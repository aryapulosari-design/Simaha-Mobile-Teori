import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/core/config/app_runtime.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/features/home/widgets/student_row.dart';
import 'package:simaha/presentation/features/home/widgets/workspace_dashboard.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/bento_card.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _search = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _search.text = ref.read(mahasiswaQueryProvider);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _refresh() {
    ref
      ..invalidate(dashboardCountsProvider)
      ..invalidate(mahasiswaSearchProvider)
      ..invalidate(workspaceOverviewProvider)
      ..invalidate(announcementsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final role = session.role;
    final canManage = role != null && canRole(role, Permission.manageMaster);
    final t = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 700;
    final title = switch (role) {
      Role.mahasiswa => 'Perjalanan studi Anda',
      Role.dosenPengampu => 'Ruang mengajar',
      Role.dosenWali => 'Pendampingan akademik',
      Role.superAdmin => 'Pusat kendali akademik',
      _ => 'Administrasi akademik',
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIMAHA / Beranda'),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
            icon: const Icon(Icons.contrast_outlined),
          ),
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: _refresh,
            icon: const Icon(Icons.refresh_outlined),
          ),
          IconButton(
            tooltip: 'Ganti akun / kunci',
            onPressed: () => ref.read(sessionProvider.notifier).lock(),
            icon: const Icon(Icons.switch_account_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _refresh();
          await ref.read(mahasiswaSearchProvider.future);
        },
        child: ListView(
          padding: EdgeInsets.all(wide ? 24 : 16),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ContextTag(
                          role?.label.toUpperCase() ?? 'RUANG AKADEMIK',
                        ),
                        ContextTag(
                          AppRuntime.isDemo
                              ? 'DEMO • 50 MAHASISWA'
                              : 'PERANGKAT LOKAL',
                          icon: Icons.circle_outlined,
                        ),
                        const ContextTag(
                          'Tersedia offline',
                          icon: Icons.wifi_off_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: wide
                          ? t.textTheme.headlineLarge
                          : t.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Selamat datang, ${session.user?.username ?? ''}. Semua aktivitas studi terhubung di satu ruang.',
                      style: t.textTheme.bodyMedium?.copyWith(
                        color: t.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => context.push('/panduan-peran'),
                          icon: const Icon(Icons.help_outline, size: 17),
                          label: const Text('Semua fungsi peran'),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              ref.read(sessionProvider.notifier).lock(),
                          icon: const Icon(
                            Icons.switch_account_outlined,
                            size: 17,
                          ),
                          label: const Text('Ganti akun'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const WorkspaceDashboard(),
                    const SizedBox(height: 28),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 16,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          width: wide ? 340 : null,
                          child: SectionHeader(
                            title: role == Role.mahasiswa
                                ? 'Profil akademik saya'
                                : role == Role.dosenWali
                                ? 'Mahasiswa bimbingan'
                                : 'Direktori mahasiswa',
                            subtitle: 'Buka profil untuk melihat hasil studi dan informasi terkait.',
                          ),
                        ),
                        if (canManage)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () => context.push('/trash'),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                ),
                                label: const Text('Tempat sampah'),
                              ),
                              FilledButton.icon(
                                onPressed: () async {
                                  final ok = await context.push<bool>(
                                    '/mahasiswa/baru',
                                  );
                                  if (ok == true) _refresh();
                                },
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Tambah mahasiswa'),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: 'Cari nama atau NIM',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _search.text.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Bersihkan pencarian',
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _debounce?.cancel();
                                  _search.clear();
                                  ref
                                          .read(mahasiswaQueryProvider.notifier)
                                          .state =
                                      '';
                                  setState(() {});
                                },
                              ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                        _debounce?.cancel();
                        _debounce = Timer(
                          const Duration(milliseconds: 250),
                          () {
                            ref.read(mahasiswaQueryProvider.notifier).state =
                                value;
                            ref.read(mahasiswaLimitProvider.notifier).state =
                                kMahasiswaPageStep;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ref
                        .watch(mahasiswaSearchProvider)
                        .when(
                          loading: () => const LinearProgressIndicator(),
                          error: (e, _) =>
                              ErrorState(message: '$e', onRetry: _refresh),
                          data: (result) => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (result.rows.isEmpty)
                                const EmptyState(
                                  title: 'Belum ada data yang sesuai',
                                  message: 'Coba nama atau NIM lain. Untuk akun baru, minta Super Admin menghubungkan profil.',
                                )
                              else
                                Card(
                                  child: Column(
                                    children: [
                                      for (
                                        var i = 0;
                                        i < result.rows.length;
                                        i++
                                      ) ...[
                                        if (i > 0) const Divider(),
                                        StudentRow(
                                          student: result.rows[i],
                                          wide: wide,
                                          canManage: canManage,
                                          refresh: _refresh,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 12),
                              if (result.rows.length >= result.limit)
                                OutlinedButton.icon(
                                  onPressed: () =>
                                      ref
                                              .read(
                                                mahasiswaLimitProvider.notifier,
                                              )
                                              .state =
                                          result.limit + kMahasiswaPageStep,
                                  icon: const Icon(Icons.expand_more),
                                  label: const Text('Muat lebih banyak'),
                                ),
                              Text(
                                'Menampilkan ${result.rows.length} mahasiswa sesuai akses Anda.',
                                style: t.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'SIMAHA OFFLINE  /  Data akademik dalam kendali Anda.',
                      style: t.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
