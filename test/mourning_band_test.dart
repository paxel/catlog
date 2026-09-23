import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/widgets/cat_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Trauerflor on the portrait of a deceased cat, photo or not.
void main() {
  setUpAll(useSystemSqlite);

  Finder band() => find.byWidgetPredicate(
      (w) => w is CustomPaint && w.painter is MourningBandPainter);

  testWidgets('a deceased cat wears the band, a living one does not',
      (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final alive = store.createCat('Miezi');
    final gone = store.createCat('Oma');
    store.append(gone, Keys.userField('deceased'), '2026-01-01');
    await tester.pumpWidget(MaterialApp(
      home: Row(children: [
        CatAvatar(store: store, catId: alive),
        CatAvatar(store: store, catId: gone),
      ]),
    ));
    await tester.pump();
    expect(band(), findsOneWidget);
    // On the placeholder too: no photo, still the band.
    expect(find.byIcon(Icons.pets), findsNWidgets(2));
  });

  test('the band never repaints: it is the same on every frame', () {
    expect(const MourningBandPainter().shouldRepaint(const MourningBandPainter()),
        isFalse);
  });
}
