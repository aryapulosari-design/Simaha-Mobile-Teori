# PROGRESS.md — Status Step SIMAHA Offline

Acuan: PRD + `CLAUDE.md` (aturan & rumus domain). Diperbarui setiap akhir step.

- [x] **Step 0: Konteks, struktur proyek, dependensi**
  - Flutter 3.47.2, Dart 3.13.2 stable
  - Struktur folder dibentuk: `lib/{core,domain,data,services,presentation}`, `test/`, `integration_test/`
  - Dependensi lengkap terpasang di `pubspec.yaml`
  - `CLAUDE.md` dan `PROGRESS.md` diinisialisasi
- [x] **Step 1: Fondasi: tema, router, DB terenkripsi, skema penuh, seeder** (NFR-01, 09, 10, 11, 13)
  - Tema Material 3 konsisten (terang & gelap) di `AppTheme`
  - 8 Komponen reusable di `lib/presentation/shared/widgets`: `AppScaffold`, `EmptyState`, `ErrorState`, `LoadingView`, `ConfirmDialog`, `SectionCard`, `StatusChip`, `AppTextField`
  - `go_router` dengan `ShellRoute`, bottom navigation role-aware, rute placeholder `/setup`, `/lock` & `/login`, `/home`
  - Database terenkripsi SQLCipher 256-bit dengan kunci acak di Keystore / `flutter_secure_storage`
  - Skema lengkap 27 tabel (termasuk `SavedFilters`), foreign keys aktif (`PRAGMA foreign_keys = ON;`), transaksi multi-tabel
  - Indeks dan FTS5 virtual table + triggers sinkronisasi otomatis
  - Service pendukung: `DeviceIdService` (UUID v4 persisten), `Clock` abstraction (`SystemClock`, `FakeClock`), `AuditLogger` interface & `DbAuditLogger`, `SeedService` (isolate & transaksi)
  - 69/69 test lulus, `flutter analyze` 0 issues
- [ ] **Step 2: Keamanan, akun, RBAC** (FR-01 s.d. FR-06, NFR-02, 04)
- [ ] **Step 3: Data master + mahasiswa + pencarian/filter** (FR-07, 08, 09, 10, 11, 12)
- [ ] **Step 4: Nilai, IPS/IPK** (FR-15, 16)
- [ ] **Step 5: KRS + jadwal kuliah** (FR-13, 14, 18)
- [ ] **Step 6: KHS, transkrip, ekspor PDF** (FR-17, 28)
- [ ] **Step 7: Presensi QR dan manual, rekap** (FR-19, 20, 21, 22)
- [ ] **Step 8: Dashboard, early warning, skor risiko, catatan bimbingan** (FR-23, 24, 25, 26)
- [ ] **Step 9: Impor/ekspor data, audit log, tempat sampah** (FR-27, 28, 33, 09)
- [ ] **Step 10: Backup dan restore terenkripsi** (FR-29, 30, NFR-03)
- [ ] **Step 11: Sinkronisasi antar-perangkat + konflik** (FR-31, 32)
- [ ] **Step 12: Notifikasi, mode gelap, bahasa, pengaturan** (FR-34, 35, 36)
- [ ] **Step 13: Modul tambahan (opsional)** (13a s.d. 13h)
- [ ] **Step 14: Pengujian dan finalisasi** (NFR-06, 07, 08, 12, 14)

---

### Catatan Asumsi & Status Saat Ini:
- Step 0 selesai: semua dependensi yang disyaratkan telah berhasil dipasang dan di-resolve tanpa konflik.
- Step 1 selesai: fondasi UI, routing, database SQLCipher, skema lengkap, dan service pendukung telah terverifikasi dengan unit dan widget tests (69 passing tests, 0 analyzer issues).
- Arsitektur SQLCipher menggunakan `package:sqlite3` dengan hook native-assets `source: sqlcipher` yang merupakan standar resmi terkini di Flutter/Dart untuk kompatibilitas lintas platform.
