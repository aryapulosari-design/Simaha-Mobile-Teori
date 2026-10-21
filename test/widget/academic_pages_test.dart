import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simaha/core/theme/app_theme.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/academic_service.dart';
import 'package:simaha/domain/academic/academic_overview.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/features/academic/academic_workspace_page.dart';
import 'package:simaha/presentation/features/academic/advising_section.dart';
import 'package:simaha/presentation/features/academic/role_guide_page.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

import 'academic_preview_helpers.dart';

class _Service extends Mock implements AcademicService {}

class _Session extends SessionNotifier {
  _Session(this.role);
  final Role role;
  @override
  SessionData build() => SessionData(
    user: UserRow(
      id: 1,
      username: 'preview',
      role: role.storageKey,
      pinHash: '',
      salt: '',
      biometricEnabled: false,
      isActive: true,
      failedAttempts: 0,
      updatedAt: DateTime(2026, 10, 20),
      deviceId: 'preview',
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAcademicPreviewFonts);
  late _Service service;
  late GlobalKey previewKey;
  const course = AcademicClassInfo(
    id: 1,
    code: 'IF101',
    name: 'Algoritma dan Pemrograman',
    credits: 3,
    lecturer: 'Rahma Hidayati',
    day: 'Senin',
    start: '08:00',
    end: '10:30',
    room: 'IF-101',
    term: '2026/2027 / Gasal',
    studentCount: 10,
    average: 79.2,
  );
  final note = AdvisingNote(
    id: 1,
    lecturer: 'Rahma Hidayati',
    content: 'Rencana studi 15 SKS telah ditinjau. Mahasiswa mengikuti lima mata kuliah semester ini.',
    followUp:
        'Pertahankan kehadiran dan selesaikan tugas mingguan tepat waktu.',
    date: DateTime(2026, 10, 17),
  );
  setUp(() {
    service = _Service();
    previewKey = GlobalKey();
  });

  Future<void> mount(
    WidgetTester tester,
    Role role,
    Widget page, {
    Size size = const Size(1000, 1100),
    double scale = 1,
  }) async {
    if (const bool.fromEnvironment('MOBILE_REPORT') && scale == 1) {
      size = const Size(390, 844);
    }
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = scale;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionProvider.overrideWith(() => _Session(role)),
          academicServiceProvider.overrideWithValue(service),
        ],
        child: RepaintBoundary(
          key: previewKey,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: page,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'teacher workspace shows linked lecturer, course, roster size, and schedule',
    (tester) async {
      when(() => service.classes()).thenAnswer((_) async => [course]);
      await mount(tester, Role.dosenPengampu, const AcademicWorkspacePage());
      expect(find.text('Kelas yang Anda ampu'), findsOneWidget);
      expect(find.text('Algoritma dan Pemrograman'), findsOneWidget);
      expect(find.text('Dosen: Rahma Hidayati'), findsOneWidget);
      expect(find.text('10 mahasiswa dalam akses Anda'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await writeAcademicPreview(
        tester,
        previewKey,
        const bool.fromEnvironment('MOBILE_REPORT')
            ? 'mobile-kelas-pengampu'
            : 'kelas-pengampu',
      );
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('student class detail shows personal grade and attendance', (
    tester,
  ) async {
    when(() => service.classDetail(1)).thenAnswer(
      (_) async => const AcademicClassDetail(course, [
        ClassStudentInfo(
          id: 1,
          nim: '2026IF001',
          name: 'Alya Putri',
          letter: 'A',
          score: 89.8,
          meetings: 3,
          present: 3,
          excused: 0,
          sick: 0,
          absent: 0,
        ),
      ]),
    );
    await mount(tester, Role.mahasiswa, const AcademicClassPage(classId: 1));
    expect(find.text('Hasil & kehadiran saya'), findsOneWidget);
    expect(find.text('Alya Putri'), findsOneWidget);
    expect(find.text('Hadir 3/3 pertemuan'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await writeAcademicPreview(
      tester,
      previewKey,
      const bool.fromEnvironment('MOBILE_REPORT')
          ? 'mobile-kelas-mahasiswa'
          : 'kelas-mahasiswa',
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('student can read advisor notes without a write button', (
    tester,
  ) async {
    when(() => service.advisingNotes(1)).thenAnswer((_) async => [note]);
    await mount(
      tester,
      Role.mahasiswa,
      const Scaffold(
        body: SingleChildScrollView(child: AdvisingSection(studentId: 1)),
      ),
    );
    expect(find.text(note.content), findsOneWidget);
    expect(find.text('Tambah catatan bimbingan'), findsNothing);
    expect(tester.takeException(), isNull);
    await writeAcademicPreview(
      tester,
      previewKey,
      const bool.fromEnvironment('MOBILE_REPORT')
          ? 'mobile-bimbingan-mahasiswa'
          : 'bimbingan-mahasiswa',
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('wali can validate and save a note for the selected student', (
    tester,
  ) async {
    final notes = [note];
    when(() => service.advisingNotes(1)).thenAnswer((_) async => notes);
    when(
      () => service.addAdvisingNote(
        studentId: 1,
        content: 'Latihan Algoritma sudah meningkat.',
        followUp: 'Lanjutkan belajar terjadwal.',
      ),
    ).thenAnswer((_) async {
      notes.insert(
        0,
        AdvisingNote(
          id: 2,
          lecturer: 'Rahma Hidayati',
          content: 'Latihan Algoritma sudah meningkat.',
          followUp: 'Lanjutkan belajar terjadwal.',
          date: DateTime(2026, 10, 20),
        ),
      );
    });
    await mount(
      tester,
      Role.dosenWali,
      const Scaffold(
        body: SingleChildScrollView(child: AdvisingSection(studentId: 1)),
      ),
    );
    await tester.tap(find.text('Tambah catatan bimbingan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan catatan'));
    await tester.pumpAndSettle();
    expect(find.text('Isi catatan minimal 5 karakter.'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Latihan Algoritma sudah meningkat.',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Lanjutkan belajar terjadwal.',
    );
    await tester.tap(find.text('Simpan catatan'));
    await tester.pumpAndSettle();
    verify(
      () => service.addAdvisingNote(
        studentId: 1,
        content: 'Latihan Algoritma sudah meningkat.',
        followUp: 'Lanjutkan belajar terjadwal.',
      ),
    ).called(1);
    expect(find.text('Latihan Algoritma sudah meningkat.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await writeAcademicPreview(
      tester,
      previewKey,
      const bool.fromEnvironment('MOBILE_REPORT')
          ? 'mobile-bimbingan-wali'
          : 'bimbingan-wali',
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'teaching role never requests or renders private advising notes',
    (tester) async {
      await mount(
        tester,
        Role.dosenPengampu,
        const Scaffold(body: AdvisingSection(studentId: 1)),
      );
      expect(find.text('Catatan bimbingan'), findsNothing);
      verifyNever(() => service.advisingNotes(any()));
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets(
    'all role functions remain readable on a narrow screen with large text',
    (tester) async {
      await mount(
        tester,
        Role.dosenWali,
        const RoleGuidePage(),
        size: const Size(320, 900),
        scale: 1.6,
      );
      for (final role in Role.values) {
        expect(find.text(role.label), findsOneWidget);
      }
      expect(find.text('Peran Anda'), findsOneWidget);
      await tester.drag(find.byType(ListView), const Offset(0, -900));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
