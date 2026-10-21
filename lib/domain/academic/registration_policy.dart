import 'package:simaha/domain/academic/grades.dart';
import 'package:simaha/domain/academic/validations.dart';

const registeredStatuses = {'draft', 'diambil', 'disetujui'};
const weekDays = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

String termLabel(String year, int semester) =>
    '$year / ${switch (semester) {
      1 => 'Gasal',
      2 => 'Genap',
      _ => 'Pendek',
    }}';

int termOrder(String year, int semester) =>
    int.parse(year.split('/').first) * 3 + semester;

String? validateSchedule(String day, String start, String end) {
  final clock = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$');
  if (!weekDays.contains(day)) return 'Pilih hari yang valid.';
  if (!clock.hasMatch(start) || !clock.hasMatch(end)) {
    return 'Waktu harus HH:MM, misalnya 08:00.';
  }
  if (start.compareTo(end) >= 0) return 'Jam selesai harus setelah jam mulai.';
  return null;
}

class RegistrationCourse {
  const RegistrationCourse({
    required this.courseId,
    required this.credits,
    required this.term,
    required this.day,
    required this.start,
    required this.end,
    this.weight,
  });
  final int courseId, credits, term;
  final String day, start, end;
  final double? weight;
}

class RegistrationBudget {
  const RegistrationBudget(this.used, this.limit, this.previousGpa);
  final int used, limit;
  final double? previousGpa;
}

/// Limits use only the immediately preceding enrolled term. Ungraded prior
/// enrolments cannot silently turn into a first-semester allowance.
RegistrationBudget registrationBudget(
  int targetTerm,
  List<RegistrationCourse> history,
) {
  final previous = history.where((c) => c.term < targetTerm).toList();
  double? ips;
  if (previous.isNotEmpty) {
    final last = previous.map((c) => c.term).reduce((a, b) => a > b ? a : b);
    final courses = previous.where((c) => c.term == last).toList();
    if (courses.any((c) => c.weight == null)) {
      throw ArgumentError('Nilai semester sebelumnya belum lengkap.');
    }
    final credits = courses.fold(0, (sum, c) => sum + c.credits);
    ips = credits == 0
        ? 0
        : courses.fold(0.0, (sum, c) => sum + c.weight! * c.credits) / credits;
  }
  return RegistrationBudget(
    history
        .where((c) => c.term == targetTerm)
        .fold(0, (sum, c) => sum + c.credits),
    batasSks(ips ?? 0, semesterPertama: ips == null),
    ips,
  );
}

String? registrationError({
  required RegistrationCourse candidate,
  required List<RegistrationCourse> history,
  required Set<int> prerequisites,
}) {
  final current = history.where((c) => c.term == candidate.term);
  if (current.any((c) => c.courseId == candidate.courseId)) {
    return 'Mata kuliah sudah diambil pada semester ini.';
  }
  for (final id in prerequisites) {
    if (!history.any(
      (c) => c.courseId == id && c.term < candidate.term && (c.weight ?? 0) > 0,
    )) {
      return 'Prasyarat mata kuliah belum lulus pada semester sebelumnya.';
    }
  }
  if (current.any(
    (c) => jadwalKelasBentrok(
      hariA: candidate.day,
      jamMulaiA: candidate.start,
      jamSelesaiA: candidate.end,
      hariB: c.day,
      jamMulaiB: c.start,
      jamSelesaiB: c.end,
    ),
  )) {
    return 'Jadwal kelas bentrok dengan KRS semester ini.';
  }
  try {
    final budget = registrationBudget(candidate.term, history);
    if (budget.used + candidate.credits > budget.limit) {
      return 'Melebihi batas ${budget.limit} SKS semester ini (${budget.used} + ${candidate.credits} SKS).';
    }
  } on ArgumentError catch (e) {
    return e.message.toString();
  }
  return null;
}
