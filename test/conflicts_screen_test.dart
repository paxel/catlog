import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Open conflicts are one menu item away while there are any, and the
/// item goes when the last one is settled.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('the menu lists open conflicts until they are settled', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    final other = CatalogStore.inMemory()..author = 'bob';
    addTearDown(store.close);
    addTearDown(other.close);

    final home = store.createClowder('Home');
    final cat = store.createCat('Miezi', clowderId: home);
    store.append(cat, 'f:color', 'white', date: DateTime.utc(2025, 1, 1));
    other.applyEntries(
      store.entriesSince(const {}),
      senderVector: store.versionVector(),
    );
    store.append(cat, 'f:color', 'black', date: DateTime.utc(2026, 1, 1));
    other.append(cat, 'f:color', 'grey', date: DateTime.utc(2026, 1, 2));
    store.applyEntries(
      other.entriesSince(store.versionVector()),
      senderVector: other.versionVector(),
    );
    expect(store.conflicts(), hasLength(1));

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    expect(find.text('Conflicts (1)'), findsOneWidget);

    await tester.tap(find.text('Conflicts (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Conflicts to resolve'), findsOneWidget);
    expect(find.textContaining('Miezi'), findsOneWidget);

    await tester.tap(find.textContaining('grey (bob)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Resolve'));
    await tester.pumpAndSettle();
    expect(store.conflicts(), isEmpty);
    // The last one settled closes the page; the menu item is gone.
    expect(find.text('Conflicts to resolve'), findsNothing);
    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    expect(find.textContaining('Conflicts'), findsNothing);
  });
}
