import 'package:drift/drift.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/domain/academic/registration_policy.dart';
import 'package:simaha/domain/academic/validations.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/services/audit/audit_logger.dart';

enum MasterKind {
  program('Program studi', 'prodi'),
  lecturer('Dosen', 'dosens'),
  term('Tahun ajaran', 'tahun_ajaran'),
  course('Mata kuliah', 'mata_kuliah'),
  classroom('Kelas', 'kelas');

  const MasterKind(this.label, this.table);
  final String label, table;
}

class MasterSnapshot {
  const MasterSnapshot(
    this.programs,
    this.lecturers,
    this.terms,
    this.courses,
    this.classes,
    this.prerequisites,
  );
  final List<ProdiRow> programs;
  final List<DosenRow> lecturers;
  final List<TahunAjaranRow> terms;
  final List<MataKuliahRow> courses;
  final List<KelasRow> classes;
  final List<PrasyaratMkRow> prerequisites;
}

/// Admin-only master writes. Checks and audit belong to the same transaction.
/// Referenced academic structure is frozen to preserve historical results.
class MasterDataService {
  MasterDataService(this.academic);
  final AcademicService academic;
  AppDatabase get db => academic.db;

  Future<MasterSnapshot> snapshot() async {
    await academic.require(Permission.manageMaster);
    return db.transaction(
      () async => MasterSnapshot(
        await (db.select(
          db.prodi,
        )..orderBy([(t) => OrderingTerm.asc(t.kode)])).get(),
        await (db.select(
          db.dosens,
        )..orderBy([(t) => OrderingTerm.asc(t.nama)])).get(),
        await (db.select(db.tahunAjaran)..orderBy([
              (t) => OrderingTerm.desc(t.tahun),
              (t) => OrderingTerm.desc(t.semester),
            ]))
            .get(),
        await (db.select(
          db.mataKuliah,
        )..orderBy([(t) => OrderingTerm.asc(t.kode)])).get(),
        await (db.select(
          db.kelas,
        )..orderBy([(t) => OrderingTerm.asc(t.id)])).get(),
        await db.select(db.prasyaratMk).get(),
      ),
    );
  }

  Future<T> _write<T>(Future<T> Function() action) async {
    await academic.require(Permission.manageMaster);
    return db.transaction(action);
  }

  Future<void> _audit(MasterKind kind, int id, bool editing) =>
      DbAuditLogger(db).log(
        aksi: editing ? 'UPDATE' : 'CREATE',
        entitas: kind.table.toUpperCase(),
        entitasId: '$id',
        userId: academic.actorId,
        sesudah: '${kind.label} ${editing ? 'diperbarui' : 'ditambahkan'}',
      );

  void _check(bool condition, String message) {
    if (!condition) throw ValidationFailure(message);
  }

  void _code(String value) => _check(
    RegExp(r'^[A-Za-z0-9][A-Za-z0-9._-]{1,23}$').hasMatch(value),
    'Kode harus 2-24 karakter huruf, angka, titik, garis bawah, atau tanda hubung.',
  );

  void _name(String value) => _check(
    validateNama(value) == null && value.length <= 120,
    'Nama harus 3-120 karakter.',
  );

  Future<void> _exists(MasterKind kind, int id) async {
    final row = await db
        .customSelect(
          'SELECT id FROM ${kind.table} WHERE id = ?',
          variables: [Variable.withInt(id)],
        )
        .getSingleOrNull();
    _check(row != null, '${kind.label} tidak ditemukan.');
  }

  Future<void> _unique(
    MasterKind kind,
    String column,
    String value,
    int? id,
  ) async {
    final rows = await db
        .customSelect(
          'SELECT id FROM ${kind.table} WHERE LOWER($column) = LOWER(?) AND id <> ?',
          variables: [Variable.withString(value), Variable.withInt(id ?? -1)],
        )
        .get();
    _check(rows.isEmpty, '${kind.label}: $value sudah digunakan.');
  }

  Future<bool> _used(String sql, int id) async =>
      (await db
              .customSelect(
                sql,
                variables: [
                  for (final _ in '?'.allMatches(sql)) Variable.withInt(id),
                ],
              )
              .get())
          .isNotEmpty;

  Future<int> saveProgram({
    int? id,
    required String code,
    required String name,
  }) => _write(() async {
    code = code.trim().toUpperCase();
    name = name.trim();
    _code(code);
    _name(name);
    if (id != null) await _exists(MasterKind.program, id);
    await _unique(MasterKind.program, 'kode', code, id);
    final now = DateTime.now();
    final entry = ProdiCompanion(
      kode: Value(code),
      nama: Value(name),
      updatedAt: Value(now),
      deviceId: const Value('local'),
    );
    final result = id ?? await db.into(db.prodi).insert(entry);
    if (id != null) {
      await (db.update(db.prodi)..where((t) => t.id.equals(id))).write(entry);
    }
    await _audit(MasterKind.program, result, id != null);
    return result;
  });

  Future<int> saveLecturer({
    int? id,
    required String nidn,
    required String name,
    required int programId,
  }) => _write(() async {
    nidn = nidn.trim();
    name = name.trim();
    _check(RegExp(r'^\d{6,20}$').hasMatch(nidn), 'NIDN harus 6-20 digit.');
    _name(name);
    await _exists(MasterKind.program, programId);
    if (id != null) await _exists(MasterKind.lecturer, id);
    await _unique(MasterKind.lecturer, 'nidn', nidn, id);
    if (id != null) {
      final old = await (db.select(
        db.dosens,
      )..where((t) => t.id.equals(id))).getSingle();
      if (old.prodiId != programId) {
        _check(
          !await _used(
            'SELECT id FROM kelas WHERE dosen_id = ? UNION ALL SELECT id FROM mahasiswa WHERE dosen_wali_id = ?',
            id,
          ),
          'Dosen yang sudah mengampu atau membimbing tidak dapat dipindah prodi.',
        );
      }
    }
    final entry = DosensCompanion(
      nidn: Value(nidn),
      nama: Value(name),
      prodiId: Value(programId),
      updatedAt: Value(DateTime.now()),
      deviceId: const Value('local'),
    );
    final result = id ?? await db.into(db.dosens).insert(entry);
    if (id != null) {
      await (db.update(db.dosens)..where((t) => t.id.equals(id))).write(entry);
    }
    await _audit(MasterKind.lecturer, result, id != null);
    return result;
  });

  Future<int> saveTerm({
    int? id,
    required String year,
    required int semester,
    required bool active,
  }) => _write(() async {
    year = year.trim();
    _check(
      RegExp(r'^20\d{2}/20\d{2}$').hasMatch(year),
      'Tahun ajaran harus YYYY/YYYY, misalnya 2026/2027.',
    );
    _check(
      int.parse(year.substring(5)) == int.parse(year.substring(0, 4)) + 1,
      'Tahun akhir harus satu tahun setelah tahun awal.',
    );
    _check(
      semester >= 1 && semester <= 3,
      'Semester harus Gasal, Genap, atau Pendek.',
    );
    final matches =
        await (db.select(db.tahunAjaran)..where(
              (t) =>
                  t.tahun.equals(year) &
                  t.semester.equals(semester) &
                  t.id.equals(id ?? -1).not(),
            ))
            .get();
    _check(matches.isEmpty, 'Tahun ajaran dan semester sudah tersedia.');
    if (id != null) {
      await _exists(MasterKind.term, id);
      final old = await (db.select(
        db.tahunAjaran,
      )..where((t) => t.id.equals(id))).getSingle();
      if (old.tahun != year || old.semester != semester) {
        _check(
          !await _used('SELECT id FROM kelas WHERE ta_id = ?', id),
          'Semester yang sudah mempunyai kelas tidak dapat diubah identitasnya.',
        );
      }
    }
    final now = DateTime.now();
    if (active) {
      await db
          .update(db.tahunAjaran)
          .write(
            TahunAjaranCompanion(
              isActive: const Value(false),
              updatedAt: Value(now),
              deviceId: const Value('local'),
            ),
          );
    }
    final entry = TahunAjaranCompanion(
      tahun: Value(year),
      semester: Value(semester),
      isActive: Value(active),
      updatedAt: Value(now),
      deviceId: const Value('local'),
    );
    final result = id ?? await db.into(db.tahunAjaran).insert(entry);
    if (id != null) {
      await (db.update(
        db.tahunAjaran,
      )..where((t) => t.id.equals(id))).write(entry);
    }
    await _audit(MasterKind.term, result, id != null);
    return result;
  });

  Future<int> saveCourse({
    int? id,
    required String code,
    required String name,
    required int credits,
    required int semester,
    required int programId,
    Set<int> prerequisites = const {},
  }) => _write(() async {
    code = code.trim().toUpperCase();
    name = name.trim();
    _code(code);
    _name(name);
    _check(credits >= 1 && credits <= 6, 'SKS mata kuliah harus 1-6.');
    _check(semester >= 1 && semester <= 14, 'Semester kurikulum harus 1-14.');
    await _exists(MasterKind.program, programId);
    await _unique(MasterKind.course, 'kode', code, id);
    if (id != null) {
      await _exists(MasterKind.course, id);
      final old = await (db.select(
        db.mataKuliah,
      )..where((t) => t.id.equals(id))).getSingle();
      final oldRequirements =
          (await (db.select(
                db.prasyaratMk,
              )..where((t) => t.mkId.equals(id))).get())
              .map((r) => r.prasyaratMkId)
              .toSet();
      if (old.kode != code ||
          old.sks != credits ||
          old.prodiId != programId ||
          oldRequirements.length != prerequisites.length ||
          !oldRequirements.containsAll(prerequisites)) {
        _check(
          !await _used(
            'SELECT r.id FROM krs r JOIN kelas k ON k.id = r.kelas_id WHERE k.mk_id = ?',
            id,
          ),
          'Kode, SKS, prodi, dan prasyarat mata kuliah yang sudah diambil tidak dapat diubah.',
        );
      }
    }
    for (final prerequisite in prerequisites) {
      await _exists(MasterKind.course, prerequisite);
      _check(
        prerequisite != id,
        'Mata kuliah tidak boleh menjadi prasyarat dirinya sendiri.',
      );
      final row = await (db.select(
        db.mataKuliah,
      )..where((t) => t.id.equals(prerequisite))).getSingle();
      _check(
        row.prodiId == programId,
        'Prasyarat harus berasal dari program studi yang sama.',
      );
    }
    final graph = <int, Set<int>>{};
    for (final row in await db.select(db.prasyaratMk).get()) {
      if (row.mkId != id) (graph[row.mkId] ??= {}).add(row.prasyaratMkId);
    }
    bool reaches(int node, Set<int> seen) {
      if (node == id) return true;
      if (!seen.add(node)) return false;
      return (graph[node] ?? {}).any((next) => reaches(next, seen));
    }

    _check(
      !prerequisites.any((p) => reaches(p, {})),
      'Prasyarat tidak boleh membentuk siklus.',
    );
    final now = DateTime.now();
    final entry = MataKuliahCompanion(
      kode: Value(code),
      nama: Value(name),
      sks: Value(credits),
      semester: Value(semester),
      prodiId: Value(programId),
      updatedAt: Value(now),
      deviceId: const Value('local'),
    );
    final result = id ?? await db.into(db.mataKuliah).insert(entry);
    if (id != null) {
      await (db.update(
        db.mataKuliah,
      )..where((t) => t.id.equals(id))).write(entry);
    }
    await (db.delete(db.prasyaratMk)..where((t) => t.mkId.equals(result))).go();
    for (final prerequisite in prerequisites) {
      await db
          .into(db.prasyaratMk)
          .insert(
            PrasyaratMkCompanion.insert(
              mkId: result,
              prasyaratMkId: prerequisite,
              updatedAt: now,
              deviceId: 'local',
            ),
          );
    }
    await _audit(MasterKind.course, result, id != null);
    return result;
  });

  Future<int> saveClass({
    int? id,
    required int courseId,
    required int lecturerId,
    required int termId,
    required String day,
    required String start,
    required String end,
    required String room,
  }) => _write(() async {
    day = day.trim();
    start = start.trim();
    end = end.trim();
    room = room.trim();
    final error = validateSchedule(day, start, end);
    if (error != null) throw ValidationFailure(error);
    _check(
      room.isNotEmpty && room.length <= 60,
      'Ruang wajib diisi, maksimal 60 karakter.',
    );
    await _exists(MasterKind.course, courseId);
    await _exists(MasterKind.lecturer, lecturerId);
    await _exists(MasterKind.term, termId);
    final course = await (db.select(
      db.mataKuliah,
    )..where((t) => t.id.equals(courseId))).getSingle();
    final lecturer = await (db.select(
      db.dosens,
    )..where((t) => t.id.equals(lecturerId))).getSingle();
    _check(
      course.prodiId == lecturer.prodiId,
      'Dosen dan mata kuliah harus berada di program studi yang sama.',
    );
    if (id != null) {
      await _exists(MasterKind.classroom, id);
      final old = await (db.select(
        db.kelas,
      )..where((t) => t.id.equals(id))).getSingle();
      if (old.mkId != courseId ||
          old.dosenId != lecturerId ||
          old.taId != termId ||
          old.hari != day ||
          old.jamMulai != start ||
          old.jamSelesai != end) {
        _check(
          !await _used(
            'SELECT id FROM krs WHERE kelas_id = ? UNION ALL SELECT id FROM sesi_presensi WHERE kelas_id = ?',
            id,
          ),
          'Kelas yang sudah mempunyai KRS atau sesi hanya boleh diubah ruangnya. Buat kelas baru untuk jadwal berbeda.',
        );
      }
    }
    final others = await (db.select(
      db.kelas,
    )..where((t) => t.taId.equals(termId) & t.id.equals(id ?? -1).not())).get();
    for (final other in others) {
      if (other.dosenId != lecturerId &&
          other.ruang.toLowerCase() != room.toLowerCase()) {
        continue;
      }
      _check(
        !jadwalKelasBentrok(
          hariA: day,
          jamMulaiA: start,
          jamSelesaiA: end,
          hariB: other.hari,
          jamMulaiB: other.jamMulai,
          jamSelesaiB: other.jamSelesai,
        ),
        'Jadwal bentrok: dosen atau ruang sudah digunakan kelas lain.',
      );
    }
    final entry = KelasCompanion(
      mkId: Value(courseId),
      dosenId: Value(lecturerId),
      taId: Value(termId),
      hari: Value(day),
      jamMulai: Value(start),
      jamSelesai: Value(end),
      ruang: Value(room),
      updatedAt: Value(DateTime.now()),
      deviceId: const Value('local'),
    );
    final result = id ?? await db.into(db.kelas).insert(entry);
    if (id != null) {
      await (db.update(db.kelas)..where((t) => t.id.equals(id))).write(entry);
    }
    await _audit(MasterKind.classroom, result, id != null);
    return result;
  });

  Future<void> delete(MasterKind kind, int id) => _write(() async {
    await _exists(kind, id);
    final dependencies = switch (kind) {
      MasterKind.program => [
        'SELECT id FROM mahasiswa WHERE prodi_id = ?',
        'SELECT id FROM dosens WHERE prodi_id = ?',
        'SELECT id FROM mata_kuliah WHERE prodi_id = ?',
      ],
      MasterKind.lecturer => [
        'SELECT id FROM kelas WHERE dosen_id = ?',
        'SELECT id FROM mahasiswa WHERE dosen_wali_id = ?',
        'SELECT id FROM catatan_bimbingan WHERE dosen_id = ?',
      ],
      MasterKind.term => [
        'SELECT id FROM kelas WHERE ta_id = ?',
        'SELECT id FROM krs WHERE ta_id = ?',
        'SELECT id FROM tahun_ajaran WHERE id = ? AND is_active = 1',
      ],
      MasterKind.course => [
        'SELECT id FROM kelas WHERE mk_id = ?',
        'SELECT mk_id FROM prasyarat_mk WHERE prasyarat_mk_id = ?',
      ],
      MasterKind.classroom => [
        'SELECT id FROM krs WHERE kelas_id = ?',
        'SELECT id FROM sesi_presensi WHERE kelas_id = ?',
        'SELECT id FROM jadwal_ujian WHERE kelas_id = ?',
        'SELECT id FROM edom_partisipasi WHERE kelas_id = ?',
        'SELECT id FROM edom_jawaban WHERE kelas_id = ?',
      ],
    };
    for (final sql in dependencies) {
      _check(
        !await _used(sql, id),
        '${kind.label} masih dipakai atau sedang aktif dan tidak dapat dihapus.',
      );
    }
    if (kind == MasterKind.course) {
      await (db.delete(db.prasyaratMk)..where((t) => t.mkId.equals(id))).go();
    }
    await db.customUpdate(
      'DELETE FROM ${kind.table} WHERE id = ?',
      variables: [Variable.withInt(id)],
      updates: db.allTables
          .where((t) => t.actualTableName == kind.table)
          .toSet(),
    );
    await DbAuditLogger(db).log(
      aksi: 'DELETE',
      entitas: kind.table.toUpperCase(),
      entitasId: '$id',
      userId: academic.actorId,
    );
  });
}
