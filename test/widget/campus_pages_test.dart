import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simaha/core/theme/app_theme.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/campus_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/features/campus/announcements_page.dart';
import 'package:simaha/presentation/features/campus/attendance_page.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

import 'academic_preview_helpers.dart';

class _Campus extends Mock implements CampusService {}

class _Session extends SessionNotifier {
  _Session(this.role);
  final Role role;
  @override
  SessionData build() => SessionData(
    user: UserRow(
      id: 1,
      username: 'demo',
      role: role.storageKey,
      pinHash: '',
      salt: '',
      biometricEnabled: false,
      isActive: true,
      failedAttempts: 0,
      updatedAt: DateTime(2026),
      deviceId: 'test',
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAcademicPreviewFonts);
  late _Campus campus;
  setUp(() => campus = _Campus());
  final notice = PengumumanRow(
    id: 1,
    judul: 'Jadwal bimbingan',
    isi: 'Bimbingan dilaksanakan pada hari Senin.',
    kategori: 'akademik',
    updatedAt: DateTime(2026, 10, 21),
    deviceId: 'test',
  );
  Future<void> mount(WidgetTester tester, Role role, Widget page) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionProvider.overrideWith(() => _Session(role)),
          campusServiceProvider.overrideWithValue(campus),
        ],
        child: MaterialApp(theme: AppTheme.light, home: page),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('student reads announcement and cannot publish or delete', (
    tester,
  ) async {
    when(() => campus.announcements()).thenAnswer((_) async => [notice]);
    await mount(tester, Role.mahasiswa, const AnnouncementsPage());
    expect(find.text('Jadwal bimbingan'), findsOneWidget);
    expect(find.text('Tulis pengumuman'), findsNothing);
    expect(find.text('Hapus'), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'admin announcement validates form and calls authorized service',
    (tester) async {
      when(() => campus.announcements()).thenAnswer((_) async => [notice]);
      when(() => campus.publish(any(), any(), any())).thenAnswer((_) async {});
      await mount(tester, Role.adminAkademik, const AnnouncementsPage());
      await tester.tap(find.text('Tulis pengumuman'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Terbitkan'));
      await tester.pumpAndSettle();
      expect(find.text('Judul minimal 5 karakter.'), findsOneWidget);
      expect(find.text('Isi minimal 10 karakter.'), findsOneWidget);
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'Informasi semester',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'Periksa jadwal kuliah semester ini.',
      );
      await tester.tap(find.text('Terbitkan'));
      await tester.pumpAndSettle();
      verify(
        () => campus.publish(
          'Informasi semester',
          'Periksa jadwal kuliah semester ini.',
          'akademik',
        ),
      ).called(1);
      expect(find.text('Terbitkan'), findsNothing);
    },
  );
  testWidgets('announcement load error offers working retry', (tester) async {
    var attempts = 0;
    when(() => campus.announcements()).thenAnswer((_) async {
      if (attempts++ == 0) throw StateError('Contoh kegagalan baca');
      return [notice];
    });
    await mount(tester, Role.mahasiswa, const AnnouncementsPage());
    expect(find.text('Coba Lagi'), findsOneWidget);
    await tester.tap(find.text('Coba Lagi'));
    await tester.pumpAndSettle();
    expect(find.text('Jadwal bimbingan'), findsOneWidget);
  });
  testWidgets('student cannot create attendance meeting', (tester) async {
    when(() => campus.sessions(1)).thenAnswer((_) async => []);
    await mount(tester, Role.mahasiswa, const AttendancePage(classId: 1));
    expect(find.text('Tambah pertemuan'), findsNothing);
    expect(find.text('Belum ada pertemuan'), findsOneWidget);
  });
  testWidgets('teacher can find attendance creation and empty state', (
    tester,
  ) async {
    when(() => campus.sessions(1)).thenAnswer((_) async => []);
    await mount(tester, Role.dosenPengampu, const AttendancePage(classId: 1));
    expect(find.text('Tambah pertemuan'), findsOneWidget);
    expect(find.text('Belum ada pertemuan'), findsOneWidget);
  });
}
