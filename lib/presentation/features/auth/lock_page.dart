import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/core/security/flag_secure.dart';
import 'package:simaha/core/config/app_runtime.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/domain/security/login_account.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

/// Choose a local role/account, then verify that account's PIN.
class LockPage extends ConsumerStatefulWidget {
  const LockPage({super.key});
  @override
  ConsumerState<LockPage> createState() => _LockPageState();
}

class _LockPageState extends ConsumerState<LockPage> {
  final _recoveryCtrl = TextEditingController();
  List<LoginAccount> _accounts = [];
  LoginAccount? _account;
  Role _role = Role.superAdmin;
  String _pin = '';
  String? _message;
  String? _loadError;
  bool _loading = true;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  @override
  void dispose() {
    _recoveryCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAccounts() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final accounts = await ref.read(authServiceProvider).listLoginAccounts();
      String? last;
      try {
        last = await ref.read(lastUserStoreProvider).read('simaha_last_user');
      } catch (_) {
        /* Remembering the account is optional. */
      }
      if (!mounted) return;
      LoginAccount? selected;
      for (final account in accounts) {
        if (account.username == last) {
          selected = account;
          break;
        }
      }
      selected ??= accounts.where((a) => a.role == Role.superAdmin).firstOrNull;
      selected ??= accounts.firstOrNull;
      setState(() {
        _accounts = accounts;
        _account = selected;
        _role = selected?.role ?? Role.superAdmin;
        _pin = '';
        _message = null;
        _loading = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadError = 'Daftar akun belum dapat dimuat.';
        });
      }
    }
  }

  void _chooseRole(Role role) {
    setState(() {
      _role = role;
      _account = _accounts.where((a) => a.role == role).firstOrNull;
      _pin = '';
      _message = null;
    });
  }

  void _chooseAccount(int? id) {
    setState(() {
      _account = _accounts
          .where((a) => a.id == id && a.role == _role)
          .firstOrNull;
      _pin = '';
      _message = null;
    });
  }

  Future<void> _rememberAndUnlock(UserRow user) async {
    try {
      await ref
          .read(lastUserStoreProvider)
          .write('simaha_last_user', user.username);
    } catch (_) {
      /* A failed convenience setting must not prevent login. */
    }
    if (!mounted) return;
    ref.read(sessionProvider.notifier).unlock(user);
  }

  Future<void> _submit() async {
    final account = _account;
    if (_pin.length != 6 || _busy || account == null) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final res = await ref
          .read(authServiceProvider)
          .verifyPin(account.username, _pin);
      if (!mounted) return;
      switch (res) {
        case Ok(value: final user):
          await _rememberAndUnlock(user);
        case Err(failure: final f):
          setState(() => _message = f.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _message = 'Belum dapat masuk. Silakan coba lagi.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _pin = '';
        });
      }
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
              'Gunakan kode pemulihan Super Admin yang disimpan saat setup. Setelah masuk, ganti PIN di Kelola akun.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _recoveryCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'XXXX-XXXX-XXXX'),
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
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final res = await ref.read(authServiceProvider).consumeRecoveryCode(code);
      if (!mounted) return;
      switch (res) {
        case Ok(value: final user):
          await _rememberAndUnlock(user);
        case Err(failure: final f):
          setState(() => _message = f.message);
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _message = 'Pemulihan belum berhasil. Silakan coba lagi.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _pin = '';
        });
      }
    }
  }

  void _press(String digit) {
    if (_busy || _account == null || _pin.length >= 6) return;
    HapticFeedback.lightImpact();
    setState(() => _pin += digit);
    if (_pin.length == 6) unawaited(_submit());
  }

  IconData _roleIcon(Role role) => switch (role) {
    Role.superAdmin => Icons.admin_panel_settings_outlined,
    Role.adminAkademik => Icons.account_balance_outlined,
    Role.dosenPengampu => Icons.co_present_outlined,
    Role.dosenWali => Icons.supervisor_account_outlined,
    Role.mahasiswa => Icons.school_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final accounts = _accounts.where((a) => a.role == _role).toList();
    return SecureScope(
      child: Scaffold(
        backgroundColor: scheme.surfaceContainerLow,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 460),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.school_outlined,
                            color: scheme.onPrimary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'SIMAHA',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Masuk ke ruang Anda.', style: text.headlineSmall),
                    const SizedBox(height: 8),
                    Text(
                      'Pilih peran dan akun. Cukup masukkan PIN untuk melanjutkan.',
                      style: text.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (AppRuntime.isDemo) ...[
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'RUANG DEMO\n5 dosen / 50 mahasiswa / 5 mata kuliah\nPIN awal semua akun: 123456',
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    Text('1. Pilih peran', style: text.titleSmall),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final role in Role.values)
                          ChoiceChip(
                            key: ValueKey('login-role-${role.storageKey}'),
                            avatar: Icon(_roleIcon(role), size: 18),
                            label: Text(role.label),
                            selected: role == _role,
                            showCheckmark: false,
                            onSelected: _busy || _loading || _loadError != null
                                ? null
                                : (_) => _chooseRole(role),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_loading)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (_loadError != null) ...[
                      Text(_loadError!, textAlign: TextAlign.center),
                      TextButton.icon(
                        onPressed: _loadAccounts,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba lagi'),
                      ),
                    ] else if (_account == null)
                      Container(
                        key: const ValueKey('login-no-account'),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Belum ada akun ${_role.label}',
                              style: text.titleSmall,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Minta Super Admin membuat akun melalui Kelola akun. Setelah itu, akun akan muncul di sini.',
                            ),
                          ],
                        ),
                      )
                    else ...[
                      DropdownButtonFormField<int>(
                        key: ValueKey('login-account-${_role.storageKey}'),
                        initialValue: _account!.id,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Pilih akun',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        items: [
                          for (final account in accounts)
                            DropdownMenuItem(
                              value: account.id,
                              child: Text(
                                account.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: _busy ? null : _chooseAccount,
                      ),
                      const SizedBox(height: 24),
                      if (AppRuntime.isDemo) ...[
                        FilledButton.icon(
                          onPressed: _busy
                              ? null
                              : () {
                                  setState(() => _pin = AppRuntime.demoPin);
                                  _submit();
                                },
                          icon: const Icon(Icons.login),
                          label: const Text('Masuk akun demo'),
                        ),
                        const SizedBox(height: 20),
                      ],
                      Text('2. Masukkan PIN akun ini', style: text.titleSmall),
                      const SizedBox(height: 16),
                      Semantics(
                        label: '${_pin.length} dari 6 digit PIN terisi',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            6,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              width: 16,
                              height: 16,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i < _pin.length
                                    ? scheme.primary
                                    : scheme.surfaceContainerHighest,
                                border: Border.all(
                                  color: scheme.outlineVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_busy)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 52,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                          children: [
                            for (final digit in [
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
                              _Key(
                                key: ValueKey('pin-key-$digit'),
                                label: digit,
                                onTap: () => _press(digit),
                              ),
                            _Key(
                              label: 'C',
                              semanticLabel: 'Bersihkan PIN',
                              onTap: () => setState(() => _pin = ''),
                            ),
                            _Key(
                              key: const ValueKey('pin-key-0'),
                              label: '0',
                              onTap: () => _press('0'),
                            ),
                            _Key(
                              icon: Icons.backspace_outlined,
                              semanticLabel: 'Hapus satu digit',
                              onTap: () => setState(
                                () => _pin = _pin.isEmpty
                                    ? ''
                                    : _pin.substring(0, _pin.length - 1),
                              ),
                            ),
                          ],
                        ),
                    ],
                    if (_message != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _message!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: scheme.error),
                        ),
                      ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _busy ? null : _showRecovery,
                      child: const Text('Lupa PIN?'),
                    ),
                    Text(
                      'Akun lokal · tetap bisa masuk tanpa internet',
                      textAlign: TextAlign.center,
                      style: text.bodySmall,
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
  const _Key({
    super.key,
    this.label,
    this.icon,
    this.semanticLabel,
    required this.onTap,
  });
  final String? label;
  final IconData? icon;
  final String? semanticLabel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      child: Material(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Center(
            child: label != null
                ? Text(
                    label!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Icon(icon, size: 22),
          ),
        ),
      ),
    );
  }
}
