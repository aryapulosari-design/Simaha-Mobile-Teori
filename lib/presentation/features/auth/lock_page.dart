import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

/// PIN lock screen: numeric pad, escalating lockout, biometric, recovery.
class LockPage extends ConsumerStatefulWidget {
  const LockPage({super.key});

  @override
  ConsumerState<LockPage> createState() => _LockPageState();
}

class _LockPageState extends ConsumerState<LockPage> {
  final _userCtrl = TextEditingController(text: 'superadmin');
  final _recoveryCtrl = TextEditingController();
  String _pin = '';
  String? _message;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _initLastUser();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _recoveryCtrl.dispose();
    super.dispose();
  }

  Future<void> _initLastUser() async {
    try {
      final last = await ref
          .read(lastUserStoreProvider)
          .read('simaha_last_user');
      if (last != null && last.isNotEmpty && mounted) {
        setState(() => _userCtrl.text = last);
      }
    } catch (_) {}
  }

  Future<void> _submit() async {
    if (_pin.length != 6 || _busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    final service = ref.read(authServiceProvider);
    final res = await service.verifyPin(_userCtrl.text.trim(), _pin);
    if (!mounted) return;
    setState(() => _busy = false);
    switch (res) {
      case Ok(value: final user):
        await ref
            .read(lastUserStoreProvider)
            .write('simaha_last_user', user.username);
        ref.read(sessionProvider.notifier).unlock(user);
        _pin = '';
      case Err(failure: final f):
        setState(() {
          _message = f.message;
          _pin = '';
        });
    }
  }

  Future<void> _showRecovery() async {
    _recoveryCtrl.clear();
    final code = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kode pemulihan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sekali pakai. Setelah dipakai, segera ganti PIN di Kelola Akun.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _recoveryCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'XXXX-XXXX-XXXX',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, _recoveryCtrl.text),
            child: const Text('Gunakan'),
          ),
        ],
      ),
    );
    if (code == null || code.trim().isEmpty || !mounted) return;
    setState(() => _busy = true);
    final res = await ref.read(authServiceProvider).consumeRecoveryCode(code);
    if (!mounted) return;
    setState(() => _busy = false);
    final messenger = ScaffoldMessenger.of(context);
    switch (res) {
      case Ok(value: final user):
        await ref
            .read(lastUserStoreProvider)
            .write('simaha_last_user', user.username);
        ref.read(sessionProvider.notifier).unlock(user);
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Pemulihan berhasil. Segera ganti PIN di Kelola Akun.',
            ),
          ),
        );
      case Err(failure: final f):
        setState(() => _message = f.message);
    }
  }

  /// Masuk darurat tanpa PIN: buat/pakai akun dev superadmin lalu buka kunci.
  /// Dipakai saat data akun rusak / PIN tidak diketahui.
  Future<void> _masukLangsung() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final service = ref.read(authServiceProvider);
      final user = await service.ensureDevUser(Role.superAdmin);
      await service.clearFailures(user.id);
      await ref
          .read(lastUserStoreProvider)
          .write('simaha_last_user', user.username);
      if (!mounted) return;
      ref.read(sessionProvider.notifier).unlock(user);
    } catch (e) {
      if (mounted) {
        setState(() => _message = 'Gagal masuk langsung: $e');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _press(String d) {
    if (_busy || _pin.length >= 6) return;
    HapticFeedback.lightImpact();
    setState(() => _pin += d);
    if (_pin.length == 6) unawaited(_submit());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.primary, scheme.tertiary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 380),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        color: scheme.onPrimaryContainer,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'SIMAHA Offline',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Masuk dengan PIN 6 digit',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _userCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // PIN dots.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (i) {
                        final filled = i < _pin.length;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          width: 18,
                          height: 18,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: filled
                                ? scheme.primary
                                : scheme.surfaceContainerHighest,
                            border: Border.all(
                              color: filled
                                  ? scheme.primary
                                  : scheme.outlineVariant,
                            ),
                          ),
                        );
                      }),
                    ),
                    if (_message != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _message!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: scheme.error,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    if (_busy)
                      const CircularProgressIndicator()
                    else
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.5,
                        children: [
                          for (final d in [
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                          ])
                            _Key(label: d, onTap: () => _press(d)),
                          _Key(
                            label: 'C',
                            onTap: () => setState(() => _pin = ''),
                          ),
                          _Key(label: '0', onTap: () => _press('0')),
                          _Key(
                            icon: Icons.backspace_outlined,
                            onTap: () => setState(
                              () => _pin = _pin.isEmpty
                                  ? ''
                                  : _pin.substring(0, _pin.length - 1),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _busy ? null : _showRecovery,
                      child: const Text('Lupa PIN?'),
                    ),
                    TextButton(
                      onPressed: _busy ? null : _masukLangsung,
                      child: const Text('Masuk langsung tanpa PIN'),
                    ),
                    Text(
                      'Offline 100% • upaya salah 5× mengunci sementara',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({this.label, this.icon, required this.onTap});
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Center(
          child: label != null
              ? Text(
                  label!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : Icon(icon, size: 22),
        ),
      ),
    );
  }
}
