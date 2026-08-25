import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/geocode.dart';
import 'package:catlog/src/map/place_view.dart';
import 'package:catlog/src/screens/map_screen.dart';
import 'package:catlog/src/screens/position_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// Serves one local PNG for every tile — no network in tests.
class _FakeTileProvider extends TileProvider {
  final File tile;
  _FakeTileProvider(this.tile);

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) =>
      FileImage(tile);
}

void main() {
  setUpAll(useSystemSqlite);

  testWidgets('map shows stray and clowder pins from positions',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_map');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));

    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    store.recordPosition(home, 52.52, 13.40);
    final stray = store.createCat('Roamer');
    store.recordPosition(stray, 52.53, 13.41);
    store.addImage(stray,
        CatalogStore.compressImage(Uint8List.fromList(
            img.encodeJpg(img.Image(width: 60, height: 60)))));

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(store: store, tileProvider: _FakeTileProvider(tile)),
    ));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Roamer'), findsOneWidget);
    expect(find.text('OpenStreetMap contributors'), findsOneWidget);
    // A stray WITH a photo shows its face ring, never the paw fallback.
    expect(find.byIcon(Icons.pets), findsNothing);

    // Tapping the stray pin shows its movement trail.
    store.recordPosition(stray, 52.54, 13.42);
    await tester.tap(find.text('Roamer'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('Trail: Roamer'), findsOneWidget);
    expect(find.textContaining('sightings'), findsOneWidget);
  });


  testWidgets('the stray-area overlay draws 500 m flier circles',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_area');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));

    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final missing = store.createCat('Minka');
    store.recordPosition(missing, 48.1, 11.5, kind: PositionKind.flier);

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(store: store, tileProvider: _FakeTileProvider(tile)),
    ));
    await tester.pump(const Duration(seconds: 1));

    // No circles until the overlay is toggled on.
    expect(find.byType(CircleLayer), findsNothing);
    await tester.tap(find.byTooltip('Possible stray area'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    // Close the sheet.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    final layer =
        tester.widget<CircleLayer>(find.byType(CircleLayer));
    expect(layer.circles, hasLength(1));
    expect(layer.circles.single.radius, 500.0);
    expect(layer.circles.single.useRadiusInMeter, isTrue);
  });

  testWidgets('a runaway stray gets a circle around the home it left',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_home');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));

    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Hof');
    store.recordPosition(home, 48.1, 11.5);
    // No flier anywhere — the home alone qualifies the cat.
    final runaway = store.createCat('Minka', clowderId: home);
    store.moveCat(runaway, null);

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(store: store, tileProvider: _FakeTileProvider(tile)),
    ));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byTooltip('Possible stray area'));
    await tester.pumpAndSettle();
    expect(find.text('Minka'), findsOneWidget);
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    final layer = tester.widget<CircleLayer>(find.byType(CircleLayer));
    expect(layer.circles, hasLength(1));
    expect(layer.circles.single.point.latitude, closeTo(48.1, 1e-6));
    expect(layer.circles.single.radius, 500.0);
  });

  testWidgets('a found place is shown at its own extent, not country zoom',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_zoom');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(
        store: store,
        initialCenter: const LatLng(51.0, 10.0),
        tileProvider: _FakeTileProvider(tile),
        geocode: (q) async => const [
          GeoHit('Grimmaische Straße, Leipzig', 51.3397, 12.3792,
              bounds: (51.3390, 51.3404, 12.3770, 12.3815)),
        ],
      ),
    ));
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(find.byType(TextField), 'Grimmaische');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Grimmaische Straße, Leipzig'));
    await tester.pump(const Duration(seconds: 1));

    final map = tester.widget<FlutterMap>(find.byType(FlutterMap));
    final camera = map.mapController!.camera;
    expect(camera.center.latitude, closeTo(51.3397, 1e-3));
    // A street, so street zoom — anything below 14 shows half a country.
    expect(camera.zoom, greaterThan(14));
  });

  testWidgets('two hits on the same spot never blow the zoom to infinity',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_samespot');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    // Two cats named alike, sighted at the identical position — the
    // search fit gets zero-size bounds (field crash: "Infinity or NaN
    // toInt" on every later tile update).
    for (final name in ['Miezi', 'Miezi II']) {
      final cat = store.createCat(name);
      store.recordPosition(cat, 51.34, 12.37,
          kind: PositionKind.sighting);
    }

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(
          store: store, tileProvider: _FakeTileProvider(tile)),
    ));
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(find.byType(TextField), 'Miezi');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump(const Duration(seconds: 1));

    final map = tester.widget<FlutterMap>(find.byType(FlutterMap));
    final camera = map.mapController!.camera;
    expect(camera.zoom.isFinite, isTrue);
    expect(camera.zoom, lessThanOrEqualTo(17));
    expect(tester.takeException(), isNull);
  });

  testWidgets('a poisoned stored viewport is rejected, not restored',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_poison');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    // double.tryParse accepts this — a crashed camera would otherwise
    // crash the map on every open, forever.
    store.setLocalSetting(mapViewportKey, '51.34,12.37,Infinity');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(
          store: store, tileProvider: _FakeTileProvider(tile)),
    ));
    await tester.pump(const Duration(seconds: 1));

    final map = tester.widget<FlutterMap>(find.byType(FlutterMap));
    expect(map.mapController!.camera.zoom.isFinite, isTrue);
    expect(tester.takeException(), isNull);
  });

  test('navChain walks pins nearest-neighbor from the start', () {
    const a = EntityView('cat:a', 'A');
    const b = EntityView('cat:b', 'B');
    const c = EntityView('cat:c', 'C');
    final chain = navChain([
      (a, const LatLng(48.30, 11.5)),
      (b, const LatLng(48.10, 11.5)),
      (c, const LatLng(48.20, 11.5)),
    ], const LatLng(48.0, 11.5));
    expect(chain.map((e) => e.$1.name), ['B', 'C', 'A']);
  });

  testWidgets('map search falls back to places when the catalog is empty',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_geo');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(
        store: store,
        tileProvider: _FakeTileProvider(tile),
        geocode: (q) async =>
            [GeoHit('Leipzig, Sachsen', 51.34, 12.37)],
      ),
    ));
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(find.byType(TextField), 'Leipzig');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Leipzig, Sachsen'), findsOneWidget);
  });

  testWidgets('the map reopens at the stored viewport', (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_vp');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    // A pinned clowder elsewhere would win without the stored viewport.
    final home = store.createClowder('Home');
    store.recordPosition(home, 40.0, 9.0);
    store.setLocalSetting(mapViewportKey, '51.34,12.37,14.0');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MapScreen(store: store, tileProvider: _FakeTileProvider(tile)),
    ));
    await tester.pump(const Duration(seconds: 1));
    final map = tester.widget<FlutterMap>(find.byType(FlutterMap));
    expect(map.options.initialCenter.latitude, closeTo(51.34, 1e-6));
    expect(map.options.initialZoom, 14.0);
  });

  testWidgets('picker geocode search jumps the map via the stub',
      (tester) async {
    final dir = Directory.systemTemp.createTempSync('catlog_picker');
    addTearDown(() => dir.deleteSync(recursive: true));
    final tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(Uint8List.fromList(
          img.encodePng(img.Image(width: 1, height: 1))));

    final queries = <String>[];
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PositionPickerScreen(
        tileProvider: _FakeTileProvider(tile),
        geocode: (q) async {
          queries.add(q);
          return const [GeoHit('Lisbon, Portugal', 38.72, -9.14)];
        },
      ),
    ));
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(find.byType(TextField), 'Lisbon');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump(const Duration(seconds: 1));

    expect(queries, ['Lisbon']);
    expect(find.text('Lisbon, Portugal'), findsOneWidget);

    await tester.tap(find.text('Lisbon, Portugal'));
    await tester.pump(const Duration(seconds: 1));
    // Result list gone; the map moved (no pin dropped yet, save disabled).
    expect(find.text('Lisbon, Portugal'), findsNothing);
    // Close enough to drop a pin, not a country view.
    final map = tester.widget<FlutterMap>(find.byType(FlutterMap));
    expect(map.mapController!.camera.zoom, placeZoom);
  });
}
