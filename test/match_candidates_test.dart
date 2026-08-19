import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/match_candidates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #33: the candidates screen lists pairs and confirms them via Merge.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('an ID pair lists, merging keeps the chosen survivor',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'test';
    final missing = store.createCat('Minka');
    final sighted = store.createCat('Fundkatze');
    store.append(missing, Keys.userField('chipid'), '276 0981 0234 5678');
    store.append(sighted, Keys.userField('chipid'), '276098102345678');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MatchCandidatesScreen(store: store),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Minka · Fundkatze'), findsOneWidget);
    expect(find.text('Same Chip ID'), findsOneWidget);

    // Confirm: survivor is the sighted cat.
    await tester.tap(find.text('Minka · Fundkatze'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fundkatze').last);
    await tester.pumpAndSettle();

    expect(store.cats(), hasLength(1));
    expect(store.cats().single.id, sighted);
    expect(find.text('No match candidates right now.'), findsOneWidget);
  });
}
