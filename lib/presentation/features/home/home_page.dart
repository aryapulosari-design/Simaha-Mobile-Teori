import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/dashboard_widgets.dart';

/// Tahap A dashboard: header, stats, FTS search, paginated list.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Color _statusColor(BuildContext context, String status) {
    final scheme = Theme.of(context).colorScheme;
    return switch (status) {
      'aktif' => scheme.primary,
      'cuti' => scheme.tertiary,
      'lulus' => Colors.green,
      'do' || 'nonaktif' => scheme.error,
      _ => scheme.secondary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final counts = ref.watch(dashboardCountsProvider);
    final search = ref.watch(mahasiswaSearchProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [scheme.primary, scheme.tertiary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SIMAHA Offline'),
                Text(
                  'Sistem Informasi Mahasiswa',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Tempat sampah',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => context.push('/trash'),
          ),
          IconButton(
            tooltip: 'Kunci sekarang',
            icon: const Icon(Icons.lock_outline),
            onPressed: () => ref.read(sessionProvider.notifier).lock(),
          ),
          IconButton(
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                ..invalidate(dashboardCountsProvider)
                ..invalidate(mahasiswaSearchProvider);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final ok = await context.push<bool>('/mahasiswa/baru');
          if (ok == true) {
            ref
              ..invalidate(dashboardCountsProvider)
              ..invalidate(mahasiswaSearchProvider);
          }
        },
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Tambah'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(dashboardCountsProvider)
            ..invalidate(mahasiswaSearchProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            // Greeting hero.
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [scheme.primary, scheme.primary.withBlue(220)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.3),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang 👋',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Data akademik\naman & offline.',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                                letterSpacing: -0.4,
                              ),
                        ),
                        const SizedBox(height: 10),
                        counts.when(
                          data: (c) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '${c.total} mahasiswa • ${c.aktif} aktif',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          loading: () => const SizedBox(
                            width: 120,
                            child: LinearProgressIndicator(color: Colors.white),
                          ),
                          error: (_, _) => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 44,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            search.when(
              data: (r) => SecurityBanner(searchMs: r.elapsedMs),
              loading: () => const SecurityBanner(),
              error: (_, _) => const SecurityBanner(),
            ),
            const SizedBox(height: 18),
            const SectionHeader(
              title: 'Ringkasan',
              subtitle: 'Fondasi Tahap A • 100 data dummy',
            ),
            const SizedBox(height: 10),
            counts.when(
              data: (c) => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.35,
                children: [
                  StatCard(
                    label: 'Mahasiswa',
                    value: '${c.total}',
                    icon: Icons.people_outline,
                    color: scheme.primary,
                    semanticsLabel: 'Total ${c.total} mahasiswa',
                  ),
                  StatCard(
                    label: 'Aktif',
                    value: '${c.aktif}',
                    icon: Icons.verified_outlined,
                    color: Colors.green.shade700,
                    semanticsLabel: '${c.aktif} mahasiswa aktif',
                  ),
                  StatCard(
                    label: 'Prodi',
                    value: '${c.prodi}',
                    icon: Icons.apartment_outlined,
                    color: scheme.tertiary,
                  ),
                  StatCard(
                    label: 'Dosen & Kelas',
                    value: '${c.dosen}/${c.kelas}',
                    icon: Icons.meeting_room_outlined,
                    color: Colors.deepOrange.shade600,
                  ),
                ],
              ),
              loading: () => const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (e, _) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Gagal memuat ringkasan: $e'),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SectionHeader(
              title: 'Mahasiswa',
              subtitle: 'Pencarian FTS5 nama / NIM',
              trailing: search.when(
                data: (r) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (r.elapsedMs <= 500
                                ? Colors.green.shade700
                                : scheme.error)
                            .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${r.elapsedMs} ms',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: r.elapsedMs <= 500
                          ? Colors.green.shade800
                          : scheme.error,
                    ),
                  ),
                ),
                loading: () => const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 10),
            Semantics(
              label: 'Pencarian mahasiswa berdasarkan nama atau NIM',
              child: TextField(
                controller: _searchCtrl,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Cari nama / NIM… mis. "Ahmad" / "202201"',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          tooltip: 'Bersihkan',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchCtrl.clear();
                            ref.read(mahasiswaQueryProvider.notifier).state =
                                '';
                            ref.read(mahasiswaLimitProvider.notifier).state =
                                kMahasiswaPageStep;
                          },
                        )
                      : null,
                ),
                onChanged: (v) {
                  ref.read(mahasiswaQueryProvider.notifier).state = v;
                  // New query restarts lazy loading from the first page.
                  ref.read(mahasiswaLimitProvider.notifier).state =
                      kMahasiswaPageStep;
                },
              ),
            ),
            const SizedBox(height: 10),
            search.when(
              data: (r) => Column(
                children: [
                  _MahasiswaList(rows: r.rows, statusColor: _statusColor),
                  // Lazy loading: rows arrive in pages of kMahasiswaPageStep.
                  // A full page hints more rows may exist (Tahap C adds counts).
                  if (r.rows.length >= r.limit)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ref.read(mahasiswaLimitProvider.notifier).state =
                                r.limit + kMahasiswaPageStep;
                          },
                          icon: const Icon(Icons.expand_more),
                          label: Text(
                            'Muat lagi (menampilkan ${r.rows.length})',
                          ),
                        ),
                      ),
                    )
                  else if (r.rows.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Menampilkan ${r.rows.length} data — semua sudah dimuat.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
              loading: () => const Card(
                child: Padding(
                  padding: EdgeInsets.all(28),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (e, _) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Pencarian gagal: $e'),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: scheme.primary),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Auth & PIN, KRS, presensi QR, dan analitik risiko '
                        'dibangun di Tahap B–G. Tahap ini mengunci fondasi: '
                        'enkripsi, migrasi, dan seeder.',
                        style: TextStyle(fontSize: 12, height: 1.5),
                      ),
                    ),
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

class _MahasiswaList extends ConsumerWidget {
  const _MahasiswaList({required this.rows, required this.statusColor});

  final List<MahasiswaRow> rows;
  final Color Function(BuildContext, String) statusColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (rows.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Icon(
                Icons.person_search_outlined,
                size: 44,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 10),
              const Text(
                'Tidak ada hasil.',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                'Coba kata kunci lain atau kosongkan untuk 20 teratas.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rows.length,
          separatorBuilder: (_, _) => const Divider(height: 1, indent: 64),
          itemBuilder: (context, i) {
            final m = rows[i];
            final c = statusColor(context, m.status);
            return ListTile(
              onTap: () => context.push('/mahasiswa/${m.id}'),
              leading: CircleAvatar(
                backgroundColor: c.withValues(alpha: 0.14),
                child: Text(
                  m.nama.isNotEmpty ? m.nama[0].toUpperCase() : '?',
                  style: TextStyle(color: c, fontWeight: FontWeight.w800),
                ),
              ),
              title: Text(
                m.nama,
                style: const TextStyle(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${m.nim} • angk. ${m.angkatan}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      m.status,
                      style: TextStyle(
                        color: c,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    tooltip: 'Aksi',
                    onSelected: (v) => _aksi(context, ref, v, m),
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'detail',
                        child: Text('Detail & nilai'),
                      ),
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'hapus', child: Text('Hapus')),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _aksi(
    BuildContext context,
    WidgetRef ref,
    String v,
    MahasiswaRow m,
  ) async {
    final db = ref.read(appDatabaseProvider);
    switch (v) {
      case 'detail':
        context.push('/mahasiswa/${m.id}');
      case 'edit':
        final ok = await context.push<bool>('/mahasiswa/${m.id}/edit');
        if (ok == true) {
          ref
            ..invalidate(dashboardCountsProvider)
            ..invalidate(mahasiswaSearchProvider);
        }
      case 'hapus':
        final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Hapus ${m.nama}?'),
            content: const Text(
              'Data dipindah ke Tempat Sampah dan bisa dipulihkan.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Hapus'),
              ),
            ],
          ),
        );
        if (ok == true) {
          await db.softDeleteMahasiswa(m.id);
          ref
            ..invalidate(dashboardCountsProvider)
            ..invalidate(mahasiswaSearchProvider);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dipindah ke sampah.')),
            );
          }
        }
    }
  }
}
