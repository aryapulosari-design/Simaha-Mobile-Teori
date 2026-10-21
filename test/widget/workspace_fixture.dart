import 'package:simaha/data/local/seed/demo_seed.dart';
import 'package:simaha/data/services/insights_service.dart';
import 'package:simaha/domain/academic/academic_overview.dart';
import 'package:simaha/domain/academic/grades.dart';
import 'package:simaha/domain/academic/student_insight.dart';
import 'package:simaha/domain/security/roles.dart';

WorkspaceOverview workspaceFixture(Role role) {
  final classes = [
    for (var i = 0; i < (role == Role.dosenPengampu ? 1 : 5); i++)
      AcademicClassInfo(
        id: i + 1,
        code: demoLecturers[i].code,
        name: demoLecturers[i].course,
        credits: 3,
        lecturer: demoLecturers[i].name,
        day: demoLecturers[i].day,
        start: '08:00',
        end: '10:30',
        room: 'IF-${i + 1}01',
        term: '2026/2027 / Gasal',
        studentCount: role == Role.mahasiswa
            ? 1
            : role == Role.dosenWali
            ? 10
            : 50,
        average: 79.2,
      ),
  ];
  final students = <StudentInsight>[];
  if (role != Role.dosenPengampu) {
    for (var i = 0; i < demoStudents.length; i++) {
      if (role == Role.mahasiswa && i != 0) continue;
      if (role == Role.dosenWali && i % 10 >= 2) continue;
      students.add(
        StudyCalculation.calculate(
          id: i + 1,
          name: demoStudents[i].name,
          nim: '2026IF${(i + 1).toString().padLeft(3, '0')}',
          registeredCredits: 15,
          present: i == 7 ? 10 : 15,
          meetings: 15,
          courses: [
            for (final c in classes)
              GradedCourse(
                mkKode: c.code,
                sks: 3,
                nilaiAkhir: 89.8,
                huruf: 'A',
                bobot: 4,
                semesterKey: c.term,
              ),
          ],
        ),
      );
    }
  }
  final registrations = role == Role.dosenPengampu ? 50 : students.length * 5;
  return WorkspaceOverview(
    classes: classes,
    students: students,
    present: registrations * 3 - (role == Role.mahasiswa ? 0 : 10),
    meetings: registrations * 3,
    graded: registrations,
    registrations: registrations,
    requiredCredits: 144,
  );
}
