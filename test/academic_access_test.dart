import 'package:drift/native.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/seed/seed_data.dart';
import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/domain/security/string_store.dart';

void main() {
  late AppDatabase db;
  late AuthService auth;
  late int admin, staff, teacher, wali, student, unlinked;
  late int s1, s2, c1, c2, k1, k2, d1, d2;
  final now = DateTime(2026, 10, 20);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    auth = AuthService(
      db: db,
      crypto: CryptoService(iterations: 10),
      store: MemoryStore(),
    );
    await auth.setupSuperAdmin(pin: '123456');
    admin = (await auth.findByUsername('superadmin'))!.id;
    Future<int> account(String name, Role role) => auth.createUser(
      actorId: admin,
      username: name,
      role: role,
      pin: '123456',
    );
    staff = await account('staff', Role.adminAkademik);
    teacher = await account('teacher', Role.dosenPengampu);
    wali = await account('wali', Role.dosenWali);
    student = await account('student', Role.mahasiswa);
    unlinked = await account('unlinked', Role.mahasiswa);
    final prodi = await db
        .into(db.prodi)
        .insert(
          ProdiCompanion.insert(
            kode: 'TI',
            nama: 'Informatika',
            updatedAt: now,
            deviceId: 'test',
          ),
        );
    d1 = await db
        .into(db.dosens)
        .insert(
          DosensCompanion.insert(
            nidn: 'D001',
            nama: 'Dosen Pengampu',
            userId: Value(teacher),
            prodiId: prodi,
            updatedAt: now,
            deviceId: 'test',
          ),
        );
    d2 = await db
        .into(db.dosens)
        .insert(
          DosensCompanion.insert(
            nidn: 'D002',
            nama: 'Dosen Wali',
            userId: Value(wali),
            prodiId: prodi,
            updatedAt: now,
            deviceId: 'test',
          ),
        );
    s1 = await db.createMahasiswa(
      nim: '20260001',
      nama: 'Alya Putri',
      prodiId: prodi,
      angkatan: 2026,
      dosenWaliId: d2,
    );
    s2 = await db.createMahasiswa(
      nim: '20260002',
      nama: 'Bima Putra',
      prodiId: prodi,
      angkatan: 2026,
    );
    await auth.linkUserToMahasiswa(
      actorId: admin,
      userId: student,
      mahasiswaId: s1,
    );
    final ta = await db
        .into(db.tahunAjaran)
        .insert(
          TahunAjaranCompanion.insert(
            tahun: '2026/2027',
            semester: 1,
            isActive: const Value(true),
            updatedAt: now,
            deviceId: 'test',
          ),
        );
    final mk = await db
        .into(db.mataKuliah)
        .insert(
          MataKuliahCompanion.insert(
            kode: 'TI101',
            nama: 'Algoritma',
            sks: 3,
            semester: 1,
            prodiId: prodi,
            updatedAt: now,
            deviceId: 'test',
          ),
        );
    c1 = await db
        .into(db.kelas)
        .insert(
          KelasCompanion.insert(
            mkId: mk,
            dosenId: d1,
            taId: ta,
            hari: 'Senin',
            jamMulai: '08:00',
            jamSelesai: '09:40',
            updatedAt: now,
            deviceId: 'test',
          ),
        );
    c2 = await db
        .into(db.kelas)
        .insert(
          KelasCompanion.insert(
            mkId: mk,
            dosenId: d2,
            taId: ta,
            hari: 'Selasa',
            jamMulai: '08:00',
            jamSelesai: '09:40',
            updatedAt: now,
            deviceId: 'test',
          ),
        );
    k1 = await db.addKrsNilai(
      mahasiswaId: s1,
      kelasId: c1,
      tugas: 80,
      uts: 80,
      uas: 80,
    );
    k2 = await db.addKrsNilai(
      mahasiswaId: s1,
      kelasId: c2,
      tugas: 70,
      uts: 70,
      uas: 70,
    );
    await db.addKrsNilai(
      mahasiswaId: s2,
      kelasId: c2,
      tugas: 60,
      uts: 60,
      uas: 60,
    );
  });
  tearDown(() async => db.close());

  test('both administrators see all current students', () async {
    for (final id in [admin, staff]) {
      final service = AcademicService(db, id);
      expect((await service.students()).length, 2);
      expect((await service.counts()).total, 2);
    }
  });
  test(
    'student scope applies to directory, counts, direct ID, and search',
    () async {
      final service = AcademicService(db, student);
      expect((await service.students()).single.id, s1);
      expect((await service.counts()).total, 1);
      expect(await service.students(query: 'Bima'), isEmpty);
      await expectLater(service.student(s2), throwsA(isA<ForbiddenFailure>()));
      await expectLater(service.grades(s2), throwsA(isA<ForbiddenFailure>()));
      expect((await service.grades(s1)).length, 2);
    },
  );
  test(
    'unlinked accounts and missing sessions never inherit global access',
    () async {
      expect(await AcademicService(db, unlinked).students(), isEmpty);
      expect((await AcademicService(db, unlinked).counts()).total, 0);
      await expectLater(
        AcademicService(db, null).students(),
        throwsA(isA<ForbiddenFailure>()),
      );
    },
  );
  test('teacher can only read and grade their own classes', () async {
    final service = AcademicService(db, teacher);
    expect((await service.students()).single.id, s1);
    expect((await service.grades(s1)).single.krsId, k1);
    await service.saveNilai(krsId: k1, tugas: 90, uts: 90, uas: 90);
    await expectLater(
      service.saveNilai(krsId: k2, tugas: 100, uts: 100, uas: 100),
      throwsA(isA<ForbiddenFailure>()),
    );
    await expectLater(service.deleteKrs(k1), throwsA(isA<ForbiddenFailure>()));
  });
  test('wali sees only advisees and cannot change grades', () async {
    final service = AcademicService(db, wali);
    expect((await service.students()).single.id, s1);
    await expectLater(service.student(s2), throwsA(isA<ForbiddenFailure>()));
    await expectLater(
      service.saveNilai(krsId: k1, tugas: 90, uts: 90, uas: 90),
      throwsA(isA<ForbiddenFailure>()),
    );
  });
  test(
    'non-administrators cannot mutate students, trash, or settings',
    () async {
      for (final id in [student, teacher, wali]) {
        final service = AcademicService(db, id);
        await expectLater(
          service.softDeleteMahasiswa(s1),
          throwsA(isA<ForbiddenFailure>()),
        );
        await expectLater(
          service.restoreMahasiswa(s1),
          throwsA(isA<ForbiddenFailure>()),
        );
        await expectLater(service.trash(), throwsA(isA<ForbiddenFailure>()));
        await expectLater(
          service.setSetting('syarat_sks_lulus', '1'),
          throwsA(isA<ForbiddenFailure>()),
        );
        await expectLater(
          service.createMahasiswa(
            nim: '9999',
            nama: 'New User',
            prodiId: 1,
            angkatan: 2026,
          ),
          throwsA(isA<ForbiddenFailure>()),
        );
      }
    },
  );
  test('account deactivation is rechecked on each service request', () async {
    final service = AcademicService(db, student);
    await service.students();
    await auth.setUserActive(actorId: admin, targetId: student, active: false);
    await expectLater(service.students(), throwsA(isA<ForbiddenFailure>()));
  });
  test('delete and restore keep FTS and dashboard counts consistent', () async {
    final service = AcademicService(db, admin);
    await service.softDeleteMahasiswa(s1);
    expect(await service.students(query: 'Alya'), isEmpty);
    expect((await service.counts()).total, 1);
    expect((await db.dashboardCounts()).total, 1);
    expect((await service.trash()).single.id, s1);
    await service.restoreMahasiswa(s1);
    expect((await service.students(query: 'Alya')).single.id, s1);
    expect((await service.counts()).total, 2);
    await db.customStatement(
      "INSERT INTO mahasiswa_fts(mahasiswa_fts, rank) VALUES('integrity-check', 1)",
    );
  });
  test(
    'scores reject NaN, infinity, and out of range at application boundary',
    () async {
      for (final score in [double.nan, double.infinity, -1.0, 101.0]) {
        await expectLater(
          AcademicService(
            db,
            admin,
          ).saveNilai(krsId: k1, tugas: score, uts: 80, uas: 80),
          throwsA(isA<ValidationFailure>()),
        );
      }
    },
  );
  test(
    'profile linking requires superadmin and cannot steal an occupied profile',
    () async {
      await expectLater(
        auth.linkUserToMahasiswa(
          actorId: staff,
          userId: unlinked,
          mahasiswaId: s2,
        ),
        throwsA(isA<ForbiddenFailure>()),
      );
      await expectLater(
        auth.linkUserToMahasiswa(
          actorId: admin,
          userId: unlinked,
          mahasiswaId: s1,
        ),
        throwsA(isA<ValidationFailure>()),
      );
      await auth.linkUserToMahasiswa(
        actorId: admin,
        userId: student,
        mahasiswaId: s2,
      );
      expect((await AcademicService(db, student).students()).single.id, s2);
      expect((await db.getMahasiswa(s1))!.userId, isNull);
    },
  );
  test(
    'a teacher cannot link a different profile through the service',
    () async {
      await expectLater(
        auth.linkUserToDosen(actorId: teacher, userId: teacher, dosenId: d2),
        throwsA(isA<ForbiddenFailure>()),
      );
      await expectLater(
        auth.linkUserToDosen(actorId: admin, userId: student, dosenId: d1),
        throwsA(isA<ValidationFailure>()),
      );
    },
  );
  test(
    'FTS special characters are treated as input instead of query syntax',
    () async {
      final service = AcademicService(db, admin);
      for (final query in ['"', '(', '-', 'Alya OR Bima', '2026*', "'", ':']) {
        await service.students(query: query);
      }
      expect((await service.students(query: 'Aly')).single.id, s1);
    },
  );
  test('archived students do not cause seeding to run again', () async {
    await db.softDeleteMahasiswa(s1);
    await db.softDeleteMahasiswa(s2);
    expect(await db.countMahasiswa(), 0);
    expect(await ensureSeeded(db), isNull);
    expect((await db.listTrashMahasiswa()).length, 2);
  });
  test(
    'login picker exposes active account names and uses linked profiles',
    () async {
      final accounts = await auth.listLoginAccounts();
      expect(accounts.length, 6);
      expect(
        accounts.firstWhere((a) => a.id == student).displayName,
        'Alya Putri',
      );
      expect(
        accounts.firstWhere((a) => a.id == teacher).role,
        Role.dosenPengampu,
      );
      expect(
        accounts.firstWhere((a) => a.id == teacher).displayName,
        'Dosen Pengampu',
      );
      await auth.setUserActive(
        actorId: admin,
        targetId: student,
        active: false,
      );
      expect(
        (await auth.listLoginAccounts()).any((a) => a.id == student),
        isFalse,
      );
    },
  );
  test('one lecturer can have teaching and advising accounts without duplicate profiles', () async {
    await auth.linkUserToDosen(actorId: admin, userId: wali, dosenId: d1);
    final profiles = await db.listDosen();
    final lecturer = profiles.firstWhere((d) => d.id == d1);
    expect(lecturer.userId, teacher);
    expect(lecturer.waliUserId, wali);
    expect(profiles.firstWhere((d) => d.id == d2).userId, null);
    final m = (await db.getMahasiswa(s1))!;
    await AcademicService(db, admin).updateMahasiswa(
      id: m.id,
      nama: m.nama,
      prodiId: m.prodiId,
      angkatan: m.angkatan,
      status: m.status,
      dosenWaliId: d1,
    );
    expect((await AcademicService(db, wali).students()).single.id, s1);
    expect(
      (await AcademicService(db, teacher).classOptions()).single.kelasId,
      c1,
    );
  });
}
