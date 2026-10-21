import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:simaha/presentation/shared/widgets/bento_card.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

class StudyInsightPage extends ConsumerWidget {
  const StudyInsightPage({super.key, required this.studentId});
  final int studentId;
  @override
  Widget build(BuildContext context, WidgetRef ref) => WorkspacePage(
    title: 'Perkembangan studi',
    children: [
      ref
          .watch(workspaceOverviewProvider)
          .when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => ErrorState(message: '$e'),
            data: (workspace) {
              final student = workspace.students
                  .where((s) => s.id == studentId)
                  .firstOrNull;
              if (student == null) {
                return const ErrorState(
                  message: 'Data studi tidak tersedia dalam lingkup akun ini.',
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    student.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(student.nim),
                  const SizedBox(height: 24),
                  BentoGrid(
                    children: [
                      MetricTile(
                        label: 'IPK',
                        value: student.hasGrades
                            ? student.gpa.toStringAsFixed(2)
                            : '—',
                        note: 'Nilai terbaik per mata kuliah',
                        icon: Icons.school_outlined,
                      ),
                      MetricTile(
                        label: 'Kehadiran',
                        value:
                            '${student.attendance?.toStringAsFixed(1) ?? '—'}%',
                        note:
                            '${student.present}/${student.meetings} sesi tercatat',
                        icon: Icons.how_to_reg_outlined,
                      ),
                      MetricTile(
                        label: 'SKS lulus',
                        value: '${student.passedCredits}',
                        note: 'Syarat ${workspace.requiredCredits} SKS',
                        icon: Icons.check_circle_outline,
                      ),
                      MetricTile(
                        label: 'Skor risiko',
                        value: student.hasGrades
                            ? '${student.risk.toStringAsFixed(1)}/100'
                            : '—',
                        note: student.hasGrades
                            ? student.level.name.toUpperCase()
                            : 'Nilai belum tersedia',
                        icon: Icons.insights_outlined,
                        indigo: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BentoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hasil per semester',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        if (student.semesters.isEmpty)
                          const Text('Belum ada nilai semester.'),
                        for (final term in student.semesters.entries)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(term.key),
                            trailing: Text(term.value.toStringAsFixed(2)),
                          ),
                        const Divider(),
                        const SizedBox(height: 12),
                        const Text(
                          'Skor risiko menggabungkan IPK (40%), kehadiran (30%), tren IPS (20%), dan SKS tertinggal (10%). Riwayat satu semester belum memiliki tren. Target SKS per semester belum ditetapkan, sehingga kontribusi SKS tertinggal bernilai nol.',
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Aman <30 • Waspada 30–60 • Kritis >60. Skor ini membantu bimbingan dan bukan keputusan akademik.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => context.push('/mahasiswa/$studentId'),
                    icon: const Icon(Icons.person_outline),
                    label: const Text('Buka hasil studi & catatan bimbingan'),
                  ),
                ],
              );
            },
          ),
    ],
  );
}
