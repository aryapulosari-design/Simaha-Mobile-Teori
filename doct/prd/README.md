# Arsip PRD dan prompt sebelum audit

> Dokumen berikut adalah salinan README lama, dipertahankan sebagai target dan riwayat. Klaim status implementasi di dalamnya bukan hasil verifikasi terkini. Baca [audit terbaru](../audit/README.md) dan [panduan dokumentasi](../README.md).

---

# SIMAHA Offline — Sistem Informasi Manajemen Data Mahasiswa (Offline-First, Tanpa REST API)

> Aplikasi Mobile Pengelolaan Data Mahasiswa (Flutter, Full Mobile, Offline-First, Tanpa REST API)
> Dokumen ini adalah PRD + Prompt + Status Implementasi. Satu-satunya sumber kebenaran untuk Tahap 1.

- Judul formal: *Perancangan dan Implementasi Aplikasi Mobile Pengelolaan Data Mahasiswa Menggunakan Flutter dengan Arsitektur Offline-First*
- Judul aplikasi: **SIMAHA Offline: Sistem Informasi Manajemen Data Mahasiswa Berbasis Mobile Offline-First dengan Enkripsi Data Lokal, Analitik Akademik, dan Asisten Cerdas On-Device**
- Platform utama: Android (Flutter). iOS opsional.
- Prinsip keras: **100% fitur inti berjalan offline. DILARANG backend / REST API / panggilan jaringan untuk fitur inti.**

---

## Daftar Isi

- [A. PRD](#a-prd)
  - [1. Judul](#1-judul-aplikasi)
  - [2. Latar Belakang dan Permasalahan](#2-latar-belakang-dan-permasalahan)
  - [3. Tujuan](#3-tujuan-pengembangan)
  - [4. Pengguna](#4-identifikasi-pengguna)
  - [5. Kebutuhan Fungsional & Nonfungsional](#5-kebutuhan-fungsional-dan-nonfungsional)
  - [6. Fitur Utama](#6-daftar-fitur-utama)
  - [7. Solusi](#7-deskripsi-singkat-solusi)
  - [8. Rancangan Teknis](#8-rancangan-teknis)
  - [9. Ruang Lingkup](#9-ruang-lingkup)
  - [10. Pengujian](#10-rencana-pengujian)
  - [11. Risiko](#11-risiko-dan-mitigasi)
  - [12. Timeline](#12-timeline-8-minggu)
- [B. Master Prompt](#b-master-prompt-untuk-ai-coding-assistant)
- [C. Prompt Per Fase](#c-prompt-bertahap-fase-1-sampai-8)
- [D. Prompt Laporan](#d-prompt-untuk-menyusun-laporan-tahap-1)
- [E. Status Implementasi di Repo Ini](#e-status-implementasi-di-repo-ini)
- [F. Cara Menjalankan](#f-cara-menjalankan)

---

# A. PRD

## 1. Judul Aplikasi

**SIMAHA Offline: Sistem Informasi Manajemen Data Mahasiswa Berbasis Mobile Offline-First dengan Enkripsi Data Lokal, Analitik Akademik, dan Asisten Cerdas On-Device**

Judul formal: *Perancangan dan Implementasi Aplikasi Mobile Pengelolaan Data Mahasiswa Menggunakan Flutter dengan Arsitektur Offline-First*

## 2. Latar Belakang dan Permasalahan

### Latar Belakang

Pengelolaan data mahasiswa di tingkat prodi, dosen wali, atau organisasi kampus sering bergantung pada spreadsheet dan koneksi internet. Di banyak situasi (ruang kelas dengan sinyal lemah, kegiatan lapangan, jaringan kampus yang padat), aplikasi berbasis server tidak dapat diandalkan. Data mahasiswa juga bersifat pribadi sehingga memerlukan perlindungan kuat. Aplikasi mobile yang menyimpan dan mengolah data secara lokal dan terenkripsi menjawab dua kebutuhan sekaligus: ketersediaan (dapat dipakai kapan saja) dan keamanan (data tidak berpindah ke pihak lain).

### Identifikasi Masalah

1. Data tersebar di banyak file, rawan duplikasi dan tidak konsisten.
2. Aplikasi berbasis server tidak dapat dipakai saat offline.
3. Perhitungan akademik (IPS, IPK, status) masih manual dan rawan salah.
4. Presensi masih memakai kertas dan sulit direkap.
5. Data pribadi tersimpan tanpa enkripsi dan tanpa kontrol akses yang jelas.
6. Mahasiswa berisiko (IPK turun, presensi rendah) terlambat terdeteksi.
7. Tidak ada cara mudah untuk membackup dan memindahkan data antar-perangkat secara aman.

### Rumusan Masalah

1. Bagaimana merancang aplikasi mobile yang berfungsi penuh tanpa internet dan tanpa server?
2. Bagaimana mengamankan data mahasiswa di perangkat (enkripsi, autentikasi, hak akses)?
3. Bagaimana mengotomatiskan perhitungan akademik dan deteksi dini mahasiswa berisiko?
4. Bagaimana membackup dan memindahkan data antar-perangkat secara aman tanpa REST API?
5. Bagaimana menambahkan asisten cerdas yang tetap berjalan tanpa server?

### Batasan Masalah

- Tidak ada server maupun REST API; seluruh data berada di perangkat.
- Platform utama Android (Flutter); iOS opsional.
- Menggunakan data dummy, skala uji hingga 10.000 record mahasiswa.
- Skala penilaian umum A sampai E (bobot 4.0 sampai 0).

## 3. Tujuan Pengembangan

**Tujuan umum:** membangun aplikasi mobile offline-first yang aman dan lengkap untuk mengelola data akademik mahasiswa.

**Tujuan khusus:**

1. Mengimplementasikan CRUD data mahasiswa dengan database lokal terenkripsi.
2. Menerapkan autentikasi berlapis (PIN, biometrik) dan RBAC lokal.
3. Membangun mesin akademik: KRS, nilai, IPS/IPK otomatis, status akademik.
4. Membangun modul presensi berbasis QR Code dengan rekap otomatis.
5. Membangun dashboard analitik dan sistem peringatan dini.
6. Menyediakan backup/restore terenkripsi dan sinkronisasi antar-perangkat tanpa server.
7. Mengintegrasikan asisten cerdas (query bahasa natural) yang berjalan on-device.
8. Menguji fungsi, kinerja, keamanan, dan kegunaan (SUS).

## 4. Identifikasi Pengguna

| Peran | Deskripsi | Kebutuhan Utama | Hak Akses |
|---|---|---|---|
| Super Admin | Pemilik aplikasi/prodi | Kelola akun, keamanan, backup | Penuh |
| Admin Akademik | Staf prodi | CRUD mahasiswa, MK, KRS, nilai, impor/ekspor | Data akademik |
| Dosen Pengampu | Pengajar MK | Presensi, input nilai | MK yang diampu |
| Dosen Wali | Pembimbing akademik | Pantau mahasiswa bimbingan, catatan, peringatan dini | Mahasiswa bimbingan |
| Mahasiswa | Pemilik data | Lihat profil, KRS, nilai, presensi, jadwal; scan QR | Data sendiri |

Tanpa server, setiap peran masuk lewat profil lokal (akun di database terenkripsi) dengan PIN/biometrik masing-masing. Satu perangkat dapat memuat banyak profil.

## 5. Kebutuhan Fungsional dan Nonfungsional

### 5.1 Kebutuhan Fungsional

**A. Keamanan dan Akun**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-01 | Setup awal: buat Super Admin dan PIN master | Must |
| FR-02 | Login dengan PIN dan/atau biometrik | Must |
| FR-03 | RBAC lokal untuk 5 peran | Must |
| FR-04 | Auto-lock saat tidak aktif (timeout dapat diatur) | Must |
| FR-05 | Penguncian sementara setelah PIN salah berulang | Must |
| FR-06 | Kelola akun pengguna (tambah, nonaktifkan, reset PIN) | Should |

**B. Data Mahasiswa dan Master**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-07 | CRUD mahasiswa (NIM, nama, prodi, angkatan, status, kontak, foto) | Must |
| FR-08 | Validasi input (NIM unik, format email/HP, field wajib) | Must |
| FR-09 | Soft delete dan pemulihan dari tempat sampah | Should |
| FR-10 | CRUD master: prodi, dosen, mata kuliah, tahun ajaran, kelas | Must |
| FR-11 | Pencarian full-text dan filter multi-kriteria | Must |
| FR-12 | Simpan filter favorit | Could |

**C. Mesin Akademik**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-13 | KRS dengan validasi batas SKS berdasarkan IPS sebelumnya | Must |
| FR-14 | Validasi prasyarat MK dan bentrok jadwal | Should |
| FR-15 | Input nilai berbobot (tugas, UTS, UAS) dan konversi huruf | Must |
| FR-16 | Hitung IPS, IPK, total SKS otomatis | Must |
| FR-17 | Transkrip dan KHS dapat diekspor PDF | Should |
| FR-18 | Jadwal kuliah mingguan (kalender) | Should |

**D. Presensi**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-19 | Dosen membuat sesi presensi dan menampilkan QR dinamis | Should |
| FR-20 | Mahasiswa memindai QR untuk hadir | Should |
| FR-21 | Presensi manual (hadir, izin, sakit, alpa) | Must |
| FR-22 | Rekap kehadiran per mahasiswa dan per MK | Must |

**E. Analitik dan Peringatan Dini**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-23 | Dashboard statistik (jumlah, sebaran, rata-rata IPK, tren IPS) | Must |
| FR-24 | Early warning berbasis aturan (IPK, presensi, SKS tertinggal) | Should |
| FR-25 | Skor risiko per mahasiswa (rule-based, transparan) | Could |
| FR-26 | Catatan bimbingan dosen wali dan riwayat tindak lanjut | Should |

**F. Data, Backup, Sinkronisasi**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-27 | Impor CSV/Excel dengan pratinjau dan validasi | Should |
| FR-28 | Ekspor CSV/Excel/PDF | Should |
| FR-29 | Backup terenkripsi ke berkas `.simaha` (password) | Must |
| FR-30 | Restore dengan pengecekan integritas | Must |
| FR-31 | Sinkronisasi antar-perangkat tanpa server | Could |
| FR-32 | Resolusi konflik (last-write-wins + log konflik) | Could |
| FR-33 | Audit log seluruh perubahan data | Should |

**G. Asisten Cerdas On-Device**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-34 | Tanya data dengan bahasa natural | Should |
| FR-35 | Intent parser lokal yang menerjemahkan pertanyaan menjadi filter SQL | Should |
| FR-36 | Ringkasan otomatis berbasis template | Could |
| FR-37 | Mode LLM opsional (model on-device atau API key milik pengguna) | Could |

**H. Pendukung**

| ID | Kebutuhan | Prioritas |
|---|---|---|
| FR-38 | Notifikasi lokal (KRS, jadwal, peringatan dini) | Should |
| FR-39 | Mode gelap/terang dan dua bahasa (ID/EN) | Could |
| FR-40 | Pengaturan aplikasi (timeout, ambang peringatan, bobot nilai) | Should |

### 5.2 Kebutuhan Nonfungsional

| ID | Kategori | Kebutuhan |
|---|---|---|
| NFR-01 | Keamanan | Database terenkripsi AES-256 (SQLCipher); kunci di Android Keystore/iOS Keychain |
| NFR-02 | Keamanan | PIN disimpan sebagai hash (Argon2/PBKDF2 + salt) |
| NFR-03 | Keamanan | Backup dienkripsi AES-GCM dengan kunci turunan password, dilengkapi checksum |
| NFR-04 | Keamanan | Screenshot dinonaktifkan dan layar disembunyikan di recent apps pada halaman sensitif |
| NFR-05 | Privasi | Tidak ada data keluar perangkat kecuali diekspor/disinkronkan pengguna |
| NFR-06 | Kinerja | Pencarian 10.000 record ≤ 500 ms; cold start ≤ 3 detik |
| NFR-07 | Kinerja | Lazy loading/pagination; proses berat di isolate |
| NFR-08 | Ketersediaan | 100% fitur inti berjalan tanpa internet |
| NFR-09 | Keandalan | Transaksi database atomik |
| NFR-10 | Keandalan | Migrasi skema berversi tanpa kehilangan data |
| NFR-11 | Kegunaan | Material 3, aksesibilitas dasar, SUS ≥ 68 |
| NFR-12 | Kompatibilitas | Android 8.0 (API 26)+, ponsel dan tablet |
| NFR-13 | Pemeliharaan | Clean Architecture; cakupan unit test logika inti ≥ 70% |
| NFR-14 | Efisiensi | APK ≤ 50 MB (tanpa model LLM) |

## 6. Daftar Fitur Utama

1. Keamanan berlapis: PIN, biometrik, auto-lock, DB terenkripsi, RBAC 5 peran.
2. Manajemen data mahasiswa dan master dengan pencarian full-text dan filter multi-kriteria.
3. Mesin akademik: KRS bervalidasi, nilai berbobot, IPS/IPK otomatis, transkrip/KHS PDF.
4. Presensi QR dinamis, presensi manual, dan rekap otomatis.
5. Jadwal kuliah (kalender mingguan) dan notifikasi lokal.
6. Dashboard analitik (tren, sebaran, distribusi nilai).
7. Early warning dan skor risiko mahasiswa.
8. Catatan bimbingan dosen wali.
9. Impor/ekspor CSV, Excel, PDF.
10. Backup/restore terenkripsi dan sinkronisasi tanpa server.
11. Audit log dan tempat sampah.
12. Asisten cerdas on-device.

## 7. Deskripsi Singkat Solusi

SIMAHA Offline adalah aplikasi Flutter yang mengelola seluruh siklus data akademik mahasiswa di dalam perangkat, tanpa server dan tanpa REST API. Data disimpan di database SQLite terenkripsi, diakses sesuai peran lewat PIN/biometrik, dan diolah oleh mesin akademik lokal (KRS, nilai, IPK, presensi). Sistem peringatan dini menandai mahasiswa berisiko, dashboard menampilkan tren, dan asisten cerdas menerjemahkan pertanyaan bahasa sehari-hari menjadi query data. Untuk berbagi data antar-perangkat, aplikasi menyediakan backup terenkripsi dan sinkronisasi lokal tanpa infrastruktur server.

## 8. Rancangan Teknis

### 8.1 Arsitektur (Clean Architecture, Offline-First)

```text
Presentation : Flutter UI (Material 3), Riverpod, go_router
Domain       : Entities, Use Cases (HitungIPK, ValidasiKRS, HitungRisiko, ...), Repository Interfaces
Data         : Repository Impl, DAO (Drift), Mapper, SQLite+SQLCipher, Secure Storage, File Service
Services     : AuthService, CryptoService, BackupService, SyncService,
               ReportService (PDF/CSV), NotificationService, IntentParser
```

### 8.2 Tech Stack

| Kebutuhan | Paket |
|---|---|
| State management | flutter_riverpod |
| Navigasi | go_router |
| Database | drift + sqlcipher_flutter_libs (saat ini: sqlite3 dengan SQLCipher via hook) |
| Penyimpanan kunci | flutter_secure_storage |
| Biometrik | local_auth |
| Kriptografi | cryptography (AES-GCM, PBKDF2/Argon2, HMAC) |
| Grafik | fl_chart |
| QR | qr_flutter, mobile_scanner |
| PDF | pdf, printing |
| CSV/Excel | csv, excel |
| Berkas | file_picker, path_provider, share_plus |
| Notifikasi | flutter_local_notifications |
| Sinkronisasi | nearby_connections (Android) atau berkas/QR |
| Pengujian | flutter_test, mocktail, integration_test |

### 8.3 Skema Database

- **users**(id, username, role, pin_hash, salt, biometric_enabled, is_active, failed_attempts, locked_until)
- **prodi**(id, kode, nama)
- **dosen**(id, nidn, nama, user_id, prodi_id)
- **mahasiswa**(id, nim UNIQUE, nama, prodi_id, angkatan, status, email, no_hp, foto_path, dosen_wali_id, user_id, is_deleted, updated_at, device_id)
- **tahun_ajaran**(id, tahun, semester, is_active)
- **mata_kuliah**(id, kode, nama, sks, semester, prodi_id)
- **prasyarat_mk**(mk_id, prasyarat_mk_id)
- **kelas**(id, mk_id, dosen_id, ta_id, hari, jam_mulai, jam_selesai, ruang)
- **krs**(id, mahasiswa_id, kelas_id, ta_id, status)
- **nilai**(id, krs_id, tugas, uts, uas, nilai_akhir, huruf, bobot)
- **sesi_presensi**(id, kelas_id, pertemuan_ke, tanggal, qr_secret, dibuka_sampai)
- **presensi**(id, sesi_id, mahasiswa_id, status, metode, waktu)
- **catatan_bimbingan**(id, mahasiswa_id, dosen_id, isi, tindak_lanjut, tanggal)
- **peringatan**(id, mahasiswa_id, jenis, skor, detail, dibuat_pada, ditangani)
- **audit_log**(id, user_id, aksi, entitas, entitas_id, sebelum, sesudah, waktu)
- **sync_log**(id, device_id, arah, jumlah_record, konflik, waktu)

Tambahan v3 (spek seksi 4): pengaturan, pengumuman, agenda_akademik, jadwal_ujian, prestasi, edom_periode, edom_pertanyaan, edom_partisipasi, edom_jawaban, dokumen_arsip.

Indeks: `mahasiswa(nim)`, `mahasiswa(angkatan, status)`, FTS5 untuk nama dan NIM.

### 8.4 Logika Inti

**Perhitungan akademik**

```text
nilai_akhir = tugas*w1 + uts*w2 + uas*w3            (bobot dapat diatur, default 0.3/0.3/0.4)
huruf/bobot : A=4, AB=3.5, B=3, BC=2.5, C=2, D=1, E=0
IPS = sum(bobot * SKS) / sum(SKS)    satu semester
IPK = sum(bobot * SKS) / sum(SKS)    semua semester (MK diulang: ambil nilai terbaik)
Batas SKS KRS: IPS >= 3.00 -> 24 | 2.50-2.99 -> 21 | 2.00-2.49 -> 18 | < 2.00 -> 15
```

**Skor risiko (rule-based)**

```text
risiko = 0.40*f(IPK) + 0.30*f(presensi) + 0.20*f(tren IPS) + 0.10*f(SKS tertinggal)
Level: < 30 Aman | 30-60 Waspada | > 60 Kritis  -> notifikasi ke dosen wali
```

**QR presensi dinamis**

```text
token = HMAC-SHA256(qr_secret, sesi_id + floor(waktu / 30 detik))
Pemindai memverifikasi token pada jendela +/- 1 interval
```

**Sinkronisasi tanpa server**

- Setiap record punya `updated_at` dan `device_id`.
- Pertukaran berupa paket delta terenkripsi.
- Konflik: last-write-wins per record; konflik dicatat di `sync_log`.

### 8.5 Asisten Cerdas (Tanpa Server)

1. **Level 1 (wajib, 100% offline):** intent parser lokal. Kata kunci, regex, dan ekstraksi entitas (angkatan, prodi, ambang IPK) diubah menjadi filter query. Contoh: "mahasiswa angkatan 2023 IPK di bawah 2.5" menjadi `angkatan=2023 AND ipk<2.5`.
2. **Level 2:** ringkasan narasi berbasis template dari data.
3. **Level 3 (opsional):** LLM model kecil on-device, atau API key milik pengguna (hanya data agregat/anonim, tanpa nama dan NIM).

Jika Level 3 tidak tersedia atau gagal, Level 1 dan 2 tetap berjalan.

## 9. Ruang Lingkup

**In scope:** seluruh fitur Must dan Should, ditambah Could sesuai waktu (prioritas: backup/restore, early warning, intent parser).
**Out of scope:** server/REST API, integrasi SIAKAD nyata, pembayaran UKT, rilis iOS ke store, akun cloud.

## 10. Rencana Pengujian

| Aspek | Metode | Target |
|---|---|---|
| Fungsional | Black-box per FR | 100% Must lulus |
| Unit test | IPK, KRS, risiko, HMAC QR | Cakupan ≥ 70% |
| Keamanan | DB tidak terbaca tanpa kunci, uji brute-force PIN, uji backup dimodifikasi | Semua ditolak |
| Kinerja | 10.000 record dummy | Pencarian ≤ 500 ms |
| Keandalan | Tutup paksa saat menulis, uji migrasi | Data konsisten |
| Kegunaan | SUS, min. 10 responden | Skor ≥ 68 |
| Kompatibilitas | 3+ perangkat/versi Android | Tanpa crash |

## 11. Risiko dan Mitigasi

| Risiko | Mitigasi |
|---|---|
| Lupa PIN master | Kode pemulihan sekali pakai saat setup; anjurkan backup rutin |
| Perangkat hilang/rusak | Backup terenkripsi, enkripsi DB melindungi data |
| Konflik data sinkronisasi | Timestamp + device_id, log konflik, tinjauan manual |
| Performa lambat | Indeks, FTS5, pagination, isolate |
| Scope terlalu besar | Kerjakan bertahap: Must dulu, yang kompleks belakangan |
| LLM on-device berat | Dijadikan opsional |

## 12. Timeline (8 Minggu)

| Minggu | Kegiatan |
|---|---|
| 1 | Analisis, PRD, UI (Figma), ERD |
| 2 | Arsitektur, Drift + SQLCipher, auth (PIN, biometrik, RBAC) |
| 3 | CRUD mahasiswa dan master, pencarian FTS, filter |
| 4 | KRS, nilai, IPS/IPK, transkrip PDF |
| 5 | Presensi QR dan rekap, jadwal, notifikasi |
| 6 | Dashboard, early warning, catatan bimbingan |
| 7 | Backup/restore, impor/ekspor, sinkronisasi, audit log |
| 8 | Asisten cerdas, pengujian, dokumentasi, demo |

---

# B. Master Prompt (untuk AI coding assistant)

Tempel prompt ini di awal sesi (Claude Code / Cursor / Copilot Chat). Setelah itu lanjutkan dengan prompt per fase di Bagian C.

```text
Kamu adalah senior mobile developer (Flutter/Dart) dengan keahlian arsitektur offline-first,
keamanan data lokal, dan Clean Architecture. Bantu saya membangun aplikasi "SIMAHA Offline".

## Konteks proyek
Aplikasi mobile Flutter untuk pengelolaan data mahasiswa, FULL MOBILE: tanpa server,
tanpa REST API, 100% fitur inti berjalan offline. Semua data tersimpan di database lokal terenkripsi.

## Batasan keras
- DILARANG membuat backend, REST API, atau panggilan jaringan untuk fitur inti.
- Database: SQLite terenkripsi via Drift + sqlcipher_flutter_libs. Kunci disimpan di flutter_secure_storage.
- State management: Riverpod. Navigasi: go_router. UI: Material 3.
- Arsitektur: Clean Architecture (presentation / domain / data / services), dependency mengarah ke domain.
- Dart null-safety, lint ketat (flutter_lints), kode ber-komentar seperlunya, nama identifier berbahasa Inggris,
  teks UI berbahasa Indonesia (siapkan l10n ID/EN).
- Proses berat (impor, ekspor, backup, hash) dijalankan di isolate agar UI tidak freeze.

## Peran pengguna (RBAC lokal)
SuperAdmin, AdminAkademik, DosenPengampu, DosenWali, Mahasiswa. Hak akses ditegakkan di layer domain
(use case) DAN disembunyikan di UI. Jangan hanya mengandalkan UI.

## Fitur
1. Keamanan: setup PIN master, login PIN + biometrik (local_auth), auto-lock, lockout setelah PIN salah
   berulang, PIN di-hash (PBKDF2/Argon2 + salt), screenshot dinonaktifkan di halaman sensitif.
2. Data: CRUD mahasiswa, prodi, dosen, mata kuliah, tahun ajaran, kelas; soft delete + tempat sampah;
   pencarian FTS5; filter multi-kriteria; validasi (NIM unik, email, HP).
3. Mesin akademik: KRS (batas SKS dari IPS sebelumnya: >=3.00:24, 2.50-2.99:21, 2.00-2.49:18, <2.00:15),
   prasyarat MK, deteksi bentrok jadwal, nilai berbobot (tugas/UTS/UAS, bobot dapat diatur),
   konversi huruf (A=4, AB=3.5, B=3, BC=2.5, C=2, D=1, E=0), IPS, IPK (MK diulang ambil nilai terbaik),
   transkrip/KHS PDF.
4. Presensi: sesi presensi, QR dinamis dengan token = HMAC-SHA256(qr_secret, sesiId + floor(waktu/30s)),
   verifikasi jendela +/-1 interval, presensi manual (hadir/izin/sakit/alpa), rekap persentase.
5. Analitik: dashboard (fl_chart), early warning rule-based, skor risiko
   = 0.40*f(IPK) + 0.30*f(presensi) + 0.20*f(tren IPS) + 0.10*f(SKS tertinggal);
   level Aman (<30), Waspada (30-60), Kritis (>60); catatan bimbingan dosen wali.
6. Data: impor CSV/Excel (pratinjau + validasi baris), ekspor CSV/Excel/PDF,
   backup/restore terenkripsi (AES-GCM, kunci dari password via PBKDF2/Argon2, checksum integritas, ekstensi .simaha),
   sinkronisasi delta antar-perangkat tanpa server (updated_at + device_id, last-write-wins, sync_log), audit_log.
7. Asisten cerdas on-device: IntentParser (kata kunci + regex + ekstraksi entitas angkatan/prodi/ambang IPK)
   yang menghasilkan filter query; ringkasan berbasis template; LLM opsional di belakang interface
   terpisah (default nonaktif) sehingga aplikasi tetap jalan tanpanya.
8. Pendukung: notifikasi lokal, mode gelap/terang, l10n ID/EN, halaman pengaturan.

## Skema database
users, prodi, dosen, mahasiswa, tahun_ajaran, mata_kuliah, prasyarat_mk, kelas, krs, nilai,
sesi_presensi, presensi, catatan_bimbingan, peringatan, audit_log, sync_log.
(Sesuaikan kolom dengan kebutuhan; wajib ada created_at/updated_at/device_id/is_deleted pada tabel
yang disinkronkan. Buat indeks pada mahasiswa(nim), mahasiswa(angkatan,status) dan FTS5 untuk nama+NIM.)

## Cara kerja yang saya minta
1. Kerjakan BERTAHAP per fase. Sebelum menulis kode tiap fase, tampilkan rencana singkat
   (daftar file yang akan dibuat/diubah) lalu langsung implementasikan.
2. Setiap fase harus: bisa di-build (`flutter analyze` bersih), punya unit test untuk logika domain,
   dan disertai ringkasan: apa yang selesai, cara menjalankan, apa yang belum.
3. Logika bisnis (IPK, KRS, risiko, HMAC QR, intent parser) harus murni (pure Dart) dan teruji unit test.
4. Jangan menambah dependensi di luar daftar tanpa menjelaskan alasannya.
5. Jika ada keputusan ambigu, pilih opsi paling aman dan sederhana, catat asumsinya, jangan berhenti bertanya.
6. Sediakan seeder data dummy (hingga 10.000 mahasiswa) untuk uji performa.

Mulai dari Fase 1 saat saya perintahkan. Konfirmasi pemahamanmu dalam 5 poin singkat, lalu tunggu.
```

---

# C. Prompt Bertahap (Fase 1 sampai 8)

## Fase 1: Fondasi, database, keamanan

```text
Mulai Fase 1. Buat project Flutter "simaha_offline" dengan struktur Clean Architecture
(lib/presentation, lib/domain, lib/data, lib/services, lib/core). Setup Riverpod, go_router,
Material 3 theme (terang/gelap), l10n ID/EN.
Implementasikan: Drift + SQLCipher dengan kunci acak yang disimpan di flutter_secure_storage;
tabel users; CryptoService (hash PIN PBKDF2/Argon2 + salt); AuthService (setup PIN master,
login PIN, biometrik via local_auth, lockout setelah 5x gagal, auto-lock timeout);
RBAC (enum Role + PermissionChecker di domain); layar Setup, Login, Lock.
Sertakan kode pemulihan sekali pakai saat setup. Tambahkan unit test untuk CryptoService,
lockout, dan PermissionChecker.
```

## Fase 2: Data master dan mahasiswa

```text
Fase 2. Tambahkan tabel prodi, dosen, mahasiswa, tahun_ajaran, mata_kuliah, prasyarat_mk, kelas
beserta DAO, repository, dan use case. Fitur: CRUD lengkap dengan validasi (NIM unik, email, HP),
soft delete + tempat sampah + restore, pencarian FTS5 (nama/NIM), filter multi-kriteria
(prodi, angkatan, status, dosen wali), pagination/lazy loading, simpan filter favorit.
Buat seeder 10.000 mahasiswa dummy dan ukur waktu pencarian. Terapkan RBAC di use case.
Tulis unit test untuk validator dan use case.
```

## Fase 3: Mesin akademik

```text
Fase 3. Implementasikan tabel krs dan nilai, serta use case murni: HitungNilaiAkhir (bobot dapat diatur),
KonversiHuruf, HitungIPS, HitungIPK (MK diulang ambil nilai terbaik), TentukanBatasSKS,
ValidasiKRS (batas SKS, prasyarat MK, bentrok jadwal). UI: pengisian KRS, input nilai oleh dosen,
KHS dan transkrip. Ekspor transkrip/KHS ke PDF (pdf + printing). Unit test wajib untuk semua
use case dengan kasus tepi (tanpa nilai, MK diulang, SKS = 0).
```

## Fase 4: Presensi dan jadwal

```text
Fase 4. Implementasikan sesi_presensi dan presensi. Dosen membuat sesi dan menampilkan QR dinamis
(token HMAC-SHA256 dari qr_secret + sesiId + floor(waktu/30s), refresh tiap 30 detik).
Mahasiswa memindai dengan mobile_scanner; verifikasi jendela +/-1 interval, cegah presensi ganda.
Tambahkan presensi manual (hadir/izin/sakit/alpa), rekap persentase per mahasiswa dan per MK,
tampilan jadwal mingguan (kalender), dan notifikasi lokal pengingat jadwal.
Unit test untuk generator dan verifikator token.
```

## Fase 5: Analitik dan peringatan dini

```text
Fase 5. Dashboard dengan fl_chart: total mahasiswa, sebaran per angkatan/status, rata-rata IPK,
distribusi nilai, tren IPS. Implementasikan use case HitungSkorRisiko (bobot 0.40/0.30/0.20/0.10)
dengan fungsi f() yang terdokumentasi dan dapat diatur ambangnya di pengaturan, serta
penjadwalan pemeriksaan peringatan dini yang menulis ke tabel peringatan dan mengirim notifikasi
ke dosen wali. Tambahkan fitur catatan_bimbingan dengan riwayat tindak lanjut.
Unit test untuk HitungSkorRisiko.
```

## Fase 6: Impor, ekspor, backup

```text
Fase 6. Impor CSV/Excel dengan pratinjau, pemetaan kolom, dan laporan error per baris (jalankan di isolate).
Ekspor CSV/Excel/PDF. BackupService: ekspor seluruh database ke berkas .simaha terenkripsi AES-GCM
dengan kunci dari password (PBKDF2/Argon2), header berisi versi skema + checksum;
RestoreService: validasi checksum dan versi, preview jumlah record, restore atomik.
Tambahkan audit_log otomatis untuk setiap perubahan data (sebelum/sesudah, user, waktu).
Unit test: backup yang dimodifikasi harus ditolak, password salah harus ditolak.
```

## Fase 7: Sinkronisasi

```text
Fase 7. SyncService tanpa server: buat paket delta terenkripsi (record dengan updated_at > sync terakhir),
transport berupa berkas (share_plus/file_picker) sebagai jalur utama, nearby_connections sebagai opsional.
Resolusi konflik last-write-wins per record, simpan konflik ke sync_log, sediakan layar tinjau konflik.
Pastikan idempoten (menerapkan paket yang sama dua kali tidak mengubah hasil). Unit test untuk
merge dan konflik.
```

## Fase 8: Asisten cerdas dan finalisasi

```text
Fase 8. Implementasikan IntentParser (pure Dart): normalisasi teks, deteksi intent
(cari mahasiswa, hitung, ringkas, presensi), ekstraksi entitas (angkatan, prodi, ambang IPK,
jumlah alpa, status), dan QueryBuilder yang menghasilkan filter Drift aman (tanpa string SQL mentah).
Tambahkan ringkasan berbasis template. Buat interface LlmProvider dengan implementasi default NoopLlm
dan implementasi opsional (BYOK atau model on-device), nonaktif secara default; hanya data agregat
atau anonim (tanpa nama/NIM) yang boleh dikirim. UI chat sederhana dengan hasil berupa daftar
yang bisa diklik. Kemudian: lengkapi pengaturan, rapikan UX, jalankan flutter analyze dan seluruh test,
buat README (cara build, struktur, asumsi), dan checklist uji black-box per FR.
```

---

# D. Prompt untuk Menyusun Laporan Tahap 1

```text
Kamu adalah dosen pembimbing sekaligus penulis laporan teknis. Susun laporan Tahap 1 mata kuliah
Pemrograman Mobile dengan judul:
"Perancangan dan Implementasi Aplikasi Mobile Pengelolaan Data Mahasiswa Menggunakan Flutter"
(aplikasi: SIMAHA Offline, full mobile, offline-first, tanpa REST API).

Gunakan Bahasa Indonesia baku akademik. Susun dengan struktur persis seperti ini:
1. Judul aplikasi
2. Latar belakang dan permasalahan (latar belakang, identifikasi masalah, rumusan masalah, batasan masalah)
3. Tujuan pengembangan aplikasi (umum dan khusus) beserta manfaat
4. Identifikasi pengguna aplikasi (tabel: peran, deskripsi, kebutuhan, hak akses)
5. Daftar kebutuhan fungsional dan nonfungsional (tabel dengan ID, kebutuhan, prioritas MoSCoW)
6. Daftar fitur utama aplikasi
7. Deskripsi singkat solusi yang ditawarkan

Aturan:
- Pakai data dari PRD berikut sebagai satu-satunya sumber
- Jangan menambah fitur di luar PRD.
- Paragraf padat, tidak bertele-tele, tiap bagian maksimal 2 halaman.
- Gunakan tabel untuk pengguna dan kebutuhan.
- Akhiri dengan tabel ringkasan kesesuaian antara masalah, tujuan, dan fitur.
- Format keluaran: dokumen Word (.docx) dengan cover, daftar isi, heading bernomor, font Times New Roman 12,
  spasi 1,5, margin 4-3-3-3 cm.
```

---

# E. Status Implementasi di Repo Ini

> Diperbarui otomatis saat pengecekan. Lihat hasil `flutter analyze` + `flutter test` terakhir di bawah.

## Struktur Clean Architecture

```text
lib/
  main.dart                          -> bootstrap DB terenkripsi + seed + router
  core/
    constants/app_constants.dart     -> konstanta (grade bands, dsb)
    errors/failures.dart
    router/app_router.dart           -> go_router + gate setup/lock/ok (login mudah-aman aktif)
    security/gate.dart
    theme/app_theme.dart
  domain/
    academic/grades.dart             -> HitungNilaiAkhir, KonversiHuruf, IPS/IPK, BatasSKS
    academic/validations.dart        -> validasi NIM/nama/email/HP + bentrok jadwal
    security/roles.dart              -> Role + Permission + matrix
    security/string_store.dart
  data/
    local/app_database.dart          -> Drift schema v3 + FTS5 + trigger + query helper
    local/tables.dart
    local/connection/                -> encrypted_connection + key manager
    local/seed/seed_data.dart        -> seeder 100 mahasiswa dummy
    services/auth_service.dart       -> AuthService + lockout
    services/crypto_service.dart     -> hash PIN PBKDF2 + AES-GCM
    services/secure_store.dart
  presentation/
    providers/app_providers.dart + session_providers.dart
    features/home, mahasiswa, nilai, auth, settings, dbinfo
    shared/widgets/app_shell, auto_lock_scope, dashboard_widgets
```

## Pemetaan FR -> Kode -> Test

| Fitur | FR | Implementasi | Test |
|---|---|---|---|
| Auth PIN + hash + lockout | FR-01..05 | `crypto_service.dart`, `auth_service.dart`, `roles.dart`, gate+router+autolock aktif | `auth_test.dart`, `auth_flow_test.dart`, `crypto_test.dart` |
| RBAC 5 peran | FR-03 | `roles.dart` + gate + router | `auth_test.dart` |
| CRUD mahasiswa + validasi + soft delete | FR-07..09 | `app_database.dart` create/update/softDelete/restore + `validations.dart` | `seed_test.dart`, `migration_test.dart`, `academic_constants_test.dart` |
| Master prodi/dosen/MK/TA/kelas | FR-10 | `tables.dart` + `app_database.dart` | `migration_test.dart`, `seed_test.dart` |
| FTS5 + filter + pagination | FR-11 | `searchMahasiswaFts`, `pagedMahasiswa` | `seed_test.dart` (cari + ukur waktu) |
| Mesin akademik IPS/IPK/SKS | FR-13..16 | `grades.dart` + `app_database.dart` listNilai/saveNilai | `academic_engine_test.dart` |
| Presensi QR HMAC + rekap | FR-19..22 | `domain/presensi/qr_token.dart` (HMAC-SHA256/30s, ±1, rekap) | `qr_token_test.dart` (3 lolos) |
| Risiko rule-based + level | FR-24..25 | `domain/analytics/risk_score.dart` (0.40/0.30/0.20/0.10) | `risk_score_test.dart` (4 lolos) |
| Backup `.simaha` + sync LWW | FR-29..32 | `data/services/backup_service.dart` (AES-GCM+PBKDF2+sha256), `domain/sync/sync_merge.dart` | `sync_backup_test.dart` (3 lolos) |
| Impor CSV preview + notif | FR-27/28/38 | `domain/import/csv_preview.dart`, `domain/notifications/local_notify.dart` (Noop) | `csv_notify_test.dart` (3 lolos) |
| Asisten cerdas on-device | FR-34..37 | `domain/assistant/intent_parser.dart` + `NoopLlm` (tanpa nama/NIM) | `intent_parser_test.dart` (4 lolos) |
| Settings/theme | FR-39..40 | `settings_page.dart` (tanpa bypass dev), `app_theme.dart` | `widget_test.dart` |

Catatan login (mudah tapi aman, realistis): `main.dart` cek `isSetupRequired()` -> `setup` jika DB kosong else `lock`. Router redirect setup/lock/ok. Auto-lock 5 menit + lock saat background. Mudah: username terisi otomatis, numpad + auto-submit, recovery sekali pakai. Aman: PBKDF2 100k + salt, lockout eskalasi 1-15 mnt, SQLCipher + Keystore, RBAC di service.

## Hasil Cek Terakhir (10 Okt 2026)

- `flutter analyze`: No issues found
- `flutter test`: All tests passed (55 test, 14 file) — termasuk file baru
  `qr_token_test`, `risk_score_test`, `sync_backup_test`, `csv_notify_test`,
  `intent_parser_test`. `auth_flow_test` ditulis ulang level flow (tanpa pump UI)
  karena versi widget gantung di runner Windows (masalah lama, pra-perubahan login).

---

# F. Cara Menjalankan

```bash
# 1. Ambil dependensi
flutter pub get

# 2. Generate Drift (jika ubah tables.dart / app_database.dart)
dart run build_runner build --delete-conflicting-outputs

# 3. Cek statis (wajib bersih)
flutter analyze

# 4. Jalankan semua test
flutter test

# 5. Jalankan aplikasi (Android emulator / HP via USB, Windows/Linux/macOS untuk dev)
flutter run

# 6. Build APK release (tanpa model LLM, target <= 50 MB)
flutter build apk --release
```

Struktur asumsi penting:

- Kunci DB acak disimpan di `flutter_secure_storage` (Keystore/Keychain). Jika hilang, DB tidak bisa dibuka — jangan hapus manual, pakai backup `.simaha`.
- Bobot default nilai: tugas 30%, UTS 30%, UAS 40%. Skala A(>=85)=4.0, AB(>=80)=3.5, B(>=75)=3.0, BC(>=70)=2.5, C(>=60)=2.0, D(>=50)=1.0, E(<50)=0.
- Batas SKS: IPS >=3.00:24, 2.50-2.99:21, 2.00-2.49:18, <2.00:15. Semester pertama: 20.
- IPK MK diulang: nilai terbaik. Lulus jika huruf != E.
- FTS5: `mahasiswa_fts(nim, nama)`, trigger AI/AD/AU + rebuild saat migrasi.
- Migrasi berversi v1->v2 (sync cols) ->v3 (tabel spek seksi 4). Tanpa kehilangan data.
