# SIMAHA Offline

Aplikasi Flutter untuk mengelola data mahasiswa di perangkat dengan database SQLCipher terenkripsi, tanpa backend atau REST API.

**Status 20 Oktober 2026:** lima role tersedia dengan pemilih akun, halaman kelas/jadwal/rekap kehadiran, nilai/IPK, dan catatan bimbingan yang saling terhubung. Ruang demo berisi 5 dosen dan 10 mahasiswa siap login. Seluruh rancangan PRD belum selesai; input presensi, PDF, backup aplikasi, sinkronisasi, serta asisten masih memerlukan pengembangan.

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

Pilih role dan nama akun, lalu klik **Masuk akun demo**. PIN awal seluruh akun **123456**. Isi demo: 5 dosen, 10 mahasiswa, 5 kelas, nilai, rekap kehadiran, dan catatan bimbingan. Lihat [semua akun dan hubungan datanya](doct/demo/README.md). Gunakan **Ganti akun** dan **Semua fungsi peran** pada beranda.

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
