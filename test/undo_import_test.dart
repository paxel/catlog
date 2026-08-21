import 'dart:async';
import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/import_summary.dart';
import 'package:catlog/src/undo_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// "Can I delete the imported stuff again?" — yes, from the sheet that
/// appears right after the import.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store, peer;
  late Directory saved;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-undo-ui');
    for (final name in ['mine', 'theirs']) {
      Directory('${dir.path}/$name').createSync();
    }
    saved = Directory('${dir.path}/saved')..createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
    peer = CatalogStore.open('${dir.path}/theirs/catlog.db')
      ..author = 'Kathrin';
  });

  tearDown(() {
    store.close();
    peer.close();
    dir.deleteSync(recursive: true);
  });

  Future<String> saveTo(String path, String name) async {
    final to = '${saved.path}/$name';
    File(path).copySync(to);
    return to;
  }

  /// A bundle from the peer holding one cat.
  String theirBundle() {
    peer.createCat('Fremdling');
    return writeBundle(peer, '${dir.path}/theirs.catsync');
  }

  Future<void> pumpImport(WidgetTester tester, String path) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(builder: (context) {
        ctx = context;
        return const Scaffold(body: SizedBox.shrink());
      }),
    ));
    final imported = importWithSavePoint(store, path);
    unawaited(showImportSummary(ctx, store, imported.result.applied,
        undo: imported.point, saveTo: saveTo));
    await tester.pumpAndSettle();
  }

  testWidgets('the summary offers to undo the import', (tester) async {
    await pumpImport(tester, theirBundle());
    expect(find.text('Undo this import'), findsOneWidget);
  });

  testWidgets('undoing removes exactly what arrived', (tester) async {
    await pumpImport(tester, theirBundle());
    store.createCat('Mine');

    await tester.tap(find.text('Undo this import'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Undo this import'));
    await tester.pumpAndSettle();

    expect(store.cats().map((c) => c.name), isNot(contains('Fremdling')));
  });

  testWidgets('the confirmation says partners keep their copy',
      (tester) async {
    await pumpImport(tester, theirBundle());
    await tester.tap(find.text('Undo this import'));
    await tester.pumpAndSettle();
    expect(find.textContaining('keep their copy'), findsOneWidget);
  });

  testWidgets('cancelling the confirmation keeps everything',
      (tester) async {
    await pumpImport(tester, theirBundle());
    await tester.tap(find.text('Undo this import'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();
    expect(store.cats().map((c) => c.name), ['Fremdling']);
  });

  testWidgets('the file is kept, and it puts everything back',
      (tester) async {
    final bundle = theirBundle();
    await pumpImport(tester, bundle);
    await tester.tap(find.text('Undo this import'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Undo this import'));
    await tester.pumpAndSettle();

    final files = saved.listSync().whereType<File>().toList();
    expect(files, hasLength(1));
    expect(find.textContaining('catlog-undone-'), findsOneWidget);

    importBundle(store, files.single.path);
    expect(store.cats().map((c) => c.name), ['Fremdling']);
  });

  test('an import that brings nothing new records no moment', () {
    final bundle = theirBundle();
    importWithSavePoint(store, bundle);
    final again = importWithSavePoint(store, bundle);
    expect(again.point, isNull);
    expect(store.savePoints(), hasLength(1));
  });

  test('each undo gets its own file', () {
    expect(undoFileName(DateTime.utc(2026, 8, 21, 14, 32)),
        'catlog-undone-2026-08-21-14-32.catsync');
    expect(undoFileName(DateTime.utc(2026, 8, 21, 14, 32)),
        isNot(undoFileName(DateTime.utc(2026, 8, 21, 15, 32))));
  });
}
