import 'package:simaha/domain/academic/grades.dart';
import 'package:simaha/domain/analytics/risk_score.dart';

class StudentInsight {
  const StudentInsight({
    required this.id,
    required this.name,
    required this.nim,
    required this.gpa,
    required this.passedCredits,
    required this.registeredCredits,
    required this.present,
    required this.meetings,
    required this.risk,
    required this.semesters,
    required this.hasGrades,
  });
  final int id, passedCredits, registeredCredits, present, meetings;
  final String name, nim;
  final double gpa, risk;
  final bool hasGrades;
  final Map<String, double> semesters;
  double? get attendance => meetings == 0 ? null : present / meetings * 100;
  RiskLevel get level => levelRisiko(risk);
}

class StudyCalculation {
  static StudentInsight calculate({
    required int id,
    required String name,
    required String nim,
    required List<GradedCourse> courses,
    required int registeredCredits,
    required int present,
    required int meetings,
  }) {
    final keys =
        courses
            .map((c) => c.semesterKey)
            .where((k) => k.isNotEmpty)
            .toSet()
            .toList()
          ..sort();
    final semesters = {for (final key in keys) key: hitungIps(courses, key)};
    final gpa = hitungIpk(courses);
    final delta = keys.length < 2
        ? 0.0
        : semesters[keys.last]! - semesters[keys[keys.length - 2]]!;
    // Unknown attendance contributes no attendance risk; the UI labels it empty.
    final risk = courses.isEmpty
        ? 0.0
        : hitungSkorRisiko(
            ipk: gpa,
            persenHadir: meetings == 0 ? 100 : present / meetings * 100,
            deltaIps: delta,
            sksTertinggal: 0,
          );
    return StudentInsight(
      id: id,
      name: name,
      nim: nim,
      gpa: gpa,
      passedCredits: sksLulus(courses),
      registeredCredits: registeredCredits,
      present: present,
      meetings: meetings,
      risk: risk,
      semesters: semesters,
      hasGrades: courses.isNotEmpty,
    );
  }
}
