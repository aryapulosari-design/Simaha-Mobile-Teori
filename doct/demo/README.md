# Demo lima role yang saling terhubung

Pembaruan 21 Oktober 2026: **50 mahasiswa, 5 dosen, 5 kelas, 62 akun**. Seluruh PIN awal demo **123456**.

## Menjalankan dan berpindah akun

```sh
flutter run -d windows --dart-define=SIMAHA_DEMO=true
```

Pilih role, pilih nama akun, lalu Masuk akun demo atau masukkan PIN. Gunakan Ganti akun untuk mencoba role lain. PIN yang sudah diubah harus menggunakan PIN baru. Pembuatan awal 62 hash akun dapat memerlukan beberapa menit pada perangkat lambat; proses berikutnya memakai data yang sama.

Pada desktop terkelola yang tidak mengizinkan penulisan Documents, gunakan folder kerja melalui variabel lingkungan SIMAHA_DEMO_DIRECTORY, khusus demo:

```powershell
$env:SIMAHA_DEMO_DIRECTORY = Join-Path (Get-Location) ".dart_tool/demo-50"
flutter run -d windows --dart-define=SIMAHA_DEMO=true
```

## Isi dataset

| Data | Jumlah |
|---|---:|
| Mahasiswa aktif | 50 |
| Profil dosen | 5 |
| Kelas dan mata kuliah | 5 |
| KRS beserta nilai | 250 |
| Pertemuan awal | 15 |
| Catatan presensi awal | 750 |
| Catatan bimbingan awal | 50 |
| Akun | 62 |

Seluruh mahasiswa mengambil kelima mata kuliah, masing-masing 3 SKS (15 SKS per mahasiswa). Setiap dosen mengajar 50 mahasiswa dan menjadi wali 10 mahasiswa. Satu profil dosen mempunyai dua akun dengan kewenangan berbeda.

## Lima dosen dan bimbingan

| Dosen | Mata kuliah | Jadwal | Sepuluh mahasiswa bimbingan |
|---|---|---|---|
| Rahma Hidayati | Algoritma dan Pemrograman | Senin 08:00-10:30 | Alya Putri, Arif Maulana, Gilang Ramadhan, Hana Safitri, Oki Setiawan, Putri Amelia, Tiara Kirana, Umar Faruq, Bagas Firmansyah, Bella Aprilia |
| Budi Santoso | Basis Data | Selasa 08:00-10:30 | Bima Pratama, Bunga Lestari, Ilham Akbar, Intan Permata, Qori Annisa, Rafi Prakoso, Vania Maharani, Wahyu Saputra, Daniel Wijaya, Dina Rahmawati |
| Citra Lestari | Pemrograman Web | Rabu 08:00-10:30 | Cahya Ramadhan, Citra Maharani, Joko Wibowo, Karina Putri, Rani Puspita, Rizal Firmansyah, Winda Kartika, Yoga Pratama, Farhan Hadi, Fitri Nuraini |
| Dimas Pratama | Rekayasa Perangkat Lunak | Kamis 08:00-10:30 | Deni Saputra, Dewi Anggraini, Luthfi Hakim, Maya Salsabila, Salma Aulia, Satria Nugraha, Zahra Nabila, Zaki Maulana, Galih Pranata, Hasna Khairunnisa |
| Nadia Putri | Statistika Terapan | Jumat 08:00-10:30 | Eka Wulandari, Fajar Hidayat, Naufal Rizki, Nisa Azzahra, Sinta Maharani, Taufik Hidayat, Adnan Fikri, Aisha Humaira, Irfan Kurniawan, Jihan Amalia |

## Semua akun

Username hanya referensi; login cukup memilih nama dari daftar.

| Role | Username | Nama | PIN awal |
|---|---|---|---|
| Super Admin | superadmin | Super Admin | 123456 |
| Admin Akademik | akademik | Admin Akademik | 123456 |
| Pengampu | pengampu.rahma | Rahma Hidayati | 123456 |
| Wali | wali.rahma | Rahma Hidayati | 123456 |
| Pengampu | pengampu.budi | Budi Santoso | 123456 |
| Wali | wali.budi | Budi Santoso | 123456 |
| Pengampu | pengampu.citra | Citra Lestari | 123456 |
| Wali | wali.citra | Citra Lestari | 123456 |
| Pengampu | pengampu.dimas | Dimas Pratama | 123456 |
| Wali | wali.dimas | Dimas Pratama | 123456 |
| Pengampu | pengampu.nadia | Nadia Putri | 123456 |
| Wali | wali.nadia | Nadia Putri | 123456 |
| Mahasiswa | mhs.alya | Alya Putri | 123456 |
| Mahasiswa | mhs.arif | Arif Maulana | 123456 |
| Mahasiswa | mhs.bima | Bima Pratama | 123456 |
| Mahasiswa | mhs.bunga | Bunga Lestari | 123456 |
| Mahasiswa | mhs.cahya | Cahya Ramadhan | 123456 |
| Mahasiswa | mhs.citra | Citra Maharani | 123456 |
| Mahasiswa | mhs.deni | Deni Saputra | 123456 |
| Mahasiswa | mhs.dewi | Dewi Anggraini | 123456 |
| Mahasiswa | mhs.eka | Eka Wulandari | 123456 |
| Mahasiswa | mhs.fajar | Fajar Hidayat | 123456 |
| Mahasiswa | mhs.gilang | Gilang Ramadhan | 123456 |
| Mahasiswa | mhs.hana | Hana Safitri | 123456 |
| Mahasiswa | mhs.ilham | Ilham Akbar | 123456 |
| Mahasiswa | mhs.intan | Intan Permata | 123456 |
| Mahasiswa | mhs.joko | Joko Wibowo | 123456 |
| Mahasiswa | mhs.karina | Karina Putri | 123456 |
| Mahasiswa | mhs.luthfi | Luthfi Hakim | 123456 |
| Mahasiswa | mhs.maya | Maya Salsabila | 123456 |
| Mahasiswa | mhs.naufal | Naufal Rizki | 123456 |
| Mahasiswa | mhs.nisa | Nisa Azzahra | 123456 |
| Mahasiswa | mhs.oki | Oki Setiawan | 123456 |
| Mahasiswa | mhs.putri | Putri Amelia | 123456 |
| Mahasiswa | mhs.qori | Qori Annisa | 123456 |
| Mahasiswa | mhs.rafi | Rafi Prakoso | 123456 |
| Mahasiswa | mhs.rani | Rani Puspita | 123456 |
| Mahasiswa | mhs.rizal | Rizal Firmansyah | 123456 |
| Mahasiswa | mhs.salma | Salma Aulia | 123456 |
| Mahasiswa | mhs.satria | Satria Nugraha | 123456 |
| Mahasiswa | mhs.sinta | Sinta Maharani | 123456 |
| Mahasiswa | mhs.taufik | Taufik Hidayat | 123456 |
| Mahasiswa | mhs.tiara | Tiara Kirana | 123456 |
| Mahasiswa | mhs.umar | Umar Faruq | 123456 |
| Mahasiswa | mhs.vania | Vania Maharani | 123456 |
| Mahasiswa | mhs.wahyu | Wahyu Saputra | 123456 |
| Mahasiswa | mhs.winda | Winda Kartika | 123456 |
| Mahasiswa | mhs.yoga | Yoga Pratama | 123456 |
| Mahasiswa | mhs.zahra | Zahra Nabila | 123456 |
| Mahasiswa | mhs.zaki | Zaki Maulana | 123456 |
| Mahasiswa | mhs.adnan | Adnan Fikri | 123456 |
| Mahasiswa | mhs.aisha | Aisha Humaira | 123456 |
| Mahasiswa | mhs.bagas | Bagas Firmansyah | 123456 |
| Mahasiswa | mhs.bella | Bella Aprilia | 123456 |
| Mahasiswa | mhs.daniel | Daniel Wijaya | 123456 |
| Mahasiswa | mhs.dina | Dina Rahmawati | 123456 |
| Mahasiswa | mhs.farhan | Farhan Hadi | 123456 |
| Mahasiswa | mhs.fitri | Fitri Nuraini | 123456 |
| Mahasiswa | mhs.galih | Galih Pranata | 123456 |
| Mahasiswa | mhs.hasna | Hasna Khairunnisa | 123456 |
| Mahasiswa | mhs.irfan | Irfan Kurniawan | 123456 |
| Mahasiswa | mhs.jihan | Jihan Amalia | 123456 |

## Alur yang dapat dicoba

1. Pengampu Rahma membuka Akademik, Algoritma, lalu Alya dan mengubah nilai.
2. Ganti akun ke Alya untuk membaca nilai dan ringkasan studi yang berubah.
3. Wali Rahma menulis catatan serta tindak lanjut di profil Alya.
4. Alya membaca catatan yang sama.
5. Pengampu membuka Kelola presensi untuk menambah pertemuan dan mengisi status.
6. Admin Akademik menerbitkan Warta; mahasiswa membaca pengumumannya.
7. Alya menyimpan PDF hasil studi dari profilnya.
8. Super Admin membaca Jejak aktivitas.

## Penyimpanan dan batas

Database baru simaha_demo_50.db tidak menimpa simaha.db atau demo lama. DemoStore menyimpan preferensi dan kunci acak demo pada file tersendiri; tidak mengakses secure storage produksi. Kunci berada bersama preferensi demo dan tidak diperuntukkan data nyata. Mode biasa tetap memakai secure storage.

Seeder idempoten mempertahankan perubahan. Seluruh akun pada satu perangkat membaca database yang sama; sinkronisasi antarperangkat belum tersedia. Contoh presensi awal tiga sesi per kelas, berikutnya dapat diisi manual. Presensi QR belum tersedia.

Lima puluh mahasiswa adalah data sintetis, bukan responden pengujian pengguna.
