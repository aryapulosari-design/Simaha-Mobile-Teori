import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simaha/core/security/flag_secure.dart';

void main() {
  testWidgets(
    'overlapping secure routes stay protected until the last scope closes',
    (tester) async {
      final calls = <String>[];
      const channel = MethodChannel('id.ac.uin.simaha/security');
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
        call,
      ) async {
        calls.add(call.method);
        return null;
      });
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          channel,
          null,
        ),
      );
      Widget scene(bool a, bool b) => MaterialApp(
        home: Column(
          children: [
            if (a)
              const SecureScope(key: ValueKey('a'), child: Text('Route A')),
            if (b)
              const SecureScope(key: ValueKey('b'), child: Text('Route B')),
          ],
        ),
      );
      await tester.pumpWidget(scene(true, false));
      await tester.pumpAndSettle();
      expect(FlagSecure.isSecure, isTrue);
      await tester.pumpWidget(scene(true, true));
      await tester.pumpAndSettle();
      await tester.pumpWidget(scene(false, true));
      await tester.pumpAndSettle();
      expect(FlagSecure.isSecure, isTrue);
      expect(calls, ['enableSecure']);
      await tester.pumpWidget(scene(false, false));
      await tester.pumpAndSettle();
      expect(FlagSecure.isSecure, isFalse);
      expect(calls, ['enableSecure', 'disableSecure']);
    },
  );
}
