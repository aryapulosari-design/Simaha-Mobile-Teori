# Sistem desain dan UI/UX

## Arah visual

Ruang kerja akademik yang tenang: bidang kertas hangat, hijau daun, garis tipis, tipografi yang jelas, ruang kosong terukur. Hierarki diberikan oleh ukuran teks dan posisi konten, bukan gradasi atau hiasan berulang.

| Elemen | Keputusan |
|---|---|
| Aksen utama terang | `#235B49` |
| Latar terang | `#FCFCF9` |
| Teks utama | `#202C26` |
| Teks pendamping | `#617068` |
| Garis batas | `#E0E5DF` |
| Latar gelap | `#171E1B` |
| Aksen gelap | `#97D5B8` |
| Tipografi | Sans-serif bawaan platform/Flutter; tidak mengambil font melalui jaringan. |
| Judul | 28 px mobile, 36 px layar lebar; hierarki subjudul 16–20 px. |
| Isi | 14–16 px, tinggi baris 1.5; label/metadata 12 px. |
| Bentuk | Kartu radius 14 px, input/tombol 10 px, chip kompak. |
| Spasi | 8/12/16/20/24/28/36 px, lebar isi beranda maksimal 1120 px. |

Implementasi utama: `lib/core/theme/app_theme.dart`, `app_shell.dart`, `home_page.dart`, serta komponen bersama. Berkas token lama `app_colors.dart` masih mendukung komponen warisan; sumber tema aktif adalah `AppTheme`.

## Responsif dan navigasi

- Mulai lebar 1000 px: sidebar dengan identitas aplikasi, menu, role akun, tema dan kunci.
- Di bawahnya: navigasi bawah dengan menu yang diizinkan role.
- Beranda mulai 700 px: header direktori dengan kolom angkatan/status.
- Statistik menjadi satu kolom pada area di bawah 480 px agar label tidak terpotong.
- Tombol tambah hanya tampil untuk admin. Tema tidak memakai floating button kedua yang bertumpuk dengan aksi halaman.
- Router dipertahankan saat tema berubah sehingga pengguna tidak kehilangan halaman aktif.

## Login tanpa mengetik username

Halaman login menampilkan lima pilihan role, lalu daftar akun aktif yang sesuai. Nama profil ditampilkan bila sudah terhubung. Pilihan akun terakhir diingat, PIN dikosongkan saat berganti akun/role, dan role tanpa akun menampilkan petunjuk pembuatan akun. Memilih role tidak membuat akun atau membuka sesi; PIN akun tetap diverifikasi. Keypad memiliki tinggi tombol 52 px.

## Perilaku interaksi

Pencarian memiliki debounce 250 ms dan tombol hapus. Memuat data memakai indikator, kegagalan memiliki tombol coba lagi, dan daftar kosong menjelaskan langkah berikutnya. Hapus meminta konfirmasi serta menggunakan tempat sampah. Nama panjang menggunakan ellipsis pada direktori, sedangkan teks penjelasan membungkus. Status memakai label dan ikon, tidak hanya warna. Tooltip menjelaskan tombol ikon.

Istilah teknis seperti FTS, budget milidetik, dan tahap pengerjaan dihilangkan dari beranda. Hanya alur yang tersedia yang ditampilkan; tidak ada tombol modul palsu.

## Pratinjau dari widget Flutter

Gambar menggunakan data contoh untuk pemeriksaan layout, bukan screenshot data pengguna. Dirender melalui `test/widget/workspace_test.dart`; pengambilan screenshot ini tidak memerlukan menonaktifkan FLAG_SECURE di produksi.

- [Desktop terang 1440×1000](previews/desktop-light.png)
- [Ponsel terang 390×844](previews/mobile-light.png)
- [Ponsel gelap 390×844](previews/mobile-dark.png)
- [Ponsel 320 px dengan pembesaran teks 160%](previews/mobile-large-text.png)
- [Tablet 800×1100](previews/tablet.png)

```sh
flutter test test/widget/workspace_test.dart --dart-define=WRITE_PREVIEWS=true
```

Generator mencoba memuat Roboto dari source engine SDK agar gambar tidak menggunakan font kotak Ahem milik Flutter test. SDK tanpa file font tersebut dapat menjalankan tes layout biasa tanpa opsi preview. Pratinjau dan widget test membantu inspeksi, tetapi uji usability/SUS serta uji sentuh pada perangkat fisik belum dilakukan.

## Ruang kerja tiap role

Beranda menyediakan kartu tugas role, akses Akademik, Semua fungsi peran, dan Ganti akun. Akademik menampilkan kartu mata kuliah yang terkait akun; detailnya memuat nilai dan rekap kehadiran. Catatan bimbingan memakai form dengan validasi dan riwayat yang dapat dibaca mahasiswa terkait. Login demo menampilkan jumlah data, PIN awal, dan tombol Masuk akun demo.

Pratinjau tambahan: [Admin Akademik](previews/role-admin-akademik.png), [Pengampu](previews/role-pengampu.png), [Wali](previews/role-wali.png), [Mahasiswa](previews/role-mahasiswa.png), [kelas pengampu](previews/kelas-pengampu.png), [kelas mahasiswa](previews/kelas-mahasiswa.png), [bimbingan wali](previews/bimbingan-wali.png), [bimbingan mahasiswa](previews/bimbingan-mahasiswa.png).
