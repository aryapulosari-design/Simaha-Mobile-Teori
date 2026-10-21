// Skor risiko rule-based transparan (FR-24/25, pure Dart).
// risiko = 0.40*f(IPK) + 0.30*f(presensi) + 0.20*f(tren) + 0.10*f(SKS).
// Semua f() 0-100, bobot dapat diatur via [RiskWeights].
// Level: <30 Aman | 30-60 Waspada | >60 Kritis.

/// Bobot default PRD (harus jumlah 1.0).
class RiskWeights {
  const RiskWeights({
    this.wIpk = 0.40,
    this.wPresensi = 0.30,
    this.wTren = 0.20,
    this.wSks = 0.10,
  });

  final double wIpk;
  final double wPresensi;
  final double wTren;
  final double wSks;

  double get total => wIpk + wPresensi + wTren + wSks;
}

enum RiskLevel { aman, waspada, kritis }

/// IPK 4.0 -> 0 risiko, IPK 0 -> 100. Piecewise transparan.
double fIpk(double ipk) => ((3.0 - ipk) / 1.5 * 100).clamp(0.0, 100.0);

/// Kehadiran 100% -> 0 risiko, 0% -> 100.
double fPresensi(double persenHadir) {
  final p = persenHadir.clamp(0.0, 100.0);
  return ((90 - p) / 40 * 100).clamp(0.0, 100.0);
}

/// Tren IPS: delta = ipsSekarang - ipsSemesterLalu.
/// Naik/tetap -> 0; turun sedikit -> 40; turun sedang -> 70; anjlok -> 100.
double fTrenIps(double delta) => (-delta * 100).clamp(0.0, 100.0);

/// SKS tertinggal dari target (mis. target 20/semester).
/// 0 tertinggal -> 0; >=24 SKS -> 100 (linear di antaranya).
double fSksTertinggal(int sksTertinggal) {
  if (sksTertinggal <= 0) return 0;
  return (sksTertinggal / 20 * 100).clamp(0.0, 100.0);
}

double hitungSkorRisiko({
  required double ipk,
  required double persenHadir,
  required double deltaIps,
  required int sksTertinggal,
  RiskWeights weights = const RiskWeights(),
}) {
  final total = weights.total;
  if ((total - 1.0).abs() > 1e-9) {
    throw ArgumentError('Total bobot harus 1.0 (dapat $total).');
  }
  final skor =
      weights.wIpk * fIpk(ipk) +
      weights.wPresensi * fPresensi(persenHadir) +
      weights.wTren * fTrenIps(deltaIps) +
      weights.wSks * fSksTertinggal(sksTertinggal);
  return skor.clamp(0.0, 100.0);
}

RiskLevel levelRisiko(double skor) {
  if (skor < 30) return RiskLevel.aman;
  if (skor <= 60) return RiskLevel.waspada;
  return RiskLevel.kritis;
}

/// Butuh perhatian dosen wali? (Waspada/Kritis + belum ditangani di UI).
bool perluPerhatian(double skor) => skor >= 30;
