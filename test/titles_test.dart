import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/moderation_screen.dart';
import 'package:catlog/src/titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Titles worn next to the name: earned from the ladders, shown to
/// partners on the author rows.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('a worn title shows on the author rows, in words', (
    tester,
  ) async {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);
    a.createCat('Miezi');
    a.setOwnTitle('chancellor|Feed');
    b.applyEntries(a.entriesSince(const {}), keys: a.keyRecords());
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ModerationScreen(store: b),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('anna · Chancellor (Feed)'), findsOneWidget);
    final t = lookupAppLocalizations(const Locale('de'));
    expect(titleText(t, b, a.deviceId), 'Kanzler (Feed)');
    expect(titleText(t, b, b.deviceId), isNull);
    // A record that is not a rank shows nothing.
    a.setOwnTitle('nonsense');
    b.applyEntries(a.entriesSince(b.versionVector()));
    expect(titleText(t, b, a.deviceId), isNull);
  });

  test('earned titles come from the ladders, one per chore', () {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    final cat = store.createCat('Miezi');
    final feed = store.createChore(
      Chore(
        id: '',
        entity: cat,
        title: 'Feed',
        schedule: const ChoreSchedule.daily(),
        start: DateTime(2026, 6, 1),
      ),
    );
    for (var d = 0; d < 12; d++) {
      final day = DateTime(2026, 6, 1 + d);
      store.tickChore(feed, day, doneOn: day);
    }
    final t = lookupAppLocalizations(const Locale('en'));
    final earned = earnedTitles(t, [store], DateTime(2026, 7, 1));
    expect(earned.map((e) => e.value), ['servant|Feed']);
    expect(earned.single.text, 'Servant (Feed)');
  });
}
