# Bahan presentasi SIMAHA

Oleh Pandhu Syach Aryanto (240605110002), Muhammad Aditya Dermawan (240605110172), dan Arya Kharisudin Irfani (240605110227).

## Slide 1 Judul dan tujuan

SIMAHA Offline. Menghubungkan administrasi, pengajaran, perwalian, dan pemantauan studi melalui Flutter. Identitas fakultas, program studi, universitas dan tahun mengikuti sampul laporan.

## Slide 2 Masalah pengguna

Data mahasiswa, nilai, kehadiran dan arahan wali sering diperiksa dari tempat berbeda. Pengguna perlu memahami siapa yang dapat melihat dan mengubah setiap bagian data.

## Slide 3 Kebutuhan dan lima role

Super Admin mengelola akun; Admin Akademik mengelola data studi; Pengampu menilai kelas sendiri; Wali membimbing mahasiswa terkait; Mahasiswa memantau diri sendiri. Tunjukkan tabel akses pada panduan role.

## Slide 4 Rancangan solusi

Satu database lokal dengan hubungan akun, dosen, mahasiswa, kelas, KRS, nilai dan bimbingan. Jelaskan perbedaan satu profil dosen dan dua akun role. Demo berisi 50 mahasiswa dan 5 dosen.

## Slide 5 Implementasi Flutter

Presentation menampilkan UI; Riverpod mengelola state; go_router mengatur rute; service memeriksa role dan scope; domain menghitung nilai; Drift dan SQLCipher menyimpan data. Tunjukkan satu alur kode tanpa menampilkan kunci enkripsi atau hash PIN.

## Slide 6 Antarmuka

Tunjukkan dashboard mahasiswa dan wali, jadwal, serta status loading/kosong/kesalahan. Jelaskan referensi Stitch, font lokal, grid, teal/indigo, ponsel/desktop dan teks besar.

## Slide 7 Demonstrasi lintas role

Pengampu Rahma mengubah nilai Alya. Alya membaca hasil yang sama. Wali Rahma menulis tindak lanjut; Alya membacanya. Tunjukkan bahwa Pengampu Budi tidak memperoleh hak mengubah Algoritma.

## Slide 8 Pengujian dan temuan

Gunakan angka AKTUAL dari hasil_pengujian_otomatis.csv dan log akhir. Jelaskan satu kesalahan yang ditemukan, cara memperbaikinya, serta tes regresi. Bedakan tes otomatis dari uji pengguna nyata.

## Slide 9 Status kandidat dan batasan

Tunjukkan APK kandidat dan identitas versinya. Uji calon pengguna, uji Android fisik dan signing distribusi perlu dijelaskan menurut status nyata. Modul yang masih rencana tidak didemonstrasikan sebagai fitur selesai.

## Slide 10 Transparansi dan penutup

Cantumkan Flutter, pustaka sumber terbuka, referensi Stitch, lisensi font dan bantuan AI. Tunjukkan repositori, dokumentasi, riwayat Git serta perbaikan yang dapat dilacak. Setiap anggota harus dapat menjelaskan kode yang dipresentasikan.
