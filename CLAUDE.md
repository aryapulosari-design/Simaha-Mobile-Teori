# CLAUDE.md — Aturan Proyek SIMAHA Offline

## ATURAN PROYEK

- FULL MOBILE: dilarang membuat backend, REST API, atau panggilan jaringan untuk fitur inti. 100% fitur inti jalan offline.
- Database: SQLite terenkripsi (Drift + SQLCipher). Kunci enkripsi acak 32 byte disimpan di flutter_secure_storage.
  (Catatan teknis: SQLCipher terpasang via package:sqlite3 + native-assets hook `source: sqlcipher` di pubspec.yaml sesuai standar Flutter/Dart terkini).
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
