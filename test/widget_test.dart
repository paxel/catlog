import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/main.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// A small synthetic JPEG for photo tests.
Uint8List makeTestJpeg() =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: 64, height: 48)));

void main() {
  setUpAll(useSystemSqlite);

  testWidgets('first launch asks for author, then shows clowder list',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);

    await tester.pumpWidget(CatlogApp(store: store));
    expect(find.text('Your name'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'axel');
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    expect(store.author, 'axel');
    expect(find.text('Clowders'), findsOneWidget);
  });

  testWidgets('creating a clowder shows it in the list', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.byTooltip('New clowder'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Foster Home South');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    // Detail screen opens for the new clowder.
    expect(find.text('Foster Home South'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);

    // Back on the list it is present too.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Foster Home South'), findsOneWidget);
  });

  testWidgets('adding a cat shows it in the clowder grid', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    store.createCat('Miezi', clowderId: home);

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Cats'), findsOneWidget);
    expect(find.text('Miezi'), findsOneWidget);

    // Open the cat and rename it; the change is authored and historic.
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Rename'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Mizzi');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Mizzi'), findsOneWidget);
    final cat = store.cats(clowderId: home).single;
    expect(store.fieldHistory(cat.id, Keys.name).length, 2);
  });

  testWidgets('setting a choice field and seeing it on the timeline',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    store.createCat('Miezi', clowderId: home);

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();

    // Set gender via the typed editor.
    await tester.tap(find.text('Gender'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('female'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('female'), findsOneWidget);

    // Timeline lists the change with the author.
    await tester.tap(find.byTooltip('Timeline'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Gender: female'), findsOneWidget);
    expect(find.textContaining('axel'), findsWidgets);
  });

  testWidgets('moving a cat out makes it a stray on the home screen',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    final cat = store.createCat('Runner', clowderId: home);

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Runner'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Clowder'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('No clowder — stray / ran away'));
    await tester.pumpAndSettle();
    // Moves ask for the effective date (historic moves are a thing).
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(store.strays().single.id, cat);
    expect(find.text('Stray — no clowder'), findsOneWidget);

    // Home screen shows the stray count.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Strays'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('a stray can be created directly from the strays screen',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Strays'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add stray'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Foundling');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(store.strays().single.name, 'Foundling');
  });

  testWidgets('a field definition can be renamed', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.byTooltip('Fields'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Color'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Colour');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Colour'), findsOneWidget);
    expect(
        store.fieldDefs().firstWhere((d) => d.slug == 'color').name, 'Colour');
  });

  testWidgets('German locale shows translated UI and starter fields',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Zuhause');
    store.createCat('Miezi', clowderId: home);

    await tester.pumpWidget(MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ClowderListScreen(store: store),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Clowder'), findsWidgets); // German plural title
    await tester.tap(find.text('Zuhause'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();
    // Starter field name shows in German (ADR-0005 display-time).
    expect(find.text('Geschlecht'), findsOneWidget);
    expect(find.text('Kastriert'), findsOneWidget);
  });

  testWidgets('Arabic locale renders right-to-left with translated UI',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    store.createClowder('البيت');

    await tester.pumpWidget(MaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ClowderListScreen(store: store),
    ));
    await tester.pumpAndSettle();

    expect(find.text('المجموعات'), findsOneWidget); // app bar title
    expect(
        Directionality.of(tester.element(find.text('المجموعات'))),
        TextDirection.rtl);
  });

  testWidgets('merging two cats via the dialog', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    final survivor = store.createCat('Miezi', clowderId: home);
    store.createCat('Mizzi', clowderId: home); // duplicate

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mizzi')); // open the duplicate = loser
    await tester.pumpAndSettle();
    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Merge into…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Merge'));
    await tester.pumpAndSettle();

    expect(store.cats().single.id, survivor);
    expect(store.current(survivor, Keys.name), 'Miezi');
  });

  testWidgets('conflicting field shows a badge and can be resolved',
      (tester) async {
    final store = CatalogStore.inMemory();
    final other = CatalogStore.inMemory();
    addTearDown(store.close);
    addTearDown(other.close);
    store.author = 'axel';
    other.author = 'friend';

    // Shared cat, then concurrent gender edits, then sync.
    final home = store.createClowder('Home');
    final cat = store.createCat('Miezi', clowderId: home);
    other.applyEntries(store.entriesSince({}), senderVector: {});
    final catOnOther = other.cats().single.id;
    final vs = store.versionVector();
    final vo = other.versionVector();
    store.append(cat, Keys.userField('gender'), 'female');
    other.append(catOnOther, Keys.userField('gender'), 'male');
    store.applyEntries(other.entriesSince(vs), senderVector: vo);
    expect(store.hasConflict(cat, Keys.userField('gender')), isTrue);

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.warning_amber), findsOneWidget);
    await tester.tap(find.text('Gender'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Conflict'), findsOneWidget);
    await tester.tap(find.text('female'));
    await tester.tap(find.text('Resolve'));
    await tester.pumpAndSettle();

    expect(store.hasConflict(cat, Keys.userField('gender')), isFalse);
    expect(store.current(cat, Keys.userField('gender')), 'female');
    expect(find.byIcon(Icons.warning_amber), findsNothing);
  });

  testWidgets('clowder timeline shows cat arrivals and departures',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    final away = store.createClowder('Adopter');
    final cat = store.createCat('Miezi', clowderId: home);
    store.moveCat(cat, away);

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Timeline'));
    await tester.pumpAndSettle();

    expect(find.text('Miezi arrived'), findsOneWidget);
    expect(find.text('Miezi left to Adopter'), findsOneWidget);
  });

  testWidgets('a change can be reverted from the timeline', (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    final cat = store.createCat('Miezi', clowderId: home);
    store.append(cat, Keys.name, 'Mizzi');

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mizzi'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Timeline'));
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('Name: Mizzi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Revert this change'));
    await tester.pumpAndSettle();

    expect(store.current(cat, Keys.name), 'Miezi');
    expect(store.fieldHistory(cat, Keys.name).length, 3);
  });

  testWidgets('card screen renders with and without a photo',
      (tester) async {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'axel';
    final home = store.createClowder('Home');
    final cat = store.createCat('Miezi', clowderId: home);
    store.append(cat, Keys.userField('gender'), 'female');

    await tester.pumpWidget(CatlogApp(store: store));
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Card'));
    await tester.pumpAndSettle();

    // No photo yet — facts still render.
    expect(find.text('Card — Miezi'), findsOneWidget);
    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('female'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    // With a photo the image shows up on the card.
    final bytes = CatalogStore.compressImage(makeTestJpeg());
    store.addImage(cat, bytes);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Card'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsWidgets);
  });
}
