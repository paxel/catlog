import 'package:catlog/src/missing_poster.dart';
import 'package:catlog/src/widgets/poster_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// The frame reports the framed part of the picture in fractions: the
/// cover fit cuts the long side, zooming in halves what shows.
void main() {
  final photo = img.encodePng(img.Image(width: 40, height: 30));

  /// The picture decodes off the test clock: let it, then pump.
  Future<void> settle(WidgetTester tester) async {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a wide frame on a 4:3 picture cuts top and bottom', (
    tester,
  ) async {
    PosterPhoto? seen;
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 200,
            child: PosterFrame(
              bytes: photo,
              aspect: 2,
              onChanged: (p) => seen = p,
            ),
          ),
        ),
      ),
    );
    await settle(tester);
    // Frame 200×100 on 40×30: scale 5, drawn 200×150, 25 cut on each
    // side vertically.
    expect(seen, isNotNull);
    expect(seen!.x, closeTo(0, 1e-6));
    expect(seen!.w, closeTo(1, 1e-6));
    expect(seen!.y, closeTo(25 / 150, 1e-6));
    expect(seen!.h, closeTo(100 / 150, 1e-6));
  });

  testWidgets('pinching in shows less of the picture', (tester) async {
    PosterPhoto? seen;
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 200,
            child: PosterFrame(
              bytes: photo,
              aspect: 2,
              onChanged: (p) => seen = p,
            ),
          ),
        ),
      ),
    );
    await settle(tester);
    final center = tester.getCenter(find.byType(InteractiveViewer));
    final a = await tester.startGesture(center - const Offset(20, 0));
    final b = await tester.startGesture(center + const Offset(20, 0));
    await tester.pump();
    await a.moveTo(center - const Offset(40, 0));
    await b.moveTo(center + const Offset(40, 0));
    await tester.pump();
    await a.up();
    await b.up();
    await tester.pumpAndSettle();
    expect(seen!.w, closeTo(0.5, 0.05));
    expect(seen!.h, closeTo(100 / 150 / 2, 0.05));
  });
}
