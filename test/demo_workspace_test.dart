import 'package:drift/native.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/core/config/app_runtime.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/seed/demo_seed.dart';
import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/domain/security/string_store.dart';

void main() {
  late AppDatabase db;
  late AuthService auth;
  final users = <String, int>{};
  late int alya, dewi;
  setUpAll(() async {
    db = AppDatabase(NativeDatabase.memory());
    await ensureDemoSeeded(db, referenceDate: DateTime(2026, 10, 20, 9));
    auth = AuthService(db: db, crypto: CryptoService(), store: MemoryStore());
    for (final user in await db.select(db.users).get()) {
      users[user.username] = user.id;
    }
    alya = (await db.pagedMahasiswa())
        .firstWhere((m) => m.nama == 'Alya Putri')
        .id;
    dewi = (await db.pagedMahasiswa())
        .firstWhere((m) => m.nama == 'Dewi Anggraini')
        .id;
  });
  tearDownAll(() async => db.close());
  AcademicService asUser(String username) =>
      AcademicService(db, users[username]);

  test('compact demo has complete links and exact initial counts', () async {
    Future<int> count(String table) async =>
        (await db.customSelect('SELECT COUNT(*) AS n FROM $table').getSingle())
            .read<int>('n');
    expect(await count('users'), 22);
    expect(await count('dosens'), 5);
    expect(await count('mahasiswa'), 10);
    expect(await count('mata_kuliah'), 5);
    expect(await count('kelas'), 5);
    expect(await count('krs'), 50);
    expect(await count('nilai'), 50);
    expect(await count('sesi_presensi'), 15);
    expect(await count('presensi'), 150);
    expect(await count('catatan_bimbingan'), 10);
    expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
    expect(
      (await db.listDosen()).every(
        (d) => d.userId != null && d.waliUserId != null,
      ),
      isTrue,
    );
    expect(
      (await db.pagedMahasiswa()).every(
        (m) => m.userId != null && m.dosenWaliId != null,
      ),
      isTrue,
    );
  });

  test('all 22 demo accounts can log in with the documented PIN and their real role', () async {
    final picker = await auth.listLoginAccounts();
    expect(picker.length, 22);
    for (final account in demoAccounts) {
      final result = await auth.verifyPin(account.username, AppRuntime.demoPin);
      expect(result.isOk, isTrue, reason: account.username);
      expect(result.valueOrNull!.role, account.role.storageKey);
    }
    expect((await auth.verifyPin('superadmin', '000000')).isErr, isTrue);
  }, timeout: const Timeout(Duration(minutes: 2)));

  test(
    'five lecturers each teach all students but own exactly one distinct class',
    () async {
      final classes = <int>{};
      for (final teacher in demoLecturers) {
        final service = asUser('pengampu.${teacher.slug}');
        expect((await service.students()).length, 10);
        final own = (await service.classes()).single;
        expect(own.studentCount, 10);
        classes.add(own.id);
        final detail = await service.classDetail(own.id);
        expect(detail.students.length, 10);
        expect(
          detail.students.every((s) => s.score != null && s.meetings == 3),
          isTrue,
        );
        expect((await service.grades(alya)).length, 1);
      }
      expect(classes.length, 5);
    },
  );

  test('same five lecturer profiles advise two students each using separate wali accounts', () async {
    final covered = <int>{};
    for (final lecturer in demoLecturers) {
      final service = asUser('wali.${lecturer.slug}');
      final students = await service.students();
      expect(students.length, 2);
      expect(students.any((s) => covered.contains(s.id)), isFalse);
      covered.addAll(students.map((s) => s.id));
      final classes = await service.classes();
      expect(classes.length, 5);
      expect(classes.every((c) => c.studentCount == 2), isTrue);
      expect((await service.classDetail(classes.first.id)).students.length, 2);
      expect(await service.advisingNotes(students.first.id), isNotEmpty);
    }
    expect(covered.length, 10);
  });

  test('each student has five courses, only their own attendance, and readable advising', () async {
    for (final student in demoStudents) {
      final service = asUser('mhs.${student.slug}');
      final profile = (await service.students()).single;
      final classes = await service.classes();
      expect(classes.length, 5);
      expect(classes.every((c) => c.studentCount == 1), isTrue);
      for (final course in classes) {
        final detail = await service.classDetail(course.id);
        expect(detail.students.single.id, profile.id);
        expect(detail.students.single.meetings, 3);
      }
      expect((await service.grades(profile.id)).length, 5);
      expect(await service.advisingNotes(profile.id), isNotEmpty);
    }
    final rahmaClass = (await asUser('pengampu.rahma').classes()).single;
    final attendance = await asUser('mhs.dewi').classDetail(rahmaClass.id);
    expect(attendance.students.single.present, 2);
    expect(attendance.students.single.absent, 1);
  });

  test(
    'a grade update is shared by teacher, student, wali, and academic admin',
    () async {
      final teacher = asUser('pengampu.rahma');
      final grade = (await teacher.grades(alya)).single;
      try {
        await teacher.saveNilai(
          krsId: grade.krsId,
          tugas: 95,
          uts: 94,
          uas: 93,
        );
        for (final username in [
          'mhs.alya',
          'wali.rahma',
          'akademik',
          'superadmin',
        ]) {
          final view = (await asUser(username).grades(alya))
              .firstWhere((g) => g.krsId == grade.krsId);
          expect(view.akhir, closeTo(93.9, 0.0001), reason: username);
        }
        await expectLater(
          asUser('pengampu.budi')
              .saveNilai(krsId: grade.krsId, tugas: 100, uts: 100, uas: 100),
          throwsA(isA<ForbiddenFailure>()),
        );
        await expectLater(
          asUser('pengampu.budi').classDetail(grade.kelasId),
          throwsA(isA<ForbiddenFailure>()),
        );
      } finally {
        await teacher.saveNilai(
          krsId: grade.krsId,
          tugas: grade.tugas,
          uts: grade.uts,
          uas: grade.uas,
        );
      }
    },
  );

  test(
    'wali notes reach the right student and are denied to unrelated accounts',
    () async {
      const content =
          'Alya sudah meningkatkan latihan Algoritma pada pertemuan bimbingan.';
      await asUser('wali.rahma').addAdvisingNote(
        studentId: alya,
        content: content,
        followUp: 'Lanjutkan latihan mandiri pekan depan.',
      );
      expect(
        (await asUser('mhs.alya').advisingNotes(alya)).first.content,
        content,
      );
      expect(
        (await asUser('superadmin').advisingNotes(alya)).first.lecturer,
        'Rahma Hidayati',
      );
      for (final username in [
        'mhs.arif',
        'wali.budi',
        'pengampu.rahma',
        'akademik',
      ]) {
        await expectLater(
          asUser(username).advisingNotes(alya),
          throwsA(isA<ForbiddenFailure>()),
        );
      }
      await expectLater(
        asUser('wali.budi').addAdvisingNote(studentId: alya, content: content),
        throwsA(isA<ForbiddenFailure>()),
      );
      await expectLater(
        asUser('mhs.alya').addAdvisingNote(studentId: alya, content: content),
        throwsA(isA<ForbiddenFailure>()),
      );
      await expectLater(
        asUser('wali.rahma').addAdvisingNote(studentId: alya, content: 'x'),
        throwsA(isA<ValidationFailure>()),
      );
      expect(
        (await db.select(db.auditLog).get()).any(
          (log) =>
              log.entitas == 'BIMBINGAN' && log.userId == users['wali.rahma'],
        ),
        isTrue,
      );
    },
  );

  test('administrators see all classes and students, and demo seeding preserves edits', () async {
    for (final username in ['superadmin', 'akademik']) {
      expect((await asUser(username).students()).length, 10);
      expect((await asUser(username).classes()).length, 5);
    }
    final grade = (await asUser('pengampu.rahma').grades(alya)).single;
    try {
      await asUser('pengampu.rahma')
          .saveNilai(krsId: grade.krsId, tugas: 70, uts: 70, uas: 70);
      final noteCount = (await db.select(db.catatanBimbingan).get()).length;
      await ensureDemoSeeded(db);
      expect(
        (await asUser('mhs.alya').grades(alya))
            .firstWhere((g) => g.krsId == grade.krsId)
            .akhir,
        70,
      );
      expect((await db.select(db.users).get()).length, 22);
      expect((await db.select(db.catatanBimbingan).get()).length, noteCount);
    } finally {
      await asUser('pengampu.rahma').saveNilai(
        krsId: grade.krsId,
        tugas: grade.tugas,
        uts: grade.uts,
        uas: grade.uas,
      );
    }
    await expectLater(
      asUser('wali.rahma').student(dewi),
      throwsA(isA<ForbiddenFailure>()),
    );
  });
  test(
    'demo recovery cannot consume the normal workspace recovery code',
    () async {
      final previousWarning =
          driftRuntimeOptions.dontWarnAboutMultipleDatabases;
      // These are deliberately separate memory executors for isolation testing.
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      final normalDb = AppDatabase(NativeDatabase.memory());
      final platformStore = MemoryStore();
      final normal = AuthService(
        db: normalDb,
        crypto: CryptoService(iterations: 10),
        store: platformStore,
      );
      try {
        final recovery = await normal.setupSuperAdmin(pin: '654321');
        final demo = AuthService(
          db: db,
          crypto: CryptoService(iterations: 10),
          store: NamespacedStringStore(platformStore, 'simaha_demo:'),
        );
        expect((await demo.consumeRecoveryCode(recovery)).isErr, isTrue);
        expect((await normal.consumeRecoveryCode(recovery)).isOk, isTrue);
      } finally {
        await normalDb.close();
        driftRuntimeOptions.dontWarnAboutMultipleDatabases = previousWarning;
      }
    },
  );
}
