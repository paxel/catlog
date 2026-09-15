// Screenshots of every step of the flier wizard, for judging the
// pages by eye, not for the stores. Skipped in the suite; run with
//
//   flutter test test/screenshots/flier_steps_test.dart --run-skipped
//
// The pages go to /tmp/claude-1000/.../flier-steps (see [outDir]).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/flier_capture.dart';
import 'package:catlog/src/flier_ocr.dart';
import 'package:catlog/src/flier_template.dart';
import 'package:catlog/src/fur_background.dart';
import 'package:catlog/src/geocode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import '../flier_fixtures.dart';

const outDir = String.fromEnvironment(
  'FLIER_SHOTS',
  defaultValue: 'build/flier-steps',
);

const _tassoUrl =
    'https://www.tasso.net/Tierregister/Suchmeldungen'
    '?lang=de-DE&snr=S3101849&lp=0';
const _unknownUrl =
    'https://www.findefix.de/vermisst/suche?tier=katze&nummer=276098102345678&region=muenchen';

Future<void> _loadRealFonts() async {
  final root = Platform.environment['FLUTTER_ROOT']!;
  final fonts = '$root/bin/cache/artifacts/material_fonts';
  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      final bytes = File('$fonts/$f').readAsBytesSync();
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    }
    await loader.load();
  }

  await load('Roboto', [
    'Roboto-Regular.ttf',
    'Roboto-Medium.ttf',
    'Roboto-Bold.ttf',
  ]);
  await load('MaterialIcons', ['MaterialIcons-Regular.otf']);
}

void main() {
  setUpAll(useSystemSqlite);
  setUpAll(_loadRealFonts);

  testWidgets('every step of the flier wizard', (tester) async {
    final store = CatalogStore.inMemory()..author = 'Alex';
    addTearDown(store.close);
    final home = store.createClowder('Foster Home South');
    store.append(home, 'f:address', 'Main Street 7, 10178 Berlin');
    store.append(home, 'f:phone', '+49 30 1234567');
    final templates = FlierTemplateSet.fromJson(
      File('assets/fliers/templates.json').readAsStringSync(),
    );
    final photo = File('test/screenshots/demo/cat3.jpg').readAsBytesSync();
    final lines = hugoLines();
    final text = lines.map((l) => l.text).join('\n');
    tester.view.physicalSize = const Size(820, 1660);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    Directory(outDir).createSync(recursive: true);
    final key = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: key,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            scaffoldBackgroundColor: Colors.transparent,
          ),
          home: FurBackground(
            child: FlierCaptureScreen(
              store: store,
              pickPhoto: (_) async => photo,
              locate: () async => (pos: (52.52, 13.405), failure: null),
              scan: (_) async => null,
              ocr: (_) async => FlierText(text, lines),
              codes: (_) async => FlierCodes([_tassoUrl, _unknownUrl]),
              geocode: (q) async => [GeoHit('Berlin, Mitte', 52.52, 13.405)],
              templates: () async => templates,
            ),
          ),
        ),
      ),
    );
    Future<void> settle() async {
      for (var i = 0; i < 3; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 300)),
        );
        await tester.pump(const Duration(milliseconds: 300));
      }
    }

    Future<void> shoot(String name) async {
      await settle();
      await tester.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 2);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        final rgb = img
            .decodePng(data!.buffer.asUint8List())!
            .convert(numChannels: 3);
        File('$outDir/$name.png').writeAsBytesSync(img.encodePng(rgb));
      });
    }

    await settle();
    await shoot('01-text');
    // The X on the first card puts a line aside: the Undo row shows.
    await tester.tap(find.byTooltip('Drop').first);
    await settle();
    await shoot('02-text-one-aside');
    // The text step is long: the lower half with the last cards.
    await tester.drag(find.byType(ListView).first, const Offset(0, -900));
    await settle();
    await shoot('03-text-scrolled');
    Future<void> next() async {
      await tester.drag(find.byType(ListView).first, const Offset(0, 4000));
      await tester.tap(find.text('Next'));
      await settle();
    }

    await next();
    await shoot('04-cat');
    await next();
    await shoot('05-owner');
    await next();
    await shoot('06-face');
    await next();
    await shoot('07-registry');
    await tester.tap(find.text('Remember service'));
    await settle();
    await shoot('08-remember-service');
    await tester.tap(find.text('Cancel'));
    await settle();
    await next();
    await shoot('09-review');
  }, skip: true);
}
