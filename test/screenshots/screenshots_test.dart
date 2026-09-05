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
import 'package:catlog/src/map/cached_tiles.dart';
import 'package:catlog/src/screens/map_screen.dart';
import 'package:catlog/src/screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catlog/src/screens/field_graph_screen.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/fur_background.dart';
import 'package:catlog/src/pet_mode.dart';

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
  store.append(miezi, 'f:color', 'white & ginger',
      date: DateTime.utc(2026, 5, 3));
  store.append(miezi, 'f:neutered', 'yes', date: DateTime.utc(2026, 6, 14));
  store.append(miezi, 'f:birthdate', '2026-03-01',
      date: DateTime.utc(2026, 5, 3));
  // A weight every fortnight — the graph page has a curve to show.
  for (final (i, grams) in [980, 1240, 1510, 1760, 2050, 2290, 2480, 2610]
      .indexed) {
    store.append(miezi, 'f:weight', '$grams',
        date: DateTime.utc(2026, 5, 3).add(Duration(days: 14 * i)));
  }
  store.createAppointment(Appointment(
    id: '',
    entity: miezi,
    date: DateTime.utc(2026, 9, 4),
    time: (hour: 10, minute: 30),
    title: 'Vaccination',
    notes: 'Bring the blue booklet',
    alert: AppointmentAlert.dayBefore,
  ));

  final balu =
      store.createCat('Balu', clowderId: home, date: DateTime.utc(2026, 5, 3));
  store.addImage(balu, photo(2), date: DateTime.utc(2026, 5, 3));
  store.append(balu, 'f:gender', 'male', date: DateTime.utc(2026, 5, 3));
  store.append(balu, 'f:color', 'black', date: DateTime.utc(2026, 5, 3));

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

/// A second catalog in pet mode: a household with a dog and a rabbit.
CatalogStore _petStore() {
  final store = CatalogStore.inMemory();
  store.author = 'Alex';
  setPetMode(store, true);
  final home = store.createClowder('Meadow Lane 3',
      date: DateTime.utc(2026, 6, 1));
  store.append(home, 'f:responsible', 'Jonas',
      date: DateTime.utc(2026, 6, 1));
  final rex = store.createCat('Rex',
      clowderId: home, date: DateTime.utc(2026, 6, 1), species: 'dog');
  store.append(rex, 'f:breed', 'Beagle', date: DateTime.utc(2026, 6, 1));
  store.append(rex, 'f:weight', '11200', date: DateTime.utc(2026, 6, 1));
  final hoppel = store.createCat('Hoppel',
      clowderId: home, date: DateTime.utc(2026, 6, 1), species: 'rabbit');
  store.append(hoppel, 'f:weight', '1850', date: DateTime.utc(2026, 6, 1));
  return store;
}

void main() {
  setUpAll(() async {
    useSystemSqlite();
    await _loadRealFonts();
  });

  // The coat under each page — pinned, so the shots are reproducible.
  const coats = {
    '01-home': FurPattern.tabby,
    '02-clowder': FurPattern.cheetah,
    '03-cat': FurPattern.rosettes,
    '04-card': FurPattern.paws,
    '05-timeline': FurPattern.tiger,
    '06-map': FurPattern.tabby,
    '07-graph': FurPattern.cheetah,
    '08-agenda': FurPattern.zebra,
    '09-pets': FurPattern.paws,
  };

  Future<void> shoot(WidgetTester tester, Widget home, String name,
      {Size physical = const Size(820, 1660), double dpr = 2}) async {
    tester.view.physicalSize = physical;
    tester.view.devicePixelRatio = dpr;
    addTearDown(tester.view.reset);
    activeFur = coats[name.substring(name.indexOf('-0') + 1)]!;
    final key = GlobalKey();
    await tester.pumpWidget(RepaintBoundary(
      key: key,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          scaffoldBackgroundColor: Colors.transparent,
        ),
        home: FurBackground(child: home),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 500));
    // Real time so Image.memory decoding and tile loading complete.
    for (var i = 0; i < 4; i++) {
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 400)));
      await tester.pump(const Duration(milliseconds: 300));
    }
    await tester.runAsync(() async {
      final boundary = key.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: dpr);
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
    final weight = store.fieldDefs().firstWhere((d) => d.slug == 'weight');
    await shoot(
        tester,
        FieldGraphScreen(store: store, entityId: miezi, def: weight),
        '07-graph');
    await shoot(tester, AgendaScreen(store: store), '08-agenda');
    final pets = _petStore();
    addTearDown(pets.close);
    final meadow = pets.clowders().single.id;
    petMode.value = true;
    await shoot(tester,
        ClowderDetailScreen(store: pets, clowderId: meadow), '09-pets');
    petMode.value = false;

    // Map with REAL pre-downloaded OSM tiles (test/screenshots/tiles,
    // fetched once by the tile script) — no network in tests.
    final tiles =
        DiskCachingTileProvider(Directory('test/screenshots/tiles'));
    await shoot(tester,
        MapScreen(store: store, tileProvider: tiles), '06-map');

    // Apple App Store sets: 6.9" iPhone (1320×2868 @3x) and 13" iPad
    // (2064×2752 @2x), into docs/screenshots/appstore/.
    Directory('docs/screenshots/appstore').createSync(recursive: true);
    const phone = Size(1320, 2868);
    const pad = Size(2064, 2752);
    final shots = <String, Widget Function()>{
      '01-home': () => ClowderListScreen(store: store),
      '02-clowder': () => ClowderDetailScreen(store: store, clowderId: home),
      '03-cat': () => CatDetailScreen(store: store, catId: miezi),
      '04-card': () => CardScreen(store: store, catId: miezi),
      '05-timeline': () => TimelineScreen(store: store, entityId: miezi),
      '06-map': () => MapScreen(store: store, tileProvider: tiles),
      '07-graph': () =>
          FieldGraphScreen(store: store, entityId: miezi, def: weight),
      '08-agenda': () => AgendaScreen(store: store),
      '09-pets': () => ClowderDetailScreen(store: pets, clowderId: meadow),
    };
    // Google Play set (9:16), into docs/screenshots/play/ — copied to
    // catlog-ops/play/shots by hand.
    Directory('docs/screenshots/play').createSync(recursive: true);
    // Play's 10-inch tablet set: 9:16, logical 720x1280 — a tablet's
    // worth of content, into docs/screenshots/tablet/.
    Directory('docs/screenshots/tablet').createSync(recursive: true);
    const play = Size(1080, 1920);
    const tablet = Size(1440, 2560);
    for (final entry in shots.entries) {
      petMode.value = entry.key == '09-pets';
      await shoot(tester, entry.value(), 'appstore/iphone-${entry.key}',
          physical: phone, dpr: 3);
      await shoot(tester, entry.value(), 'appstore/ipad-${entry.key}',
          physical: pad, dpr: 2);
      await shoot(tester, entry.value(), 'play/play-${entry.key}',
          physical: play, dpr: 3);
      await shoot(tester, entry.value(), 'tablet/tablet10-${entry.key}',
          physical: tablet, dpr: 2);
    }
    petMode.value = false;
  });
}
