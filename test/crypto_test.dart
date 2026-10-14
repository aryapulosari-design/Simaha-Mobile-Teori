// CryptoService: PBKDF2 format, verify, salt uniqueness (pure Dart).
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/data/services/crypto_service.dart';

void main() {
  test('hash then verify succeeds; wrong PIN fails', () async {
    final crypto = CryptoService(iterations: 5000);
    final encoded = (await crypto.hashPin('123456')).encode();
    expect(encoded.startsWith('pbkdf2-sha256\$5000\$'), isTrue);
    expect(await crypto.verifyPin('123456', encoded), isTrue);
    expect(await crypto.verifyPin('654321', encoded), isFalse);
  });

  test('salts are random: same PIN gives different hashes', () async {
    final crypto = CryptoService(iterations: 5000);
    final a = (await crypto.hashPin('123456')).encode();
    final b = (await crypto.hashPin('123456')).encode();
    expect(a, isNot(equals(b)));
    expect(await crypto.verifyPin('123456', a), isTrue);
    expect(await crypto.verifyPin('123456', b), isTrue);
  });

  test('malformed hash throws FormatException', () {
    expect(() => PinHash.parse('not-a-hash'), throwsA(isA<FormatException>()));
    expect(() => PinHash.parse('pbkdf2-sha256\$x\$y'), throwsA(anything));
  });

  test('recovery code format XXXX-XXXX-XXXX, unambiguous chars', () {
    final crypto = CryptoService();
    final seen = <String>{};
    for (var i = 0; i < 20; i++) {
      final code = crypto.generateRecoveryCode();
      expect(code.length, 14);
      expect(
        RegExp(r'^[A-Z2-9]{4}-[A-Z2-9]{4}-[A-Z2-9]{4}$').hasMatch(code),
        isTrue,
      );
      expect(code.contains('0'), isFalse);
      expect(code.contains('O'), isFalse);
      expect(code.contains('1'), isFalse);
      expect(code.contains('I'), isFalse);
      seen.add(code);
    }
    expect(seen.length, greaterThan(15)); // random, no mass collision
  });
}
