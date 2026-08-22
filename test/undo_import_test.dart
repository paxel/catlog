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

  /// A save that fails — no Downloads folder, a refused MediaStore
  /// insert — must leave the import alone.
  Future<String> failingSave(String path, String name) async =>
      throw const FileSystemException('No Downloads folder');

  Future<void> pumpImport(WidgetTester tester, String path,
      {SaveFile? save}) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(builder: (context) {
        ctx = context;
        return const Scaffold(body: SizedBox.shrink());
      }),
    ));
    final imported = importWithMoment(store, path);
    unawaited(showImportSummary(ctx, store, imported.result.applied,
        undo: imported.moment, saveTo: save ?? saveTo));
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
    importWithMoment(store, bundle);
    final again = importWithMoment(store, bundle);
    expect(again.moment, isNull);
    expect(store.moments(), hasLength(1));
  });

  test('each undo gets its own file, even two in the same minute', () {
    expect(undoFileName(DateTime.utc(2026, 8, 21, 14, 32, 5)),
        'catlog-undone-2026-08-21-14-32-05.catsync');
    expect(undoFileName(DateTime.utc(2026, 8, 21, 14, 32, 5)),
        isNot(undoFileName(DateTime.utc(2026, 8, 21, 14, 32, 41))));
  });

  testWidgets('a file that cannot be saved costs nothing', (tester) async {
    await pumpImport(tester, theirBundle(), save: failingSave);
    expect(store.cats().map((c) => c.name), ['Fremdling']);

    await tester.tap(find.text('Undo this import'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Undo this import'));
    await tester.pumpAndSettle();

    // The save threw; the import must still be there.
    expect(store.cats().map((c) => c.name), ['Fremdling']);
    expect(find.textContaining('Nothing was removed'), findsOneWidget);
  });
}
