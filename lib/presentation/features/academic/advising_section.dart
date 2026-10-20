import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/domain/academic/academic_overview.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

final advisingNotesProvider = FutureProvider.autoDispose
    .family<List<AdvisingNote>, int>(
      (ref, id) => ref.watch(academicServiceProvider).advisingNotes(id),
    );

class AdvisingSection extends ConsumerStatefulWidget {
  const AdvisingSection({super.key, required this.studentId});
  final int studentId;
  @override
  ConsumerState<AdvisingSection> createState() => _AdvisingSectionState();
}

class _AdvisingSectionState extends ConsumerState<AdvisingSection> {
  bool _saving = false;
  Future<void> _add() async {
    final result = await showDialog<({String content, String followUp})>(
      context: context,
      builder: (_) => const _AdvisingDialog(),
    );
    if (result == null || !mounted) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(academicServiceProvider)
          .addAdvisingNote(
            studentId: widget.studentId,
            content: result.content,
            followUp: result.followUp,
          );
      ref.invalidate(advisingNotesProvider(widget.studentId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Catatan tersimpan dan dapat dibaca mahasiswa terkait.',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(sessionProvider).role;
    if (!{Role.superAdmin, Role.dosenWali, Role.mahasiswa}.contains(role)) {
      return const SizedBox.shrink();
    }
    final notes = ref.watch(advisingNotesProvider(widget.studentId));
    final theme = Theme.of(context);
    final canAdd = role != null && canRole(role, Permission.manageBimbingan);
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Catatan bimbingan', style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                role == Role.mahasiswa
                    ? 'Arahan dan tindak lanjut dari dosen wali Anda.'
                    : 'Catatan ini dapat dibaca mahasiswa yang bersangkutan.',
                style: theme.textTheme.bodySmall,
              ),
              if (canAdd)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: _saving ? null : _add,
                      icon: const Icon(Icons.note_add_outlined, size: 18),
                      label: Text(
                        _saving ? 'Menyimpan...' : 'Tambah catatan bimbingan',
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              notes.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Column(
                  children: [
                    Text('$e'),
                    TextButton(
                      onPressed: () => ref.invalidate(
                        advisingNotesProvider(widget.studentId),
                      ),
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
                data: (items) => items.isEmpty
                    ? const Text('Belum ada catatan bimbingan.')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final note in items)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${note.lecturer} / ${note.date.day.toString().padLeft(2, '0')}-${note.date.month.toString().padLeft(2, '0')}-${note.date.year}',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(note.content),
                                  if (note.followUp?.isNotEmpty ?? false) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tindak lanjut: ${note.followUp}',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdvisingDialog extends StatefulWidget {
  const _AdvisingDialog();
  @override
  State<_AdvisingDialog> createState() => _AdvisingDialogState();
}

class _AdvisingDialogState extends State<_AdvisingDialog> {
  final _form = GlobalKey<FormState>();
  final _content = TextEditingController();
  final _followUp = TextEditingController();
  @override
  void dispose() {
    _content.dispose();
    _followUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Catatan bimbingan baru'),
    content: SizedBox(
      width: 440,
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _content,
                minLines: 3,
                maxLines: 6,
                maxLength: 2000,
                decoration: const InputDecoration(
                  labelText: 'Catatan',
                  alignLabelWithHint: true,
                ),
                validator: (value) => (value?.trim().length ?? 0) < 5
                    ? 'Isi catatan minimal 5 karakter.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _followUp,
                minLines: 2,
                maxLines: 4,
                maxLength: 2000,
                decoration: const InputDecoration(
                  labelText: 'Tindak lanjut (opsional)',
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Batal'),
      ),
      FilledButton(
        onPressed: () {
          if (_form.currentState!.validate()) {
            Navigator.pop(context, (
              content: _content.text.trim(),
              followUp: _followUp.text.trim(),
            ));
          }
        },
        child: const Text('Simpan catatan'),
      ),
    ],
  );
}
