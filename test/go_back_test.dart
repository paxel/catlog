import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/go_back_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The moments the catalog changed shape, as sentences, with a way back.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late Directory saved;
  late CatalogStore store;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-goback');
    Directory('${dir.path}/mine').createSync();
    saved = Directory('${dir.path}/saved')..createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  Future<String> saveTo(String path, String name) async {
    final to = '${saved.path}/$name';
    File(path).copySync(to);
    return to;
  }

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: GoBackScreen(store: store, saveTo: saveTo),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('every moment reads as a sentence with a date',
      (tester) async {
    store.addSavePoint(
        cause: SaveCause.import, label: 'catlog-backup.catsync');
    store.addSavePoint(cause: SaveCause.merge);
    await pump(tester);

    expect(find.text('Before importing'), findsOneWidget);
    expect(find.textContaining('catlog-backup.catsync'), findsOneWidget);
    expect(find.text('Before merging'), findsOneWidget);
  });

  testWidgets('the list is grouped by month', (tester) async {
    store.addSavePoint(
        cause: SaveCause.manual, label: 'in March', at: DateTime(2026, 3, 4));
    store.addSavePoint(
        cause: SaveCause.manual, label: 'in April', at: DateTime(2026, 4, 9));
    await pump(tester);
    expect(find.text('March 2026'), findsOneWidget);
    expect(find.text('April 2026'), findsOneWidget);
  });

  testWidgets('older moments are behind a control', (tester) async {
    for (var i = 0; i < recentMoments + 3; i++) {
      store.addSavePoint(cause: SaveCause.manual, label: 'moment $i');
    }
    await pump(tester);
    expect(find.text('moment 0'), findsNothing);
    await tester.scrollUntilVisible(find.text('Show older'), 300);
    await tester.tap(find.text('Show older'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('moment 0'), 200);
    expect(find.text('moment 0'), findsOneWidget);
  });

  testWidgets('going back restores the catalog and says what it costs',
      (tester) async {
    final cat = store.createCat('Miezi');
    store.addSavePoint(cause: SaveCause.manual, label: 'before the trip');
    store.append(cat, Keys.userField('color'), 'black');
    store.createCat('Mausi');
    await pump(tester);

    await tester.tap(find.text('Go back to here'));
    await tester.pumpAndSettle();
    expect(find.textContaining('keep their copy'), findsOneWidget);
    expect(find.textContaining('newer than this one'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Go back to here'));
    await tester.pumpAndSettle();

    expect(store.cats().map((c) => c.name), ['Miezi']);
    expect(store.current(cat, Keys.userField('color')), isNull);
    expect(saved.listSync().whereType<File>(), hasLength(1));
  });

  testWidgets('cancelling changes nothing', (tester) async {
    store.addSavePoint(cause: SaveCause.manual, label: 'before the trip');
    store.createCat('Mausi');
    await pump(tester);
    await tester.tap(find.text('Go back to here'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();
    expect(store.cats().map((c) => c.name), ['Mausi']);
  });

  testWidgets('a moment can be marked by hand', (tester) async {
    await pump(tester);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Before the Paris trip');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Before the Paris trip'), findsOneWidget);
  });

  testWidgets('the page explains itself', (tester) async {
    await pump(tester);
    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();
    expect(find.textContaining('The moments this catalog changed shape'),
        findsOneWidget);
  });
}
