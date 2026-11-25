# Pengujian dan verifikasi

## QA Windows 25 November 2026

Mode demo dijalankan pada Windows dengan database tersendiri. Dataset yang diverifikasi memuat **50 akun mahasiswa, 5 akun dosen pengampu, 5 akun dosen wali, dan 2 akun admin**. Lima dosen memiliki akun terpisah untuk masing-masing peran. [Daftar akun dan cara menjalankan demo](../demo/README.md).

| Pemeriksaan | Hasil |
|---|---|
| Suite lengkap sebelum perubahan | 143 tes lulus, termasuk verifikasi PIN awal dan peran semua 62 akun demo. |
| QA langsung di Windows | Adnan Fikri masuk dan membuka hasil studi. Akun Pengampu Budi Santoso melihat kelas Basis Data dengan 50 peserta. Setelah pemilih akun diperbarui, pencarian `z` menampilkan Zaki Maulana dan akun tersebut berhasil masuk. |
| Regresi setelah perubahan | 19 tes mode demo lulus, termasuk pencarian dalam daftar 50 mahasiswa, batas peran, pengosongan PIN saat akun diganti, dan dashboard. Analyzer pada dua file Dart yang diubah bersih. |
| Waktu mulai dan tata letak | Inisialisasi demo pertama lambat pada sesi ini. Pembukaan ulang dengan database yang sudah ada tercatat 2,6 detik. Pada jendela setinggi sekitar 720 piksel, keypad PIN baru terlihat setelah menggulir. |

Perintah untuk mengulang tes regresi:

```sh
flutter test --no-pub -r expanded --dart-define=SIMAHA_DEMO=true test/widget/login_picker_test.dart test/auth_flow_test.dart test/widget/workspace_test.dart
```

### Prioritas setelah QA

1. **Pengajuan KRS dan persetujuan dosen wali.** Saat ini penambahan KRS dilakukan admin. Mahasiswa perlu bisa mengajukan KRS, melihat statusnya, dan memperbaiki usulan jika diminta wali. [Pedoman Pendidikan UIN Suska Riau](https://fst.uin-suska.ac.id/wp-content/uploads/2025/08/DOC-20250827-WA0059.pdf)
2. **KHS per semester.** Tambahkan pemilihan semester, tampilan IPS, dan unduhan KHS. Aplikasi saat ini menyediakan PDF ringkasan hasil studi. [Panduan SIAKADU Universitas Lampung](https://tik.unila.ac.id/layanan/panduan-siakad-mahasiswa)
3. **Backup dan pemulihan data lokal.** Sediakan alur untuk membuat, memeriksa, dan memulihkan cadangan sebelum memakai data nyata.
4. **Data demo yang lebih beragam.** Bagi 50 mahasiswa ke beberapa kelas atau semester dan tambahkan contoh nilai kosong, mata kuliah yang diulang, serta kehadiran rendah.

QA langsung kali ini mencakup Windows. Android fisik dan pemulihan cadangan belum diuji.

## Pembaruan kandidat 21 Oktober 2026

Analyzer terakhir bersih. Suite utama 139 tes lulus pada `bukti/tests.jsonl`; empat tes aturan KRS tambahan lulus pada `bukti/registration-tests.jsonl` (total 143). Tabel laporan menggabungkan kedua log dengan ID terpisah. Tes master memeriksa alur prodi → dosen → semester → mata kuliah → kelas → KRS, proteksi data terpakai, audit, bentrok jadwal, siklus prasyarat dan penolakan tiga role non-admin. Tes demo yang sudah ada memeriksa 62 akun, 50 mahasiswa, isi setiap role, perubahan nilai/bimbingan/presensi lintas akun serta batas akses.

Build Windows dalam bukti terdahulu mendahului penambahan halaman master; build Android diperbarui untuk kandidat ini. Pengujian otomatis tidak menggantikan uji perangkat fisik atau calon pengguna.

Tanggal audit: **20 Oktober 2026**, lingkungan Windows dengan Dart 3.13.2 dan Flutter SDK yang terpasang pada mesin pengembangan.

## Perintah

```sh
flutter analyze
flutter test --reporter expanded
flutter test test/academic_access_test.dart
flutter test test/widget/workspace_test.dart
flutter test test/widget/workspace_test.dart test/widget/academic_pages_test.dart --dart-define=SIMAHA_DEMO=true --dart-define=WRITE_PREVIEWS=true
flutter build windows --release
```

Hasil akhir run audit dicatat di [hasil verifikasi](../audit/verification.md).

## Cakupan tes

| Area | Berkas |
|---|---|
| Rumus nilai, IPS/IPK, simulasi, validasi | `academic_engine_test.dart`, `academic_constants_test.dart` |
| Pilih peran, cari akun, pulihkan pilihan terakhir, verifikasi PIN, coba lagi, layar kecil | `widget/login_picker_test.dart` |
| Setup/PIN/lockout/recovery/RBAC akun | `auth_test.dart`, `auth_flow_test.dart`, `crypto_test.dart` |
| Enkripsi SQLCipher | `encryption_test.dart` |
| Migrasi/seed/FTS/pagination | `migration_test.dart`, `seed_test.dart`, `unit/step1_foundation_test.dart` |
| Demo semua akun, kelas, mahasiswa, nilai lintas role, bimbingan, recovery terpisah | `demo_workspace_test.dart` |
| Halaman kelas, rekap dan form/riwayat bimbingan | `widget/academic_pages_test.dart` |
| Scope lima role, data mahasiswa/nilai, mutasi, linking, FTS sampah | `academic_access_test.dart` |
| QR/risiko/parser/sync/backup | `qr_token_test.dart`, `risk_score_test.dart`, `intent_parser_test.dart`, `sync_backup_test.dart` |
| CSV dan interface notifikasi | `csv_notify_test.dart` |
| Proteksi layar selama transisi route | `widget/secure_scope_test.dart` |
| Komponen dasar dan pengaturan | `widget_test.dart`, `widget/step1_widgets_test.dart` |
| Responsif, gelap, teks besar, akses URL, tema tidak mereset navigasi | `widget/workspace_test.dart` |

Tes domain membuktikan fungsi terpisah; tidak membuktikan bahwa fitur QR/backup/sinkronisasi memiliki UI atau alur data lengkap.

## Pengujian manual yang masih diperlukan

1. Jalankan setup pada instalasi baru, simpan recovery code, dan pastikan PIN diperlukan sesudah restart.
2. Buat kelima role dan hubungkan akun dosen/mahasiswa dengan profil.
3. Uji baca/tulis tiap role sesuai [matriks](../roles/README.md), termasuk ID/URL di luar scope.
4. Tambah/edit/hapus/pulih mahasiswa; cari lagi sesudah restore.
5. Input nilai normal serta input kosong/negatif/lebih dari 100.
6. Uji keyboard, pembaca layar, rotasi, layar kecil/tablet, tema gelap.
7. Uji airplane mode, cold start, auto-lock idle/background, screenshot dan recent apps pada Android.
8. Ukur 10.000 mahasiswa, cold start, ukuran APK, coverage logika inti, dan SUS.

`integration_test/` belum berisi skenario end-to-end. Uji Android fisik, iOS/Linux/macOS, benchmark 10.000 record, SUS, dan APK release belum dianggap selesai.

## Catatan toolchain

Pada lingkungan audit, `flutter.bat` sempat tidak memberi keluaran karena pembatasan akses cache SDK. Tool dijalankan melalui `dart.exe` dan `flutter_tools.snapshot` dari SDK yang sama, dengan akses cache SDK yang diizinkan. Ini ekuivalen dengan subcommand Flutter; tidak mengubah kode aplikasi untuk melewati pemeriksaan.
