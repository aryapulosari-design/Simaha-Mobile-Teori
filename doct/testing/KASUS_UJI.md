# Kasus uji terstruktur

Dataset prasyarat: ruang demo 50 mahasiswa dan 5 dosen sudah dibuat. PIN awal 123456, profil Alya terhubung dengan Wali Rahma, dan Algoritma diampu Rahma. Data berubah pada database sementara untuk tes otomatis; pelaksanaan manual terpisah belum diklaim.

| ID | Prasyarat | Langkah dan masukan | Hasil yang diharapkan | Bukti otomatis |
|---|---|---|---|---|
| TC-01 | Akun aktif tersedia | Pilih role dan akun; isi PIN yang benar | Sesi memakai ID serta role akun terverifikasi | auth_test.dart, login_picker_test.dart |
| TC-02 | PIN awal belum diubah | Verifikasi seluruh 62 username dengan 123456 | Seluruh akun masuk dengan role dan hubungan profil benar | demo_workspace_test.dart |
| TC-03 | Masuk sebagai Pengampu Rahma | Buka Algoritma dan daftar peserta; coba ID kelas Budi | 50 peserta pada kelas sendiri; kelas Budi ditolak | demo_workspace_test.dart |
| TC-04 | Masuk bergantian sebagai lima wali | Baca daftar bimbingan tiap wali | Masing-masing 10 mahasiswa, tanpa tumpang tindih, total 50 | demo_workspace_test.dart |
| TC-05 | Masuk sebagai Alya | Baca profil sendiri, lalu coba ID Arif | Profil Alya tersedia; data Arif ditolak | academic_access_test.dart, demo_workspace_test.dart |
| TC-06 | KRS Algoritma Alya tersedia | Pengampu Rahma mengisi tugas 95, UTS 94, UAS 93; baca melalui Alya/Wali/Admin | Nilai akhir 93.9 terbaca sama pada role yang berhak | demo_workspace_test.dart |
| TC-07 | Alya dibimbing Rahma | Wali Rahma menambah catatan dan tindak lanjut; Alya membaca; Wali Budi mencoba | Catatan terbaca oleh Alya, akses Wali Budi ditolak | demo_workspace_test.dart, academic_pages_test.dart |
| TC-08 | Pertemuan kelas Algoritma dibuat | Simpan hadir untuk Alya, lalu ubah menjadi izin | Satu baris presensi, status baru terbaca oleh Alya dan wali | demo_workspace_test.dart |
| TC-09 | Pertemuan tersedia | Simpan status invalid, ID peserta asing, atau dari akun mahasiswa | Operasi ditolak dan data valid tidak diubah | demo_workspace_test.dart |
| TC-10 | Masuk sebagai Admin Akademik | Terbitkan judul/isi valid; mahasiswa membaca; coba judul pendek dan publikasi mahasiswa | Pengumuman terbaca; input pendek dan role tanpa izin ditolak | demo_workspace_test.dart, campus_pages_test.dart |
| TC-11 | Nilai Alya tersedia | Ekspor hasil studi Alya; coba ekspor dari Arif dan Pengampu | Bytes PDF valid; ekspor lintas mahasiswa dan kumulatif Pengampu ditolak | demo_workspace_test.dart |
| TC-12 | Mahasiswa aktif tercatat | Arsipkan, cari nama/NIM, pulihkan, cari kembali | Arsip dikecualikan dari hasil dan count; pemulihan mengembalikan data serta FTS | academic_access_test.dart |
| TC-13 | Mahasiswa sedang login | Buka rute Kelola akun; ubah tema pada rute yang diizinkan | Akses admin ditolak; perubahan tema tidak mereset rute | workspace_test.dart |
| TC-14 | Form nilai tersedia | Masukkan -1, 101, NaN atau Infinity | Validasi menolak nilai di luar rentang dan non-finite | academic_access_test.dart, stage4_regression_test.dart |
| TC-15 | Folder sementara berisi berkas mode biasa sentinel | Buka demo pada folder khusus; simpan setting; tutup dan buka kembali | Setting tersimpan; isi berkas mode biasa tidak berubah | workspace_storage_test.dart |
| TC-16 | Database demo ada, kunci preferensi dihapus pada fixture | Buka kembali workspace | Gagal aman; database tidak ditimpa dan kunci pengganti tidak dibuat | workspace_storage_test.dart |
| TC-17 | Halaman pengumuman mengalami kegagalan baca pertama | Tekan Coba Lagi | Halaman pulih dan menampilkan data pada percobaan kedua | campus_pages_test.dart |
| TC-18 | Dashboard tersedia | Render desktop, tablet, ponsel, gelap dan teks 160 persen | Tidak terjadi exception layout; tombol role sesuai akses | workspace_test.dart |

Semua jalur berkas di kolom bukti merujuk ke folder test atau test/widget. Hasil akhir masing-masing tes, bukan sekadar daftar rencana, diekspor pada ../laporan/hasil_pengujian_otomatis.csv. Pengujian pengguna mengikuti instrumen terpisah dan belum dilaksanakan.
