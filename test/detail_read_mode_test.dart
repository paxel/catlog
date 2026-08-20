import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// #46/#47: the cat page opens read-only — filled fields only, no edit
/// affordances — and the pencil flips it into the all-fields edit view.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    cat = store.createCat('Sissi');
    store.append(cat, Keys.userField('gender'), 'female');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatDetailScreen(store: store, catId: cat),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('opens read-only: filled fields only, no edit icons',
      (tester) async {
    await pump(tester);
    // The filled field shows, formatted.
    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('female'), findsOneWidget);
    // Empty fields are absent in read mode.
    expect(find.text('Breed'), findsNothing);
    expect(find.text('Color'), findsNothing);
    // No per-row edit affordances.
    expect(find.byIcon(Icons.edit_outlined), findsNothing);
    // Tapping the filled row does nothing.
    await tester.tap(find.text('Gender'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('pencil enters edit mode with all fields, check leaves it',
      (tester) async {
    await pump(tester);
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    // All defined fields appear now.
    expect(find.text('Breed'), findsOneWidget);
    expect(find.text('Color'), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsWidgets);
    // Tapping a field opens its editor.
    await tester.tap(find.text('Gender'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    // The check ends edit mode.
    await tester.tap(find.byTooltip('Done'));
    await tester.pumpAndSettle();
    expect(find.text('Breed'), findsNothing);
  });

  testWidgets('back leaves edit mode before leaving the page',
      (tester) async {
    await pump(tester);
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    expect(find.text('Breed'), findsOneWidget);
    final dynamic state = tester.state(find.byType(CatDetailScreen));
    // Simulate the system back gesture.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    // Still on the page, but back in read mode.
    expect(find.byType(CatDetailScreen), findsOneWidget);
    expect(find.text('Breed'), findsNothing);
    expect(state, isNotNull);
  });

  testWidgets('read-mode long-press on a field lands in its editor',
      (tester) async {
    await pump(tester);
    await tester.longPress(find.text('Gender'));
    await tester.pumpAndSettle();
    // The field's editor is open…
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('female'), findsWidgets);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    // …and the page is now in edit mode.
    expect(find.text('Breed'), findsOneWidget);
  });

  testWidgets('photo long-press menu works in read mode', (tester) async {
    await tester.runAsync(() async {
      final bytes = Uint8List.fromList(
          img.encodeJpg(img.Image(width: 8, height: 8)));
      store.addImage(cat, CatalogStore.compressImage(bytes));
    });
    await pump(tester);
    final tile = find.descendant(
        of: find.byType(GridView),
        matching: find.byType(GestureDetector));
    await tester.ensureVisible(tile.first);
    await tester.pumpAndSettle();
    // Tap opens the viewer.
    await tester.tap(tile.first);
    await tester.pumpAndSettle();
    expect(find.text('1 / 1'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    // Long-press opens the management menu without entering edit mode.
    await tester.ensureVisible(tile.first);
    await tester.pumpAndSettle();
    await tester.longPress(tile.first);
    await tester.pumpAndSettle();
    expect(find.text('This is the profile image'), findsOneWidget);
  });

  testWidgets('clowder opens read-only with the gallery before the fields',
      (tester) async {
    final home = store.createClowder('Home');
    store.moveCat(cat, home);
    store.append(home, Keys.userField('address'), 'Main St 1');

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ClowderDetailScreen(store: store, clowderId: home),
    ));
    await tester.pumpAndSettle();

    // Filled field shows, empty one doesn't, no edit icons.
    expect(find.text('Main St 1'), findsOneWidget);
    expect(find.text('Responsible person'), findsNothing);
    expect(find.byIcon(Icons.edit_outlined), findsNothing);
    // Gallery renders above the fields.
    final galleryY = tester.getTopLeft(find.text('Sissi')).dy;
    final fieldY = tester.getTopLeft(find.text('Main St 1')).dy;
    expect(galleryY, lessThan(fieldY));

    // Pencil: fields first, all definitions, edit icons back.
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    expect(find.text('Responsible person'), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsWidgets);
    final editFieldY = tester.getTopLeft(find.text('Main St 1')).dy;
    final editGalleryY = tester.getTopLeft(find.text('Sissi')).dy;
    expect(editFieldY, lessThan(editGalleryY));
    // Add cat stays available in both modes.
    expect(find.text('Add cat'), findsOneWidget);
  });

  testWidgets('a new field can be created from the page in edit mode',
      (tester) async {
    await pump(tester);
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('New field'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New field'), warnIfMissed: true);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'Vaccinated');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    // The new definition appears immediately as an editable row.
    expect(find.text('Vaccinated'), findsOneWidget);
    expect(store.fieldDefs().any((d) => d.name == 'Vaccinated'), isTrue);
    // First value in one motion.
    await tester.tap(find.text('Vaccinated'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('a fresh cat opens in edit mode, existing ones read-only',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatDetailScreen(store: store, catId: cat, startEditing: true),
    ));
    await tester.pumpAndSettle();
    // All fields visible right away — no pencil needed.
    expect(find.text('Breed'), findsOneWidget);
    expect(find.byTooltip('Done'), findsOneWidget);
  });

  testWidgets('a revert on the timeline shows after returning',
      (tester) async {
    store.append(cat, Keys.userField('gender'), 'male');
    await pump(tester);
    expect(find.text('male'), findsOneWidget);
    // Open the field's history via edit mode long-press (history lives
    // there), revert the last change, and come back.
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    await tester.longPress(find.text('Gender'));
    await tester.pumpAndSettle();
    // Timeline entry -> revert sheet -> revert.
    await tester.tap(find.byIcon(Icons.undo).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Revert this change'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    // The page shows the reverted value without reopening.
    expect(find.text('female'), findsOneWidget);
    expect(find.text('male'), findsNothing);
  });

  testWidgets('conflict row shows and resolves in read mode',
      (tester) async {
    final other = CatalogStore.inMemory();
    addTearDown(other.close);
    other.author = 'friend';
    other.applyEntries(store.entriesSince({}), senderVector: {});
    final catOnOther = other.cats().single.id;
    final vs = store.versionVector();
    final vo = other.versionVector();
    store.append(cat, Keys.userField('color'), 'black');
    other.append(catOnOther, Keys.userField('color'), 'white');
    store.applyEntries(other.entriesSince(vs), senderVector: vo);
    expect(store.hasConflict(cat, Keys.userField('color')), isTrue);

    await pump(tester);
    // Conflicted field visible in read mode with the warning badge.
    expect(find.text('Color'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber), findsOneWidget);
    // Tap opens the conflict dialog without entering edit mode.
    await tester.tap(find.text('Color'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
