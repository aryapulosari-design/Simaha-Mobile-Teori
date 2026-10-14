// Minimal key-value abstraction so AuthService stays unit-testable
// (flutter_secure_storage has no test double on plain `flutter test`).
abstract class StringStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// In-memory implementation for tests (and previews).
class MemoryStore implements StringStore {
  final Map<String, String> _map = {};
  @override
  Future<String?> read(String key) async => _map[key];
  @override
  Future<void> write(String key, String value) async => _map[key] = value;
  @override
  Future<void> delete(String key) async => _map.remove(key);
}
