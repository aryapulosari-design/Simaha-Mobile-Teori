import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> loadAcademicPreviewFonts() async {
  await (FontLoader(
    'MaterialIcons',
  )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  if (!const bool.fromEnvironment('WRITE_PREVIEWS')) return;
  final configFile = File('.dart_tool/package_config.json');
  final config =
      jsonDecode(await configFile.readAsString()) as Map<String, dynamic>;
  final pkg = (config['packages'] as List).firstWhere(
    (p) => p['name'] == 'flutter',
  );
  final root = Directory.fromUri(
    configFile.absolute.uri.resolve(pkg['rootUri'] as String),
  ).parent.parent.path;
  final font = File(
    '$root/engine/src/flutter/txt/third_party/fonts/Roboto-Regular.ttf',
  );
  if (await font.exists()) {
    await (FontLoader('Roboto')..addFont(
          Future.value(ByteData.sublistView(await font.readAsBytes())),
        ))
        .load();
  }
}

Future<void> writeAcademicPreview(
  WidgetTester tester,
  GlobalKey key,
  String name,
) async {
  if (!const bool.fromEnvironment('WRITE_PREVIEWS')) return;
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final img = await boundary.toImage();
    final bytes = (await img.toByteData(format: ui.ImageByteFormat.png))!;
    final file = File('doct/design/previews/$name.png');
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes.buffer.asUint8List());
    img.dispose();
  });
}
