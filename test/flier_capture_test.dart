import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/flier_capture.dart';
import 'package:catlog/src/flier_ocr.dart';
import 'package:catlog/src/flier_template.dart';
import 'package:catlog/src/geocode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import 'flier_fixtures.dart';

Uint8List _jpeg() =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: 8, height: 8)));

const _flierText =
    'MISSING: Minka\n'
    'Chip 276 0981 0234 567-8\n'
    'Call 089 1234567 — reward!';

const _tassoUrl =
    'https://www.tasso.net/Tierregister/Suchmeldungen'
    '?lang=de-DE&snr=S3101849&lp=0';

final _templates = FlierTemplateSet.fromJson(
  File('assets/fliers/templates.json').readAsStringSync(),
);

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
    expect(
      suggestEmail('write to finder@example.org please'),
      'finder@example.org',
    );
    expect(suggestEmail(_flierText), isNull);
  });

  test('registry hits are recognized once per number', () {
    final hits = registryHitsIn([_tassoUrl, _tassoUrl, 'https://x.example']);
    expect(hits, hasLength(1));
    expect(hits.single.serviceName, 'Tasso');
    expect(hits.single.value, 'S3101849');
    expect(hits.single.take, isTrue);
  });

  Future<void> pump(
    WidgetTester tester, {
    String? existingCatId,
    String text = _flierText,
    List<FlierLine> lines = const [],
    FlierCodes codes = FlierCodes.none,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: FlierCaptureScreen(
          store: store,
          existingCatId: existingCatId,
          pickPhoto: (_) async => _jpeg(),
          locate: () async => (pos: (48.1, 11.5), failure: null),
          scan: (_) async => null,
          ocr: (_) async => FlierText(text, lines),
          codes: (_) async => codes,
          geocode: (q) async => [GeoHit('Somewhere', 48.2, 11.6)],
          templates: () async => _templates,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> next(WidgetTester tester) async {
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
  }

  /// Walks the wizard to its last page.
  Future<void> toReview(WidgetTester tester) async {
    while (find.text('Save').evaluate().isEmpty) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
  }

  /// Saves from the last page — the only page that can.
  Future<void> save(WidgetTester tester) async {
    await toReview(tester);
    await tester.runAsync(() async {
      await tester.tap(find.widgetWithText(FilledButton, 'Save').last);
      // Image compression hops through an isolate.
      await Future<void>.delayed(const Duration(milliseconds: 500));
    });
    await tester.pumpAndSettle();
  }

  testWidgets('a flier becomes an owner clowder and a missing stray', (
    tester,
  ) async {
    await pump(tester);
    // The text page lists every line; nothing is a field yet.
    expect(find.text('MISSING: Minka'), findsOneWidget);
    await next(tester);
    // Cat page prefilled by OCR, everything editable.
    expect(find.text('276098102345678'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'Minka');
    // Owner step.
    await next(tester);
    await tester.enterText(find.byType(TextField).first, 'Familie Huber');
    await save(tester);

    final cat = store.cats().single;
    expect(cat.name, 'Minka');
    // Stray now, but the owner clowder is in the history.
    expect(store.strays().single.id, cat.id);
    final clowder = store.clowders().single;
    expect(store.current(clowder.id, Keys.userField('status')), 'owner');
    expect(
      store.current(clowder.id, Keys.userField('responsible')),
      'Familie Huber',
    );
    // Contact goes into its own field, not only into the text.
    expect(store.current(clowder.id, Keys.userField('phone')), '089 1234567');
    // The owner card carries the flier text itself.
    expect(
      store.current(clowder.id, Keys.userField('remarks')),
      contains('MISSING: Minka'),
    );
    // Flier position recorded as flier kind — off the sighting map.
    expect(store.flierPositions(cat.id), [(48.1, 11.5)]);
    expect(store.sightingPositionOf(cat.id), isNull);
    // Chip, remarks, and the provenance photo made it.
    expect(store.current(cat.id, Keys.userField('chipid')), '276098102345678');
    expect(
      store.current(cat.id, Keys.userField('remarks')),
      contains('MISSING: Minka'),
    );
    expect(store.images(cat.id), isNotEmpty);
  });

  testWidgets('a nameless owner is named after the cat', (tester) async {
    await pump(tester);
    await next(tester);
    await tester.enterText(find.byType(TextField).first, 'Minka');
    await save(tester);
    expect(store.clowders().single.name, 'Owner of Minka');
  });

  testWidgets('double-tapping save creates exactly one owner and cat', (
    tester,
  ) async {
    await pump(tester);
    await toReview(tester);
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

  testWidgets('add flier to an existing cat appends, never re-creates', (
    tester,
  ) async {
    final cat = store.createCat('Minka');
    store.append(cat, Keys.userField('remarks'), 'first flier');
    await pump(tester, existingCatId: cat);
    await save(tester);

    expect(store.cats(), hasLength(1));
    expect(store.clowders(), isEmpty);
    expect(store.flierPositions(cat), [(48.1, 11.5)]);
    // Remarks appended below the existing note.
    expect(
      store.current(cat, Keys.userField('remarks')),
      'first flier\n$_flierText',
    );
  });

  testWidgets('a Tasso link on the poster becomes a looked-up ID field', (
    tester,
  ) async {
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
    expect(
      lookupUrl(def, 'S3101849'),
      'https://www.tasso.net/Tierregister/Suchmeldungen?snr=S3101849',
    );
  });

  testWidgets('a service learned once is recognized on the next flier', (
    tester,
  ) async {
    // What "remember service" leaves behind: an ID field with a template.
    store.defineField(
      'Pet Register',
      FieldType.id,
      scope: FieldScope.cat,
      lookupUrl: 'https://pets.example/search?id={value}',
    );
    await pump(
      tester,
      text: 'MISSING\nhttps://pets.example/search?id=AB-42&lang=en',
    );
    await toReview(tester);
    expect(find.textContaining('AB-42'), findsWidgets);
    await save(tester);
    final cat = store.cats().single;
    expect(store.current(cat.id, Keys.userField('pet-register')), 'AB-42');
  });

  testWidgets('a QR code on the poster counts as a link too', (tester) async {
    await pump(
      tester,
      text: 'MISSING: Minka',
      codes: const FlierCodes([_tassoUrl]),
    );
    await save(tester);
    final cat = store.cats().single;
    final def = store.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    expect(store.current(cat.id, def.key), 'S3101849');
  });

  testWidgets('the address can be turned into a position for the owner', (
    tester,
  ) async {
    await pump(tester);
    await next(tester);
    await next(tester);
    await tester.enterText(
      find.widgetWithText(TextField, '').last,
      'Main St 1',
    );
    await tester.tap(find.text('Find address on the map'));
    await tester.pumpAndSettle();
    expect(find.text('Address found'), findsOneWidget);
    await save(tester);

    final clowder = store.clowders().single;
    expect(store.positionOf(clowder.id), (48.2, 11.6));
  });

  testWidgets('the poster page is the only way in, the review page the '
      'only way out', (tester) async {
    await pump(tester);
    expect(find.text('Flier text'), findsOneWidget);
    // No save anywhere before the last page.
    expect(find.byTooltip('Save'), findsNothing);
    expect(find.widgetWithText(FilledButton, 'Save'), findsNothing);
    await next(tester);
    expect(find.widgetWithText(FilledButton, 'Save'), findsNothing);
  });

  testWidgets('back asks before the scan is thrown away', (tester) async {
    await pump(tester);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Abort the scan?'), findsOneWidget);
    await tester.tap(find.text('Keep going'));
    await tester.pumpAndSettle();
    expect(find.text('Flier text'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Abort'));
    await tester.pumpAndSettle();
    expect(find.text('Flier text'), findsNothing);
    expect(store.cats(), isEmpty);
    expect(store.clowders(), isEmpty);
  });

  testWidgets('the QR reader says when it found nothing', (tester) async {
    await pump(tester);
    expect(find.text('No QR code found in the photo.'), findsOneWidget);
  });

  testWidgets('the QR reader says why it broke, verbatim', (tester) async {
    await pump(
      tester,
      codes: const FlierCodes([], error: 'PlatformException(boom)'),
    );
    expect(
      find.text('QR reading failed: PlatformException(boom)'),
      findsOneWidget,
    );
  });

  testWidgets('a found QR code is shown and asks to be used', (tester) async {
    await pump(tester, codes: const FlierCodes([_tassoUrl]));
    expect(find.text('Use this code'), findsOneWidget);
    expect(find.text(_tassoUrl), findsOneWidget);
  });

  testWidgets('an unticked QR code is not read', (tester) async {
    await pump(
      tester,
      text: 'MISSING: Minka',
      codes: const FlierCodes([_tassoUrl]),
    );
    await tester.tap(find.text('Use this code'));
    await tester.pumpAndSettle();
    await toReview(tester);
    expect(find.textContaining('S3101849'), findsNothing);
  });

  testWidgets('a TASSO poster fills the cat, the registry number and '
      'the address, never the owner contact', (tester) async {
    await pump(tester, text: '', lines: hugoLines());
    expect(find.textContaining('TASSO poster recognized'), findsOneWidget);
    await next(tester);
    // Cat page: name, missing date, the fields the poster carried.
    expect(find.widgetWithText(TextField, 'HUGO'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'HUGO'), findsOneWidget);
    expect(find.text('6/5/2025'), findsOneWidget);
    expect(find.text('Gender'), findsOneWidget);
    await next(tester);
    // Owner page: the hotline is TASSO's, not the owner's.
    expect(find.widgetWithText(TextField, '06190/ 93 73 00'), findsNothing);
    final address = find.widgetWithText(
      TextField,
      '04207 Leipzig, Colberger Weg. Deutschland',
    );
    await tester.dragUntilVisible(
      address,
      find.byType(ListView),
      const Offset(0, -200),
    );
    expect(address, findsOneWidget);
    await save(tester);

    final cat = store.cats().single;
    expect(cat.name, 'HUGO');
    expect(store.current(cat.id, Keys.userField('gender')), 'male');
    expect(store.current(cat.id, Keys.userField('neutered')), 'yes');
    expect(
      store.current(cat.id, Keys.userField('breed')),
      'Europäische Langhaarkatze',
    );
    expect(store.current(cat.id, Keys.userField('color')), 'braun');
    expect(store.current(cat.id, Keys.userField('species')), 'cat');
    expect(store.current(cat.id, Keys.userField('chipid')), isNull);
    final tasso = store.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    expect(store.current(cat.id, tasso.key), 'S2983764');
    expect(
      lookupUrl(tasso, 'S2983764'),
      'https://www.tasso.net/Tierregister/Suchmeldungen?snr=S2983764',
    );
    final remarks = store.current(cat.id, Keys.userField('remarks'))!;
    expect(remarks, contains('GESUCHT!'));
    expect(remarks, contains('Geburtsdatum: 26.05.2024'));
    expect(remarks, contains('Kennzeichnung: Das Tier ist gechipt.'));
    expect(remarks, isNot(contains('braun')));
    final clowder = store.clowders().single;
    expect(store.current(clowder.id, Keys.userField('phone')), isNull);
    expect(store.current(clowder.id, Keys.userField('email')), isNull);
    expect(
      store.current(clowder.id, Keys.userField('address')),
      '04207 Leipzig, Colberger Weg. Deutschland',
    );
  });

  testWidgets('a line sent to another field lands there', (tester) async {
    await pump(tester, text: 'Minka\nreward!');
    expect(find.textContaining('Unknown poster layout'), findsOneWidget);
    // Send the first line to Name.
    await tester.tap(find.byType(DropdownButton<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Name').last);
    await tester.pumpAndSettle();
    await next(tester);
    expect(find.widgetWithText(TextField, 'Minka'), findsOneWidget);
    await save(tester);
    expect(store.cats().single.name, 'Minka');
    expect(
      store.current(store.cats().single.id, Keys.userField('remarks')),
      'reward!',
    );
  });

  testWidgets('without text recognition the typed remarks survive Next', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: FlierCaptureScreen(
          store: store,
          pickPhoto: (_) async => _jpeg(),
          locate: () async => (pos: null, failure: null),
          scan: (_) async => null,
          ocr: (_) async => null,
          codes: (_) async => FlierCodes.none,
          templates: () async => _templates,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('not available'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'typed by hand');
    await next(tester);
    expect(find.widgetWithText(TextField, 'typed by hand'), findsOneWidget);
    await save(tester);
    expect(
      store.current(store.cats().single.id, Keys.userField('remarks')),
      'typed by hand',
    );
  });

  testWidgets('a missing date in the future stays a remark', (tester) async {
    await pump(
      tester,
      text: '',
      lines: [
        flierLine('Suchdienstnummer', 100, 100),
        flierLine('S1', 500, 100),
        flierLine('Verlustdatum', 100, 150),
        flierLine('05.06.2099', 500, 150),
      ],
    );
    await next(tester);
    expect(find.text('6/5/2099'), findsNothing);
    await save(tester);
    expect(
      store.current(store.cats().single.id, Keys.userField('remarks')),
      contains('Verlustdatum: 05.06.2099'),
    );
  });
}
