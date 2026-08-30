import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/l10n/app_localizations_de.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/field_labels.dart';
import 'package:catlog/src/name_date_dialog.dart';
import 'package:catlog/src/pet_mode.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Species presets (#94) and breeds by species (#95).
void main() {
  setUpAll(useSystemSqlite);
  tearDown(() => petMode.value = false);

  test('species is a choice with presets; a cat is still a cat', () {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final species = store.fieldDefs().firstWhere((d) => d.slug == 'species');
    expect(species.type, FieldType.choice);
    expect(species.options, contains('dog'));
    expect(store.current(store.createCat('Miezi'), 'f:species'), 'cat');
    expect(store.current(store.createCat('Rex', species: 'dog'), 'f:species'),
        'dog');
  });

  test('a species value displays translated; the word cat elsewhere as is',
      () {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final species = store.fieldDefs().firstWhere((d) => d.slug == 'species');
    final color = store.fieldDefs().firstWhere((d) => d.slug == 'color');
    expect(fieldValueDisplay(AppLocalizationsEn(), species, 'cat'), 'Cat');
    expect(fieldValueDisplay(AppLocalizationsEn(), species, 'dog'), 'Dog');
    expect(fieldValueDisplay(AppLocalizationsDe(), species, 'cat'), 'Katze');
    expect(fieldValueDisplay(AppLocalizationsEn(), color, 'cat'), 'cat');
  });

  test('a dog gets dog breeds, an added one only for dogs', () {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    var breed = store.fieldDefs().firstWhere((d) => d.slug == 'breed');
    expect(breedOptions(breed, 'dog'), contains('Beagle'));
    expect(breedOptions(breed, 'dog'), isNot(contains('Maine Coon')));
    expect(breedOptions(breed, 'cat'), contains('Maine Coon'));
    expect(breedOptions(breed, 'tortoise'), isEmpty);
    store.addFieldOption(breed.id, 'dog', 'Whippet');
    store.addFieldOption(breed.id, 'dog', 'Whippet');
    breed = store.fieldDefs().firstWhere((d) => d.slug == 'breed');
    expect(breedOptions(breed, 'dog').where((o) => o == 'Whippet'),
        hasLength(1));
    expect(breedOptions(breed, 'cat'), isNot(contains('Whippet')));
    expect(breed.options, isNot(contains('Whippet')));
  });

  Future<BuildContext> pump(WidgetTester tester, Widget home) async {
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Builder(builder: (c) {
        context = c;
        return home;
      })),
    ));
    await tester.pumpAndSettle();
    return context;
  }

  testWidgets('in pet mode the new-animal dialog asks for the species',
      (tester) async {
    final context = await pump(tester, const SizedBox());
    NameAndDate? result;
    askNameAndDate(context, 'New', species: 'rabbit').then((r) => result = r);
    await tester.pumpAndSettle();
    expect(find.text('Rabbit'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'Hoppel');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(result?.species, 'rabbit');
    expect(result?.name, 'Hoppel');
  });

  testWidgets('without a species the dialog stays as it was',
      (tester) async {
    final context = await pump(tester, const SizedBox());
    NameAndDate? result;
    askNameAndDate(context, 'New').then((r) => result = r);
    await tester.pumpAndSettle();
    expect(find.byType(DropdownButtonFormField<String>), findsNothing);
    await tester.enterText(find.byType(TextField).first, 'Miezi');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(result?.species, isNull);
  });

  testWidgets('a new animal starts from the species picked last',
      (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    setPetMode(store, true);
    store.setLocalSetting(lastSpeciesKey, 'rabbit');
    final context = await pump(tester, const SizedBox());
    String? created;
    createAnimal(context, store, title: 'New').then((id) => created = id);
    await tester.pumpAndSettle();
    expect(find.text('Rabbit'), findsOneWidget);
    await tester.tap(find.text('Rabbit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dog').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Rex');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(store.current(created!, 'f:species'), 'dog');
    expect(store.localSetting(lastSpeciesKey), 'dog');
  });

  testWidgets('in cat mode a new animal is a cat and nothing is asked',
      (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final context = await pump(tester, const SizedBox());
    String? created;
    createAnimal(context, store, title: 'New').then((id) => created = id);
    await tester.pumpAndSettle();
    expect(find.byType(DropdownButtonFormField<String>), findsNothing);
    await tester.enterText(find.byType(TextField).first, 'Miezi');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(store.current(created!, 'f:species'), 'cat');
    expect(store.localSetting(lastSpeciesKey), isNull);
  });

  testWidgets("a dog's breed editor offers dog breeds", (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    final dog = store.createCat('Rex', species: 'dog');
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await pump(tester, CatDetailScreen(store: store, catId: dog));
    await tester.tap(find.byTooltip('Edit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Breed'));
    await tester.pumpAndSettle();
    expect(find.text('Beagle'), findsOneWidget);
    expect(find.text('Maine Coon'), findsNothing);
  });
}
