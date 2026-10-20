import 'package:simaha/domain/security/roles.dart';

/// Public account-picker information. Never includes PIN hashes or secrets.
class LoginAccount {
  const LoginAccount({
    required this.id,
    required this.username,
    required this.displayName,
    required this.role,
  });

  final int id;
  final String username;
  final String displayName;
  final Role role;

  String get label =>
      displayName == username ? displayName : '$displayName · $username';
}
