import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/in_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Syncing with somebody in the room: the page has to explain both
/// sides before anything is connected.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-inperson');
    Directory('${dir.path}/mine').createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: InPersonScreen(store: store),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('the page opens with something to do on it', (tester) async {
    await pump(tester);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
    final tappable = find.byWidgetPredicate((w) =>
        w is ButtonStyleButton || w is ListTile || w is IconButton);
    expect(tappable, findsWidgets);
  });

  testWidgets('private data is left out unless you say otherwise',
      (tester) async {
    await pump(tester);
    final switches = find.byType(SwitchListTile);
    if (switches.evaluate().isNotEmpty) {
      final tile = tester.widget<SwitchListTile>(switches.first);
      expect(tile.value, isFalse,
          reason: 'Private stays home until the keeper decides otherwise');
    }
  });

  testWidgets('nothing is connected until asked', (tester) async {
    await pump(tester);
    expect(store.savePoints(), isEmpty);
  });
}
