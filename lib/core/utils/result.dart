// Pure-Dart result type using sealed classes (Dart 3).
// No Flutter import so domain/core logic stays testable without emulator.

/// Base type for operation outcomes.
sealed class Result<S, F extends Object> {
  const Result();
}

/// Success case.
final class Ok<S, F extends Object> extends Result<S, F> {
  const Ok(this.value);
  final S value;
}

/// Failure case.
final class Err<S, F extends Object> extends Result<S, F> {
  const Err(this.failure);
  final F failure;
}

/// Convenience getters with pattern matching.
extension ResultX<S, F extends Object> on Result<S, F> {
  bool get isOk => this is Ok<S, F>;
  bool get isErr => this is Err<S, F>;

  S? get valueOrNull => switch (this) {
    Ok(value: final v) => v,
    Err() => null,
  };

  F? get failureOrNull => switch (this) {
    Ok() => null,
    Err(failure: final f) => f,
  };
}
