// Pure-Dart checks for PRD section 5 defaults (no DB, no Flutter).
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/core/utils/result.dart';

void main() {
  test('grade bands cover 0-100 with exact PRD weights', () {
    double weightFor(String letter) =>
        kGradeBands.firstWhere((b) => b.letter == letter).weight;

    expect(weightFor('A'), 4.0);
    expect(weightFor('AB'), 3.5);
    expect(weightFor('B'), 3.0);
    expect(weightFor('BC'), 2.5);
    expect(weightFor('C'), 2.0);
    expect(weightFor('D'), 1.0);
    expect(weightFor('E'), 0.0);

    // Bands sorted desc, last covers 0.
    expect(kGradeBands.first.minScore, 85);
    expect(kGradeBands.last.minScore, 0);

    double letterToMin(String letter) =>
        kGradeBands.firstWhere((b) => b.letter == letter).minScore;
    expect(letterToMin('A'), 85);
    expect(letterToMin('AB'), 80);
    expect(letterToMin('B'), 75);
    expect(letterToMin('BC'), 70);
    expect(letterToMin('C'), 60);
    expect(letterToMin('D'), 50);
  });

  test('SKS caps follow PRD IPS thresholds', () {
    int capFor(double ips, {bool firstSemester = false}) {
      if (firstSemester) return kDefaultFirstSemesterSksCap;
      if (ips >= kSksCapIpsA) return 24;
      if (ips >= kSksCapIpsB) return 21;
      if (ips >= kSksCapIpsC) return 18;
      return 15;
    }

    expect(capFor(3.5), 24);
    expect(capFor(3.0), 24);
    expect(capFor(2.75), 21);
    expect(capFor(2.5), 21);
    expect(capFor(2.2), 18);
    expect(capFor(2.0), 18);
    expect(capFor(1.5), 15);
    expect(capFor(0.0, firstSemester: true), 20);
  });

  test('Result sealed type pattern matching works', () {
    const Result<int, AppFailure> ok = Ok<int, AppFailure>(7);
    const Result<int, AppFailure> err = Err<int, AppFailure>(
      ValidationFailure('bad'),
    );

    expect(ok.isOk, isTrue);
    expect(err.isErr, isTrue);
    expect(ok.valueOrNull, 7);
    expect(err.failureOrNull, isA<ValidationFailure>());

    final msg = switch (err) {
      Ok(value: final v) => 'ok $v',
      Err(failure: final f) => 'err ${f.message}',
    };
    expect(msg, 'err bad');
  });
}
