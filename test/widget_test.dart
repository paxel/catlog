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
}
