import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/auto_lock_scope.dart';

class _NavItem {
  const _NavItem({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.allowedRoles,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Set<Role>? allowedRoles;
}

const List<_NavItem> _allNavItems = [
  _NavItem(
    route: '/',
    label: 'Beranda',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
  ),
  _NavItem(
    route: '/settings',
    label: 'Pengaturan',
    icon: Icons.tune_outlined,
    selectedIcon: Icons.tune,
  ),
  _NavItem(
    route: '/db',
    label: 'Database',
    icon: Icons.storage_outlined,
    selectedIcon: Icons.storage,
    allowedRoles: {Role.superAdmin, Role.adminAkademik},
  ),
];

/// Bottom-navigation shell with role-aware menu filtering (Step 1 & Step 2).
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final mode = ref.watch(themeModeProvider);
    final session = ref.watch(sessionProvider);
    final userRole = session.role;

    // Filter items based on active role if unlocked; otherwise show standard set.
    final items = _allNavItems.where((item) {
      if (item.allowedRoles == null || userRole == null) return true;
      return item.allowedRoles!.contains(userRole);
    }).toList();

    var selectedIndex = 0;
    for (var i = 0; i < items.length; i++) {
      if (items[i].route == '/' && location == '/') {
        selectedIndex = i;
        break;
      } else if (items[i].route != '/' && location.startsWith(items[i].route)) {
        selectedIndex = i;
        break;
      }
    }

    return Scaffold(
      body: AutoLockScope(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (i) => context.go(items[i].route),
        destinations: items
            .map(
              (item) => NavigationDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon),
                label: item.label,
              ),
            )
            .toList(),
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
