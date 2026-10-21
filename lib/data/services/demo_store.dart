import 'dart:convert';
import 'dart:io';

import 'package:simaha/domain/security/string_store.dart';

/// Public demonstration data only. Never used for production credentials.
/// A separate file avoids opening Windows DPAPI storage from the demo process.
class DemoStore implements StringStore {
  DemoStore(this.file);
  final File file;
  Future<void> _pending = Future.value();

  Future<Map<String, dynamic>> _readAll() async {
    if (!await file.exists()) return {};
    return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  }

  @override
  Future<String?> read(String key) async {
    await _pending;
    return (await _readAll())[key] as String?;
  }

  Future<void> _change(String key, String? value) {
    final operation = _pending.then((_) async {
      final values = await _readAll();
      if (value == null) {
        values.remove(key);
      } else {
        values[key] = value;
      }
      await file.parent.create(recursive: true);
      final temporary = File('${file.path}.tmp');
      await temporary.writeAsString(jsonEncode(values), flush: true);
      await temporary.rename(file.path);
    });
    _pending = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }

  @override
  Future<void> write(String key, String value) => _change(key, value);
  @override
  Future<void> delete(String key) => _change(key, null);
}
