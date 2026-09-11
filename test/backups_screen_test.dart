import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/auto_backup.dart';
import 'package:catlog/src/screens/backups_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Backups page: what the platform does, the last copy, a button
/// that writes one now.
void main() {
  setUpAll(useSystemSqlite);

  Future<void> pump(WidgetTester tester, Widget home) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('names the platform, writes a copy on request', (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    store.createCat('Miezi');
    final saved = <String>[];
    await pump(
      tester,
      BackupsScreen(
        store: store,
        platform: 'android',
        save: (path, name) async {
          saved.add(name);
          return name;
        },
      ),
    );
    expect(find.textContaining('Google backs up'), findsOneWidget);
    expect(find.textContaining('Documents/catlog'), findsOneWidget);
    expect(find.text('No copy written yet.'), findsOneWidget);

    await tester.tap(find.text('Back up now'));
    await tester.pumpAndSettle();
    expect(saved, ['catlog-backup.catsync']);
    expect(find.textContaining('Last copy:'), findsOneWidget);
    expect(store.localSetting(backupAtKey), isNotNull);

    // Nothing changed, the button still writes.
    await tester.tap(find.text('Back up now'));
    await tester.pumpAndSettle();
    expect(saved.length, 2);
  });

  testWidgets('iPhone and desktop read their own lines', (tester) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    await pump(tester, BackupsScreen(store: store, platform: 'ios'));
    expect(find.textContaining('iCloud Backup'), findsOneWidget);
    expect(find.textContaining('Files'), findsOneWidget);
    await pump(tester, BackupsScreen(store: store, platform: 'desktop'));
    expect(find.textContaining('Downloads'), findsOneWidget);
  });

  testWidgets('a folder can be chosen for the copies and forgotten', (
    tester,
  ) async {
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    await pump(
      tester,
      BackupsScreen(
        store: store,
        platform: 'android',
        pickFolder: () async => 'content://drive/tree/primary%3ABackups',
        folderName: (tree) async => 'Backups',
      ),
    );
    await tester.tap(find.text('Also copy to a folder…'));
    await tester.pumpAndSettle();
    expect(store.localSetting(backupFolderKey), startsWith('content://'));
    expect(find.text('Also copied to Backups'), findsOneWidget);
    await tester.tap(find.byTooltip('Stop copying there'));
    await tester.pumpAndSettle();
    expect(store.localSetting(backupFolderKey), '');
    expect(find.text('Also copy to a folder…'), findsOneWidget);
  });
}
