// Backup terenkripsi .simaha (FR-29/30, pure Dart + cryptography).
// Format JSON: {v:1, iter, salt, nonce, cipher, sha256}.
// Kunci AES-256 dari password via PBKDF2-HMAC-SHA256.
// Restore: password salah / file dimodifikasi -> throw.
import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

class BackupService {
  BackupService({int? iterations, Random? random})
    : iterations = iterations ?? 50000,
      _random = random ?? Random.secure();

  final int iterations;
  final Random _random;

  Future<List<int>> _keyFromPassword(String password, List<int> salt) async {
    final algo = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: 256,
    );
    final key = await algo.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );
    return key.extractBytes();
  }

  List<int> _salt() => List<int>.generate(16, (_) => _random.nextInt(256));

  List<int> _nonce() => List<int>.generate(12, (_) => _random.nextInt(256));

  /// Enkripsi [plain] dengan [password]. Kembalikan bytes JSON (.simaha).
  Future<List<int>> encryptBackup(List<int> plain, String password) async {
    if (password.length < 6) {
      throw ArgumentError('Password backup minimal 6 karakter.');
    }
    final salt = _salt();
    final nonce = _nonce();
    final keyBytes = await _keyFromPassword(password, salt);
    final cipher = await AesGcm.with256bits().encrypt(
      plain,
      secretKey: SecretKey(keyBytes),
      nonce: nonce,
    );
    final payload = <String, Object?>{
      'v': 1,
      'iter': iterations,
      'salt': base64Encode(salt),
      'nonce': base64Encode(nonce),
      'cipher': base64Encode(cipher.cipherText),
      'mac': base64Encode(cipher.mac.bytes),
      'sha256': base64Encode((await Sha256().hash(plain)).bytes),
    };
    return utf8.encode(jsonEncode(payload));
  }

  /// Dekripsi bytes .simaha dengan [password]. Throw jika salah/rusak.
  Future<List<int>> decryptBackup(List<int> fileBytes, String password) async {
    late final Map<String, dynamic> payload;
    try {
      payload = jsonDecode(utf8.decode(fileBytes)) as Map<String, dynamic>;
    } catch (_) {
      throw const FormatException('Bukan berkas .simaha yang valid.');
    }
    if (payload['v'] != 1) {
      throw const FormatException('Versi backup tidak didukung.');
    }
    final iter = payload['iter'] as int;
    final salt = base64Decode(payload['salt'] as String);
    final nonce = base64Decode(payload['nonce'] as String);
    final cipherBytes = base64Decode(payload['cipher'] as String);
    final macBytes = base64Decode(payload['mac'] as String);
    final algo = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iter,
      bits: 256,
    );
    final key = await algo.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );
    late final List<int> plain;
    try {
      plain = await AesGcm.with256bits().decrypt(
        SecretBox(cipherBytes, nonce: nonce, mac: Mac(macBytes)),
        secretKey: key,
      );
    } catch (_) {
      throw StateError('Password salah atau berkas rusak.');
    }
    final expectSha = payload['sha256'] as String;
    final actualSha = base64Encode((await Sha256().hash(plain)).bytes);
    if (expectSha != actualSha) {
      throw StateError('Checksum tidak cocok: berkas dimodifikasi.');
    }
    return plain;
  }
}
