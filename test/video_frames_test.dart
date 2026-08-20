import 'dart:typed_data';

import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/video_frames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

Uint8List _sharp() {
  // A checkerboard has hard edges everywhere — maximal Laplacian energy.
  final image = img.Image(width: 64, height: 64);
  for (var y = 0; y < 64; y++) {
    for (var x = 0; x < 64; x++) {
      final on = ((x ~/ 4) + (y ~/ 4)).isEven;
      image.setPixelRgb(x, y, on ? 255 : 0, on ? 255 : 0, on ? 255 : 0);
    }
  }
  return Uint8List.fromList(img.encodeJpg(image));
}

Uint8List _blurred() {
  final image = img.Image(width: 64, height: 64);
  img.fill(image, color: img.ColorRgb8(128, 128, 128));
  return Uint8List.fromList(img.encodeJpg(image));
}

void main() {
  test('sharp frames outrank blurred ones', () {
    expect(sharpnessScore(_sharp()),
        greaterThan(sharpnessScore(_blurred())));
  });

  test('suggestions pick the sharpest, spread over the clip', () {
    final frames = <(int, Uint8List)>[
      (500, _blurred()),
      (1500, _sharp()),
      (1800, _sharp()), // same second bucket as nothing — 1s vs 1.8s
      (2500, _blurred()),
      (3500, _sharp()),
    ];
    final picks = suggestFrameIndexes(frames, keep: 2);
    expect(picks, hasLength(2));
    // The two sharp frames from different seconds win.
    expect(picks.map((i) => frames[i].$1),
        containsAll(<int>[1500, 3500]));
  });

  testWidgets('scrubbed grabs are kept and popped on save',
      (tester) async {
    final frame = _sharp();
    List<Uint8List>? result;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () async {
            result = await Navigator.of(context)
                .push<List<Uint8List>>(MaterialPageRoute(
              builder: (_) => VideoFramesScreen(
                duration: const Duration(seconds: 10),
                samples: 4,
                extractFrame: (ms) async => frame,
              ),
            ));
          },
          child: const Text('go'),
        ),
      ),
    ));
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    // Scrubbing alone shows the frame at that position — before any keep.
    expect(find.byKey(const ValueKey('scrub-preview')), findsNothing);
    await tester.scrollUntilVisible(find.byType(Slider), 200,
        scrollable: find.byType(Scrollable).first);
    await tester.drag(find.byType(Slider), const Offset(60, 0));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('scrub-preview')), findsOneWidget);
    // Suggestions rendered; keep one via tap, plus a scrubbed grab.
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Keep this frame'), 200,
        scrollable: find.byType(Scrollable).first);
    await tester.tap(find.text('Keep this frame'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(result, isNotNull);
    expect(result!.length, greaterThanOrEqualTo(1));
  });
}
