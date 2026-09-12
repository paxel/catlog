import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/field_labels.dart';
import 'package:catlog/src/value_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Stored documents and codes read as the app's words.
void main() {
  setUpAll(() async {
    useSystemSqlite();
    await initializeDateFormatting('en');
  });
  final t = lookupAppLocalizations(const Locale('en'));

  test('a chore reads as title, schedule, time, reminder, state', () {
    final c = Chore(
      id: 'x',
      entity: 'cat:1',
      title: 'Feed',
      schedule: const ChoreSchedule.every(2, ChoreUnit.days),
      start: DateTime(2026, 9, 1),
      time: (hour: 8, minute: 0),
      remind: true,
      remindAt: (hour: 8, minute: 30),
      paused: true,
    );
    expect(
      choreWords(t, c),
      'Feed · every 2 days · 08:00 · reminder 08:30 · Paused',
    );
    expect(
      scheduleWords(
        t,
        const ChoreSchedule.weekdays({DateTime.monday, DateTime.friday}),
      ),
      'Mon, Fri',
    );
  });

  test('ticks, titles and privacy marks have words', () {
    expect(tickWords(t, '2026-09-11'), 'done on 9/11/2026');
    expect(titleWords(t, 'butler|Feed'), 'Butler (Feed)');
    expect(storedValueWords(t, r'$private:f:phone', 'yes'), 'Private');
    expect(
      storedValueWords(t, r'$withheld:f:phone', 'yes'),
      'kept back by a partner',
    );
  });

  test('an unknown document becomes indented lines', () {
    expect(
      documentWords('{"a":1,"b":{"c":"x"},"d":[1,2]}'),
      'a: 1\nb:\n  c: x\nd: 1, 2',
    );
    expect(documentWords('plain'), isNull);
  });

  test('valueLabel and fieldLabel use them for stored chores', () {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    final meds = store.createChore(
      Chore(
        id: '',
        entity: cat,
        title: 'Meds',
        schedule: const ChoreSchedule.daily(),
        start: DateTime(2026, 9, 1),
      ),
    );
    final raw = store.current(cat, meds.key)!;
    expect(valueLabel(t, store, meds.key, raw), startsWith('Meds · Daily'));
    expect(fieldLabel(t, store, meds.key), 'Chore');
    expect(
      fieldLabel(t, store, Keys.choreTick(meds.id, '2026-09-11')),
      'Chore done',
    );
    expect(
      valueLabel(t, store, Keys.choreTick(meds.id, '2026-09-11'), '2026-09-11'),
      'done on 9/11/2026',
    );
  });
}
