// App-level failures as a sealed hierarchy (pure Dart).

/// Base failure.
sealed class AppFailure {
  const AppFailure(this.message);
  final String message;
}

/// Database-related failure (open, migrate, query).
final class DatabaseFailure extends AppFailure {
  const DatabaseFailure(super.message);
}

/// Encryption/key failure (missing key, wrong key, corrupt file).
final class CryptoFailure extends AppFailure {
  const CryptoFailure(super.message);
}

/// Validation failure (caller should show message to user).
final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}

/// Unexpected failure (bugs, unhandled states).
final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message);
}

/// Authentication failure (wrong PIN, locked, setup needed).
final class AuthFailure extends AppFailure {
  const AuthFailure(super.message);
}

/// Authorization failure (role lacks permission). Thrown at the service
/// layer so UI hiding a button is never the only protection.
final class ForbiddenFailure extends AppFailure {
  const ForbiddenFailure(super.message);
}
