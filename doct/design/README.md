# Desain antarmuka SIMAHA

Acuan: folder `stitch_simaha_offline_saas_ui/stitch_simaha_offline_saas_ui`, khususnya dashboard Pengampu, Mahasiswa, Wali, Super Admin dan `swiss_bento_engineering/DESIGN.md`.

## Sistem visual

| Elemen | Implementasi |
|---|---|
| Latar | #F8F9FF terang; navy pada mode gelap |
| Kartu | Putih, radius 16, garis tipis, jarak antar kartu 12 |
| Aksen utama | Teal #00685F |
| Aksen pendamping | Indigo #4B41E1 |
| Judul | Plus Jakarta Sans lokal |
| Isi | Inter lokal |
| Label kode | JetBrains Mono lokal |
| Ruang | Margin desktop 24, ponsel 16, padding kartu 20 |
| Navigasi | Sidebar desktop; empat tujuan utama pada ponsel |
| Aksesibilitas | Target tombol minimal 48, teks membungkus, grid satu kolom saat teks besar |

Font dan lisensi OFL berada pada `assets/fonts/`. Ikon launcher dibangun dari bentuk geometris asli melalui `tools/build_launcher_icons.py`, mengikuti simbol institusi pada aplikasi. Tidak memerlukan unduhan aset saat aplikasi dipakai.

## Halaman dan data

Dashboard Mahasiswa memperlihatkan IPK, beban studi, progres dan kehadiran sendiri. Pengampu mendapat kelas, kelengkapan nilai dan presensi. Wali memperoleh prioritas pendampingan dan bimbingannya. Admin memperoleh ringkasan kelas serta aksi pengelolaan. Semua angka pada aplikasi berasal dari data sesuai akses akun.

Kartu jadwal, warta, hasil studi, PDF, insight dan jejak aktivitas mengarah ke halaman yang berfungsi. Status loading, kosong, gagal dan retry tersedia. Modul referensi yang belum terintegrasi tidak diberi tombol yang berpura-pura bekerja.

## Bukti visual

PNG berasal dari widget Flutter aktual dengan fixture data sintetis dan font aplikasi, bukan gambar mockup. Fixture adalah alat pemeriksaan layout dan bukan hasil pengujian calon pengguna.

- [Super Admin desktop](previews/desktop-light.png)
- [Admin Akademik](previews/role-admin-akademik.png)
- [Pengampu](previews/role-pengampu.png)
- [Wali](previews/role-wali.png)
- [Mahasiswa](previews/role-mahasiswa.png)
- [Ponsel terang](previews/mobile-light.png)
- [Ponsel gelap](previews/mobile-dark.png)
- [Teks 160 persen](previews/mobile-large-text.png)
- [Tablet](previews/tablet.png)

Reproduksi: `flutter test test/widget/workspace_test.dart test/widget/academic_pages_test.dart test/widget/login_picker_test.dart --dart-define=SIMAHA_DEMO=true --dart-define=WRITE_PREVIEWS=true`.
