import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/presentation/shared/widgets/dashboard_widgets.dart';

final _syaratSksProvider = FutureProvider<int>((ref) async {
  // Tahan tanpa DB (widget test): fallback 144 agar halaman tetap render.
  try {
    final db = ref.watch(appDatabaseProvider);
    return await db.getSyaratSksLulus();
  } catch (_) {
    return 144;
  }
});

/// Settings (+ entry to account management for permitted roles).
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final role = ref.watch(sessionProvider).role;
    final me = ref.watch(sessionProvider).user;
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.primaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Default Tahap A',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'PIN, lockout, auto-lock, dan RBAC aktif. '
                        'Ganti akun via Kunci + masuk PIN akun lain.',
                        style: TextStyle(fontSize: 12, height: 1.45),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Akun & keamanan',
            subtitle: 'Sesi perangkat ini',
          ),
          const SizedBox(height: 10),
          _Group(
            children: [
              _Tile(
                icon: Icons.person_outline,
                title: me?.username ?? '-',
                subtitle: role?.label ?? 'Belum masuk',
                trailing: 'keluar',
                onTap: () => ref.read(sessionProvider.notifier).lock(),
              ),
              if (role != null && canRole(role, Permission.manageUsers))
                _Tile(
                  icon: Icons.manage_accounts_outlined,
                  title: 'Kelola akun',
                  subtitle: 'Tambah, nonaktifkan, reset PIN',
                  trailing: 'buka',
                  onTap: () => context.go('/users'),
                ),
              _Tile(
                icon: Icons.lock_outline,
                title: 'Kunci sekarang',
                subtitle: 'Butuh PIN untuk membuka lagi',
                trailing: 'kunci',
                onTap: () => ref.read(sessionProvider.notifier).lock(),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Kelulusan (FR-37/51)',
            subtitle: 'Syarat SKS — bisa diubah, tersimpan di database',
          ),
          const SizedBox(height: 10),
          _Group(
            children: [
              const _SyaratSksTile(),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Akademik',
            subtitle: 'Bobot, batas SKS, rentang huruf',
          ),
          const SizedBox(height: 10),
          _Group(
            children: [
              _Tile(
                icon: Icons.scale_outlined,
                title: 'Bobot nilai',
                subtitle: 'Tugas 30% • UTS 30% • UAS 40%',
                trailing: '100%',
              ),
              _Tile(
                icon: Icons.credit_card_outlined,
                title: 'Batas SKS semester 1',
                subtitle: 'Tanpa IPS sebelumnya (default)',
                trailing: '$kDefaultFirstSemesterSksCap SKS',
              ),
              const _Tile(
                icon: Icons.grade_outlined,
                title: 'Rentang huruf',
                subtitle: 'A ≥85 • AB ≥80 • B ≥75 • BC ≥70 • C ≥60 • D ≥50',
              ),
              _Tile(
                icon: Icons.table_chart_outlined,
                title: 'Batas SKS per IPS',
                subtitle: '≥3.00→24 • 2.50→21 • 2.00→18 • <2.00→15',
                trailing: 'otomatis',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Keamanan',
            subtitle: 'Kunci otomatis & notifikasi',
          ),
          const SizedBox(height: 10),
          _Group(
            children: [
              _Tile(
                icon: Icons.timer_outlined,
                title: 'Auto-lock',
                subtitle: 'Kunci saat idle / background',
                trailing: '$kDefaultAutoLockMinutes mnt',
              ),
              _Tile(
                icon: Icons.pin_outlined,
                title: 'PIN salah',
                subtitle: 'Kunci sementara bertahap 1-15 menit',
                trailing: 'maks $kMaxPinFailures×',
              ),
              const _Tile(
                icon: Icons.fingerprint,
                title: 'Biometrik',
                subtitle: 'Opsional berikutnya (butuh plugin local_auth)',
                trailing: 'PIN',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Risiko & bahasa',
            subtitle: 'Ambang + bahasa tampilan',
          ),
          const SizedBox(height: 10),
          const _Group(
            children: [
              _Tile(
                icon: Icons.warning_amber_outlined,
                title: 'Ambang risiko',
                subtitle: '<30 Aman • 30–60 Waspada • >60 Kritis',
              ),
              _Tile(
                icon: Icons.language_outlined,
                title: 'Bahasa',
                subtitle: 'Indonesia (EN menyusul via l10n)',
                trailing: 'ID',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: children.length,
          separatorBuilder: (_, _) => const Divider(height: 1, indent: 58),
          itemBuilder: (_, i) => children[i],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: scheme.secondaryContainer.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: scheme.onSecondaryContainer),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: trailing == null
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                trailing!,
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
    );
  }
}

/// Syarat SKS lulus yang bisa diedit (FR-51).
/// Tahan tanpa DB: fallback 144 agar halaman tetap render di widget test.
class _SyaratSksTile extends ConsumerWidget {
  const _SyaratSksTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syarat = ref.watch(_syaratSksProvider);
    final label = syarat.when(
      data: (v) => '$v SKS',
      loading: () => '…',
      error: (_, _) => '144 SKS',
    );
    return _Tile(
      icon: Icons.school_outlined,
      title: 'Syarat SKS lulus',
      subtitle: 'Dipakai progres kelulusan & status',
      trailing: label,
      onTap: syarat.hasValue
          ? () async {
              final db = ref.read(appDatabaseProvider);
              final cur = await db.getSyaratSksLulus();
              if (!context.mounted) return;
              final ctrl = TextEditingController(text: cur.toString());
              final res = await showDialog<String>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Syarat SKS lulus'),
                  content: TextField(
                    controller: ctrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah SKS (mis. 144)',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Batal'),
                    ),
                    FilledButton(
                      onPressed: () =>
                          Navigator.pop(ctx, ctrl.text.trim()),
                      child: const Text('Simpan'),
                    ),
                  ],
                ),
              );
              if (res == null || !context.mounted) return;
              final n = int.tryParse(res);
              if (n == null || n <= 0 || n > 300) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Harus angka 1-300.')),
                );
                return;
              }
              await db.setSetting('syarat_sks_lulus', '$n');
              ref.invalidate(_syaratSksProvider);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Syarat SKS disimpan: $n.')),
                );
              }
            }
          : null,
    );
  }
}
