import 'package:flutter/foundation.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/seed/seed_data.dart';

/// Service to handle parameterized database seeding.
/// Runs heavy generation in background Isolate and wraps writes in atomic transaction.
class SeedService {
  SeedService(this._db);

  final AppDatabase _db;

  /// Seeds only when DB is completely empty. Safe to call on app startup.
  Future<SeedStats?> ensureInitialData() async {
    return ensureSeeded(_db);
  }

  /// Full seed with customizable student count and RNG seed.
  /// Generates realistic prodi, dosen, mata kuliah, kelas, krs, nilai, and presensi.
  Future<SeedStats> runSeed({int count = 100, int seed = 42}) async {
    return seedDatabase(_db, mahasiswaCount: count, seed: seed);
  }

  /// Checks if seeding is allowed (only in debug/test or when DB is empty).
  Future<bool> canSeed() async {
    if (kDebugMode) return true;
    final count = await _db.countMahasiswa();
    return count == 0;
  }
}
