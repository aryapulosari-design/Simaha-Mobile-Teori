// Encrypted connection helpers for Drift + SQLCipher (via package:sqlite3
// with hooks `source: sqlcipher`, see pubspec.yaml).
//
// SQLCipher setup native tambahan (ringkas):
// 1. pubspec.yaml mengaktifkan build SQLCipher:
//      hooks:
//        user_defines:
//          sqlite3:
//            source: sqlcipher
//    sehingga `flutter pub get` mengunduh native lib SQLCipher, bukan sqlite
//    bawaan. Tidak perlu gradle/cmake manual.
// 2. Database dibuka dengan NativeDatabase + `setup` yang menjalankan
//      PRAGMA key = "x'<64-hex>'";
//    sebelum query apa pun. Tanpa PRAGMA yang benar file terbaca sebagai
//    "file is not a database" (dibuktikan di test/encryption_test.dart).
// 3. Kunci 256-bit dibuat acak via DatabaseKeyManager dan disimpan di
//    flutter_secure_storage (Android Keystore), bukan di kode/SharedPrefs.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';

/// Builds a SQLCipher-encrypted executor for [file] using raw hex key.
///
/// The key must be 64 lowercase hex chars (32 bytes). We use the
/// `x'hex'` raw-key format so the key material is exactly 256 bit.
QueryExecutor openEncryptedExecutor({
  required File file,
  required String rawHexKey,
  bool logStatements = false,
}) {
  assert(
    RegExp(r'^[0-9a-f]{64}$').hasMatch(rawHexKey),
    'rawHexKey must be 64 lowercase hex chars',
  );
  return NativeDatabase(
    file,
    logStatements: logStatements,
    setup: (db) {
      // Must run before any table access.
      db.execute('PRAGMA key = "x\'$rawHexKey\'";');
      // Fail fast if key is wrong: this throws "file is not a database".
      db.execute('SELECT count(*) FROM sqlite_master;');
    },
  );
}

/// Resolves default DB file: `<app-documents>/simaha.db`
Future<File> defaultDatabaseFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File(p.join(dir.path, kDatabaseFileName));
}

/// Opens executor with key from secure storage (production path).
Future<QueryExecutor> openProductionExecutor({
  DatabaseKeyManager? keyManager,
  File? overrideFile,
  bool logStatements = false,
}) async {
  final km = keyManager ?? DatabaseKeyManager();
  final key = await km.getOrCreateDbKey();
  final file = overrideFile ?? await defaultDatabaseFile();
  return openEncryptedExecutor(
    file: file,
    rawHexKey: key,
    logStatements: logStatements,
  );
}
