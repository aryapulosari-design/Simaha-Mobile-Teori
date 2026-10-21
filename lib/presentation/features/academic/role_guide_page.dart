import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/core/config/app_runtime.dart';
import 'package:simaha/domain/security/role_guide.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

class RolePurposeCard extends ConsumerWidget {
  const RolePurposeCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(sessionProvider).role;
    if (role == null) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tugas Anda sebagai ${role.label}',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(role.purpose),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () => context.push('/akademik'),
                  icon: const Icon(Icons.menu_book_outlined, size: 18),
                  label: Text(
                    role == Role.dosenPengampu
                        ? 'Buka kelas saya'
                        : role == Role.mahasiswa
                        ? 'Jadwal & mata kuliah'
                        : 'Lihat kelas & dosen',
                  ),
                ),
                TextButton.icon(
                  onPressed: () => context.push('/panduan-peran'),
                  icon: const Icon(Icons.help_outline, size: 18),
                  label: const Text('Semua fungsi peran'),
                ),
                OutlinedButton.icon(
                  onPressed: () => ref.read(sessionProvider.notifier).lock(),
                  icon: const Icon(Icons.switch_account_outlined, size: 18),
                  label: const Text('Ganti akun'),
                ),
              ],
            ),
            if (AppRuntime.isDemo) ...[
              const SizedBox(height: 12),
              Text(
                'DEMO: 5 dosen, 50 mahasiswa, 5 kelas. Semua akun sudah terhubung.',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class RoleGuidePage extends ConsumerWidget {
  const RoleGuidePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(sessionProvider).role;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Fungsi setiap peran')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Satu data, tanggung jawab berbeda.',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Super Admin menyiapkan akun dan hubungan profil. Admin Akademik mengelola data studi. Dosen Pengampu mengisi nilai kelas. Dosen Wali mendampingi mahasiswa. Mahasiswa membaca hasil dan arahan yang sama.',
                  ),
                  if (AppRuntime.isDemo) ...[
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alur contoh yang bisa langsung dicoba',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              '1. Pengampu Rahma membuka Algoritma dan mengubah nilai Alya.\n2. Mahasiswa Alya melihat nilai yang berubah.\n3. Wali Rahma melihat hasil studi Alya dan menambahkan catatan.\n4. Alya membaca catatan yang sama.\n5. Admin Akademik dapat memeriksa seluruh data tersebut.',
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Lima dosen masing-masing mengajar satu mata kuliah untuk seluruh 50 mahasiswa. Tiap dosen juga membimbing sepuluh mahasiswa melalui akun Wali. PIN awal semua akun: 123456.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  for (final role in Role.values)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    role.label,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  if (active == role)
                                    const Chip(label: Text('Peran Anda')),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(role.purpose),
                              const SizedBox(height: 12),
                              for (final action in role.availableActions)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 18,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(child: Text(action)),
                                    ],
                                  ),
                                ),
                              const Divider(),
                              const SizedBox(height: 12),
                              Text(
                                role.boundary,
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  FilledButton.icon(
                    onPressed: () => ref.read(sessionProvider.notifier).lock(),
                    icon: const Icon(Icons.switch_account_outlined),
                    label: const Text('Ganti akun untuk mencoba peran lain'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
