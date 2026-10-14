// Proves SQLCipher encryption: file cannot be read without the right key.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';
import 'package:sqlite3/sqlite3.dart' as raw_sqlite3;

void main() {
  test('encrypted DB round-trips with correct key', () async {
    final dir = await Directory.systemTemp.createTemp('simaha-enc-ok-');
    final file = File('${dir.path}/ok.db');
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
    expect(await db.countMahasiswa(), 0);
    await db.close();

    // Reopen with same key: data persists.
    final db2 = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));
    final prodiRows = await db2.select(db2.prodi).get();
    expect(prodiRows, hasLength(1));
    expect(prodiRows.first.kode, 'IF');
    await db2.close();
    await dir.delete(recursive: true);
  });

  test('opening encrypted DB with wrong key fails', () async {
    final dir = await Directory.systemTemp.createTemp('simaha-enc-bad-');
    addTearDown(() async {
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
    });
    final file = File('${dir.path}/bad.db');
    final good = DatabaseKeyManager.generateRawHexKey();
    final bad = DatabaseKeyManager.generateRawHexKey();

    final db = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: good));
    await db
        .into(db.prodi)
        .insert(
          ProdiCompanion.insert(
            kode: 'SI',
            nama: 'Sistem Informasi',
            updatedAt: DateTime.utc(2024, 1, 1),
            deviceId: 'test',
          ),
        );
    await db.close();

    // Wrong key must throw (SQLCipher: "file is not a database").
    // try/finally: koneksi buruk tetap ditutup agar cleanup Windows sukses.
    Future<void> openWithBadKey() async {
      final dbBad = AppDatabase(
        openEncryptedExecutor(file: file, rawHexKey: bad),
      );
      try {
        await dbBad.select(dbBad.prodi).get();
      } finally {
        await dbBad.close();
      }
    }

    await expectLater(openWithBadKey(), throwsA(anything));
  });

  test('raw open without PRAGMA key cannot read tables', () async {
    final dir = await Directory.systemTemp.createTemp('simaha-enc-raw-');
    final file = File('${dir.path}/raw.db');
    final key = DatabaseKeyManager.generateRawHexKey();

    final db = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));
    await db
        .into(db.prodi)
        .insert(
          ProdiCompanion.insert(
            kode: 'BD',
            nama: 'Bisnis Digital',
            updatedAt: DateTime.utc(2024, 1, 1),
            deviceId: 'test',
          ),
        );
    await db.close();

    // Direct sqlite3 open without key: schema unreadable.
    // NOTE: must dispose the raw handle, otherwise temp-dir cleanup fails
    // on Windows (file locked by another process).
    final raw = raw_sqlite3.sqlite3.open(file.path);
    try {
      expect(
        () => raw.select('SELECT count(*) AS c FROM prodi;'),
        throwsA(anything),
      );
    } finally {
      raw.close();
    }
    await dir.delete(recursive: true);
  });

  test('generated key is 64 lowercase hex chars', () {
    final k = DatabaseKeyManager.generateRawHexKey();
    expect(k.length, 64);
    expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(k), isTrue);
  });
}
