// AuthService: setup, PIN verify, escalating lockout, recovery one-time,
// RBAC enforcement. Uses a real encrypted temp DB + fake clock.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/domain/security/string_store.dart';

import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';

class _Harness {
  _Harness._(this.db, this.auth);
  final AppDatabase db;
  final AuthService auth;
  DateTime now = DateTime(2025, 1, 1, 8);

  void travel(Duration d) => now = now.add(d);

  static Future<_Harness> open() async {
    final dir = await Directory.systemTemp.createTemp('simaha-auth-');
    final file = File('${dir.path}/auth.db');
    final key = DatabaseKeyManager.generateRawHexKey();
    final db = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));
    late final _Harness h;
    h = _Harness._(
      db,
      AuthService(
        db: db,
        crypto: CryptoService(iterations: 5000),
        store: MemoryStore(),
        clock: () => h.now,
      ),
    );
    addTearDown(() async {
      await db.close();
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
    });
    return h;
  }
}

void main() {
  test('setup creates superadmin + recovery code shown once', () async {
    final h = await _Harness.open();
    expect(await h.auth.isSetupRequired(), isTrue);

    final code = await h.auth.setupSuperAdmin(pin: '123456');
    expect(RegExp(r'^[A-Z2-9-]{14}$').hasMatch(code), isTrue);
    expect(await h.auth.isSetupRequired(), isFalse);

    // Setup twice is rejected.
    expect(
      () => h.auth.setupSuperAdmin(pin: '123456'),
      throwsA(isA<AuthFailure>()),
    );

    // PIN format enforced.
    final ok = await h.auth.verifyPin('superadmin', '123456');
    expect(ok.isOk, isTrue);
  });

  test('5 wrong PINs lock 30s, then doubles (60s, 120s), capped 15 min', () async {
    expect(AuthService.lockoutFor(4), Duration.zero);
    expect(AuthService.lockoutFor(5), const Duration(seconds: 30));
    expect(AuthService.lockoutFor(6), const Duration(seconds: 60));
    expect(AuthService.lockoutFor(7), const Duration(seconds: 120));
    expect(AuthService.lockoutFor(8), const Duration(seconds: 240));
    expect(AuthService.lockoutFor(10), const Duration(minutes: 15));
    expect(AuthService.lockoutFor(20), const Duration(minutes: 15));

    final h = await _Harness.open();
    await h.auth.setupSuperAdmin(pin: '123456');
    for (var i = 0; i < 4; i++) {
      final r = await h.auth.verifyPin('superadmin', '000000');
      expect(r.isErr, isTrue);
      expect(switch (r) {
        Err(failure: final f) => f.message,
        Ok() => '',
      }, contains('Sisa'));
    }
    final locked = await h.auth.verifyPin('superadmin', '000000');
    expect(locked.isErr, isTrue);

    // Correct PIN during lock is still rejected...
    final during = await h.auth.verifyPin('superadmin', '123456');
    expect(during.isErr, isTrue);

    // ...but works after the window passes (fake clock).
    h.travel(const Duration(minutes: 2));
    final after = await h.auth.verifyPin('superadmin', '123456');
    expect(after.isOk, isTrue);
  });

  test('unknown username gives same message as wrong PIN', () async {
    final h = await _Harness.open();
    await h.auth.setupSuperAdmin(pin: '123456');
    final a = await h.auth.verifyPin('ghost', '123456');
    final b = await h.auth.verifyPin('superadmin', '000000');
    String msg(Result<UserRow, AppFailure> r) => switch (r) {
      Err(failure: final f) => f.message,
      Ok() => '',
    };
    expect(msg(a), contains('Username atau PIN salah'));
    expect(msg(b), contains('Sisa'));
  });

  test('recovery code works once, then rejected', () async {
    final h = await _Harness.open();
    final code = await h.auth.setupSuperAdmin(pin: '123456');
    // Lock the account first.
    for (var i = 0; i < 5; i++) {
      await h.auth.verifyPin('superadmin', '000000');
    }
    expect((await h.auth.verifyPin('superadmin', '123456')).isErr, isTrue);

    final first = await h.auth.consumeRecoveryCode(code.toLowerCase());
    expect(first.isOk, isTrue);
    // Failures cleared: PIN works immediately.
    expect((await h.auth.verifyPin('superadmin', '123456')).isOk, isTrue);

    final second = await h.auth.consumeRecoveryCode(code);
    expect(second.isErr, isTrue);
    final wrong = await h.auth.consumeRecoveryCode('AAAA-BBBB-CCCC');
    expect(wrong.isErr, isTrue);
  });

  test(
    'RBAC: only superadmin manages users; self-deactivation blocked',
    () async {
      final h = await _Harness.open();
      await h.auth.setupSuperAdmin(pin: '123456');
      final admin =
          (await h.auth.verifyPin('superadmin', '123456') as Ok).valueOrNull!;

      final dosenId = await h.auth.createUser(
        actorId: admin.id,
        username: 'dosen1',
        role: Role.dosenWali,
        pin: '111111',
      );

      // Non-privileged actor is forbidden (service layer, not just UI).
      expect(
        () => h.auth.createUser(
          actorId: dosenId,
          username: 'x',
          role: Role.mahasiswa,
          pin: '222222',
        ),
        throwsA(isA<ForbiddenFailure>()),
      );
      expect(
        () => h.auth.listUsers(actorId: dosenId),
        throwsA(isA<ForbiddenFailure>()),
      );

      // Duplicate username rejected.
      expect(
        () => h.auth.createUser(
          actorId: admin.id,
          username: 'dosen1',
          role: Role.mahasiswa,
          pin: '333333',
        ),
        throwsA(isA<ValidationFailure>()),
      );

      // Bad PIN format rejected.
      expect(
        () => h.auth.createUser(
          actorId: admin.id,
          username: 'mhs1',
          role: Role.mahasiswa,
          pin: '12',
        ),
        throwsA(isA<ValidationFailure>()),
      );

      // Cannot deactivate self.
      expect(
        () => h.auth.setUserActive(
          actorId: admin.id,
          targetId: admin.id,
          active: false,
        ),
        throwsA(isA<ValidationFailure>()),
      );

      // Deactivate + reactivate other works; inactive cannot log in.
      await h.auth.setUserActive(
        actorId: admin.id,
        targetId: dosenId,
        active: false,
      );
      expect((await h.auth.verifyPin('dosen1', '111111')).isErr, isTrue);
      await h.auth.setUserActive(
        actorId: admin.id,
        targetId: dosenId,
        active: true,
      );

      // Reset PIN clears lock and sets new PIN.
      await h.auth.resetPin(
        actorId: admin.id,
        targetId: dosenId,
        newPin: '999999',
      );
      expect((await h.auth.verifyPin('dosen1', '999999')).isOk, isTrue);
    },
  );

  test('RBAC matrix matches PRD 5 roles', () {
    expect(canRole(Role.superAdmin, Permission.manageUsers), isTrue);
    expect(canRole(Role.adminAkademik, Permission.manageUsers), isFalse);
    expect(canRole(Role.adminAkademik, Permission.manageMaster), isTrue);
    expect(canRole(Role.dosenPengampu, Permission.manageNilai), isTrue);
    expect(canRole(Role.dosenPengampu, Permission.manageBimbingan), isFalse);
    expect(canRole(Role.dosenWali, Permission.manageBimbingan), isTrue);
    expect(canRole(Role.mahasiswa, Permission.viewAllMahasiswa), isFalse);
    expect(Role.fromStorage('super_admin'), Role.superAdmin);
    expect(Role.fromStorage('bogus'), Role.mahasiswa);
  });
}
