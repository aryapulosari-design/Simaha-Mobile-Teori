// Manages the SQLCipher raw key in Android Keystore / iOS Keychain
// via flutter_secure_storage. The key is a 256-bit random value stored
// as 64 lowercase hex chars. It is never hardcoded and never logged.
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class DatabaseKeyManager {
  DatabaseKeyManager({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Returns existing hex key or creates a new 256-bit one.
  Future<String> getOrCreateDbKey() async {
    final existing = await _storage.read(key: kDbKeyStorageKey);
    if (existing != null && _isValidHexKey(existing)) {
      return existing;
    }
    final fresh = generateRawHexKey();
    await _storage.write(key: kDbKeyStorageKey, value: fresh);
    return fresh;
  }

  /// Reads the key without creating (null if first run).
  Future<String?> readDbKey() => _storage.read(key: kDbKeyStorageKey);

  Future<String> getOrCreateDeviceId() async {
    final existing = await _storage.read(key: kDeviceIdStorageKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final fresh = const Uuid().v4();
    await _storage.write(key: kDeviceIdStorageKey, value: fresh);
    return fresh;
  }

  /// Generates 32 random bytes as 64 hex chars (SQLCipher raw-key format).
  static String generateRawHexKey([Random? random]) {
    final rnd = random ?? Random.secure();
    final bytes = List<int>.generate(32, (_) => rnd.nextInt(256));
    final buf = StringBuffer();
    for (final b in bytes) {
      buf.write(b.toRadixString(16).padLeft(2, '0'));
    }
    return buf.toString();
  }

  static bool _isValidHexKey(String v) {
    if (v.length != 64) return false;
    return RegExp(r'^[0-9a-f]{64}$').hasMatch(v);
  }
}
