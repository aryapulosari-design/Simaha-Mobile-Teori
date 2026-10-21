import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/features/academic/academic_workspace_page.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/bento_card.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key, required this.classId});
  final int classId;
  @override
  ConsumerState<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  bool _busy = false;
  void _refresh() {
    ref
      ..invalidate(attendanceSessionsProvider(widget.classId))
      ..invalidate(academicClassProvider(widget.classId))
      ..invalidate(workspaceOverviewProvider);
  }

  Future<void> _create() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (date == null) return;
    setState(() => _busy = true);
    try {
      await ref.read(campusServiceProvider).createSession(widget.classId, date);
      _refresh();
    } catch (e) {
      _error(e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _error(Object e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _edit(int sessionId, String title) async {
    setState(() => _busy = true);
    try {
      final roster = await ref.read(
        academicClassProvider(widget.classId).future,
      );
      final values = await ref
          .read(campusServiceProvider)
          .attendance(sessionId);
      if (!mounted) return;
      final changes = await showDialog<Map<int, String>>(
        context: context,
        builder: (ctx) => _AttendanceDialog(
          title: title,
          students: {for (final s in roster.students) s.id: s.name},
          initial: values,
        ),
      );
      if (changes == null) return;
      await ref.read(campusServiceProvider).saveAttendance(sessionId, changes);
      _refresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Presensi tersimpan. Rekap seluruh peran diperbarui.',
            ),
          ),
        );
      }
    } catch (e) {
      _error(e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(sessionProvider).role;
    final manage = role != null && canRole(role, Permission.manageNilai);
    return WorkspacePage(
      title: 'Pertemuan & presensi',
      children: [
        Text(
          'Kehadiran yang terhubung',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Pilih pertemuan untuk mencatat kehadiran peserta kelas. Mahasiswa dan wali membaca hasilnya pada rekap kelas.',
        ),
        const SizedBox(height: 20),
        if (manage)
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: _busy ? null : _create,
              icon: const Icon(Icons.add),
              label: const Text('Tambah pertemuan'),
            ),
          ),
        if (_busy) const LinearProgressIndicator(),
        const SizedBox(height: 20),
        ref
            .watch(attendanceSessionsProvider(widget.classId))
            .when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => ErrorState(message: '$e', onRetry: _refresh),
              data: (items) => Column(
                children: [
                  if (items.isEmpty)
                    const EmptyState(
                      title: 'Belum ada pertemuan',
                      message: 'Pengampu atau admin dapat menambahkan pertemuan pertama.',
                    ),
                  for (final item in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.event_available_outlined),
                          title: Text('Pertemuan ${item.pertemuanKe}'),
                          subtitle: Text(
                            '${item.tanggal.day}/${item.tanggal.month}/${item.tanggal.year}',
                          ),
                          trailing: manage
                              ? const Icon(Icons.edit_outlined)
                              : null,
                          onTap: !manage || _busy
                              ? null
                              : () => _edit(
                                  item.id,
                                  'Pertemuan ${item.pertemuanKe}',
                                ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
      ],
    );
  }
}

class _AttendanceDialog extends StatefulWidget {
  const _AttendanceDialog({
    required this.title,
    required this.students,
    required this.initial,
  });
  final String title;
  final Map<int, String> students, initial;
  @override
  State<_AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<_AttendanceDialog> {
  late final Map<int, String> values = {...widget.initial};
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: SizedBox(
      width: 560,
      height: 400,
      child: ListView(
        children: [
          const Text(
            'Peserta tanpa pilihan belum akan disimpan. Pilih status berdasarkan kehadiran sebenarnya.',
          ),
          const SizedBox(height: 16),
          for (final entry in widget.students.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    entry.value,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: values[entry.key],
                    decoration: const InputDecoration(
                      labelText: 'Status kehadiran',
                    ),
                    items: [
                      for (final s in ['hadir', 'izin', 'sakit', 'alpa'])
                        DropdownMenuItem(value: s, child: Text(s)),
                    ],
                    onChanged: (v) {
                      if (v != null) values[entry.key] = v;
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Batal'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, values),
        child: const Text('Simpan presensi'),
      ),
    ],
  );
}
