import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/core/security/gate.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/domain/security/string_store.dart';

/// Session state: which user (if any) is unlocked on this device.
class SessionData {
  const SessionData({this.user});
  final UserRow? user;

  bool get isUnlocked => user != null;
  Role? get role => user == null ? null : Role.fromStorage(user!.role);
}

final authServiceProvider = Provider<AuthService>((ref) {
  throw UnimplementedError('authServiceProvider not initialized');
});

class SessionNotifier extends Notifier<SessionData> {
  @override
  SessionData build() => const SessionData();

  void unlock(UserRow user) {
    state = SessionData(user: user);
    gateListenable.value = GateStatus.ok;
  }

  void lock() {
    state = const SessionData();
    gateListenable.value = GateStatus.lock;
  }

  Future<void> refreshUser() async {
    final id = state.user?.id;
    if (id == null) return;
    final fresh = await ref.read(authServiceProvider).findUser(id);
    if (fresh == null || !fresh.isActive) {
      lock();
    } else {
      state = SessionData(user: fresh);
    }
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, SessionData>(
  SessionNotifier.new,
);

/// Last-login username for the lock screen (device-local convenience).
Future<String?> readLastUsername(Ref ref) =>
    ref.read(lastUserStoreProvider).read('simaha_last_user');

final lastUserStoreProvider = Provider<StringStore>((ref) {
  throw UnimplementedError('lastUserStoreProvider not initialized');
});

/// Pure-Dart default: real store overridden in main.dart.
final cryptoProvider = Provider<CryptoService>((ref) => CryptoService());
