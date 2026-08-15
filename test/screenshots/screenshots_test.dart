// Screenshot generator, not a test suite: renders key screens with a
// demo catalog and real fonts, writing PNGs to docs/screenshots/.
//
// Regenerate with:
//   flutter test test/screenshots --run-skipped
@Tags(['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/card_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:catlog/src/screens/map_screen.dart';
import 'package:catlog/src/screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

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

  await load('Roboto', ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf']);
  await load('MaterialIcons', ['MaterialIcons-Regular.otf']);
}

/// Demo catalog: two clowders, four cats with portraits and history.
CatalogStore _demoStore() {
  final store = CatalogStore.inMemory();
  store.author = 'Alex';
  Uint8List photo(int i) => CatalogStore.compressImage(
      File('test/screenshots/demo/cat$i.jpg').readAsBytesSync());

  final home = store.createClowder('Foster Home South',
      date: DateTime.utc(2026, 5, 2));
  store.append(home, 'f:address', 'Main Street 7',
      date: DateTime.utc(2026, 5, 2));
  store.append(home, 'f:responsible', 'Marta',
      date: DateTime.utc(2026, 5, 2));
  final barn = store.createClowder('Old Barn',
      date: DateTime.utc(2026, 5, 20));
  store.append(barn, 'f:address', 'Field Road 2',
      date: DateTime.utc(2026, 5, 20));

  final miezi =
      store.createCat('Miezi', clowderId: home, date: DateTime.utc(2026, 5, 3));
  store.addImage(miezi, photo(1), date: DateTime.utc(2026, 5, 3));
  store.append(miezi, 'f:gender', 'female', date: DateTime.utc(2026, 5, 3));
  store.append(miezi, 'f:color', 'ginger tabby',
      date: DateTime.utc(2026, 5, 3));
  store.append(miezi, 'f:neutered', 'yes', date: DateTime.utc(2026, 6, 14));
  store.append(miezi, 'f:birthdate', '2026-03-01',
      date: DateTime.utc(2026, 5, 3));

  final balu =
      store.createCat('Balu', clowderId: home, date: DateTime.utc(2026, 5, 3));
  store.addImage(balu, photo(2), date: DateTime.utc(2026, 5, 3));
  store.append(balu, 'f:gender', 'male', date: DateTime.utc(2026, 5, 3));
  store.append(balu, 'f:color', 'grey', date: DateTime.utc(2026, 5, 3));

  final luna =
      store.createCat('Luna', clowderId: home, date: DateTime.utc(2026, 5, 10));
  store.addImage(luna, photo(3), date: DateTime.utc(2026, 5, 10));
  store.append(luna, 'f:gender', 'female', date: DateTime.utc(2026, 5, 10));
  store.append(luna, 'f:pregnant', 'yes', date: DateTime.utc(2026, 6, 1));
  store.moveCat(luna, barn, date: DateTime.utc(2026, 7, 2));

  final findus = store.createCat('Findus', date: DateTime.utc(2026, 7, 21));
  store.addImage(findus, photo(4), date: DateTime.utc(2026, 7, 21));
  store.recordPosition(findus, 52.5205, 13.4049,
      date: DateTime.utc(2026, 7, 21));
  store.recordPosition(findus, 52.5228, 13.4102,
      date: DateTime.utc(2026, 8, 2));
  store.recordPosition(findus, 52.5241, 13.4021,
      date: DateTime.utc(2026, 8, 12));
  store.recordPosition(home, 52.5170, 13.3990,
      date: DateTime.utc(2026, 5, 2));

  return store;
}

class _PastelTileProvider extends TileProvider {
  final File tile;
  _PastelTileProvider(this.tile);
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) =>
      FileImage(tile);
}

void main() {
  setUpAll(() async {
    useSystemSqlite();
    await _loadRealFonts();
  });

  Future<void> shoot(WidgetTester tester, Widget home, String name) async {
    tester.view.physicalSize = const Size(820, 1660);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final key = GlobalKey();
    await tester.pumpWidget(RepaintBoundary(
      key: key,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: home,
      ),
    ));
    await tester.pump(const Duration(milliseconds: 500));
    // Real time so Image.memory decoding completes before capture.
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 600)));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.runAsync(() async {
      final boundary = key.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 1);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      File('docs/screenshots/$name.png')
          .writeAsBytesSync(data!.buffer.asUint8List());
    });
  }

  testWidgets('generate', (tester) async {
    final store = _demoStore();
    addTearDown(store.close);
    final miezi = store.searchCats('Miezi').single.id;
    final home = store
        .clowders()
        .firstWhere((c) => c.name == 'Foster Home South')
        .id;

    await shoot(tester, ClowderListScreen(store: store), '01-home');
    await shoot(tester,
        ClowderDetailScreen(store: store, clowderId: home), '02-clowder');
    await shoot(
        tester, CatDetailScreen(store: store, catId: miezi), '03-cat');
    await shoot(
        tester, CardScreen(store: store, catId: miezi), '04-card');
    await shoot(tester,
        TimelineScreen(store: store, entityId: miezi), '05-timeline');

    // Map with a soft placeholder tile (no network in tests).
    final tileFile =
        File('${Directory.systemTemp.path}/catlog_tile.png');
    final tile = img.Image(width: 256, height: 256);
    img.fill(tile, color: img.ColorRgb8(232, 238, 230));
    tileFile.writeAsBytesSync(img.encodePng(tile));
    await shoot(
        tester,
        MapScreen(
            store: store, tileProvider: _PastelTileProvider(tileFile)),
        '06-map');
  });
}
