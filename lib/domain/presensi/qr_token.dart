// QR presensi dinamis (FR-19/20, pure Dart).
// token = HMAC-SHA256(qr_secret, sesiId + floor(waktu/30s)) hex.
// Verifikasi jendela +/-1 interval, compare constant-time.
// Cegah ganda ditangani DB UNIQUE(sesi_id, mahasiswa_id).
import 'dart:convert';

import 'package:cryptography/cryptography.dart';

/// Interval refresh QR (detik), sesuai PRD.
const int kQrIntervalSeconds = 30;

/// Status presensi valid (FR-21).
const Set<String> kPresensiStatus = {'hadir', 'izin', 'sakit', 'alpa'};

String _intervalKey(int sesiId, DateTime waktu) {
  final interval = waktu.millisecondsSinceEpoch ~/ (kQrIntervalSeconds * 1000);
  return '$sesiId:$interval';
}

String _hex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

bool _constantTimeEquals(String a, String b) {
  if (a.length != b.length) return false;
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
  }
  return diff == 0;
}

/// Membuat token hex untuk sesi + waktu tertentu.
Future<String> generateQrToken({
  required String qrSecret,
  required int sesiId,
  required DateTime waktu,
}) async {
  final mac = await Hmac.sha256().calculateMac(
    utf8.encode(_intervalKey(sesiId, waktu)),
    secretKey: SecretKey(utf8.encode(qrSecret)),
  );
  return _hex(mac.bytes);
}

/// Verifikasi token dengan toleransi [window] interval (default +/-1).
/// Mengembalikan true jika cocok pada interval waktu-1, waktu, atau waktu+1.
Future<bool> verifyQrToken({
  required String qrSecret,
  required int sesiId,
  required String token,
  required DateTime waktu,
  int window = 1,
}) async {
  final base = waktu.millisecondsSinceEpoch ~/ (kQrIntervalSeconds * 1000);
  for (var d = -window; d <= window; d++) {
    final t = DateTime.fromMillisecondsSinceEpoch(
      (base + d) * kQrIntervalSeconds * 1000,
    );
    final candidate = await generateQrToken(
      qrSecret: qrSecret,
      sesiId: sesiId,
      waktu: t,
    );
    if (_constantTimeEquals(candidate, token)) return true;
  }
  return false;
}

/// Rekap: persentase hadir (0-100). List kosong -> 0.
/// Hanya 'hadir' dihitung hadir; izin/sakit/alpa tidak.
double persentaseHadir(Iterable<String> statusList) {
  final list = statusList.toList();
  if (list.isEmpty) return 0;
  final hadir = list.where((s) => s == 'hadir').length;
  return hadir / list.length * 100;
}
