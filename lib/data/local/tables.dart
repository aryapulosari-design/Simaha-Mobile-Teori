import 'package:drift/drift.dart';

// ---------------------------------------------------------------------------
// Drift tables for SIMAHA Offline (schema v1).
// All multi-table writes must run inside transactions (enforced in repositories
// and seeders, Tahap C+). Foreign keys are enforced via PRAGMA in
// AppDatabase.beforeOpen.
// ---------------------------------------------------------------------------

@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  // Role: super_admin | admin_akademik | dosen_pengampu | dosen_wali | mahasiswa
  TextColumn get role => text()();
  TextColumn get pinHash => text()();
  TextColumn get salt => text()();
  BoolColumn get biometricEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get lockedUntil => dateTime().nullable()();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('ProdiRow')
class Prodi extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kode => text().unique()();
  TextColumn get nama => text()();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('DosenRow')
class Dosens extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nidn => text().unique()();
  TextColumn get nama => text()();
  IntColumn get userId => integer().nullable().references(Users, #id)();
  // A lecturer may teach and advise with distinct, role-scoped accounts.
  @ReferenceName('waliAccount')
  IntColumn get waliUserId => integer().nullable().references(Users, #id)();
  IntColumn get prodiId => integer().references(Prodi, #id)();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('MahasiswaRow')
class Mahasiswa extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nim => text().unique()();
  TextColumn get nama => text()();
  IntColumn get prodiId => integer().references(Prodi, #id)();
  IntColumn get angkatan => integer()();
  // Status: aktif | cuti | nonaktif | do | lulus
  TextColumn get status => text().withDefault(const Constant('aktif'))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get noHp => text().withDefault(const Constant(''))();
  TextColumn get fotoPath => text().nullable()();
  IntColumn get dosenWaliId => integer().nullable().references(Dosens, #id)();
  IntColumn get userId => integer().nullable().references(Users, #id)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text().withDefault(const Constant('seed'))();
}

@DataClassName('TahunAjaranRow')
class TahunAjaran extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tahun => text()();
  // 1 = gasal, 2 = genap, 3 = pendek
  IntColumn get semester => integer()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('MataKuliahRow')
class MataKuliah extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kode => text().unique()();
  TextColumn get nama => text()();
  IntColumn get sks => integer()();
  IntColumn get semester => integer()();
  IntColumn get prodiId => integer().references(Prodi, #id)();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('PrasyaratMkRow')
class PrasyaratMk extends Table {
  @ReferenceName('mk_prasyarat')
  IntColumn get mkId => integer().references(MataKuliah, #id)();
  @ReferenceName('prasyarat_for_mk')
  IntColumn get prasyaratMkId => integer().references(MataKuliah, #id)();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();

  @override
  Set<Column> get primaryKey => {mkId, prasyaratMkId};
}

@DataClassName('KelasRow')
class Kelas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mkId => integer().references(MataKuliah, #id)();
  IntColumn get dosenId => integer().references(Dosens, #id)();
  IntColumn get taId => integer().references(TahunAjaran, #id)();
  TextColumn get hari => text()();
  TextColumn get jamMulai => text()();
  TextColumn get jamSelesai => text()();
  TextColumn get ruang => text().withDefault(const Constant(''))();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('KrsRow')
class Krs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mahasiswaId => integer().references(Mahasiswa, #id)();
  IntColumn get kelasId => integer().references(Kelas, #id)();
  IntColumn get taId => integer().references(TahunAjaran, #id)();
  // draft | diambil | disetujui | ditolak | batal
  TextColumn get status => text().withDefault(const Constant('diambil'))();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('NilaiRow')
class Nilai extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get krsId => integer().unique().references(Krs, #id)();
  RealColumn get tugas => real().withDefault(const Constant(0))();
  RealColumn get uts => real().withDefault(const Constant(0))();
  RealColumn get uas => real().withDefault(const Constant(0))();
  RealColumn get nilaiAkhir => real().withDefault(const Constant(0))();
  TextColumn get huruf => text().withDefault(const Constant('E'))();
  RealColumn get bobot => real().withDefault(const Constant(0))();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('SesiPresensiRow')
class SesiPresensi extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get kelasId => integer().references(Kelas, #id)();
  IntColumn get pertemuanKe => integer()();
  DateTimeColumn get tanggal => dateTime()();
  TextColumn get qrSecret => text()();
  DateTimeColumn get dibukaSampai => dateTime().nullable()();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('PresensiRow')
class Presensi extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sesiId => integer().references(SesiPresensi, #id)();
  IntColumn get mahasiswaId => integer().references(Mahasiswa, #id)();
  // hadir | izin | sakit | alpa
  TextColumn get status => text()();
  // qr | manual
  TextColumn get metode => text().withDefault(const Constant('manual'))();
  DateTimeColumn get waktu => dateTime()();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {sesiId, mahasiswaId},
  ];
}

@DataClassName('CatatanBimbinganRow')
class CatatanBimbingan extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mahasiswaId => integer().references(Mahasiswa, #id)();
  IntColumn get dosenId => integer().references(Dosens, #id)();
  TextColumn get isi => text()();
  TextColumn get tindakLanjut => text().nullable()();
  DateTimeColumn get tanggal => dateTime()();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('PeringatanRow')
class Peringatan extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mahasiswaId => integer().references(Mahasiswa, #id)();
  TextColumn get jenis => text()();
  RealColumn get skor => real()();
  TextColumn get detail => text().withDefault(const Constant(''))();
  DateTimeColumn get dibuatPada => dateTime()();
  BoolColumn get ditangani => boolean().withDefault(const Constant(false))();
  // Sync delta (Tahap I): every record carries updated_at + device_id.
  // Required, no default: every writer must stamp explicitly so sync
  // never sees NULL/placeholder clocks (enforced at compile time).
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('AuditLogRow')
class AuditLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().nullable().references(Users, #id)();
  TextColumn get aksi => text()();
  TextColumn get entitas => text()();
  TextColumn get entitasId => text().nullable()();
  TextColumn get sebelum => text().nullable()();
  TextColumn get sesudah => text().nullable()();
  DateTimeColumn get waktu => dateTime()();
}

@DataClassName('SyncLogRow')
class SyncLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get deviceId => text()();
  TextColumn get arah => text()();
  IntColumn get jumlahRecord => integer().withDefault(const Constant(0))();
  IntColumn get konflik => integer().withDefault(const Constant(0))();
  DateTimeColumn get waktu => dateTime()();
}

// ---------------------------------------------------------------------------
// Tambahan spek seksi 4 (dibuat di Tahap A agar skema lengkap sejak awal;
// UI-nya menyusul di Tahap I/J). Semua membawa updated_at + device_id
// untuk delta sync last-write-wins, kecuali Pengaturan yang key-value.
// ---------------------------------------------------------------------------

/// Key-value pengaturan aplikasi (bobot nilai, timeout, ambang, dsb).
/// Termasuk syarat_sks_lulus (default 144) dan kunci_aplikasi untuk QR kartu.
@DataClassName('PengaturanRow')
class Pengaturan extends Table {
  TextColumn get kunci => text()();
  TextColumn get nilai => text()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();

  @override
  Set<Column> get primaryKey => {kunci};
}

@DataClassName('PengumumanRow')
class Pengumuman extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get judul => text()();
  TextColumn get isi => text()();
  TextColumn get kategori => text().withDefault(const Constant('umum'))();
  DateTimeColumn get tanggalMulai => dateTime().nullable()();
  DateTimeColumn get tanggalSelesai => dateTime().nullable()();
  IntColumn get dibuatOleh => integer().nullable().references(Users, #id)();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('AgendaAkademikRow')
class AgendaAkademik extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get judul => text()();
  TextColumn get jenis => text().withDefault(const Constant('umum'))();
  DateTimeColumn get tanggalMulai => dateTime()();
  DateTimeColumn get tanggalSelesai => dateTime().nullable()();
  IntColumn get pengingatMenit => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('JadwalUjianRow')
class JadwalUjian extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get kelasId => integer().references(Kelas, #id)();
  // jenis: UTS | UAS
  TextColumn get jenis => text()();
  DateTimeColumn get tanggal => dateTime()();
  TextColumn get jamMulai => text()();
  TextColumn get jamSelesai => text()();
  TextColumn get ruang => text().withDefault(const Constant(''))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('PrestasiRow')
class Prestasi extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mahasiswaId => integer().references(Mahasiswa, #id)();
  TextColumn get judul => text()();
  TextColumn get kategori => text().withDefault(const Constant('akademik'))();
  TextColumn get tingkat => text().withDefault(const Constant('kampus'))();
  DateTimeColumn get tanggal => dateTime().nullable()();
  TextColumn get deskripsi => text().withDefault(const Constant(''))();
  TextColumn get lampiranPath => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('EdomPeriodeRow')
class EdomPeriode extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taId => integer().references(TahunAjaran, #id)();
  DateTimeColumn get dibuka => dateTime().nullable()();
  DateTimeColumn get ditutup => dateTime().nullable()();
  BoolColumn get isAktif => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

@DataClassName('EdomPertanyaanRow')
class EdomPertanyaan extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get aspek => text()();
  TextColumn get teks => text()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

/// Hanya penanda sudah mengisi (cegah isi ganda). Satu baris per
/// (periode, mahasiswa, kelas).
@DataClassName('EdomPartisipasiRow')
class EdomPartisipasi extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get periodeId => integer().references(EdomPeriode, #id)();
  IntColumn get mahasiswaId => integer().references(Mahasiswa, #id)();
  IntColumn get kelasId => integer().references(Kelas, #id)();
  DateTimeColumn get waktu => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {periodeId, mahasiswaId, kelasId},
  ];
}

/// Jawaban anonim: TANPA mahasiswa_id agar tidak dapat ditelusuri.
@DataClassName('EdomJawabanRow')
class EdomJawaban extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get periodeId => integer().references(EdomPeriode, #id)();
  IntColumn get dosenId => integer().references(Dosens, #id)();
  IntColumn get kelasId => integer().references(Kelas, #id)();
  IntColumn get pertanyaanId => integer().references(EdomPertanyaan, #id)();
  IntColumn get skor => integer()();
  TextColumn get komentar => text().withDefault(const Constant(''))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

/// Arsip dokumen terenkripsi (AES-GCM per berkas, maks 5 MB).
/// Hanya path terenkripsi yang disimpan; dekripsi di memori saja.
@DataClassName('DokumenArsipRow')
class DokumenArsip extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mahasiswaId => integer().references(Mahasiswa, #id)();
  TextColumn get jenis => text()();
  TextColumn get namaBerkas => text()();
  TextColumn get pathTerenkripsi => text()();
  IntColumn get ukuran => integer().withDefault(const Constant(0))();
  IntColumn get diunggahOleh => integer().nullable().references(Users, #id)();
  DateTimeColumn get waktu => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}

/// Filter tersimpan (FR-12) untuk pencarian cepat mahasiswa.
@DataClassName('SavedFilterRow')
class SavedFilters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  TextColumn get kriteriaJson => text()();
  IntColumn get userId => integer().nullable().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get deviceId => text()();
}
