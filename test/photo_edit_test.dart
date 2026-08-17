import 'dart:typed_data';

import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/photo_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

void main() {
  testWidgets('drag a rectangle and confirm returns cropped bytes',
      (tester) async {
    final source = Uint8List.fromList(
        img.encodeJpg(img.Image(width: 400, height: 400)));
    Uint8List? result;

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () async {
            result = await Navigator.of(context).push<Uint8List>(
              MaterialPageRoute(
                builder: (_) => PhotoEditScreen(
                    bytes: source,
                    mode: PhotoEditMode.crop,
                    allowSkip: true),
              ),
            );
          },
          child: const Text('go'),
        ),
      ),
    ));
    await tester.tap(find.text('go'));
    await tester.pump();
    // Real time for the image decode to finish.
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 400)));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    // Drag a selection across the middle of the image area.
    final area = find.byKey(const Key('photoEditArea'));
    final center = tester.getCenter(area);
    final gesture = await tester.startGesture(center - const Offset(80, 80));
    await gesture.moveBy(const Offset(80, 80));
    await tester.pump();
    await gesture.moveBy(const Offset(80, 80));
    await tester.pump();
    await gesture.up();
    await tester.pump(const Duration(milliseconds: 300));

    final confirm = tester.widget<TextButton>(
        find.widgetWithText(TextButton, 'Crop'));
    expect(confirm.onPressed, isNotNull,
        reason: 'drag should have produced a selection');

    await tester.tap(find.widgetWithText(TextButton, 'Crop'));
    await tester.pump();
    // Real time for the crop isolate to finish.
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(seconds: 1)));
    await tester.pump(const Duration(milliseconds: 300));

    expect(result, isNotNull);
    final decoded = img.decodeImage(result!)!;
    expect(decoded.width, lessThan(400)); // actually cropped
  });

  testWidgets('use full photo returns the original bytes', (tester) async {
    final source = Uint8List.fromList(
        img.encodeJpg(img.Image(width: 100, height: 100)));
    Uint8List? result;

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () async {
            result = await Navigator.of(context).push<Uint8List>(
              MaterialPageRoute(
                builder: (_) => PhotoEditScreen(
                    bytes: source,
                    mode: PhotoEditMode.crop,
                    allowSkip: true),
              ),
            );
          },
          child: const Text('go'),
        ),
      ),
    ));
    await tester.tap(find.text('go'));
    await tester.pump();
    // Real time for the image decode to finish.
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 400)));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.text('Use full photo'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    expect(result, source);
  });
}
