import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/image_import.dart';
import 'package:catlog/src/screens/photo_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// Frames kept from a video get the crop step one after the other, on
/// the full-size frame, before anything is compressed.
void main() {
  setUpAll(useSystemSqlite);

  Uint8List frame(int width) =>
      Uint8List.fromList(img.encodeJpg(img.Image(width: width, height: 40)));

  const left = (x: 0.0, y: 0.0, w: 0.5, h: 1.0);

  /// A crop step that answers from [answers] in order and remembers
  /// which frames it was shown; a missing answer is Cancel.
  (CropStep, List<Uint8List>) script(List<CropChoice?> answers) {
    final shown = <Uint8List>[];
    Future<CropChoice?> step(BuildContext _, Uint8List f) async {
      shown.add(f);
      return answers[shown.length - 1];
    }

    return (step, shown);
  }

  Future<BuildContext> host(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: SizedBox()),
      ),
    );
    return tester.element(find.byType(SizedBox));
  }

  testWidgets('each frame gets its crop page, in order', (tester) async {
    final context = await host(tester);
    final frames = [frame(40), frame(60), frame(80)];
    final (step, shown) = script([
      (crop: left),
      null, // Cancel drops this frame only
      (crop: null), // Use full photo keeps it whole
    ]);

    final kept = await cropFrames(context, frames, cropStep: step);

    expect(shown, frames);
    expect(kept.map((k) => k.bytes), [frames[0], frames[2]]);
    expect(kept.map((k) => k.crop), [left, null]);
  });

  testWidgets('frames from a video land on the cat cropped', (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    final context = await host(tester);
    final (step, _) = script([(crop: left), null]);

    final added = await tester.runAsync(
      () => addPhotosFromVideo(
        context,
        store,
        cat,
        pickFrames: (_) async => [frame(80), frame(60)],
        cropStep: step,
      ),
    );

    expect(added, isTrue);
    final stored =
        img.decodeImage(store.imageBytes(store.images(cat).single)!)!;
    expect(stored.width, 40, reason: 'the left half of the first frame');
  });

  testWidgets('every frame canceled stores nothing', (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    final context = await host(tester);
    final (step, _) = script([null, null]);

    final added = await tester.runAsync(
      () => addPhotosFromVideo(
        context,
        store,
        cat,
        pickFrames: (_) async => [frame(80), frame(60)],
        cropStep: step,
      ),
    );

    expect(added, isFalse);
    expect(store.images(cat), isEmpty);
  });
}
