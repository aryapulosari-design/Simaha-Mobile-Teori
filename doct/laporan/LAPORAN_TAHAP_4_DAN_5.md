# TUGAS PERTEMUAN
## Laporan Tahap 4 dan Tahap 5 SIMAHA Offline

- Pandhu Syach Aryanto — 240605110002
- Muhammad Aditya Dermawan — 240605110172
- Arya Kharisudin Irfani — 240605110227

Fakultas Sains dan Teknologi, Program Studi Teknik Informatika, Universitas Islam Negeri Maulana Malik Ibrahim Malang, 2026.

## 1 Pendahuluan dan ruang lingkup

SIMAHA Offline dikembangkan sebagai aplikasi Flutter untuk menghubungkan administrasi mahasiswa, pengajaran, perwalian, dan pemantauan studi dalam satu perangkat. Masalah yang ditangani adalah data akademik yang terpisah serta ketidakjelasan kewenangan setiap pengguna ketika membaca atau memperbarui data.

Kebutuhan pengguna diterjemahkan menjadi lima peran: Super Admin menyiapkan akun; Admin Akademik mengelola data studi; Dosen Pengampu mengisi nilai kelas; Dosen Wali mendampingi mahasiswa; dan Mahasiswa memantau data dirinya. Tujuan integrasi adalah memastikan perubahan oleh satu pihak terbaca oleh pihak lain yang berwenang.

Laporan ini mencakup Tahap 4 Integrasi Pengujian dan Penyempurnaan serta Tahap 5 Finalisasi Dokumentasi dan Presentasi. Implementasi yang berjalan, hasil tes otomatis, rancangan uji pengguna, dan kekurangan disajikan secara terpisah. Kandidat aplikasi belum dinyatakan memenuhi seluruh rancangan awal sebelum semua pekerjaan tersisa dan uji pengguna ditutup.

Data demonstrasi bersifat sintetis: 50 mahasiswa, 5 dosen, 5 kelas, 250 KRS beserta nilai, 15 pertemuan, 750 catatan kehadiran, dan 50 catatan bimbingan awal. Angka 50 menyatakan data mahasiswa demo, bukan jumlah peserta penelitian pengguna.

| Aspek | Keputusan |
| --- | --- |
| Platform | Flutter native Android dan Windows; alur utama offline tanpa backend. |
| Konteks data | Program studi Informatika, semester Gasal 2026/2027, lima mata kuliah masing-masing 3 SKS. |
| Hubungan | Kelima dosen mengajar seluruh 50 mahasiswa. Setiap dosen menjadi wali bagi 10 mahasiswa. |
| Status akademik | Dokumen hasil studi lokal bukan transkrip resmi yang disahkan kampus. |
| Acuan awal | Kebutuhan awal di doct/prd/README.md dan pemeriksaan status di doct/audit/README.md. |

## 2 Rancangan integrasi dan implementasi Flutter

Integrasi mengikuti alur presentasi, layanan aplikasi, logika domain, dan penyimpanan. Widget menampilkan status serta menerima masukan; Riverpod mengelola dependensi dan pembaruan data; go_router mengelola navigasi; layanan memeriksa akun aktif dan batas data sebelum menjalankan transaksi Drift pada SQLCipher.

AcademicService menjadi batas akses untuk mahasiswa, kelas, dan nilai. CampusService menangani pengumuman, sesi serta presensi manual, dan pembacaan audit. InsightsService menyusun ringkasan dari pembacaan yang sudah diotorisasi. StudyExportService menghasilkan PDF setelah memeriksa izin dan lingkup mahasiswa.

Logika perhitungan IPK, SKS, simulasi dan risiko dipisahkan pada domain Dart. Komponen BentoCard, MetricTile, BentoGrid, ContextTag, dan WorkspacePage digunakan kembali agar warna, jarak, dan perilaku responsif konsisten. Direktori mahasiswa dipisahkan dari kartu dashboard untuk mengurangi kepadatan HomePage.

Pada mode biasa, kunci SQLCipher tetap berasal dari secure storage platform. Mode demo menggunakan file database baru simaha_demo_50.db dan preferensi khusus dengan kunci acak yang disimpan bersama preferensi demo. Penyimpanan demo ditujukan hanya untuk data sintetis yang terbuka dan tidak memiliki tingkat perlindungan yang sama dengan mode biasa. Demo tidak membuka secure storage produksi.

| Komponen | Tanggung jawab |
| --- | --- |
| Presentation | Halaman login, dashboard lima peran, kelas, mahasiswa, presensi, pengumuman, insight dan pengaturan. |
| Riverpod dan router | Status sesi, pemuatan ulang setelah perubahan, navigasi, serta penolakan rute admin. |
| Domain | Nilai berbobot 30/30/40, konversi huruf, IPK nilai terbaik, SKS, simulasi, risiko dan validasi. |
| Data | SQLCipher melalui Drift, hubungan akun-profil, transaksi, layanan akses, seed idempoten dan audit. |
| Keamanan | PIN PBKDF2 dengan salt, lockout bertahap, auto-lock, batas per role, dan pemisahan demo. |

## 3 Hubungan lima peran dan data demonstrasi

Setiap akun mempunyai satu role. Satu profil dosen dapat terhubung dengan dua akun berbeda untuk tugas Pengampu dan Wali. Pembagian ini menjaga agar kewenangan memberi nilai berbeda dari kewenangan membaca seluruh hasil studi mahasiswa bimbingan.

Contoh integrasi: Pengampu Rahma mengubah nilai Algoritma milik Alya. Mahasiswa Alya membaca nilai yang sama dan ringkasan studinya diperbarui. Wali Rahma menulis tindak lanjut bimbingan; Alya membaca catatan tersebut. Pengampu Budi tidak dapat mengubah nilai Algoritma dan Wali Budi tidak dapat membuka bimbingan Alya.

Login demo cukup memilih role serta nama akun dari daftar, kemudian menggunakan PIN awal 123456. Terdapat 62 akun: satu Super Admin, satu Admin Akademik, lima Pengampu, lima Wali, dan 50 Mahasiswa. Seeder berjalan sekali; perubahan tersimpan ketika aplikasi dibuka kembali.

| Peran | Fungsi dan batas akses |
| --- | --- |
| Super Admin | Kelola akun, reset PIN, hubungkan profil, seluruh data akademik, bimbingan, serta audit. |
| Admin Akademik | Kelola mahasiswa, KRS/nilai, seluruh kelas, presensi dan pengumuman. Tidak mengelola akun atau catatan bimbingan. |
| Dosen Pengampu | Kelas sendiri, nilai peserta, sesi dan presensi kelas sendiri. Tidak membaca IPK kumulatif atau catatan wali. |
| Dosen Wali | Profil, nilai, IPK, insight dan kehadiran 10 mahasiswa bimbingan; menulis catatan serta tindak lanjut. |
| Mahasiswa | Profil, mata kuliah, jadwal, nilai, insight, rekap kehadiran dan catatan wali sendiri; unduh PDF hasil studi. |

## 4 Tahap 4 Skenario dan kasus pengujian

Pengujian meliputi perhitungan domain, layanan pada database sementara, otorisasi lima role, integrasi perubahan antarakun, validasi masukan, navigasi serta widget responsif. Pengujian otomatis menggunakan data sintetis dan tidak menggantikan pengujian pada calon pengguna.

Kasus disusun dengan prasyarat, langkah, hasil yang diharapkan, serta bukti. Daftar hasil setiap tes aktual diekspor ke hasil_pengujian_otomatis.csv. Log mentah tersedia pada bukti/tests.jsonl. Pengujian antarmuka tambahan mencakup desktop, tablet, ponsel, tema gelap, serta teks 160 persen pada lebar 320 piksel.

| ID | Skenario dan hasil yang diharapkan |
| --- | --- |
| TC-01 | Login akun benar; role dan profil yang terhubung sesuai. PIN salah ditolak dan lockout meningkat. |
| TC-02 | Seluruh 62 akun demo menerima PIN awal dan role yang terdokumentasi. |
| TC-03 | Lima pengampu masing-masing melihat 50 peserta; nilai kelas dosen lain ditolak. |
| TC-04 | Lima wali masing-masing memperoleh 10 mahasiswa berbeda; seluruh 50 mahasiswa tercakup. |
| TC-05 | Mahasiswa hanya membaca profil, nilai, kehadiran dan bimbingan dirinya. |
| TC-06 | Perubahan nilai Pengampu terbaca oleh Mahasiswa, Wali, Admin Akademik dan Super Admin. |
| TC-07 | Catatan bimbingan Wali terbaca mahasiswa terkait; akses pihak lain ditolak. |
| TC-08 | Presensi disimpan, diperbarui tanpa duplikasi, dan terbaca mahasiswa serta wali terkait. |
| TC-09 | Status presensi tidak valid, peserta asing dan penulisan oleh role tanpa izin ditolak. |
| TC-10 | Pengumuman admin terbaca role lain; masukan pendek dan publikasi mahasiswa ditolak. |
| TC-11 | PDF menghasilkan struktur PDF nyata; ekspor mahasiswa lain serta ekspor Pengampu ditolak. |
| TC-12 | Data arsip hilang dari pencarian, dapat dipulihkan, dan indeks pencarian tetap konsisten. |
| TC-13 | Navigasi admin ditolak bagi mahasiswa; tema berubah tanpa mereset rute aktif. |
| TC-14 | Demo tidak mengubah file mode biasa; preferensi persisten dan masukan NaN ditolak. |

## 5 Tahap 4 Tabel hasil pengujian

Pada bukti pengujian yang dipakai saat laporan dibangun tercatat 136 tes berhasil, 0 tes gagal atau error, dan 0 tes berstatus skipped. Status akhir runner adalah lulus. Angka ini berasal dari log, bukan jumlah skenario manual.

Kelulusan tes otomatis menunjukkan perilaku dalam kondisi uji yang didefinisikan. Pengujian perangkat fisik, pemindai QR, kehilangan perangkat, pemulihan kunci produksi, benchmark 10000 mahasiswa, pembaca layar, serta evaluasi calon pengguna belum dapat dianggap lulus tanpa bukti tambahan.

| Pemeriksaan | Hasil atau bukti |
| --- | --- |
| Unit dan integrasi layanan | 136 berhasil; rincian pada CSV dan bukti/tests.jsonl. |
| Analisis statis | Bersih |
| Widget responsif | Lihat bukti/widget-previews.log dan PNG pada doct/design/previews. |
| Build Windows | Berhasil |
| Build Android kandidat | Berhasil; lihat manifest artefak. |
| Uji calon pengguna | Belum dilaksanakan. Jumlah responden yang sudah menguji: 0. |
| Uji Android fisik | Belum ada bukti pengujian langsung pada perangkat fisik. |
| Pengujian ulang | Dilakukan setelah perbaikan API ekspor dan perapian UI; bukti akhir disimpan terpisah dari kegagalan awal. |

## 6 Tahap 4 Kesalahan dan dokumentasi perbaikan

Masalah dicatat berdasarkan temuan pada kode, kompilasi, atau pemeriksaan visual. Perbaikan kemudian diperiksa menggunakan tes yang relevan. Temuan lama terkait secure storage produksi tidak ditutup hanya karena mode demo dapat dijalankan.

| ID | Temuan | Perbaikan dan status |
| --- | --- | --- |
| BUG-01 | Demo membuka penyimpanan kunci yang sama dengan mode biasa; konteks Windows berbeda memicu kegagalan DPAPI. | Database dan DemoStore khusus, tanpa pemanggilan secure storage produksi. Uji isolasi lulus. Pembukaan ulang data produksi lama masih memerlukan verifikasi. |
| BUG-02 | Pemanggilan FilePicker.platform tidak tersedia pada versi 13.1.0 sehingga build gagal. | Menggunakan FilePicker.saveFile dengan bytes dan MIME PDF. Jalankan ulang analyzer, tes, serta build. |
| BUG-03 | Normalisasi risiko tidak sesuai rumus yang tertulis pada aturan proyek. | Fungsi IPK, kehadiran, tren dan SKS menggunakan normalisasi linear yang disepakati; regresi menguji titik tengah tiap faktor. |
| BUG-04 | Validator angka menerima NaN karena perbandingan rentang saja tidak mencukupi. | Pemeriksaan isFinite pada validator dan mesin nilai; kasus NaN dan Infinity ditolak. |
| BUG-05 | Kartu metrik berbeda tinggi dan kartu jadwal menyusut pada desktop. | Grid menyamakan tinggi per baris dan jadwal membentang mengikuti lebar kartu. Diperiksa pada preview aktual. |
| BUG-06 | Penghapusan atau perubahan data perlu memperbarui ringkasan lintas halaman. | Provider ringkasan studi diinvalidasi setelah simpan nilai dan presensi, lalu membaca ulang data terotorisasi. |
| BUG-07 | Konfigurasi desugaring Android belum tersedia untuk dependensi notifikasi. | Konfigurasi diperbaiki dan paket/izin yang belum dipakai dihapus. Build diulang dari dependensi aktif. |
| BUG-08 | Build release memuat plugin integration_test yang tidak tersedia. | Dependensi yang belum dipakai dilepas, registrant diregenerasi dan verifikasi Flutter dijalankan berurutan. |
| BUG-09 | Desktop terkelola menolak penulisan demo ke Documents. | Folder demo dapat diarahkan melalui SIMAHA_DEMO_DIRECTORY; tes membuktikan file mode biasa tidak berubah. |

## 7 Tahap 4 Rencana dan hasil pengujian pengguna

Pengujian calon pengguna belum dilaksanakan. Tidak ada skor kepuasan, kutipan komentar, jumlah keberhasilan tugas, maupun nilai SUS yang dapat dilaporkan sebagai hasil nyata. Lima puluh mahasiswa di database adalah data demonstrasi dan bukan responden.

Rencana pelaksanaan melibatkan beberapa calon pengguna, disarankan 5 sampai 8 orang dengan variasi pengalaman menggunakan aplikasi akademik. Peserta menggunakan akun sintetis. Fasilitator menjelaskan tujuan, meminta persetujuan, dan mencatat tugas tanpa mengumpulkan identitas pribadi yang tidak diperlukan.

Setiap peserta diminta memilih role dan login, menemukan jadwal, membuka nilai serta kehadiran, mencoba alur perubahan nilai dan catatan wali sesuai role, berganti akun, serta menemukan pengumuman. Catat keberhasilan, waktu penyelesaian, kebutuhan bantuan, kesalahan, dan komentar. Hindari memberi petunjuk sebelum peserta mencoba.

Sesudah tugas, peserta menilai kemudahan login, kejelasan navigasi, keterbacaan, pemahaman role dan kepuasan keseluruhan pada skala 1 sampai 5. Rata-rata baru dihitung setelah data nyata terkumpul. Temuan dikelompokkan menurut dampak, diperbaiki, dan diuji ulang sebelum penetapan versi final.

| Instrumen | Status dan lokasi |
| --- | --- |
| Skenario moderator | Disediakan dalam doct/laporan/UJI_PENGGUNA.md. |
| Form per peserta | Disediakan dengan ID anonim, tugas, waktu, hasil, bantuan dan komentar. |
| Tabel hasil responden | Kosong; status belum dilaksanakan. Tidak diisi memakai data simulasi. |
| Kesimpulan usability | Menunggu pengujian nyata; belum ada klaim mudah digunakan secara empiris. |
| Bukti pelaksanaan | Tanggal, persetujuan, lembar hasil dan dokumentasi yang diizinkan peserta perlu ditambahkan. |

## 8 Tahap 4 Penyempurnaan antarmuka

Acuan visual berasal dari folder Stitch yang disediakan pengguna. Prinsip yang diterapkan adalah latar abu kebiruan #F8F9FF, kartu putih, teal #00685F, aksen indigo, garis pembatas halus, grid berjarak konsisten, dan tipografi lokal. Plus Jakarta Sans digunakan untuk judul, Inter untuk teks, serta JetBrains Mono untuk label kode.

Dashboard dibedakan berdasarkan tugas. Mahasiswa melihat IPK, beban studi, progres dan kehadiran pribadi. Pengampu melihat kelas serta kelengkapan nilai. Wali melihat bimbingan dan prioritas pendampingan. Admin memperoleh ringkasan lintas kelas dan akses pengelolaan.

Navigasi ponsel menggunakan empat tujuan utama; pengelolaan akun dan database tetap dapat diakses admin melalui halaman terkait. Komponen menyediakan status loading, data kosong, kesalahan dan percobaan ulang. Elemen interaktif mengarah ke fungsi yang sudah terhubung; tampilan referensi tidak digunakan untuk mengklaim fitur yang belum dibuat.

## 9 Tahap 5 Finalisasi dan paket penyerahan

Paket penyerahan memuat kode sumber Flutter, dokumentasi peran dan arsitektur, bukti pengujian, APK kandidat bila build berhasil, serta laporan ini. Repositori proyek menggunakan tautan yang diberikan kelompok. Artefak yang belum mempunyai bukti diberi status belum dilaksanakan atau belum tersedia.

APK kandidat dibuat melalui build release untuk demonstrasi data sintetis. Konfigurasi proyek saat ini masih memakai sertifikat debug pada build release, sehingga belum dinyatakan sebagai paket distribusi produksi. Identitas signing milik kelompok dan uji perangkat perlu diselesaikan sebelum publikasi final.

Penetapan aplikasi final membutuhkan penutupan pekerjaan tersisa, evaluasi calon pengguna, pemeriksaan Android fisik dan verifikasi penyimpanan produksi. Modul tambahan pada rancangan awal seperti QR, backup/restore, sinkronisasi, impor/ekspor menyeluruh, EDOM, arsip dan asisten belum otomatis dianggap selesai.

| Luaran | Kondisi |
| --- | --- |
| Aplikasi yang dijalankan | Build Windows dan Android diperiksa berdasarkan log; hasil Android fisik belum tersedia. |
| File APK | Kandidat demo pada artifacts bila build berhasil; nama dan SHA256 dalam manifest. |
| Kode dan Git | https://github.com/aryapulosari-design/Simaha-Mobile-Teori |
| Dokumentasi teknis | README.md serta doct/architecture, roles, features, demo, security, testing dan audit. |
| Laporan akhir | Dokumen Tahap 4 dan Tahap 5 ini serta sumber yang dapat diperbarui. |
| Video demonstrasi | Naskah dan daftar adegan disediakan; rekaman demonstrasi nyata masih perlu dibuat. |
| Bahan presentasi | Outline presentasi tersedia dalam doct/laporan/PRESENTASI.md. |
| Demonstrasi langsung | Skenario disediakan; pelaksanaan presentasi langsung menjadi tugas kelompok. |

## 10 Transparansi sumber dan kesiapan presentasi

Pengembangan memakai Flutter dan Dart beserta pustaka sumber terbuka yang tercantum pada pubspec.yaml dan pubspec.lock. Referensi visual berasal dari ekspor Stitch milik pengguna. Font Inter, Plus Jakarta Sans dan JetBrains Mono dibundel bersama lisensi OFL masing-masing.

Bantuan kecerdasan artifisial digunakan dalam penyusunan dan perapian kode, penulisan pengujian, pemeriksaan implementasi serta penyusunan dokumentasi. Kelompok wajib meninjau, menjalankan, memahami, dan mampu menjelaskan kode yang diserahkan. Bantuan AI tidak dipakai untuk mengarang hasil uji pengguna, riwayat kegiatan atau bukti pelaksanaan tahap.

Presentasi mengikuti hubungan masalah, kebutuhan pengguna, rancangan solusi, implementasi Flutter, pengujian dan hasil aplikasi. Setiap anggota perlu dapat menjelaskan alur data yang didemonstrasikan, pemisahan role, provider, transaksi database, validasi serta batas versi kandidat.

Riwayat Git dan dokumen PROGRESS.md dipertahankan sebagai bukti perkembangan yang benar-benar tersedia. Laporan ini tidak menyatakan bahwa seluruh Tahap 1 sampai Tahap 5 sudah dinilai atau dilaksanakan pada tanggal tertentu tanpa bukti dari kelompok.

| Sumber | Pemakaian dan pengakuan |
| --- | --- |
| Flutter dan Dart | Framework UI dan bahasa aplikasi. Versi lingkungan tercatat pada hasil pemeriksaan toolchain. |
| Riverpod dan go_router | Pengelolaan dependensi, state dan navigasi. |
| Drift dan SQLCipher | Penyimpanan relasional lokal serta enkripsi database. |
| cryptography dan flutter_secure_storage | Hash PIN serta penyimpanan kunci platform pada mode biasa. |
| pdf dan file_picker | Pembuatan serta penyimpanan hasil studi PDF. |
| Stitch dan Google Fonts | Acuan tampilan dan font lokal berlisensi OFL. |
| Bantuan AI | Asistensi implementasi dan dokumentasi; tanggung jawab akademik tetap pada kelompok. |
