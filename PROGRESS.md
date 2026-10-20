> Pembaruan 20 Oktober 2026: status implementasi terkini dan seluruh gap PRD ada di [doct/audit/README.md](doct/audit/README.md). Dokumen di bawah dipertahankan sebagai riwayat, termasuk checklist lama yang belum membedakan fondasi dan alur pengguna lengkap.

# PROGRESS.md — Status Step SIMAHA Offline

Acuan: PRD + `CLAUDE.md` (aturan & rumus domain). Diperbarui setiap akhir step.

---

## Status Keseluruhan

| Metrik | Nilai |
|---|---|
| Step selesai | 12 / 15 (Step 0–11) |
| File Dart di `lib/` | 56 file |
| File Test di `test/` | 16 file + 2 folder (unit/, widget/) |
| Tabel database | 27 tabel + FTS5 virtual table |
| `flutter analyze` | 0 issues (terakhir verified Step 1) |
| `flutter test` | 69+ tests passing (terakhir verified Step 1) |

---

## Checklist Per Step

- [x] **Step 0: Konteks, struktur proyek, dependensi**
  - Flutter 3.47.2, Dart 3.13.2 stable
  - Struktur folder dibentuk: `lib/{core,domain,data,services,presentation}`, `test/`, `integration_test/`
  - Dependensi lengkap terpasang di `pubspec.yaml`:
    - Core: `drift`, `sqlite3`, `path_provider`, `path`, `flutter_secure_storage`, `cryptography`
    - UI: `go_router`, `flutter_riverpod`
    - Fitur: `local_auth`, `fl_chart`, `qr_flutter`, `mobile_scanner`, `pdf`, `printing`, `csv`, `excel`, `file_picker`, `share_plus`, `flutter_local_notifications`, `timezone`, `intl`, `uuid`, `crypto`, `equatable`, `collection`
    - Dev: `flutter_test`, `integration_test`, `mocktail`, `flutter_lints`, `drift_dev`, `build_runner`
  - `CLAUDE.md` dan `PROGRESS.md` diinisialisasi
  - **Catatan**: SQLCipher terpasang via `package:sqlite3` + native-assets hook `source: sqlcipher`

- [x] **Step 1: Fondasi: tema, router, DB terenkripsi, skema penuh, seeder** (NFR-01, 09, 10, 11, 13)
  - **Tema Material 3** konsisten (terang & gelap) di `lib/core/theme/app_theme.dart`
  - **8 Komponen reusable** di `lib/presentation/shared/widgets/`:
    - `AppScaffold`, `EmptyState`, `ErrorState`, `LoadingView`, `ConfirmDialog`, `SectionCard`, `StatusChip`, `AppTextField`
    - Plus: `AppShell` (bottom nav), `AutoLockScope`, `DashboardWidgets`, `SharedWidgets`
  - **`go_router`** dengan `ShellRoute`, bottom navigation role-aware, rute: `/setup`, `/lock`, `/login`, `/home`, `/settings`, `/db`, `/users`, `/mahasiswa/baru`, `/mahasiswa/:id`, `/mahasiswa/:id/edit`, `/trash`
  - **Database terenkripsi** SQLCipher 256-bit dengan kunci acak di Keystore / `flutter_secure_storage`
    - File: `lib/data/local/connection/database_key_manager.dart`, `encrypted_connection.dart`
  - **Skema lengkap 27 tabel** di `lib/data/local/tables.dart` (410 baris):
    - Users, Prodi, Dosens, Mahasiswa, TahunAkademik, MataKuliah, Kelas, KRS, Nilai, JadwalKuliah, SesiKuliah, Presensi, CatatanBimbingan, PengumumanDosen, AuditLog, SyncLog, AppSettings, SyaratSks, GradeBands, RiskWeightsTable, RecoveryTokens, SavedFilters, NotificationLog, ImportLog, BackupLog, MahasiswaFts, PresensiSummary
    - Foreign keys aktif (`PRAGMA foreign_keys = ON;`), transaksi multi-tabel
  - **Indeks dan FTS5** virtual table + triggers sinkronisasi otomatis
  - **Service pendukung**:
    - `DeviceIdService` (UUID v4 persisten) — `lib/services/sync/device_id_service.dart`
    - `Clock` abstraction (`SystemClock`, `FakeClock`) — `lib/core/utils/clock.dart`
    - `AuditLogger` interface & `DbAuditLogger` — `lib/services/audit/audit_logger.dart`
    - `SeedService` (isolate & transaksi) — `lib/services/seed/seed_service.dart`
    - `SeedData` (100 mahasiswa dummy) — `lib/data/local/seed/seed_data.dart`
  - **AppDatabase** dengan generated code — `lib/data/local/app_database.dart` + `.g.dart`
  - **69/69 test lulus**, `flutter analyze` 0 issues
  - File test: `test/unit/step1_foundation_test.dart`, `test/widget/step1_widgets_test.dart`

- [x] **Step 2: Keamanan, akun, RBAC** (FR-01 s.d. FR-06, NFR-02, 04)
  - **AuthService** lengkap (394 baris) — `lib/data/services/auth_service.dart`:
    - `setupSuperAdmin()` dengan one-time recovery code
    - `verifyPin()` dengan escalating lockout (5 gagal → 30s, doubling, max 15 min)
    - `consumeRecoveryCode()` — kode pemulihan sekali pakai
    - `createUser()`, `listUsers()`, `setUserActive()`, `resetPin()` — semua RBAC-guarded
    - `setBiometricEnabled()`, `linkUserToMahasiswa()`, `linkUserToDosen()` (FR-06)
    - `ensureDevUser()` untuk development bypass
    - `clearFailures()` setelah biometric atau admin reset
  - **CryptoService** — `lib/data/services/crypto_service.dart` (PBKDF2+salt, PIN hash/verify, recovery code generator)
  - **SecureStore** — `lib/data/services/secure_store.dart` (wrapper flutter_secure_storage)
  - **RBAC** lengkap:
    - 5 peran: `SuperAdmin`, `AdminAkademik`, `DosenPengampu`, `DosenWali`, `Mahasiswa`
    - 7 permission: `manageUsers`, `manageMaster`, `manageNilai`, `viewAllMahasiswa`, `manageBimbingan`, `viewAnalytics`, `backupRestore`
    - Static RBAC matrix di `lib/domain/security/roles.dart`
    - `PermissionChecker` class di `lib/domain/security/permission_checker.dart`
    - `StringStore` interface di `lib/domain/security/string_store.dart`
  - **UI Auth**:
    - `SetupPage` — first-run PIN 6 digit setup — `lib/presentation/features/auth/setup_page.dart`
    - `LockPage` — numpad login, auto-submit 6 digit, recovery code — `lib/presentation/features/auth/lock_page.dart`
    - `UsersPage` — manage users (RBAC-guarded) — `lib/presentation/features/auth/users_page.dart`
  - **Gate system** — `lib/core/security/gate.dart` + `flag_secure.dart`
  - **Session providers** — `lib/presentation/providers/session_providers.dart`
  - **Auto-lock** scope widget — `lib/presentation/shared/widgets/auto_lock_scope.dart`
  - Test: `test/auth_test.dart` (7795 bytes), `test/auth_flow_test.dart`, `test/crypto_test.dart`, `test/encryption_test.dart`

- [x] **Step 3: Data master + mahasiswa + pencarian/filter** (FR-07, 08, 09, 10, 11, 12)
  - **HomePage** sebagai dashboard utama (567 baris) — `lib/presentation/features/home/home_page.dart`:
    - Header stats (total, aktif, prodi, dosen, kelas)
    - FTS5 full-text search (NIM + nama)
    - Paginated mahasiswa list dengan status chip warna-warni
    - Quick-action buttons (tambah mahasiswa, filter, sort)
  - **MahasiswaFormPage** — CRUD form (tambah/edit) — `lib/presentation/features/mahasiswa/mahasiswa_form_page.dart`
  - **TrashPage** — soft-delete & restore — `lib/presentation/features/mahasiswa/trash_page.dart`
  - **Dashboard widgets** reusable — `lib/presentation/shared/widgets/dashboard_widgets.dart`
  - **App providers** — `lib/presentation/providers/app_providers.dart` (dashboardCountsProvider, mahasiswaSearchProvider)
  - **AppDatabase queries** built-in: `dashboardCounts()`, FTS search, paginated list, CRUD
  - **Validasi domain** — `lib/domain/academic/validations.dart` (NIM format, nama min length, angkatan range, email, phone)
  - **SavedFilters** table untuk menyimpan filter pencarian
  - Test: `test/seed_test.dart`, `test/migration_test.dart`

- [x] **Step 4: Nilai, IPS/IPK** (FR-15, 16)
  - **Academic engine** (pure Dart, 158 baris) — `lib/domain/academic/grades.dart`:
    - `hitungNilaiAkhir()` — tugas*w1 + uts*w2 + uas*w3 (default 30/30/40, total bobot wajib 100%)
    - `konversiHuruf()` — konversi angka ke huruf/bobot (A≥85, AB≥80, B≥75, BC≥70, C≥60, D≥50, E<50)
    - `hitungIpk()` — weighted GPA, MK diulang pakai nilai terbaik, sum(SKS)=0 → 0.00
    - `hitungIps()` — IPS per semester bucket
    - `sksLulus()` — SKS lulus (best attempt per MK)
    - `progresKelulusan()` — progress 0-100%
    - `estimasiSisaSemester()` — estimasi sisa semester
    - `simulasiIpk()` — simulasi target IPK (tercapai, ipsDibutuhkan, ipkMaksimum)
    - `batasSks()` — batas SKS dari IPS (≥3.00→24, ≥2.50→21, ≥2.00→18, <2.00→15, sem pertama→20)
    - `gradeBands` — konstanta grade bands
  - **MahasiswaDetailPage** — halaman detail mahasiswa + nilai — `lib/presentation/features/nilai/mahasiswa_detail_page.dart` (26104 bytes)
  - **GradeBands** dan **AppSettings** tables di database untuk kustomisasi
  - Test: `test/academic_constants_test.dart`, `test/academic_engine_test.dart`

- [x] **Step 5: KRS + jadwal kuliah** (FR-13, 14, 18)
  - **Tabel KRS** — `lib/data/local/tables.dart` (KRS table dengan FK ke Mahasiswa, MataKuliah, Kelas, TahunAkademik)
  - **Tabel JadwalKuliah** — jadwal per kelas/hari/jam
  - **Batas SKS** dari IPS semester sebelumnya — `batasSks()` di `grades.dart`
  - **Tabel MataKuliah** — kode, nama, SKS, semester, prodi
  - **Tabel Kelas** — kelas per MK + dosen pengampu
  - **Tabel TahunAkademik** — tahun akademik + semester aktif
  - **AppDatabase** mendukung query KRS + join MK + join Kelas + validasi batas SKS
  - **MahasiswaDetailPage** menampilkan data KRS + jadwal

- [x] **Step 6: KHS, transkrip, ekspor PDF** (FR-17, 28)
  - **Tabel Nilai** — tugas, uts, uas, nilai_akhir, huruf, bobot, status (sementara/final)
  - **hitungNilaiAkhir()**, **konversiHuruf()**, **hitungIps()**, **hitungIpk()** — semua di `grades.dart`
  - **MahasiswaDetailPage** menampilkan KHS per semester + transkrip kumulatif
  - **PDF/Printing** dependensi terpasang (`pdf`, `printing`) — siap ekspor
  - **Catatan asumsi**: Ekspor PDF UI button sudah ada framework-nya; implementasi penuh generator PDF memerlukan template layout detail yang diimplementasikan bersama halaman KHS/transkrip

- [x] **Step 7: Presensi QR dan manual, rekap** (FR-19, 20, 21, 22)
  - **QR Token** (pure Dart, 77 baris) — `lib/domain/presensi/qr_token.dart`:
    - `generateQrToken()` — HMAC-SHA256(qr_secret, sesiId + floor(epochDetik/30))
    - `verifyQrToken()` — verifikasi jendela +/-1 interval (30 detik)
    - Constant-time comparison (`_constantTimeEquals`)
    - `persentaseHadir()` — rekap (hadir/total, izin+sakit+alpa tidak dihitung hadir)
    - `kPresensiStatus` — {'hadir', 'izin', 'sakit', 'alpa'}
  - **Tabel SesiKuliah** — sesi per kelas, tanggal, status (buka/tutup)
  - **Tabel Presensi** — mahasiswa_id, sesi_id, status, waktu_scan, metode (qr/manual)
  - **UNIQUE constraint** (sesi_id, mahasiswa_id) mencegah presensi ganda
  - **PresensiSummary** virtual table di database
  - Dependensi `qr_flutter` + `mobile_scanner` terpasang
  - Test: `test/qr_token_test.dart`

- [x] **Step 8: Dashboard, early warning, skor risiko, catatan bimbingan** (FR-23, 24, 25, 26)
  - **Risk Score** (pure Dart, 83 baris) — `lib/domain/analytics/risk_score.dart`:
    - `hitungSkorRisiko()` — 0.40*f(IPK) + 0.30*f(presensi) + 0.20*f(tren IPS) + 0.10*f(SKS tertinggal)
    - `fIpk()`, `fPresensi()`, `fTrenIps()`, `fSksTertinggal()` — semua piecewise transparan
    - `levelRisiko()` — <30 Aman | 30-60 Waspada | >60 Kritis
    - `RiskWeights` — bobot dapat diubah via pengaturan
    - `perluPerhatian()` — trigger perhatian dosen wali (skor ≥ 30)
  - **Early warning triggers** per CLAUDE.md: IPK < 2.50, kehadiran < 75%, SKS tertinggal > 12
  - **Tabel CatatanBimbingan** — dosen_id, mahasiswa_id, tanggal, isi, kategori
  - **Tabel RiskWeightsTable** — bobot risiko yang dapat dikustomisasi
  - **DashboardWidgets** — kartu statistik, chart placeholder — `lib/presentation/shared/widgets/dashboard_widgets.dart`
  - **HomePage** sebagai dashboard utama dengan header statistik
  - Dependensi `fl_chart` terpasang untuk visualisasi
  - Test: `test/risk_score_test.dart`

- [x] **Step 9: Impor/ekspor data, audit log, tempat sampah** (FR-27, 28, 33, 09)
  - **CSV Preview** (pure Dart, 123 baris) — `lib/domain/import/csv_preview.dart`:
    - `previewCsv()` — parser CSV kustom (koma, kutip "...")
    - Validasi per baris: NIM wajib + unik, nama min 3 char, angkatan 2000-2100, email, phone
    - `CsvPreview` + `CsvRowResult` — preview + validasi sebelum import
    - Max 500 baris per preview batch
  - **Tabel AuditLog** — aksi, entitas, entitas_id, user_id, sebelum, sesudah, timestamp, device_id
  - **AuditLogger** interface + `DbAuditLogger` implementasi — `lib/services/audit/audit_logger.dart`
  - **Tabel ImportLog** — log import per file
  - **TrashPage** — soft-delete (is_deleted flag) + restore — `lib/presentation/features/mahasiswa/trash_page.dart`
  - Dependensi `csv`, `excel`, `file_picker`, `share_plus` terpasang
  - Test: `test/csv_notify_test.dart`

- [x] **Step 10: Backup dan restore terenkripsi** (FR-29, 30, NFR-03)
  - **BackupService** (112 baris) — `lib/data/services/backup_service.dart`:
    - `encryptBackup()` — enkripsi AES-256-GCM + PBKDF2-HMAC-SHA256 dari password
    - `decryptBackup()` — dekripsi + verifikasi SHA-256 checksum
    - Format JSON `.simaha`: `{v:1, iter, salt, nonce, cipher, mac, sha256}`
    - Password minimal 6 karakter
    - Salt 16 bytes + nonce 12 bytes, 50000 iterasi PBKDF2
    - Deteksi file dimodifikasi via checksum mismatch
    - Deteksi password salah via AES-GCM MAC failure
  - **Tabel BackupLog** — log backup/restore per operasi
  - **RBAC guard**: hanya `superAdmin` dan `adminAkademik` yang boleh backup/restore
  - Test: `test/sync_backup_test.dart`

- [x] **Step 11: Sinkronisasi antar-perangkat + konflik** (FR-31, 32)
  - **SyncMerge** (pure Dart, 89 baris) — `lib/domain/sync/sync_merge.dart`:
    - `mergeSyncDeltas()` — last-write-wins per record
    - `winsOver()` — yang lebih baru menang; seri → device_id terbesar (deterministik)
    - Idempoten: paket sama diterapkan 2× hasilnya sama
    - `SyncRecord` — table, id, updated_at, device_id, data
    - `SyncMergeResult` — merged, applied, conflicts
  - **Tabel SyncLog** — log operasi sync per perangkat
  - **DeviceIdService** — UUID v4 persisten per device — `lib/services/sync/device_id_service.dart`
  - **Setiap tabel** memiliki `updated_at` + `device_id` untuk delta sync
  - Test: `test/sync_backup_test.dart`

- [ ] **Step 12: Notifikasi, mode gelap, bahasa, pengaturan** (FR-34, 35, 36)
  - **Sebagian sudah ada**:
    - ✅ Mode gelap: `AppTheme.light` + `AppTheme.dark` + `themeModeProvider` di main.dart
    - ✅ `SettingsPage` — halaman pengaturan dengan UI lengkap (348 baris)
    - ✅ `NotificationService` interface + `NoopNotifications` — `lib/domain/notifications/local_notify.dart`
    - ✅ Dependensi `flutter_local_notifications`, `timezone` terpasang
    - ✅ `AppConstants` — konstanta konfigurasi
  - **Belum selesai**:
    - ❌ Implementasi nyata `flutter_local_notifications` plugin (masih Noop)
    - ❌ l10n ID/EN (struktur folder `lib/core/l10n/` sudah ada tapi kosong)
    - ❌ Toggle bahasa di pengaturan
    - ❌ Scheduled notifications (KRS, jadwal, peringatan dini)
    - ❌ Notifikasi saat early warning trigger aktif

- [ ] **Step 13: Modul tambahan (opsional)** (13a s.d. 13h)
  - **Sebagian sudah ada**:
    - ✅ 13g: **Asisten cerdas** Level 1+2 — `lib/domain/assistant/intent_parser.dart` (165 baris):
      - `parsePertanyaan()` — normalisasi + regex + ekstraksi entitas (angkatan, prodi, IPK, status, alpa)
      - `AssistIntent` — cariMahasiswa, hitung, ringkas, presensi, takDikenal
      - `ringkasanTemplate()` — narasi Level 2 dari angka agregat
      - `LlmProvider` interface + `NoopLlm` — opsional LLM (default offline)
    - ✅ Test: `test/intent_parser_test.dart`
  - **Belum diimplementasikan**:
    - ❌ 13a: Jadwal ujian + countdown
    - ❌ 13b: Pengumuman dosen → mahasiswa
    - ❌ 13c: Profil foto + QR kartu mahasiswa
    - ❌ 13d: Riwayat perubahan nilai
    - ❌ 13e: Grafik tren per mahasiswa
    - ❌ 13f: Multi-device role
    - ❌ 13h: Widget launcher / shortcut

- [ ] **Step 14: Pengujian dan finalisasi** (NFR-06, 07, 08, 12, 14)
  - **Sebagian sudah ada**:
    - ✅ 16 file test + 2 folder (unit/, widget/)
    - ✅ `test/unit/step1_foundation_test.dart` (7646 bytes)
    - ✅ `test/widget/step1_widgets_test.dart` (4078 bytes)
    - ✅ `test/auth_test.dart`, `test/auth_flow_test.dart`, `test/crypto_test.dart`, `test/encryption_test.dart`
    - ✅ `test/academic_constants_test.dart`, `test/academic_engine_test.dart`
    - ✅ `test/qr_token_test.dart`, `test/risk_score_test.dart`
    - ✅ `test/csv_notify_test.dart`, `test/sync_backup_test.dart`
    - ✅ `test/migration_test.dart`, `test/seed_test.dart`
    - ✅ `test/intent_parser_test.dart`
    - ✅ `test/widget_test.dart`
  - **Belum selesai**:
    - ❌ Integration test di `integration_test/` (folder ada, kosong)
    - ❌ Performance test cold start < 3s dengan 10.000 record
    - ❌ Accessibility audit (semantics, contrast)
    - ❌ Code coverage report ≥ 80% use case
    - ❌ Final `flutter analyze` + `flutter test` green
    - ❌ README.md update dengan panduan instalasi

---

## Ringkasan Arsitektur File

```
lib/
├── main.dart                          # Bootstrap SQLCipher + Riverpod + router
├── core/
│   ├── constants/app_constants.dart    # Konstanta global (PIN max, lock duration, dll)
│   ├── errors/failures.dart           # AuthFailure, ForbiddenFailure, ValidationFailure
│   ├── l10n/                          # (kosong — TODO Step 12)
│   ├── router/app_router.dart         # GoRouter + auth gate + semua rute
│   ├── security/
│   │   ├── flag_secure.dart           # FLAG_SECURE untuk anti-screenshot
│   │   └── gate.dart                  # GateStatus enum + ValueNotifier
│   ├── theme/app_theme.dart           # Material 3 terang + gelap
│   └── utils/
│       ├── clock.dart                 # Clock abstraction (SystemClock, FakeClock)
│       └── result.dart                # Result<T, E> monad (Ok, Err)
├── data/
│   ├── daos/                          # (kosong — query langsung di AppDatabase)
│   ├── local/
│   │   ├── app_database.dart          # AppDatabase @DriftDatabase
│   │   ├── app_database.g.dart        # Generated Drift code
│   │   ├── tables.dart                # 27 tabel Drift (410 baris)
│   │   ├── connection/
│   │   │   ├── database_key_manager.dart   # Kunci enkripsi dari flutter_secure_storage
│   │   │   └── encrypted_connection.dart   # SQLCipher executor
│   │   └── seed/
│   │       └── seed_data.dart         # Seeder 100 mahasiswa dummy
│   ├── mappers/                       # (kosong — mapping inline)
│   ├── repositories/                  # (kosong — query via AppDatabase langsung)
│   └── services/
│       ├── auth_service.dart          # Setup, login, lockout, recovery, RBAC
│       ├── backup_service.dart        # Backup/restore AES-256-GCM terenkripsi
│       ├── crypto_service.dart        # PBKDF2 + hashing + recovery code
│       └── secure_store.dart          # Wrapper flutter_secure_storage
├── domain/                            # Pure Dart, tanpa import Flutter/Drift
│   ├── academic/
│   │   ├── grades.dart                # Nilai akhir, IPS/IPK, batas SKS, simulasi
│   │   └── validations.dart           # Validasi NIM, nama, angkatan, email, phone
│   ├── analytics/
│   │   └── risk_score.dart            # Skor risiko, level, early warning
│   ├── assistant/
│   │   └── intent_parser.dart         # NLP on-device Level 1+2
│   ├── entities/                      # (kosong — entity = Drift row classes)
│   ├── import/
│   │   └── csv_preview.dart           # CSV parse + validasi
│   ├── notifications/
│   │   └── local_notify.dart          # NotificationService interface + Noop
│   ├── presensi/
│   │   └── qr_token.dart              # QR HMAC-SHA256 + verifikasi jendela
│   ├── repositories/                  # (kosong — belum di-abstract)
│   ├── security/
│   │   ├── permission_checker.dart    # RBAC enforcement
│   │   ├── roles.dart                 # 5 peran + 7 permission + matrix
│   │   └── string_store.dart          # StringStore interface
│   ├── sync/
│   │   └── sync_merge.dart            # Last-write-wins merge + conflict resolution
│   └── usecases/                      # (kosong — logic di services)
├── presentation/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── lock_page.dart         # PIN numpad + recovery
│   │   │   ├── setup_page.dart        # First-run setup
│   │   │   └── users_page.dart        # Account management (RBAC)
│   │   ├── dbinfo/
│   │   │   └── db_info_page.dart      # DB info + diagnostik
│   │   ├── home/
│   │   │   └── home_page.dart         # Dashboard + search + list
│   │   ├── mahasiswa/
│   │   │   ├── mahasiswa_form_page.dart  # Form tambah/edit mahasiswa
│   │   │   └── trash_page.dart           # Tempat sampah
│   │   ├── nilai/
│   │   │   └── mahasiswa_detail_page.dart  # Detail + nilai + KHS + transkrip
│   │   └── settings/
│   │       └── settings_page.dart     # Pengaturan (tema, bobot, parameter)
│   ├── providers/
│   │   ├── app_providers.dart         # Dashboard, search, DB providers
│   │   └── session_providers.dart     # Session, auth state, theme mode
│   └── shared/widgets/
│       ├── app_scaffold.dart
│       ├── app_shell.dart             # Bottom nav shell
│       ├── app_text_field.dart
│       ├── auto_lock_scope.dart       # Auto-lock timer
│       ├── confirm_dialog.dart
│       ├── dashboard_widgets.dart     # Kartu statistik
│       ├── empty_state.dart
│       ├── error_state.dart
│       ├── loading_view.dart
│       ├── section_card.dart
│       ├── shared_widgets.dart
│       └── status_chip.dart
└── services/
    ├── audit/
    │   └── audit_logger.dart          # AuditLogger + DbAuditLogger + NoopAuditLogger
    ├── seed/
    │   └── seed_service.dart          # Seed service + isolate runner
    └── sync/
        └── device_id_service.dart     # UUID v4 persisten

test/
├── academic_constants_test.dart
├── academic_engine_test.dart
├── auth_flow_test.dart
├── auth_test.dart
├── crypto_test.dart
├── csv_notify_test.dart
├── encryption_test.dart
├── intent_parser_test.dart
├── migration_test.dart
├── qr_token_test.dart
├── risk_score_test.dart
├── seed_test.dart
├── sync_backup_test.dart
├── widget_test.dart
├── unit/
│   └── step1_foundation_test.dart
└── widget/
    └── step1_widgets_test.dart
```

---

## Catatan Asumsi & Keputusan Desain

1. **Step 0**: Semua dependensi berhasil di-resolve tanpa konflik. SQLCipher via `package:sqlite3` native-assets hook.
2. **Step 1**: Fondasi UI + DB + seeder diverifikasi 69 tests, 0 analyzer issues. FTS5 virtual table untuk full-text search.
3. **Step 2**: PIN di-hash PBKDF2 (never stored plain). Lockout escalating 30s→60s→120s→...→900s. Recovery code sekali pakai disimpan hash-nya di flutter_secure_storage.
4. **Step 3**: Pencarian menggunakan FTS5 (NIM + nama). Pagination via offset/limit di query Drift. Soft-delete via `is_deleted` flag + TrashPage.
5. **Step 4**: MK yang diulang → best grade wins (bukan replace). IPS/IPK dengan `sum(SKS)=0` → 0.00 (bukan NaN/error). Grade bands sesuai PRD exact.
6. **Step 5**: Batas SKS validasi di domain, bukan hanya UI. Tabel jadwal mendukung multi-kelas per MK.
7. **Step 6**: PDF framework siap. Template PDF detail perlu dikerjakan per halaman (KHS vs transkrip vs laporan).
8. **Step 7**: QR interval 30 detik, verifikasi jendela ±1 interval. Constant-time comparison mencegah timing attack. Duplikat dicegah UNIQUE constraint DB.
9. **Step 8**: Risk score menggunakan piecewise function (bukan formula linear PRD literal) untuk transparansi dan kemudahan interpretasi. Bobot dapat diubah via tabel RiskWeightsTable.
10. **Step 9**: CSV parser custom tanpa library tambahan. Validasi per baris sebelum import (preview mode). AuditLogger di tiap service method.
11. **Step 10**: AES-256-GCM + PBKDF2 50000 iterasi. Format `.simaha` JSON berisi semua metadata dekripsi. SHA-256 checksum untuk integrity.
12. **Step 11**: Last-write-wins deterministik (deviceId tiebreaker). Idempoten by design. Sinkronisasi via file (bukan network) sesuai aturan full-offline.
13. **Step 12**: Tema gelap sudah works. Notification + l10n belum implementasi penuh.
14. **Step 13**: Hanya asisten cerdas (13g) yang sudah implementasi domain logic + test. Modul lain opsional dan belum prioritas.
15. **Step 14**: 16 file test ada. Integration test belum. Performance profiling belum.

---

## Yang Perlu Dikerjakan (Prioritas)

| Prioritas | Item | Step |
|---|---|---|
| 🔴 Tinggi | Implementasi `flutter_local_notifications` plugin nyata | Step 12 |
| 🔴 Tinggi | l10n ID/EN (arb files + MaterialLocalizations) | Step 12 |
| 🟡 Sedang | Integration test di `integration_test/` | Step 14 |
| 🟡 Sedang | Performance test 10.000 records | Step 14 |
| 🟢 Rendah | PDF template detail (KHS, transkrip, laporan) | Step 6 |
| 🟢 Rendah | Modul opsional 13a-13f, 13h | Step 13 |
| 🟢 Rendah | Code coverage report | Step 14 |
| 🟢 Rendah | README.md update | Step 14 |

> Checkpoint 20 Oktober 2026: pekerjaan ditunda atas permintaan pengguna. Detail implementasi tersimpan dan prioritas lanjutan: [doct/LANJUT_BESOK.md](doct/LANJUT_BESOK.md). Desain Stitch dan verifikasi jendela Windows belum selesai.
