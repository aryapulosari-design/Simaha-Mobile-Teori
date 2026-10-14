// Skor risiko rule-based (FR-24/25).
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/domain/analytics/risk_score.dart';

void main() {
  test('mahasiswa ideal -> skor 0 Aman', () {
    final s = hitungSkorRisiko(
      ipk: 3.8,
      persenHadir: 100,
      deltaIps: 0.2,
      sksTertinggal: 0,
    );
    expect(s, 0);
    expect(levelRisiko(s), RiskLevel.aman);
    expect(perluPerhatian(s), isFalse);
  });

  test('mahasiswa kritis -> skor >60 Kritis', () {
    final s = hitungSkorRisiko(
      ipk: 1.5,
      persenHadir: 40,
      deltaIps: -1.0,
      sksTertinggal: 30,
    );
    // 0.4*100 + 0.3*60 + 0.2*100 + 0.1*100 = 88
    expect(s, closeTo(88, 1e-9));
    expect(levelRisiko(s), RiskLevel.kritis);
    expect(perluPerhatian(s), isTrue);
  });

  test('batas level 30 dan 60', () {
    expect(levelRisiko(29.9), RiskLevel.aman);
    expect(levelRisiko(30), RiskLevel.waspada);
    expect(levelRisiko(60), RiskLevel.waspada);
    expect(levelRisiko(60.1), RiskLevel.kritis);
  });

  test('bobot tidak 1.0 ditolak', () {
    expect(
      () => hitungSkorRisiko(
        ipk: 3,
        persenHadir: 90,
        deltaIps: 0,
        sksTertinggal: 0,
        weights: const RiskWeights(wIpk: 1, wPresensi: 1, wTren: 0, wSks: 0),
      ),
      throwsArgumentError,
    );
  });
}
