import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/flier_capture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

Uint8List _jpeg() =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: 8, height: 8)));

const _flierText = 'MISSING: Minka\n'
    'Chip 276 0981 0234 567-8\n'
    'Call 089 1234567 — reward!';

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
  });

  tearDown(() => store.close());

  test('chip and phone suggestions from OCR text', () {
    expect(suggestChipId(_flierText), '276098102345678');
    expect(suggestPhone(_flierText), '089 1234567');
    expect(suggestChipId('no ids here'), isNull);
    // The chip's digits never masquerade as the phone number.
    expect(suggestPhone('Chip 276 0981 0234 567-8'), isNull);
  });

  Future<void> pump(WidgetTester tester, {String? existingCatId}) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlierCaptureScreen(
        store: store,
        existingCatId: existingCatId,
        pickPhoto: (_) async => _jpeg(),
        locate: () async => (pos: (48.1, 11.5), failure: null),
        scan: (_) async => null,
        ocr: (_) async => _flierText,
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('a flier becomes an owner clowder and a missing stray',
      (tester) async {
    await pump(tester);
    // OCR prefilled the suggestions, all editable.
    expect(find.text('276098102345678'), findsOneWidget);
    await tester.enterText(
        find.widgetWithText(TextField, '').first, 'Minka');
    await tester.enterText(
        find.byType(TextField).at(2), 'Familie Huber');
    await tester.runAsync(() async {
      await tester.tap(find.byIcon(Icons.check).first);
      // Image compression hops through an isolate.
      await Future<void>.delayed(const Duration(milliseconds: 400));
    });
    await tester.pumpAndSettle();

    final cat = store.cats().single;
    expect(cat.name, 'Minka');
    // Stray now, but the owner clowder is in the history.
    expect(store.strays().single.id, cat.id);
    final clowder = store.clowders().single;
    expect(store.current(clowder.id, Keys.userField('status')), 'owner');
    expect(store.current(clowder.id, Keys.userField('responsible')),
        'Familie Huber');
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

  testWidgets('double-tapping save creates exactly one owner and cat',
      (tester) async {
    await pump(tester);
    await tester.runAsync(() async {
      // Two rapid taps on the save check while compression runs.
      await tester.tap(find.byIcon(Icons.check).first);
      await tester.pump();
      await tester.tap(find.byIcon(Icons.check).first, warnIfMissed: false);
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
    await tester.runAsync(() async {
      await tester.tap(find.byIcon(Icons.check).first);
      await Future<void>.delayed(const Duration(milliseconds: 400));
    });
    await tester.pumpAndSettle();

    expect(store.cats(), hasLength(1));
    expect(store.clowders(), isEmpty);
    expect(store.flierPositions(cat), [(48.1, 11.5)]);
    // Remarks appended below the existing note.
    expect(store.current(cat, Keys.userField('remarks')),
        'first flier\n$_flierText');
  });
}
