// QR presensi: generator + verifikator + rekap (FR-19..22).
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/domain/presensi/qr_token.dart';

void main() {
  test('token stabil dalam 1 interval, beda antar interval', () async {
    // t0 disejajarkan ke awal interval 30 dtk agar +10 dtk stabil.
    final t0 = DateTime.fromMillisecondsSinceEpoch(1_699_999_980 * 1000);
    final a = await generateQrToken(
      qrSecret: 's3cr3t',
      sesiId: 7,
      waktu: t0,
    );
    final b = await generateQrToken(
      qrSecret: 's3cr3t',
      sesiId: 7,
      waktu: t0.add(const Duration(seconds: 10)),
    );
    expect(a, equals(b));
    final c = await generateQrToken(
      qrSecret: 's3cr3t',
      sesiId: 7,
      waktu: t0.add(const Duration(seconds: 31)),
    );
    expect(c, isNot(equals(a)));
  });

  test('verifikasi ok dalam jendela +/-1, tolak di luar & secret salah',
      () async {
    final t0 = DateTime.fromMillisecondsSinceEpoch(1_699_999_980 * 1000);
    final token = await generateQrToken(
      qrSecret: 's3cr3t',
      sesiId: 7,
      waktu: t0,
    );
    expect(
      await verifyQrToken(
        qrSecret: 's3cr3t',
        sesiId: 7,
        token: token,
        waktu: t0.add(const Duration(seconds: 29)),
      ),
      isTrue,
    );
    // +1 interval masih ok
    expect(
      await verifyQrToken(
        qrSecret: 's3cr3t',
        sesiId: 7,
        token: token,
        waktu: t0.add(const Duration(seconds: 59)),
      ),
      isTrue,
    );
    // +2 interval ditolak
    expect(
      await verifyQrToken(
        qrSecret: 's3cr3t',
        sesiId: 7,
        token: token,
        waktu: t0.add(const Duration(seconds: 95)),
      ),
      isFalse,
    );
    // secret salah ditolak
    expect(
      await verifyQrToken(
        qrSecret: 'lain',
        sesiId: 7,
        token: token,
        waktu: t0,
      ),
      isFalse,
    );
    // sesi lain ditolak
    expect(
      await verifyQrToken(
        qrSecret: 's3cr3t',
        sesiId: 8,
        token: token,
        waktu: t0,
      ),
      isFalse,
    );
  });

  test('rekap persentase hadir', () {
    expect(persentaseHadir([]), 0);
    expect(persentaseHadir(['hadir', 'hadir', 'alpa', 'izin']), 50);
    expect(persentaseHadir(['hadir', 'hadir']), 100);
  });
}
