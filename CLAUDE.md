# CLAUDE.md — Aturan Proyek SIMAHA Offline

Sumber kebenaran PRD: `README.md`. File ini berisi aturan kerja + rumus domain (Step 0).

## ATURAN PROYEK

- FULL MOBILE: dilarang membuat backend, REST API, atau panggilan jaringan untuk fitur inti. 100% fitur inti jalan offline.
- Database: SQLite terenkripsi (Drift + SQLCipher). Kunci enkripsi acak 32 byte disimpan di flutter_secure_storage.
- State: Riverpod. Navigasi: go_router. UI: Material 3. Teks UI Bahasa Indonesia (siapkan l10n ID/EN), identifier kode Bahasa Inggris.
- Clean Architecture: presentation -> domain <- data. Domain murni Dart, tanpa import Flutter/Drift.
- Hak akses (RBAC) ditegakkan di use case (domain) DAN disembunyikan di UI. Jangan hanya di UI.
- Semua tabel yang disinkronkan memakai PK UUID v4 (TEXT) + created_at, updated_at (UTC epoch ms), device_id, is_deleted.
- Proses berat (impor, ekspor, backup, hashing, seeder) berjalan di Isolate agar UI tidak freeze.
- Setiap use case logika bisnis wajib punya unit test. `flutter analyze` harus bersih sebelum step dinyatakan selesai.
- Setiap akhir step: update PROGRESS.md (centang + catatan asumsi), lalu ringkas apa yang selesai, cara menjalankan, dan yang belum.
- Jika ada keputusan ambigu: pilih opsi paling aman dan sederhana, catat asumsinya di PROGRESS.md, jangan berhenti bertanya.
- Data uji: seeder data dummy berparameter (default 100 mahasiswa, bisa sampai 10.000).

## RUMUS DOMAIN (sumber kebenaran)

- Peran: SuperAdmin, AdminAkademik, DosenPengampu, DosenWali, Mahasiswa.
- Status mahasiswa: aktif, cuti, lulus, nonaktif.
- Nilai akhir = tugas*w1 + uts*w2 + uas*w3 (default 30/30/40, total bobot wajib 100, dapat diubah di Pengaturan).
- Konversi angka ke huruf/bobot (default, dapat diubah):
  >=85 A=4.0 | 80-84.99 AB=3.5 | 75-79.99 B=3.0 | 70-74.99 BC=2.5 | 60-69.99 C=2.0 | 50-59.99 D=1.0 | <50 E=0.
- IPS = sum(bobot*SKS)/sum(SKS) untuk satu semester. IPK = sama untuk seluruh semester;
  MK yang diulang memakai nilai terbaik. Jika sum(SKS)=0 maka hasil 0.00 (jangan error/NaN).
- Batas SKS KRS dari IPS semester sebelumnya: >=3.00 -> 24 | 2.50-2.99 -> 21 | 2.00-2.49 -> 18 | <2.00 -> 15.
  Semester pertama (belum ada IPS) -> 20.
- Skor risiko = 0.40*f(IPK) + 0.30*f(presensi) + 0.20*f(tren IPS) + 0.10*f(SKS tertinggal), hasil 0-100.
  f(IPK)=clamp((3.0-IPK)/1.5*100); f(presensi)=clamp((90-persen)/40*100);
  f(tren)=0 jika IPS naik/sama, selain itu clamp(penurunan/1.0*100); f(SKS tertinggal)=clamp(tertinggal/20*100).
  Level: <30 Aman | 30-60 Waspada | >60 Kritis. Semua ambang dapat diubah di Pengaturan.
- Early warning: IPK < 2.50, kehadiran < 75%, atau SKS tertinggal > 12 -> buat peringatan.
- Persentase kehadiran = jumlah hadir / jumlah sesi yang sudah ditutup * 100 (izin dan sakit tidak dihitung hadir).
- Token QR presensi = HMAC-SHA256(qr_secret, sesiId + ":" + floor(epochDetik/30)); verifikasi jendela +/-1 interval.
- PIN 6 digit. Lockout: 5 kali salah -> kunci 30 detik, berlipat dua tiap kunci berikutnya. Auto-lock default 2 menit.

## DEVIASI IMPLEMENTASI SAAT INI (catatan asumsi, 14 Okt 2026)

Repo ini sudah terisi implementasi sebelum Step 0 dicatat. Yang di bawah ini kondisi
nyata di kode — berlaku sampai diselaraskan ke rumus di atas:

1. SQLCipher via `package:sqlite3` + hook `source: sqlcipher` (lihat `pubspec.yaml`),
   BUKAN paket `sqlcipher_flutter_libs` (versi 0.7.0+EOL, no-op). Alasan: itu jalur
   resmi package:sqlite3 saat ini.
2. PK tabel = integer autoincrement, BUKAN UUID v4. Kolom sync (`updated_at`, `device_id`)
   ada; `created_at`/`is_deleted` hanya di sebagian tabel.
3. Lockout: 5x salah -> kunci 1 menit, berlipat dua, maks 15 menit (bukan 30 detik).
   Auto-lock: 5 menit idle/background (bukan 2 menit). Lihat `auth_service.dart`, `app_constants.dart`.
4. Fungsi f() risiko di `lib/domain/analytics/risk_score.dart` memakai tabel
   piecewise transparan, BUKAN rumus clamp di atas. Total bobot tetap 0.40/0.30/0.20/0.10,
   level tetap <30 / 30-60 / >60. Test: `test/risk_score_test.dart`.
5. Paket UI (fl_chart, qr_flutter, mobile_scanner, pdf, printing, csv, excel,
   file_picker, share_plus, flutter_local_notifications, timezone, local_auth,
   equatable, collection) BELUM ditambahkan — UI Tahap C-H belum ada, jadi
   dependensi belum dibutuhkan. Ditambah saat step UI-nya dikerjakan.
6. Biometrik belum ada (PIN saja). Struktur folder: `lib/{core,domain,data,presentation}`
   dengan services di `lib/data/services` (bukan `lib/services`).
7. Seeder default 100 mahasiswa (`seed_data.dart`, parameter `mahasiswaCount`);
   uji 10.000 record belum dilakukan.
8. Layar kunci darurat: tombol "Masuk langsung tanpa PIN" (akun `dev_super_admin`)
   masih ada di `lock_page.dart` — dibuat saat perbaikan insiden "Data akun rusak".
   Hapus saat login PIN superadmin sudah normal kembali.
