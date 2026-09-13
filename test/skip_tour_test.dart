import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/author_setup_screen.dart';
import 'package:catlog/src/spotlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The tester's tick on the name page: intro and every tip count as
/// seen; without the tick nothing is marked.
void main() {
  setUpAll(useSystemSqlite);

  Future<void> pump(
    WidgetTester tester,
    CatalogStore store,
    VoidCallback done,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AuthorSetupScreen(store: store, onDone: done),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('ticked, the intro and all tips are marked seen', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    var done = 0;
    await pump(tester, store, () => done++);
    await tester.enterText(find.byType(TextField), 'Anna');
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(done, 1);
    expect(store.author, 'Anna');
    expect(store.localSetting('introSeen'), '1');
    for (final screen in spotlightManifest.keys) {
      expect(
        store.localSetting('spot2:$screen'),
        contains(spotlightManifest[screen]!.first.id),
      );
    }
  });

  testWidgets('unticked, nothing is marked', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    await pump(tester, store, () {});
    await tester.enterText(find.byType(TextField), 'Anna');
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(store.localSetting('introSeen'), isNull);
    expect(store.localSetting('spot2:home'), isNull);
  });
}
