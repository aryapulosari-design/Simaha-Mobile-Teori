> Riwayat checkpoint 20 Oktober 2026. Pekerjaan sudah dilanjutkan pada 21 Oktober; lihat doct/laporan/README.md dan audit terkini untuk status sekarang.

﻿# Catatan lanjut — 20 Oktober 2026

Pekerjaan dihentikan sementara atas permintaan pengguna dan disimpan ke GitHub. Implementasi desain Stitch belum selesai.

## Sudah tersimpan

- Dokumentasi `doct/`, audit fitur, panduan lima peran, dan daftar akun demo.
- Pemilihan role dan akun tanpa mengetik username; PIN awal demo `123456`.
- Dataset demo: 5 dosen, 10 mahasiswa, 5 kelas, nilai, kehadiran, dan bimbingan yang terhubung.
- Pembatasan data tiap role, skema database v5, serta pengujian hubungan antarperan.
- Hasil pengujian terakhir sebelum penghentian: 118 tes lulus; analyzer bersih.
- Referensi desain asli pada `stitch_simaha_offline_saas_ui/`.
- Font Plus Jakarta Sans, Inter, dan JetBrains Mono beserta lisensi OFL sudah tersedia di `assets/fonts/`; belum dipasang ke tema/pubspec.

## Prioritas saat dilanjutkan

1. Selesaikan isolasi penyimpanan demo dari mode biasa. Saat ini file database demo terpisah, tetapi kunci database masih memakai secure storage yang sama. Namespace preferensi saja belum mengisolasi DPAPI Windows.
2. Verifikasi kembali pembukaan database biasa dan pemulihan akun. Uji menjalankan aplikasi dari konteks Windows berbeda menghasilkan kegagalan DPAPI; kunci database yang ditahan proses aktif sudah ditulis kembali dari proses asal. Jangan menghapus database atau secure storage untuk mengatasi masalah ini. Kode pemulihan lama belum diverifikasi kembali.
3. Pastikan jendela Windows demo membuka halaman login secara normal. Build debug berhasil dan seeder 10 mahasiswa berjalan, tetapi uji jendela dari konteks eksekusi berbeda belum selesai.
4. Terapkan desain Stitch ke Flutter: latar #F8F9FF, kartu putih, teal #00685F, aksen indigo, font lokal, serta dashboard berbeda untuk tiap role. Screenshot role Super Admin, Pengampu, Wali, Mahasiswa dan DESIGN.md sudah diperiksa; tema saat ini masih desain sebelumnya.
5. Uji ulang perubahan penyimpanan dan UI, perbarui preview serta dokumentasi, lalu jalankan `flutter run -d windows --dart-define=SIMAHA_DEMO=true`.

Modul yang belum lengkap tetap tercantum pada audit. Gambar referensi bukan bukti bahwa seluruh fitur pada gambar sudah diimplementasikan.
