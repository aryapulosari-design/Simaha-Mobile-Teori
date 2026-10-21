import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/data/services/master_data_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/domain/security/string_store.dart';

void main() {
  late AppDatabase db;
  late MasterDataService master;
  late AcademicService academic;
  late AuthService auth;
  late int admin;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    auth = AuthService(
      db: db,
      crypto: CryptoService(iterations: 10),
      store: MemoryStore(),
    );
    await auth.setupSuperAdmin(pin: '123456');
    admin = (await auth.findByUsername('superadmin'))!.id;
    academic = AcademicService(db, admin);
    master = MasterDataService(academic);
  });
  tearDown(() => db.close());

  test(
    'master -> class -> KRS stays connected and preserves used data',
    () async {
      final program = await master.saveProgram(code: 'TI', name: 'Informatika');
      final lecturer = await master.saveLecturer(
        nidn: '123456',
        name: 'Dosen Rahma',
        programId: program,
      );
      final term = await master.saveTerm(
        year: '2026/2027',
        semester: 1,
        active: true,
      );
      final course = await master.saveCourse(
        code: 'TI01',
        name: 'Algoritma',
        credits: 3,
        semester: 1,
        programId: program,
      );
      final classroom = await master.saveClass(
        courseId: course,
        lecturerId: lecturer,
        termId: term,
        day: 'Senin',
        start: '08:00',
        end: '10:00',
        room: 'A101',
      );
      final student = await academic.createMahasiswa(
        nim: '20260001',
        nama: 'Alya Putri',
        prodiId: program,
        angkatan: 2026,
      );
      final registration = await academic.addKrsNilai(
        mahasiswaId: student,
        kelasId: classroom,
        tugas: 80,
        uts: 85,
        uas: 90,
      );
      final row = await (db.select(db.krs)).getSingle();
      expect(row.id, registration);
      expect(row.taId, term);
      await expectLater(
        academic.addKrsNilai(
          mahasiswaId: student,
          kelasId: classroom,
          tugas: 80,
          uts: 85,
          uas: 90,
        ),
        throwsA(isA<ValidationFailure>()),
      );
      await expectLater(
        master.delete(MasterKind.classroom, classroom),
        throwsA(isA<ValidationFailure>()),
      );
      await expectLater(
        master.saveLecturer(
          id: lecturer,
          nidn: '123456',
          name: 'Dosen Rahma',
          programId: await master.saveProgram(
            code: 'SI',
            name: 'Sistem Informasi',
          ),
        ),
        throwsA(isA<ValidationFailure>()),
      );
      await master.saveClass(
        id: classroom,
        courseId: course,
        lecturerId: lecturer,
        termId: term,
        day: 'Senin',
        start: '08:00',
        end: '10:00',
        room: 'A102',
      );
      expect((await master.snapshot()).classes.single.ruang, 'A102');
      expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
      expect((await db.select(db.auditLog).get()).isNotEmpty, isTrue);
    },
  );

  test('master access denied for all three non-admin roles', () async {
    for (final role in [Role.dosenPengampu, Role.dosenWali, Role.mahasiswa]) {
      final user = await auth.createUser(
        actorId: admin,
        username: 'user${role.name}',
        role: role,
        pin: '123456',
      );
      final restricted = MasterDataService(AcademicService(db, user));
      await expectLater(
        restricted.snapshot(),
        throwsA(isA<ForbiddenFailure>()),
      );
      await expectLater(
        restricted.saveProgram(code: 'XX', name: 'Tidak boleh'),
        throwsA(isA<ForbiddenFailure>()),
      );
    }
  });

  test('staff can manage master; conflicting schedule and prerequisite cycles rejected', () async {
    final user = await auth.createUser(
      actorId: admin,
      username: 'akademik',
      role: Role.adminAkademik,
      pin: '123456',
    );
    master = MasterDataService(AcademicService(db, user));
    final p = await master.saveProgram(code: 'TI', name: 'Informatika');
    final d = await master.saveLecturer(
      nidn: '123456',
      name: 'Dosen Rahma',
      programId: p,
    );
    final t = await master.saveTerm(
      year: '2026/2027',
      semester: 1,
      active: true,
    );
    final a = await master.saveCourse(
      code: 'TI01',
      name: 'Algoritma',
      credits: 3,
      semester: 1,
      programId: p,
    );
    final b = await master.saveCourse(
      code: 'TI02',
      name: 'Struktur Data',
      credits: 3,
      semester: 2,
      programId: p,
      prerequisites: {a},
    );
    await expectLater(
      master.saveCourse(
        id: a,
        code: 'TI01',
        name: 'Algoritma',
        credits: 3,
        semester: 1,
        programId: p,
        prerequisites: {b},
      ),
      throwsA(isA<ValidationFailure>()),
    );
    await master.saveClass(
      courseId: a,
      lecturerId: d,
      termId: t,
      day: 'Senin',
      start: '08:00',
      end: '10:00',
      room: 'A101',
    );
    await expectLater(
      master.saveClass(
        courseId: b,
        lecturerId: d,
        termId: t,
        day: 'Senin',
        start: '09:00',
        end: '11:00',
        room: 'A102',
      ),
      throwsA(isA<ValidationFailure>()),
    );
    final unused = await master.saveProgram(
      code: 'SI',
      name: 'Sistem Informasi',
    );
    await master.delete(MasterKind.program, unused);
    expect((await master.snapshot()).programs.length, 1);
  });
}
