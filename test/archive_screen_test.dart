import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/import_summary.dart';
import 'package:catlog/src/screens/archive_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #53: the archive screen writes the file first and only then deletes.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late Directory dir;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog_archive_ui');
    store = CatalogStore.open('${dir.path}/catalog.db');
    store.author = 'axel';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  Future<void> pump(WidgetTester tester,
      {Future<String?> Function(String)? saveTo}) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ArchiveScreen(store: store, saveTo: saveTo),
    ));
    await tester.pumpAndSettle();
  }

  test('bytes read as sizes, not as digits', () {
    expect(formatBytes(512), '512 B');
    expect(formatBytes(2048), '2 KB');
    expect(formatBytes(5 * 1024 * 1024), '5.0 MB');
  });

  testWidgets('an old deceased cat is offered, archived, then gone',
      (tester) async {
    final long = DateTime(2020, 1, 1);
    final cat = store.createCat('Mimzy', date: long);
    store.append(cat, Keys.userField('deceased'), '2020-03-01',
        date: long);
    final path = '${dir.path}/out.catsync';

    await pump(tester, saveTo: (_) async => path);
    expect(find.text('Mimzy'), findsOneWidget);

    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Archive 1 entries'));
    await tester.pumpAndSettle();
    // The confirmation says what deletion means before anything happens.
    expect(find.textContaining('every device you sync with'),
        findsOneWidget);
    expect(store.cats().where((c) => c.id == cat), isNotEmpty);

    await tester.tap(find.widgetWithText(FilledButton, 'Archive'));
    await tester.pumpAndSettle();

    expect(File(path).existsSync(), isTrue);
    expect(store.cats().where((c) => c.id == cat), isEmpty);
  });

  testWidgets('a failed export deletes nothing', (tester) async {
    final long = DateTime(2020, 1, 1);
    final cat = store.createCat('Mimzy', date: long);
    store.append(cat, Keys.userField('deceased'), '2020-03-01',
        date: long);

    // Unwritable destination: the export throws, the cat must survive.
    await pump(tester,
        saveTo: (_) async => '${dir.path}/missing-dir/out.catsync');
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Archive 1 entries'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Archive'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Nothing was deleted'), findsOneWidget);
    expect(store.cats().where((c) => c.id == cat), isNotEmpty);
  });

  testWidgets('importing the archive back offers to restore it',
      (tester) async {
    final long = DateTime(2020, 1, 1);
    final cat = store.createCat('Mimzy', date: long);
    store.append(cat, Keys.userField('deceased'), '2020-03-01',
        date: long);
    final path = writeArchive(store, '${dir.path}/out.catsync',
        entityIds: {cat});
    deleteArchived(store, {cat});
    final applied = importBundle(store, path).applied;

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () => showImportSummary(context, store, applied),
          child: const Text('go'),
        ),
      ),
    ));
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();

    expect(find.textContaining('deleted in this catalog'), findsOneWidget);
    expect(store.cats().where((c) => c.id == cat), isEmpty);
    await tester.tap(find.widgetWithText(FilledButton, 'Restore'));
    await tester.pumpAndSettle();
    expect(store.cats().single.name, 'Mimzy');
  });
}
