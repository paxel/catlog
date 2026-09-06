import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/moderation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Authors read as people under keys: your own, a partner's met in
/// person or from a file, and one without any key.
void main() {
  setUpAll(useSystemSqlite);

  testWidgets('each author row names its key and how far it is trusted', (
    tester,
  ) async {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);
    a.createCat('Miezi');
    b.createCat('Wanderer');
    a.applyEntries(b.entriesSince(const {}), keys: b.keyRecords());
    // An old phone without a key.
    a.applyEntries([
      Entry(
        seq: -1,
        device: 'old-phone',
        dseq: 1,
        entity: 'cat:old',
        field: r'$type',
        value: 'cat',
        date: DateTime(2026),
        author: 'carla',
        recorded: DateTime(2026),
      ),
    ]);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ModerationScreen(store: a),
      ),
    );
    await tester.pumpAndSettle();
    // Two names write under the own key: anna and the seeder.
    expect(find.textContaining('key ${a.keyCode} · Your key'), findsWidgets);
    expect(
      find.textContaining(
        'key ${a.pinnedKey(b.deviceId)!.record.code} · from a file',
      ),
      findsWidgets,
    );
    expect(find.textContaining('no key yet'), findsOneWidget);

    // The delete dialog names the key, not a device.
    await tester.tap(find.byTooltip('Delete everything by this author').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('under key'), findsOneWidget);
  });
}
