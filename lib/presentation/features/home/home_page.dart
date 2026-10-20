import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/presentation/features/academic/role_guide_page.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
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
      ..invalidate(mahasiswaSearchProvider);
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(sessionProvider).role;
    final canManage = role != null && canRole(role, Permission.manageMaster);
    final counts = ref.watch(dashboardCountsProvider);
    final search = ref.watch(mahasiswaSearchProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final wide = MediaQuery.sizeOf(context).width >= 700;
    final title = switch (role) {
      Role.mahasiswa => 'Perjalanan akademik Anda.',
      Role.dosenPengampu => 'Ruang kelas Anda.',
      Role.dosenWali => 'Tumbuh bersama mahasiswa.',
      _ => 'Akademik, lebih tertata.',
    };
    final description = switch (role) {
      Role.mahasiswa =>
        'Profil, hasil studi, dan rencana berikutnya dalam satu tempat.',
      Role.dosenPengampu =>
        'Pantau mahasiswa dan kelola nilai di kelas yang Anda ampu.',
      Role.dosenWali =>
        'Kenali perkembangan akademik mahasiswa bimbingan Anda.',
      _ => 'Kelola data mahasiswa dengan rapi, langsung dari perangkat Anda.',
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(
          wide ? 'Beranda / Ringkasan' : 'simaha',
          style: text.titleMedium,
        ),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            icon: const Icon(Icons.contrast_outlined),
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
          ),
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: _refresh,
            icon: const Icon(Icons.refresh_outlined),
          ),
          IconButton(
            tooltip: 'Ganti akun / kunci',
            onPressed: () => ref.read(sessionProvider.notifier).lock(),
            icon: const Icon(Icons.lock_outline),
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
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: wide ? 36 : 20,
            vertical: 24,
          ),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'RUANG KERJA',
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.primaryContainer.withValues(
                              alpha: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            role?.label ?? 'Akun lokal',
                            style: TextStyle(
                              color: scheme.onPrimaryContainer,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: wide ? text.headlineLarge : text.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: text.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const RolePurposeCard(),
                    const SizedBox(height: 24),
                    counts.when(
                      data: (c) => LayoutBuilder(
                        builder: (context, box) {
                          final columns = box.maxWidth < 480 ? 1 : 3;
                          final width =
                              (box.maxWidth - (columns - 1) * 12) / columns;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              SizedBox(
                                width: width,
                                child: StatCard(
                                  label: role == Role.mahasiswa
                                      ? 'Profil terhubung'
                                      : 'Mahasiswa dalam lingkup Anda',
                                  value: '${c.total}',
                                  icon: Icons.people_outline,
                                ),
                              ),
                              SizedBox(
                                width: width,
                                child: StatCard(
                                  label: 'Status aktif',
                                  value: '${c.aktif}',
                                  icon: Icons.check_circle_outline,
                                ),
                              ),
                              SizedBox(
                                width: width,
                                child: StatCard(
                                  label: 'Program studi',
                                  value: '${c.prodi}',
                                  icon: Icons.account_balance_outlined,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (e, _) => ErrorState(
                        message: 'Ringkasan belum dapat dimuat. $e',
                        onRetry: _refresh,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: scheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Tersimpan di perangkat ini. Tetap tersedia tanpa internet.',
                              style: text.bodySmall,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.wifi_off_outlined,
                            size: 18,
                            color: scheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: 16,
                      spacing: 24,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          width: wide ? 350 : null,
                          child: SectionHeader(
                            title: role == Role.mahasiswa
                                ? 'Data akademik saya'
                                : 'Direktori mahasiswa',
                            subtitle: role == Role.mahasiswa
                                ? 'Buka profil untuk melihat hasil studi.'
                                : 'Cari profil dan buka rincian akademiknya.',
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: 'Cari nama atau NIM',
                        prefixIcon: const Icon(Icons.search, size: 21),
                        suffixIcon: _search.text.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Bersihkan pencarian',
                                icon: const Icon(Icons.close, size: 18),
                                onPressed: () {
                                  _debounce?.cancel();
                                  _search.clear();
                                  ref
                                          .read(mahasiswaQueryProvider.notifier)
                                          .state =
                                      '';
                                  ref
                                          .read(mahasiswaLimitProvider.notifier)
                                          .state =
                                      kMahasiswaPageStep;
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
                    const SizedBox(height: 16),
                    search.when(
                      data: (result) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (result.rows.isEmpty)
                            EmptyState(
                              title: _search.text.isEmpty
                                  ? 'Belum ada data terhubung'
                                  : 'Pencarian belum menemukan hasil',
                              message: _search.text.isEmpty
                                  ? (canManage
                                        ? 'Mulai dengan menambahkan mahasiswa.'
                                        : 'Hubungi Super Admin untuk menghubungkan akun dengan profil Anda.')
                                  : 'Coba nama atau NIM yang lain.',
                              icon: Icons.person_search_outlined,
                            )
                          else
                            Card(
                              child: Column(
                                children: [
                                  if (wide)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 14,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'MAHASISWA',
                                              style: text.labelSmall?.copyWith(
                                                letterSpacing: 1.3,
                                                color: scheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 110,
                                            child: Text(
                                              'ANGKATAN',
                                              style: text.labelSmall?.copyWith(
                                                letterSpacing: 1.3,
                                                color: scheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: canManage ? 140 : 100,
                                            child: Text(
                                              'STATUS',
                                              style: text.labelSmall?.copyWith(
                                                letterSpacing: 1.3,
                                                color: scheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  for (
                                    var i = 0;
                                    i < result.rows.length;
                                    i++
                                  ) ...[
                                    if (i > 0 || wide) const Divider(),
                                    _StudentRow(
                                      student: result.rows[i],
                                      wide: wide,
                                      canManage: canManage,
                                      refresh: _refresh,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          const SizedBox(height: 16),
                          if (result.rows.length >= result.limit)
                            OutlinedButton.icon(
                              onPressed: () =>
                                  ref
                                          .read(mahasiswaLimitProvider.notifier)
                                          .state =
                                      result.limit + kMahasiswaPageStep,
                              icon: const Icon(Icons.expand_more),
                              label: const Text('Muat lebih banyak'),
                            ),
                          if (result.rows.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                'Menampilkan ${result.rows.length} mahasiswa sesuai akses Anda.',
                                style: text.bodySmall,
                              ),
                            ),
                        ],
                      ),
                      loading: () => const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (e, _) => ErrorState(
                        message: 'Pencarian belum dapat dimuat. $e',
                        onRetry: _refresh,
                      ),
                    ),
                    const SizedBox(height: 36),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'SIMAHA OFFLINE   /   Ruang untuk setiap langkah akademik.',
                      style: text.bodySmall,
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

class _StudentRow extends ConsumerWidget {
  const _StudentRow({
    required this.student,
    required this.wide,
    required this.canManage,
    required this.refresh,
  });
  final MahasiswaRow student;
  final bool wide;
  final bool canManage;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final name = student.nama.trim();
    return InkWell(
      onTap: () => context.push('/mahasiswa/${student.id}'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: wide ? 20 : 14, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                name.isEmpty ? '?' : name[0].toUpperCase(),
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    wide ? student.nim : '${student.nim} · ${student.angkatan}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (wide)
              SizedBox(
                width: 110,
                child: Text(
                  '${student.angkatan}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            StatusChip(label: student.status),
            if (canManage)
              PopupMenuButton<String>(
                tooltip: 'Aksi mahasiswa',
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit profil')),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Pindahkan ke sampah'),
                  ),
                ],
                onSelected: (action) async {
                  if (action == 'edit') {
                    final ok = await context.push<bool>(
                      '/mahasiswa/${student.id}/edit',
                    );
                    if (ok == true) refresh();
                    return;
                  }
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Hapus ${student.nama}?'),
                      content: const Text(
                        'Data akan dipindahkan ke tempat sampah dan dapat dipulihkan.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Batal'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Pindahkan'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed != true) return;
                  try {
                    await ref
                        .read(academicServiceProvider)
                        .softDeleteMahasiswa(student.id);
                    refresh();
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('$e')));
                    }
                  }
                },
              )
            else
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.chevron_right, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
