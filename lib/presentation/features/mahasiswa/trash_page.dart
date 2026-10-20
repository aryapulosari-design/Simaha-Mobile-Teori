import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/presentation/providers/app_providers.dart';

/// Tempat sampah soft-delete (FR-09): pulihkan atau biarkan terarsip.
class TrashPage extends ConsumerStatefulWidget {
  const TrashPage({super.key});

  @override
  ConsumerState<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends ConsumerState<TrashPage> {
  Future<List<MahasiswaRow>>? _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = ref.read(academicServiceProvider).trash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tempat Sampah')),
      body: FutureBuilder<List<MahasiswaRow>>(
        future: _future,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final rows = snap.data ?? const [];
          if (rows.isEmpty) {
            return const Center(
              child: Text('Sampah kosong. Data yang dihapus tampil di sini.'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => setState(_reload),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
              itemCount: rows.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (ctx, i) {
                final m = rows[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: Text(
                      m.nama,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text('${m.nim} • angk. ${m.angkatan}'),
                    trailing: TextButton(
                      onPressed: () async {
                        await ref
                            .read(academicServiceProvider)
                            .restoreMahasiswa(m.id);
                        ref
                          ..invalidate(dashboardCountsProvider)
                          ..invalidate(mahasiswaSearchProvider);
                        if (ctx.mounted) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(content: Text('${m.nama} dipulihkan.')),
                          );
                        }
                        setState(_reload);
                      },
                      child: const Text('Pulihkan'),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
