# Pengujian dan verifikasi

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
| Pilih role/akun tanpa mengetik, akun terakhir, PIN, retry, layar kecil | `widget/login_picker_test.dart` |
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
