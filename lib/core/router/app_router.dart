import 'package:go_router/go_router.dart';
import 'package:simaha/core/security/gate.dart';
import 'package:simaha/presentation/features/auth/lock_page.dart';
import 'package:simaha/presentation/features/auth/setup_page.dart';
import 'package:simaha/presentation/features/auth/users_page.dart';
import 'package:simaha/presentation/features/dbinfo/db_info_page.dart';
import 'package:simaha/presentation/features/home/home_page.dart';
import 'package:simaha/presentation/features/mahasiswa/mahasiswa_form_page.dart';
import 'package:simaha/presentation/features/mahasiswa/trash_page.dart';
import 'package:simaha/presentation/features/nilai/mahasiswa_detail_page.dart';
import 'package:simaha/presentation/features/settings/settings_page.dart';
import 'package:simaha/presentation/shared/widgets/app_shell.dart';

/// Central routes with auth gate (Tahap B).
/// Redirects react to [gateListenable] (written only by SessionNotifier).
///
/// Login mudah-aman (realistis, tetap aman):
/// - Belum setup (DB users kosong) -> wajib /setup (buat PIN 6 digit sekali).
/// - Sudah setup tapi terkunci -> wajib /lock (username terisi otomatis,
///   numpad besar, auto-submit 6 digit, kode pemulihan sekali pakai).
/// - Sudah unlock -> tidak boleh kembali ke /setup atau /lock.
GoRouter buildRouter({required String dbPath}) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: gateListenable,
    redirect: (context, state) {
      final gate = gateListenable.value;
      final loc = state.uri.toString();
      final isAuthPage = loc == '/setup' || loc == '/lock' || loc == '/login';
      if (gate == GateStatus.setup && loc != '/setup') return '/setup';
      if (gate == GateStatus.lock && !isAuthPage) return '/lock';
      if (gate == GateStatus.ok && isAuthPage) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/setup', builder: (context, state) => const SetupPage()),
      GoRoute(path: '/lock', builder: (context, state) => const LockPage()),
      GoRoute(path: '/login', builder: (context, state) => const LockPage()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/db',
            builder: (context, state) => DbInfoPage(dbPath: dbPath),
          ),
          GoRoute(
            path: '/users',
            builder: (context, state) => const UsersPage(),
          ),
          GoRoute(
            path: '/mahasiswa/baru',
            builder: (context, state) => const MahasiswaFormPage(),
          ),
          GoRoute(
            path: '/mahasiswa/:id',
            builder: (context, state) => MahasiswaDetailPage(
              mahasiswaId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
            ),
          ),
          GoRoute(
            path: '/mahasiswa/:id/edit',
            builder: (context, state) => MahasiswaFormPage(
              mahasiswaId: int.tryParse(state.pathParameters['id'] ?? ''),
            ),
          ),
          GoRoute(
            path: '/trash',
            builder: (context, state) => const TrashPage(),
          ),
        ],
      ),
    ],
  );
}
