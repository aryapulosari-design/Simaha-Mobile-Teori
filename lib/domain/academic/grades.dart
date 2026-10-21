// Pure-Dart academic engine (Tahap D). No Flutter imports.
// Assumptions (documented per rule #2):
// - Default weights: tugas 30%, uts 30%, uas 40% (total must be 100%).
// - Grade bands follow kGradeBands constants (A>=85 ... E<50).
// - Repeated courses: best grade wins for IPK.
// - A course counts as passed when letter != 'E'.

/// One graded course enrolment (join of KRS + Nilai + SKS).
class GradedCourse {
  const GradedCourse({
    required this.mkKode,
    required this.sks,
    required this.nilaiAkhir,
    required this.huruf,
    required this.bobot,
    this.semesterKey = '',
  });

  final String mkKode;
  final int sks;
  final double nilaiAkhir;
  final String huruf;
  final double bobot;

  /// Semester bucket, e.g. '2024/2025-1'. Empty means "unknown semester".
  final String semesterKey;

  bool get lulus => huruf != 'E';
}

/// nilai_akhir = tugas*w1 + uts*w2 + uas*w3. Weights must sum to 1.0.
double hitungNilaiAkhir(
  double tugas,
  double uts,
  double uas, {
  double wTugas = 0.3,
  double wUts = 0.3,
  double wUas = 0.4,
}) {
  final total = wTugas + wUts + wUas;
  if ((total - 1.0).abs() > 1e-9) {
    throw ArgumentError('Total bobot harus 100% (dapat $total).');
  }
  for (final v in [tugas, uts, uas]) {
    if (!v.isFinite || v < 0 || v > 100) {
      throw ArgumentError('Nilai harus 0-100 (dapat $v).');
    }
  }
  return tugas * wTugas + uts * wUts + uas * wUas;
}

/// IPS/IPK grade bands: (minScore, letter, weight), sorted desc.
const List<(double minScore, String letter, double weight)> gradeBands = [
  (85, 'A', 4.0),
  (80, 'AB', 3.5),
  (75, 'B', 3.0),
  (70, 'BC', 2.5),
  (60, 'C', 2.0),
  (50, 'D', 1.0),
  (0, 'E', 0.0),
];

/// Converts numeric score to (letter, weight).
({String huruf, double bobot}) konversiHuruf(double akhir) {
  for (final band in gradeBands) {
    if (akhir >= band.$1) return (huruf: band.$2, bobot: band.$3);
  }
  return (huruf: 'E', bobot: 0.0);
}

/// SKS cap from previous IPS (spec section 5, exact).
int batasSks(double ips, {bool semesterPertama = false}) {
  if (semesterPertama) return 20;
  if (ips >= 3.00) return 24;
  if (ips >= 2.50) return 21;
  if (ips >= 2.00) return 18;
  return 15;
}

/// Weighted GPA over [courses]. Repeated MK: best bobot wins.
/// Returns 0.0 when there are no courses with sks > 0.
double hitungIpk(Iterable<GradedCourse> courses) {
  final best = <String, GradedCourse>{};
  for (final c in courses) {
    final prev = best[c.mkKode];
    if (prev == null || c.bobot > prev.bobot) best[c.mkKode] = c;
  }
  double totalBobotSks = 0;
  var totalSks = 0;
  for (final c in best.values) {
    totalBobotSks += c.bobot * c.sks;
    totalSks += c.sks;
  }
  if (totalSks == 0) return 0.0;
  return totalBobotSks / totalSks;
}

/// IPS of a single semester bucket.
double hitungIps(Iterable<GradedCourse> courses, String semesterKey) =>
    hitungIpk(courses.where((c) => c.semesterKey == semesterKey));

/// Passed SKS (best attempt per MK, only passed ones).
int sksLulus(Iterable<GradedCourse> courses) {
  final best = <String, GradedCourse>{};
  for (final c in courses) {
    final prev = best[c.mkKode];
    if (prev == null || c.bobot > prev.bobot) best[c.mkKode] = c;
  }
  var sum = 0;
  for (final c in best.values) {
    if (c.lulus) sum += c.sks;
  }
  return sum;
}

/// Graduation progress 0-100%.
double progresKelulusan(int sksLulusCount, {int syaratSks = 144}) {
  if (syaratSks <= 0) throw ArgumentError('syaratSks harus > 0.');
  final p = sksLulusCount / syaratSks * 100;
  return p.clamp(0.0, 100.0);
}

/// Estimated remaining semesters (ceil). Returns 0 when already done.
int estimasiSisaSemester(
  int sksLulusCount, {
  int syaratSks = 144,
  required double rataSksPerSemester,
}) {
  final sisa = syaratSks - sksLulusCount;
  if (sisa <= 0) return 0;
  if (rataSksPerSemester <= 0) {
    throw ArgumentError('rataSksPerSemester harus > 0.');
  }
  return (sisa / rataSksPerSemester).ceil();
}

/// Required IPS on planned SKS to reach [ipkTarget].
/// Returns (tercapai, ipsDibutuhkan, ipkMaksimum).
/// ipsDibutuhkan > 4.00 means unreachable; ipkMaksimum shows the best
/// possible IPK if all planned courses score A (4.0).
({bool tercapai, double ipsDibutuhkan, double ipkMaksimum}) simulasiIpk(
  double ipkSekarang,
  int sksLulusCount,
  int sksRencana,
  double ipkTarget,
) {
  if (sksRencana <= 0) throw ArgumentError('sksRencana harus > 0.');
  final total = sksLulusCount + sksRencana;
  final dibutuhkan =
      (ipkTarget * total - ipkSekarang * sksLulusCount) / sksRencana;
  final ipkMaks = (ipkSekarang * sksLulusCount + 4.0 * sksRencana) / total;
  return (
    tercapai: dibutuhkan <= 4.0,
    ipsDibutuhkan: dibutuhkan,
    ipkMaksimum: ipkMaks,
  );
}
