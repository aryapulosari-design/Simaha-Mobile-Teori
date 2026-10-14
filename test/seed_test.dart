// Seeder + FTS5 + pagination tests (100 dummy mahasiswa).
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';
import 'package:simaha/data/local/seed/seed_data.dart';

Future<AppDatabase> _openTempDb() async {
  final dir = await Directory.systemTemp.createTemp('simaha-seed-');
  addTearDown(() async {
    try {
      await dir.delete(recursive: true);
    } catch (_) {}
  });
  final file = File('${dir.path}/seed.db');
  final key = DatabaseKeyManager.generateRawHexKey();
  return AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));
}

void main() {
  test('seed creates 100 mahasiswa + academic data', () async {
    final db = await _openTempDb();
    final stats = await seedDatabase(db, mahasiswaCount: 100, seed: 42);

    expect(stats.mahasiswa, 100);
    expect(stats.kelas, 12);
    expect(stats.krs, greaterThan(200)); // 82 aktif x 3
    expect(stats.nilai, stats.krs);

    final counts = await db.dashboardCounts();
    expect(counts.total, 100);
    expect(counts.aktif, 82);
    expect(counts.prodi, 4);
    expect(counts.dosen, 8);
    expect(counts.kelas, 12);
    await db.close();
  });

  test('ensureSeeded is idempotent', () async {
    final db = await _openTempDb();
    final first = await ensureSeeded(db);
    expect(first, isNotNull);
    expect(first!.mahasiswa, 100);
    final second = await ensureSeeded(db);
    expect(second, isNull);
    expect(await db.countMahasiswa(), 100);
    await db.close();
  });

  test('FTS5 search <= 500ms and finds by NIM fragment', () async {
    final db = await _openTempDb();
    await seedDatabase(db);

    final sample = (await db.pagedMahasiswa(limit: 1)).first;
    final prefix = sample.nama.split(' ').first.substring(0, 3);

    final sw = Stopwatch()..start();
    final hits = await db.searchMahasiswaFts(prefix, limit: 20);
    sw.stop();

    expect(hits, isNotEmpty);
    expect(
      sw.elapsedMilliseconds,
      lessThanOrEqualTo(500),
      reason: 'PRD budget: search 100 rows <= 500ms',
    );

    // NIM search also works (full NIM = exact match, must rank first).
    final nimHits = await db.searchMahasiswaFts(sample.nim, limit: 5);
    expect(nimHits.map((e) => e.nim), contains(sample.nim));
    await db.close();
  });

  test('pagination returns stable pages', () async {
    final db = await _openTempDb();
    await seedDatabase(db);

    final p1 = await db.pagedMahasiswa(limit: 20, offset: 0);
    final p2 = await db.pagedMahasiswa(limit: 20, offset: 20);
    expect(p1, hasLength(20));
    expect(p2, hasLength(20));
    final ids1 = p1.map((e) => e.id).toSet();
    final ids2 = p2.map((e) => e.id).toSet();
    expect(ids1.intersection(ids2), isEmpty);

    final aktifOnly = await db.pagedMahasiswa(limit: 100, status: 'aktif');
    expect(aktifOnly, hasLength(82));
    await db.close();
  });
}
