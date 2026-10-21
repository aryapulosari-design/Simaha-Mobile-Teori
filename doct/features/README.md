> Pembaruan 21 Oktober 2026: lihat bagian fitur baru di bawah; uraian fondasi lama yang terkait telah digantikan.

# Fitur dan alur penggunaan

## Demo terhubung

[Jalankan ruang demo](../demo/README.md) untuk langsung memakai lima role. Semua akun sudah mempunyai data: 5 dosen, 50 mahasiswa, 5 kelas, 250 KRS/nilai, 750 presensi, dan 50 catatan bimbingan awal. PIN awal 123456.

## Yang sudah dapat digunakan

| Fitur | Perilaku aktual |
|---|---|
| Setup | Super Admin, PIN enam digit, kode pemulihan satu kali. |
| Login | Pilih salah satu dari lima role, pilih akun aktif sesuai role, lalu keypad PIN; akun terakhir dipilih otomatis. Username tidak perlu diketik. |
| Kunci | Manual, idle lima menit, serta ketika aplikasi tidak aktif/background. |
| Lockout | Setelah lima kegagalan: 30 detik, 60, 120, dst., maksimal 900 detik. |
| Akun lokal | Super Admin membuat akun, aktif/nonaktif akun lain, reset PIN, memilih lima role. |
| Hubungkan profil | Mengaitkan akun mahasiswa/dosen dengan profil untuk menentukan scope data. |
| Beranda | Judul, statistik, menu, dan aksi sesuai role. |
| Statistik | Jumlah mahasiswa, status aktif, dan prodi dalam lingkup akun; arsip dikecualikan. |
| Pencarian | Nama/NIM dengan FTS5, pencocokan awalan, debounce 250 ms. |
| Pagination | Awal 20 data, tombol memuat 20 tambahan. |
| Mahasiswa | Tambah/edit NIM, nama, prodi, angkatan, status, kontak, dosen wali. NIM tidak dapat diubah setelah dibuat. |
| Validasi | NIM unik, field wajib, format email/HP, rentang angkatan; diperiksa juga di service. |
| Sampah | Soft delete dan pemulihan oleh admin. |
| Detail | Biodata, KRS, komponen nilai, ringkasan studi sesuai akses. |
| Nilai | Input/edit tugas, UTS, UAS; hitung akhir 30/30/40 dan konversi huruf A–E. |
| KRS sederhana | Admin menambah kelas beserta nilai atau menghapus KRS dan nilainya. |
| IPK/SKS | IPK menggunakan nilai terbaik per kode MK, SKS, progres syarat kelulusan. |
| Simulasi | Estimasi IPS yang diperlukan untuk target IPK dan rencana SKS. |
| Pengaturan | Syarat SKS kelulusan dapat diedit admin, default 144. Parameter lain terutama informasi. |
| Tema | Terang/gelap, awal sesi mengikuti sistem. |
| Kelas dan jadwal | Halaman Akademik: mata kuliah, pengampu, jadwal/ruangan, rata-rata nilai, peserta sesuai scope. |
| Rekap kehadiran | Detail kelas menampilkan hadir/izin/sakit/alpa dari database, sesuai scope role. |
| Bimbingan | Wali/Super Admin menambah catatan dan tindak lanjut; mahasiswa terkait dapat membacanya. |
| Panduan peran | Tugas, seluruh aksi yang tersedia, batas akses, contoh alur, dan tombol Ganti akun. |
| Database | Lokasi file, jumlah master, informasi enkripsi tanpa key, khusus admin. |

Foto belum memiliki pemilih/unggah. Master prodi/dosen/MK/tahun ajaran/kelas berasal dari seeder; halaman CRUD master belum ada.

## Cara memakai

**Mahasiswa:** masuk sebagai admin → Tambah mahasiswa → isi form → simpan → cari nama/NIM → buka detail. Menu baris menyediakan Edit profil atau Pindahkan ke sampah. Pemulihan melalui Tempat sampah.

**Nilai:** masuk sebagai admin atau Dosen Pengampu → buka mahasiswa yang diizinkan → Input/Edit. Nilai harus terbatas 0–100; NaN/infinity ditolak service. Dosen hanya dapat mengubah nilai kelas yang diampunya. Tambah/hapus KRS khusus admin.

**Akun dosen/mahasiswa:** Super Admin membuat akun → Hubungkan profil → kunci → masuk sebagai akun baru. Mahasiswa membaca data sendiri; wali membaca bimbingannya; pengampu hanya melihat mahasiswa serta nilai kelas yang diampu.

## Batasan akademik

- KRS masih memakai validasi sederhana total SKS/IPK di UI; belum batas per semester dari IPS sebelumnya di service.
- Fungsi bentrok jadwal tersedia terpisah; prasyarat/bentrok belum dihubungkan ke KRS.
- Fungsi IPS per semester ada pada domain; UI belum menampilkan riwayat semester.
- SKS lulus saat ini menganggap semua huruf selain E lulus, termasuk D; aturan kampus lain belum diterapkan.
- Indikator kelulusan hanya berdasarkan SKS/IPK/status; belum memeriksa syarat administratif/tugas akhir.
- Dosen Pengampu tidak diberi ringkasan IPK/simulator dari nilai kelas yang terbatas agar tidak terbaca sebagai IPK kumulatif.
- Simulator memakai total SKS pembentuk IPK, termasuk mata kuliah bernilai E, dengan percobaan terbaik per kode MK.
- Simulator merupakan estimasi aritmetika, bukan keputusan akademik resmi.

## Fondasi, belum menjadi fitur lengkap

| Modul | Yang ada | Yang belum tersedia |
|---|---|---|
| QR presensi | HMAC dan token pada domain | Sesi/pemindai QR belum dihubungkan; rekap serta input manual sudah tersedia |
| Presensi manual | Sesi kelas, pilihan hadir/izin/sakit/alpa, simpan dan rekap | Pemindai QR belum tersedia |
| Risiko | Ringkasan IPK, kehadiran, tren IPS dan skor transparan | Target SKS tertinggal dan notifikasi belum terhubung |
| CSV | Parser/preview/validasi baris | File picker, UI preview, commit ke DB |
| Excel/PDF | PDF hasil studi dapat disimpan | Impor Excel, ekspor CSV/Excel dan KHS per semester belum tersedia |
| Backup `.simaha` | Enkripsi/dekripsi bytes AES-GCM dan checksum | Snapshot database, picker/share, restore atomik, pemulihan key |
| Sinkronisasi | Merge last-write-wins dan hasil konflik | Paket delta, pertukaran/penerapan data, log UI |
| Asisten | Parser intent dan template ringkasan | Halaman tanya jawab dan query DB sesuai scope |
| LLM | Interface dan fallback `NoopLlm` | Model/provider nyata |
| Notifikasi | Interface dan `NoopNotifications` di memori | Plugin nyata, izin, penjadwalan, trigger akademik |
| Agenda/ujian/prestasi/EDOM/arsip | Schema tabel | Layar dan alur belum tersedia; pengumuman sudah dapat diterbitkan/dibaca |

Audit log saat ini mencatat sejumlah aksi autentikasi serta pengaitan profil dan penambahan catatan bimbingan. Belum seluruh perubahan mahasiswa/nilai dan belum ada halaman pembaca audit.

Lihat [matriks lengkap FR/NFR](../audit/README.md).

## Fitur terintegrasi 21 Oktober 2026

- Dashboard Stitch berbeda untuk tiap role dengan metrik dari data yang diotorisasi, jadwal dan tautan aksi.
- Pengampu/admin menambah pertemuan dan mencatat presensi manual. Status dapat diperbaiki tanpa duplikasi; mahasiswa dan wali membaca rekap sesuai lingkupnya.
- Admin menerbitkan/menghapus pengumuman; seluruh akun aktif dapat membacanya.
- Mahasiswa/wali/admin melihat insight studi dan IPS berdasarkan semester yang tersedia. Skor risiko memakai rumus domain; komponen SKS tertinggal nol karena target semester belum ditetapkan. Data kosong ditandai belum tersedia.
- Mahasiswa/wali/admin dapat menyimpan PDF ringkasan hasil studi lokal. Pengampu tidak mendapat transkrip kumulatif. Dokumen bukan transkrip resmi kampus.
- Super Admin membaca 100 aktivitas audit terakhir. Pencatatan mutasi akademik belum seluruhnya lengkap.
- Font dibundel offline dan paket/izin untuk fitur yang belum dipakai dihapus agar build lebih bersih.
