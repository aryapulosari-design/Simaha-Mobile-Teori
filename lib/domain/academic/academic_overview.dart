class AcademicClassInfo {
  const AcademicClassInfo({
    required this.id,
    required this.code,
    required this.name,
    required this.credits,
    required this.lecturer,
    required this.day,
    required this.start,
    required this.end,
    required this.room,
    required this.term,
    required this.studentCount,
    this.average,
  });
  final int id;
  final String code, name, lecturer, day, start, end, room, term;
  final int credits, studentCount;
  final double? average;
}

class ClassStudentInfo {
  const ClassStudentInfo({
    required this.id,
    required this.nim,
    required this.name,
    required this.letter,
    required this.score,
    required this.meetings,
    required this.present,
    required this.excused,
    required this.sick,
    required this.absent,
  });
  final int id, meetings, present, excused, sick, absent;
  final String nim, name;
  final String? letter;
  final double? score;
}

class AcademicClassDetail {
  const AcademicClassDetail(this.info, this.students);
  final AcademicClassInfo info;
  final List<ClassStudentInfo> students;
}

class AdvisingNote {
  const AdvisingNote({
    required this.id,
    required this.lecturer,
    required this.content,
    required this.followUp,
    required this.date,
  });
  final int id;
  final String lecturer, content;
  final String? followUp;
  final DateTime date;
}
