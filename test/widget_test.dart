import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(useSystemSqlite);

  testWidgets('first launch asks for author, then shows clowder list',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);

    await tester.pumpWidget(CatlogApp(store: store));
    expect(find.text('Your name'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'axel');
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    expect(store.author, 'axel');
    expect(find.text('Clowders'), findsOneWidget);
  });

  testWidgets('creating a clowder shows it in the list', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.byTooltip('New clowder'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Foster Home South');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    // Detail screen opens for the new clowder.
    expect(find.text('Foster Home South'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);

    // Back on the list it is present too.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Foster Home South'), findsOneWidget);
  });

  testWidgets('adding a cat shows it in the clowder grid', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    store.createCat('Miezi', clowderId: home);

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Cats'), findsOneWidget);
    expect(find.text('Miezi'), findsOneWidget);

    // Open the cat and rename it; the change is authored and historic.
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Rename'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Mizzi');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Mizzi'), findsOneWidget);
    final cat = store.cats(clowderId: home).single;
    expect(store.fieldHistory(cat.id, Keys.name).length, 2);
  });

  testWidgets('setting a choice field and seeing it on the timeline',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    store.createCat('Miezi', clowderId: home);

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();

    // Set gender via the typed editor.
    await tester.tap(find.text('Gender'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('female'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('female'), findsOneWidget);

    // Timeline lists the change with the author.
    await tester.tap(find.byTooltip('Timeline'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Gender: female'), findsOneWidget);
    expect(find.textContaining('axel'), findsWidgets);
  });
}
