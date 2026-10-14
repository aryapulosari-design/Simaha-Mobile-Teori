import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:simaha/data/local/app_database.dart';

// Overridden in main.dart after the encrypted DB is opened.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider not initialized');
});

final dashboardCountsProvider = FutureProvider((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return db.dashboardCounts();
});

/// Search query state (Tahap A: FTS5 proof of <=500ms).
final mahasiswaQueryProvider = StateProvider<String>((ref) => '');

/// Visible row budget for lazy loading ("Muat lagi" adds +20).
const int kMahasiswaPageStep = 20;
final mahasiswaLimitProvider = StateProvider<int>((ref) => kMahasiswaPageStep);

final mahasiswaSearchProvider = FutureProvider((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final q = ref.watch(mahasiswaQueryProvider).trim();
  final limit = ref.watch(mahasiswaLimitProvider);
  final sw = Stopwatch()..start();
  final rows = q.isEmpty
      ? await db.pagedMahasiswa(limit: limit)
      : await db.searchMahasiswaFts(q, limit: limit);
  sw.stop();
  return (rows: rows, elapsedMs: sw.elapsedMilliseconds, limit: limit);
});

/// Light/dark/system theme state (Riverpod 3 Notifier, no legacy API).
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void toggle() {
    state = switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.system => ThemeMode.light,
    };
  }

  void setSystem() => state = ThemeMode.system;
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
