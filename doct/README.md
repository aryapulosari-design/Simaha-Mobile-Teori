# Dokumentasi SIMAHA Offline

Dokumentasi implementasi per **20 Oktober 2026**. Folder ini bernama `doct` sesuai permintaan.

**Untuk langsung mencoba lima role:** buka [akun demo terisi](demo/README.md). Semua PIN awal 123456; lima dosen dan sepuluh mahasiswa sudah saling terhubung.

## Urutan membaca

1. [Setup](setup/README.md): persyaratan, menjalankan, build, dan masalah umum.
2. [Fitur](features/README.md): fitur yang bisa dipakai serta fondasi modul lanjutan.
3. [Role](roles/README.md): lima peran, lingkup data, tindakan, dan contoh.
4. [Desain](design/README.md): warna, tipografi, layout, interaksi, dan pratinjau.
5. [Arsitektur](architecture/README.md): alur data, struktur kode, schema, perhitungan.
6. [Keamanan](security/README.md): autentikasi, enkripsi, penguncian, keterbatasan.
7. [Pengujian](testing/README.md): perintah tes dan bukti verifikasi.
8. [Audit](audit/README.md): matriks lengkap FR-01–FR-40 dan NFR-01–NFR-14 terhadap kode.
9. [PRD asli](prd/README.md): arsip kebutuhan dan prompt lama.

## Arti status

| Status | Arti |
|---|---|
| Tersedia | Ada alur pengguna yang terhubung dengan penyimpanan lokal. |
| Sebagian | Sebagian alur/persyaratan tersedia; kekurangannya disebutkan. |
| Fondasi | Ada logika/service/interface/tabel, belum menjadi fitur aplikasi lengkap. |
| Belum | Belum ditemukan implementasi alur tersebut. |
| Belum diverifikasi | Perlu pengukuran/perangkat/responden; kode tidak membuktikan hasilnya. |

**Implementasi belum memenuhi semua kebutuhan PRD.** Aplikasi saat ini merupakan fondasi pengelolaan mahasiswa dan nilai dengan lima role lokal. Dependency, tabel, dan mockup bukan bukti bahwa suatu fitur sudah selesai.

README utama dan dokumen implementasi di folder ini menjelaskan kondisi aktual. PRD asli dipertahankan sebagai target. `PROGRESS.md`, `todo.md`, serta folder referensi Stitch menyimpan konteks pengerjaan terdahulu dan tidak menggantikan [audit](audit/README.md).

## Luaran Tahap 4 dan 5

[Laporan, hasil pengujian, temuan/perbaikan, formulir calon pengguna, bahan presentasi dan naskah demonstrasi](laporan/README.md). Dataset demonstrasi diperbarui menjadi 50 mahasiswa dan 5 dosen yang saling terhubung.
