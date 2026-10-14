// Migration v1 -> v3: sync columns (v2) + spec section-4 tables (v3).
// Existing rows must survive; new tables must exist with defaults.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';
import 'package:sqlite3/sqlite3.dart' as raw_sqlite3;

// Minimal v1 DDL (no updated_at/device_id except mahasiswa, which had them
// since v1). Types mirror drift storage: INTEGER for int/bool/datetime.
const List<String> _v1Tables = [
  'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL UNIQUE, role TEXT NOT NULL, pin_hash TEXT NOT NULL, salt TEXT NOT NULL, biometric_enabled INTEGER NOT NULL DEFAULT 0, is_active INTEGER NOT NULL DEFAULT 1, failed_attempts INTEGER NOT NULL DEFAULT 0, locked_until INTEGER);',
  'CREATE TABLE prodi (id INTEGER PRIMARY KEY AUTOINCREMENT, kode TEXT NOT NULL UNIQUE, nama TEXT NOT NULL);',
  'CREATE TABLE dosens (id INTEGER PRIMARY KEY AUTOINCREMENT, nidn TEXT NOT NULL UNIQUE, nama TEXT NOT NULL, user_id INTEGER, prodi_id INTEGER NOT NULL);',
  'CREATE TABLE mahasiswa (id INTEGER PRIMARY KEY AUTOINCREMENT, nim TEXT NOT NULL UNIQUE, nama TEXT NOT NULL, prodi_id INTEGER NOT NULL, angkatan INTEGER NOT NULL, status TEXT NOT NULL DEFAULT (\'aktif\'), email TEXT NOT NULL DEFAULT \'\', no_hp TEXT NOT NULL DEFAULT \'\', foto_path TEXT, dosen_wali_id INTEGER, user_id INTEGER, is_deleted INTEGER NOT NULL DEFAULT 0, updated_at INTEGER NOT NULL, device_id TEXT NOT NULL DEFAULT \'seed\');',
  'CREATE TABLE tahun_ajaran (id INTEGER PRIMARY KEY AUTOINCREMENT, tahun TEXT NOT NULL, semester INTEGER NOT NULL, is_active INTEGER NOT NULL DEFAULT 0);',
  'CREATE TABLE mata_kuliah (id INTEGER PRIMARY KEY AUTOINCREMENT, kode TEXT NOT NULL UNIQUE, nama TEXT NOT NULL, sks INTEGER NOT NULL, semester INTEGER NOT NULL, prodi_id INTEGER NOT NULL);',
  'CREATE TABLE prasyarat_mk (mk_id INTEGER NOT NULL, prasyarat_mk_id INTEGER NOT NULL, PRIMARY KEY (mk_id, prasyarat_mk_id));',
  'CREATE TABLE kelas (id INTEGER PRIMARY KEY AUTOINCREMENT, mk_id INTEGER NOT NULL, dosen_id INTEGER NOT NULL, ta_id INTEGER NOT NULL, hari TEXT NOT NULL, jam_mulai TEXT NOT NULL, jam_selesai TEXT NOT NULL, ruang TEXT NOT NULL DEFAULT \'\');',
  'CREATE TABLE krs (id INTEGER PRIMARY KEY AUTOINCREMENT, mahasiswa_id INTEGER NOT NULL, kelas_id INTEGER NOT NULL, ta_id INTEGER NOT NULL, status TEXT NOT NULL DEFAULT (\'diambil\'));',
  'CREATE TABLE nilai (id INTEGER PRIMARY KEY AUTOINCREMENT, krs_id INTEGER NOT NULL UNIQUE, tugas REAL NOT NULL DEFAULT 0.0, uts REAL NOT NULL DEFAULT 0.0, uas REAL NOT NULL DEFAULT 0.0, nilai_akhir REAL NOT NULL DEFAULT 0.0, huruf TEXT NOT NULL DEFAULT \'E\', bobot REAL NOT NULL DEFAULT 0.0);',
  'CREATE TABLE sesi_presensi (id INTEGER PRIMARY KEY AUTOINCREMENT, kelas_id INTEGER NOT NULL, pertemuan_ke INTEGER NOT NULL, tanggal INTEGER NOT NULL, qr_secret TEXT NOT NULL, dibuka_sampai INTEGER);',
  'CREATE TABLE presensi (id INTEGER PRIMARY KEY AUTOINCREMENT, sesi_id INTEGER NOT NULL, mahasiswa_id INTEGER NOT NULL, status TEXT NOT NULL, metode TEXT NOT NULL DEFAULT \'manual\', waktu INTEGER NOT NULL, UNIQUE (sesi_id, mahasiswa_id));',
  'CREATE TABLE catatan_bimbingan (id INTEGER PRIMARY KEY AUTOINCREMENT, mahasiswa_id INTEGER NOT NULL, dosen_id INTEGER NOT NULL, isi TEXT NOT NULL, tindak_lanjut TEXT, tanggal INTEGER NOT NULL);',
  'CREATE TABLE peringatan (id INTEGER PRIMARY KEY AUTOINCREMENT, mahasiswa_id INTEGER NOT NULL, jenis TEXT NOT NULL, skor REAL NOT NULL, detail TEXT NOT NULL DEFAULT \'\', dibuat_pada INTEGER NOT NULL, ditangani INTEGER NOT NULL DEFAULT 0);',
];

Future<File> _buildV1Database(String key) async {
  final dir = await Directory.systemTemp.createTemp('simaha-mig-');
  final file = File('${dir.path}/v1.db');
  final raw = raw_sqlite3.sqlite3.open(file.path);
  try {
    raw.execute('PRAGMA key = "x\'$key\'";');
    for (final ddl in _v1Tables) {
      raw.execute(ddl);
    }
    raw.execute("INSERT INTO prodi (kode, nama) VALUES ('IF', 'Informatika');");
    raw.execute(
      "INSERT INTO users (username, role, pin_hash, salt) VALUES "
      "('superadmin', 'super_admin', 'h', 's');",
    );
    raw.execute(
      "INSERT INTO mahasiswa (nim, nama, prodi_id, angkatan, updated_at) "
      "VALUES ('2022010001', 'Uji Migrasi', 1, 2022, 1700000000);",
    );
    raw.execute('PRAGMA user_version = 1;');
  } finally {
    raw.close();
  }
  addTearDown(() async {
    try {
      await dir.delete(recursive: true);
    } catch (_) {}
  });
  return file;
}

void main() {
  test('upgrade v1 -> v3 preserves rows and adds sync columns', () async {
    final key = DatabaseKeyManager.generateRawHexKey();
    final file = await _buildV1Database(key);

    final db = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));

    // Existing rows survive the upgrade.
    final mhs = await db.select(db.mahasiswa).get();
    expect(mhs, hasLength(1));
    expect(mhs.first.nim, '2022010001');
    expect(mhs.first.deviceId, 'seed'); // untouched by backfill
    final users = await db.select(db.users).get();
    expect(users, hasLength(1));
    expect(users.first.deviceId, ''); // v2 default
    expect(users.first.updatedAt, isA<DateTime>()); // backfilled, readable

    // Every synced table now exposes both columns.
    for (final t in AppDatabase.syncedTables) {
      final cols = await db
          .customSelect(
            'SELECT name FROM pragma_table_info(?)',
            variables: [Variable.withString(t)],
          )
          .map((r) => r.read<String>('name'))
          .get();
      expect(cols, contains('updated_at'), reason: t);
      expect(cols, contains('device_id'), reason: t);
    }

    // Schema version bumped.
    final version = await db
        .customSelect('PRAGMA user_version')
        .map((r) => r.read<int>('user_version'))
        .getSingle();
    expect(version, 4);

    // v3 & v4 tables exist and carry sync columns + default pengaturan.
    for (final t in [
      'pengaturan',
      'pengumuman',
      'agenda_akademik',
      'jadwal_ujian',
      'prestasi',
      'edom_periode',
      'edom_pertanyaan',
      'edom_partisipasi',
      'edom_jawaban',
      'dokumen_arsip',
      'saved_filters',
    ]) {
      final cols = await db
          .customSelect(
            'SELECT name FROM pragma_table_info(?)',
            variables: [Variable.withString(t)],
          )
          .map((r) => r.read<String>('name'))
          .get();
      expect(cols, contains('updated_at'), reason: t);
      expect(cols, contains('device_id'), reason: t);
    }
    expect(await db.getSyaratSksLulus(), 144);

    // FTS triggers recreated by the upgrade: migrated row is searchable.
    final hits = await db.searchMahasiswaFts('2022010001', limit: 5);
    expect(hits.map((e) => e.nim), contains('2022010001'));

    await db.close();
  });

  test('fresh v3 database exposes sync columns with defaults', () async {
    final dir = await Directory.systemTemp.createTemp('simaha-v2fresh-');
    addTearDown(() async {
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
    });
    final file = File('${dir.path}/fresh.db');
    final key = DatabaseKeyManager.generateRawHexKey();
    final db = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));

    await db
        .into(db.prodi)
        .insert(
          ProdiCompanion.insert(
            kode: 'IF',
            nama: 'Informatika',
            updatedAt: DateTime.utc(2024, 1, 1),
            deviceId: 'test',
          ),
        );
    final row = await db.select(db.prodi).getSingle();
    // Drift reads DateTime in local zone; compare instants, not zones.
    expect(
      row.updatedAt.millisecondsSinceEpoch,
      DateTime.utc(2024, 1, 1).millisecondsSinceEpoch,
    );
    expect(row.deviceId, 'test');

    await db.close();
  });

  test('FTS operator query falls back to LIKE instead of throwing', () async {
    final dir = await Directory.systemTemp.createTemp('simaha-ftsfall-');
    addTearDown(() async {
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
    });
    final file = File('${dir.path}/fts.db');
    final key = DatabaseKeyManager.generateRawHexKey();
    final db = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));
    await db
        .into(db.prodi)
        .insert(
          ProdiCompanion.insert(
            kode: 'IF',
            nama: 'Informatika',
            updatedAt: DateTime.utc(2024, 1, 1),
            deviceId: 'test',
          ),
        );

    // '*' alone is not a valid FTS5 MATCH expression: must not throw.
    final hits = await db.searchMahasiswaFts('*', limit: 20);
    expect(hits, isA<List<MahasiswaRow>>());

    await db.close();
  });
}
