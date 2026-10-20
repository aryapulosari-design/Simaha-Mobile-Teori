import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/core/security/flag_secure.dart';
import 'package:simaha/core/utils/result.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

/// First-run wizard: creates Super Admin PIN, shows one-time recovery code.
class SetupPage extends ConsumerStatefulWidget {
  const SetupPage({super.key});

  @override
  ConsumerState<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends ConsumerState<SetupPage> {
  final _pinCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  String? _recoveryCode;
  bool _noted = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _pinCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final pin = _pinCtrl.text.trim();
    if (pin != _confirmCtrl.text.trim()) {
      setState(() => _error = 'Konfirmasi PIN tidak sama.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final code = await ref
          .read(authServiceProvider)
          .setupSuperAdmin(pin: pin);
      if (mounted) {
        setState(() {
          _recoveryCode = code;
          _busy = false;
        });
      }
    } on Object catch (e) {
      if (mounted) {
        setState(() {
          _error = '$e'.replaceFirst('ValidationFailure: ', '');
          _busy = false;
        });
      }
    }
  }

  Future<void> _finish() async {
    final service = ref.read(authServiceProvider);
    final res = await service.verifyPin('superadmin', _pinCtrl.text.trim());
    if (!mounted) return;
    switch (res) {
      case Ok(value: final user):
        await ref
            .read(lastUserStoreProvider)
            .write('simaha_last_user', user.username);
        ref.read(sessionProvider.notifier).unlock(user);
      case Err(failure: final f):
        setState(() => _error = f.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SecureScope(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: scheme.surfaceContainerLow),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _recoveryCode == null
                      ? _setupForm(context)
                      : _recoveryView(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _setupForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.school, size: 48),
        const SizedBox(height: 8),
        const Text(
          'Selamat datang di SIMAHA',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        Text(
          'Buat PIN 6 digit untuk Super Admin (username: superadmin). '
          'Tanpa internet, data hanya di perangkat ini.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _pinCtrl,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'PIN 6 digit',
            prefixIcon: Icon(Icons.pin_outlined),
            counterText: '',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _confirmCtrl,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'Ulangi PIN',
            prefixIcon: Icon(Icons.pin_outlined),
            counterText: '',
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: 8),
          Text(
            _error!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _busy ? null : _create,
          child: _busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Buat Super Admin'),
        ),
      ],
    );
  }

  Widget _recoveryView(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.key_outlined, size: 44),
        const SizedBox(height: 8),
        const Text(
          'Catat kode pemulihan ini',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
        ),
        const Text(
          'Ditampilkan SEKALI saja. Dipakai saat lupa PIN (satu kali pakai).',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: SelectableText(
                  _recoveryCode!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Salin',
                icon: const Icon(Icons.copy),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: _recoveryCode!));
                },
              ),
            ],
          ),
        ),
        CheckboxListTile(
          value: _noted,
          onChanged: (v) => setState(() => _noted = v ?? false),
          title: const Text(
            'Saya sudah mencatat di tempat aman',
            style: TextStyle(fontSize: 13),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        FilledButton(
          onPressed: _noted ? _finish : null,
          child: const Text('Selesai — masuk aplikasi'),
        ),
      ],
    );
  }
}
