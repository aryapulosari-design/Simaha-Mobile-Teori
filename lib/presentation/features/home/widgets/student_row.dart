import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

class StudentRow extends ConsumerWidget {
  const StudentRow({
    super.key,
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
