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
    // The preview is decoded at screen size, never at photo size.
    expect(tester.widget<Image>(find.byType(Image)).image, isA<ResizeImage>());
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

  group('select only', () {
    Future<CropChoice?> open(WidgetTester tester,
        Future<void> Function() act) async {
      final source = Uint8List.fromList(
          img.encodeJpg(img.Image(width: 400, height: 400)));
      CropChoice? result;
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              result = await Navigator.of(context).push<CropChoice>(
                MaterialPageRoute(
                  builder: (_) => PhotoEditScreen(
                      bytes: source,
                      mode: PhotoEditMode.crop,
                      allowSkip: true,
                      selectOnly: true),
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
      await act();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));
      return result;
    }

    testWidgets('a drag and Crop return the selection, not bytes',
        (tester) async {
      final result = await open(tester, () async {
        final center = tester.getCenter(find.byKey(const Key('photoEditArea')));
        final gesture =
            await tester.startGesture(center - const Offset(80, 80));
        await gesture.moveBy(const Offset(80, 80));
        await tester.pump();
        await gesture.moveBy(const Offset(80, 80));
        await tester.pump();
        await gesture.up();
        await tester.pump(const Duration(milliseconds: 300));
        await tester.tap(find.widgetWithText(TextButton, 'Crop'));
      });

      final crop = result?.crop;
      expect(crop, isNotNull);
      expect(crop!.w, inExclusiveRange(0, 1));
      expect(crop.h, inExclusiveRange(0, 1));
    });

    testWidgets('use full photo returns no crop', (tester) async {
      final result =
          await open(tester, () => tester.tap(find.text('Use full photo')));
      expect(result, isNotNull, reason: 'kept, not canceled');
      expect(result!.crop, isNull);
    });
  });
}
