import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/widgets/pair_code_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The pair code shown to read and type: wrapped into short lines, each
/// line in its own colour, instead of one long line off the screen.
void main() {
  final fingerprint = List<int>.generate(fullFingerprintBytes, (i) => i);

  test('a code breaks into lines of three groups', () {
    final code = encodePairCode(
      '192.168.1.23',
      4040,
      '123456',
      fingerprint: fingerprint,
      typed: true,
    );
    final lines = pairCodeLines(code);
    expect(lines.length, greaterThan(1));
    for (final line in lines) {
      expect(line.split('_').length, lessThanOrEqualTo(3));
      expect(line.length, lessThanOrEqualTo(17));
    }
    // Nothing lost: the lines joined give the code back.
    expect(lines.join('_'), code);
  });

  test('an IPv6 code still fits in lines', () {
    final code = encodePairCode(
      'fe80::1',
      4040,
      '123456',
      fingerprint: fingerprint,
      typed: true,
    );
    expect(pairCodeLines(code).length, greaterThanOrEqualTo(3));
    expect(pairCodeLines(code).join('_'), code);
  });

  testWidgets(
    'neighbouring lines differ in colour and the code is selectable',
    (tester) async {
      final code = encodePairCode(
        '192.168.1.23',
        4040,
        '123456',
        fingerprint: fingerprint,
        typed: true,
      );
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Center(child: PairCodeText(code))),
        ),
      );
      expect(tester.takeException(), isNull);
      final rich = tester.widget<SelectableText>(find.byType(SelectableText));
      final spans = (rich.textSpan as TextSpan).children!.cast<TextSpan>();
      expect(spans.length, pairCodeLines(code).length);
      expect(spans[0].style!.color, isNot(spans[1].style!.color));
      expect(spans.map((s) => s.text).join().replaceAll('\n', '_'), code);
    },
  );
}
