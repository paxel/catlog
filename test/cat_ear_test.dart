import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/widgets/cat_ear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The cat ear marks everything that answers to press-and-hold: if it
/// has a long press, it shows the ear — no hidden shortcuts.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  setUp(() {
    agendaAutoOpened = true;
    store = CatalogStore.inMemory();
    store.author = 'test';
    cat = store.createCat('Miezi');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget home) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('field rows wear the ear in read mode', (tester) async {
    store.append(cat, Keys.userField('gender'), 'female');
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    // The clowder row and the filled field row both hold long-presses.
    expect(find.byType(CatEarBadge), findsWidgets);
  });

  testWidgets('agenda cards wear the ear', (tester) async {
    store.append(cat, Keys.userField('remarks'), 'due soon',
        date: DateTime.now().add(const Duration(days: 3)),
        reminder: true);
    await pump(tester, AgendaScreen(store: store));
    expect(
        find.descendant(
            of: find.byType(Card), matching: find.byType(CatEarBadge)),
        findsOneWidget);
  });
}
