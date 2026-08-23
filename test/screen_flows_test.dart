import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/card_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:catlog/src/screens/fields_screen.dart';
import 'package:catlog/src/screens/search_screen.dart';
import 'package:catlog/src/screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The everyday paths through the detail screens: what a keeper does on
/// a normal afternoon.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store;
  late String cat, clowder;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-flows');
    Directory('${dir.path}/mine').createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
    clowder = store.createClowder('Hinterhof');
    cat = store.createCat('Miezi');
    store.moveCat(cat, clowder);
    store.append(cat, Keys.userField('color'), 'black');
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  Future<void> pump(WidgetTester tester, Widget screen,
      {Size size = const Size(500, 1600)}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
    ));
    await tester.pumpAndSettle();
  }

  Future<void> menu(WidgetTester tester, String item) async {
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text(item));
    await tester.pumpAndSettle();
  }

  group('a clowder', () {
    testWidgets('a value turns private in its editor', (tester) async {
      await pump(tester,
          ClowderDetailScreen(store: store, clowderId: clowder));
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Address'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Main St 1');
      await tester.tap(find.text('Private'));
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      expect(store.isFieldPrivate(clowder, 'f:address'), isTrue);
      expect(store.current(clowder, 'f:address'), 'Main St 1');
    });

    testWidgets('can be hidden from the lists', (tester) async {
      await pump(tester,
          ClowderDetailScreen(store: store, clowderId: clowder));
      await menu(tester, 'Hide on this device');
      expect(store.isHidden(clowder), isTrue);
    });

    testWidgets('edit mode shows the empty fields too', (tester) async {
      await pump(tester,
          ClowderDetailScreen(store: store, clowderId: clowder));
      expect(find.text('Address'), findsNothing);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.text('Address'), findsOneWidget);
    });

    testWidgets('deleting it says what happens to its cats',
        (tester) async {
      await pump(tester,
          ClowderDetailScreen(store: store, clowderId: clowder));
      await menu(tester, 'Delete clowder');
      expect(find.textContaining('become strays'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      await tester.pumpAndSettle();
      expect(store.isDeleted(clowder), isFalse);
    });
  });

  group('a cat', () {
    testWidgets('shows only what is filled in, until you edit',
        (tester) async {
      await pump(tester, CatDetailScreen(store: store, catId: cat));
      expect(find.text('black'), findsOneWidget);
      expect(find.text('Breed'), findsNothing);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.text('Breed'), findsOneWidget);
    });

    testWidgets('a private value shows its lock in read mode',
        (tester) async {
      await pump(tester, CatDetailScreen(store: store, catId: cat));
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Color'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Private'));
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      expect(store.isFieldPrivate(cat, 'f:color'), isTrue);
      // Back to read mode: the lock sits at the end of the row.
      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('its card is one tap away', (tester) async {
      await pump(tester, CatDetailScreen(store: store, catId: cat));
      await tester.tap(find.byIcon(Icons.badge_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(CardScreen), findsOneWidget);
    });

    testWidgets('its timeline lists every change', (tester) async {
      await pump(tester, TimelineScreen(store: store, entityId: cat));
      expect(find.textContaining('Miezi'), findsWidgets);
      expect(find.byType(ListTile), findsWidgets);
    });
  });

  group('the card', () {
    testWidgets('chooses which fields it prints', (tester) async {
      await pump(tester, CardScreen(store: store, catId: cat));
      final chips = find.byType(FilterChip);
      expect(chips, findsWidgets);
      await tester.tap(chips.first);
      await tester.pumpAndSettle();
      expect(store.localSetting('cardFields'), isNotNull);
    });
  });

  group('fields', () {
    testWidgets('a field can be renamed and keeps its values',
        (tester) async {
      await pump(tester, FieldsScreen(store: store));
      await tester.tap(find.text('Color'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Colour');
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();

      expect(store.fieldDefs().map((d) => d.name), contains('Colour'));
      expect(store.current(cat, Keys.userField('color')), 'black');
    });
  });

  group('the home list', () {
    testWidgets('switches to the table and sorts it', (tester) async {
      store.createClowder('Anderswo');
      await pump(tester, ClowderListScreen(store: store));
      await tester.tap(find.byIcon(Icons.table_rows_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(DataTable), findsOneWidget);

      await tester.tap(find.text('Name').first);
      await tester.pumpAndSettle();
      expect(store.localSetting('clowderSort'), isNotNull);
    });

    testWidgets('search finds a cat by name', (tester) async {
      await pump(tester, SearchScreen(store: store));
      await tester.enterText(find.byType(TextField), 'Mie');
      await tester.pumpAndSettle();
      expect(find.text('Miezi'), findsOneWidget);
    });
  });
}
