// AuthService: setup, PIN login, escalating lockout, biometric flag,
// one-time recovery code, and RBAC-guarded account management.
// Security rules (PRD section 6):
// - PIN only ever exists as PBKDF2+salt (see CryptoService), never logged.
// - Temporary lock after 5 wrong PINs, duration doubles, capped at 15 min.
// - RBAC enforced here via [Permission]; UI must not be the only gate.
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/domain/security/login_account.dart';
import 'package:simaha/domain/security/string_store.dart';
import 'package:simaha/services/audit/audit_logger.dart';

class AuthService {
  AuthService({
    required this._db,
    required this._crypto,
    required this._store,
    AuditLogger? auditLogger,
    DateTime Function()? clock,
  }) : _logger = auditLogger ?? const NoopAuditLogger(),
       _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final CryptoService _crypto;
  final StringStore _store;
  final AuditLogger _logger;
  final DateTime Function() _now;

  static const String _recoveryHashKey = 'simaha_recovery_hash';
  static const String _recoveryUsedKey = 'simaha_recovery_used';

  /// Local login chooser; selecting a role never authenticates the account.
  /// Only display information is exposed before the PIN has been verified.
  Future<List<LoginAccount>> listLoginAccounts() async {
    final rows = await _db
        .customSelect(
          'SELECT u.id, u.username, u.role, COALESCE('
          '(SELECT m.nama FROM mahasiswa m WHERE m.user_id = u.id '
          'AND m.is_deleted = 0 ORDER BY m.id LIMIT 1), '
          '(SELECT d.nama FROM dosens d WHERE (d.user_id = u.id OR d.wali_user_id = u.id) ORDER BY d.id LIMIT 1), '
          'u.username) AS display_name FROM users u '
          'WHERE u.is_active = 1 ORDER BY u.username, u.id',
          readsFrom: {_db.users, _db.mahasiswa, _db.dosens},
        )
        .get();
    return rows
        .map(
          (row) => LoginAccount(
            id: row.read<int>('id'),
            username: row.read<String>('username'),
            displayName: row.read<String>('display_name'),
            role: Role.fromStorage(row.read<String>('role')),
          ),
        )
        .toList();
  }

  /// Escalating lockout: 5 fails -> 30s, then doubling (60s, 120s, ...), max 15 min.
  static Duration lockoutFor(int failedAttempts) {
    if (failedAttempts < kMaxPinFailures) return Duration.zero;
    final shift = failedAttempts - kMaxPinFailures;
    final seconds = 30 * (1 << shift.clamp(0, 5));
    return Duration(seconds: seconds.clamp(30, 900));
  }

  Future<bool> isSetupRequired() async {
    final count =
        await (_db.selectOnly(_db.users)..addColumns([_db.users.id.count()]))
            .map((r) => r.read(_db.users.id.count()) ?? 0)
            .getSingle();
    return count == 0;
  }

  /// First-run setup: creates the Super Admin + one-time recovery code.
  /// Returns the plain recovery code (shown once, never stored in plain).
  Future<String> setupSuperAdmin({required String pin}) async {
    if (!await isSetupRequired()) {
      throw const AuthFailure('Setup already completed');
    }
    _requirePinFormat(pin);
    final hashed = await _crypto.hashPin(pin);
    final parsed = PinHash.parse(hashed.encode());
    await _db
        .into(_db.users)
        .insert(
          UsersCompanion.insert(
            username: 'superadmin',
            role: Role.superAdmin.storageKey,
            pinHash: hashed.encode(),
            salt: _b64(parsed.salt),
            updatedAt: _now(),
            deviceId: 'setup',
          ),
        );
    final code = _crypto.generateRecoveryCode();
    final codeHash = await _crypto.hashPin(code);
    await _store.write(_recoveryHashKey, codeHash.encode());
    await _store.delete(_recoveryUsedKey);
    await _logger.log(
      aksi: 'CREATE',
      entitas: 'USER',
      entitasId: 'superadmin',
      sesudah: 'Setup Super Admin',
    );
    return code;
  }

  /// Verifies PIN. Handles lockout windows and failure counting.
  Future<Result<UserRow, AppFailure>> verifyPin(
    String username,
    String pin,
  ) async {
    final user = await (_db.select(
      _db.users,
    )..where((t) => t.username.equals(username))).getSingleOrNull();
    if (user == null || !user.isActive) {
      // Same message as wrong PIN: no username enumeration.
      return UserRowDeletedOrMissing.missing;
    }
    final now = _now();
    if (user.lockedUntil != null && now.isBefore(user.lockedUntil!)) {
      final left = user.lockedUntil!.difference(now);
      await _logger.log(
        aksi: 'LOGIN_FAIL',
        entitas: 'USER',
        entitasId: username,
        userId: user.id,
        sesudah: 'Percobaan login saat akun masih terkunci',
      );
      return Err(AuthFailure('Terkunci. Coba lagi dalam ${_fmt(left)}.'));
    }
    bool ok;
    try {
      ok = await _crypto.verifyPin(pin, user.pinHash);
    } catch (_) {
      // Corrupt hash (never crash the lock screen on bad data).
      return const Err(AuthFailure('Data akun rusak. Gunakan kode pemulihan.'));
    }
    if (ok) {
      await (_db.update(_db.users)..where((t) => t.id.equals(user.id))).write(
        const UsersCompanion(
          failedAttempts: Value(0),
          lockedUntil: Value(null),
        ),
      );
      await _logger.log(
        aksi: 'LOGIN',
        entitas: 'USER',
        entitasId: username,
        userId: user.id,
        sesudah: 'Login berhasil',
      );
      return Ok(user);
    }
    final fails = user.failedAttempts + 1;
    final lock = lockoutFor(fails);
    await (_db.update(_db.users)..where((t) => t.id.equals(user.id))).write(
      UsersCompanion(
        failedAttempts: Value(fails),
        lockedUntil: Value(lock == Duration.zero ? null : now.add(lock)),
      ),
    );
    await _logger.log(
      aksi: 'LOGIN_FAIL',
      entitas: 'USER',
      entitasId: username,
      userId: user.id,
      sesudah: lock == Duration.zero
          ? 'PIN salah ($fails gagal)'
          : 'Terkunci ${_fmt(lock)}',
    );
    if (lock == Duration.zero) {
      final left = kMaxPinFailures - fails;
      return Err(AuthFailure('PIN salah. Sisa $left percobaan.'));
    }
    return Err(AuthFailure('PIN salah 5×. Terkunci ${_fmt(lock)}.'));
  }

  /// Consumes the one-time recovery code: unlocks superadmin, single use.
  Future<Result<UserRow, AppFailure>> consumeRecoveryCode(String code) async {
    final used = await _store.read(_recoveryUsedKey);
    if (used == '1') {
      return const Err(AuthFailure('Kode pemulihan sudah dipakai.'));
    }
    final stored = await _store.read(_recoveryHashKey);
    if (stored == null) {
      return const Err(AuthFailure('Tidak ada kode pemulihan.'));
    }
    if (!await _crypto.verifyPin(code.trim().toUpperCase(), stored)) {
      return const Err(AuthFailure('Kode pemulihan salah.'));
    }
    await _store.write(_recoveryUsedKey, '1');
    final admin =
        await (_db.select(_db.users)
              ..where((t) => t.role.equals(Role.superAdmin.storageKey))
              ..limit(1))
            .getSingleOrNull();
    if (admin == null) {
      return const Err(AuthFailure('Akun super admin tidak ada.'));
    }
    await (_db.update(_db.users)..where((t) => t.id.equals(admin.id))).write(
      const UsersCompanion(failedAttempts: Value(0), lockedUntil: Value(null)),
    );
    return Ok(admin);
  }

  // -- RBAC-guarded account management (Super Admin only) --

  void _require(Role actor, Permission perm) {
    if (!canRole(actor, perm)) {
      throw ForbiddenFailure(
        'Peran ${actor.label} tidak punya izin ${perm.name}.',
      );
    }
  }

  Future<UserRow> _actorOrThrow(int actorId) async {
    final actor = await (_db.select(
      _db.users,
    )..where((t) => t.id.equals(actorId))).getSingleOrNull();
    if (actor == null || !actor.isActive) {
      throw const AuthFailure('Sesi tidak valid.');
    }
    return actor;
  }

  Future<int> createUser({
    required int actorId,
    required String username,
    required Role role,
    required String pin,
  }) async {
    final actor = await _actorOrThrow(actorId);
    _require(Role.fromStorage(actor.role), Permission.manageUsers);
    _requirePinFormat(pin);
    final clean = username.trim();
    if (clean.isEmpty) throw const ValidationFailure('Username kosong.');
    final hashed = await _crypto.hashPin(pin);
    final parsed = PinHash.parse(hashed.encode());
    try {
      final id = await _db
          .into(_db.users)
          .insert(
            UsersCompanion.insert(
              username: clean,
              role: role.storageKey,
              pinHash: hashed.encode(),
              salt: _b64(parsed.salt),
              updatedAt: _now(),
              deviceId: 'admin',
            ),
          );
      await _logger.log(
        aksi: 'CREATE',
        entitas: 'USER',
        entitasId: clean,
        userId: actorId,
        sesudah: 'Peran: ${role.label}',
      );
      return id;
    } catch (_) {
      throw const ValidationFailure('Username sudah dipakai.');
    }
  }

  Future<List<UserRow>> listUsers({required int actorId}) async {
    final actor = await _actorOrThrow(actorId);
    _require(Role.fromStorage(actor.role), Permission.manageUsers);
    return (_db.select(
      _db.users,
    )..orderBy([(t) => OrderingTerm.asc(t.username)])).get();
  }

  Future<void> setUserActive({
    required int actorId,
    required int targetId,
    required bool active,
  }) async {
    final actor = await _actorOrThrow(actorId);
    _require(Role.fromStorage(actor.role), Permission.manageUsers);
    if (actorId == targetId && !active) {
      throw const ValidationFailure('Tidak bisa menonaktifkan diri sendiri.');
    }
    await (_db.update(_db.users)..where((t) => t.id.equals(targetId))).write(
      UsersCompanion(isActive: Value(active)),
    );
    await _logger.log(
      aksi: 'UPDATE',
      entitas: 'USER',
      entitasId: '$targetId',
      userId: actorId,
      sesudah: 'Status aktif diubah: $active',
    );
  }

  Future<void> resetPin({
    required int actorId,
    required int targetId,
    required String newPin,
  }) async {
    final actor = await _actorOrThrow(actorId);
    _require(Role.fromStorage(actor.role), Permission.manageUsers);
    _requirePinFormat(newPin);
    final hashed = await _crypto.hashPin(newPin);
    final parsed = PinHash.parse(hashed.encode());
    await (_db.update(_db.users)..where((t) => t.id.equals(targetId))).write(
      UsersCompanion(
        pinHash: Value(hashed.encode()),
        salt: Value(_b64(parsed.salt)),
        failedAttempts: const Value(0),
        lockedUntil: const Value(null),
      ),
    );
    await _logger.log(
      aksi: 'RESET_PIN',
      entitas: 'USER',
      entitasId: '$targetId',
      userId: actorId,
      sesudah: 'PIN di-reset oleh admin',
    );
  }

  Future<void> setBiometricEnabled({
    required int userId,
    required bool enabled,
  }) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(userId))).write(
      UsersCompanion(biometricEnabled: Value(enabled)),
    );
  }

  /// A profile belongs to one account. Re-linking never steals another account's data.
  Future<void> linkUserToMahasiswa({
    required int actorId,
    required int userId,
    required int mahasiswaId,
  }) async {
    final actor = await _actorOrThrow(actorId);
    _require(Role.fromStorage(actor.role), Permission.manageUsers);
    final target = await findUser(userId);
    if (target == null || target.role != Role.mahasiswa.storageKey) {
      throw const ValidationFailure('Pilih akun mahasiswa.');
    }
    await _db.transaction(() async {
      final profile = await _db.getMahasiswa(mahasiswaId);
      if (profile == null || profile.isDeleted) {
        throw const ValidationFailure('Profil mahasiswa tidak tersedia.');
      }
      if (profile.userId != null && profile.userId != userId) {
        throw const ValidationFailure(
          'Profil sudah terhubung dengan akun lain.',
        );
      }
      await (_db.update(_db.mahasiswa)..where((m) => m.userId.equals(userId)))
          .write(const MahasiswaCompanion(userId: Value(null)));
      await (_db.update(
        _db.mahasiswa,
      )..where((m) => m.id.equals(mahasiswaId))).write(
        MahasiswaCompanion(userId: Value(userId), updatedAt: Value(_now())),
      );
    });
    await _logger.log(
      aksi: 'LINK_PROFILE',
      entitas: 'USER',
      entitasId: '$userId',
      userId: actorId,
      sesudah: 'Profil mahasiswa dihubungkan',
    );
  }

  Future<void> linkUserToDosen({
    required int actorId,
    required int userId,
    required int dosenId,
  }) async {
    final actor = await _actorOrThrow(actorId);
    _require(Role.fromStorage(actor.role), Permission.manageUsers);
    final target = await findUser(userId);
    if (target == null ||
        !{
          Role.dosenPengampu.storageKey,
          Role.dosenWali.storageKey,
        }.contains(target.role)) {
      throw const ValidationFailure('Pilih akun dosen.');
    }
    await _db.transaction(() async {
      final profile = await (_db.select(
        _db.dosens,
      )..where((d) => d.id.equals(dosenId))).getSingleOrNull();
      if (profile == null) {
        throw const ValidationFailure('Profil dosen tidak tersedia.');
      }
      final asWali = target.role == Role.dosenWali.storageKey;
      final linkedId = asWali ? profile.waliUserId : profile.userId;
      if (linkedId != null && linkedId != userId) {
        throw const ValidationFailure(
          'Profil pada peran ini sudah terhubung dengan akun lain.',
        );
      }
      if (asWali) {
        await (_db.update(_db.dosens)..where((d) => d.userId.equals(userId)))
            .write(const DosensCompanion(userId: Value(null)));
        await (_db.update(_db.dosens)
              ..where((d) => d.waliUserId.equals(userId)))
            .write(const DosensCompanion(waliUserId: Value(null)));
        await (_db.update(
          _db.dosens,
        )..where((d) => d.id.equals(dosenId))).write(
          DosensCompanion(waliUserId: Value(userId), updatedAt: Value(_now())),
        );
      } else {
        await (_db.update(_db.dosens)..where((d) => d.userId.equals(userId)))
            .write(const DosensCompanion(userId: Value(null)));
        await (_db.update(
          _db.dosens,
        )..where((d) => d.id.equals(dosenId))).write(
          DosensCompanion(userId: Value(userId), updatedAt: Value(_now())),
        );
      }
    });
    await _logger.log(
      aksi: 'LINK_PROFILE',
      entitas: 'USER',
      entitasId: '$userId',
      userId: actorId,
      sesudah: 'Profil dosen dihubungkan',
    );
  }

  Future<UserRow?> findUser(int id) =>
      (_db.select(_db.users)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<UserRow?> findByUsername(String username) => (_db.select(
    _db.users,
  )..where((t) => t.username.equals(username.trim()))).getSingleOrNull();

  /// Clears failures/lock (used after biometric success or admin reset).
  Future<void> clearFailures(int userId) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(userId))).write(
      const UsersCompanion(failedAttempts: Value(0), lockedUntil: Value(null)),
    );
  }

  void _requirePinFormat(String pin) {
    if (!RegExp(r'^\d{6}$').hasMatch(pin)) {
      throw const ValidationFailure('PIN harus 6 digit angka.');
    }
  }

  static String _fmt(Duration d) {
    if (d.inMinutes < 1) return '${d.inSeconds} detik';
    if (d.inMinutes < 60) return '${d.inMinutes} menit';
    return '${d.inHours} jam';
  }

  static String _b64(List<int> bytes) => base64Encode(bytes);
}

/// Sentinel failure for unknown/inactive username (no enumeration).
extension UserRowDeletedOrMissing on UserRow {
  static const Err<UserRow, AppFailure> missing = Err(
    AuthFailure('Username atau PIN salah.'),
  );
}
