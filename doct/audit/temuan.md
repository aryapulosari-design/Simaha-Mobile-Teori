# Temuan dan dokumentasi perbaikan

Tanggal 21 Oktober 2026. Status dibedakan antara perbaikan yang diuji dan pemeriksaan yang masih memerlukan data/perangkat pengguna.

| ID | Kondisi ditemukan | Perbaikan | Bukti dan batas |
|---|---|---|---|
| BUG-01 | Demo membuka secure storage yang sama dengan mode biasa; DPAPI gagal pada konteks Windows berbeda | WorkspaceStorage dan DemoStore khusus, database 50 mahasiswa baru, tanpa akses secure storage produksi | workspace_storage_test dan stage4_regression_test. Pembukaan data produksi lama belum diverifikasi ulang |
| BUG-02 | FilePicker.platform tidak tersedia pada file_picker 13.1.0 sehingga build gagal | FilePicker.saveFile menerima bytes dan MIME application/pdf | Analyzer, widget, build ulang dan tes ekspor PDF |
| BUG-03 | Fungsi risiko tidak mengikuti rumus yang tertulis pada aturan proyek | Normalisasi linear IPK/presensi/tren/SKS sesuai aturan | risk_score_test dan stage4_regression_test |
| BUG-04 | Validator angka tidak menolak NaN | Pemeriksaan isFinite di validator dan mesin nilai | Kasus NaN/Infinity pada tes regresi |
| BUG-05 | Kartu metrik berbeda tinggi dan jadwal tidak mengisi lebar kartu | Tinggi per baris disamakan, jadwal membentang, layout satu kolom untuk teks besar | Preview desktop, ponsel dan teks 160 persen |
| BUG-06 | Ringkasan berpotensi tertinggal setelah penyimpanan nilai/presensi | Invalidasi provider ringkasan setelah simpan dan pembacaan ulang sesuai role | Tes integrasi perubahan nilai/presensi serta uji widget |
| BUG-07 | Build APK memerlukan desugaring dependensi notifikasi yang belum digunakan | Konfigurasi desugaring ditambahkan; selanjutnya seluruh paket serta izin yang tidak dipakai dilepas | pubspec/lock dirapikan dan log dependencies; tidak mengklaim fitur notifikasi tersedia |
| BUG-08 | Registrant release Android menyertakan integration_test yang tidak tersedia saat kompilasi Java | Dependensi pengujian perangkat yang belum digunakan dilepas, registrant diregenerasi, verifikasi Flutter dijalankan berurutan | Build APK final dan daftar dependensi. Tidak mengubah generated Java secara manual |
| BUG-09 | Proses demo dari sandbox Windows tidak boleh menulis ke Documents | Override SIMAHA_DEMO_DIRECTORY hanya untuk demo; kegagalan tidak menghapus data | workspace_storage_test menguji folder khusus, reopen dan file produksi tidak berubah |

Kegagalan awal pengujian akibat BUG-02 disimpan pada `bukti/tests-sebelum-perbaikan.jsonl`; hasil akhir berada pada `bukti/tests.jsonl`. Log build akhir diperbarui setelah perbaikan. Tidak ada hasil calon pengguna yang dibuat dari data sintetis.
