import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/fur_background.dart';
import 'package:catlog/src/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Coats: six from the start, five earned by full months, a favourite
/// pinned in Settings or a random one each launch.
void main() {
  setUpAll(useSystemSqlite);
  tearDown(() => activeFur = FurPattern.cheetah);

  test('earned coats join in order, the favourite wins when earned', () {
    expect(coatsAvailable(0), baseCoats);
    expect(coatsAvailable(2), [
      ...baseCoats,
      FurPattern.calico,
      FurPattern.snowLeopard,
    ]);
    expect(coatsAvailable(99).length, FurPattern.values.length);
    // A favourite not yet earned falls back to the pool.
    expect(pickCoat(favourite: 'lynx', fullMonths: 0), isIn(baseCoats));
    expect(pickCoat(favourite: 'lynx', fullMonths: 4), FurPattern.lynx);
    expect(
      pickCoat(favourite: 'nonsense', fullMonths: 4),
      isIn(coatsAvailable(4)),
    );
    expect(activeFur, isIn(coatsAvailable(4)));
  });

  testWidgets('Settings pins a favourite and applies it at once', (
    tester,
  ) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsScreen(store: store),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('A different one each start'), findsOneWidget);
    await tester.tap(find.text('Coat'));
    await tester.pumpAndSettle();
    // Nothing earned: the six base coats only.
    expect(find.text('Calico'), findsNothing);
    await tester.tap(find.text('Zebra'));
    await tester.pumpAndSettle();
    expect(store.localSetting('furFavourite'), 'zebra');
    expect(activeFur, FurPattern.zebra);
    expect(find.text('Zebra'), findsOneWidget);
  });
}
