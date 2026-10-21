import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/data/services/demo_store.dart';
import 'package:simaha/domain/academic/grades.dart';
import 'package:simaha/domain/academic/student_insight.dart';
import 'package:simaha/domain/academic/validations.dart';
import 'package:simaha/domain/analytics/risk_score.dart';

void main() {
  test(
    'demo preferences persist independently and serialize concurrent writes',
    () async {
      final dir = await Directory.systemTemp.createTemp('simaha_demo_store_');
      try {
        final normal = File('${dir.path}/normal.json');
        await normal.writeAsString('{"production":"unchanged"}');
        final store = DemoStore(File('${dir.path}/demo.json'));
        await Future.wait([
          store.write('last', 'alya'),
          store.write('demo_key', 'public-demo-value'),
        ]);
        final reopened = DemoStore(File('${dir.path}/demo.json'));
        expect(await reopened.read('last'), 'alya');
        expect(await reopened.read('demo_key'), 'public-demo-value');
        await reopened.delete('last');
        expect(await reopened.read('last'), isNull);
        expect(await normal.readAsString(), '{"production":"unchanged"}');
      } finally {
        await dir.delete(recursive: true);
      }
    },
  );
  test(
    'corrupt demo preferences fail without overwriting stored data',
    () async {
      final dir = await Directory.systemTemp.createTemp('simaha_demo_corrupt_');
      try {
        final file = File('${dir.path}/demo.json');
        await file.writeAsString('broken');
        await expectLater(
          DemoStore(file).write('key', 'value'),
          throwsFormatException,
        );
        expect(await file.readAsString(), 'broken');
      } finally {
        await dir.delete(recursive: true);
      }
    },
  );
  test('missing study data is explicit and does not create risk warnings', () {
    final result = StudyCalculation.calculate(
      id: 1,
      name: 'Alya',
      nim: '0001',
      courses: [],
      registeredCredits: 15,
      present: 0,
      meetings: 0,
    );
    expect(result.hasGrades, isFalse);
    expect(result.attendance, isNull);
    expect(result.risk, 0);
  });
  test('semester history, repeated-course GPA and passed credits use academic rules', () {
    final result = StudyCalculation.calculate(
      id: 1,
      name: 'Alya',
      nim: '0001',
      courses: [
        const GradedCourse(
          mkKode: 'IF1',
          sks: 3,
          nilaiAkhir: 90,
          huruf: 'A',
          bobot: 4,
          semesterKey: '2025 / Gasal',
        ),
        const GradedCourse(
          mkKode: 'IF1',
          sks: 3,
          nilaiAkhir: 40,
          huruf: 'E',
          bobot: 0,
          semesterKey: '2026 / Gasal',
        ),
      ],
      registeredCredits: 3,
      present: 2,
      meetings: 4,
    );
    expect(result.gpa, 4);
    expect(result.passedCredits, 3);
    expect(result.semesters.values.toList(), [4, 0]);
    expect(result.attendance, 50);
  });
  test('risk normalization matches approved formulas', () {
    expect(fIpk(2.25), 50);
    expect(fPresensi(70), 50);
    expect(fTrenIps(-0.5), 50);
    expect(fSksTertinggal(10), 50);
  });
  test('non-finite numeric input rejected by validator and grade engine', () {
    expect(validateNilaiAngka('NaN'), isNotNull);
    expect(validateNilaiAngka('Infinity'), isNotNull);
    expect(() => hitungNilaiAkhir(double.nan, 90, 90), throwsArgumentError);
  });
}
