import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/shared/widgets/dashboard_widgets.dart';

/// Shows DB encryption facts for Tahap A verification (never shows the key).
class DbInfoPage extends ConsumerWidget {
  const DbInfoPage({super.key, required this.dbPath});

  final String dbPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(dashboardCountsProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Database')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  scheme.tertiaryContainer,
                  scheme.primaryContainer.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Terenkripsi • SQLCipher',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'AES-256 • kunci 256-bit acak di Keystore. '
                        'Tanpa kunci: "file is not a database".',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.45,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          counts.when(
            data: (c) => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.45,
              children: [
                StatCard(
                  label: 'Mahasiswa',
                  value: '${c.total}',
                  icon: Icons.people_outline,
                ),
                StatCard(
                  label: 'Aktif',
                  value: '${c.aktif}',
                  icon: Icons.verified_outlined,
                  color: Colors.green.shade700,
                ),
                StatCard(
                  label: 'Prodi • Dosen',
                  value: '${c.prodi} • ${c.dosen}',
                  icon: Icons.apartment_outlined,
                  color: scheme.tertiary,
                ),
                StatCard(
                  label: 'Kelas aktif',
                  value: '${c.kelas}',
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
                child: Text('Gagal membaca: $e'),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const SectionHeader(
            title: 'Berkas & kunci',
            subtitle: 'Kunci tidak pernah ditampilkan',
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Row(label: 'Nama file', value: kDatabaseFileName),
                  const SizedBox(height: 8),
                  const Text(
                    'Lokasi file',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(dbPath, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: dbPath),
                            );
                          },
                          icon: const Icon(Icons.copy, size: 16),
                          label: const Text('Salin path'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            ref
                              ..invalidate(dashboardCountsProvider)
                              ..invalidate(mahasiswaSearchProvider);
                          },
                          icon: const Icon(Icons.refresh, size: 16),
                          label: const Text('Muat ulang'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const SectionHeader(
            title: 'Cara verifikasi',
            subtitle: 'Bukti enkripsi Tahap A',
          ),
          const SizedBox(height: 10),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '1. Jalankan: flutter test test/encryption_test.dart\n'
                '2. Tes membuka file .db tanpa PRAGMA key → gagal.\n'
                '3. Tes kunci salah → "file is not a database".\n'
                '4. Tes kunci benar → data terbaca kembali.',
                style: TextStyle(fontSize: 12, height: 1.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
