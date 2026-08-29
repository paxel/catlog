import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catlog/src/screens/clowder_card_screen.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

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

  testWidgets('a registry QR carries the search link, the caption the id',
      (tester) async {
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    store.defineField('Tasso', FieldType.id,
        scope: FieldScope.cat,
        idDisplay: IdDisplay.qr,
        lookupUrl: 'https://www.tasso.net/Tierregister/Suchmeldungen?snr={value}');
    final tasso = store.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    store.append(cat, tasso.key, 'S2983764');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CardScreen(store: store, catId: cat),
    ));
    await tester.pumpAndSettle();

    expect(cardQrPayload(tasso, 'S2983764'),
        'https://www.tasso.net/Tierregister/Suchmeldungen?snr=S2983764');
    final plain = store.fieldDefs().firstWhere((d) => d.slug == 'chipid');
    expect(cardQrPayload(plain, '276098102345678'), '276098102345678');
    expect(find.text('Tasso: S2983764'), findsOneWidget);
  });

  testWidgets('the card photo is decoded at card size', (tester) async {
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    store.addImage(cat, CatalogStore.compressImage(Uint8List.fromList(
        img.encodeJpg(img.Image(width: 300, height: 200)))));
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CardScreen(store: store, catId: cat),
    ));
    await tester.pumpAndSettle();
    final photos = tester
        .widgetList<Image>(find.byType(Image))
        .where((w) => w.image is ResizeImage);
    expect(photos, isNotEmpty);
  });

  test('a roster thumbnail is 240 px wide', () {
    final big = Uint8List.fromList(
        img.encodeJpg(img.Image(width: 1200, height: 900)));
    final small = pdfThumbnail(big);
    expect(img.decodeImage(small)!.width, 240);
    expect(small.length, lessThan(big.length));
  });
}
