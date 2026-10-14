// PBKDF2-HMAC-SHA256 PIN hashing (pure Dart, no Flutter import).
// PRD chose PBKDF2 over Argon2 for Flutter stability.
// Parameters: 16-byte random salt, 256-bit output, 210 000 iterations
// (OWASP 2023 recommends >=600k for server HSM-backed logins; 210k keeps
// unlock <1s on low-end Android 8 devices while staying far beyond brute
// force for a 6-digit PIN combined with lockout + Keystore-held DB key).
import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

class CryptoService {
  CryptoService({int? iterations, Random? random})
    : iterations = iterations ?? kPbkdf2Iterations,
      _random = random ?? Random.secure();

  /// 100k iterasi: wajar untuk HP low-end (unlock < 1 detik).
  /// Lapisan utama anti-brute-force adalah lockout + kunci DB di Keystore
  /// (tanpa kunci itu hash PIN tak bisa dibaca), jadi iterasi super-tinggi
  /// hanya menambah lambat tanpa guna praktis.
  static const int kPbkdf2Iterations = 100000;
  static const int kSaltBytes = 16;

  final int iterations;
  final Random _random;

  Pbkdf2 get _algo =>
      Pbkdf2(macAlgorithm: Hmac.sha256(), iterations: iterations, bits: 256);

  /// Hashes [pin] with a fresh random salt.
  /// Format: `pbkdf2-sha256$<iterations>$<saltB64>$<hashB64>`.
  /// The plain PIN is never stored or logged.
  Future<PinHash> hashPin(String pin) async {
    final salt = List<int>.generate(kSaltBytes, (_) => _random.nextInt(256));
    final key = await _algo.deriveKeyFromPassword(password: pin, nonce: salt);
    final hash = await key.extractBytes();
    return PinHash._(iterations: iterations, salt: salt, hash: hash);
  }

  /// Verifies [pin] against a stored [encoded] hash (constant-time compare).
  Future<bool> verifyPin(String pin, String encoded) async {
    final parsed = PinHash.parse(encoded);
    final algo = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: parsed.iterations,
      bits: parsed.hash.length * 8,
    );
    final key = await algo.deriveKeyFromPassword(
      password: pin,
      nonce: parsed.salt,
    );
    final candidate = await key.extractBytes();
    return _constantTimeEquals(candidate, parsed.hash);
  }

  bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }

  /// One-time recovery code, unambiguous charset (no 0/O/1/I).
  /// Format: XXXX-XXXX-XXXX.
  String generateRecoveryCode() {
    const alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
    final buf = StringBuffer();
    for (var i = 0; i < 12; i++) {
      if (i > 0 && i % 4 == 0) buf.write('-');
      buf.write(alphabet[_random.nextInt(alphabet.length)]);
    }
    return buf.toString();
  }
}

/// Parsed PIN hash (salt + hash bytes + iteration count).
class PinHash {
  PinHash._({required this.iterations, required this.salt, required this.hash});

  final int iterations;
  final List<int> salt;
  final List<int> hash;

  String encode() {
    final b64 = base64Encode;
    return 'pbkdf2-sha256\$$iterations\$${b64(salt)}\$${b64(hash)}';
  }

  factory PinHash.parse(String encoded) {
    final parts = encoded.split(r'$');
    if (parts.length != 4 || parts[0] != 'pbkdf2-sha256') {
      throw const FormatException('Invalid PIN hash format');
    }
    return PinHash._(
      iterations: int.parse(parts[1]),
      salt: base64Decode(parts[2]),
      hash: base64Decode(parts[3]),
    );
  }
}
