import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/core/security/flag_secure.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/auto_lock_scope.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final role = session.role;
    final scheme = Theme.of(context).colorScheme;
    final location = GoRouterState.of(context).uri.path;
    final destinations = [
      (route: '/', label: 'Beranda', icon: Icons.space_dashboard_outlined),
      (route: '/akademik', label: 'Akademik', icon: Icons.menu_book_outlined),
      if (role == Role.superAdmin)
        (
          route: '/users',
          label: 'Kelola akun',
          icon: Icons.manage_accounts_outlined,
        ),
      if (role == Role.superAdmin || role == Role.adminAkademik)
        (route: '/db', label: 'Database', icon: Icons.storage_outlined),
      (route: '/pengumuman', label: 'Warta', icon: Icons.campaign_outlined),
      (route: '/settings', label: 'Pengaturan', icon: Icons.tune_outlined),
    ];
    final navLocation =
        location.startsWith('/kelas/') || location.startsWith('/presensi/')
        ? '/akademik'
        : location;
    final isWide = MediaQuery.sizeOf(context).width >= 1000;
    if (!isWide) {
      destinations.removeWhere((d) => d.route == '/db' || d.route == '/users');
    }
    final index = destinations.indexWhere((d) => d.route == navLocation);
    final selected = index < 0 ? 0 : index;
    final themeButton = IconButton(
      tooltip: 'Ganti tema',
      onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined,
      ),
    );
    return SecureScope(
      child: AutoLockScope(
        child: Scaffold(
          body: Row(
            children: [
              if (isWide)
                Container(
                  width: 244,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLowest,
                    border: Border(
                      right: BorderSide(color: scheme.outlineVariant),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: scheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.account_balance_outlined,
                                  color: scheme.onPrimary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'SIMAHA',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'RUANG AKADEMIK',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 2,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 32),
                          for (var i = 0; i < destinations.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Material(
                                color: Colors.transparent,
                                child: ListTile(
                                  dense: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  selected: selected == i,
                                  selectedTileColor: scheme.primaryContainer
                                      .withValues(alpha: 0.55),
                                  selectedColor: scheme.onPrimaryContainer,
                                  leading: Icon(destinations[i].icon, size: 21),
                                  title: Text(destinations[i].label),
                                  onTap: () =>
                                      context.go(destinations[i].route),
                                ),
                              ),
                            ),
                          const Spacer(),
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(
                            session.user?.username ?? 'Akun lokal',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            role?.label ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              themeButton,
                              const Spacer(),
                              IconButton(
                                tooltip: 'Ganti akun / kunci',
                                onPressed: () =>
                                    ref.read(sessionProvider.notifier).lock(),
                                icon: const Icon(Icons.lock_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Expanded(child: child),
            ],
          ),
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
                  selectedIndex: selected,
                  onDestinationSelected: (i) =>
                      context.go(destinations[i].route),
                  destinations: [
                    for (final d in destinations)
                      NavigationDestination(icon: Icon(d.icon), label: d.label),
                  ],
                ),
        ),
      ),
    );
  }
}
