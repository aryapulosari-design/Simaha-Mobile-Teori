import 'dart:convert';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:simaha/core/config/app_runtime.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/domain/security/roles.dart';

const demoLecturers = [
  (
    slug: 'rahma',
    name: 'Rahma Hidayati',
    code: 'IF101',
    course: 'Algoritma dan Pemrograman',
    day: 'Senin',
  ),
  (
    slug: 'budi',
    name: 'Budi Santoso',
    code: 'IF102',
    course: 'Basis Data',
    day: 'Selasa',
  ),
  (
    slug: 'citra',
    name: 'Citra Lestari',
    code: 'IF103',
    course: 'Pemrograman Web',
    day: 'Rabu',
  ),
  (
    slug: 'dimas',
    name: 'Dimas Pratama',
    code: 'IF104',
    course: 'Rekayasa Perangkat Lunak',
    day: 'Kamis',
  ),
  (
    slug: 'nadia',
    name: 'Nadia Putri',
    code: 'IF105',
    course: 'Statistika Terapan',
    day: 'Jumat',
  ),
];
const demoStudents = [
  (slug: 'alya', name: 'Alya Putri'),
  (slug: 'arif', name: 'Arif Maulana'),
  (slug: 'bima', name: 'Bima Pratama'),
  (slug: 'bunga', name: 'Bunga Lestari'),
  (slug: 'cahya', name: 'Cahya Ramadhan'),
  (slug: 'citra', name: 'Citra Maharani'),
  (slug: 'deni', name: 'Deni Saputra'),
  (slug: 'dewi', name: 'Dewi Anggraini'),
  (slug: 'eka', name: 'Eka Wulandari'),
  (slug: 'fajar', name: 'Fajar Hidayat'),
  (slug: 'gilang', name: 'Gilang Ramadhan'),
  (slug: 'hana', name: 'Hana Safitri'),
  (slug: 'ilham', name: 'Ilham Akbar'),
  (slug: 'intan', name: 'Intan Permata'),
  (slug: 'joko', name: 'Joko Wibowo'),
  (slug: 'karina', name: 'Karina Putri'),
  (slug: 'luthfi', name: 'Luthfi Hakim'),
  (slug: 'maya', name: 'Maya Salsabila'),
  (slug: 'naufal', name: 'Naufal Rizki'),
  (slug: 'nisa', name: 'Nisa Azzahra'),
  (slug: 'oki', name: 'Oki Setiawan'),
  (slug: 'putri', name: 'Putri Amelia'),
  (slug: 'qori', name: 'Qori Annisa'),
  (slug: 'rafi', name: 'Rafi Prakoso'),
  (slug: 'rani', name: 'Rani Puspita'),
  (slug: 'rizal', name: 'Rizal Firmansyah'),
  (slug: 'salma', name: 'Salma Aulia'),
  (slug: 'satria', name: 'Satria Nugraha'),
  (slug: 'sinta', name: 'Sinta Maharani'),
  (slug: 'taufik', name: 'Taufik Hidayat'),
  (slug: 'tiara', name: 'Tiara Kirana'),
  (slug: 'umar', name: 'Umar Faruq'),
  (slug: 'vania', name: 'Vania Maharani'),
  (slug: 'wahyu', name: 'Wahyu Saputra'),
  (slug: 'winda', name: 'Winda Kartika'),
  (slug: 'yoga', name: 'Yoga Pratama'),
  (slug: 'zahra', name: 'Zahra Nabila'),
  (slug: 'zaki', name: 'Zaki Maulana'),
  (slug: 'adnan', name: 'Adnan Fikri'),
  (slug: 'aisha', name: 'Aisha Humaira'),
  (slug: 'bagas', name: 'Bagas Firmansyah'),
  (slug: 'bella', name: 'Bella Aprilia'),
  (slug: 'daniel', name: 'Daniel Wijaya'),
  (slug: 'dina', name: 'Dina Rahmawati'),
  (slug: 'farhan', name: 'Farhan Hadi'),
  (slug: 'fitri', name: 'Fitri Nuraini'),
  (slug: 'galih', name: 'Galih Pranata'),
  (slug: 'hasna', name: 'Hasna Khairunnisa'),
  (slug: 'irfan', name: 'Irfan Kurniawan'),
  (slug: 'jihan', name: 'Jihan Amalia'),
];

List<({String username, Role role})> get demoAccounts => [
  (username: 'superadmin', role: Role.superAdmin),
  (username: 'akademik', role: Role.adminAkademik),
  for (final lecturer in demoLecturers)
    (username: 'pengampu.${lecturer.slug}', role: Role.dosenPengampu),
  for (final lecturer in demoLecturers)
    (username: 'wali.${lecturer.slug}', role: Role.dosenWali),
  for (final student in demoStudents)
    (username: 'mhs.${student.slug}', role: Role.mahasiswa),
];

/// Only called for the explicitly selected demo database. Atomic and idempotent:
/// restarting preserves edits made while exploring roles.
Future<void> ensureDemoSeeded(AppDatabase db, {DateTime? referenceDate}) async {
  if (await db.getSetting('demo_dataset_version') == '2') return;
  final existing = await db
      .customSelect('SELECT COUNT(*) AS n FROM users')
      .getSingle();
  if (existing.read<int>('n') != 0 || await db.countMahasiswa() != 0) {
    throw StateError(
      'Ruang demo berisi data yang tidak dikenali. Data tidak ditimpa.',
    );
  }
  final hashes = await _buildDemoHashes();
  final now = referenceDate ?? DateTime.now();
  await db.transaction(() async {
    final userIds = <String, int>{};
    for (final account in demoAccounts) {
      final hash = hashes[account.username]!;
      userIds[account.username] = await db
          .into(db.users)
          .insert(
            UsersCompanion.insert(
              username: account.username,
              role: account.role.storageKey,
              pinHash: hash.encoded,
              salt: hash.salt,
              updatedAt: now,
              deviceId: 'demo',
            ),
          );
    }
    final prodi = await db
        .into(db.prodi)
        .insert(
          ProdiCompanion.insert(
            kode: 'IF',
            nama: 'Informatika',
            updatedAt: now,
            deviceId: 'demo',
          ),
        );
    final tahun = await db
        .into(db.tahunAjaran)
        .insert(
          TahunAjaranCompanion.insert(
            tahun: '2026/2027',
            semester: 1,
            isActive: const Value(true),
            updatedAt: now,
            deviceId: 'demo',
          ),
        );
    final dosenIds = <int>[];
    final classIds = <int>[];
    for (var i = 0; i < demoLecturers.length; i++) {
      final d = demoLecturers[i];
      final dosen = await db
          .into(db.dosens)
          .insert(
            DosensCompanion.insert(
              nidn: 'DEMO${(i + 1).toString().padLeft(4, '0')}',
              nama: d.name,
              userId: Value(userIds['pengampu.${d.slug}']),
              waliUserId: Value(userIds['wali.${d.slug}']),
              prodiId: prodi,
              updatedAt: now,
              deviceId: 'demo',
            ),
          );
      dosenIds.add(dosen);
      final mk = await db
          .into(db.mataKuliah)
          .insert(
            MataKuliahCompanion.insert(
              kode: d.code,
              nama: d.course,
              sks: 3,
              semester: 1,
              prodiId: prodi,
              updatedAt: now,
              deviceId: 'demo',
            ),
          );
      classIds.add(
        await db
            .into(db.kelas)
            .insert(
              KelasCompanion.insert(
                mkId: mk,
                dosenId: dosen,
                taId: tahun,
                hari: d.day,
                jamMulai: '08:00',
                jamSelesai: '10:30',
                ruang: Value('IF-${i + 1}01'),
                updatedAt: now,
                deviceId: 'demo',
              ),
            ),
      );
    }
    const baseScores = [
      90.0,
      84.0,
      78.0,
      70.0,
      88.0,
      82.0,
      65.0,
      55.0,
      80.0,
      75.0,
    ];
    final studentIds = <int>[];
    for (var i = 0; i < demoStudents.length; i++) {
      final student = demoStudents[i];
      final dosen = dosenIds[(i % 10) ~/ 2];
      final id = await db
          .into(db.mahasiswa)
          .insert(
            MahasiswaCompanion.insert(
              nim: '2026IF${(i + 1).toString().padLeft(3, '0')}',
              nama: student.name,
              prodiId: prodi,
              angkatan: 2026,
              email: Value('${student.slug}@student.example'),
              noHp: Value('08120000${(i + 1).toString().padLeft(4, '0')}'),
              dosenWaliId: Value(dosen),
              userId: Value(userIds['mhs.${student.slug}']),
              updatedAt: now,
              deviceId: const Value('demo'),
            ),
          );
      studentIds.add(id);
      for (var j = 0; j < classIds.length; j++) {
        final score = baseScores[i % baseScores.length] + (j % 3) * 2;
        await db.addKrsNilai(
          mahasiswaId: id,
          kelasId: classIds[j],
          tugas: score,
          uts: score - 2,
          uas: score + 1,
        );
      }
      await db
          .into(db.catatanBimbingan)
          .insert(
            CatatanBimbinganCompanion.insert(
              mahasiswaId: id,
              dosenId: dosen,
              isi: baseScores[i % baseScores.length] < 70
                  ? 'Evaluasi awal semester: perlu pendampingan pada latihan dan konsistensi belajar.'
                  : 'Rencana studi 15 SKS telah ditinjau. Mahasiswa mengikuti lima mata kuliah semester ini.',
              tindakLanjut: Value(
                baseScores[i % baseScores.length] < 70
                    ? 'Kerjakan latihan tambahan dan jadwalkan bimbingan pekan depan.'
                    : 'Pertahankan kehadiran dan selesaikan tugas mingguan tepat waktu.',
              ),
              tanggal: now.subtract(const Duration(days: 3)),
              updatedAt: now,
              deviceId: 'demo',
            ),
          );
    }
    // Three meetings per course. All students are registered in all five classes.
    for (var j = 0; j < classIds.length; j++) {
      for (var meeting = 1; meeting <= 3; meeting++) {
        final date = now.subtract(Duration(days: (4 - meeting) * 7 + j));
        final session = await db
            .into(db.sesiPresensi)
            .insert(
              SesiPresensiCompanion.insert(
                kelasId: classIds[j],
                pertemuanKe: meeting,
                tanggal: date,
                qrSecret: 'demo-class-${j + 1}-meeting-$meeting',
                updatedAt: now,
                deviceId: 'demo',
              ),
            );
        for (var i = 0; i < studentIds.length; i++) {
          final status = i == 7 && meeting == 2
              ? 'alpa'
              : i == 6 && meeting == 3
              ? 'izin'
              : 'hadir';
          await db
              .into(db.presensi)
              .insert(
                PresensiCompanion.insert(
                  sesiId: session,
                  mahasiswaId: studentIds[i],
                  status: status,
                  waktu: date,
                  updatedAt: now,
                  deviceId: 'demo',
                ),
              );
        }
      }
    }
    for (final notice in [
      (title: 'Selamat datang di semester Gasal', body: 'Periksa jadwal dan lima mata kuliah Anda. Hubungi dosen wali untuk mendiskusikan rencana studi.', category: 'akademik'),
      (title: 'Bimbingan akademik pekan ini', body: 'Mahasiswa dapat membaca arahan wali pada profil masing-masing. Siapkan daftar pertanyaan sebelum pertemuan.', category: 'bimbingan'),
    ]) {
      await db.into(db.pengumuman).insert(PengumumanCompanion.insert(
        judul: notice.title, isi: notice.body, kategori: Value(notice.category),
        dibuatOleh: Value(userIds['akademik']), updatedAt: now, deviceId: 'demo',
      ));
    }
    await db.setSetting('demo_dataset_version', '2');
    await db.setSetting('demo_label', 'Kelas Informatika · 2026/2027 Gasal');
    await db
        .into(db.auditLog)
        .insert(
          AuditLogCompanion.insert(
            userId: Value(userIds['superadmin']),
            aksi: 'SEED_DEMO',
            entitas: 'DEMO',
            sesudah: const Value(
              '62 akun, 5 dosen, 50 mahasiswa, 5 kelas, 250 KRS/nilai, 15 pertemuan, 750 presensi, 50 catatan bimbingan.',
            ),
            waktu: now,
          ),
        );
  });
}

Future<Map<String, ({String encoded, String salt})>> _buildDemoHashes() async {
  return Isolate.run(() async {
    final crypto = CryptoService();
    final result = <String, ({String encoded, String salt})>{};
    for (final account in demoAccounts) {
      final hash = await crypto.hashPin(AppRuntime.demoPin);
      result[account.username] = (
        encoded: hash.encode(),
        salt: base64Encode(hash.salt),
      );
    }
    return result;
  });
}
