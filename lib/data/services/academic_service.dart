import 'package:drift/drift.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/domain/academic/validations.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/domain/academic/academic_overview.dart';
import 'package:simaha/services/audit/audit_logger.dart';

/// Application boundary: every request rechecks the active account and scope.
/// AppDatabase remains the internal persistence API used by seeders/migrations.
class AcademicService {
  AcademicService(this.db, this.actorId);

  final AppDatabase db;
  final int? actorId;

  Future<UserRow> _actor() async {
    final user = await (db.select(
      db.users,
    )..where((u) => u.id.equals(actorId ?? -1))).getSingleOrNull();
    if (user == null || !user.isActive) {
      throw const ForbiddenFailure('Silakan masuk dengan akun aktif.');
    }
    return user;
  }

  Future<void> require(Permission permission) async {
    final user = await _actor();
    if (!canRole(Role.fromStorage(user.role), permission)) {
      throw const ForbiddenFailure(
        'Akun ini tidak memiliki izin untuk tindakan tersebut.',
      );
    }
  }

  Future<List<AcademicClassInfo>> classes() async {
    final user = await _actor();
    final role = Role.fromStorage(user.role);
    final classScope = switch (role) {
      Role.superAdmin || Role.adminAkademik => '1 = 1',
      Role.dosenPengampu => 'd.user_id = ?',
      Role.mahasiswa =>
        'EXISTS (SELECT 1 FROM krs r JOIN mahasiswa x ON x.id = r.mahasiswa_id '
            'WHERE r.kelas_id = kl.id AND x.user_id = ? AND x.is_deleted = 0)',
      Role.dosenWali =>
        'EXISTS (SELECT 1 FROM krs r JOIN mahasiswa x ON x.id = r.mahasiswa_id '
            'JOIN dosens w ON w.id = x.dosen_wali_id WHERE r.kelas_id = kl.id '
            'AND COALESCE(w.wali_user_id, w.user_id) = ? AND x.is_deleted = 0)',
    };
    final restricted = role != Role.superAdmin && role != Role.adminAkademik;
    final rows = await db
        .customSelect(
          'SELECT kl.id, mk.kode, mk.nama, mk.sks, d.nama AS dosen, kl.hari, kl.jam_mulai, '
          'kl.jam_selesai, kl.ruang, ta.tahun, ta.semester, COUNT(DISTINCT m.id) AS peserta, '
          'AVG(n.nilai_akhir) AS rerata FROM kelas kl '
          'JOIN mata_kuliah mk ON mk.id = kl.mk_id JOIN dosens d ON d.id = kl.dosen_id '
          'JOIN tahun_ajaran ta ON ta.id = kl.ta_id '
          'LEFT JOIN krs k ON k.kelas_id = kl.id '
          'LEFT JOIN mahasiswa m ON m.id = k.mahasiswa_id AND m.is_deleted = 0 '
          'LEFT JOIN nilai n ON n.krs_id = k.id AND m.id IS NOT NULL '
          'WHERE ($classScope) AND (m.id IS NULL OR (${_scope(role)})) '
          'GROUP BY kl.id ORDER BY mk.kode, kl.id',
          variables: [
            if (restricted) Variable.withInt(user.id),
            if (restricted) Variable.withInt(user.id),
          ],
          readsFrom: {
            db.kelas,
            db.mataKuliah,
            db.dosens,
            db.tahunAjaran,
            db.krs,
            db.mahasiswa,
            db.nilai,
          },
        )
        .get();
    return rows
        .map(
          (r) => AcademicClassInfo(
            id: r.read<int>('id'),
            code: r.read<String>('kode'),
            name: r.read<String>('nama'),
            credits: r.read<int>('sks'),
            lecturer: r.read<String>('dosen'),
            day: r.read<String>('hari'),
            start: r.read<String>('jam_mulai'),
            end: r.read<String>('jam_selesai'),
            room: r.read<String>('ruang'),
            term:
                '${r.read<String>('tahun')} / ${r.read<int>('semester') == 1 ? 'Gasal' : 'Genap'}',
            studentCount: r.read<int>('peserta'),
            average: r.readNullable<double>('rerata'),
          ),
        )
        .toList();
  }

  Future<AcademicClassDetail> classDetail(int classId) async {
    final visible = (await classes()).where((c) => c.id == classId).firstOrNull;
    if (visible == null) {
      throw const ForbiddenFailure('Kelas tidak tersedia untuk akun ini.');
    }
    final user = await _actor();
    final role = Role.fromStorage(user.role);
    final rows = await db
        .customSelect(
          'SELECT m.id, m.nim, m.nama, n.huruf, n.nilai_akhir, COUNT(s.id) AS pertemuan, '
          "COALESCE(SUM(p.status = 'hadir'), 0) AS hadir, COALESCE(SUM(p.status = 'izin'), 0) AS izin, "
          "COALESCE(SUM(p.status = 'sakit'), 0) AS sakit, COALESCE(SUM(p.status = 'alpa'), 0) AS alpa "
          'FROM krs k JOIN mahasiswa m ON m.id = k.mahasiswa_id '
          'LEFT JOIN nilai n ON n.krs_id = k.id '
          'LEFT JOIN sesi_presensi s ON s.kelas_id = k.kelas_id '
          'LEFT JOIN presensi p ON p.sesi_id = s.id AND p.mahasiswa_id = m.id '
          'WHERE k.kelas_id = ? AND m.is_deleted = 0 AND (${_scope(role)}) '
          'GROUP BY k.id, m.id ORDER BY m.nama, m.id',
          variables: [
            Variable.withInt(classId),
            if (role != Role.superAdmin && role != Role.adminAkademik)
              Variable.withInt(user.id),
          ],
          readsFrom: {
            db.krs,
            db.mahasiswa,
            db.nilai,
            db.sesiPresensi,
            db.presensi,
            db.kelas,
            db.dosens,
          },
        )
        .get();
    return AcademicClassDetail(
      visible,
      rows
          .map(
            (r) => ClassStudentInfo(
              id: r.read<int>('id'),
              nim: r.read<String>('nim'),
              name: r.read<String>('nama'),
              letter: r.readNullable<String>('huruf'),
              score: r.readNullable<double>('nilai_akhir'),
              meetings: r.read<int>('pertemuan'),
              present: r.read<int>('hadir'),
              excused: r.read<int>('izin'),
              sick: r.read<int>('sakit'),
              absent: r.read<int>('alpa'),
            ),
          )
          .toList(),
    );
  }

  Future<List<AdvisingNote>> advisingNotes(int studentId) async {
    final user = await _actor();
    if (!{
      Role.superAdmin,
      Role.dosenWali,
      Role.mahasiswa,
    }.contains(Role.fromStorage(user.role))) {
      throw const ForbiddenFailure(
        'Catatan bimbingan hanya untuk mahasiswa, dosen wali, dan Super Admin.',
      );
    }
    await student(studentId);
    final rows = await db
        .customSelect(
          'SELECT b.id, b.isi, b.tindak_lanjut, b.tanggal, d.nama AS dosen FROM catatan_bimbingan b '
          'JOIN dosens d ON d.id = b.dosen_id WHERE b.mahasiswa_id = ? ORDER BY b.tanggal DESC, b.id DESC',
          variables: [Variable.withInt(studentId)],
          readsFrom: {db.catatanBimbingan, db.dosens},
        )
        .get();
    return rows
        .map(
          (r) => AdvisingNote(
            id: r.read<int>('id'),
            lecturer: r.read<String>('dosen'),
            content: r.read<String>('isi'),
            followUp: r.readNullable<String>('tindak_lanjut'),
            date: r.read<DateTime>('tanggal'),
          ),
        )
        .toList();
  }

  Future<void> addAdvisingNote({
    required int studentId,
    required String content,
    String followUp = '',
  }) async {
    await require(Permission.manageBimbingan);
    final profile = await student(studentId);
    final text = content.trim();
    final action = followUp.trim();
    if (text.length < 5 || text.length > 2000 || action.length > 2000) {
      throw const ValidationFailure(
        'Catatan harus 5–2000 karakter; tindak lanjut maksimal 2000 karakter.',
      );
    }
    final lecturerId = profile!.dosenWaliId;
    if (lecturerId == null) {
      throw const ValidationFailure('Mahasiswa belum mempunyai dosen wali.');
    }
    final now = DateTime.now();
    await db.transaction(() async {
      final id = await db
          .into(db.catatanBimbingan)
          .insert(
            CatatanBimbinganCompanion.insert(
              mahasiswaId: studentId,
              dosenId: lecturerId,
              isi: text,
              tindakLanjut: Value(action.isEmpty ? null : action),
              tanggal: now,
              updatedAt: now,
              deviceId: 'local',
            ),
          );
      await DbAuditLogger(db).log(
        aksi: 'CREATE',
        entitas: 'BIMBINGAN',
        entitasId: '$id',
        userId: actorId,
        sesudah: 'Catatan bimbingan mahasiswa $studentId ditambahkan',
      );
    });
  }

  String _scope(Role role) => switch (role) {
    Role.superAdmin || Role.adminAkademik => '1 = 1',
    Role.mahasiswa => 'm.user_id = ?',
    Role.dosenWali =>
      'EXISTS (SELECT 1 FROM dosens d '
          'WHERE d.id = m.dosen_wali_id AND COALESCE(d.wali_user_id, d.user_id) = ?)',
    Role.dosenPengampu =>
      'EXISTS (SELECT 1 FROM krs k '
          'JOIN kelas kl ON kl.id = k.kelas_id '
          'JOIN dosens d ON d.id = kl.dosen_id '
          'WHERE k.mahasiswa_id = m.id AND d.user_id = ?)',
  };

  Future<({int total, int aktif, int prodi})> counts() async {
    final user = await _actor();
    final role = Role.fromStorage(user.role);
    final row = await db
        .customSelect(
          "SELECT COUNT(*) AS total, COALESCE(SUM(m.status = 'aktif'), 0) AS aktif, "
          'COUNT(DISTINCT m.prodi_id) AS prodi FROM mahasiswa m '
          'WHERE m.is_deleted = 0 AND ${_scope(role)}',
          variables: [
            if (role != Role.superAdmin && role != Role.adminAkademik)
              Variable.withInt(user.id),
          ],
          readsFrom: {db.mahasiswa, db.krs, db.kelas, db.dosens},
        )
        .getSingle();
    return (
      total: row.read<int>('total'),
      aktif: row.read<int>('aktif'),
      prodi: row.read<int>('prodi'),
    );
  }

  Future<List<MahasiswaRow>> students({
    String query = '',
    int limit = 20,
    int? id,
  }) async {
    final user = await _actor();
    final role = Role.fromStorage(user.role);
    final variables = <Variable>[];
    final clauses = <String>['m.is_deleted = 0', _scope(role)];
    if (role != Role.superAdmin && role != Role.adminAkademik) {
      variables.add(Variable.withInt(user.id));
    }
    if (id != null) {
      clauses.add('m.id = ?');
      variables.add(Variable.withInt(id));
    }
    if (query.trim().isNotEmpty) {
      // Quote every term so user input cannot inject FTS operators.
      final terms = query
          .replaceAll('"', '')
          .split(RegExp(r'\s+'))
          .where((term) => term.isNotEmpty)
          .map((term) => '"$term"*')
          .join(' OR ');
      if (terms.isEmpty) return [];
      clauses.add(
        'm.id IN (SELECT rowid FROM mahasiswa_fts WHERE mahasiswa_fts MATCH ?)',
      );
      variables.add(Variable.withString(terms));
    }
    variables.add(Variable.withInt(limit.clamp(1, 100000)));
    final rows = await db
        .customSelect(
          'SELECT m.* FROM mahasiswa m WHERE ${clauses.join(' AND ')} ORDER BY m.nama, m.id LIMIT ?',
          variables: variables,
          readsFrom: {db.mahasiswa, db.krs, db.kelas, db.dosens},
        )
        .get();
    return rows.map((row) => db.mahasiswa.map(row.data)).toList();
  }

  Future<MahasiswaRow?> student(int id) async {
    final rows = await students(id: id, limit: 1);
    if (rows.isEmpty) {
      throw const ForbiddenFailure(
        'Data tidak tersedia dalam lingkup akun ini.',
      );
    }
    return rows.first;
  }

  Future<List<KrsNilaiItem>> grades(int id) async {
    await student(id);
    final items = await db.listNilaiMahasiswa(id);
    final user = await _actor();
    if (Role.fromStorage(user.role) != Role.dosenPengampu) return items;
    final classes = await classOptions();
    final ids = classes.map((c) => c.kelasId).toSet();
    return items.where((item) => ids.contains(item.kelasId)).toList();
  }

  Future<List<KelasOption>> classOptions() async {
    await require(Permission.manageNilai);
    final user = await _actor();
    final options = await db.listKelasOptions();
    if (Role.fromStorage(user.role) != Role.dosenPengampu) return options;
    final rows = await db
        .customSelect(
          'SELECT kl.id FROM kelas kl JOIN dosens d ON d.id = kl.dosen_id WHERE d.user_id = ?',
          variables: [Variable.withInt(user.id)],
          readsFrom: {db.kelas, db.dosens},
        )
        .get();
    final ids = rows.map((row) => row.read<int>('id')).toSet();
    return options.where((option) => ids.contains(option.kelasId)).toList();
  }

  Future<void> _requireGrade(int krsId) async {
    await require(Permission.manageNilai);
    final entry = await (db.select(
      db.krs,
    )..where((k) => k.id.equals(krsId))).getSingleOrNull();
    if (entry == null) throw const ValidationFailure('KRS tidak ditemukan.');
    await student(entry.mahasiswaId);
    if (!(await classOptions()).any((c) => c.kelasId == entry.kelasId)) {
      throw const ForbiddenFailure('Kelas ini bukan kelas yang Anda ampu.');
    }
  }

  void _validateScores(double tugas, double uts, double uas) {
    if ([tugas, uts, uas].any((n) => !n.isFinite || n < 0 || n > 100)) {
      throw const ValidationFailure('Nilai harus berada di antara 0 dan 100.');
    }
  }

  Future<void> saveNilai({
    required int krsId,
    required double tugas,
    required double uts,
    required double uas,
  }) async {
    await _requireGrade(krsId);
    _validateScores(tugas, uts, uas);
    await db.saveNilai(krsId: krsId, tugas: tugas, uts: uts, uas: uas);
  }

  Future<int> addKrsNilai({
    required int mahasiswaId,
    required int kelasId,
    required double tugas,
    required double uts,
    required double uas,
  }) async {
    // Adding/removing registrations is an academic administrator operation.
    await require(Permission.manageMaster);
    await student(mahasiswaId);
    _validateScores(tugas, uts, uas);
    if ((await db.listNilaiMahasiswa(mahasiswaId))
        .any((k) => k.kelasId == kelasId)) {
      throw const ValidationFailure('Kelas sudah diambil.');
    }
    return db.addKrsNilai(
      mahasiswaId: mahasiswaId,
      kelasId: kelasId,
      tugas: tugas,
      uts: uts,
      uas: uas,
    );
  }

  Future<void> deleteKrs(int id) async {
    await require(Permission.manageMaster);
    await _requireGrade(id);
    await db.deleteKrs(id);
  }

  Future<List<MahasiswaRow>> trash() async {
    await require(Permission.manageMaster);
    return db.listTrashMahasiswa();
  }

  Future<void> softDeleteMahasiswa(int id) async {
    await require(Permission.manageMaster);
    await db.softDeleteMahasiswa(id);
  }

  Future<void> restoreMahasiswa(int id) async {
    await require(Permission.manageMaster);
    await db.restoreMahasiswa(id);
  }

  Future<void> setSetting(String key, String value) async {
    await require(Permission.manageMaster);
    await db.setSetting(key, value);
  }

  void _validateStudent(
    String nim,
    String nama,
    int angkatan,
    String email,
    String noHp,
  ) {
    final error =
        validateNim(nim) ??
        validateNama(nama) ??
        (angkatan < 2000 || angkatan > 2100 ? 'Tahun tidak valid.' : null) ??
        validateEmail(email) ??
        validatePhone(noHp);
    if (error != null) throw ValidationFailure(error);
  }

  Future<int> createMahasiswa({
    required String nim,
    required String nama,
    required int prodiId,
    required int angkatan,
    String status = 'aktif',
    String email = '',
    String noHp = '',
    int? dosenWaliId,
  }) async {
    await require(Permission.manageMaster);
    _validateStudent(nim, nama, angkatan, email, noHp);
    return db.createMahasiswa(
      nim: nim,
      nama: nama,
      prodiId: prodiId,
      angkatan: angkatan,
      status: status,
      email: email,
      noHp: noHp,
      dosenWaliId: dosenWaliId,
    );
  }

  Future<void> updateMahasiswa({
    required int id,
    required String nama,
    required int prodiId,
    required int angkatan,
    required String status,
    String email = '',
    String noHp = '',
    int? dosenWaliId,
  }) async {
    await require(Permission.manageMaster);
    final existing = await student(id);
    _validateStudent(existing!.nim, nama, angkatan, email, noHp);
    await db.updateMahasiswa(
      id: id,
      nama: nama,
      prodiId: prodiId,
      angkatan: angkatan,
      status: status,
      email: email,
      noHp: noHp,
      dosenWaliId: dosenWaliId,
    );
  }
}
