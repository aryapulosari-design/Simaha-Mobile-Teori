import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

/// Super Admin account management (service layer enforces RBAC too).
class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final role = session.role;
    if (role == null || !canRole(role, Permission.manageUsers)) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kelola Akun')),
        body: const Center(
          child: Text(
            'Akses ditolak.\nHanya Super Admin yang boleh mengelola akun.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final usersAsync = ref.watch(usersListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Akun')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreate(context, ref, session.user!.id),
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Tambah'),
      ),
      body: usersAsync.when(
        data: (users) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
          itemCount: users.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, i) =>
              _UserCard(user: users[i], selfId: session.user!.id),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal memuat: $e')),
      ),
    );
  }

  Future<void> _showCreate(
    BuildContext context,
    WidgetRef ref,
    int actorId,
  ) async {
    final userCtrl = TextEditingController();
    final pinCtrl = TextEditingController();
    Role role = Role.adminAkademik;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Akun baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: userCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<Role>(
                initialValue: role,
                decoration: const InputDecoration(labelText: 'Peran'),
                items: Role.values
                    .map(
                      (r) => DropdownMenuItem(value: r, child: Text(r.label)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => role = v ?? role),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: pinCtrl,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'PIN 6 digit',
                  counterText: '',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Buat'),
            ),
          ],
        ),
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      await ref
          .read(authServiceProvider)
          .createUser(
            actorId: actorId,
            username: userCtrl.text,
            role: role,
            pin: pinCtrl.text.trim(),
          );
      ref.invalidate(usersListProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'.replaceFirst('ValidationFailure: ', ''))),
        );
      }
    }
  }
}

final usersListProvider = FutureProvider<List<UserRow>>((ref) async {
  final me = ref.watch(sessionProvider).user;
  if (me == null) return [];
  return ref.read(authServiceProvider).listUsers(actorId: me.id);
});

class _UserCard extends ConsumerWidget {
  const _UserCard({required this.user, required this.selfId});
  final UserRow user;
  final int selfId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final role = Role.fromStorage(user.role);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: scheme.primary.withValues(alpha: 0.14),
                  child: Text(
                    user.username.isNotEmpty
                        ? user.username[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        role.label,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (user.isActive ? Colors.green.shade700 : scheme.error)
                            .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    user.isActive ? 'aktif' : 'nonaktif',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: user.isActive
                          ? Colors.green.shade800
                          : scheme.error,
                    ),
                  ),
                ),
              ],
            ),
            if (user.lockedUntil != null &&
                DateTime.now().isBefore(user.lockedUntil!)) ...[
              const SizedBox(height: 6),
              Text(
                'Terkunci + gagal ${user.failedAttempts}×',
                style: TextStyle(color: scheme.error, fontSize: 12),
              ),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: user.id == selfId
                      ? null
                      : () => _toggleActive(context, ref),
                  icon: Icon(
                    user.isActive
                        ? Icons.block_outlined
                        : Icons.check_circle_outline,
                    size: 16,
                  ),
                  label: Text(user.isActive ? 'Nonaktifkan' : 'Aktifkan'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _resetPin(context, ref),
                  icon: const Icon(Icons.pin_outlined, size: 16),
                  label: const Text('Reset PIN'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _toggleBiometric(context, ref),
                  icon: const Icon(Icons.fingerprint, size: 16),
                  label: Text(user.biometricEnabled ? 'Bio: on' : 'Bio: off'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleActive(BuildContext context, WidgetRef ref) async {
    final me = ref.read(sessionProvider).user!;
    try {
      await ref
          .read(authServiceProvider)
          .setUserActive(
            actorId: me.id,
            targetId: user.id,
            active: !user.isActive,
          );
      ref.invalidate(usersListProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  Future<void> _resetPin(BuildContext context, WidgetRef ref) async {
    final pinCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Reset PIN ${user.username}'),
        content: TextField(
          controller: pinCtrl,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'PIN baru 6 digit',
            counterText: '',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final me = ref.read(sessionProvider).user!;
    try {
      await ref
          .read(authServiceProvider)
          .resetPin(
            actorId: me.id,
            targetId: user.id,
            newPin: pinCtrl.text.trim(),
          );
      ref.invalidate(usersListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('PIN direset.')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'.replaceFirst('ValidationFailure: ', ''))),
        );
      }
    }
  }

  Future<void> _toggleBiometric(BuildContext context, WidgetRef ref) async {
    // Any user may toggle their own flag; admins may set it for managed
    // accounts (device itself must still support biometrics at unlock).
    await ref
        .read(authServiceProvider)
        .setBiometricEnabled(userId: user.id, enabled: !user.biometricEnabled);
    ref.invalidate(usersListProvider);
  }
}
