# PROGRESS.md — Status Step SIMAHA Offline

Acuan: `README.md` (PRD) + `CLAUDE.md` (aturan & rumus). Diperbarui tiap akhir step.
Hasil cek terakhir: `flutter analyze` bersih, `flutter test` 55/55 lolos (14 Okt 2026).

- [x] **Step 0 — Setup proyek.** Flutter 3.47.2 stable. Struktur `lib/{core,domain,data,presentation}`,
  `test/`. `flutter pub get` OK. Aturan + rumus disalin ke `CLAUDE.md` (plus catatan deviasi).
  Asumsi: proyek tidak dibuat ulang — repo existing dipakai; dependensi UI ditunda (lihat CLAUDE.md poin 5).
- [x] **Step 1 — Fondasi, database, keamanan.** Drift + SQLCipher (kunci di secure storage),
  setup PIN master, login PIN + lockout eskalasi, auto-lock, RBAC 5 peran di service + UI.
- [x] **Step 2 — Data master & mahasiswa.** CRUD + validasi (NIM unik, email, HP),
  soft delete + trash + restore, FTS5, filter, pagination. Seeder 100 mahasiswa.
- [x] **Step 3 — Mesin akademik (logika).** `grades.dart`: nilai akhir, konversi huruf,
  IPS/IPK (MK diulang nilai terbaik, SKS=0 -> 0.00), batas SKS. Unit test lolos.
  UI: detail nilai per mahasiswa ada; halaman entri KRS massal BELUM.
- [x] **Step 4 — Presensi (logika).** `qr_token.dart`: HMAC-SHA256/30 dtk, jendela ±1,
  rekap hadir. Unit test lolos. UI sesi + QR + scan BELUM.
- [x] **Step 5 — Analitik & peringatan (logika).** `risk_score.dart` + level Aman/Waspada/Kritis.
  Unit test lolos. UI dashboard grafik + catatan bimbingan BELUM.
- [x] **Step 6 — Backup & impor (logika).** `backup_service.dart` (AES-GCM + checksum,
  password salah/file rusak ditolak), `sync_merge.dart` (LWW), `csv_preview.dart`.
  Unit test lolos. UI backup/restore/impor BELUM.
- [ ] **Step 7 — Sinkronisasi antar-perangkat.** Merge LWW + sync_log ada; transport berkas
  + layar tinjau konflik BELUM.
- [x] **Step 8 — Asisten cerdas (logika).** `intent_parser.dart` + `NoopLlm` (tanpa nama/NIM).
  Unit test lolos. UI chat BELUM.
- [ ] **Step 9 — Notifikasi lokal.** `local_notify.dart` masih Noop; paket
  flutter_local_notifications belum dipasang.
- [ ] **Step 10 — Pengaturan & bahasa.** Halaman pengaturan + tema gelap/terang ada;
  bobot nilai/ambang risiko belum bisa diubah di UI; l10n EN belum.
- [x] **Step 11 — Testing & kualitas.** 55 unit test lolos (14 file), `flutter analyze` bersih.
- [ ] **Step 12 — Uji performa 10.000.** Seeder berparameter ada; uji 10.000 + target
  pencarian ≤500 ms BELUM dijalankan.
- [ ] **Step 13 — Dokumentasi & laporan.** README (PRD + status + cara jalan) ada;
  laporan .docx Tahap 1 BELUM.
- [ ] **Step 14 — Finalisasi & demo.** Hapus tombol darurat "Masuk langsung tanpa PIN",
  build APK release ≤50 MB, checklist black-box per FR, demo.
