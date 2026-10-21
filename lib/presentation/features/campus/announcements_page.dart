import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/campus_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/bento_card.dart';
import 'package:simaha/presentation/shared/widgets/shared_widgets.dart';

class AnnouncementsPage extends ConsumerWidget {
  const AnnouncementsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(sessionProvider).role;
    final manage = role != null && canRole(role, Permission.manageMaster);
    final t = Theme.of(context);
    return WorkspacePage(
      title: 'Warta akademik',
      actions: [
        IconButton(
          tooltip: 'Muat ulang',
          onPressed: () => ref.invalidate(announcementsProvider),
          icon: const Icon(Icons.refresh),
        ),
      ],
      children: [
        Text(
          'Informasi untuk satu komunitas',
          style: t.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Pengumuman pengelola tersimpan lokal dan dapat dibaca semua peran.',
          style: t.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        if (manage)
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: () => _publish(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Tulis pengumuman'),
            ),
          ),
        const SizedBox(height: 20),
        ref
            .watch(announcementsProvider)
            .when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => ErrorState(
                message: '$e',
                onRetry: () => ref.invalidate(announcementsProvider),
              ),
              data: (items) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (items.isEmpty)
                    const EmptyState(
                      title: 'Belum ada pengumuman',
                      message: 'Informasi dari pengelola akan muncul di sini.',
                    ),
                  for (final item in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: BentoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ContextTag(
                                  item.kategori.toUpperCase(),
                                  icon: Icons.campaign_outlined,
                                ),
                                ContextTag(
                                  '${item.updatedAt.day}/${item.updatedAt.month}/${item.updatedAt.year}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(item.judul, style: t.textTheme.titleLarge),
                            const SizedBox(height: 10),
                            SelectableText(item.isi),
                            if (manage)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                  ),
                                  label: const Text('Hapus'),
                                  onPressed: () async {
                                    final ok = await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Hapus pengumuman?'),
                                        content: Text(item.judul),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, false),
                                            child: const Text('Batal'),
                                          ),
                                          FilledButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, true),
                                            child: const Text('Hapus'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (ok != true) return;
                                    try {
                                      await ref
                                          .read(campusServiceProvider)
                                          .deleteAnnouncement(item.id);
                                      ref.invalidate(announcementsProvider);
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                              SnackBar(content: Text('$e')),
                                            );
                                      }
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
      ],
    );
  }

  Future<void> _publish(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<(String, String, String)>(
      context: context,
      builder: (_) => const _AnnouncementDialog(),
    );
    if (result == null || !context.mounted) return;
    try {
      await ref
          .read(campusServiceProvider)
          .publish(result.$1, result.$2, result.$3);
      ref.invalidate(announcementsProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }
}

class _AnnouncementDialog extends StatefulWidget {
  const _AnnouncementDialog();
  @override
  State<_AnnouncementDialog> createState() => _AnnouncementDialogState();
}

class _AnnouncementDialogState extends State<_AnnouncementDialog> {
  final _title = TextEditingController(), _body = TextEditingController();
  final _key = GlobalKey<FormState>();
  String _category = 'akademik';
  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Tulis pengumuman'),
    content: SizedBox(
      width: 460,
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _title,
                maxLength: 120,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (v) => (v?.trim().length ?? 0) < 5
                    ? 'Judul minimal 5 karakter.'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: [
                  for (final c in ['akademik', 'bimbingan', 'umum'])
                    DropdownMenuItem(value: c, child: Text(c)),
                ],
                onChanged: (v) => _category = v!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _body,
                minLines: 3,
                maxLines: 7,
                maxLength: 3000,
                decoration: const InputDecoration(labelText: 'Isi pengumuman'),
                validator: (v) => (v?.trim().length ?? 0) < 10
                    ? 'Isi minimal 10 karakter.'
                    : null,
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
          if (_key.currentState!.validate()) {
            Navigator.pop(context, (_title.text, _body.text, _category));
          }
        },
        child: const Text('Terbitkan'),
      ),
    ],
  );
}

class AuditTrailPage extends ConsumerWidget {
  const AuditTrailPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => WorkspacePage(
    title: 'Jejak aktivitas',
    children: [
      Text(
        'Aktivitas yang tercatat',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 8),
      const Text(
        'Menampilkan 100 catatan terbaru untuk membantu pemeriksaan perubahan.',
      ),
      const SizedBox(height: 20),
      ref
          .watch(auditTrailProvider)
          .when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => ErrorState(message: '$e'),
            data: (rows) => Column(
              children: [
                for (final row in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.history),
                        title: Text('${row.aksi} • ${row.entitas}'),
                        subtitle: Text(
                          '${row.waktu.toLocal()}\nAkun #${row.userId ?? 'sistem'} • Data #${row.entitasId ?? '—'}',
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  ),
                if (rows.isEmpty)
                  const EmptyState(
                    title: 'Belum ada aktivitas',
                    message: 'Perubahan yang dicatat akan muncul di sini.',
                  ),
              ],
            ),
          ),
    ],
  );
}
