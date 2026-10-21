# Artefak kandidat SIMAHA

APK demo ARM64: `SIMAHA-1.1.0-rc-demo-arm64.apk`, versi 1.1.0, minimum Android API 26. File terbaru berukuran sekitar 25,0 MiB dan sudah memuat form master serta validasi KRS. Checksum dan metadata tersedia dalam [manifest.json](manifest.json).

APK berada di folder lokal ini dan tidak dimasukkan ke Git. Kode, perintah build, laporan dan bukti hasil berada di repositori. Gunakan perangkat ARM64 yang kompatibel; jangan menganggap APK ini mencakup ABI 32-bit atau x86.

Kandidat memakai 50 mahasiswa sintetis dan 5 dosen, dengan 62 akun. PIN awal seluruh akun 123456. Sertifikat masih Android Debug; uji calon pengguna, Android fisik dan signing distribusi belum selesai. Batas seluruh fitur mengikuti doct/audit/README.md.

Build ulang:

```sh
flutter build apk --release --dart-define=SIMAHA_DEMO=true --target-platform android-arm64
```

Sumber hasil build: build/app/outputs/flutter-apk/app-release.apk. Version code kandidat ini 2; kandidat split lama memakai 2002. Android dapat menolak pemasangan sebagai downgrade jika kandidat lama sudah terpasang; cadangkan data yang diperlukan sebelum menghapus instalasi demo lama. Untuk Windows, gunakan seluruh folder build/windows/x64/runner/Debug beserta data dan DLL-nya; build Windows lama belum memuat form master terbaru.
