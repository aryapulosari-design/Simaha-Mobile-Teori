import 'dart:math';

import 'package:drift/drift.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/services/audit/audit_logger.dart';

class CampusService {
  CampusService(this.academic);
  final AcademicService academic;
  AppDatabase get db => academic.db;

  Future<List<PengumumanRow>> announcements() async {
    await academic.counts();
    final now = DateTime.now();
    final rows = await (db.select(
      db.pengumuman,
    )..orderBy([(p) => OrderingTerm.desc(p.updatedAt)])).get();
    return rows
        .where(
          (p) =>
              (p.tanggalMulai == null || !p.tanggalMulai!.isAfter(now)) &&
              (p.tanggalSelesai == null || !p.tanggalSelesai!.isBefore(now)),
        )
        .toList();
  }

  Future<void> publish(String title, String body, String category) async {
    await academic.require(Permission.manageMaster);
    if (title.trim().length < 5 ||
        title.trim().length > 120 ||
        body.trim().length < 10 ||
        body.trim().length > 3000 ||
        !['akademik', 'bimbingan', 'umum'].contains(category)) {
      throw const ValidationFailure(
        'Judul 5–120 karakter dan isi 10–3000 karakter.',
      );
    }
    await db.transaction(() async {
      final id = await db
          .into(db.pengumuman)
          .insert(
            PengumumanCompanion.insert(
              judul: title.trim(),
              isi: body.trim(),
              kategori: Value(category),
              dibuatOleh: Value(academic.actorId),
              updatedAt: DateTime.now(),
              deviceId: 'local',
            ),
          );
      await _audit('CREATE', 'PENGUMUMAN', id);
    });
  }

  Future<void> deleteAnnouncement(int id) async {
    await academic.require(Permission.manageMaster);
    await db.transaction(() async {
      await (db.delete(db.pengumuman)..where((p) => p.id.equals(id))).go();
      await _audit('DELETE', 'PENGUMUMAN', id);
    });
  }

  Future<List<AuditLogRow>> auditTrail() async {
    await academic.require(Permission.manageUsers);
    return (db.select(db.auditLog)
          ..orderBy([(a) => OrderingTerm.desc(a.waktu)])
          ..limit(100))
        .get();
  }

  Future<void> _requireAttendance(int classId) async {
    await academic.require(Permission.manageNilai);
    await academic.classDetail(classId);
  }

  Future<List<SesiPresensiRow>> sessions(int classId) async {
    await academic.classDetail(classId);
    return (db.select(db.sesiPresensi)
          ..where((s) => s.kelasId.equals(classId))
          ..orderBy([(s) => OrderingTerm.desc(s.pertemuanKe)]))
        .get();
  }

  Future<int> createSession(int classId, DateTime date) async {
    await _requireAttendance(classId);
    if (date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      throw const ValidationFailure(
        'Tanggal presensi tidak boleh di masa depan.',
      );
    }
    return db.transaction(() async {
      final previous = await sessions(classId);
      final number = previous.isEmpty ? 1 : previous.first.pertemuanKe + 1;
      final now = DateTime.now();
      final secret = List.generate(
        32,
        (_) => Random.secure().nextInt(256).toRadixString(16).padLeft(2, '0'),
      ).join();
      final id = await db
          .into(db.sesiPresensi)
          .insert(
            SesiPresensiCompanion.insert(
              kelasId: classId,
              pertemuanKe: number,
              tanggal: date,
              qrSecret: secret,
              dibukaSampai: Value(now),
              updatedAt: now,
              deviceId: 'local',
            ),
          );
      await _audit('CREATE', 'SESI_PRESENSI', id);
      return id;
    });
  }

  Future<Map<int, String>> attendance(int sessionId) async {
    final session = await (db.select(
      db.sesiPresensi,
    )..where((s) => s.id.equals(sessionId))).getSingleOrNull();
    if (session == null) {
      throw const ValidationFailure('Pertemuan tidak ditemukan.');
    }
    final detail = await academic.classDetail(session.kelasId);
    final allowed = detail.students.map((s) => s.id).toSet();
    final rows = await (db.select(
      db.presensi,
    )..where((p) => p.sesiId.equals(sessionId))).get();
    return {
      for (final row in rows)
        if (allowed.contains(row.mahasiswaId)) row.mahasiswaId: row.status,
    };
  }

  Future<void> saveAttendance(int sessionId, Map<int, String> statuses) async {
    final session = await (db.select(
      db.sesiPresensi,
    )..where((s) => s.id.equals(sessionId))).getSingleOrNull();
    if (session == null) {
      throw const ValidationFailure('Pertemuan tidak ditemukan.');
    }
    await _requireAttendance(session.kelasId);
    final roster = (await academic.classDetail(session.kelasId)).students
        .map((s) => s.id)
        .toSet();
    if (statuses.isEmpty ||
        statuses.keys.any((id) => !roster.contains(id)) ||
        statuses.values.any(
          (v) => !['hadir', 'izin', 'sakit', 'alpa'].contains(v),
        )) {
      throw const ValidationFailure(
        'Peserta atau status presensi tidak valid.',
      );
    }
    final now = DateTime.now();
    await db.transaction(() async {
      for (final entry in statuses.entries) {
        final old =
            await (db.select(db.presensi)..where(
                  (p) =>
                      p.sesiId.equals(sessionId) &
                      p.mahasiswaId.equals(entry.key),
                ))
                .getSingleOrNull();
        if (old == null) {
          await db
              .into(db.presensi)
              .insert(
                PresensiCompanion.insert(
                  sesiId: sessionId,
                  mahasiswaId: entry.key,
                  status: entry.value,
                  waktu: now,
                  updatedAt: now,
                  deviceId: 'local',
                ),
              );
        } else {
          await (db.update(
            db.presensi,
          )..where((p) => p.id.equals(old.id))).write(
            PresensiCompanion(
              status: Value(entry.value),
              metode: const Value('manual'),
              waktu: Value(now),
              updatedAt: Value(now),
            ),
          );
        }
      }
      await _audit('UPDATE', 'PRESENSI', sessionId);
    });
  }

  Future<void> _audit(String action, String entity, int id) => DbAuditLogger(db)
      .log(
        aksi: action,
        entitas: entity,
        entitasId: '$id',
        userId: academic.actorId,
      );
}
