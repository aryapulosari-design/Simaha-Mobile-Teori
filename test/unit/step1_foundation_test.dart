import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/utils/clock.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';
import 'package:simaha/domain/security/string_store.dart';
import 'package:simaha/services/audit/audit_logger.dart';
import 'package:simaha/services/seed/seed_service.dart';
import 'package:simaha/services/sync/device_id_service.dart';
import 'package:sqlite3/sqlite3.dart' as raw_sqlite3;

class InMemoryStringStore implements StringStore {
  final Map<String, String> _data = {};

  @override
  Future<String?> read(String key) async => _data[key];

  @override
  Future<void> write(String key, String value) async => _data[key] = value;

  @override
  Future<void> delete(String key) async => _data.remove(key);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late String rawKey;
  late File dbFile;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('simaha_step1_test_');
    rawKey = DatabaseKeyManager.generateRawHexKey();
    dbFile = File('${tempDir.path}/encrypted_test.db');
  });

  tearDown(() async {
    try {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    } catch (_) {}
  });

  group('Step 1: Database Encryption & Security', () {
    test('DB opens with key and stores encrypted data unreadable by raw SQLite', () async {
      final db = AppDatabase(
        openEncryptedExecutor(file: dbFile, rawHexKey: rawKey),
      );

      final now = DateTime.now();
      await db.into(db.prodi).insert(
            ProdiCompanion.insert(
              kode: 'TIF',
              nama: 'Teknik Informatika',
              updatedAt: now,
              deviceId: 'dev-1',
            ),
          );

      final prodiList = await db.select(db.prodi).get();
      expect(prodiList.length, 1);
      expect(prodiList.first.kode, 'TIF');
      await db.close();

      // Open directly without PRAGMA key: must fail or not be readable
      final raw = raw_sqlite3.sqlite3.open(dbFile.path);
      try {
        expect(
          () => raw.select('SELECT * FROM prodi;'),
          throwsA(isA<raw_sqlite3.SqliteException>()),
        );
      } finally {
        raw.close();
      }
    });

    test('Foreign key enforcement is active (PRAGMA foreign_keys = ON)', () async {
      final db = AppDatabase(
        openEncryptedExecutor(file: dbFile, rawHexKey: rawKey),
      );

      final now = DateTime.now();
      // Inserting a student with non-existent prodiId (e.g. 99999) must throw SqliteException
      expect(
        () async => await db.into(db.mahasiswa).insert(
              MahasiswaCompanion.insert(
                nim: '123456789012',
                nama: 'Budi Santoso',
                prodiId: 99999, // non-existent FK
                angkatan: 2024,
                updatedAt: now,
                deviceId: const Value('dev-1'),
              ),
            ),
        throwsA(isA<raw_sqlite3.SqliteException>()),
      );

      await db.close();
    });

    test('CRUD on SavedFilters table works properly', () async {
      final db = AppDatabase(
        openEncryptedExecutor(file: dbFile, rawHexKey: rawKey),
      );

      final now = DateTime.now();
      final id = await db.into(db.savedFilters).insert(
            SavedFiltersCompanion.insert(
              nama: 'Filter Angkatan 2024 Aktif',
              kriteriaJson: '{"angkatan": 2024, "status": "aktif"}',
              createdAt: now,
              updatedAt: now,
              deviceId: 'device-test',
            ),
          );

      expect(id, isPositive);

      final saved = await (db.select(db.savedFilters)..where((t) => t.id.equals(id))).getSingle();
      expect(saved.nama, 'Filter Angkatan 2024 Aktif');
      expect(saved.kriteriaJson, contains('2024'));

      // Update
      await (db.update(db.savedFilters)..where((t) => t.id.equals(id))).write(
        const SavedFiltersCompanion(nama: Value('Filter Update')),
      );

      final updated = await (db.select(db.savedFilters)..where((t) => t.id.equals(id))).getSingle();
      expect(updated.nama, 'Filter Update');

      // Delete
      final deletedCount = await (db.delete(db.savedFilters)..where((t) => t.id.equals(id))).go();
      expect(deletedCount, 1);

      final remaining = await db.select(db.savedFilters).get();
      expect(remaining.isEmpty, isTrue);

      await db.close();
    });
  });

  group('Step 1: Core Services & Abstractions', () {
    test('Clock abstraction returns current time and allows advancing in FakeClock', () {
      final fakeTime = DateTime(2026, 10, 14, 10, 0, 0);
      final fakeClock = FakeClock(fakeTime);

      expect(fakeClock.now(), fakeTime);

      fakeClock.advance(const Duration(minutes: 15));
      expect(fakeClock.now(), fakeTime.add(const Duration(minutes: 15)));

      const sysClock = SystemClock();
      expect(sysClock.now().isAfter(fakeTime), isTrue);
    });

    test('DeviceIdService generates persistent UUID v4 and caches it', () async {
      final store = InMemoryStringStore();
      final service = DeviceIdService(store: store);

      final id1 = await service.getDeviceId();
      expect(id1.isNotEmpty, isTrue);
      expect(service.cachedDeviceId, id1);

      // Subsequent call returns same cached ID
      final id2 = await service.getDeviceId();
      expect(id2, id1);

      // New service instance with same store reads saved ID
      final service2 = DeviceIdService(store: store);
      final id3 = await service2.getDeviceId();
      expect(id3, id1);
    });

    test('DbAuditLogger writes structured audit records to database', () async {
      final db = AppDatabase(
        openEncryptedExecutor(file: dbFile, rawHexKey: rawKey),
      );

      final fakeClock = FakeClock(DateTime(2026, 10, 14, 12, 0, 0));
      final logger = DbAuditLogger(db, clock: fakeClock);

      final userId = await db.into(db.users).insert(
            UsersCompanion.insert(
              username: 'admin_test',
              role: 'super_admin',
              pinHash: 'hash',
              salt: 'salt',
              updatedAt: fakeClock.now(),
              deviceId: 'dev-test',
            ),
          );

      await logger.log(
        aksi: 'CREATE',
        entitas: 'MAHASISWA',
        entitasId: '123456789012',
        sebelum: null,
        sesudah: '{"nim":"123456789012","nama":"Ahmad"}',
        userId: userId,
      );

      final logs = await db.select(db.auditLog).get();
      expect(logs.length, 1);
      final entry = logs.first;
      expect(entry.aksi, 'CREATE');
      expect(entry.entitas, 'MAHASISWA');
      expect(entry.entitasId, '123456789012');
      expect(entry.userId, userId);
      expect(entry.waktu, fakeClock.now());

      await db.close();
    });

    test('SeedService populates dummy data in atomic transaction', () async {
      final db = AppDatabase(
        openEncryptedExecutor(file: dbFile, rawHexKey: rawKey),
      );

      final seedService = SeedService(db);
      expect(await seedService.canSeed(), isTrue);

      final stats = await seedService.runSeed(count: 10, seed: 101);
      expect(stats.mahasiswa, 10);
      expect(stats.krs, isPositive);
      expect(stats.nilai, isPositive);
      expect(stats.kelas, isPositive);

      final mhsCount = await db.countMahasiswa();
      expect(mhsCount, 10);

      await db.close();
    });
  });
}
