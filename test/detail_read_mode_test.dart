import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
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
