# Audit kesesuaian README dan implementasi

Tanggal: **20 Oktober 2026**. Acuan kebutuhan: [PRD asli](../prd/README.md). Acuan kondisi aktual: kode, route, wiring provider/service, serta tes yang benar-benar dijalankan.

**Hasil: belum seluruhnya sesuai PRD.** Tabel/service/dependency tanpa alur pengguna tidak dinilai sebagai fitur lengkap. README utama sekarang menjelaskan kemampuan aktual; seluruh kebutuhan lama tetap disimpan sebagai target di arsip.

## Kebutuhan fungsional

| ID | Kebutuhan PRD | Status | Bukti dan kekurangan |
|---|---|---|---|
| FR-01 | Setup Super Admin/PIN | Tersedia | SetupPage → AuthService, recovery code satu kali. |
| FR-02 | PIN dan/atau biometrik | Sebagian | Pemilih role/akun aktif dan PIN berjalan; local_auth dinonaktifkan, sensor belum ada. |
| FR-03 | RBAC lima role | Tersedia pada alur aktif | AcademicService/AuthService, router/UI, tes scope lima role. Modul yang belum dibuat tetap memerlukan otorisasi saat diimplementasikan. |
| FR-04 | Auto-lock, timeout dapat diatur | Sebagian | Idle lima menit/background; timeout belum dapat diubah pengguna. |
| FR-05 | Lockout PIN | Tersedia | Lima gagal →30 detik, meningkat hingga 15 menit; auth tests. |
| FR-06 | Kelola akun | Tersedia | Buat, status aktif, reset PIN, hubungkan profil; Super Admin. |
| FR-07 | CRUD mahasiswa lengkap termasuk foto | Sebagian | Field utama tersedia; pemilih foto belum ada. |
| FR-08 | Validasi mahasiswa | Tersedia | Form/service dan NIM unik DB; email/HP/rentang angkatan. |
| FR-09 | Sampah/pemulihan | Tersedia | Soft delete/restore; FTS dan counts diuji setelah mutasi. |
| FR-10 | CRUD master | Fondasi | Schema dan seed; hanya daftar pilihan master, belum halaman CRUD. |
| FR-11 | FTS dan filter multikriteria | Sebagian | Cari nama/NIM, scope/pagination; UI filter angkatan/prodi/status belum ada. |
| FR-12 | Filter favorit | Fondasi | Tabel saved_filters; belum alur simpan/pakai filter. |
| FR-13 | KRS, batas dari IPS sebelumnya | Sebagian | Tambah/hapus KRS; UI masih validasi sederhana IPK/total SKS, belum per semester di service. |
| FR-14 | Prasyarat/bentrok | Fondasi | Fungsi cek bentrok dan tabel prasyarat; belum terhubung ke KRS. |
| FR-15 | Nilai berbobot/huruf | Tersedia | 30/30/40; nilai terbatas 0–100 di service; dosen dibatasi kelas. |
| FR-16 | IPS/IPK/total SKS | Sebagian | IPK/SKS UI tersedia; IPS per semester baru fungsi domain. |
| FR-17 | KHS/transkrip PDF | Belum | Dependency PDF tidak disertai template/export UI. |
| FR-18 | Kalender jadwal mingguan | Sebagian | Jadwal per kelas, hari/jam/ruangan tersedia di Akademik; kalender mingguan visual belum ada. |
| FR-19 | Sesi dan QR dosen | Fondasi | Token HMAC dan tabel; belum sesi/QR UI. |
| FR-20 | Scan QR mahasiswa | Belum | Dependency mobile_scanner belum terhubung ke alur. |
| FR-21 | Presensi manual | Fondasi | Tabel; belum form/service penyimpanan presensi. |
| FR-22 | Rekap kehadiran | Tersedia | Query persisten dan UI detail kelas menampilkan hadir/izin/sakit/alpa sesuai scope; input manual/QR masih terpisah. |
| FR-23 | Dashboard analitik lengkap | Sebagian | Jumlah mahasiswa/aktif/prodi; belum distribusi/tren/rata-rata IPK. |
| FR-24 | Early warning | Fondasi | Fungsi risiko/level; belum data nyata, daftar dan tindak lanjut. |
| FR-25 | Skor risiko transparan | Fondasi | Fungsi hitung dan test; belum hasil per mahasiswa pada aplikasi. |
| FR-26 | Catatan bimbingan | Tersedia | Tambah catatan/tindak lanjut oleh Wali/Super Admin, riwayat dibaca mahasiswa terkait; scope dan audit diuji. |
| FR-27 | Impor CSV/Excel preview | Fondasi | Parser CSV/validasi; belum picker/preview UI/commit; Excel belum ada. |
| FR-28 | Ekspor CSV/Excel/PDF | Belum | Belum alur export. |
| FR-29 | Backup database `.simaha` | Fondasi | Enkripsi bytes AES-GCM; belum ekstraksi/snapshot DB dan simpan file. |
| FR-30 | Restore/integritas | Fondasi | Dekripsi/checksum bytes; belum restore database/key secara atomik. |
| FR-31 | Sync antarperangkat | Fondasi | Merge domain; belum transport/paket delta/penerapan DB. |
| FR-32 | Konflik LWW dan log | Fondasi | Merge deterministik dan hasil konflik; belum log/pilihan UI. |
| FR-33 | Audit semua perubahan | Sebagian | Auth/linking/bimbingan dicatat; mutasi akademik belum seluruhnya. |
| FR-34 | Tanya data bahasa natural | Fondasi | Parser; belum halaman asisten/query nyata. |
| FR-35 | Intent menjadi filter SQL | Fondasi | Filter terstruktur; belum executor query DB yang terhubung. |
| FR-36 | Ringkasan otomatis | Fondasi | Template narasi, belum integrasi data/UI asisten. |
| FR-37 | LLM opsional | Belum | Interface/fallback NoopLlm, tidak ada model/provider nyata. |
| FR-38 | Notifikasi lokal | Fondasi | Interface/Noop di memori; belum plugin/scheduling nyata. |
| FR-39 | Tema dan ID/EN | Sebagian | Tema terang/gelap; bahasa Indonesia, EN/l10n belum ada. |
| FR-40 | Pengaturan timeout/ambang/bobot | Sebagian | Syarat SKS bisa disimpan; timeout/risiko/bobot masih informasi/konstanta. |

Modul tambahan dalam schema (pengumuman, agenda, ujian, prestasi, EDOM, arsip dokumen) juga masih fondasi tanpa halaman pengguna.

## Kebutuhan nonfungsional

| ID | Target | Hasil audit |
|---|---|---|
| NFR-01 | SQLCipher/key secure storage | Terimplementasi; tes key benar/salah/tanpa key. Penyimpanan platform fisik belum diuji lintas OS. |
| NFR-02 | Hash PIN + salt | PBKDF2-HMAC-SHA256, default 100.000 iterasi, salt acak; tes hash/verifikasi. |
| NFR-03 | Backup AES-GCM/checksum | Teruji pada bytes; belum alur backup database. |
| NFR-04 | Screenshot/recent apps | Channel Android dan SecureScope tersedia; efek pada perangkat Android belum diverifikasi. |
| NFR-05 | Data tidak keluar tanpa aksi pengguna | Tidak ditemukan client HTTP/cloud pada alur aplikasi yang tersedia. Bukan audit jaringan perangkat. |
| NFR-06 | 10.000 pencarian ≤500 ms/cold start ≤3 detik | Belum diverifikasi pada target 10.000 dan perangkat fisik; tes seed lama memakai 100 mahasiswa. |
| NFR-07 | Pagination/isolate | Muat +20 dan seeder payload isolate tersedia; pekerjaan DB/crypto lain belum semuanya di isolate. |
| NFR-08 | Fitur inti offline | Alur yang tersedia memakai data lokal; seluruh fitur inti PRD belum selesai, sehingga pemenuhan PRD keseluruhan belum dapat dinyatakan. |
| NFR-09 | Transaksi atomik | Ada transaksi pada KRS/seed/linking; belum fault-injection/crash testing menyeluruh. |
| NFR-10 | Migrasi tanpa kehilangan data | Migrasi berversi dan tes tersedia; belum seluruh kombinasi upgrade produksi diuji. |
| NFR-11 | Material 3/aksesibilitas/SUS ≥68 | Material 3, tes responsive/teks 160%/gelap; SUS dan audit pembaca layar belum dilakukan. |
| NFR-12 | Android API26+, ponsel/tablet | minSdk 26 dikonfigurasi; layout widget diuji, uji Android fisik belum dilakukan. |
| NFR-13 | Clean Architecture/coverage ≥70% | Pemisahan folder ada; belum repository/usecase penuh, angka coverage logika inti belum diukur. |
| NFR-14 | APK ≤50 MB | Belum ada pengukuran APK release pada audit ini. |

## Perbaikan yang dilakukan saat audit

- Menata ulang dokumentasi; mempertahankan PRD asli dan menandai gap secara eksplisit.
- Mendesain ulang tema, beranda, shell responsive, auth background, status gelap, serta menyingkirkan teks tahap pengembangan dari beranda.
- Menjaga instance router saat tema berubah; membatasi route admin dan jalur setup ketika aplikasi terkunci.
- Menambahkan AcademicService untuk scope per data, izin mutasi, dan validasi input mahasiswa/nilai.
- Membatasi dosen pengampu ke kelasnya, wali ke bimbingannya, mahasiswa ke data sendiri; statistik memakai scope yang sama.
- Menambahkan UI hubungan akun/profil, otorisasi Super Admin, dan penolakan profil yang ditempati akun lain.
- Menghapus tombol dan helper akses Super Admin tanpa PIN.
- Mengeluarkan sampah dari counts, menghapus penulisan FTS ganda saat hapus/pulih, menjaga seeder tidak menganggap semua data arsip sebagai instalasi kosong.
- Menjaga scope FLAG_SECURE selama transisi halaman; tidak menampilkan IPK parsial kepada pengampu; memperbaiki dasar SKS simulator.
- Memperbaiki pesan failure agar informasi validasi dapat dibaca pengguna.
- Menambahkan regression test otorisasi dan layout serta pratinjau dari widget Flutter.

## Pembaruan demo dan role

- Ruang demo terpisah: 22 akun login, 5 dosen, 10 mahasiswa, 5 kelas, 50 KRS/nilai, 15 pertemuan, 150 presensi, 10 catatan bimbingan.
- Satu profil dosen mendukung akun Pengampu dan Wali dengan schema/migrasi v5.
- Nilai dan catatan dipakai bersama lintas role; scope kelas/wali/mahasiswa diuji.
- Login demo cukup pilih role dan nama lalu Masuk akun demo; PIN awal 123456 tetap diverifikasi.
- Beranda memiliki fungsi peran, tombol ganti akun, dan akses kelas/jadwal.
- [Panduan semua akun demo](../demo/README.md) memuat data dan skenario yang dapat dicoba.

## Prioritas tersisa

1. KRS per semester dari IPS sebelumnya; validasi prasyarat/bentrok di service dan transaksi.
2. CRUD master dan pengaitan kelas/dosen melalui UI.
3. Presensi manual/QR lengkap serta rekap persisten.
4. Snapshot backup/restore aplikasi, integritas, key/recovery dan uji kehilangan perangkat.
5. KHS/transkrip PDF, impor/ekspor, audit mutasi akademik.
6. Risiko otomatis, kalender visual/notifikasi nyata, asisten terhubung database.
7. Bahasa, biometrik, pengaturan persisten lengkap.
8. Uji Android, signing distribusi, benchmark 10.000, coverage, SUS, ukuran APK.

Lihat [hasil verifikasi](verification.md) untuk perintah yang selesai dan batas pengujian.
