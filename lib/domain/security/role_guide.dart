import 'package:simaha/domain/security/roles.dart';

extension RoleGuide on Role {
  String get purpose => switch (this) {
    Role.superAdmin =>
      'Menyiapkan akun dan memastikan seluruh data akademik saling terhubung.',
    Role.adminAkademik =>
      'Mengelola mahasiswa, KRS, dan nilai untuk kegiatan administrasi prodi.',
    Role.dosenPengampu =>
      'Mengajar dan menilai mahasiswa pada mata kuliah yang Anda ampu.',
    Role.dosenWali =>
      'Mendampingi studi mahasiswa bimbingan dan mencatat tindak lanjutnya.',
    Role.mahasiswa => 'Memantau rencana studi, nilai, kehadiran, dan arahan dosen wali sendiri.',
  };

  List<String> get availableActions => switch (this) {
    Role.superAdmin => [
      'Membuat akun, memilih role, mengaktifkan/nonaktifkan akun lain, dan reset PIN.',
      'Menghubungkan akun mahasiswa serta akun pengampu/wali dengan profil.',
      'Mengelola seluruh mahasiswa, KRS, nilai, sampah, dan syarat SKS.',
      'Mengelola pengumuman dan presensi, membaca audit, insight studi serta bimbingan.',
    ],
    Role.adminAkademik => [
      'Menambah, mengubah, mengarsipkan, dan memulihkan mahasiswa.',
      'Menambah/menghapus KRS serta memasukkan atau memperbaiki nilai.',
      'Melihat seluruh kelas, dosen, peserta, jadwal, dan rekap kehadiran.',
      'Menerbitkan pengumuman, mengelola presensi, mengubah syarat SKS dan melihat database.',
    ],
    Role.dosenPengampu => [
      'Melihat mata kuliah, jadwal, dan daftar mahasiswa di kelas sendiri.',
      'Mengisi/mengubah nilai tugas, UTS, dan UAS di kelas yang diampu.',
      'Menambah pertemuan, mencatat presensi manual, dan melihat rekap kelas sendiri.',
    ],
    Role.dosenWali => [
      'Melihat profil, KRS, nilai, dan IPK mahasiswa bimbingan.',
      'Melihat kelas dan rekap kehadiran yang diikuti mahasiswa bimbingan.',
      'Menulis bimbingan, memeriksa insight studi, dan menyimpan PDF hasil studi bimbingan.',
    ],
    Role.mahasiswa => [
      'Melihat profil, KRS, jadwal, nilai, IPK, dan progres studi sendiri.',
      'Mencoba simulasi target IPK.',
      'Melihat kehadiran, membaca pengumuman serta catatan wali, dan menyimpan PDF hasil studi.',
    ],
  };

  String get boundary => switch (this) {
    Role.superAdmin =>
      'Akses mencakup seluruh data di ruang yang sedang dibuka.',
    Role.adminAkademik => 'Pengelolaan akun, reset PIN, dan hubungan akun/profil dilakukan Super Admin.',
    Role.dosenPengampu => 'Nilai mata kuliah dosen lain dan catatan bimbingan tidak dapat diubah dari peran ini.',
    Role.dosenWali => 'Hanya mahasiswa bimbingan. Nilai dan KRS dikelola pengampu atau admin akademik.',
    Role.mahasiswa => 'Hanya data sendiri. Perubahan biodata, KRS, dan nilai dilakukan pihak yang berwenang.',
  };
}
