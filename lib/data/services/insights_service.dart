import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/domain/academic/academic_overview.dart';
import 'package:simaha/domain/academic/grades.dart';
import 'package:simaha/domain/academic/student_insight.dart';
import 'package:simaha/domain/security/roles.dart';

class WorkspaceOverview {
  const WorkspaceOverview({
    required this.classes,
    required this.students,
    required this.present,
    required this.meetings,
    required this.graded,
    required this.registrations,
    required this.requiredCredits,
  });
  final List<AcademicClassInfo> classes;
  final List<StudentInsight> students;
  final int present, meetings, graded, registrations, requiredCredits;
  double? get attendance => meetings == 0 ? null : present / meetings * 100;
}

/// Composes already-authorized reads. Teaching accounts never get cumulative GPA.
class InsightsService {
  InsightsService(this.academic);
  final AcademicService academic;

  Future<WorkspaceOverview> overview(Role role) async {
    final classes = await academic.classes();
    final details = <AcademicClassDetail>[];
    for (final item in classes) {
      details.add(await academic.classDetail(item.id));
    }
    var present = 0, meetings = 0, graded = 0, registrations = 0;
    final records = <int, List<(AcademicClassInfo, ClassStudentInfo)>>{};
    for (final detail in details) {
      for (final student in detail.students) {
        present += student.present;
        meetings += student.meetings;
        registrations++;
        if (student.score != null) graded++;
        records.putIfAbsent(student.id, () => []).add((detail.info, student));
      }
    }
    final students = <StudentInsight>[];
    if (role != Role.dosenPengampu) {
      for (final entry in records.entries) {
        final items = entry.value;
        final courses = <GradedCourse>[];
        for (final (info, row) in items) {
          if (row.score == null) continue;
          final grade = konversiHuruf(row.score!);
          courses.add(
            GradedCourse(
              mkKode: info.code,
              sks: info.credits,
              nilaiAkhir: row.score!,
              huruf: grade.huruf,
              bobot: grade.bobot,
              semesterKey: info.term,
            ),
          );
        }
        students.add(
          StudyCalculation.calculate(
            id: entry.key,
            name: items.first.$2.name,
            nim: items.first.$2.nim,
            courses: courses,
            registeredCredits: items.fold(0, (n, item) => n + item.$1.credits),
            present: items.fold(0, (n, item) => n + item.$2.present),
            meetings: items.fold(0, (n, item) => n + item.$2.meetings),
          ),
        );
      }
      students.sort((a, b) => b.risk.compareTo(a.risk));
    }
    return WorkspaceOverview(
      classes: classes,
      students: students,
      present: present,
      meetings: meetings,
      graded: graded,
      registrations: registrations,
      requiredCredits: await academic.db.getSyaratSksLulus(),
    );
  }
}
