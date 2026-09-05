import 'package:catlog/src/fur_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The fur ground (#99): one of six coats behind every page, beige on
/// beige, dark on dark, picked anew each launch.
void main() {
  tearDown(() => activeFur = FurPattern.cheetah);

  test('the launch picks one of the coats', () {
    expect(FurPattern.values, contains(activeFur));
  });

  test('the tones follow the brightness and stay close together', () {
    final light = furTones(Brightness.light);
    final dark = furTones(Brightness.dark);
    expect(light.base.computeLuminance(), greaterThan(0.8));
    expect(dark.base.computeLuminance(), lessThan(0.02));
    // Marks are barely apart from their ground — fur, not wallpaper.
    expect(
        (light.mark.computeLuminance() - light.base.computeLuminance()).abs(),
        lessThan(0.15));
    expect(
        (dark.mark.computeLuminance() - dark.base.computeLuminance()).abs(),
        lessThan(0.05));
  });

  testWidgets('every coat paints under a transparent page, both modes',
      (tester) async {
    for (final pattern in FurPattern.values) {
      for (final brightness in Brightness.values) {
        activeFur = pattern;
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepOrange, brightness: brightness),
              scaffoldBackgroundColor: Colors.transparent),
          home: const FurBackground(
            child: Scaffold(body: Center(child: Text('Miezi'))),
          ),
        ));
        await tester.pumpAndSettle();
        expect(find.text('Miezi'), findsOneWidget);
        expect(tester.takeException(), isNull, reason: pattern.name);
      }
    }
  });
}
