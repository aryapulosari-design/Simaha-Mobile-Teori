# Keamanan dan batas implementasi

## Perlindungan yang diimplementasikan

| Area | Implementasi |
|---|---|
| Database | SQLite/Drift melalui SQLCipher, key acak 256 bit; hook `sqlite3.source: sqlcipher`. |
| Penyimpanan key | `flutter_secure_storage`, bukan key yang ditanam di source. |
| Hash PIN | PBKDF2-HMAC-SHA256, default 100.000 iterasi, salt acak 16 byte, keluaran 256 bit. Parameter tersimpan bersama hash. |
| Format PIN | Tepat enam angka; PIN asli tidak disimpan ke tabel. |
| Lockout | Lima kegagalan →30 detik, kemudian dua kali lipat hingga maksimal 900 detik. |
| Recovery | Kode `XXXX-XXXX-XXXX`, hash di secure storage, dapat digunakan satu kali. |
| Auto-lock | Idle lima menit, manual, dan event lifecycle inactive/paused/hidden. |
| Otorisasi | Service memeriksa akun aktif, permission dan scope mahasiswa/kelas. Router/UI ikut membatasi. |
| Layar sensitif | `SecureScope` pada auth dan shell menggunakan native Android FLAG_SECURE. |
| Fondasi backup | AES-256-GCM, PBKDF2 default 50.000 iterasi, checksum SHA-256; belum alur backup database. |

Tes enkripsi membuka database dengan key benar, key salah, dan tanpa key. Pesan HMAC/decryption error pada keluaran tes negatif dapat merupakan hasil yang diharapkan.

## Pemulihan akun

Super Admin dapat mereset PIN akun lain. Pada login, Lupa PIN memakai kode pemulihan untuk membuka sesi Super Admin; sesudah itu PIN harus direset melalui Kelola akun. Kode hanya berlaku sekali dan tidak menjadi backup database.

Tidak ada login bawaan tanpa PIN. Tombol serta helper pembuat akun bypass telah dihapus pada audit ini. Akun `dev_*` yang mungkin pernah dibuat versi sebelumnya tidak otomatis dihapus; Super Admin dapat memeriksa dan menonaktifkannya di Kelola akun.

## Batas yang belum diselesaikan

- Biometrik belum tersedia; `local_auth` dinonaktifkan dalam dependency. Flag biometrik pada schema bukan bukti autentikasi sensor berjalan.
- FLAG_SECURE hanya diterapkan platform Android melalui MethodChannel. Pengelolaan scope menjaga proteksi saat route bertumpuk dan diuji dengan mock channel. Efek screenshot/recent apps belum diuji pada perangkat Android dalam sesi ini; tidak dijamin pada desktop/iOS.
- Audit log belum mencakup seluruh mutasi data mahasiswa/nilai dan tidak memiliki UI pembaca.
- Backup service mengolah bytes yang diberikan pemanggil. Belum ada snapshot/restore database dan manajemen secure-storage/recovery lintas perangkat.
- Menghapus secure storage atau key dapat membuat database terenkripsi tidak dapat dibuka. Menyalin file database saja tidak memindahkan key.
- Database berada di direktori dokumen aplikasi yang ditentukan `path_provider`; lokasi berbeda per platform. Pada desktop direktori itu tidak otomatis merupakan sandbox aplikasi.
- PIN, data akun, dan role masih satu perangkat; tidak ada pencabutan session jarak jauh.
- `AuthService`/`AcademicService` mempercayai identitas actor yang diberikan oleh session internal; ini bukan protokol autentikasi jaringan.
- Release Android masih debug signing. Belum ada audit penetrasi independen atau pengujian perangkat lintas OS.

Dokumentasi ini mencatat perilaku kode dan bukti tes. Tidak menyatakan aplikasi sudah memenuhi semua persyaratan keamanan PRD.

## Ruang demo yang diminta untuk pengujian

Flag SIMAHA_DEMO=true membuka simaha_demo_50.db berisi 62 akun sintetis dengan PIN awal publik 123456. Tombol demo tetap memverifikasi PIN. Demo memakai DemoStore pada berkas preferensi tersendiri, tanpa membuka secure storage produksi. Kunci acak SQLCipher demo disimpan bersama preferensi untuk demonstrasi; perlindungannya tidak setara mode biasa dan tidak boleh dipakai untuk data nyata. Mode biasa tetap memakai kunci platform dan PIN setup. File demo lama tidak ditimpa.


Pada desktop terkelola yang membatasi folder Documents, variabel lingkungan SIMAHA_DEMO_DIRECTORY dapat diarahkan ke folder kerja yang dapat ditulis. Override ini hanya berlaku pada mode demo. Pembukaan ulang data produksi lama dan pemulihan kode lama belum diverifikasi setelah temuan DPAPI.
