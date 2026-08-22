import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// An ID field takes whatever a scanner reads. Code128 cannot carry all
/// of it, and the card must survive that.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store;
  late String cat;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-card');
    store = CatalogStore.open('${dir.path}/catlog.db')..author = 'test';
    cat = store.createCat('Miezi');
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  test('a chip number prints as bars; text Code128 cannot carry does not',
      () {
    expect(printsAsCode128('276098102345678'), isTrue);
    expect(printsAsCode128('SD-3101849'), isTrue);
    expect(printsAsCode128('ÄÖÜ 1234'), isFalse);
    expect(printsAsCode128(''), isFalse);
  });

  testWidgets('a value Code128 cannot carry still reaches the card',
      (tester) async {
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    store.append(cat, Keys.userField('chipid'), 'ÄÖÜ 1234');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CardScreen(store: store, catId: cat),
    ));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.textContaining('ÄÖÜ 1234'), findsWidgets);
  });
}
