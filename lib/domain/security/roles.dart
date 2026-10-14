// Roles & permissions (pure Dart). Enforcement lives in AuthService and
// repositories (never only in UI), per PRD section 6 (RBAC 5 peran).
enum Role {
  superAdmin('super_admin'),
  adminAkademik('admin_akademik'),
  dosenPengampu('dosen_pengampu'),
  dosenWali('dosen_wali'),
  mahasiswa('mahasiswa');

  const Role(this.storageKey);
  final String storageKey;

  static Role fromStorage(String key) => Role.values.firstWhere(
    (r) => r.storageKey == key,
    orElse: () => Role.mahasiswa,
  );

  String get label => switch (this) {
    Role.superAdmin => 'Super Admin',
    Role.adminAkademik => 'Admin Akademik',
    Role.dosenPengampu => 'Dosen Pengampu',
    Role.dosenWali => 'Dosen Wali',
    Role.mahasiswa => 'Mahasiswa',
  };
}

/// Coarse permissions checked at the service layer.
enum Permission {
  manageUsers, // create/deactivate/reset PIN (Super Admin only)
  manageMaster, // prodi/dosen/MK/TA/kelas (Tahap C)
  manageNilai, // input nilai (Tahap D)
  viewAllMahasiswa, // all students vs own scope
  manageBimbingan, // wali notes (Tahap G)
  viewAnalytics, // dashboards (Tahap G)
  backupRestore, // Tahap E
}

/// Static RBAC matrix.
const Map<Role, Set<Permission>> rolePermissions = {
  Role.superAdmin: {
    Permission.manageUsers,
    Permission.manageMaster,
    Permission.manageNilai,
    Permission.viewAllMahasiswa,
    Permission.manageBimbingan,
    Permission.viewAnalytics,
    Permission.backupRestore,
  },
  Role.adminAkademik: {
    Permission.manageMaster,
    Permission.manageNilai,
    Permission.viewAllMahasiswa,
    Permission.viewAnalytics,
    Permission.backupRestore,
  },
  Role.dosenPengampu: {Permission.manageNilai, Permission.viewAllMahasiswa},
  Role.dosenWali: {
    Permission.viewAllMahasiswa,
    Permission.manageBimbingan,
    Permission.viewAnalytics,
  },
  Role.mahasiswa: {},
};

bool canRole(Role role, Permission permission) =>
    rolePermissions[role]?.contains(permission) ?? false;
