# Demo lima role yang saling terhubung

## Langsung mencoba

```sh
flutter run -d windows --dart-define=SIMAHA_DEMO=true
```

Pada halaman login bertanda **RUANG DEMO**:

1. Pilih role.
2. Pilih nama akun dari daftar.
3. Klik **Masuk akun demo**, atau masukkan PIN **123456**.
4. Gunakan tombol **Ganti akun** di beranda untuk mencoba role berikutnya.

Semua akun, profil, kelas, KRS, nilai, presensi, dan bimbingan sudah dibuat serta dihubungkan otomatis. Tidak perlu setup akun satu per satu. Tombol Masuk akun demo tetap memverifikasi PIN akun yang dipilih. Angka 123456 adalah PIN awal; jika diubah melalui Kelola akun, gunakan PIN baru.

## Isi yang ringkas

| Data | Jumlah |
|---|---:|
| Program studi Informatika | 1 |
| Tahun ajaran 2026/2027 Gasal | 1 |
| Profil dosen | 5 |
| Profil mahasiswa aktif | 10 |
| Mata kuliah dan kelas | 5 |
| KRS sekaligus nilai | 50 |
| Pertemuan contoh | 15, tiga per kelas |
| Catatan presensi | 150 |
| Catatan bimbingan awal | 10, satu per mahasiswa |
| Akun login | 22 |

22 akun berasal dari 1 Super Admin, 1 Admin Akademik, 5 Pengampu, 5 Wali, dan 10 Mahasiswa. Lima dosen yang sama masing-masing memiliki akun Pengampu dan Wali; **profil dosennya tetap lima**.

Semua mahasiswa mengambil kelima mata kuliah (15 SKS). Setiap pengampu mengajar seluruh sepuluh mahasiswa pada satu mata kuliah. Setiap wali membimbing dua mahasiswa. Data antarakun berasal dari database yang sama, bukan salinan per role.

## Dosen, kelas, dan mahasiswa bimbingan

| Dosen | Mata kuliah yang diampu | Hari/jam | Bimbingan sebagai wali |
|---|---|---|---|
| Rahma Hidayati | IF101 Algoritma dan Pemrograman | Senin 08:00–10:30 | Alya Putri, Arif Maulana |
| Budi Santoso | IF102 Basis Data | Selasa 08:00–10:30 | Bima Pratama, Bunga Lestari |
| Citra Lestari | IF103 Pemrograman Web | Rabu 08:00–10:30 | Cahya Ramadhan, Citra Maharani |
| Dimas Pratama | IF104 Rekayasa Perangkat Lunak | Kamis 08:00–10:30 | Deni Saputra, Dewi Anggraini |
| Nadia Putri | IF105 Statistika Terapan | Jumat 08:00–10:30 | Eka Wulandari, Fajar Hidayat |

Semua kelas di atas berisi Alya, Arif, Bima, Bunga, Cahya, Citra, Deni, Dewi, Eka, dan Fajar. Masing-masing mata kuliah bernilai 3 SKS.

## Semua akun dan PIN awal

Username berikut hanya untuk referensi; cukup pilih nama akun dari dropdown.

| Role | Username | Nama | PIN awal |
|---|---|---|---|
| Super Admin | `superadmin` | Super Admin | `123456` |
| Admin Akademik | `akademik` | Admin Akademik | `123456` |
| Pengampu | `pengampu.rahma` | Rahma Hidayati | `123456` |
| Pengampu | `pengampu.budi` | Budi Santoso | `123456` |
| Pengampu | `pengampu.citra` | Citra Lestari | `123456` |
| Pengampu | `pengampu.dimas` | Dimas Pratama | `123456` |
| Pengampu | `pengampu.nadia` | Nadia Putri | `123456` |
| Wali | `wali.rahma` | Rahma Hidayati | `123456` |
| Wali | `wali.budi` | Budi Santoso | `123456` |
| Wali | `wali.citra` | Citra Lestari | `123456` |
| Wali | `wali.dimas` | Dimas Pratama | `123456` |
| Wali | `wali.nadia` | Nadia Putri | `123456` |
| Mahasiswa | `mhs.alya` | Alya Putri | `123456` |
| Mahasiswa | `mhs.arif` | Arif Maulana | `123456` |
| Mahasiswa | `mhs.bima` | Bima Pratama | `123456` |
| Mahasiswa | `mhs.bunga` | Bunga Lestari | `123456` |
| Mahasiswa | `mhs.cahya` | Cahya Ramadhan | `123456` |
| Mahasiswa | `mhs.citra` | Citra Maharani | `123456` |
| Mahasiswa | `mhs.deni` | Deni Saputra | `123456` |
| Mahasiswa | `mhs.dewi` | Dewi Anggraini | `123456` |
| Mahasiswa | `mhs.eka` | Eka Wulandari | `123456` |
| Mahasiswa | `mhs.fajar` | Fajar Hidayat | `123456` |

## Contoh alur lintas role

1. **Pengampu / Rahma** → Akademik → Algoritma → Alya → Input / Edit nilai. Simpan nilai baru.
2. **Mahasiswa / Alya** → buka profil atau kelas Algoritma. Nilai dan IPK menggunakan hasil perubahan tersebut.
3. **Wali / Rahma** → buka Alya → Catatan bimbingan → Tambah catatan dan tindak lanjut.
4. **Mahasiswa / Alya** → buka Catatan bimbingan. Catatan baru terlihat di sana.
5. **Admin Akademik** dapat memeriksa seluruh kelas serta nilai; **Super Admin** juga dapat mengelola semua akun dan hubungan profil.
6. Coba **Pengampu / Budi**: hanya Basis Data yang bisa dinilai. Coba **Wali / Budi**: hanya Bima dan Bunga yang masuk lingkup bimbingannya.

Di aplikasi, **Semua fungsi peran** menjelaskan tugas dan batas akses setiap role. **Akademik** menunjukkan jadwal, pengampu, peserta dalam lingkup akun, nilai, serta rekap hadir/izin/sakit/alpa.

## Penyimpanan dan batas demo

- Database demo: `simaha_demo.db`, terpisah dari `simaha.db` ruang biasa.
- Preferensi akun terakhir dan kode pemulihan demo memakai namespace secure storage tersendiri; pemulihan demo tidak memakai kode ruang biasa.
- Pembuatan awal akun dapat memerlukan sekitar 20 detik karena setiap PIN di-hash dengan salt terpisah pada isolate. Pembukaan berikutnya memakai data yang sudah ada.
- Seeder hanya berjalan sekali. Nilai dan catatan yang kamu ubah tetap tersimpan setelah aplikasi dibuka kembali.
- Presensi yang terlihat adalah tiga pertemuan contoh per kelas; input presensi manual dan scan QR belum tersedia.
- Mode biasa tetap dijalankan dengan `flutter run -d windows`, menggunakan setup dan data lokal yang sebelumnya ada.
- Fitur lanjutan lain yang belum selesai dijelaskan pada [audit](../audit/README.md).
