import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simaha/data/services/campus_service.dart';
import 'package:simaha/data/services/insights_service.dart';
import 'package:simaha/presentation/providers/app_providers.dart';
import 'package:simaha/presentation/providers/session_providers.dart';

final campusServiceProvider = Provider(
  (ref) => CampusService(ref.watch(academicServiceProvider)),
);
final announcementsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(campusServiceProvider).announcements(),
);
final auditTrailProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(campusServiceProvider).auditTrail(),
);
final workspaceOverviewProvider = FutureProvider.autoDispose<WorkspaceOverview>(
  (ref) {
    final role = ref.watch(sessionProvider).role;
    if (role == null) throw StateError('Silakan masuk terlebih dahulu.');
    return InsightsService(ref.watch(academicServiceProvider)).overview(role);
  },
);
final attendanceSessionsProvider = FutureProvider.autoDispose.family(
  (ref, int id) => ref.watch(campusServiceProvider).sessions(id),
);
