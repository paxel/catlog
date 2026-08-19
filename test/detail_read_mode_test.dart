import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
