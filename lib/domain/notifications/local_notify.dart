// Kontrak notifikasi lokal (FR-38, pure Dart).
// Implementasi nyata (flutter_local_notifications) butuh plugin + izin
// platform, jadi di belakang interface; default [NoopNotifications]
// agar app tetap jalan offline tanpa plugin.

/// Pesan terjadwal (KRS, jadwal, peringatan dini).
class LocalNotice {
  const LocalNotice({
    required this.id,
    required this.title,
    required this.body,
  });

  final int id;
  final String title;
  final String body;
}

abstract class NotificationService {
  Future<void> show(LocalNotice notice);
  Future<List<LocalNotice>> get scheduled;
}

/// Default: simpan di memori (dipakai UI + test). Ganti dengan plugin
/// saat dependensi ditambahkan, tanpa mengubah pemanggil.
class NoopNotifications implements NotificationService {
  final List<LocalNotice> _sent = [];

  @override
  Future<void> show(LocalNotice notice) async {
    _sent.add(notice);
  }

  @override
  Future<List<LocalNotice>> get scheduled async => List.unmodifiable(_sent);
}
