import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/undo_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Going back removes only what the file holds: if the catalog changed
/// while the file was being saved, nothing is removed.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('a change during the save stops the removal', (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    store.createCat('Old');
    final before = store.currentSeq();
    store.createCat('Imported');
    final point = momentFor(store,
        before: before, changed: true, cause: MomentCause.sync)!;
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Builder(builder: (c) {
        context = c;
        return const SizedBox();
      })),
    ));
    bool? result;
    confirmGoBack(context, store, point, saveTo: (path, name) async {
      // A sync lands while the file is on its way.
      store.createCat('Meanwhile');
      return path;
    }).then((r) => result = r);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(result, isFalse);
    expect(store.cats().map((c) => c.name),
        containsAll(['Old', 'Imported', 'Meanwhile']));
    expect(find.textContaining('Nothing was removed'), findsOneWidget);
  });
}
