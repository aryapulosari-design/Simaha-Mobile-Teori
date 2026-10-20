# Hasil verifikasi — 20 Oktober 2026

Pembaruan login: pengguna kini memilih role dan akun aktif dari daftar, kemudian memasukkan PIN. Tidak perlu mengetik username. Akun terakhir diingat.

## Hasil yang dijalankan

| Pemeriksaan | Hasil |
|---|---|
| `flutter analyze --no-pub` | **Lulus — No issues found**, exit 0. |
| `flutter test --no-pub --reporter expanded` | **118 tes lulus**, exit 0; tidak ada tes gagal. |
| Tes scope akademik | 15 skenario: lima role, direct ID, pencarian, nilai kelas lain, mutasi terlarang, akun nonaktif, linking, FTS hapus/pulih, NaN/infinity, seeder saat seluruh data diarsipkan, daftar akun aktif untuk login. |
| Tes pemilih akun | 7 skenario: lima role, role tanpa akun, akun terakhir, pemilihan akun/PIN, login valid, retry, layar sempit dengan teks 160%. |
| Tes workspace | 10 skenario: desktop, mobile terang/gelap, teks 160% pada lebar 320, tablet, restricted deep links/tema tidak mereset route. |
| Tes scope layar aman | Proteksi tetap aktif saat dua route sensitif bertumpuk dan baru dilepas sesudah scope terakhir ditutup. Mock MethodChannel; bukan uji screenshot Android fisik. |
| Build Windows release audit awal | **Berhasil** pada implementasi audit awal, di `build/windows/x64/runner/Release/`. Pembaruan pemilih akun dijalankan melalui build debug `flutter run -d windows`. |
| Pratinjau UI | PNG dari widget aktual pada [folder preview](../design/README.md), diperiksa secara visual. |

SDK: Dart 3.13.2 stable pada Windows. Perintah Flutter dijalankan dengan `dart.exe .../flutter_tools.snapshot <subcommand>` untuk mengatasi akses lock/cache launcher SDK pada lingkungan terkelola. Tidak ada penggantian implementasi produksi dengan mock untuk analyzer/build. Widget preview memakai data dummy; test service memakai database sementara.

## Bukti hasil dan cara reproduksi

```text
flutter analyze: No issues found!
flutter test: +118: All tests passed!
flutter build windows: Built build\windows\x64\runner\Release\simaha.exe
```

```sh
flutter analyze --no-pub
flutter test --no-pub --reporter expanded
flutter test test/widget/workspace_test.dart --no-pub --dart-define=WRITE_PREVIEWS=true
flutter build windows --release --no-pub
```

Untuk menjalankan/memindahkan build Windows, gunakan isi folder Release secara lengkap, termasuk `data/` dan DLL, bukan hanya berkas EXE.

## Batas pengujian

- Build Windows membuktikan kompilasi; sesi GUI Windows produksi belum diuji secara interaktif dalam audit ini.
- Belum build/uji APK Android, perangkat fisik, iOS/macOS/Linux, screenshot/recent apps Android, biometrik, notifikasi nyata.
- Belum ada integration test end-to-end, uji kehilangan key/perangkat, benchmark 10.000 mahasiswa, pengukuran cold start perangkat, ukuran APK, SUS, atau coverage logika inti ≥70%.
- Kelulusan unit test QR/backup/sync/parser hanya membuktikan fungsi yang diuji; tidak mengubah status modul tersebut menjadi fitur aplikasi lengkap.
- Target PRD yang belum selesai tercatat pada [audit FR/NFR](README.md).

## Perubahan perilaku utama yang diperiksa

1. Mahasiswa A tidak dapat membaca mahasiswa B melalui query atau ID.
2. Dosen Pengampu tidak dapat membaca/mengubah nilai kelas dosen lain.
3. Wali hanya mendapat mahasiswa bimbingan dan tidak dapat menulis nilai.
4. Data arsip hilang dari pencarian/count, kembali setelah restore, dan indeks FTS tetap konsisten.
5. Mengarsipkan seluruh mahasiswa tidak menjalankan seeder ulang saat pembukaan aplikasi.
6. Profil yang sudah ditempati akun lain tidak dapat diambil alih; linking dibatasi Super Admin.
7. URL admin ditolak bagi mahasiswa dan navigasi tetap pada halaman aktif ketika tema berubah.
