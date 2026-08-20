import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/flier_capture.dart';
import 'package:catlog/src/geocode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

Uint8List _jpeg() =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: 8, height: 8)));

const _flierText = 'MISSING: Minka\n'
    'Chip 276 0981 0234 567-8\n'
    'Call 089 1234567 — reward!';

const _tassoUrl = 'https://www.tasso.net/Tierregister/Suchmeldungen'
    '?lang=de-DE&snr=S3101849&lp=0';

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
  });

  tearDown(() => store.close());

  test('chip, phone and mail suggestions from OCR text', () {
    expect(suggestChipId(_flierText), '276098102345678');
    expect(suggestPhone(_flierText), '089 1234567');
    expect(suggestChipId('no ids here'), isNull);
    // The chip's digits never masquerade as the phone number.
    expect(suggestPhone('Chip 276 0981 0234 567-8'), isNull);
    expect(suggestEmail('write to finder@example.org please'),
        'finder@example.org');
    expect(suggestEmail(_flierText), isNull);
  });

  test('registry hits are recognized once per number', () {
    final hits = registryHitsIn([_tassoUrl, _tassoUrl, 'https://x.example']);
    expect(hits, hasLength(1));
    expect(hits.single.serviceName, 'Tasso');
    expect(hits.single.value, 'S3101849');
    expect(hits.single.take, isTrue);
  });

  Future<void> pump(WidgetTester tester,
      {String? existingCatId,
      String text = _flierText,
      List<String> codes = const []}) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlierCaptureScreen(
        store: store,
        existingCatId: existingCatId,
        pickPhoto: (_) async => _jpeg(),
        locate: () async => (pos: (48.1, 11.5), failure: null),
        scan: (_) async => null,
        ocr: (_) async => text,
        codes: (_) async => codes,
        geocode: (q) async => [GeoHit('Somewhere', 48.2, 11.6)],
      ),
    ));
    await tester.pumpAndSettle();
  }

  /// Walks the wizard to its last page.
  Future<void> toReview(WidgetTester tester) async {
    while (find.text('Save').evaluate().isEmpty) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
  }

  Future<void> save(WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.tap(find.byTooltip('Save'));
      // Image compression hops through an isolate.
      await Future<void>.delayed(const Duration(milliseconds: 500));
    });
    await tester.pumpAndSettle();
  }

  testWidgets('a flier becomes an owner clowder and a missing stray',
      (tester) async {
    await pump(tester);
    // Step one prefilled by OCR, everything editable.
    expect(find.text('276098102345678'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'Minka');
    // Owner step.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Familie Huber');
    await save(tester);

    final cat = store.cats().single;
    expect(cat.name, 'Minka');
    // Stray now, but the owner clowder is in the history.
    expect(store.strays().single.id, cat.id);
    final clowder = store.clowders().single;
    expect(store.current(clowder.id, Keys.userField('status')), 'owner');
    expect(store.current(clowder.id, Keys.userField('responsible')),
        'Familie Huber');
    // Contact goes into its own field, not only into the text.
    expect(store.current(clowder.id, Keys.userField('phone')),
        '089 1234567');
    // The owner card carries the flier text itself.
    expect(store.current(clowder.id, Keys.userField('remarks')),
        contains('MISSING: Minka'));
    // Flier position recorded as flier kind — off the sighting map.
    expect(store.flierPositions(cat.id), [(48.1, 11.5)]);
    expect(store.sightingPositionOf(cat.id), isNull);
    // Chip, remarks, and the provenance photo made it.
    expect(store.current(cat.id, Keys.userField('chipid')),
        '276098102345678');
    expect(store.current(cat.id, Keys.userField('remarks')),
        contains('MISSING: Minka'));
    expect(store.images(cat.id), isNotEmpty);
  });

  testWidgets('a nameless owner is named after the cat', (tester) async {
    await pump(tester);
    await tester.enterText(find.byType(TextField).first, 'Minka');
    await save(tester);
    expect(store.clowders().single.name, 'Owner of Minka');
  });

  testWidgets('double-tapping save creates exactly one owner and cat',
      (tester) async {
    await pump(tester);
    final saveSpot = tester.getCenter(find.byIcon(Icons.check).first);
    await tester.runAsync(() async {
      // Two rapid taps on the save spot while compression runs — the
      // second lands on the (now spinning, disabled) button.
      await tester.tapAt(saveSpot);
      await tester.pump();
      await tester.tapAt(saveSpot);
      await Future<void>.delayed(const Duration(milliseconds: 500));
    });
    await tester.pumpAndSettle();
    expect(store.cats(), hasLength(1));
    expect(store.clowders(), hasLength(1));
  });

  testWidgets('add flier to an existing cat appends, never re-creates',
      (tester) async {
    final cat = store.createCat('Minka');
    store.append(cat, Keys.userField('remarks'), 'first flier');
    await pump(tester, existingCatId: cat);
    await save(tester);

    expect(store.cats(), hasLength(1));
    expect(store.clowders(), isEmpty);
    expect(store.flierPositions(cat), [(48.1, 11.5)]);
    // Remarks appended below the existing note.
    expect(store.current(cat, Keys.userField('remarks')),
        'first flier\n$_flierText');
  });

  testWidgets('a Tasso link on the poster becomes a looked-up ID field',
      (tester) async {
    await pump(tester, text: 'MISSING: Minka\nInfos: $_tassoUrl');
    await toReview(tester);
    // The recognized number is listed on the review page, pre-ticked.
    expect(find.textContaining('S3101849'), findsWidgets);
    await save(tester);

    final cat = store.cats().single;
    final def = store.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    expect(def.type, FieldType.id);
    expect(store.current(cat.id, def.key), 'S3101849');
    // The field knows where to look the number up.
    expect(lookupUrl(def, 'S3101849'),
        'https://www.tasso.net/Tierregister/Suchmeldungen?snr=S3101849');
  });

  testWidgets('a QR code on the poster counts as a link too',
      (tester) async {
    await pump(tester, text: 'MISSING: Minka', codes: [_tassoUrl]);
    await save(tester);
    final cat = store.cats().single;
    final def = store.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    expect(store.current(cat.id, def.key), 'S3101849');
  });

  testWidgets('the address can be turned into a position for the owner',
      (tester) async {
    await pump(tester);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, '').last, 'Main St 1');
    await tester.tap(find.text('Find address on the map'));
    await tester.pumpAndSettle();
    expect(find.text('Address found'), findsOneWidget);
    await save(tester);

    final clowder = store.clowders().single;
    expect(store.positionOf(clowder.id), (48.2, 11.6));
  });
}
