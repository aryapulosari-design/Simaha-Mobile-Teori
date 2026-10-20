import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Service to enforce NFR-04: FLAG_SECURE on sensitive screens.
/// Prevents screenshots, screen recording, and hides window preview in Recent Apps.
/// Uses native Android WindowManager.LayoutParams.FLAG_SECURE via MethodChannel.
class FlagSecure {
  FlagSecure._();

  static const _channel = MethodChannel('id.ac.uin.simaha/security');
  static bool _isSecure = false;
  static int _activeScopes = 0;

  // Routes can overlap during transitions. Releasing the old route must not
  // disable protection while the replacement is still on screen.
  static void _acquire() {
    if (++_activeScopes == 1) unawaited(enable());
  }

  static void _release() {
    if (_activeScopes == 0) return;
    if (--_activeScopes == 0) unawaited(disable());
  }

  static bool get isSecure => _isSecure;

  /// Enables FLAG_SECURE (blocks screenshots & hides preview in recent apps).
  static Future<void> enable() async {
    _isSecure = true;
    if (kIsWeb) return;
    try {
      await _channel.invokeMethod('enableSecure');
    } on MissingPluginException {
      // In test environment or unhandled platforms, safe no-op.
    } catch (_) {}
  }

  /// Disables FLAG_SECURE (allows normal screenshots).
  static Future<void> disable() async {
    _isSecure = false;
    if (kIsWeb) return;
    try {
      await _channel.invokeMethod('disableSecure');
    } on MissingPluginException {
      // In test environment or unhandled platforms, safe no-op.
    } catch (_) {}
  }
}

/// A widget wrapper that automatically enables FLAG_SECURE on sensitive pages
/// and disables it when the page is popped or disposed.
class SecureScope extends StatefulWidget {
  const SecureScope({super.key, required this.child});

  final Widget child;

  @override
  State<SecureScope> createState() => _SecureScopeState();
}

class _SecureScopeState extends State<SecureScope> {
  @override
  void initState() {
    super.initState();
    FlagSecure._acquire();
  }

  @override
  void dispose() {
    FlagSecure._release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
