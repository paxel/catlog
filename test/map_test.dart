import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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

    await tester.pumpWidget(MaterialApp(
      home: MapScreen(store: store, tileProvider: _FakeTileProvider(tile)),
    ));
    await tester.pump(const Duration(seconds: 1));

    expect(find.byTooltip('Home'), findsOneWidget);
    expect(find.byTooltip('Roamer'), findsOneWidget);
    expect(find.text('OpenStreetMap contributors'), findsOneWidget);

    // Tapping the stray pin shows its movement trail.
    store.recordPosition(stray, 52.54, 13.42);
    await tester.tap(find.byTooltip('Roamer'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('Trail: Roamer'), findsOneWidget);
    expect(find.textContaining('sightings'), findsOneWidget);
  });
}
