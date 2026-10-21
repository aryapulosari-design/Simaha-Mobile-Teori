import 'package:drift/drift.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/data/local/tables.dart';

part 'app_database.g.dart';

// FTS5 + index DDL kept as constants so tests can assert their presence.
const String kFtsTableDdl =
    "CREATE VIRTUAL TABLE IF NOT EXISTS mahasiswa_fts "
    "USING fts5(nim, nama, content='mahasiswa', content_rowid='id');";

const String kIdxMahasiswaAngkatanStatus =
    'CREATE INDEX IF NOT EXISTS idx_mahasiswa_angkatan_status '
    'ON mahasiswa (angkatan, status);';

const String kIdxKrsMhs =
    'CREATE INDEX IF NOT EXISTS idx_krs_mhs ON krs (mahasiswa_id);';

const String kIdxNilaiKrs =
    'CREATE INDEX IF NOT EXISTS idx_nilai_krs ON nilai (krs_id);';

const String kIdxPresensiSesi =
    'CREATE INDEX IF NOT EXISTS idx_presensi_sesi ON presensi (sesi_id);';

const String kIdxJadwalUjianTanggalRuang =
    'CREATE INDEX IF NOT EXISTS idx_jadwal_ujian_tanggal_ruang '
    'ON jadwal_ujian (tanggal, ruang);';

const String kIdxDokumenArsipMhs =
    'CREATE INDEX IF NOT EXISTS idx_dokumen_arsip_mhs '
    'ON dokumen_arsip (mahasiswa_id);';

const String kIdxPrestasiMhs =
    'CREATE INDEX IF NOT EXISTS idx_prestasi_mhs ON prestasi (mahasiswa_id);';

const String kIdxEdomJawabanPeriode =
    'CREATE INDEX IF NOT EXISTS idx_edom_jawaban_periode '
    'ON edom_jawaban (periode_id, kelas_id);';

const String kTriggerMahasiswaInsert = '''
CREATE TRIGGER IF NOT EXISTS trg_mahasiswa_ai AFTER INSERT ON mahasiswa
BEGIN
  INSERT INTO mahasiswa_fts(rowid, nim, nama) VALUES (new.id, new.nim, new.nama);
END;
''';

const String kTriggerMahasiswaDelete = '''
CREATE TRIGGER IF NOT EXISTS trg_mahasiswa_ad AFTER DELETE ON mahasiswa
BEGIN
  INSERT INTO mahasiswa_fts(mahasiswa_fts, rowid, nim, nama)
  VALUES ('delete', old.id, old.nim, old.nama);
END;
''';

const String kTriggerMahasiswaUpdate = '''
CREATE TRIGGER IF NOT EXISTS trg_mahasiswa_au AFTER UPDATE ON mahasiswa
BEGIN
  INSERT INTO mahasiswa_fts(mahasiswa_fts, rowid, nim, nama)
  VALUES ('delete', old.id, old.nim, old.nama);
  INSERT INTO mahasiswa_fts(rowid, nim, nama) VALUES (new.id, new.nim, new.nama);
END;
''';

@DriftDatabase(
  tables: [
    Users,
    Prodi,
    Dosens,
    Mahasiswa,
    TahunAjaran,
    MataKuliah,
    PrasyaratMk,
    Kelas,
    Krs,
    Nilai,
    SesiPresensi,
    Presensi,
    CatatanBimbingan,
    Peringatan,
    AuditLog,
    SyncLog,
    // Tambahan spek seksi 4 (skema v3).
    Pengaturan,
    Pengumuman,
    AgendaAkademik,
    JadwalUjian,
    Prestasi,
    EdomPeriode,
    EdomPertanyaan,
    EdomPartisipasi,
    EdomJawaban,
    DokumenArsip,
    SavedFilters,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 5;

  /// Tables carrying sync columns (updated_at + device_id). AuditLog and
  /// SyncLog are append-only local logs excluded from sync deltas, so they
  /// intentionally have `waktu` instead.
  static const List<String> syncedTables = [
    'users',
    'prodi',
    'dosens',
    'mahasiswa',
    'tahun_ajaran',
    'mata_kuliah',
    'prasyarat_mk',
    'kelas',
    'krs',
    'nilai',
    'sesi_presensi',
    'presensi',
    'catatan_bimbingan',
    'peringatan',
    'pengaturan',
    'pengumuman',
    'agenda_akademik',
    'jadwal_ujian',
    'prestasi',
    'edom_periode',
    'edom_pertanyaan',
    'edom_partisipasi',
    'edom_jawaban',
    'dokumen_arsip',
    'saved_filters',
  ];

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(kFtsTableDdl);
      await customStatement(kIdxMahasiswaAngkatanStatus);
      await customStatement(kIdxKrsMhs);
      await customStatement(kIdxNilaiKrs);
      await customStatement(kIdxPresensiSesi);
      await customStatement(kIdxJadwalUjianTanggalRuang);
      await customStatement(kIdxDokumenArsipMhs);
      await customStatement(kIdxPrestasiMhs);
      await customStatement(kIdxEdomJawabanPeriode);
      await customStatement(kTriggerMahasiswaInsert);
      await customStatement(kTriggerMahasiswaDelete);
      await customStatement(kTriggerMahasiswaUpdate);
      // Default pengaturan (syarat SKS lulus 144 sesuai spek seksi 4).
      await customStatement(
        "INSERT OR IGNORE INTO pengaturan (kunci, nilai, updated_at, device_id) "
        "VALUES ('syarat_sks_lulus', '144', "
        "strftime('%s','now'), 'seed');",
      );
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // v2: sync columns for Tahap I (last-write-wins deltas).
        // SQLite forbids ADD COLUMN with non-constant defaults, so the
        // new columns land as NOT NULL with constant placeholders, then
        // old rows are backfilled to unix-seconds (drift's int format).
        // All writers pass explicit stamps (compile-time required), so
        // the placeholder default never fires in practice.
        const tables = [
          'users',
          'prodi',
          'dosens',
          'tahun_ajaran',
          'mata_kuliah',
          'prasyarat_mk',
          'kelas',
          'krs',
          'nilai',
          'sesi_presensi',
          'presensi',
          'catatan_bimbingan',
          'peringatan',
        ];
        for (final t in tables) {
          await customStatement(
            'ALTER TABLE "$t" ADD COLUMN "updated_at" INTEGER '
            'NOT NULL DEFAULT 0;',
          );
          await customStatement(
            'ALTER TABLE "$t" ADD COLUMN "device_id" TEXT '
            "NOT NULL DEFAULT '';",
          );
          await customStatement(
            "UPDATE \"$t\" SET updated_at = strftime('%s','now') "
            'WHERE updated_at = 0;',
          );
        }
      }
      if (from < 3) {
        // v3: tabel tambahan spek seksi 4 (pengaturan, pengumuman,
        // agenda, jadwal ujian, prestasi, edom, arsip dokumen).
        // createTable idempoten untuk upgrade bertahap v1/v2 -> v3.
        await m.createTable(pengaturan);
        await m.createTable(pengumuman);
        await m.createTable(agendaAkademik);
        await m.createTable(jadwalUjian);
        await m.createTable(prestasi);
        await m.createTable(edomPeriode);
        await m.createTable(edomPertanyaan);
        await m.createTable(edomPartisipasi);
        await m.createTable(edomJawaban);
        await m.createTable(dokumenArsip);
        await customStatement(
          "INSERT OR IGNORE INTO pengaturan (kunci, nilai, updated_at, device_id) "
          "VALUES ('syarat_sks_lulus', '144', "
          "strftime('%s','now'), 'seed');",
        );
      }
      if (from < 4) {
        await m.createTable(savedFilters);
      }
      if (from < 5) {
        await m.addColumn(dosens, dosens.waliUserId);
        // Preserve older advisor accounts in their dedicated slot.
        await customStatement(
          "UPDATE dosens SET wali_user_id = user_id, user_id = NULL "
          "WHERE user_id IN (SELECT id FROM users WHERE role = 'dosen_wali');",
        );
      }
      // Keep FTS/indexes idempotent for upgrades.
      await customStatement(kFtsTableDdl);
      await customStatement(kIdxMahasiswaAngkatanStatus);
      await customStatement(kIdxKrsMhs);
      await customStatement(kIdxNilaiKrs);
      await customStatement(kIdxPresensiSesi);
      await customStatement(kIdxJadwalUjianTanggalRuang);
      await customStatement(kIdxDokumenArsipMhs);
      await customStatement(kIdxPrestasiMhs);
      await customStatement(kIdxEdomJawabanPeriode);
      await customStatement(kTriggerMahasiswaInsert);
      await customStatement(kTriggerMahasiswaDelete);
      await customStatement(kTriggerMahasiswaUpdate);
      // Rebuild FTS last so rows written before the upgrade (or before
      // triggers existed) become searchable. Idempotent and cheap.
      await customStatement(
        "INSERT INTO mahasiswa_fts(mahasiswa_fts) VALUES('rebuild');",
      );
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );

  // -- Tahap A helpers (repositories/UI use these; UI never touches DAO) --

  Future<int> countMahasiswa({bool onlyActive = false}) {
    final q = selectOnly(mahasiswa)..addColumns([mahasiswa.id.count()]);
    q.where(mahasiswa.isDeleted.equals(false));
    if (onlyActive) {
      q.where(mahasiswa.status.equals('aktif'));
    }
    return q.map((row) => row.read(mahasiswa.id.count()) ?? 0).getSingle();
  }

  Future<({int total, int aktif, int prodi, int dosen, int kelas})>
  dashboardCounts() async {
    Future<int> count(
      TableInfo<Table, dynamic> table,
      GeneratedColumn<int> id,
    ) {
      return (selectOnly(table)..addColumns([id.count()]))
          .map((r) => r.read(id.count()) ?? 0)
          .getSingle();
    }

    final results = await Future.wait([
      countMahasiswa(),
      countMahasiswa(onlyActive: true),
      count(prodi, prodi.id),
      count(dosens, dosens.id),
      count(kelas, kelas.id),
    ]);
    return (
      total: results[0],
      aktif: results[1],
      prodi: results[2],
      dosen: results[3],
      kelas: results[4],
    );
  }

  /// Paginated + filtered mahasiswa list (lazy loading for big lists).
  Future<List<MahasiswaRow>> pagedMahasiswa({
    int limit = 20,
    int offset = 0,
    int? angkatan,
    String? status,
    int? prodiId,
    bool includeDeleted = false,
  }) {
    final q = select(mahasiswa)
      ..orderBy([(t) => OrderingTerm.asc(t.nama)])
      ..limit(limit, offset: offset);
    if (!includeDeleted) {
      q.where((t) => t.isDeleted.equals(false));
    }
    if (angkatan != null) {
      q.where((t) => t.angkatan.equals(angkatan));
    }
    if (status != null) {
      q.where((t) => t.status.equals(status));
    }
    if (prodiId != null) {
      q.where((t) => t.prodiId.equals(prodiId));
    }
    return q.get();
  }

  /// Full-text search on nim/nama via FTS5. Target <=500ms for 100 rows.
  /// Falls back to LIKE when the query contains FTS5 operators that would
  /// otherwise throw a syntax error (e.g. `-`, `*`, `(`, `:`).
  Future<List<MahasiswaRow>> searchMahasiswaFts(
    String query, {
    int limit = 20,
  }) async {
    final q = query.trim();
    if (q.isEmpty) return pagedMahasiswa(limit: limit);
    // Prefix match per token for "Ahm" -> "Ahmad*".
    final sanitized = q
        .replaceAll('"', '')
        .replaceAll("'", '')
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .map((t) => '"$t"*')
        .join(' OR ');
    try {
      final rows = await customSelect(
        'SELECT m.* FROM mahasiswa_fts f '
        'JOIN mahasiswa m ON m.id = f.rowid '
        'WHERE mahasiswa_fts MATCH ? AND m.is_deleted = 0 '
        'LIMIT ?',
        variables: [Variable.withString(sanitized), Variable.withInt(limit)],
        readsFrom: {mahasiswa},
      ).get();
      return rows.map((row) => mahasiswa.map(row.data)).toList();
    } catch (_) {
      final like = '%${q.replaceAll('%', '').replaceAll('_', '')}%';
      return (select(mahasiswa)
            ..where(
              (t) =>
                  t.isDeleted.equals(false) &
                  (t.nama.like(like) | t.nim.like(like)),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.nama)])
            ..limit(limit))
          .get();
    }
  }

  // -- Tahap D: nilai & kelulusan (dipakai halaman detail mahasiswa) --

  Future<MahasiswaRow?> getMahasiswa(int id) =>
      (select(mahasiswa)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Semua nilai milik satu mahasiswa (join KRS + Kelas + MK + Nilai).
  Future<List<KrsNilaiItem>> listNilaiMahasiswa(int mahasiswaId) async {
    final rows = await customSelect(
      'SELECT k.id AS krs_id, k.status AS krs_status, '
      'kl.id AS kelas_id, mk.kode AS mk_kode, mk.nama AS mk_nama, mk.sks AS sks, '
      'n.tugas AS tugas, n.uts AS uts, n.uas AS uas, '
      'n.nilai_akhir AS akhir, n.huruf AS huruf, n.bobot AS bobot '
      'FROM krs k '
      'JOIN kelas kl ON kl.id = k.kelas_id '
      'JOIN mata_kuliah mk ON mk.id = kl.mk_id '
      'LEFT JOIN nilai n ON n.krs_id = k.id '
      'WHERE k.mahasiswa_id = ? '
      'ORDER BY mk.kode ASC',
      variables: [Variable.withInt(mahasiswaId)],
      readsFrom: {krs, kelas, mataKuliah, nilai},
    ).get();
    return rows.map((r) {
      final d = r.data;
      return KrsNilaiItem(
        krsId: d['krs_id'] as int,
        krsStatus: (d['krs_status'] as String?) ?? 'diambil',
        kelasId: d['kelas_id'] as int,
        mkKode: (d['mk_kode'] as String?) ?? '-',
        mkNama: (d['mk_nama'] as String?) ?? '-',
        sks: (d['sks'] as int?) ?? 0,
        tugas: (d['tugas'] as num?)?.toDouble() ?? 0,
        uts: (d['uts'] as num?)?.toDouble() ?? 0,
        uas: (d['uas'] as num?)?.toDouble() ?? 0,
        akhir: (d['akhir'] as num?)?.toDouble() ?? 0,
        huruf: (d['huruf'] as String?) ?? 'E',
        bobot: (d['bobot'] as num?)?.toDouble() ?? 0,
        adaNilai: d['akhir'] != null,
      );
    }).toList();
  }

  /// Pilihan kelas untuk tambah KRS (1 baris per kelas + info MK).
  Future<List<KelasOption>> listKelasOptions() async {
    final rows = await customSelect(
      'SELECT kl.id AS id, mk.kode AS kode, mk.nama AS nama, mk.sks AS sks '
      'FROM kelas kl JOIN mata_kuliah mk ON mk.id = kl.mk_id '
      'ORDER BY mk.kode ASC',
      readsFrom: {kelas, mataKuliah},
    ).get();
    return rows.map((r) {
      final d = r.data;
      return KelasOption(
        kelasId: d['id'] as int,
        mkKode: d['kode'] as String,
        mkNama: d['nama'] as String,
        sks: d['sks'] as int,
      );
    }).toList();
  }

  Future<int> activeTahunAjaranId() async {
    final ta =
        await (select(tahunAjaran)
              ..where((t) => t.isActive.equals(true))
              ..limit(1))
            .getSingleOrNull();
    if (ta != null) return ta.id;
    final first = await (select(tahunAjaran)..limit(1)).getSingleOrNull();
    return first?.id ?? 1;
  }

  static ({double akhir, String huruf, double bobot}) hitungAkhir(
    double tugas,
    double uts,
    double uas,
  ) {
    final akhir = tugas * 0.3 + uts * 0.3 + uas * 0.4;
    final band = kGradeBands.firstWhere(
      (b) => akhir >= b.minScore,
      orElse: () => kGradeBands.last,
    );
    return (akhir: akhir, huruf: band.letter, bobot: band.weight);
  }

  /// Input / edit nilai: update baris nilai milik krsId (atau insert jika belum ada).
  Future<void> saveNilai({
    required int krsId,
    required double tugas,
    required double uts,
    required double uas,
  }) async {
    final h = hitungAkhir(tugas, uts, uas);
    final now = DateTime.now();
    final existing = await (select(
      nilai,
    )..where((t) => t.krsId.equals(krsId))).getSingleOrNull();
    if (existing == null) {
      await into(nilai).insert(
        NilaiCompanion.insert(
          krsId: krsId,
          tugas: Value(tugas),
          uts: Value(uts),
          uas: Value(uas),
          nilaiAkhir: Value(h.akhir),
          huruf: Value(h.huruf),
          bobot: Value(h.bobot),
          updatedAt: now,
          deviceId: 'input',
        ),
      );
    } else {
      await (update(nilai)..where((t) => t.krsId.equals(krsId))).write(
        NilaiCompanion(
          tugas: Value(tugas),
          uts: Value(uts),
          uas: Value(uas),
          nilaiAkhir: Value(h.akhir),
          huruf: Value(h.huruf),
          bobot: Value(h.bobot),
          updatedAt: Value(now),
        ),
      );
    }
  }

  /// Tambah MK ke mahasiswa (insert KRS + Nilai sekaligus).
  Future<int> addKrsNilai({
    required int mahasiswaId,
    required int kelasId,
    required double tugas,
    required double uts,
    required double uas,
  }) {
    return transaction(() async {
      // The selected class owns the term; never infer it from a global flag.
      final selected = await (select(
        kelas,
      )..where((k) => k.id.equals(kelasId))).getSingle();
      final taId = selected.taId;
      final now = DateTime.now();
      final krsId = await into(krs).insert(
        KrsCompanion.insert(
          mahasiswaId: mahasiswaId,
          kelasId: kelasId,
          taId: taId,
          updatedAt: now,
          deviceId: 'input',
        ),
      );
      final h = hitungAkhir(tugas, uts, uas);
      await into(nilai).insert(
        NilaiCompanion.insert(
          krsId: krsId,
          tugas: Value(tugas),
          uts: Value(uts),
          uas: Value(uas),
          nilaiAkhir: Value(h.akhir),
          huruf: Value(h.huruf),
          bobot: Value(h.bobot),
          updatedAt: now,
          deviceId: 'input',
        ),
      );
      return krsId;
    });
  }

  Future<void> deleteKrs(int krsId) {
    return transaction(() async {
      await (delete(nilai)..where((t) => t.krsId.equals(krsId))).go();
      await (delete(krs)..where((t) => t.id.equals(krsId))).go();
    });
  }

  // -- Pengaturan key-value (FR-51) --

  Future<String?> getSetting(String kunci) async {
    final row = await (select(
      pengaturan,
    )..where((t) => t.kunci.equals(kunci))).getSingleOrNull();
    return row?.nilai;
  }

  Future<int> getSyaratSksLulus() async {
    final v = await getSetting('syarat_sks_lulus');
    return int.tryParse(v ?? '') ?? 144;
  }

  Future<void> setSetting(String kunci, String nilai) {
    return transaction(() async {
      final now = DateTime.now();
      final existing = await (select(
        pengaturan,
      )..where((t) => t.kunci.equals(kunci))).getSingleOrNull();
      if (existing == null) {
        await into(pengaturan).insert(
          PengaturanCompanion.insert(
            kunci: kunci,
            nilai: nilai,
            updatedAt: now,
            deviceId: 'settings',
          ),
        );
      } else {
        await (update(pengaturan)..where((t) => t.kunci.equals(kunci))).write(
          PengaturanCompanion(nilai: Value(nilai), updatedAt: Value(now)),
        );
      }
    });
  }

  // -- CRUD mahasiswa (FR-07/08/09): NIM unik ditegakkan DB,
  // hapus = soft delete, sampah bisa dipulihkan. --

  /// Insert mahasiswa baru. Throws jika NIM sudah dipakai.
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
    try {
      return await into(mahasiswa).insert(
        MahasiswaCompanion.insert(
          nim: nim.trim(),
          nama: nama.trim(),
          prodiId: prodiId,
          angkatan: angkatan,
          status: Value(status),
          email: Value(email.trim()),
          noHp: Value(noHp.trim()),
          dosenWaliId: Value(dosenWaliId),
          updatedAt: DateTime.now(),
          deviceId: const Value('input'),
        ),
      );
    } catch (_) {
      throw Exception('NIM sudah dipakai.');
    }
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
    await (update(mahasiswa)..where((t) => t.id.equals(id))).write(
      MahasiswaCompanion(
        nama: Value(nama.trim()),
        prodiId: Value(prodiId),
        angkatan: Value(angkatan),
        status: Value(status),
        email: Value(email.trim()),
        noHp: Value(noHp.trim()),
        dosenWaliId: Value(dosenWaliId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete: baris tetap ada, disembunyikan dari list & FTS.
  Future<void> softDeleteMahasiswa(int id) async {
    await (update(mahasiswa)..where((t) => t.id.equals(id))).write(
      MahasiswaCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<List<MahasiswaRow>> listTrashMahasiswa() =>
      (select(mahasiswa)
            ..where((t) => t.isDeleted.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.nama)]))
          .get();

  Future<void> restoreMahasiswa(int id) async {
    await (update(mahasiswa)..where((t) => t.id.equals(id))).write(
      MahasiswaCompanion(
        isDeleted: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<List<ProdiRow>> listProdi() =>
      (select(prodi)..orderBy([(t) => OrderingTerm.asc(t.nama)])).get();

  Future<List<DosenRow>> listDosen() =>
      (select(dosens)..orderBy([(t) => OrderingTerm.asc(t.nama)])).get();
}

/// Satu baris KRS + Nilai untuk detail mahasiswa.
class KrsNilaiItem {
  const KrsNilaiItem({
    required this.krsId,
    required this.krsStatus,
    required this.kelasId,
    required this.mkKode,
    required this.mkNama,
    required this.sks,
    required this.tugas,
    required this.uts,
    required this.uas,
    required this.akhir,
    required this.huruf,
    required this.bobot,
    required this.adaNilai,
  });

  final int krsId;
  final String krsStatus;
  final int kelasId;
  final String mkKode;
  final String mkNama;
  final int sks;
  final double tugas;
  final double uts;
  final double uas;
  final double akhir;
  final String huruf;
  final double bobot;
  final bool adaNilai;

  /// Lulus MK jika huruf selain E (E = mengulang).
  bool get lulusMk => huruf != 'E';
}

class KelasOption {
  const KelasOption({
    required this.kelasId,
    required this.mkKode,
    required this.mkNama,
    required this.sks,
  });
  final int kelasId;
  final String mkKode;
  final String mkNama;
  final int sks;
}

/// Ringkasan IPK & syarat lulus.
class IpkRingkasan {
  const IpkRingkasan({
    required this.ipk,
    required this.sksTempuh,
    required this.sksLulus,
    required this.jumlahMk,
    required this.jumlahLulus,
  });
  final double ipk;
  final int sksTempuh;
  final int sksLulus;
  final int jumlahMk;
  final int jumlahLulus;

  static IpkRingkasan fromItems(List<KrsNilaiItem> items) {
    double totalBobotSks = 0;
    var sksTempuh = 0;
    var sksLulus = 0;
    var lulus = 0;
    for (final it in items) {
      if (!it.adaNilai) continue;
      sksTempuh += it.sks;
      totalBobotSks += it.bobot * it.sks;
      if (it.lulusMk) {
        sksLulus += it.sks;
        lulus++;
      }
    }
    final ipk = sksTempuh == 0 ? 0.0 : totalBobotSks / sksTempuh;
    return IpkRingkasan(
      ipk: ipk,
      sksTempuh: sksTempuh,
      sksLulus: sksLulus,
      jumlahMk: items.where((e) => e.adaNilai).length,
      jumlahLulus: lulus,
    );
  }
}
