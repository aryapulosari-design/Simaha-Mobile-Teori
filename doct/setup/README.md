# Instalasi dan menjalankan

## Persyaratan

- Flutter dengan Dart 3.13.2 atau yang memenuhi `sdk: ^3.13.2`.
- Android: SDK, JDK 17, emulator/perangkat Android 8.0/API 26 ke atas.
- Windows: Visual Studio, workload Desktop development with C++, Windows SDK.
- Internet untuk dependency dan native assets pada persiapan/build pertama.
- Direktori SDK Flutter/cache dapat ditulis oleh akun yang menjalankan tool.

Tidak perlu server, database eksternal, akun cloud, `.env`, REST API, atau API key.

```sh
flutter doctor -v
flutter pub get
flutter devices
flutter run -d <device-id>
```

Pilih ID dari `flutter devices`, misalnya `windows`. Target utama Android; direktori iOS/macOS/Linux ada tetapi belum diuji dalam audit ini. Web belum didukung oleh bootstrap database native.

## Ruang demo yang sudah terisi

```sh
flutter run -d windows --dart-define=SIMAHA_DEMO=true
```

Pilih role, pilih nama, lalu Masuk akun demo. PIN awal 123456. Database simaha_demo_50.db dibuat terpisah, bersama preferensi demo khusus data sintetis. Pembuatan pertama hingga beberapa menit pada perangkat lambat; berikutnya memakai data yang sama. Panduan lengkap: [demo](../demo/README.md).

## Pemasangan pertama pada mode biasa

1. Aplikasi membuka/membuat `simaha.db` terenkripsi dalam direktori dokumen aplikasi.
2. Seeder membuat 100 mahasiswa dummy beserta master akademik jika tabel mahasiswa belum mempunyai baris, termasuk baris arsip.
3. Buat PIN enam angka untuk username `superadmin`.
4. Simpan kode pemulihan yang ditampilkan satu kali.
5. Buat akun lain melalui Kelola akun dengan role dan PIN masing-masing.
6. Pada kartu akun mahasiswa/dosen, pilih **Hubungkan profil**, cari nama/NIM/NIDN, lalu pilih profil yang sesuai.
7. Kunci aplikasi, pilih peran dan akun dari daftar, lalu masukkan PIN akun baru.

Profil yang ditempati akun lain tidak bisa diambil alih. Hubungan dosen wali dipilih di form mahasiswa. Hubungan dosen pengampu mengikuti master kelas dan KRS yang tersimpan.

## Generate database dan verifikasi

Jalankan generator setelah mengubah deklarasi tabel/config Drift:

```sh
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

`lib/data/local/app_database.g.dart` adalah hasil generator. Schema saat ini versi 5; perubahan schema harus memiliki migrasi untuk instalasi yang sudah ada.

```sh
flutter build apk --release
flutter build windows --release
```

Hasil build yang benar-benar dijalankan dicatat di [pengujian](../testing/README.md). Petunjuk Android tidak menyatakan bahwa uji perangkat Android sudah dilakukan. Release Android masih memakai debug signing; konfigurasi penandatanganan distribusi belum disiapkan.

## Masalah umum

| Gejala | Pemeriksaan |
|---|---|
| Gagal membuka SDK `bin/cache/lockfile` | Pastikan SDK dapat ditulis dan tidak dikunci proses Flutter lain. |
| `file is not a database` | Key SQLCipher mungkin tidak cocok atau file rusak; jangan menghapus database/secure storage sembarangan. |
| Akun baru tidak melihat data | Super Admin perlu menghubungkannya dengan profil. Akun tanpa hubungan mendapat daftar kosong. |
| Dosen tidak melihat mahasiswa | Periksa profil dosen, kelas/KRS atau hubungan dosen wali mahasiswa. |
| Login terkunci | Setelah lima kegagalan, tunggu 30 detik; kegagalan berikutnya berlipat hingga 15 menit. |
| Lupa PIN akun biasa | Super Admin dapat reset PIN melalui Kelola akun. |
| Lupa PIN Super Admin | Gunakan kode pemulihan satu kali, kemudian reset PIN di Kelola akun. |
| Tidak ada tombol backup | UI backup/restore belum dibuat; service baru mengenkripsi/dekripsi bytes. |

Mode biasa masih memakai seeder awal 100 mahasiswa bila kosong. Mode demo terpisah memakai 50 mahasiswa dan 5 dosen. Belum ada tombol reset seluruh data.
