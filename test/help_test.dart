import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/help.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:catlog/src/spotlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Help is always one tap away and explains the page you are on.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
  });

  tearDown(() => store.close());

  test('every screen with tips also has a help text', () {
    for (final screen in spotlightManifest.keys) {
      expect(helpTexts.containsKey(screen), isTrue,
          reason: '$screen has tips but no help');
    }
  });

  testWidgets('the help button explains the page and replays its tips',
      (tester) async {
    // Tips already seen: the sheet's button must bring them back.
    store.setLocalSetting('spot2:home', 'home-strays,home-sync,home-menu');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ClowderListScreen(store: store),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();
    expect(find.text('Help'), findsOneWidget);
    expect(find.textContaining('a clowder is a place where cats live'),
        findsOneWidget);

    await tester.tap(find.text('Show tips again'));
    await tester.pumpAndSettle();
    expect(store.localSetting('spot2:home'), isNull);
  });
}
