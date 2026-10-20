# Lima role dan seluruh fungsi yang tersedia

Cara termudah memahami role adalah [mencoba akun demo yang sudah terisi](../demo/README.md). Semua PIN awal demo **123456**. Di aplikasi, gunakan tombol **Semua fungsi peran** untuk melihat panduan ini, dan **Ganti akun** untuk berpindah.

## 1. Super Admin — menyiapkan dan mengawasi sistem

- Membuat akun lokal dan memilih salah satu dari lima role.
- Mengaktifkan/nonaktifkan akun lain, mereset PIN, dan menghubungkan akun dengan profil mahasiswa/dosen.
- Melihat seluruh mahasiswa serta menambah, mengubah, mengarsipkan, dan memulihkannya.
- Mengelola KRS/nilai yang tersedia dan syarat SKS kelulusan.
- Melihat semua kelas, pengampu, peserta, jadwal, rata-rata nilai, dan rekap kehadiran.
- Membaca catatan bimbingan dan dapat menambah catatan pada profil yang sudah mempunyai wali.
- Membuka informasi database. Tidak dapat menonaktifkan dirinya sendiri.

**Demo:** `superadmin` → 10 mahasiswa, 5 dosen, 5 kelas, dan 22 akun yang sudah terhubung.

## 2. Admin Akademik — administrasi studi seluruh mahasiswa

- Menambah, mengubah, mengarsipkan, dan memulihkan profil mahasiswa.
- Menambah/menghapus KRS, memasukkan/memperbaiki nilai tugas/UTS/UAS.
- Melihat seluruh kelas, pengampu, peserta, jadwal, rata-rata nilai, dan rekap kehadiran.
- Melihat ringkasan IPK/SKS/simulasi mahasiswa, mengubah syarat SKS, serta membuka informasi database.
- Tidak mengelola akun, reset PIN, dan hubungan akun/profil. Catatan bimbingan dibatasi untuk wali, mahasiswa terkait, dan Super Admin.

**Demo:** `akademik` → seluruh 10 mahasiswa dan lima kelas.

## 3. Dosen Pengampu — menilai mata kuliah yang diampu

- Melihat kelas/mata kuliah sendiri, jadwal, ruangan, dan seluruh peserta kelasnya.
- Melihat serta mengubah nilai tugas, UTS, dan UAS pada mata kuliah tersebut.
- Melihat rekap kehadiran kelas sendiri.
- Tidak mengubah nilai kelas dosen lain, KRS, biodata mahasiswa, pengaturan akademik, atau akun.
- Tidak membaca/menulis catatan bimbingan melalui role Pengampu.

**Demo:** `pengampu.rahma` → Algoritma berisi seluruh 10 mahasiswa. Rahma hanya dapat mengubah nilai Algoritma, sedangkan Basis Data dikelola `pengampu.budi`. Dosen lainnya masing-masing mempunyai satu mata kuliah dan 10 peserta yang sama.

## 4. Dosen Wali — pendamping studi mahasiswa bimbingan

- Melihat biodata, KRS, nilai semua mata kuliah, IPK, progres studi, dan simulator mahasiswa bimbingannya.
- Melihat jadwal/kelas yang diikuti mahasiswa bimbingan. Jumlah peserta dan rata-rata nilai di halaman kelas hanya dihitung dari mahasiswa bimbingan tersebut.
- Menulis catatan bimbingan dan tindak lanjut; membaca riwayat catatan yang tersimpan.
- Tidak mengubah nilai, KRS, biodata, akun, atau syarat SKS.

**Demo:** `wali.rahma` → Alya dan Arif; `wali.budi` → Bima dan Bunga; setiap wali mempunyai dua mahasiswa. Profil Rahma ini adalah orang yang sama dengan Pengampu Rahma, dengan akun dan kewenangan berbeda.

## 5. Mahasiswa — memantau studi sendiri

- Melihat biodata, KRS, lima mata kuliah, dosen pengampu, jadwal, dan ruangan.
- Membaca komponen nilai, nilai akhir, huruf, IPK, SKS, progres studi, serta memakai simulator target IPK.
- Melihat rekap kehadiran sendiri pada setiap kelas.
- Membaca catatan dan tindak lanjut dosen wali sendiri.
- Tidak melihat profil/nilai/kehadiran/catatan mahasiswa lain atau menulis nilai/KRS/bimbingan.

**Demo:** `mhs.alya` → profil Alya, 15 SKS pada lima kelas, seluruh nilainya, presensi, dan catatan dari Wali Rahma.

## Matriks akses

| Aksi | Super Admin | Admin Akademik | Pengampu | Wali | Mahasiswa |
|---|---|---|---|---|---|
| Mahasiswa | Semua | Semua | Peserta kelasnya | Bimbingannya | Diri sendiri |
| Kelas/jadwal | Semua | Semua | Kelas sendiri | Kelas bimbingan | Kelas sendiri |
| Baca nilai | Semua | Semua | Mata kuliah sendiri | Seluruh nilai bimbingan | Nilai sendiri |
| Input/edit nilai | Ya | Ya | Mata kuliah sendiri | Tidak | Tidak |
| Tambah/hapus KRS | Ya | Ya | Tidak | Tidak | Tidak |
| Tambah/edit/arsip/pulih mahasiswa | Ya | Ya | Tidak | Tidak | Tidak |
| Rekap kehadiran | Semua | Semua | Kelas sendiri | Bimbingannya | Diri sendiri |
| Baca catatan bimbingan | Semua | Tidak | Tidak | Bimbingannya | Diri sendiri |
| Tulis bimbingan/tindak lanjut | Ya | Tidak | Tidak | Bimbingannya | Tidak |
| Kelola akun/reset PIN/hubungkan profil | Ya | Tidak | Tidak | Tidak | Tidak |
| Syarat SKS dan informasi database | Ya | Ya | Tidak | Tidak | Tidak |
| Tema/ganti akun/kunci | Ya | Ya | Ya | Ya | Ya |

Direktori normal mengecualikan data sampah. Penghitungan kelas mengikuti scope akun, sehingga mahasiswa dan wali tidak memperoleh statistik nilai seluruh kelas.

## Hubungan akun dan profil

Akun bersifat lokal pada perangkat. Satu akun mempunyai satu role. Satu profil dosen mendukung dua akun: `user_id` untuk Pengampu dan `wali_user_id` untuk Wali. Mahasiswa memakai `mahasiswa.user_id`, sedangkan wali ditentukan oleh `mahasiswa.dosen_wali_id`.

Super Admin dapat menghubungkan akun dari Kelola akun. Slot role yang sudah ditempati akun lain tidak dapat diambil alih. Akun tanpa hubungan profil akan menampilkan data kosong. Di ruang demo seluruh hubungan ini sudah disiapkan.

Penegakan ada pada AuthService/AcademicService, router, dan UI. Memilih role pada login tidak mengubah role akun atau melewati verifikasi PIN. Scope berlaku juga pada ID/URL langsung.

## Yang masih belum tersedia

CRUD master melalui form, validasi KRS penuh per semester, input presensi manual/QR, KHS/transkrip PDF, backup/restore aplikasi, sinkronisasi, risiko otomatis, notifikasi nyata, dan asisten belum menjadi alur lengkap. Lihat [audit](../audit/README.md); keberadaan permission atau tabel tidak membuat modul tersebut selesai.
