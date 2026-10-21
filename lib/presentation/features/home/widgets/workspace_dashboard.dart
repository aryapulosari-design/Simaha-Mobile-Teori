import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/data/services/insights_service.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/bento_card.dart';
import 'package:simaha/presentation/shared/widgets/error_state.dart';

class WorkspaceDashboard extends ConsumerWidget {
  const WorkspaceDashboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(workspaceOverviewProvider);
    final role = ref.watch(sessionProvider).role;
    return data.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => ErrorState(
        message: 'Ringkasan studi belum dapat dimuat.',
        onRetry: () => ref.invalidate(workspaceOverviewProvider),
      ),
      data: (d) => _Content(data: d, role: role!),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.data, required this.role});
  final WorkspaceOverview data;
  final Role role;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final self = role == Role.mahasiswa ? data.students.firstOrNull : null;
    final warning = data.students
        .where(
          (s) =>
              s.hasGrades &&
              (s.risk >= 30 ||
                  s.gpa < 2.5 ||
                  (s.attendance != null && s.attendance! < 75)),
        )
        .length;
    final attendance = data.attendance;
    final cards = self != null
        ? [
            MetricTile(
              label: 'IPK kumulatif',
              value: self.hasGrades ? self.gpa.toStringAsFixed(2) : '—',
              note: 'Skala 4.00 • nilai terbaik per MK',
              icon: Icons.trending_up,
              progress: self.hasGrades ? self.gpa / 4 : null,
            ),
            MetricTile(
              label: 'Beban studi',
              value: '${self.registeredCredits} SKS',
              note: '${data.classes.length} mata kuliah terdaftar',
              icon: Icons.auto_stories_outlined,
              indigo: true,
            ),
            MetricTile(
              label: 'Progres kelulusan',
              value: '${self.passedCredits} / ${data.requiredCredits}',
              note: 'SKS lulus dari syarat akademik',
              icon: Icons.school_outlined,
              progress: self.passedCredits / data.requiredCredits,
            ),
            MetricTile(
              label: 'Kehadiran saya',
              value: attendance == null
                  ? '—'
                  : '${attendance.toStringAsFixed(1)}%',
              note: '${data.present} hadir dari ${data.meetings} sesi tercatat',
              icon: Icons.check_circle_outline,
              progress: attendance == null ? null : attendance / 100,
            ),
          ]
        : [
            MetricTile(
              label: role == Role.dosenWali
                  ? 'Mahasiswa bimbingan'
                  : 'Kelas aktif',
              value: role == Role.dosenWali
                  ? '${data.students.length}'
                  : '${data.classes.length}',
              note: role == Role.dosenWali
                  ? 'Dalam lingkup perwalian Anda'
                  : 'Terhubung dengan akun Anda',
              icon: Icons.groups_outlined,
            ),
            MetricTile(
              label: 'Kelengkapan nilai',
              value: '${data.graded}/${data.registrations}',
              note: 'KRS yang sudah memiliki nilai',
              icon: Icons.fact_check_outlined,
              progress: data.registrations == 0
                  ? null
                  : data.graded / data.registrations,
              indigo: true,
            ),
            MetricTile(
              label: 'Kehadiran kuliah',
              value: attendance == null
                  ? '—'
                  : '${attendance.toStringAsFixed(1)}%',
              note: 'Dihitung dari peserta dalam akses Anda',
              icon: Icons.how_to_reg_outlined,
              progress: attendance == null ? null : attendance / 100,
            ),
            MetricTile(
              label: role == Role.dosenPengampu
                  ? 'Peserta terdaftar'
                  : 'Perlu pendampingan',
              value: role == Role.dosenPengampu
                  ? '${data.registrations}'
                  : '$warning',
              note: role == Role.dosenPengampu
                  ? 'Total keikutsertaan pada kelas Anda'
                  : 'IPK, kehadiran, atau skor risiko',
              icon: Icons.insights_outlined,
            ),
          ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BentoGrid(children: cards),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, box) {
            final schedule = BentoCard(
              accent: t.colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          role == Role.dosenPengampu
                              ? 'Jadwal mengajar'
                              : 'Jadwal perkuliahan',
                          style: t.textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Semua kelas',
                        onPressed: () => context.push('/akademik'),
                        icon: const Icon(Icons.arrow_forward, size: 20),
                      ),
                    ],
                  ),
                  Text(
                    data.classes.firstOrNull?.term ??
                        'Belum ada semester terhubung',
                    style: t.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  if (data.classes.isEmpty)
                    const Text('Kelas yang terhubung akan muncul di sini.'),
                  for (final c in data.classes.take(3))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: t.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => context.push('/kelas/${c.id}'),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 6,
                                  children: [
                                    ContextTag(
                                      '${c.day}  ${c.start}',
                                      icon: Icons.schedule,
                                    ),
                                    ContextTag('${c.credits} SKS'),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(c.name, style: t.textTheme.titleMedium),
                                const SizedBox(height: 4),
                                Text(
                                  '${c.lecturer} • ${c.room}',
                                  style: t.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  TextButton(
                    onPressed: () => context.push('/akademik'),
                    child: const Text('Lihat seluruh jadwal →'),
                  ),
                ],
              ),
            );
            final access = BentoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ruang akademik', style: t.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Lanjutkan aktivitas sesuai peran Anda.',
                    style: t.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  _Action(
                    icon: Icons.menu_book_outlined,
                    title: role == Role.mahasiswa
                        ? 'Mata kuliah & kehadiran'
                        : 'Kelas & rekap kehadiran',
                    subtitle: 'Jadwal, peserta, dan hasil perkuliahan',
                    route: '/akademik',
                  ),
                  if (self != null)
                    _Action(
                      icon: Icons.description_outlined,
                      title: 'Hasil studi & bimbingan',
                      subtitle: 'Nilai, simulasi, catatan wali, dan PDF',
                      route: '/mahasiswa/${self.id}',
                    ),
                  _Action(
                    icon: Icons.campaign_outlined,
                    title: 'Warta akademik',
                    subtitle: 'Informasi terbaru dari pengelola',
                    route: '/pengumuman',
                  ),
                  if (role == Role.superAdmin)
                    const _Action(
                      icon: Icons.manage_accounts_outlined,
                      title: 'Akun & hak akses',
                      subtitle: 'Hubungkan profil dan kelola PIN',
                      route: '/users',
                    ),
                  if (role == Role.superAdmin)
                    const _Action(
                      icon: Icons.history_outlined,
                      title: 'Jejak aktivitas',
                      subtitle: '100 aktivitas terakhir yang tercatat',
                      route: '/audit',
                    ),
                  const _Action(
                    icon: Icons.help_outline,
                    title: 'Panduan lima peran',
                    subtitle: 'Pahami fungsi dan hubungan antarakun',
                    route: '/panduan-peran',
                  ),
                ],
              ),
            );
            if (box.maxWidth < 740) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [schedule, const SizedBox(height: 12), access],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: schedule),
                const SizedBox(width: 12),
                Expanded(flex: 2, child: access),
              ],
            );
          },
        ),
        if (role == Role.dosenWali && data.students.isNotEmpty) ...[
          const SizedBox(height: 20),
          BentoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Prioritas pendampingan', style: t.textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(
                  'Urutan berdasarkan risiko. Skor membantu menentukan tindak lanjut bimbingan.',
                  style: t.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                for (final s in data.students.take(3))
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: t.colorScheme.surfaceContainerLow,
                      child: Text(s.name[0]),
                    ),
                    title: Text(s.name),
                    subtitle: Text(
                      'IPK ${s.hasGrades ? s.gpa.toStringAsFixed(2) : 'belum tersedia'} • Hadir ${s.attendance?.toStringAsFixed(0) ?? '—'}%',
                    ),
                    trailing: ContextTag('${s.risk.toStringAsFixed(0)}/100'),
                    onTap: () => context.push('/studi/${s.id}'),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });
  final IconData icon;
  final String title, subtitle, route;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 21, color: Theme.of(context).colorScheme.primary),
    ),
    title: Text(
      title,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    ),
    subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
    trailing: const Icon(Icons.arrow_outward, size: 16),
    onTap: () => context.push(route),
  );
}
