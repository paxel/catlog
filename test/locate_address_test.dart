import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/geocode.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The clowder page turns its Address into a Position on request (#81),
/// naming the place it found — or that it found none.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String home;
  setUp(() {
    store = CatalogStore.inMemory()..author = 'test';
    home = store.createClowder('Hühnerecken');
    store.append(home, Keys.userField('address'), 'Hauptstraße 1, Merzig');
  });
  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, GeocodeSearch geocode) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ClowderDetailScreen(
          store: store,
          clowderId: home,
          geocode: geocode,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a found address is offered in a dialog; OK adds the position',
      (tester) async {
    await pump(
      tester,
      (q) async => [const GeoHit('Merzig, Saarland', 49.44, 6.64)],
    );
    expect(store.positionOf(home), isNull);
    await tester.tap(find.text('Find address on the map'));
    await tester.pumpAndSettle();
    // Nothing is written before the dialog is answered.
    expect(store.positionOf(home), isNull);
    expect(find.text('Address found'), findsOneWidget);
    expect(find.text('Merzig, Saarland'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(store.positionOf(home), (49.44, 6.64));
    // The address stays as typed unless asked to replace it.
    expect(store.current(home, Keys.userField('address')),
        'Hauptstraße 1, Merzig');
  });

  testWidgets('ticking the offer replaces the address with the found one',
      (tester) async {
    await pump(
      tester,
      (q) async => [const GeoHit('Merzig, Saarland', 49.44, 6.64)],
    );
    await tester.tap(find.text('Find address on the map'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Replace the address with this'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(store.current(home, Keys.userField('address')),
        'Merzig, Saarland');
    expect(store.positionOf(home), (49.44, 6.64));
  });

  testWidgets('cancelling the dialog writes nothing', (tester) async {
    await pump(
      tester,
      (q) async => [const GeoHit('Merzig, Saarland', 49.44, 6.64)],
    );
    await tester.tap(find.text('Find address on the map'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(store.positionOf(home), isNull);
    expect(store.current(home, Keys.userField('address')),
        'Hauptstraße 1, Merzig');
  });

  testWidgets('no hit leaves the position alone and says so', (tester) async {
    await pump(tester, (q) async => []);
    await tester.tap(find.text('Find address on the map'));
    await tester.pumpAndSettle();
    expect(store.positionOf(home), isNull);
    expect(find.textContaining('No place found'), findsOneWidget);
  });
}
