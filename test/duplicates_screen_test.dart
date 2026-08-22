import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/duplicates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #45: the duplicates screen lists twins and resolves them via Merge.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('same-name cats surface and merge to the chosen survivor',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'test';
    final keeper = store.createCat('Miezi');
    store.createCat('miezi');
    store.createClowder('Home');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: DuplicatesScreen(store: store),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Miezi · miezi'), findsOneWidget);
    expect(find.text('Same Name'), findsOneWidget);

    await tester.tap(find.text('Miezi · miezi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi').last);
    await tester.pumpAndSettle();
    // The irreversibility confirmation guards every merge.
    expect(find.textContaining('cannot be undone'), findsOneWidget);
    await tester.tap(find.text('Merge'));
    await tester.pumpAndSettle();

    expect(store.cats(), hasLength(1));
    expect(store.cats().single.id, keeper);
    expect(find.text('No possible duplicates right now.'),
        findsOneWidget);
  });
}
