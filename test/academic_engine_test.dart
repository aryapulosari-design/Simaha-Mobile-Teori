// Unit tests for pure-Dart academic engine (FR-15/16/36/37/39).
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/domain/academic/grades.dart';
import 'package:simaha/domain/academic/validations.dart';

void main() {
  test('hitungNilaiAkhir default weights 30/30/40', () {
    expect(hitungNilaiAkhir(80, 70, 90), closeTo(81.0, 1e-9));
  });

  test('hitungNilaiAkhir rejects bad weights and range', () {
    expect(
      () => hitungNilaiAkhir(80, 70, 90, wTugas: 0.5, wUts: 0.5, wUas: 0.5),
      throwsArgumentError,
    );
    expect(() => hitungNilaiAkhir(-1, 70, 90), throwsArgumentError);
    expect(() => hitungNilaiAkhir(80, 101, 90), throwsArgumentError);
  });

  test('konversiHuruf follows grade bands', () {
    expect(konversiHuruf(90).huruf, 'A');
    expect(konversiHuruf(82).huruf, 'AB');
    expect(konversiHuruf(76).huruf, 'B');
    expect(konversiHuruf(71).huruf, 'BC');
    expect(konversiHuruf(65).huruf, 'C');
    expect(konversiHuruf(55).huruf, 'D');
    expect(konversiHuruf(30).huruf, 'E');
  });

  test('batasSks follows IPS thresholds', () {
    expect(batasSks(3.5), 24);
    expect(batasSks(2.75), 21);
    expect(batasSks(2.2), 18);
    expect(batasSks(1.0), 15);
    expect(batasSks(0.0, semesterPertama: true), 20);
  });

  test('hitungIpk uses best grade for repeats', () {
    const courses = [
      GradedCourse(
        mkKode: 'IF101',
        sks: 3,
        nilaiAkhir: 55,
        huruf: 'D',
        bobot: 1.0,
      ),
      GradedCourse(
        mkKode: 'IF101',
        sks: 3,
        nilaiAkhir: 88,
        huruf: 'A',
        bobot: 4.0,
      ),
      GradedCourse(
        mkKode: 'IF102',
        sks: 3,
        nilaiAkhir: 76,
        huruf: 'B',
        bobot: 3.0,
      ),
    ];
    // (4*3 + 3*3) / 6 = 3.5
    expect(hitungIpk(courses), closeTo(3.5, 1e-9));
    expect(sksLulus(courses), 6);
  });

  test('simulasiIpk detects unreachable target', () {
    final r = simulasiIpk(2.0, 100, 20, 4.0);
    expect(r.tercapai, isFalse);
    expect(r.ipsDibutuhkan, greaterThan(4.0));
    expect(r.ipkMaksimum, lessThanOrEqualTo(4.0));
    final ok = simulasiIpk(3.0, 100, 24, 3.1);
    expect(ok.tercapai, isTrue);
  });

  test('progresKelulusan and estimasiSisaSemester', () {
    expect(progresKelulusan(72), closeTo(50.0, 1e-9));
    expect(progresKelulusan(200), 100.0);
    expect(
      estimasiSisaSemester(100, rataSksPerSemester: 22),
      ((144 - 100) / 22).ceil(),
    );
    expect(estimasiSisaSemester(144, rataSksPerSemester: 20), 0);
  });

  test('validators accept valid and reject invalid input', () {
    expect(validateNim('2024010001'), isNull);
    expect(validateNim(''), isNotNull);
    expect(validateEmail('a@b.ac.id'), isNull);
    expect(validateEmail('bukan-email'), isNotNull);
    expect(validatePhone('08123456789'), isNull);
    expect(validatePhone('abc'), isNotNull);
  });

  test('jadwalUjianBentrok detects overlap only same date', () {
    expect(
      jadwalUjianBentrok(
        tanggalA: '2025-01-10',
        jamMulaiA: '08:00',
        jamSelesaiA: '10:00',
        tanggalB: '2025-01-10',
        jamMulaiB: '09:00',
        jamSelesaiB: '11:00',
      ),
      isTrue,
    );
    expect(
      jadwalUjianBentrok(
        tanggalA: '2025-01-10',
        jamMulaiA: '08:00',
        jamSelesaiA: '10:00',
        tanggalB: '2025-01-10',
        jamMulaiB: '10:00',
        jamSelesaiB: '12:00',
      ),
      isFalse, // back-to-back is not overlap
    );
    expect(
      jadwalUjianBentrok(
        tanggalA: '2025-01-10',
        jamMulaiA: '08:00',
        jamSelesaiA: '10:00',
        tanggalB: '2025-01-11',
        jamMulaiB: '09:00',
        jamSelesaiB: '11:00',
      ),
      isFalse,
    );
  });
}
