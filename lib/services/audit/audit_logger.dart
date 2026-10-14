import 'package:drift/drift.dart';
import 'package:simaha/core/utils/clock.dart';
import 'package:simaha/data/local/app_database.dart';

/// Contract for recording audit logs across all state-mutating operations.
abstract class AuditLogger {
  Future<void> log({
    required String aksi,
    required String entitas,
    String? entitasId,
    String? sebelum,
    String? sesudah,
    int? userId,
  });
}

/// Production implementation saving logs to the encrypted local SQLite database.
class DbAuditLogger implements AuditLogger {
  DbAuditLogger(this.db, {this.clock = const SystemClock()});

  final AppDatabase db;
  final Clock clock;

  @override
  Future<void> log({
    required String aksi,
    required String entitas,
    String? entitasId,
    String? sebelum,
    String? sesudah,
    int? userId,
  }) async {
    await db.into(db.auditLog).insert(
      AuditLogCompanion.insert(
        aksi: aksi,
        entitas: entitas,
        entitasId: Value(entitasId),
        sebelum: Value(sebelum),
        sesudah: Value(sesudah),
        userId: Value(userId),
        waktu: clock.now(),
      ),
    );
  }
}

/// Test/No-op audit logger.
class NoopAuditLogger implements AuditLogger {
  const NoopAuditLogger();

  @override
  Future<void> log({
    required String aksi,
    required String entitas,
    String? entitasId,
    String? sebelum,
    String? sesudah,
    int? userId,
  }) async {}
}
