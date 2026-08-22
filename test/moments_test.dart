import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/merge_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every operation that changes a lot in one tap records the moment
/// before it — and one that changes nothing records nothing.
void main() {
  setUpAll(useSystemSqlite);

  late Directory dir;
  late CatalogStore store;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-moments');
    Directory('${dir.path}/mine').createSync();
    store = CatalogStore.open('${dir.path}/mine/catlog.db')
      ..author = 'Patrick';
  });

  tearDown(() {
    store.close();
    dir.deleteSync(recursive: true);
  });

  test('nothing applied records nothing', () {
    final before = store.currentSeq();
    expect(
        momentFor(store,
            before: before, changed: false, cause: MomentCause.sync),
        isNull);
    expect(store.moments(), isEmpty);
  });

  test('a moment names what was about to happen', () {
    final before = store.currentSeq();
    final point = momentFor(store,
        before: before,
        changed: true,
        cause: MomentCause.sync,
        label: 'Kathrin');
    expect(point!.cause, MomentCause.sync);
    expect(point.label, 'Kathrin');
  });

  testWidgets('a merge can be undone through the list', (tester) async {
    final one = store.createCat('Miezi');
    final two = store.createCat('Mieze');

    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(builder: (context) {
        ctx = context;
        return const Scaffold(body: SizedBox.shrink());
      }),
    ));

    final merged = confirmPairMerge(
      context: ctx,
      store: store,
      a: one,
      b: two,
      lead: (_) => const SizedBox.shrink(),
      merge: (loser, survivor) => store.mergeCat(loser, survivor),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Miezi').last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Merge'));
    await tester.pumpAndSettle();
    expect(await merged, isTrue);

    expect(store.cats(), hasLength(1));
    final point = momentsOf(store).single;
    expect(point.cause, MomentCause.merge);

    revertTo(store, point, keepAt: '${dir.path}/undo.catsync');
    expect(store.cats().map((c) => c.name),
        unorderedEquals(['Miezi', 'Mieze']));
  });

  test('archiving and deleting can be undone', () {
    final cat = store.createCat('Alt');
    store.append(cat, Keys.userField('deceased'), '2020-01-01');
    final before = store.currentSeq();
    deleteArchived(store, {cat});
    final point = momentFor(store,
        before: before, changed: true, cause: MomentCause.archive)!;
    expect(store.cats(), isEmpty);

    revertTo(store, point, keepAt: '${dir.path}/undo.catsync');
    expect(store.cats().map((c) => c.name), ['Alt']);
  });

  test('a hard delete records no moment', () {
    // It removes entries instead of adding any (ADR-0006), so a moment
    // before it could never put anything back — offering one would be a
    // promise the catalog cannot keep.
    store.createCat('Miezi');
    store.author = 'Patrick the second';
    store.hardDeleteAuthor('Patrick');
    expect(store.moments(), isEmpty);
  });

  test('a moment never sits above the log it points into', () {
    store.createCat('Miezi');
    final high = store.currentSeq();
    store.author = 'Patrick the second';
    store.hardDeleteAuthor('Patrick');
    final id = store.addMoment(cause: MomentCause.import, seq: high);
    final moment = momentsOf(store).firstWhere((m) => m.id == id);
    expect(moment.seq, lessThanOrEqualTo(store.currentSeq()));
  });
}
