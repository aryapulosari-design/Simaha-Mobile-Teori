# Hasil verifikasi 21 Oktober 2026

| Pemeriksaan | Hasil dan bukti |
|---|---|
| Suite lengkap | **136 tes lulus**, runner success=true, bukti/tests.jsonl |
| Analyzer | **No issues found**, bukti/analyze.log |
| Regresi UI dan domain terkait | **38 tes lulus**, bukti/widget-previews.log |
| Dataset dan hubungan | 50 mahasiswa, 5 dosen, 5 kelas, 62 akun, 250 KRS/nilai, 750 presensi awal dan 50 catatan bimbingan |
| Semua akun | Seluruh 62 PIN awal dan role diverifikasi melalui AuthService |
| Antarperan | Nilai, catatan bimbingan dan presensi terbaca melalui akun terkait; akses pihak lain ditolak |
| Penyimpanan demo | Reopen mempertahankan data, file mode biasa tetap utuh, kunci hilang gagal aman |
| Build APK ARM64 | Berhasil, release kandidat demo versi 1.1.0, minimum API 26; file artifacts/SIMAHA-1.1.0-rc-demo-arm64.apk |
| Tanda tangan APK | apksigner verify lulus, skema v2, sertifikat Android Debug; belum signing distribusi |
| Manifest APK | Package id.ac.uin.simaha, versi ABI 2002, target/compile API 36, native-code arm64-v8a |
| Build Windows | Hasil akhir pada bukti/build-windows.log; jangan menyamakan build dengan uji interaktif lengkap |
| Preview | PNG widget aktual, font lokal, desktop/ponsel/tablet/gelap/teks 160 persen |
| Uji calon pengguna | **Belum dilaksanakan**, 0 responden aktual; 50 mahasiswa demo bukan responden |

CSV hasil setiap tes dibuat otomatis saat laporan dibangun pada doct/laporan/hasil_pengujian_otomatis.csv. Data pada widget preview adalah fixture sintetis untuk layout, sedangkan service test menggunakan database sementara.

## Reproduksi

Jalankan berurutan karena perintah Flutter memperbarui file plugin yang sama:

```sh
flutter pub get
flutter test --no-pub --reporter json
flutter analyze --no-pub
flutter build apk --release --no-pub --dart-define=SIMAHA_DEMO=true --target-platform android-arm64 --split-per-abi
flutter build windows --debug --no-pub --dart-define=SIMAHA_DEMO=true
```

Untuk UI preview:

```sh
flutter test test/widget/workspace_test.dart test/widget/academic_pages_test.dart test/widget/login_picker_test.dart test/widget/campus_pages_test.dart test/stage4_regression_test.dart test/risk_score_test.dart --dart-define=SIMAHA_DEMO=true --dart-define=WRITE_PREVIEWS=true
```

Pada lingkungan terkelola, perintah memakai dart.exe dan flutter_tools.snapshot dari SDK yang sama untuk menghindari launcher lock. Runtime folder demo dapat diarahkan melalui SIMAHA_DEMO_DIRECTORY tanpa mengubah penyimpanan mode biasa.

## Batas bukti

Belum ada uji Android fisik, uji calon pengguna, penilaian SUS, uji pembaca layar, benchmark 10000 mahasiswa, ataupun pengujian kehilangan perangkat. Penyimpanan serta pemulihan data produksi lama belum diverifikasi ulang setelah temuan DPAPI. Build release APK masih memakai sertifikat debug. QR, backup/restore, sinkronisasi dan gap lain mengikuti matriks FR/NFR.

Lihat [temuan dan perbaikan](temuan.md), [kasus uji](../testing/KASUS_UJI.md), dan [laporan Tahap 4 dan 5](../laporan/README.md).

Windows smoke test terbaru mencapai halaman LockPage dengan total=50, aktif=50, prodi=1, dosen=5, kelas=5. Tidak ada BootError. Bukti terbatas pada startup dan struktur widget Flutter; belum merupakan uji interaktif lengkap oleh pengguna. Lihat bukti/windows-smoke.json.
