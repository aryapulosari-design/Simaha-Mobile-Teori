import 'package:simaha/presentation/features/campus/announcements_page.dart';
import 'package:simaha/presentation/features/academic/master_data_page.dart';
import 'package:simaha/presentation/features/campus/attendance_page.dart';
import 'package:simaha/presentation/features/campus/study_insight_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/domain/security/roles.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

import 'package:simaha/core/security/gate.dart';
import 'package:simaha/presentation/features/academic/academic_workspace_page.dart';
import 'package:simaha/presentation/features/academic/role_guide_page.dart';
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

final routerProvider = Provider.autoDispose.family<GoRouter, String>((
  ref,
  path,
) {
  final router = buildRouter(dbPath: path);
  ref.onDispose(router.dispose);
  return router;
});

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
      final loc = state.uri.path;
      final isAuthPage = loc == '/setup' || loc == '/lock' || loc == '/login';
      if (gate == GateStatus.setup && loc != '/setup') return '/setup';
      if (gate == GateStatus.lock && loc != '/lock' && loc != '/login') {
        return '/lock';
      }
      if (gate == GateStatus.ok && isAuthPage) return '/';
      if (gate == GateStatus.ok) {
        final role = ProviderScope.containerOf(
          context,
          listen: false,
        ).read(sessionProvider).role;
        final masterPage =
            loc == '/master' ||
            loc == '/db' ||
            loc == '/trash' ||
            loc == '/mahasiswa/baru' ||
            loc.endsWith('/edit');
        if (masterPage &&
            (role == null || !canRole(role, Permission.manageMaster))) {
          return '/';
        }
        if ((loc == '/users' || loc == '/audit') &&
            (role == null || !canRole(role, Permission.manageUsers))) {
          return '/';
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/setup', builder: (context, state) => const SetupPage()),
      GoRoute(path: '/lock', builder: (context, state) => const LockPage()),
      GoRoute(path: '/login', builder: (context, state) => const LockPage()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/master',
            builder: (context, state) => const MasterDataPage(),
          ),
          GoRoute(
            path: '/pengumuman',
            builder: (context, state) => const AnnouncementsPage(),
          ),
          GoRoute(
            path: '/audit',
            builder: (context, state) => const AuditTrailPage(),
          ),
          GoRoute(
            path: '/presensi/:id',
            builder: (context, state) => AttendancePage(
              classId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
            ),
          ),
          GoRoute(
            path: '/studi/:id',
            builder: (context, state) => StudyInsightPage(
              studentId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
            ),
          ),
          GoRoute(path: '/', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/akademik',
            builder: (context, state) => const AcademicWorkspacePage(),
          ),
          GoRoute(
            path: '/kelas/:id',
            builder: (context, state) => AcademicClassPage(
              classId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
            ),
          ),
          GoRoute(
            path: '/panduan-peran',
            builder: (context, state) => const RoleGuidePage(),
          ),
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
