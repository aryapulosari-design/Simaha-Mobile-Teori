import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/data/local/app_database.dart';
import 'package:simaha/data/local/connection/workspace_storage.dart';

void main() {
  test('demo connection opens encrypted database, reopens changes and leaves normal file untouched', () async {
    final dir = await Directory.systemTemp.createTemp('simaha_workspace_');
    try {
      final normal = File('${dir.path}/normal.db');
      await normal.writeAsString('production sentinel');
      final first = await openWorkspaceStorage(
        demo: true,
        normalFile: normal,
        demoDirectory: '${dir.path}/demo',
      );
      final db = AppDatabase(first.executor);
      await db.setSetting('test_persist', 'saved');
      await db.close();
      final second = await openWorkspaceStorage(
        demo: true,
        normalFile: normal,
        demoDirectory: '${dir.path}/demo',
      );
      final reopened = AppDatabase(second.executor);
      expect(await reopened.getSetting('test_persist'), 'saved');
      await reopened.close();
      expect(await normal.readAsString(), 'production sentinel');
      expect(first.file.path, isNot(normal.path));
    } finally {
      await dir.delete(recursive: true);
    }
  });
  test(
    'missing demo key fails safely without replacing existing database',
    () async {
      final dir = await Directory.systemTemp.createTemp(
        'simaha_workspace_missing_',
      );
      try {
        final normal = File('${dir.path}/normal.db');
        final storage = await openWorkspaceStorage(
          demo: true,
          normalFile: normal,
        );
        final db = AppDatabase(storage.executor);
        await db.setSetting('test_persist', 'saved');
        await db.close();
        final bytes = await storage.file.readAsBytes();
        await File('${storage.file.path}.preferences.json').delete();
        await expectLater(
          openWorkspaceStorage(demo: true, normalFile: normal),
          throwsStateError,
        );
        expect(await storage.file.readAsBytes(), bytes);
        expect(
          await File('${storage.file.path}.preferences.json').exists(),
          isFalse,
        );
      } finally {
        await dir.delete(recursive: true);
      }
    },
  );
}
