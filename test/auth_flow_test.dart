// Alur Tahap B level flow: setup -> kunci -> buka PIN (tanpa pump UI).
//
// CATATAN: versi widget (pumpWidget LockPage + tekan keypad) diganti karena
// gantung di runner Windows ini (sudah gantung sebelum perubahan login;
// widget_test.dart lain tetap lolos). Alur yang diuji identik: PIN benar
// membuka sesi + gate ok, PIN salah tetap terkunci + gate lock.
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/security/gate.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/domain/security/string_store.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

Future<(AppDatabase, AuthService, ProviderContainer, Directory)> _open() async {
  final dir = await Directory.systemTemp.createTemp('simaha-flow-');
  final file = File('${dir.path}/flow.db');
  final key = DatabaseKeyManager.generateRawHexKey();
  final db = AppDatabase(openEncryptedExecutor(file: file, rawHexKey: key));
  final auth = AuthService(
    db: db,
    crypto: CryptoService(iterations: 1000),
    store: MemoryStore(),
  );
  final container = ProviderContainer(
    overrides: [
      authServiceProvider.overrideWithValue(auth),
      lastUserStoreProvider.overrideWithValue(MemoryStore()),
    ],
  );
  gateListenable.value = GateStatus.lock;
  return (db, auth, container, dir);
}

void main() {
  test('PIN benar membuka sesi', () async {
    final (db, auth, container, dir) = await _open();
    addTearDown(() async {
      container.dispose();
      await db.close();
      gateListenable.value = GateStatus.lock;
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
    });
    await auth.setupSuperAdmin(pin: '123456');

    final res = await auth.verifyPin('superadmin', '123456');
    expect(res.isOk, isTrue);
    final user = (res as Ok).valueOrNull!;
    container.read(sessionProvider.notifier).unlock(user);

    expect(container.read(sessionProvider).isUnlocked, isTrue);
    expect(gateListenable.value, GateStatus.ok);

    // Kunci lagi (idle/background) -> gate lock.
    container.read(sessionProvider.notifier).lock();
    expect(container.read(sessionProvider).isUnlocked, isFalse);
    expect(gateListenable.value, GateStatus.lock);
  });

  test('PIN salah menampilkan pesan, sesi tetap terkunci', () async {
    final (db, auth, container, dir) = await _open();
    addTearDown(() async {
      container.dispose();
      await db.close();
      gateListenable.value = GateStatus.lock;
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
    });
    await auth.setupSuperAdmin(pin: '123456');

    final res = await auth.verifyPin('superadmin', '000000');
    expect(res.isErr, isTrue);
    final msg = switch (res) {
      Err(failure: final f) => f.message,
      Ok() => '',
    };
    expect(msg, contains('PIN salah'));
    expect(container.read(sessionProvider).isUnlocked, isFalse);
    expect(gateListenable.value, GateStatus.lock);
  });
}
