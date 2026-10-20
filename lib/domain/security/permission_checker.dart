import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/domain/security/roles.dart';

/// Domain usecase/service for enforcing Role-Based Access Control (RBAC).
class PermissionChecker {
  const PermissionChecker();

  /// Returns true if [role] possesses [permission].
  bool hasPermission(Role role, Permission permission) {
    return canRole(role, permission);
  }

  /// Throws [ForbiddenFailure] if [role] lacks [permission].
  void require(Role role, Permission permission) {
    if (!hasPermission(role, permission)) {
      throw ForbiddenFailure(
        'Akses ditolak: Peran ${role.label} tidak memiliki izin ${permission.name}',
      );
    }
  }

  bool canManageUsers(Role role) => hasPermission(role, Permission.manageUsers);
  bool canManageMaster(Role role) => hasPermission(role, Permission.manageMaster);
  bool canManageNilai(Role role) => hasPermission(role, Permission.manageNilai);
  bool canViewAllMahasiswa(Role role) => hasPermission(role, Permission.viewAllMahasiswa);
  bool canManageBimbingan(Role role) => hasPermission(role, Permission.manageBimbingan);
  bool canViewAnalytics(Role role) => hasPermission(role, Permission.viewAnalytics);
  bool canBackupRestore(Role role) => hasPermission(role, Permission.backupRestore);
}
