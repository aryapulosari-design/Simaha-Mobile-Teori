# SIMAHA Offline

Aplikasi Flutter untuk mengelola data mahasiswa di perangkat dengan database SQLCipher terenkripsi, tanpa backend atau REST API.

**Status 21 Oktober 2026:** Lima dashboard, 50 mahasiswa demo dan 5 dosen saling terhubung. Tersedia pemilih akun, nilai/IPK, jadwal, presensi manual dan rekap, bimbingan, pengumuman, insight studi, audit terbatas, PDF hasil studi, serta CRUD master melalui Akademik → Data master. Penambahan KRS memeriksa semester, IPS sebelumnya, batas SKS, prasyarat dan bentrok jadwal. Scope kandidat berfokus pada alur lima role yang bisa dipakai; QR, backup/restore, sinkronisasi dan asisten masih di luar alur lengkap.

## Laporan Tahap 4 dan Tahap 5

[Laporan dan matriks luaran](doct/laporan/README.md) memuat kasus uji, hasil aktual, temuan/perbaikan, rancangan uji pengguna, bahan presentasi, dan naskah video. Uji calon pengguna belum dilaksanakan; 50 mahasiswa demo bukan responden.

## Dokumentasi

Mulai dari **[doct/README.md](doct/README.md)**.

| Kebutuhan | Panduan |
|---|---|
| Instalasi dan menjalankan aplikasi | [Setup](doct/setup/README.md) |
| Fitur yang tersedia dan cara memakainya | [Fitur](doct/features/README.md) |
| Penjelasan lima role dan hak akses | [Role](doct/roles/README.md) |
| Struktur kode dan database | [Arsitektur](doct/architecture/README.md) |
| PIN, enkripsi, pemulihan, batas keamanan | [Keamanan](doct/security/README.md) |
| Sistem desain dan pratinjau UI | [Desain](doct/design/README.md) |
| Pengujian dan reproduksi hasil | [Pengujian](doct/testing/README.md) |
| Kesesuaian seluruh FR/NFR dan pekerjaan tersisa | [Audit](doct/audit/README.md) |
| PRD serta prompt asli sebelum audit | [Arsip rancangan](doct/prd/README.md) |

## Demo siap dicoba

```sh
flutter run -d windows --dart-define=SIMAHA_DEMO=true
```

Pilih role dan nama akun, lalu klik **Masuk akun demo**. PIN awal seluruh akun **123456**. Isi demo: 5 dosen, 50 mahasiswa, 5 kelas, nilai, rekap kehadiran, dan catatan bimbingan. Lihat [semua akun dan hubungan datanya](doct/demo/README.md). Gunakan **Ganti akun** dan **Semua fungsi peran** pada beranda.

## Jalankan mode biasa

Prasyarat: Flutter dengan Dart **3.13.2 atau versi kompatibel**, toolchain platform, serta dependensi native. Android minimum API 26. Windows dapat dipakai untuk pengembangan. Bootstrap saat ini memakai `dart:io` dan database native; target web belum didukung.

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Pada mode biasa, pemasangan baru menambahkan **100 data mahasiswa dummy** dan data akademik terkait. Buat PIN enam digit untuk akun `superadmin`, simpan kode pemulihan, lalu buat akun lain di **Kelola akun**. Untuk akun dosen/mahasiswa, gunakan **Hubungkan profil** agar data tersedia sesuai perannya. Pada halaman login, pilih peran dan akun dari daftar, lalu isi PIN; username tidak perlu diketik. PIN mode biasa ditentukan saat setup. Akun/PIN demo hanya tersedia pada ruang demo.

Dependensi memerlukan internet saat disiapkan; alur aplikasi yang tersedia berjalan lokal. Paket di `pubspec.yaml` atau tabel database yang sudah ada tidak otomatis berarti fiturnya selesai. Gunakan [audit](doct/audit/README.md) sebagai status implementasi terkini.
