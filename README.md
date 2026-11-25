# SIMAHA Offline

SIMAHA Offline adalah aplikasi Flutter untuk administrasi akademik mahasiswa. Admin mengelola data dan KRS, dosen mencatat nilai, presensi, dan bimbingan, lalu mahasiswa melihat hasil studinya. Data disimpan di perangkat dalam database SQLCipher terenkripsi. Aplikasi bisa dipakai tanpa server.

## Coba demo

- **Umum:** Git, Flutter dengan Dart yang memenuhi `^3.13.2`, dan internet untuk menyiapkan dependensi.
- **Windows:** Visual Studio dengan workload **Desktop development with C++** dan Windows SDK.
- **Android:** Android SDK, JDK 17, dan emulator atau perangkat Android 8.0 (API 26) ke atas.

```sh
git clone https://github.com/aryapulosari-design/Simaha-Mobile-Teori.git
cd Simaha-Mobile-Teori
flutter doctor -v
flutter pub get
flutter run -d windows --dart-define=SIMAHA_DEMO=true
```

Untuk Android, jalankan `flutter devices`, lalu ganti `windows` pada perintah terakhir dengan ID emulator atau perangkat. Target web belum didukung. [Panduan instalasi dan solusi masalah umum](doct/setup/README.md)

Di layar masuk, pilih peran → **Pilih akun** → cari nama atau username → **Masuk akun demo**. PIN awal semua akun demo adalah **`123456`**. Pembukaan pertama bisa memerlukan beberapa menit untuk menyiapkan data.

### Akun yang bisa dicoba

| Peran | Jumlah akun | Contoh akun | Yang bisa dicoba |
|---|---:|---|---|
| Mahasiswa | 50 | Alya Putri (`mhs.alya`) | Lihat nilai, IPK, jadwal, presensi, dan catatan bimbingan sendiri. |
| Dosen Pengampu | 5 | Rahma Hidayati (`pengampu.rahma`) | Ubah nilai dan isi presensi kelas Algoritma. |
| Dosen Wali | 5 | Rahma Hidayati (`wali.rahma`) | Lihat mahasiswa bimbingan dan tulis catatan untuk Alya. |
| Admin Akademik | 1 | `akademik` | Kelola mahasiswa, data master, dan KRS. |
| Super Admin | 1 | `superadmin` | Kelola akun, hubungkan profil, dan buka jejak aktivitas. |

**Coba alur lintas peran:** masuk sebagai Rahma Pengampu dan ubah nilai Algoritma Alya. Tekan **Ganti akun** di beranda, masuk sebagai Alya, lalu buka **Hasil studi & bimbingan** untuk melihat nilai yang berubah. Demo berisi 62 akun, 5 kelas, dan data akademik sintetis. [Daftar lengkap akun dan skenario demo](doct/demo/README.md)

## Fitur yang sudah tersedia

- **Administrasi akademik:** kelola profil mahasiswa dan data master prodi, dosen, tahun ajaran, mata kuliah, serta kelas. Saat admin menambah KRS, aplikasi memeriksa semester aktif, batas SKS, prasyarat, dan bentrok jadwal.
- **Perkuliahan:** lihat jadwal, isi nilai tugas/UTS/UAS, kelola presensi manual, dan lihat rekap sesuai peran.
- **Hasil studi dan bimbingan:** lihat IPK, SKS, progres studi, dan catatan wali. Simpan PDF ringkasan hasil studi.
- **Pengelolaan aplikasi:** terbitkan pengumuman, kelola akun lokal dengan PIN, dan lihat jejak aktivitas yang tercatat.

**Masih dalam rencana:** pengajuan KRS mandiri dan persetujuan wali, KHS per semester, presensi QR, backup dan pemulihan, sinkronisasi antarperangkat, dan asisten akademik. [Audit fitur dan batasannya](doct/audit/README.md)

## Mode biasa

Jalankan `flutter run -d windows` untuk membuka mode biasa. Instalasi baru menyiapkan 100 profil mahasiswa dummy beserta data akademik terkait. Buat PIN enam digit untuk `superadmin`, simpan kode pemulihan, lalu buat akun melalui **Kelola akun**. Gunakan **Hubungkan profil** pada akun mahasiswa dan dosen agar data akademiknya muncul. Mode biasa memiliki database dan PIN sendiri. [Langkah setup pertama](doct/setup/README.md#pemasangan-pertama-pada-mode-biasa)

## Pengujian dan dokumentasi

```sh
flutter analyze
flutter test
```

QA 25 November 2026 mencakup login mahasiswa dan dosen di Windows. Suite awal lulus 143 tes, termasuk verifikasi 62 akun demo. Setelah fitur pencarian ditambahkan, 19 tes regresi lulus. Android fisik dan uji calon pengguna masih menunggu pelaksanaan. [Catatan QA dan perintah reproduksi](doct/testing/README.md#qa-windows-25-november-2026)

| Dokumen | Isi |
|---|---|
| [Indeks dokumentasi](doct/README.md) | Panduan setup, penggunaan, dan pengembangan. |
| [Peran dan hak akses](doct/roles/README.md) | Data dan tindakan yang tersedia untuk setiap peran. |
| [Desain dan pratinjau](doct/design/README.md#bukti-visual) | Tampilan dashboard Flutter untuk ponsel, tablet, dan desktop. |
| [Arsitektur](doct/architecture/README.md) dan [keamanan](doct/security/README.md) | Struktur kode, database, enkripsi, dan pemulihan PIN. |
| [Laporan Tahap 4 dan 5](doct/laporan/README.md) | Matriks luaran, kasus uji, temuan, rancangan uji pengguna, presentasi, dan naskah video. |
| [Build APK](artifacts/README.md) | Perintah membuat APK demo untuk ARM64. |
