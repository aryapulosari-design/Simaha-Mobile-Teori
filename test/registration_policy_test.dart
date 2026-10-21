import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/domain/academic/registration_policy.dart';

void main() {
  RegistrationCourse course(
    int id,
    int term, {
    int credits = 3,
    double? weight,
    String start = '08:00',
    String day = 'Senin',
  }) => RegistrationCourse(
    courseId: id,
    credits: credits,
    term: term,
    day: day,
    start: start,
    end: '10:00',
    weight: weight,
  );

  test('budget uses previous term IPS rather than cumulative GPA', () {
    final history = [
      course(1, 1, weight: 4),
      course(2, 2, weight: 1),
      course(3, 3),
    ];
    final budget = registrationBudget(3, history);
    expect(budget.previousGpa, 1);
    expect(budget.used, 3);
    expect(budget.limit, 15);
    expect(registrationBudget(1, []).limit, 20);
  });

  test(
    'ungraded previous semester does not receive first semester allowance',
    () {
      expect(
        registrationError(
          candidate: course(2, 2),
          history: [course(1, 1)],
          prerequisites: {},
        ),
        contains('belum lengkap'),
      );
    },
  );

  test(
    'prerequisite must be passed in an earlier term and schedule must fit',
    () {
      expect(
        registrationError(
          candidate: course(2, 2),
          history: [course(1, 1, weight: 0)],
          prerequisites: {1},
        ),
        contains('Prasyarat'),
      );
      expect(
        registrationError(
          candidate: course(2, 2),
          history: [course(1, 1, weight: 4)],
          prerequisites: {1},
        ),
        isNull,
      );
      expect(
        registrationError(
          candidate: course(2, 2),
          history: [course(1, 2)],
          prerequisites: {1},
        ),
        contains('Prasyarat'),
      );
      expect(
        registrationError(
          candidate: course(2, 2),
          history: [course(1, 2)],
          prerequisites: {},
        ),
        contains('bentrok'),
      );
      expect(
        registrationError(
          candidate: course(1, 2),
          history: [course(1, 2)],
          prerequisites: {},
        ),
        contains('sudah diambil'),
      );
    },
  );

  test('first semester limit and schedule format are enforced', () {
    final history = [
      for (var i = 0; i < 3; i++) course(i, 1, credits: 6, day: 'Selasa'),
    ];
    expect(
      registrationError(
        candidate: course(9, 1),
        history: history,
        prerequisites: {},
      ),
      contains('20 SKS'),
    );
    expect(validateSchedule('Senin', '25:00', '26:00'), isNotNull);
    expect(validateSchedule('Senin', '10:00', '08:00'), isNotNull);
    expect(validateSchedule('Senin', '08:00', '10:00'), isNull);
  });
}
