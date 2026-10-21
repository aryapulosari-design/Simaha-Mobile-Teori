import 'package:simaha/presentation/providers/campus_providers.dart';

import 'workspace_fixture.dart';
import 'academic_preview_helpers.dart';

import 'dart:io';


import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/router/app_router.dart';
import 'package:simaha/core/security/gate.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/seed/demo_seed.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/main.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

class _Session extends SessionNotifier {
  _Session(this.role);
  final Role role;
  @override
  SessionData build() => SessionData(
    user: UserRow(
      id: 1,
      username: 'arya',
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
  final rows = List.generate(
    demoStudents.length,
    (i) => MahasiswaRow(
      id: i + 1,
      nim: '2026IF${(i + 1).toString().padLeft(3, '0')}',
      nama: demoStudents[i].name,
      prodiId: 1,
      angkatan: 2026,
      status: 'aktif',
      email: '',
      noHp: '',
      isDeleted: false,
      updatedAt: DateTime(2026, 10, 20),
      deviceId: 'preview',
    ),
  );
  for (final scene in [
    (
      name: 'role-admin-akademik',
      size: const Size(1440, 1000),
      role: Role.adminAkademik,
      dark: false,
      scale: 1.0,
    ),
    (
      name: 'role-pengampu',
      size: const Size(1440, 1000),
      role: Role.dosenPengampu,
      dark: false,
      scale: 1.0,
    ),
    (
      name: 'role-wali',
      size: const Size(1440, 1000),
      role: Role.dosenWali,
      dark: false,
      scale: 1.0,
    ),
    (
      name: 'role-mahasiswa',
      size: const Size(1440, 1000),
      role: Role.mahasiswa,
      dark: false,
      scale: 1.0,
    ),
    (
      name: 'desktop-light',
      size: const Size(1440, 1000),
      role: Role.superAdmin,
      dark: false,
      scale: 1.0,
    ),
    (
      name: 'mobile-light',
      size: const Size(390, 844),
      role: Role.superAdmin,
      dark: false,
      scale: 1.0,
    ),
    (
      name: 'mobile-dark',
      size: const Size(390, 844),
      role: Role.mahasiswa,
      dark: true,
      scale: 1.0,
    ),
    (
      name: 'mobile-large-text',
      size: const Size(320, 900),
      role: Role.mahasiswa,
      dark: false,
      scale: 1.6,
    ),
    (
      name: 'tablet',
      size: const Size(800, 1100),
      role: Role.dosenWali,
      dark: false,
      scale: 1.0,
    ),
  ]) {
    testWidgets('${scene.name}: dashboard fits and respects role actions', (
      tester,
    ) async {
      tester.view.physicalSize = scene.size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = scene.scale;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      gateListenable.value = GateStatus.ok;
      addTearDown(() => gateListenable.value = GateStatus.lock);
      final container = ProviderContainer(
        overrides: [
          sessionProvider.overrideWith(() => _Session(scene.role)),
          workspaceOverviewProvider.overrideWith(
            (ref) async => workspaceFixture(scene.role),
          ),
          dashboardCountsProvider.overrideWith(
            (ref) async => (
              total: scene.role == Role.mahasiswa
                  ? 1
                  : scene.role == Role.dosenWali
                  ? 10
                  : 50,
              aktif: scene.role == Role.mahasiswa
                  ? 1
                  : scene.role == Role.dosenWali
                  ? 2
                  : 10,
              prodi: 1,
            ),
          ),
          mahasiswaSearchProvider.overrideWith(
            (ref) async => (
              rows: scene.role == Role.mahasiswa
                  ? rows.take(1).toList()
                  : scene.role == Role.dosenWali
                  ? rows.where((m) => (m.id - 1) % 10 < 2).toList()
                  : rows,
              elapsedMs: 8,
              limit: 20,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      if (scene.dark) {
        container.read(themeModeProvider.notifier).toggle();
        container.read(themeModeProvider.notifier).toggle();
      }
      final key = GlobalKey();
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: RepaintBoundary(
            key: key,
            child: const SimahaApp(dbPath: 'preview.db'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      if (!canRole(scene.role, Permission.manageMaster)) {
        expect(find.text('Tambah mahasiswa'), findsNothing);
      } else {
        expect(find.text('Tambah mahasiswa'), findsOneWidget);
      }
      if (const bool.fromEnvironment('WRITE_PREVIEWS')) {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        await tester.runAsync(() async {
          final img = await boundary.toImage();
          final bytes = (await img.toByteData(format: ui.ImageByteFormat.png))!;
          final file = File('doct/design/previews/${scene.name}.png');
          await file.parent.create(recursive: true);
          await file.writeAsBytes(bytes.buffer.asUint8List());
          img.dispose();
        });
      }
      // Reach the directory and exercise the debounce without a layout exception.
      await tester.drag(find.byType(ListView).first, const Offset(0, -650));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    });
  }
  testWidgets(
    'restricted deep links redirect and theme changes preserve current route',
    (tester) async {
      gateListenable.value = GateStatus.ok;
      addTearDown(() => gateListenable.value = GateStatus.lock);
      final container = ProviderContainer(
        overrides: [
          sessionProvider.overrideWith(() => _Session(Role.mahasiswa)),
          dashboardCountsProvider.overrideWith(
            (ref) async => (total: 0, aktif: 0, prodi: 0),
          ),
          mahasiswaSearchProvider.overrideWith(
            (ref) async => (rows: <MahasiswaRow>[], elapsedMs: 0, limit: 20),
          ),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SimahaApp(dbPath: 'preview.db'),
        ),
      );
      await tester.pumpAndSettle();
      final router = container.read(routerProvider('preview.db'));
      for (final path in [
        '/users',
        '/db',
        '/trash',
        '/mahasiswa/baru',
        '/mahasiswa/1/edit',
      ]) {
        router.go(path);
        await tester.pumpAndSettle();
        expect(router.routeInformationProvider.value.uri.path, '/');
        expect(tester.takeException(), isNull);
      }
      router.go('/settings');
      await tester.pumpAndSettle();
      container.read(themeModeProvider.notifier).toggle();
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/settings');
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
