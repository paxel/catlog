import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/main.dart';
import 'package:flutter/material.dart';
import 'package:catlog/src/conflict_dialog.dart';
import 'package:catlog/src/field_labels.dart';
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

  testWidgets('two entries with the same value: nothing to pick', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    final other = CatalogStore.inMemory()..author = 'bob';
    addTearDown(store.close);
    addTearDown(other.close);
    final cat = store.createCat('Miezi');
    store.append(cat, 'f:deceased', '2025-01-01', date: DateTime.utc(2025, 1, 1));
    other.applyEntries(
      store.entriesSince(const {}),
      senderVector: store.versionVector(),
    );
    store.append(cat, 'f:deceased', '2026-02-02', date: DateTime.utc(2026, 1, 1));
    other.append(cat, 'f:deceased', '2026-02-02', date: DateTime.utc(2026, 1, 2));
    store.applyEntries(
      other.entriesSince(store.versionVector()),
      senderVector: other.versionVector(),
    );
    // Same value on both sides: no conflict is raised at all.
    expect(store.conflicts(), isEmpty);
    // One raised anyway (an older version did): the dialog says so.
    store.append(cat, Keys.conflict('f:deceased'), 'open');
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            ctx = context;
            return const SizedBox();
          },
        ),
      ),
    );
    final done = showConflictDialog(ctx, store, cat, 'f:deceased');
    await tester.pumpAndSettle();
    expect(find.textContaining('Both changes say the same'), findsOneWidget);
    expect(find.byType(RadioListTile<int?>), findsNothing);
    await tester.tap(find.text('Resolve'));
    await tester.pumpAndSettle();
    expect(await done, isTrue);
    expect(store.conflicts(), isEmpty);
  });

  testWidgets('a position in a history or conflict reads as coordinates', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    store.recordPosition(cat, 52.52, 13.405);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Text(
            valueLabel(
              AppLocalizations.of(context)!,
              store,
              CatalogStore.positionKey,
              store.current(cat, CatalogStore.positionKey),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('52.52000, 13.40500 · '), findsOneWidget);
    expect(find.textContaining('9F4MGCC4'), findsOneWidget);
  });
}
