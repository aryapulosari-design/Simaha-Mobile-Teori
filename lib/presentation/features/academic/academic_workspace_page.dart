import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/domain/academic/academic_overview.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

final academicClassesProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(academicServiceProvider).classes(),
);
final academicClassProvider = FutureProvider.autoDispose
    .family<AcademicClassDetail, int>(
      (ref, id) => ref.watch(academicServiceProvider).classDetail(id),
    );

class AcademicWorkspacePage extends ConsumerWidget {
  const AcademicWorkspacePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(sessionProvider).role;
    final classes = ref.watch(academicClassesProvider);
    final theme = Theme.of(context);
    final title = switch (role) {
      Role.dosenPengampu => 'Kelas yang Anda ampu',
      Role.dosenWali => 'Perkuliahan mahasiswa bimbingan',
      Role.mahasiswa => 'Jadwal & mata kuliah saya',
      _ => 'Kelas & dosen',
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akademik'),
        actions: [
          if (role != null && canRole(role, Permission.manageMaster))
            TextButton.icon(
              onPressed: () => context.push('/master'),
              icon: const Icon(Icons.edit_note),
              label: const Text('Data master'),
            ),
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: () => ref.invalidate(academicClassesProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: classes.when(
        loading: () => const LoadingView(message: 'Memuat kelas dan jadwal...'),
        error: (e, _) => ErrorState(
          message: '$e',
          onRetry: () => ref.invalidate(academicClassesProvider),
        ),
        data: (items) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(title, style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 12),
                    Text(
                      role == Role.mahasiswa
                          ? 'Dosen, jadwal, nilai, dan rekap kehadiran mata kuliah yang Anda ambil.'
                          : role == Role.dosenWali
                          ? 'Jumlah peserta dan nilai berikut hanya menghitung mahasiswa bimbingan Anda.'
                          : 'Buka kelas untuk melihat peserta, nilai, dan rekap kehadiran sesuai akses Anda.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    if (items.isEmpty)
                      const EmptyState(
                        title: 'Belum ada kelas terhubung',
                        message: 'Data kelas mengikuti hubungan dosen, mahasiswa, dan KRS yang tersimpan.',
                      ),
                    for (final item in items)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => context.push('/kelas/${item.id}'),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item.code} / ${item.credits} SKS',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.name,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Dosen: ${item.lecturer}'),
                                  Text(
                                    '${item.day}, ${item.start} - ${item.end} / ${item.room}',
                                  ),
                                  Text(
                                    item.term,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 20,
                                    runSpacing: 8,
                                    children: [
                                      if (role != Role.mahasiswa)
                                        Text(
                                          '${item.studentCount} mahasiswa dalam akses Anda',
                                        ),
                                      Text(
                                        '${role == Role.mahasiswa ? 'Nilai saya' : 'Rata-rata nilai'}: ${item.average?.toStringAsFixed(1) ?? 'Belum diisi'}',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          role == Role.mahasiswa
                                              ? 'Lihat nilai & kehadiran'
                                              : 'Buka daftar mahasiswa',
                                          style: TextStyle(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 18,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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

class AcademicClassPage extends ConsumerWidget {
  const AcademicClassPage({super.key, required this.classId});
  final int classId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(academicClassProvider(classId));
    final role = ref.watch(sessionProvider).role;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail kelas'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: () {
              ref.invalidate(academicClassProvider(classId));
              ref.invalidate(academicClassesProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: data.when(
        loading: () => const LoadingView(message: 'Memuat peserta kelas...'),
        error: (e, _) => ErrorState(
          message: '$e',
          onRetry: () => ref.invalidate(academicClassProvider(classId)),
        ),
        data: (detail) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      detail.info.name,
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${detail.info.code} / ${detail.info.credits} SKS / ${detail.info.term}',
                    ),
                    Text('Pengampu: ${detail.info.lecturer}'),
                    Text(
                      '${detail.info.day}, ${detail.info.start} - ${detail.info.end} / ${detail.info.room}',
                    ),
                    const SizedBox(height: 16),
                    if (role == Role.superAdmin ||
                        role == Role.adminAkademik ||
                        role == Role.dosenPengampu)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FilledButton.icon(
                          onPressed: () => context.push('/presensi/$classId'),
                          icon: const Icon(Icons.fact_check_outlined),
                          label: const Text('Kelola presensi'),
                        ),
                      ),
                    const SizedBox(height: 24),
                    Text(
                      role == Role.mahasiswa
                          ? 'Hasil & kehadiran saya'
                          : 'Mahasiswa dalam lingkup Anda',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      role == Role.dosenPengampu
                          ? 'Pilih mahasiswa, lalu gunakan Input / Edit untuk memperbarui nilai mata kuliah ini.'
                          : role == Role.dosenWali
                          ? 'Pilih mahasiswa untuk melihat hasil studi dan menambahkan catatan bimbingan.'
                          : 'Pilih mahasiswa untuk membuka profil dan rincian nilai.',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    if (detail.students.isEmpty)
                      const EmptyState(
                        title: 'Belum ada peserta',
                        message: 'KRS mahasiswa akan muncul di sini.',
                      ),
                    for (final student in detail.students)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () =>
                                context.push('/mahasiswa/${student.id}'),
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              student.name,
                                              style:
                                                  theme.textTheme.titleMedium,
                                            ),
                                            Text(
                                              student.nim,
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        student.letter ?? '-',
                                        style: theme.textTheme.headlineSmall,
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.chevron_right, size: 18),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 16,
                                    runSpacing: 8,
                                    children: [
                                      Text(
                                        'Nilai: ${student.score?.toStringAsFixed(1) ?? 'Belum diisi'}',
                                      ),
                                      Text(
                                        student.meetings == 0
                                            ? 'Belum ada pertemuan'
                                            : 'Hadir ${student.present}/${student.meetings} pertemuan',
                                      ),
                                      Text(
                                        'Izin ${student.excused} / Sakit ${student.sick} / Alpa ${student.absent}',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
