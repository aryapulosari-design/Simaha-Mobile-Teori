import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/shared/widgets/auto_lock_scope.dart';

/// Bottom-navigation shell for Tahap A (Beranda • Pengaturan • Database).
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const _tabs = ['/', '/settings', '/db'];

  int _indexFor(String location) {
    if (location.startsWith('/settings')) return 1;
    if (location.startsWith('/db')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexFor(location);
    final mode = ref.watch(themeModeProvider);

    return Scaffold(
      body: AutoLockScope(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(_tabs[i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune),
            label: 'Pengaturan',
          ),
          NavigationDestination(
            icon: Icon(Icons.storage_outlined),
            selectedIcon: Icon(Icons.storage),
            label: 'Database',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Ganti tema terang/gelap (saat ini: $mode)',
        onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
        child: Icon(
          mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
        ),
      ),
    );
  }
}
