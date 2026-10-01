import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/video_frames_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
