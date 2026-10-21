# Arsitektur dan data

## Alur aplikasi

```text
main()
  → ambil/buat key dari secure storage
  → buka Drift + SQLCipher
  → migrasi schema dan seeding bila tabel mahasiswa belum memiliki baris
  → tentukan gate setup atau lock
  → ProviderScope → MaterialApp.router
  → Session → Router → UI sesuai role
  → AcademicService/AuthService → AppDatabase → file lokal
```

Tidak ada backend/REST API pada alur ini. Database produksi menggunakan executor native, bukan database web.

## Struktur penting

| Lokasi | Tanggung jawab |
|---|---|
| `lib/main.dart` | Bootstrap database, seeder, auth, provider, tema/router. |
| `lib/core/router` | Navigasi, gate autentikasi, akses halaman admin, provider lifecycle router. |
| `lib/core/theme` | Tema Material 3, warna, tipografi, komponen. |
| `lib/core/security` | Gate, channel FLAG_SECURE, wrapper halaman sensitif. |
| `lib/data/local/tables.dart` | Deklarasi tabel Drift. |
| `lib/data/local/app_database.dart` | Schema/migrasi, query, persistence CRUD, FTS dan trigger. |
| `lib/data/local/connection` | Pengelolaan key dan executor SQLCipher. |
| `lib/core/config/app_runtime.dart` | Flag compile-time SIMAHA_DEMO dan nama database demo. |
| `lib/data/local/seed/demo_seed.dart` | Seeder atomik/idempoten untuk 62 akun, 5 dosen, 50 mahasiswa, dan seluruh relasinya. |
| `lib/data/local/seed` | Data dummy deterministik dengan pembuatan payload di isolate. |
| `lib/data/services/auth_service.dart` | Setup, PIN, lockout, recovery, pengelolaan/pengaitan akun. |
| `lib/data/services/academic_service.dart` | Batas akses mahasiswa/nilai, izin mutasi, validasi input. |
| `lib/data/services/backup_service.dart` | Enkripsi/dekripsi bytes; belum snapshot/restore database. |
| `lib/domain` | Perhitungan nilai/risiko, parser intent/CSV, token QR, merge sync, permission. |
| `lib/presentation/features` | Halaman auth, beranda, mahasiswa, nilai, pengaturan, database. |
| `lib/presentation/providers` | Session, service, hasil pencarian/statistik, tema. |
| `lib/presentation/shared/widgets` | Shell, komponen, auto-lock, status/empty/error/loading. |
| `lib/services/audit` | Penulis audit log lokal. |
| `test` | Unit, service, keamanan, migrasi, widget, scope dan layout. |

Arsitektur belum sepenuhnya Clean Architecture: UI masih memakai row Drift, beberapa pengambilan master/pengaturan langsung melalui DB, repository interface/use case belum menjadi lapisan penuh. `AcademicService` merupakan batas aplikasi untuk data mahasiswa dan nilai; database mentah tetap untuk kebutuhan internal.

## Schema versi 5

Kelompok tabel:

- Keamanan: users, audit_log.
- Akademik: prodi, dosens, mahasiswa, tahun_ajaran, mata_kuliah, prasyarat_mk, kelas, krs, nilai.
- Kehadiran/bimbingan: sesi_presensi, presensi, catatan_bimbingan, peringatan.
- Sistem: pengaturan, sync_log, saved_filters.
- Modul lanjutan: pengumuman, agenda_akademik, jadwal_ujian, prestasi, edom_periode, edom_pertanyaan, edom_partisipasi, edom_jawaban, dokumen_arsip.

Sumber nama/kolom definitif adalah `tables.dart` dan schema hasil Drift; beberapa nama fisik mengikuti konvensi generator (misalnya `dosens`). Keberadaan tabel tidak berarti UI modul tersedia.

Hubungan scope:

```text
Mahasiswa : mahasiswa.user_id → users.id
Wali      : mahasiswa.dosen_wali_id → dosens.id → dosens.user_id
Pengampu  : mahasiswa → krs → kelas.dosen_id → dosens.user_id
```

NIM unik ditegakkan database. Soft delete memakai `is_deleted`. Trigger insert/update/delete menjaga indeks FTS5; filter query menyembunyikan data arsip. Tidak boleh menambah entri FTS manual lagi saat soft delete/restore karena trigger sudah memperbaruinya.

Versi 5 menambah dosens.wali_user_id. Migrasi memindahkan akun dosen wali lama ke slot tersebut, sementara akun Pengampu tetap pada user_id. Nama profil login dicari pada kedua slot. Namespace secure storage memisahkan preferensi/kode pemulihan demo dari mode biasa. Halaman Akademik dan detail kelas mengambil roster/nilai/rekap dengan scope yang sama; bimbingan dicatat dalam transaksi bersama audit log.

## Perhitungan akademik

```text
nilai akhir = 0.30 × tugas + 0.30 × UTS + 0.40 × UAS
A ≥85 →4.0; AB ≥80 →3.5; B ≥75 →3.0; BC ≥70 →2.5
C ≥60 →2.0; D ≥50 →1.0; E <50 →0.0
IPK = Σ(bobot × SKS) / Σ(SKS), nilai terbaik per kode MK
```

IPS tersedia pada domain melalui kelompok semester. Batas SKS domain: semester pertama 20; IPS ≥3.00:24, ≥2.50:21, ≥2.00:18, di bawahnya:15. Alur tambah KRS di UI belum sepenuhnya menggunakan aturan semester ini; lihat audit FR-13/14.

## Menambah fitur

Fitur baru perlu mendefinisikan scope dan permission, mengotorisasi di service, menjaga transaksi multi-tabel, menyediakan loading/error/empty state, dan menguji akses di luar scope. Pengembangan schema perlu migrasi, bukan menghapus database pengguna. Status harus diperbarui pada fitur dan audit setelah alur benar-benar terhubung.

## Struktur kandidat 21 Oktober 2026

`WorkspaceStorage` mengatur berkas, executor dan store sesuai mode; `DemoStore` hanya untuk data sintetis. `InsightsService` menyusun metrik dari pembacaan AcademicService yang dibatasi scope; `CampusService` menangani pengumuman, sesi/presensi dan audit; `StudyExportService` menghasilkan PDF setelah otorisasi. Komponen `BentoCard`, `BentoGrid`, `MetricTile` dan `ContextTag` dipakai ulang pada presentasi. Domain `StudentInsight` tidak bergantung Flutter atau Drift.

PDF report dibangun secara reproduktif dari `tools/build_project_report.py`, membaca log tes/build aktual. Paket yang belum dipakai dihapus dari dependensi langsung; fondasi domain yang belum menjadi fitur pengguna tetap dicatat sebagai gap.
