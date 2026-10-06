import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/photo_edit_screen.dart';
import 'package:catlog/src/video_frames_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

/// Records where a video was asked for, and hands none back.
class _FakePicker extends ImagePickerPlatform {
  final sources = <ImageSource>[];

  @override
  Future<XFile?> getVideo({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
  }) async {
    sources.add(source);
    return null;
  }
}

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late _FakePicker picker;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    picker = _FakePicker();
    ImagePickerPlatform.instance = picker;
  });

  tearDown(() => store.close());

  testWidgets(
    'a stray from a video picks a video file, not the camera',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: SizedBox()),
        ),
      );
      final context = tester.element(find.byType(SizedBox));

      final catId = await strayCamVideo(
        context,
        store,
        locate: () async => (pos: (48.1, 11.5), failure: null),
      );

      expect(picker.sources, [ImageSource.gallery]);
      expect(catId, isNull, reason: 'no video picked, no cat');
      expect(store.cats(), isEmpty);
    },
    // The frame picker only runs on a phone.
    variant: TargetPlatformVariant.only(TargetPlatform.android),
  );

  group('crop step', () {
    Uint8List frame(int width) => Uint8List.fromList(
      img.encodeJpg(img.Image(width: width, height: 40)),
    );

    Future<String?> run(
      WidgetTester tester,
      List<Uint8List> frames,
      List<CropChoice?> answers,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: SizedBox()),
        ),
      );
      final context = tester.element(find.byType(SizedBox));
      var asked = 0;
      return tester.runAsync<String?>(
        () => strayCamVideo(
          context,
          store,
          locate: () async => (pos: (48.1, 11.5), failure: null),
          pickFrames: (_) async => frames,
          cropStep: (_, _) async => answers[asked++],
        ),
      );
    }

    testWidgets('a canceled first frame leaves the stray to the next', (
      tester,
    ) async {
      final catId = await run(
        tester,
        [frame(100), frame(80), frame(60)],
        [
          null,
          (crop: (x: 0.0, y: 0.0, w: 0.5, h: 1.0)),
          (crop: null),
        ],
      );

      expect(catId, isNotNull);
      final widths = [
        for (final hash in store.images(catId!))
          img.decodeImage(store.imageBytes(hash)!)!.width,
      ];
      expect(widths, unorderedEquals([40, 60]),
          reason: 'the second frame cropped to its half, the third whole');
    });

    testWidgets('every frame canceled creates no stray', (tester) async {
      final catId = await run(tester, [frame(100), frame(80)], [null, null]);

      expect(catId, isNull);
      expect(store.cats(), isEmpty);
    });
  });
}
