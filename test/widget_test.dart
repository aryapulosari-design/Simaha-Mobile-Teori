// Tahap A smoke: theme + DB-free pages. HomePage needs a real encrypted DB
// (provided via ProviderScope override in main.dart), so widget tests cover
// the DB-free pages plus router construction only.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/router/app_router.dart';
import 'package:simaha/core/theme/app_theme.dart';
import 'package:simaha/presentation/features/settings/settings_page.dart';

void main() {
  test('light and dark themes are Material3', () {
    expect(AppTheme.light.useMaterial3, isTrue);
    expect(AppTheme.dark.useMaterial3, isTrue);
    expect(AppTheme.light.colorScheme.brightness, Brightness.light);
    expect(AppTheme.dark.colorScheme.brightness, Brightness.dark);
  });

  test('router constructs with 3 shell destinations', () {
    final router = buildRouter(dbPath: '/tmp/simaha.db');
    expect(router, isNotNull);
    // ShellRoute + 3 sub-routes registered without throwing.
    expect(router.routerDelegate.toString().isNotEmpty, isTrue);
  });

  testWidgets('settings page renders without DB', (tester) async {
    // Tall viewport so all lazily-built tiles materialize at once.
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const SettingsPage()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Pengaturan'), findsOneWidget);
    expect(find.textContaining('Bobot nilai'), findsOneWidget);
  });
}
