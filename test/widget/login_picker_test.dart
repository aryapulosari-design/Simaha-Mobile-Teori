import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simaha/core/errors/failures.dart';
import 'package:simaha/core/config/app_runtime.dart';

import 'academic_preview_helpers.dart';

import 'package:simaha/core/security/gate.dart';
import 'package:simaha/core/theme/app_theme.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/domain/security/login_account.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/domain/security/string_store.dart';
import 'package:simaha/presentation/features/auth/lock_page.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

class _Auth extends Mock implements AuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAcademicPreviewFonts);
  const accounts = [
    LoginAccount(
      id: 1,
      username: 'superadmin',
      displayName: 'superadmin',
      role: Role.superAdmin,
    ),
    LoginAccount(
      id: 2,
      username: 'mahasiswa.a',
      displayName: 'Alya Putri',
      role: Role.mahasiswa,
    ),
    LoginAccount(
      id: 3,
      username: 'mahasiswa.b',
      displayName: 'Bima Putra',
      role: Role.mahasiswa,
    ),
  ];
  late _Auth auth;
  late MemoryStore store;
  late ProviderContainer container;

  setUp(() {
    auth = _Auth();
    store = MemoryStore();
    when(() => auth.listLoginAccounts()).thenAnswer((_) async => accounts);
    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(auth),
        lastUserStoreProvider.overrideWithValue(store),
      ],
    );
    gateListenable.value = GateStatus.lock;
  });
  tearDown(() {
    container.dispose();
    gateListenable.value = GateStatus.lock;
  });

  Future<void> mount(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1300);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.light, home: const LockPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> chooseRole(WidgetTester tester, Role role) async {
    final finder = find.byKey(ValueKey('login-role-${role.storageKey}'));
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> typePin(WidgetTester tester, String pin) async {
    for (final digit in pin.split('')) {
      final finder = find.byKey(ValueKey('pin-key-$digit'));
      await tester.ensureVisible(finder);
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
  }

  testWidgets(
    'five roles are selectable with no username typing; empty roles cannot log in',
    (tester) async {
      await mount(tester);
      for (final role in Role.values) {
        expect(
          find.byKey(ValueKey('login-role-${role.storageKey}')),
          findsOneWidget,
        );
      }
      expect(find.byType(TextField), findsNothing);
      await chooseRole(tester, Role.dosenPengampu);
      expect(find.byKey(const ValueKey('login-no-account')), findsOneWidget);
      expect(find.byKey(const ValueKey('pin-key-1')), findsNothing);
      expect(container.read(sessionProvider).isUnlocked, isFalse);
      verifyNever(() => auth.verifyPin(any(), any()));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('last account restores the role and selected name', (
    tester,
  ) async {
    await store.write('simaha_last_user', 'mahasiswa.b');
    await mount(tester);
    final chip = tester.widget<ChoiceChip>(
      find.byKey(const ValueKey('login-role-mahasiswa')),
    );
    expect(chip.selected, isTrue);
    final field = tester.widget<DropdownButtonFormField<int>>(
      find.byKey(const ValueKey('login-account-mahasiswa')),
    );
    expect(field.initialValue, 3);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'switching accounts clears partial PIN and uses the selected account for verification',
    (tester) async {
      when(() => auth.verifyPin('mahasiswa.b', '123456')).thenAnswer(
        (_) async => const Err<UserRow, AppFailure>(AuthFailure('PIN salah.')),
      );
      await mount(tester);
      await chooseRole(tester, Role.mahasiswa);
      await typePin(tester, '12');
      await tester.tap(find.byKey(const ValueKey('login-account-mahasiswa')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bima Putra · mahasiswa.b').last);
      await tester.pumpAndSettle();
      expect(
        find.bySemanticsLabel('0 dari 6 digit PIN terisi'),
        findsOneWidget,
      );
      await typePin(tester, '123456');
      verify(() => auth.verifyPin('mahasiswa.b', '123456')).called(1);
      expect(find.text('PIN salah.'), findsOneWidget);
      expect(container.read(sessionProvider).isUnlocked, isFalse);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets(
    'selecting a role still needs a valid PIN and unlocks the verified user',
    (tester) async {
      final user = UserRow(
        id: 2,
        username: 'mahasiswa.a',
        role: Role.mahasiswa.storageKey,
        pinHash: '',
        salt: '',
        biometricEnabled: false,
        isActive: true,
        failedAttempts: 0,
        updatedAt: DateTime(2026, 10, 20),
        deviceId: 'test',
      );
      when(() => auth.verifyPin('mahasiswa.a', '123456'))
          .thenAnswer((_) async => Ok<UserRow, AppFailure>(user));
      await mount(tester);
      await chooseRole(tester, Role.mahasiswa);
      expect(container.read(sessionProvider).isUnlocked, isFalse);
      await typePin(tester, '123456');
      expect(container.read(sessionProvider).role, Role.mahasiswa);
      expect(container.read(sessionProvider).user!.id, 2);
      expect(await store.read('simaha_last_user'), 'mahasiswa.a');
      expect(gateListenable.value, GateStatus.ok);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('failed account loading can be retried', (tester) async {
    when(() => auth.listLoginAccounts())
        .thenAnswer((_) async => throw StateError('DB unavailable'));
    await mount(tester);
    expect(find.text('Daftar akun belum dapat dimuat.'), findsOneWidget);
    when(() => auth.listLoginAccounts()).thenAnswer((_) async => accounts);
    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('login-account-super_admin')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'role and account chooser fits a narrow screen with enlarged text',
    (tester) async {
      await mount(tester);
      tester.view.physicalSize = const Size(320, 900);
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpAndSettle();
      await chooseRole(tester, Role.mahasiswa);
      await tester.ensureVisible(find.byKey(const ValueKey('pin-key-0')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
  testWidgets(
    'demo shortcut is mode-specific and verifies the selected account PIN',
    (tester) async {
      await mount(tester);
      await chooseRole(tester, Role.mahasiswa);
      if (!AppRuntime.isDemo) {
        expect(find.text('Masuk akun demo'), findsNothing);
      } else {
        when(() => auth.verifyPin('mahasiswa.a', AppRuntime.demoPin))
            .thenAnswer(
              (_) async => const Err<UserRow, AppFailure>(
                AuthFailure('PIN akun sudah berubah.'),
              ),
            );
        final button = find.text('Masuk akun demo');
        await tester.ensureVisible(button);
        await tester.tap(button);
        await tester.pumpAndSettle();
        verify(() => auth.verifyPin('mahasiswa.a', AppRuntime.demoPin))
            .called(1);
        expect(container.read(sessionProvider).isUnlocked, isFalse);
        expect(find.text('PIN akun sudah berubah.'), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
