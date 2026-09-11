import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/spotlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The words around chores: the agenda help explains them and the Today
/// section carries a first-visit tip.
void main() {
  setUpAll(useSystemSqlite);

  test('the agenda help explains chores in both wordings', () {
    final t = lookupAppLocalizations(const Locale('en'));
    expect(t.helpAgenda, contains('Chores are the recurring tasks'));
    expect(t.helpAgendaNeutral, contains('Chores are the recurring tasks'));
    expect(t.spotAgendaToday, contains('last seven days'));
  });

  test('the Today tip is part of the agenda tour', () {
    expect(
      spotlightManifest['agenda']!.map((i) => i.id),
      contains('agenda-today'),
    );
  });

  testWidgets('the Today section is the tip\'s anchor', (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    store.createChore(
      Chore(
        id: '',
        entity: cat,
        title: 'Feed',
        schedule: const ChoreSchedule.daily(),
        start: DateUtils.dateOnly(DateTime.now()),
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AgendaScreen(store: store),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate((w) => w is Spotlight && w.id == 'agenda-today'),
      findsOneWidget,
    );
  });
}
