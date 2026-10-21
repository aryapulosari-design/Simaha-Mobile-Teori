import 'dart:io';

import 'package:drift/drift.dart';
import 'package:simaha/core/config/app_runtime.dart';
import 'package:simaha/data/local/connection/database_key_manager.dart';
import 'package:simaha/data/local/connection/encrypted_connection.dart';
import 'package:simaha/data/services/demo_store.dart';
import 'package:simaha/data/services/secure_store.dart';
import 'package:simaha/domain/security/string_store.dart';

class WorkspaceStorage {
  const WorkspaceStorage({
    required this.file,
    required this.executor,
    required this.authStore,
  });
  final File file;
  final QueryExecutor executor;
  final StringStore authStore;
}

/// Resolves storage before constructing UI. Demo never opens production secrets.
Future<WorkspaceStorage> openWorkspaceStorage({
  required bool demo,
  File? normalFile,
  String? demoDirectory,
}) async {
  final productionFile = normalFile ?? await defaultDatabaseFile();
  if (!demo) {
    return WorkspaceStorage(
      file: productionFile,
      executor: await openProductionExecutor(overrideFile: productionFile),
      authStore: SecureStore(),
    );
  }
  final folder = demoDirectory != null && demoDirectory.isNotEmpty
      ? Directory(demoDirectory)
      : productionFile.parent;
  final file = File.fromUri(folder.uri.resolve(AppRuntime.demoDatabaseName));
  final store = DemoStore(File('${file.path}.preferences.json'));
  var key = await store.read('demo_database_key');
  if (key == null) {
    if (await file.exists()) {
      throw StateError('Kunci demo tidak ditemukan. Database tidak diubah.');
    }
    key = DatabaseKeyManager.generateRawHexKey();
    await store.write('demo_database_key', key);
  }
  if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(key)) {
    throw StateError('Kunci demo tidak valid. Data dipertahankan.');
  }
  return WorkspaceStorage(
    file: file,
    executor: openEncryptedExecutor(file: file, rawHexKey: key),
    authStore: store,
  );
}
