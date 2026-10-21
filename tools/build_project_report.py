"""Rebuild the Stage 4/5 report from checked-in narrative and recorded evidence.
Run with: uv run --with reportlab --with pymupdf python tools/build_project_report.py
"""
from pathlib import Path
import json, csv, html, hashlib
from collections import Counter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak, Image, KeepTogether, Flowable
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_CENTER, TA_JUSTIFY
from reportlab.lib.pagesizes import A4
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / 'doct' / 'laporan'
OUT.mkdir(parents=True, exist_ok=True)
DATE = '21 Oktober 2026'
AUTHORS = [('Pandhu Syach Aryanto','240605110002'),('Muhammad Aditya Dermawan','240605110172'),('Arya Kharisudin Irfani','240605110227')]
REPO = 'https://github.com/aryapulosari-design/Simaha-Mobile-Teori'

def read(path):
    p = ROOT / path
    if not p.exists(): return ''
    b = p.read_bytes()
    return b.decode('utf-16' if b.startswith(b'\xff\xfe') else 'utf-8-sig', errors='replace')

records = []
runner_results = []
for prefix, log in enumerate(['bukti/tests.jsonl', 'bukti/registration-tests.jsonl']):
    for line in read(log).splitlines():
        try:
            record = json.loads(line)
            for key in ['test', 'suite']:
                if key in record:
                    for field in ['id', 'suiteID']:
                        if field in record[key]: record[key][field] = f'{prefix}:{record[key][field]}'
            if 'testID' in record: record['testID'] = f'{prefix}:{record["testID"]}'
            if record.get('type') == 'done': runner_results.append(record.get('success', False))
            records.append(record)
        except (ValueError, TypeError): pass
names = {r['test']['id']:r['test'] for r in records if r.get('type') == 'testStart'}
suites = {r['suite']['id']:r['suite']['path'] for r in records if r.get('type') == 'suite'}
results = [r for r in records if r.get('type') == 'testDone' and not r.get('hidden')]
counts = Counter(r['result'] for r in results)
done = next((r for r in reversed(records) if r.get('type')=='done'), {})
done['success'] = len(runner_results) == 2 and all(runner_results)
with (OUT/'hasil_pengujian_otomatis.csv').open('w', encoding='utf-8-sig', newline='') as f:
    w=csv.writer(f, lineterminator='\n'); w.writerow(['ID','Kasus pengujian aktual','Berkas','Hasil'])
    for i,r in enumerate(results,1):
        t=names.get(r['testID'],{}); p=suites.get(t.get('suiteID'),'')
        w.writerow([f'AUTO-{i:03}',t.get('name',''), p.split('/simaha/')[-1],r['result']])

sections=[]
def section(title, paragraphs=(), headers=None, rows=(), image=None):
    sections.append(dict(title=title,paragraphs=list(paragraphs),headers=headers,rows=list(rows),image=image))

section('1 Pendahuluan dan ruang lingkup',[
 'SIMAHA Offline dikembangkan sebagai aplikasi Flutter untuk menghubungkan administrasi mahasiswa, pengajaran, perwalian, dan pemantauan studi dalam satu perangkat. Masalah yang ditangani adalah data akademik yang terpisah serta ketidakjelasan kewenangan setiap pengguna ketika membaca atau memperbarui data.',
 'Kebutuhan pengguna diterjemahkan menjadi lima peran: Super Admin menyiapkan akun; Admin Akademik mengelola data studi; Dosen Pengampu mengisi nilai kelas; Dosen Wali mendampingi mahasiswa; dan Mahasiswa memantau data dirinya. Tujuan integrasi adalah memastikan perubahan oleh satu pihak terbaca oleh pihak lain yang berwenang.',
 'Laporan ini mencakup Tahap 4 Integrasi Pengujian dan Penyempurnaan serta Tahap 5 Finalisasi Dokumentasi dan Presentasi. Implementasi yang berjalan, hasil tes otomatis, rancangan uji pengguna, dan kekurangan disajikan secara terpisah. Kandidat aplikasi belum dinyatakan memenuhi seluruh rancangan awal sebelum semua pekerjaan tersisa dan uji pengguna ditutup.',
 'Data demonstrasi bersifat sintetis: 50 mahasiswa, 5 dosen, 5 kelas, 250 KRS beserta nilai, 15 pertemuan, 750 catatan kehadiran, dan 50 catatan bimbingan awal. Angka 50 menyatakan data mahasiswa demo, bukan jumlah peserta penelitian pengguna.',
],['Aspek','Keputusan'],[
 ['Platform','Flutter native Android dan Windows; alur utama offline tanpa backend.'],
 ['Konteks data','Program studi Informatika, semester Gasal 2026/2027, lima mata kuliah masing-masing 3 SKS.'],
 ['Hubungan','Kelima dosen mengajar seluruh 50 mahasiswa. Setiap dosen menjadi wali bagi 10 mahasiswa.'],
 ['Status akademik','Dokumen hasil studi lokal bukan transkrip resmi yang disahkan kampus.'],
 ['Acuan awal','Kebutuhan awal di doct/prd/README.md dan pemeriksaan status di doct/audit/README.md.'],
])

section('2 Rancangan integrasi dan implementasi Flutter',[
 'Integrasi mengikuti alur presentasi, layanan aplikasi, logika domain, dan penyimpanan. Widget menampilkan status serta menerima masukan; Riverpod mengelola dependensi dan pembaruan data; go_router mengelola navigasi; layanan memeriksa akun aktif dan batas data sebelum menjalankan transaksi Drift pada SQLCipher.',
 'AcademicService menjadi batas akses untuk mahasiswa, kelas, dan nilai. MasterDataService menghubungkan form prodi, dosen, tahun ajaran, mata kuliah, prasyarat dan kelas untuk kedua role admin. CampusService menangani pengumuman, sesi serta presensi manual, dan pembacaan audit. InsightsService menyusun ringkasan dari pembacaan yang sudah diotorisasi. StudyExportService menghasilkan PDF setelah memeriksa izin dan lingkup mahasiswa.',
 'Penyelesaian kandidat difokuskan pada fungsi yang terhubung dan isi kelima role. Data master dibuka dari menu Akademik. KRS baru mengikuti semester kelas aktif, program studi, IPS semester sebelumnya, batas SKS, prasyarat dan bentrok jadwal. Data yang sudah dipakai dilindungi dari penghapusan atau perubahan struktur; ruang kelas tetap dapat diperbarui.',
 'Logika perhitungan IPK, SKS, simulasi dan risiko dipisahkan pada domain Dart. Komponen BentoCard, MetricTile, BentoGrid, ContextTag, dan WorkspacePage digunakan kembali agar warna, jarak, dan perilaku responsif konsisten. Direktori mahasiswa dipisahkan dari kartu dashboard untuk mengurangi kepadatan HomePage.',
 'Pada mode biasa, kunci SQLCipher tetap berasal dari secure storage platform. Mode demo menggunakan file database baru simaha_demo_50.db dan preferensi khusus dengan kunci acak yang disimpan bersama preferensi demo. Penyimpanan demo ditujukan hanya untuk data sintetis yang terbuka dan tidak memiliki tingkat perlindungan yang sama dengan mode biasa. Demo tidak membuka secure storage produksi.',
],['Komponen','Tanggung jawab'],[
 ['Presentation','Halaman login, dashboard lima peran, kelas, mahasiswa, presensi, pengumuman, insight dan pengaturan.'],
 ['Riverpod dan router','Status sesi, pemuatan ulang setelah perubahan, navigasi, serta penolakan rute admin.'],
 ['Domain','Nilai berbobot 30/30/40, konversi huruf, IPK nilai terbaik, SKS, simulasi, risiko dan validasi.'],
 ['Data','SQLCipher melalui Drift, hubungan akun-profil, transaksi, layanan akses, seed idempoten dan audit.'],
 ['Keamanan','PIN PBKDF2 dengan salt, lockout bertahap, auto-lock, batas per role, dan pemisahan demo.'],
])

section('3 Hubungan lima peran dan data demonstrasi',[
 'Setiap akun mempunyai satu role. Satu profil dosen dapat terhubung dengan dua akun berbeda untuk tugas Pengampu dan Wali. Pembagian ini menjaga agar kewenangan memberi nilai berbeda dari kewenangan membaca seluruh hasil studi mahasiswa bimbingan.',
 'Contoh integrasi: Pengampu Rahma mengubah nilai Algoritma milik Alya. Mahasiswa Alya membaca nilai yang sama dan ringkasan studinya diperbarui. Wali Rahma menulis tindak lanjut bimbingan; Alya membaca catatan tersebut. Pengampu Budi tidak dapat mengubah nilai Algoritma dan Wali Budi tidak dapat membuka bimbingan Alya.',
 'Login demo cukup memilih role serta nama akun dari daftar, kemudian menggunakan PIN awal 123456. Terdapat 62 akun: satu Super Admin, satu Admin Akademik, lima Pengampu, lima Wali, dan 50 Mahasiswa. Seeder berjalan sekali; perubahan tersimpan ketika aplikasi dibuka kembali.',
],['Peran','Fungsi dan batas akses'],[
 ['Super Admin','Kelola akun, reset PIN, hubungkan profil, seluruh data akademik, bimbingan, serta audit.'],
 ['Admin Akademik','Kelola master prodi/dosen/semester/mata kuliah/kelas, mahasiswa, KRS/nilai, presensi dan pengumuman. Tidak mengelola akun atau catatan bimbingan.'],
 ['Dosen Pengampu','Kelas sendiri, nilai peserta, sesi dan presensi kelas sendiri. Tidak membaca IPK kumulatif atau catatan wali.'],
 ['Dosen Wali','Profil, nilai, IPK, insight dan kehadiran 10 mahasiswa bimbingan; menulis catatan serta tindak lanjut.'],
 ['Mahasiswa','Profil, mata kuliah, jadwal, nilai, insight, rekap kehadiran dan catatan wali sendiri; unduh PDF hasil studi.'],
])

section('4 Tahap 4 Skenario dan kasus pengujian',[
 'Pengujian meliputi perhitungan domain, layanan pada database sementara, otorisasi lima role, integrasi perubahan antarakun, validasi masukan, navigasi serta widget responsif. Pengujian otomatis menggunakan data sintetis dan tidak menggantikan pengujian pada calon pengguna.',
 'Kasus disusun dengan prasyarat, langkah, hasil yang diharapkan, serta bukti. Daftar hasil setiap tes aktual diekspor ke hasil_pengujian_otomatis.csv. Log mentah tersedia pada bukti/tests.jsonl. Pengujian antarmuka tambahan mencakup desktop, tablet, ponsel, tema gelap, serta teks 160 persen pada lebar 320 piksel.',
],['ID','Skenario dan hasil yang diharapkan'],[
 ['TC-01','Login akun benar; role dan profil yang terhubung sesuai. PIN salah ditolak dan lockout meningkat.'],
 ['TC-02','Seluruh 62 akun demo menerima PIN awal dan role yang terdokumentasi.'],
 ['TC-03','Lima pengampu masing-masing melihat 50 peserta; nilai kelas dosen lain ditolak.'],
 ['TC-04','Lima wali masing-masing memperoleh 10 mahasiswa berbeda; seluruh 50 mahasiswa tercakup.'],
 ['TC-05','Mahasiswa hanya membaca profil, nilai, kehadiran dan bimbingan dirinya.'],
 ['TC-06','Perubahan nilai Pengampu terbaca oleh Mahasiswa, Wali, Admin Akademik dan Super Admin.'],
 ['TC-07','Catatan bimbingan Wali terbaca mahasiswa terkait; akses pihak lain ditolak.'],
 ['TC-08','Presensi disimpan, diperbarui tanpa duplikasi, dan terbaca mahasiswa serta wali terkait.'],
 ['TC-09','Status presensi tidak valid, peserta asing dan penulisan oleh role tanpa izin ditolak.'],
 ['TC-10','Pengumuman admin terbaca role lain; masukan pendek dan publikasi mahasiswa ditolak.'],
 ['TC-11','PDF menghasilkan struktur PDF nyata; ekspor mahasiswa lain serta ekspor Pengampu ditolak.'],
 ['TC-12','Data arsip hilang dari pencarian, dapat dipulihkan, dan indeks pencarian tetap konsisten.'],
 ['TC-13','Navigasi admin ditolak bagi mahasiswa; tema berubah tanpa mereset rute aktif.'],
 ['TC-14','Demo tidak mengubah file mode biasa; preferensi persisten dan masukan NaN ditolak.'],
])

build_apk=read('bukti/build-apk.log'); build_win=read('bukti/build-windows.log'); analysis=read('bukti/analyze.log')
apks=list((ROOT/'artifacts').glob('*.apk'))
apk_status='Berhasil; lihat manifest artefak.' if apks else 'Belum ada APK kandidat pada artifacts; lihat log build.'
section('5 Tahap 4 Tabel hasil pengujian',[
 f'Pada bukti pengujian yang dipakai saat laporan dibangun tercatat {counts.get("success",0)} tes berhasil, {counts.get("error",0)+counts.get("failure",0)} tes gagal atau error, dan {counts.get("skipped",0)} tes berstatus skipped. Status akhir runner adalah {"lulus" if done.get("success") else "belum lulus atau belum lengkap"}. Angka ini berasal dari log, bukan jumlah skenario manual.',
 'Kelulusan tes otomatis menunjukkan perilaku dalam kondisi uji yang didefinisikan. Pengujian perangkat fisik, pemindai QR, kehilangan perangkat, pemulihan kunci produksi, benchmark 10000 mahasiswa, pembaca layar, serta evaluasi calon pengguna belum dapat dianggap lulus tanpa bukti tambahan.',
],['Pemeriksaan','Hasil atau bukti'],[
 ['Unit dan integrasi layanan',f'{counts.get("success",0)} berhasil; rincian pada CSV, bukti/tests.jsonl dan bukti/registration-tests.jsonl.'],
 ['Analisis statis','Bersih' if 'No issues found' in analysis else 'Lihat bukti/analyze.log; hasil belum dinyatakan bersih.'],
 ['Widget responsif','Lihat bukti/widget-previews.log dan PNG pada doct/design/previews.'],
 ['Build Windows','Build sebelumnya berhasil; belum diulang setelah penambahan form master.' if ('Built build' in build_win) else 'Lihat bukti/build-windows.log.'],
 ['Build Android kandidat',apk_status],
 ['Uji calon pengguna','Belum dilaksanakan. Jumlah responden yang sudah menguji: 0.'],
 ['Uji Android fisik','Belum ada bukti pengujian langsung pada perangkat fisik.'],
 ['Pengujian ulang','Dilakukan setelah perbaikan API ekspor dan perapian UI; bukti akhir disimpan terpisah dari kegagalan awal.'],
])

section('6 Tahap 4 Kesalahan dan dokumentasi perbaikan',[
 'Masalah dicatat berdasarkan temuan pada kode, kompilasi, atau pemeriksaan visual. Perbaikan kemudian diperiksa menggunakan tes yang relevan. Temuan lama terkait secure storage produksi tidak ditutup hanya karena mode demo dapat dijalankan.',
],['ID','Temuan','Perbaikan dan status'],[
 ['BUG-01','Demo membuka penyimpanan kunci yang sama dengan mode biasa; konteks Windows berbeda memicu kegagalan DPAPI.','Database dan DemoStore khusus, tanpa pemanggilan secure storage produksi. Uji isolasi lulus. Pembukaan ulang data produksi lama masih memerlukan verifikasi.'],
 ['BUG-02','Pemanggilan FilePicker.platform tidak tersedia pada versi 13.1.0 sehingga build gagal.','Menggunakan FilePicker.saveFile dengan bytes dan MIME PDF. Jalankan ulang analyzer, tes, serta build.'],
 ['BUG-03','Normalisasi risiko tidak sesuai rumus yang tertulis pada aturan proyek.','Fungsi IPK, kehadiran, tren dan SKS menggunakan normalisasi linear yang disepakati; regresi menguji titik tengah tiap faktor.'],
 ['BUG-04','Validator angka menerima NaN karena perbandingan rentang saja tidak mencukupi.','Pemeriksaan isFinite pada validator dan mesin nilai; kasus NaN dan Infinity ditolak.'],
 ['BUG-05','Kartu metrik berbeda tinggi dan kartu jadwal menyusut pada desktop.','Grid menyamakan tinggi per baris dan jadwal membentang mengikuti lebar kartu. Diperiksa pada preview aktual.'],
 ['BUG-06','Penghapusan atau perubahan data perlu memperbarui ringkasan lintas halaman.','Provider ringkasan studi diinvalidasi setelah simpan nilai dan presensi, lalu membaca ulang data terotorisasi.'],
])

section('7 Tahap 4 Rencana dan hasil pengujian pengguna',[
 'Pengujian calon pengguna belum dilaksanakan. Tidak ada skor kepuasan, kutipan komentar, jumlah keberhasilan tugas, maupun nilai SUS yang dapat dilaporkan sebagai hasil nyata. Lima puluh mahasiswa di database adalah data demonstrasi dan bukan responden.',
 'Rencana pelaksanaan melibatkan beberapa calon pengguna, disarankan 5 sampai 8 orang dengan variasi pengalaman menggunakan aplikasi akademik. Peserta menggunakan akun sintetis. Fasilitator menjelaskan tujuan, meminta persetujuan, dan mencatat tugas tanpa mengumpulkan identitas pribadi yang tidak diperlukan.',
 'Setiap peserta diminta memilih role dan login, menemukan jadwal, membuka nilai serta kehadiran, mencoba alur perubahan nilai dan catatan wali sesuai role, berganti akun, serta menemukan pengumuman. Catat keberhasilan, waktu penyelesaian, kebutuhan bantuan, kesalahan, dan komentar. Hindari memberi petunjuk sebelum peserta mencoba.',
 'Sesudah tugas, peserta menilai kemudahan login, kejelasan navigasi, keterbacaan, pemahaman role dan kepuasan keseluruhan pada skala 1 sampai 5. Rata-rata baru dihitung setelah data nyata terkumpul. Temuan dikelompokkan menurut dampak, diperbaiki, dan diuji ulang sebelum penetapan versi final.',
],['Instrumen','Status dan lokasi'],[
 ['Skenario moderator','Disediakan dalam doct/laporan/UJI_PENGGUNA.md.'],
 ['Form per peserta','Disediakan dengan ID anonim, tugas, waktu, hasil, bantuan dan komentar.'],
 ['Tabel hasil responden','Kosong; status belum dilaksanakan. Tidak diisi memakai data simulasi.'],
 ['Kesimpulan usability','Menunggu pengujian nyata; belum ada klaim mudah digunakan secara empiris.'],
 ['Bukti pelaksanaan','Tanggal, persetujuan, lembar hasil dan dokumentasi yang diizinkan peserta perlu ditambahkan.'],
])

section('8 Tahap 4 Penyempurnaan antarmuka',[
 'Acuan visual berasal dari folder Stitch yang disediakan pengguna. Prinsip yang diterapkan adalah latar abu kebiruan #F8F9FF, kartu putih, teal #00685F, aksen indigo, garis pembatas halus, grid berjarak konsisten, dan tipografi lokal. Plus Jakarta Sans digunakan untuk judul, Inter untuk teks, serta JetBrains Mono untuk label kode.',
 'Dashboard dibedakan berdasarkan tugas. Mahasiswa melihat IPK, beban studi, progres dan kehadiran pribadi. Pengampu melihat kelas serta kelengkapan nilai. Wali melihat bimbingan dan prioritas pendampingan. Admin memperoleh ringkasan lintas kelas dan akses pengelolaan.',
 'Navigasi ponsel menggunakan empat tujuan utama; pengelolaan akun dan database tetap dapat diakses admin melalui halaman terkait. Komponen menyediakan status loading, data kosong, kesalahan dan percobaan ulang. Elemen interaktif mengarah ke fungsi yang sudah terhubung; tampilan referensi tidak digunakan untuk mengklaim fitur yang belum dibuat.',
])

mobile_gallery = [
 ('Dashboard pengelola', 'Super Admin dan Admin Akademik memperoleh ringkasan serta akses pengelolaan sesuai tugasnya.', [
   ('mobile-role-super_admin', 'Dashboard Super Admin', 'Ringkasan data akademik dan akses pengelolaan sistem.'),
   ('mobile-role-admin_akademik', 'Dashboard Admin Akademik', 'Ringkasan administrasi mahasiswa dan perkuliahan.')]),
 ('Dashboard dosen', 'Tampilan ponsel membedakan pekerjaan pengampu dan wali tanpa mengubah batas akses masing-masing.', [
   ('mobile-role-dosen_pengampu', 'Dashboard Dosen Pengampu', 'Ringkasan kelas yang diajar dan kelengkapan nilai.'),
   ('mobile-role-dosen_wali', 'Dashboard Dosen Wali', 'Ringkasan mahasiswa bimbingan dan pendampingan studi.')]),
 ('Dashboard mahasiswa dan direktori', 'Mahasiswa memantau studi sendiri, sedangkan admin mengakses data mahasiswa melalui bagian bawah beranda.', [
   ('mobile-role-mahasiswa', 'Dashboard Mahasiswa', 'Ringkasan IPK, SKS dan progres studi pribadi.'),
   ('mobile-role-super_admin-suite', 'Beranda Super Admin setelah digulir', 'Bagian lanjutan beranda pada layar ponsel yang sama.')]),
 ('Rincian beranda akademik', 'Halaman yang panjang digulir secara vertikal. Screenshot berikut memperlihatkan bagian lanjutan pada ukuran layar ponsel.', [
   ('mobile-role-admin_akademik-suite', 'Beranda Admin Akademik setelah digulir', 'Konten lanjutan untuk administrasi akademik.'),
   ('mobile-role-dosen_pengampu-suite', 'Beranda Pengampu setelah digulir', 'Konten lanjutan yang mengikuti lingkup kelas pengampu.')]),
 ('Pemantauan studi pada ponsel', 'Konten lanjutan mengikuti lingkup akun wali dan mahasiswa; screenshot diambil sesudah menggulir beranda.', [
   ('mobile-role-dosen_wali-suite', 'Beranda Wali setelah digulir', 'Informasi lanjutan pendampingan mahasiswa bimbingan.'),
   ('mobile-role-mahasiswa-suite', 'Beranda Mahasiswa setelah digulir', 'Informasi lanjutan studi pribadi dan navigasi fitur.')]),
 ('Kelas, jadwal dan hasil studi', 'Pengampu melihat kelas yang diajarnya. Mahasiswa membaca hasil serta rekap kehadiran dirinya pada kelas terkait.', [
   ('mobile-kelas-pengampu', 'Kelas Dosen Pengampu', 'Mata kuliah, dosen, jadwal, ruang dan jumlah peserta dalam akses akun.'),
   ('mobile-kelas-mahasiswa', 'Detail kelas Mahasiswa', 'Nilai dan rekap kehadiran pribadi pada mata kuliah yang dipilih.')]),
 ('Bimbingan akademik', 'Wali menulis catatan dan tindak lanjut; mahasiswa membaca catatan yang ditujukan kepadanya.', [
   ('mobile-bimbingan-wali', 'Catatan dari sisi Dosen Wali', 'Riwayat bimbingan dan catatan tindak lanjut yang sudah disimpan.'),
   ('mobile-bimbingan-mahasiswa', 'Catatan dari sisi Mahasiswa', 'Mahasiswa membaca catatan wali tanpa tombol penulisan.')]),
]
for i, (title, description, shots) in enumerate(mobile_gallery, 1):
    section(f'8.{i} Dokumentasi mobile: {title}', [description,
        'Render widget Flutter aktual pada viewport 390 x 844 piksel dengan data sintetis. Gambar diperkecil secara proporsional dalam bingkai ponsel untuk dokumentasi; bukan foto pengujian pada perangkat Android fisik.'])
    sections[-1]['screenshots'] = shots

section('9 Tahap 5 Finalisasi dan paket penyerahan',[
 'Paket penyerahan memuat kode sumber Flutter, dokumentasi peran dan arsitektur, bukti pengujian, APK kandidat bila build berhasil, serta laporan ini. Repositori proyek menggunakan tautan yang diberikan kelompok. Artefak yang belum mempunyai bukti diberi status belum dilaksanakan atau belum tersedia.',
 'APK kandidat dibuat melalui build release untuk demonstrasi data sintetis. Konfigurasi proyek saat ini masih memakai sertifikat debug pada build release, sehingga belum dinyatakan sebagai paket distribusi produksi. Identitas signing milik kelompok dan uji perangkat perlu diselesaikan sebelum publikasi final.',
 'Penetapan aplikasi final membutuhkan penutupan pekerjaan tersisa, evaluasi calon pengguna, pemeriksaan Android fisik dan verifikasi penyimpanan produksi. Modul tambahan pada rancangan awal seperti QR, backup/restore, sinkronisasi, impor/ekspor menyeluruh, EDOM, arsip dan asisten belum otomatis dianggap selesai.',
],['Luaran','Kondisi'],[
 ['Aplikasi yang dijalankan','Build Windows dan Android diperiksa berdasarkan log; hasil Android fisik belum tersedia.'],
 ['File APK','Kandidat demo pada artifacts bila build berhasil; nama dan SHA256 dalam manifest.'],
 ['Kode dan Git',REPO],
 ['Dokumentasi teknis','README.md serta doct/architecture, roles, features, demo, security, testing dan audit.'],
 ['Laporan akhir','Dokumen Tahap 4 dan Tahap 5 ini serta sumber yang dapat diperbarui.'],
 ['Video demonstrasi','Naskah dan daftar adegan disediakan; rekaman demonstrasi nyata masih perlu dibuat.'],
 ['Bahan presentasi','Outline presentasi tersedia dalam doct/laporan/PRESENTASI.md.'],
 ['Demonstrasi langsung','Skenario disediakan; pelaksanaan presentasi langsung menjadi tugas kelompok.'],
])

section('10 Transparansi sumber dan kesiapan presentasi',[
 'Pengembangan memakai Flutter dan Dart beserta pustaka sumber terbuka yang tercantum pada pubspec.yaml dan pubspec.lock. Referensi visual berasal dari ekspor Stitch milik pengguna. Font Inter, Plus Jakarta Sans dan JetBrains Mono dibundel bersama lisensi OFL masing-masing.',
 'Bantuan kecerdasan artifisial digunakan dalam penyusunan dan perapian kode, penulisan pengujian, pemeriksaan implementasi serta penyusunan dokumentasi. Kelompok wajib meninjau, menjalankan, memahami, dan mampu menjelaskan kode yang diserahkan. Bantuan AI tidak dipakai untuk mengarang hasil uji pengguna, riwayat kegiatan atau bukti pelaksanaan tahap.',
 'Presentasi mengikuti hubungan masalah, kebutuhan pengguna, rancangan solusi, implementasi Flutter, pengujian dan hasil aplikasi. Setiap anggota perlu dapat menjelaskan alur data yang didemonstrasikan, pemisahan role, provider, transaksi database, validasi serta batas versi kandidat.',
 'Riwayat Git dan dokumen PROGRESS.md dipertahankan sebagai bukti perkembangan yang benar-benar tersedia. Laporan ini tidak menyatakan bahwa seluruh Tahap 1 sampai Tahap 5 sudah dinilai atau dilaksanakan pada tanggal tertentu tanpa bukti dari kelompok.',
],['Sumber','Pemakaian dan pengakuan'],[
 ['Flutter dan Dart','Framework UI dan bahasa aplikasi. Versi lingkungan tercatat pada hasil pemeriksaan toolchain.'],
 ['Riverpod dan go_router','Pengelolaan dependensi, state dan navigasi.'],
 ['Drift dan SQLCipher','Penyimpanan relasional lokal serta enkripsi database.'],
 ['cryptography dan flutter_secure_storage','Hash PIN serta penyimpanan kunci platform pada mode biasa.'],
 ['pdf dan file_picker','Pembuatan serta penyimpanan hasil studi PDF.'],
 ['Stitch dan Google Fonts','Acuan tampilan dan font lokal berlisensi OFL.'],
 ['Bantuan AI','Asistensi implementasi dan dokumentasi; tanggung jawab akademik tetap pada kelompok.'],
])

sections[5]['rows'].extend([
 ['BUG-10','Data master belum mempunyai form yang dapat dipakai kedua admin.','Form tambah/ubah/hapus disambungkan ke layanan, transaksi, audit, dan proteksi data yang masih dipakai.'],
 ['BUG-11','Penambahan KRS menebak semester aktif global dan belum memeriksa aturan per semester.','Semester diambil dari kelas; service memeriksa status/prodi, IPS sebelumnya, batas SKS, prasyarat, duplikat dan jadwal. Tes regresi tersedia pada master_data_test.dart dan registration_policy_test.dart.'],
 ['BUG-07','Konfigurasi desugaring Android belum tersedia untuk dependensi notifikasi.','Konfigurasi diperbaiki dan paket/izin yang belum dipakai dihapus. Build diulang dari dependensi aktif.'],
 ['BUG-08','Build release memuat plugin integration_test yang tidak tersedia.','Dependensi yang belum dipakai dilepas, registrant diregenerasi dan verifikasi Flutter dijalankan berurutan.'],
 ['BUG-09','Desktop terkelola menolak penulisan demo ke Documents.','Folder demo dapat diarahkan melalui SIMAHA_DEMO_DIRECTORY; tes membuktikan file mode biasa tidak berubah.'],
])
styles=getSampleStyleSheet()
font_dir=Path('C:/Windows/Fonts')
for name,file in [('Report','times.ttf'),('ReportBold','timesbd.ttf')]:
    pdfmetrics.registerFont(TTFont(name,str(font_dir/file)))
styles.add(ParagraphStyle(name='BodyReport',fontName='Report',fontSize=11,leading=16,alignment=TA_JUSTIFY,spaceAfter=10))
styles.add(ParagraphStyle(name='HeadingReport',fontName='ReportBold',fontSize=15,leading=21,spaceAfter=18))
styles.add(ParagraphStyle(name='CellReport',fontName='Report',fontSize=9,leading=12))
styles.add(ParagraphStyle(name='HeaderReport',fontName='ReportBold',fontSize=9,leading=12,textColor=colors.white))
styles.add(ParagraphStyle(name='CoverReport',fontName='ReportBold',fontSize=17,leading=25,alignment=TA_CENTER,spaceAfter=16))
styles.add(ParagraphStyle(name='CenterReport',fontName='Report',fontSize=12,leading=19,alignment=TA_CENTER,spaceAfter=10))
styles.add(ParagraphStyle(name='HeaderMobile',fontName='ReportBold',fontSize=10,leading=13,alignment=TA_CENTER,spaceAfter=6))
styles.add(ParagraphStyle(name='CaptionMobile',fontName='Report',fontSize=9,leading=12,alignment=TA_CENTER,spaceAfter=6))

def P(text,style='BodyReport'): return Paragraph(html.escape(str(text)),styles[style])

class PhoneScreenshot(Flowable):
    def __init__(self, path):
        Flowable.__init__(self)
        self.path = path
        self.width = 180
        self.height = 380
        from reportlab.lib.utils import ImageReader
        self.reader = ImageReader(str(path))
        if self.reader.getSize() != (390, 844):
            raise ValueError(f'Mobile screenshot must be 390x844: {path}')
    def draw(self):
        c = self.canv
        c.setFillColor(colors.HexColor('#1C2530'))
        c.roundRect(0, 0, self.width, self.height, 15, stroke=0, fill=1)
        c.drawImage(self.reader, 5, 9, width=170, height=170*844/390)
        c.setFillColor(colors.HexColor('#C7CED6'))
        c.roundRect(73, 3, 34, 2, 1, stroke=0, fill=1)
def footer(canvas,doc):
    if doc.page==1:return
    canvas.saveState();canvas.setFont('Report',9);canvas.setFillColor(colors.HexColor('#555555'))
    canvas.drawString(78,35,'SIMAHA | Laporan Tahap 4 dan Tahap 5');canvas.drawRightString(A4[0]-78,35,str(doc.page-1));canvas.restoreState()
flow=[Spacer(1,20),P('TUGAS PERTEMUAN','CoverReport'),Spacer(1,12),P('LAPORAN TAHAP 4 DAN TAHAP 5','CoverReport'),P('SIMAHA Offline','CoverReport'),P('Integrasi Pengujian Penyempurnaan dan Finalisasi Proyek','CenterReport'),Spacer(1,45),P('Oleh','CenterReport')]
for name,nim in AUTHORS:flow.append(P(f'{name}   {nim}','CenterReport'))
flow += [Spacer(1,45),P('FAKULTAS SAINS DAN TEKNOLOGI','CoverReport'),P('PROGRAM STUDI TEKNIK INFORMATIKA','CenterReport'),P('UNIVERSITAS ISLAM NEGERI','CenterReport'),P('MAULANA MALIK IBRAHIM MALANG','CenterReport'),P('2026','CenterReport'),PageBreak()]
width=A4[0]-156
for index,s in enumerate(sections):
    flow.append(P(s['title'],'HeadingReport'))
    for body in s['paragraphs']:flow.append(P(body))
    if s['headers']:
        n=len(s['headers']); col=[width/n]*n
        if n==2:col=[width*0.27,width*0.73]
        if n==3:col=[width*0.14,width*0.36,width*0.50]
        table=Table([[P(v,'HeaderReport') for v in s['headers']]]+[[P(v,'CellReport') for v in row] for row in s['rows']],colWidths=col,repeatRows=1,hAlign='LEFT')
        table.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),colors.HexColor('#243746')),('VALIGN',(0,0),(-1,-1),'TOP'),('LEFTPADDING',(0,0),(-1,-1),8),('RIGHTPADDING',(0,0),(-1,-1),8),('TOPPADDING',(0,0),(-1,-1),7),('BOTTOMPADDING',(0,0),(-1,-1),7),('ROWBACKGROUNDS',(0,1),(-1,-1),[colors.white,colors.HexColor('#F4F6F8')]),('LINEBELOW',(0,0),(-1,0),0.5,colors.HexColor('#BBBBBB'))]))
        flow.append(table)
    if s['image'] and (ROOT/s['image']).exists():
        flow.append(Spacer(1,12)); flow.append(Image(str(ROOT/s['image']),width=width,height=width*1000/1440));flow.append(Spacer(1,8));flow.append(P('Gambar antarmuka Flutter aktual dengan fixture data sintetis untuk pemeriksaan layout.','CellReport'))
    if s.get('screenshots'):
        cells = []
        for j, (name, title, caption) in enumerate(s['screenshots']):
            number = (int(s['title'].split('.')[1].split()[0])-1)*2+j+1
            shot = ROOT/'doct/design/previews'/f'{name}.png'
            if not shot.exists(): raise FileNotFoundError(shot)
            cells.append([PhoneScreenshot(shot), Spacer(1,12), P(f'Gambar {number}. {title}', 'HeaderMobile'), P(caption, 'CaptionMobile')])
        grid = Table([cells], colWidths=[width/2]*2)
        grid.setStyle(TableStyle([('VALIGN',(0,0),(-1,-1),'TOP'),('ALIGN',(0,0),(-1,-1),'CENTER'),('LEFTPADDING',(0,0),(-1,-1),12),('RIGHTPADDING',(0,0),(-1,-1),12)]))
        flow.append(Spacer(1,12)); flow.append(grid)
    if index != len(sections)-1:flow.append(PageBreak())
path=OUT/'Laporan_Tahap_4_dan_5_SIMAHA.pdf'
SimpleDocTemplate(str(path),pagesize=A4,leftMargin=78,rightMargin=78,topMargin=68,bottomMargin=60,title='Laporan Tahap 4 dan Tahap 5 SIMAHA',author='; '.join(n for n,_ in AUTHORS)).build(flow,onFirstPage=footer,onLaterPages=footer)
md=['# TUGAS PERTEMUAN','## Laporan Tahap 4 dan Tahap 5 SIMAHA Offline','',*[f'- {n} — {nim}' for n,nim in AUTHORS],'','Fakultas Sains dan Teknologi, Program Studi Teknik Informatika, Universitas Islam Negeri Maulana Malik Ibrahim Malang, 2026.','']
for s in sections:
    md += ['## '+s['title'],'',*sum(([p,''] for p in s['paragraphs']),[])]
    if s['headers']:md += ['| '+' | '.join(s['headers'])+' |','| '+' | '.join(['---']*len(s['headers']))+' |',*['| '+' | '.join(str(v).replace('|','/') for v in row)+' |' for row in s['rows']],'']
    for name, title, caption in s.get('screenshots', []):
        md += [f'![{title}](../design/previews/{name}.png)', '', f'**{title}.** {caption}', '']
(OUT/'LAPORAN_TAHAP_4_DAN_5.md').write_text('\n'.join(md),encoding='utf-8',newline='\n')
import pymupdf as fitz
pdf=fitz.open(path); qa=ROOT/'.dart_tool'/'report-qa';qa.mkdir(parents=True,exist_ok=True)
for i,page in enumerate(pdf):page.get_pixmap(matrix=fitz.Matrix(1.25,1.25)).save(qa/f'page-{i+1:02}.png')
print(json.dumps({'pdf':str(path),'pages':len(pdf),'automated_tests':dict(counts),'runner_success':done.get('success')},ensure_ascii=False))
