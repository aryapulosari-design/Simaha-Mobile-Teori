import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/core/constants/app_constants.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

/// Locks the session after inactivity or when the app goes to background
/// (PRD: auto-lock timeout configurable, background lock mandatory).
class AutoLockScope extends ConsumerStatefulWidget {
  const AutoLockScope({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AutoLockScope> createState() => _AutoLockScopeState();
}

class _AutoLockScopeState extends ConsumerState<AutoLockScope>
    with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _restart();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Mudah tapi aman: kunci saat app ke background agar recent-apps tidak
    // membocorkan data. Kembali masuk cukup PIN 6 digit (username diingat).
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      if (ref.read(sessionProvider).isUnlocked) {
        ref.read(sessionProvider.notifier).lock();
      }
    }
  }

  void _restart() {
    // Timeout 5 menit (kDefaultAutoLockMinutes): cukup lama agar tidak
    // mengganggu, cukup cepat agar aman. Tiap sentuhan me-reset timer.
    _timer?.cancel();
    _timer = Timer(
      const Duration(minutes: kDefaultAutoLockMinutes),
      () {
        if (ref.read(sessionProvider).isUnlocked) {
          ref.read(sessionProvider.notifier).lock();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _restart(),
      onPointerMove: (_) => _restart(),
      child: widget.child,
    );
  }
}
