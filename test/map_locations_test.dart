import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
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

/// Every location pins and every location has a trail: the built-in
/// position, a home's position, and a location field the keeper added.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late File tile;
  late CatalogStore store;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog_map_loc');
    tile = File('${dir.path}/tile.png')
      ..writeAsBytesSync(
        Uint8List.fromList(img.encodePng(img.Image(width: 1, height: 1))),
      );
    store = CatalogStore.inMemory()..author = 'anna';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  Future<void> pump(WidgetTester tester, {(String, String)? trailOf}) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MapScreen(
          store: store,
          tileProvider: _FakeTileProvider(tile),
          trailOf: trailOf,
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
  }

  int dots(WidgetTester tester) => tester
      .widgetList<MarkerLayer>(find.byType(MarkerLayer))
      .expand((l) => l.markers)
      .where((m) => m.width == 20)
      .length;

  testWidgets('a location field the keeper added pins with its name', (
    tester,
  ) async {
    store.defineField('Vet', FieldType.location);
    final vet = store.fieldDefs().firstWhere((d) => d.name == 'Vet');
    final cat = store.createCat('Miezi');
    store.append(cat, vet.key, '52.52,13.40');

    await pump(tester);
    expect(find.text('Miezi · Vet'), findsOneWidget);
    expect(find.byIcon(Icons.place), findsOneWidget);

    // Tap: its trail, one value so far.
    await tester.tap(find.text('Miezi · Vet'));
    await tester.pump();
    expect(find.textContaining('Trail: Miezi — Vet'), findsOneWidget);
    expect(dots(tester), 1);
  });

  testWidgets('opened from a row, the trail is on with dated dots', (
    tester,
  ) async {
    store.defineField('Vet', FieldType.location);
    final vet = store.fieldDefs().firstWhere((d) => d.name == 'Vet');
    final cat = store.createCat('Miezi');
    store.append(cat, vet.key, '52.52,13.40', date: DateTime.utc(2026, 1, 5));
    store.append(cat, vet.key, '52.53,13.41', date: DateTime.utc(2026, 3, 9));

    await pump(tester, trailOf: (cat, vet.key));
    expect(find.byType(PolylineLayer), findsOneWidget);
    expect(dots(tester), 2);
    expect(find.text('Trail: Miezi — Vet (2 values)'), findsOneWidget);

    // A dot names its date and author in the label.
    await tester.tap(find.byTooltip('2026-03-09'));
    await tester.pump();
    expect(find.textContaining('2026-03-09 · anna'), findsOneWidget);
  });

  testWidgets('a home has a trail too, and Open leads to its page', (
    tester,
  ) async {
    final home = store.createClowder('Home');
    store.recordPosition(home, 52.52, 13.40, date: DateTime.utc(2025, 1, 1));
    store.recordPosition(home, 52.60, 13.50, date: DateTime.utc(2026, 1, 1));

    await pump(tester);
    expect(find.byType(PolylineLayer), findsNothing);
    await tester.tap(find.text('Home'));
    await tester.pump();
    expect(find.byType(PolylineLayer), findsOneWidget);
    expect(find.text('Trail: Home (2 sightings)'), findsOneWidget);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsWidgets);
    expect(find.byType(MapScreen), findsNothing);
  });
}
