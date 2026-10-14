import 'package:uuid/uuid.dart';
import 'package:simaha/data/services/secure_store.dart';
import 'package:simaha/domain/security/string_store.dart';

/// Service to provide a unique, persistent Device ID (UUID v4) for multi-device sync.
/// Stored once in secure storage and cached in memory.
class DeviceIdService {
  DeviceIdService({StringStore? store, Uuid? uuid})
      : _store = store ?? SecureStore(),
        _uuid = uuid ?? const Uuid();

  static const String keyDeviceId = 'device_id_uuid';

  final StringStore _store;
  final Uuid _uuid;
  String? _cachedId;

  /// Returns existing device ID, or generates and stores a new UUID v4.
  Future<String> getDeviceId() async {
    if (_cachedId != null) return _cachedId!;
    final stored = await _store.read(keyDeviceId);
    if (stored != null && stored.isNotEmpty) {
      _cachedId = stored;
      return stored;
    }
    final newId = _uuid.v4();
    await _store.write(keyDeviceId, newId);
    _cachedId = newId;
    return newId;
  }

  /// Synchronously returns cached ID if already initialized.
  String? get cachedDeviceId => _cachedId;
}
