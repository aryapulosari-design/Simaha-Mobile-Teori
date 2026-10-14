// Sync tanpa server: last-write-wins per record (FR-31/32, pure Dart).
// Setiap record: updated_at (epoch detik) + device_id.
// Konflik: yang lebih baru menang; seri -> device_id terbesar (deterministik).
// Idempoten: paket yang sama diterapkan 2x hasilnya sama.

/// Satu baris delta sync (sudah di-decrypt).
class SyncRecord {
  const SyncRecord({
    required this.table,
    required this.id,
    required this.updatedAt,
    required this.deviceId,
    required this.data,
  });

  final String table;
  final String id;
  final int updatedAt;
  final String deviceId;
  final Map<String, Object?> data;

  String get key => '$table:$id';
}

/// Hasil merge untuk log sync_log.
class SyncMergeResult {
  const SyncMergeResult({
    required this.merged,
    required this.applied,
    required this.conflicts,
  });

  /// Peta key -> record menang.
  final Map<String, SyncRecord> merged;

  /// Berapa record dari [incoming] yang dipakai (menang).
  final int applied;

  /// Berapa key yang ada di kedua sisi dengan isi beda (dicatat ke sync_log).
  final int conflicts;
}

/// true jika [a] menang atas [b] (lebih baru, atau deviceId lebih besar).
bool winsOver(SyncRecord a, SyncRecord b) {
  if (a.updatedAt != b.updatedAt) return a.updatedAt > b.updatedAt;
  return a.deviceId.compareTo(b.deviceId) > 0;
}

/// Gabungkan [local] dengan paket [incoming]. Tidak mengubah input.
SyncMergeResult mergeSyncDeltas({
  required Map<String, SyncRecord> local,
  required List<SyncRecord> incoming,
}) {
  final merged = Map<String, SyncRecord>.from(local);
  var applied = 0;
  var conflicts = 0;
  for (final inc in incoming) {
    final cur = merged[inc.key];
    if (cur == null) {
      merged[inc.key] = inc;
      applied++;
      continue;
    }
    if (cur.updatedAt == inc.updatedAt &&
        cur.deviceId == inc.deviceId &&
        _mapsEqual(cur.data, inc.data)) {
      continue; // identik: idempoten, tidak dihitung
    }
    conflicts++;
    if (winsOver(inc, cur)) {
      merged[inc.key] = inc;
      applied++;
    }
  }
  return SyncMergeResult(
    merged: merged,
    applied: applied,
    conflicts: conflicts,
  );
}

bool _mapsEqual(Map<String, Object?> a, Map<String, Object?> b) {
  if (a.length != b.length) return false;
  for (final k in a.keys) {
    if (!b.containsKey(k) || b[k] != a[k]) return false;
  }
  return true;
}
