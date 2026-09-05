import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/l10n/app_localizations_de.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/mode_l10n.dart';
import 'package:catlog/src/pet_mode.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pet mode (#93): the words follow the catalog's choice, the choice
/// travels with the catalog, cat mode stays exactly as it was.
void main() {
  setUpAll(useSystemSqlite);
  tearDown(() => petMode.value = false);

  test('the facade answers with the twin in pet mode only', () {
    final cats = ModeLocalizations(AppLocalizationsEn(), false);
    final pets = ModeLocalizations(AppLocalizationsEn(), true);
    expect(cats.cats, 'Cats');
    expect(pets.cats, 'Pets');
    expect(pets.clowders, 'Households');
    expect(pets.catsCount(3), '3 pets');
    expect(cats.catsCount(3), '3 cats');
    expect(pets.kittensLabel, 'Young');
    // No twin: forwarded untouched.
    expect(pets.cancel, cats.cancel);
    // Every help and spotlight text speaks of pets too.
    expect(pets.helpAgenda, isNot(contains(' cat')));
    expect(pets.helpAgenda, contains('pet'));
    final de = ModeLocalizations(AppLocalizationsDe(), true);
    expect(de.clowderLabel, 'Haushalt');
    expect(de.cats, 'Tiere');
  });

  test('the choice is an entry: it survives a bundle round trip', () {
    final dir = Directory.systemTemp.createTempSync('catlog-pets');
    addTearDown(() => dir.deleteSync(recursive: true));
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    addTearDown(a.close);
    addTearDown(b.close);
    expect(isPetMode(a), isFalse);
    setPetMode(a, true);
    expect(petMode.value, isTrue);
    expect(isPetMode(a), isTrue);
    final path = writeBundle(a, '${dir.path}/pets.catsync');
    importBundle(b, path);
    expect(isPetMode(b), isTrue);
    // Nothing else appeared: no cat, no clowder, no field.
    expect(b.cats(), isEmpty);
    expect(b.clowders(), isEmpty);
  });

  testWidgets('the home screen says Households in pet mode',
      (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    setPetMode(store, true);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ClowderListScreen(store: store),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Households'), findsOneWidget);
    expect(find.text('Clowders'), findsNothing);
  });
}
