// SIMAHA Offline bootstrap (Tahap A).
// Opens SQLCipher-encrypted Drift DB, seeds 100 dummy students on first run,
// then starts Material3 + Riverpod + go_router app. 100% offline.
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/core/router/app_router.dart';
import 'package:simaha/core/config/app_runtime.dart';
import 'package:simaha/data/local/seed/demo_seed.dart';
import 'package:simaha/core/security/gate.dart';
import 'package:simaha/core/theme/app_theme.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';
import 'package:simaha/data/local/seed/seed_data.dart';
import 'package:simaha/data/services/auth_service.dart';
import 'package:simaha/data/services/crypto_service.dart';
import 'package:simaha/data/services/secure_store.dart';
import 'package:simaha/domain/security/string_store.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';
import 'package:simaha/services/audit/audit_logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Splash while opening encrypted DB (cold start budget <=3s for 100 rows).
  runApp(const _BootSplash());

  try {
    final bootSw = Stopwatch()..start();
    final keyManager = DatabaseKeyManager();
    final normalFile = await defaultDatabaseFile();
    final file = AppRuntime.isDemo
        ? File.fromUri(
            normalFile.parent.uri.resolve(AppRuntime.demoDatabaseName),
          )
        : normalFile;
    final executor = await openProductionExecutor(
      keyManager: keyManager,
      overrideFile: file,
    );
    final db = AppDatabase(executor);
    if (AppRuntime.isDemo) await ensureDemoSeeded(db);
    final stats = AppRuntime.isDemo ? null : await ensureSeeded(db);
    bootSw.stop();
    if (kDebugMode) {
      debugPrint('SIMAHA startup: ${bootSw.elapsedMilliseconds} ms');
      final c = await db.dashboardCounts();
      debugPrint(
        'SIMAHA counts: total=${c.total} aktif=${c.aktif} '
        'prodi=${c.prodi} dosen=${c.dosen} kelas=${c.kelas}',
      );
      if (stats != null) {
        debugPrint(
          'SIMAHA seeded: ${stats.mahasiswa} mhs, ${stats.krs} krs, '
          '${stats.nilai} nilai, ${stats.kelas} kelas',
        );
      }
    }

    // Auth wiring (Tahap B): gate is decided before first frame, so the
    // router never flashes the wrong page.
    // Login mudah-aman: setup sekali (PIN 6 digit) lalu kunci PIN tiap
    // cold start. Mudah karena username terisi otomatis + numpad + recovery;
    // aman karena hash PBKDF2, lockout eskalasi, DB SQLCipher di Keystore.
    final platformStore = SecureStore();
    final StringStore secureStore = AppRuntime.isDemo
        ? NamespacedStringStore(platformStore, 'simaha_demo:')
        : platformStore;
    final authService = AuthService(
      db: db,
      crypto: CryptoService(),
      store: secureStore,
      auditLogger: DbAuditLogger(db),
    );
    gateListenable.value = await authService.isSetupRequired()
        ? GateStatus.setup
        : GateStatus.lock;
    runApp(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          authServiceProvider.overrideWithValue(authService),
          lastUserStoreProvider.overrideWithValue(secureStore),
        ],
        child: SimahaApp(dbPath: file.path),
      ),
    );
  } catch (e) {
    runApp(_BootError(message: '$e'));
  }
}

class SimahaApp extends ConsumerWidget {
  const SimahaApp({super.key, required this.dbPath});
  final String dbPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: AppRuntime.isDemo ? 'SIMAHA Demo' : 'SIMAHA Offline',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      routerConfig: ref.watch(routerProvider(dbPath)),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _BootSplash extends StatelessWidget {
  const _BootSplash();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0xFF123D35)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, color: Colors.white, size: 64),
              SizedBox(height: 16),
              Text(
                'SIMAHA Offline',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Membuka database terenkripsi…',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BootError extends StatelessWidget {
  const _BootError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 12),
                const Text('Gagal membuka database terenkripsi.'),
                const SizedBox(height: 8),
                SelectableText(message),
                const SizedBox(height: 8),
                Text(
                  'Jangan hapus file secara manual. '
                  'Jalankan ulang; jika rusak, restore dari backup .simaha (Tahap E).',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Used by tests to open a temp encrypted DB without secure storage.
@visibleForTesting
Future<AppDatabase> openTestDatabase(File file, String rawHexKey) async {
  final ex = openEncryptedExecutor(file: file, rawHexKey: rawHexKey);
  return AppDatabase(ex);
}
