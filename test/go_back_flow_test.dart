import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/main.dart' show CatlogApp;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Going back from the catalog's settings must show on the home screen
/// the moment you return to it — a home that still lists the world as
/// it was before going back says "nothing happened".
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late CatalogManager catalogs;
  late CatalogStore store;

  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-goback');
    catalogs = CatalogManager.open(root.path, defaultName: 'Berlin');
    store = catalogs.openStore(catalogs.active)..author = 'test';
  });

  tearDown(() {
    store.close();
    catalogs.close();
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  testWidgets('the home shows the restored cat after going back', (
    tester,
  ) async {
    final home = store.createClowder('Hinterhof');
    store.createCat('Miezi', clowderId: home);
    final before = store.currentSeq();
    // What a sync with an old device did: the cat and its home deleted.
    final moment = momentFor(
      store,
      before: before,
      changed: true,
      cause: MomentCause.sync,
      label: 'ipad',
    );
    store.deleteClowder(home);
    expect(store.clowders(), isEmpty);

    await tester.pumpWidget(CatlogApp(store: store, catalogs: catalogs));
    await tester.pumpAndSettle();
    expect(find.text('Hinterhof'), findsNothing);

    // Into the catalog's settings, as the keeper goes.
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Manage catalogs'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Go back'), findsOneWidget);

    // The go-back itself, as the confirmation applies it once the file
    // is written: the catalog is back to before the sync.
    applyGoBack(store, moment!);
    expect(store.clowders().map((c) => c.name), ['Hinterhof']);

    // Back out to the home screen: it must show the world as it is now.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Hinterhof'), findsOneWidget);
  });
}
