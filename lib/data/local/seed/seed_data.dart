// Deterministic dummy seeder: 100 mahasiswa + related academic data.
// Runs data generation in Isolate.run (heavy work off UI thread) and
// inserts everything inside a single transaction (atomic).
import 'dart:isolate';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/data/local/app_database.dart';

class SeedStats {
  const SeedStats({
    required this.mahasiswa,
    required this.krs,
    required this.nilai,
    required this.kelas,
  });
  final int mahasiswa;
  final int krs;
  final int nilai;
  final int kelas;
}

/// Public entry: seeds only when DB is empty. Idempotent.
Future<SeedStats?> ensureSeeded(AppDatabase db) async {
  final existing = await (db.selectOnly(db.mahasiswa)..addColumns([db.mahasiswa.id.count()]))
      .map((r) => r.read(db.mahasiswa.id.count()) ?? 0).getSingle();
  if (existing > 0) return null;
  return seedDatabase(db);
}

/// Full seed (used by app bootstrap and tests).
Future<SeedStats> seedDatabase(
  AppDatabase db, {
  int mahasiswaCount = 100,
  int seed = 42,
}) async {
  // NOTE: must go through _buildPayloadInIsolate (separate activation with
  // only sendable params). Calling Isolate.run with a closure directly here
  // would capture `db` (FfiDatabase is unsendable) and throw.
  final payload = await _buildPayloadInIsolate(mahasiswaCount, seed);

  var krsCount = 0;
  var nilaiCount = 0;

  await db.transaction(() async {
    // Single stamp for the whole seed: writers always stamp explicitly
    // (sync columns are required, no defaults).
    final now = DateTime.now();
    // -- master: prodi --
    final prodiIds = <int>[];
    for (final p in payload['prodi']!) {
      prodiIds.add(
        await db
            .into(db.prodi)
            .insert(
              ProdiCompanion.insert(
                kode: p['kode']! as String,
                nama: p['nama']! as String,
                updatedAt: now,
                deviceId: 'seed',
              ),
            ),
      );
    }

    // NOTE: no seeded login account. The Super Admin is created only via
    // the setup wizard (Tahap B), so a fresh install always shows setup
    // first and no default credential ever exists.

    // -- dosen (2 per prodi) --
    final dosenIds = <int>[];
    for (final d in payload['dosen']!) {
      dosenIds.add(
        await db
            .into(db.dosens)
            .insert(
              DosensCompanion.insert(
                nidn: d['nidn']! as String,
                nama: d['nama']! as String,
                prodiId: prodiIds[d['prodiIdx']! as int],
                updatedAt: now,
                deviceId: 'seed',
              ),
            ),
      );
    }

    // -- tahun ajaran --
    final taActiveId = await db
        .into(db.tahunAjaran)
        .insert(
          TahunAjaranCompanion.insert(
            tahun: '2024/2025',
            semester: 1,
            isActive: const Value(true),
            updatedAt: now,
            deviceId: 'seed',
          ),
        );
    final taGenapId = await db
        .into(db.tahunAjaran)
        .insert(
          TahunAjaranCompanion.insert(
            tahun: '2024/2025',
            semester: 2,
            updatedAt: now,
            deviceId: 'seed',
          ),
        );
    // Use genap id to avoid unused warning in future analytics.
    assert(taGenapId > 0);

    // -- mata kuliah (3 per prodi = 12) --
    final mkIds = <int>[];
    final mkSks = <int>[];
    final mkProdiIdx = <int>[];
    for (final m in payload['mk']!) {
      mkProdiIdx.add(m['prodiIdx']! as int);
      mkSks.add(m['sks']! as int);
      mkIds.add(
        await db
            .into(db.mataKuliah)
            .insert(
              MataKuliahCompanion.insert(
                kode: m['kode']! as String,
                nama: m['nama']! as String,
                sks: m['sks']! as int,
                semester: m['semester']! as int,
                prodiId: prodiIds[m['prodiIdx']! as int],
                updatedAt: now,
                deviceId: 'seed',
              ),
            ),
      );
    }

    // -- prasyarat (4 rows, within same prodi) --
    final prasyaratPairs = <List<int>>[
      [1, 0],
      [2, 1],
      [4, 3],
      [7, 6],
    ];
    for (final pair in prasyaratPairs) {
      await db
          .into(db.prasyaratMk)
          .insert(
            PrasyaratMkCompanion.insert(
              mkId: mkIds[pair[0]],
              prasyaratMkId: mkIds[pair[1]],
              updatedAt: now,
              deviceId: 'seed',
            ),
          );
    }

    // -- kelas (1 per MK for active TA = 12) --
    final kelasIds = <int>[];
    const hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
    for (var i = 0; i < mkIds.length; i++) {
      kelasIds.add(
        await db
            .into(db.kelas)
            .insert(
              KelasCompanion.insert(
                mkId: mkIds[i],
                dosenId:
                    dosenIds[(mkProdiIdx[i] * 2 + (i % 2)) % dosenIds.length],
                taId: taActiveId,
                hari: hari[i % hari.length],
                jamMulai: '${(8 + (i % 4) * 2).toString().padLeft(2, '0')}:00',
                jamSelesai:
                    '${(10 + (i % 4) * 2).toString().padLeft(2, '0')}:00',
                ruang: Value('R.10${i + 1}'),
                updatedAt: now,
                deviceId: 'seed',
              ),
            ),
      );
    }

    // -- mahasiswa (100) --
    final mhsIds = <int>[];
    final mhsProdiDbIdx = <int>[];
    await db.batch((b) {
      for (final m in payload['mhs']!) {
        mhsProdiDbIdx.add(m['prodiIdx']! as int);
        b.insert(
          db.mahasiswa,
          MahasiswaCompanion.insert(
            nim: m['nim']! as String,
            nama: m['nama']! as String,
            prodiId: prodiIds[m['prodiIdx']! as int],
            angkatan: m['angkatan']! as int,
            status: Value(m['status']! as String),
            email: Value(m['email']! as String),
            noHp: Value(m['noHp']! as String),
            dosenWaliId: Value(
              dosenIds[(m['prodiIdx']! as int) * 2 + (m['seq']! as int) % 2],
            ),
            updatedAt: now,
            deviceId: const Value('seed'),
          ),
        );
      }
    });
    // Re-read ids (batch doesn't return them) in nim order.
    final inserted = await (db.select(
      db.mahasiswa,
    )..orderBy([(t) => OrderingTerm.asc(t.nim)])).get();
    mhsIds.addAll(inserted.map((e) => e.id));

    // -- krs + nilai: only for aktif students, 3 kelas of own prodi --
    final mhsRows = inserted;
    for (var i = 0; i < mhsRows.length; i++) {
      final m = mhsRows[i];
      if (m.status != 'aktif') continue;
      final pIdx = mhsProdiDbIdx[i];
      // kelas indices belonging to this prodi: mk 3 per prodi.
      final kelasForProdi = <int>[];
      for (var k = 0; k < mkIds.length; k++) {
        if (mkProdiIdx[k] == pIdx) kelasForProdi.add(kelasIds[k]);
      }
      final take = kelasForProdi.take(3);
      for (final kId in take) {
        final krsId = await db
            .into(db.krs)
            .insert(
              KrsCompanion.insert(
                mahasiswaId: m.id,
                kelasId: kId,
                taId: taActiveId,
                updatedAt: now,
                deviceId: 'seed',
              ),
            );
        krsCount++;
        final n = payload['nilai']![krsCount % payload['nilai']!.length];
        final tugas = (n['tugas']! as num).toDouble();
        final uts = (n['uts']! as num).toDouble();
        final uas = (n['uas']! as num).toDouble();
        // Default weights 30/30/40 (documented; Tahap H makes them tunable).
        final akhir = tugas * 0.3 + uts * 0.3 + uas * 0.4;
        final band = kGradeBands.firstWhere(
          (b) => akhir >= b.minScore,
          orElse: () => kGradeBands.last,
        );
        await db
            .into(db.nilai)
            .insert(
              NilaiCompanion.insert(
                krsId: krsId,
                tugas: Value(tugas),
                uts: Value(uts),
                uas: Value(uas),
                nilaiAkhir: Value(akhir),
                huruf: Value(band.letter),
                bobot: Value(band.weight),
                updatedAt: now,
                deviceId: 'seed',
              ),
            );
        nilaiCount++;
      }
    }

    // -- sesi presensi: 1 sesi per kelas + presensi for enrolled --
    for (final kId in kelasIds) {
      final sesiId = await db
          .into(db.sesiPresensi)
          .insert(
            SesiPresensiCompanion.insert(
              kelasId: kId,
              pertemuanKe: 1,
              tanggal: now,
              qrSecret: 'seed-secret-$kId',
              updatedAt: now,
              deviceId: 'seed',
            ),
          );
      final enrolled = await (db.select(
        db.krs,
      )..where((t) => t.kelasId.equals(kId))).get();
      for (final e in enrolled) {
        await db
            .into(db.presensi)
            .insert(
              PresensiCompanion.insert(
                sesiId: sesiId,
                mahasiswaId: e.mahasiswaId,
                status: 'hadir',
                waktu: now,
                updatedAt: now,
                deviceId: 'seed',
              ),
            );
      }
    }
  });

  final total = await db.countMahasiswa();
  return SeedStats(
    mahasiswa: total,
    krs: krsCount,
    nilai: nilaiCount,
    kelas: 12,
  );
}

// -- Pure payload builder (runs inside Isolate, must stay sendable) --

/// Isolate entry: separate activation so the closure only captures two ints
/// (sendable). Never pass `db` or Drift objects across isolates.
Future<Map<String, List<Map<String, Object?>>>> _buildPayloadInIsolate(
  int count,
  int seed,
) {
  return Isolate.run(() => buildSeedPayload(count, seed));
}

/// Builds plain maps only (no Drift types) so it can run in Isolate.run.
Map<String, List<Map<String, Object?>>> buildSeedPayload(int count, int seed) {
  final rnd = Random(seed);
  const first = [
    'Ahmad',
    'Budi',
    'Citra',
    'Dewi',
    'Eka',
    'Fajar',
    'Gita',
    'Hendra',
    'Intan',
    'Joko',
    'Kartika',
    'Lukman',
    'Maya',
    'Nadia',
    'Putri',
    'Rizky',
    'Sari',
    'Tono',
    'Utami',
    'Wahyu',
    'Yoga',
    'Zahra',
    'Andi',
    'Fitri',
    'Rudi',
    'Nina',
    'Dian',
    'Bayu',
    'Lina',
    'Agus',
  ];
  const last = [
    'Santoso',
    'Pratama',
    'Wijaya',
    'Kusuma',
    'Rahmawati',
    'Saputra',
    'Hidayat',
    'Nugroho',
    'Setiawan',
    'Anggraini',
    'Puspita',
    'Ramadhan',
    'Firmansyah',
    'Lestari',
    'Utama',
    'Maharani',
    'Gunawan',
    'Halim',
    'Siregar',
    'Nasution',
    'Pangestu',
    'Wibowo',
    'Kurniawan',
    ' Amelia',
  ];

  final prodi = [
    {'kode': 'IF', 'nama': 'Informatika'},
    {'kode': 'SI', 'nama': 'Sistem Informasi'},
    {'kode': 'BD', 'nama': 'Bisnis Digital'},
    {'kode': 'MI', 'nama': 'Manajemen Informatika'},
  ];

  final dosen = List.generate(8, (i) {
    final p = i ~/ 2;
    return {
      'nidn': '1980010${(i + 1).toString().padLeft(2, '0')}001',
      'nama': '${first[(i * 3) % first.length]} ${last[(i * 5) % last.length]}',
      'prodiIdx': p,
    };
  });

  final mkNames = [
    ['IF101', 'Algoritma dan Pemrograman', 3, 1],
    ['IF102', 'Struktur Data', 3, 2],
    ['IF201', 'Basis Data', 3, 3],
    ['SI101', 'Pengantar Sistem Informasi', 3, 1],
    ['SI102', 'Analisis Proses Bisnis', 3, 2],
    ['SI201', 'ERP dan Sistem Enterprise', 2, 3],
    ['BD101', 'Pengantar Bisnis Digital', 2, 1],
    ['BD102', 'Pemasaran Digital', 3, 2],
    ['BD201', 'Analitik Bisnis', 3, 3],
    ['MI101', 'Logika Informatika', 2, 1],
    ['MI102', 'Pemrograman Web', 3, 2],
    ['MI201', 'Jaringan Komputer', 3, 3],
  ];
  final mk = List.generate(mkNames.length, (i) {
    return {
      'kode': mkNames[i][0] as String,
      'nama': mkNames[i][1] as String,
      'sks': mkNames[i][2] as int,
      'semester': mkNames[i][3] as int,
      'prodiIdx': i ~/ 3,
    };
  });

  // Status distribution for 100: 82 aktif, 8 cuti, 5 nonaktif, 3 lulus, 2 do.
  final statusPool = <String>[
    ...List.filled(82, 'aktif'),
    ...List.filled(8, 'cuti'),
    ...List.filled(5, 'nonaktif'),
    ...List.filled(3, 'lulus'),
    ...List.filled(2, 'do'),
  ]..shuffle(rnd);

  final angkatanPool = [2021, 2022, 2023, 2024];

  final mhs = List.generate(count, (i) {
    final pIdx = i % 4;
    final angkatan = angkatanPool[i % angkatanPool.length];
    final nama =
        '${first[rnd.nextInt(first.length)]} ${last[rnd.nextInt(last.length)]}';
    final nim =
        '$angkatan${(pIdx + 1).toString().padLeft(2, '0')}${(i + 1).toString().padLeft(4, '0')}';
    final clean = nama.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
    return {
      'nim': nim,
      'nama': nama,
      'prodiIdx': pIdx,
      'angkatan': angkatan,
      'status': statusPool[i % statusPool.length],
      'email': '$clean$i@student.uin.ac.id',
      'noHp': '0812${(1000000 + rnd.nextInt(8999999)).toString()}',
      'seq': i,
    };
  });

  // Pre-generated nilai triples (deterministic).
  final nilai = List.generate(40, (_) {
    return {
      'tugas': 60 + rnd.nextDouble() * 40,
      'uts': 55 + rnd.nextDouble() * 45,
      'uas': 55 + rnd.nextDouble() * 45,
    };
  });

  return {'prodi': prodi, 'dosen': dosen, 'mk': mk, 'mhs': mhs, 'nilai': nilai};
}
