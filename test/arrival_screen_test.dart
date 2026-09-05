import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/import_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The page after an import: sections, a cat's effective changes, and
/// Accept or Reject — Reject puts the catalog back as it was.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a;
  late CatalogStore b;
  late Directory saved;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'bob';
    saved = Directory.systemTemp.createTempSync('catlog-arrival');
  });

  tearDown(() {
    a.close();
    b.close();
    saved.deleteSync(recursive: true);
  });

  /// Bob's changes land in Anna's catalog with a moment before them.
  (List<Entry>, Moment?) receive() {
    final before = a.currentSeq();
    final applied = a.applyEntries(
      b.entriesSince(a.versionVector()),
      senderVector: b.versionVector(),
    );
    final moment = momentFor(
      a,
      before: before,
      changed: applied.isNotEmpty,
      cause: MomentCause.import,
      label: 'bob',
    );
    return (applied, moment);
  }

  Future<void> pump(
    WidgetTester tester,
    List<Entry> applied, {
    Moment? undo,
  }) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showImportSummary(
                context,
                a,
                applied,
                undo: undo,
                saveTo: (path, name) async {
                  final to = '${saved.path}/$name';
                  File(path).copySync(to);
                  return to;
                },
              ),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
  }

  testWidgets('new and updated are sections; a tap shows before and after', (
    tester,
  ) async {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:color', 'white');
    b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
    b.createCat('Runner');
    b.append(cat, 'f:color', 'grey');
    final (applied, moment) = receive();

    await pump(tester, applied, undo: moment);
    expect(find.text('What arrived'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(find.text('Updated'), findsOneWidget);
    expect(find.text('Runner'), findsOneWidget);
    expect(find.text('1 change'), findsOneWidget);
    expect(find.textContaining('other changes'), findsNothing);

    await tester.tap(find.text('Miezi'));
    await tester.pumpAndSettle();
    expect(find.text('white → grey'), findsOneWidget);
  });

  testWidgets('Accept keeps what arrived', (tester) async {
    b.createCat('Runner');
    final (applied, moment) = receive();
    await pump(tester, applied, undo: moment);
    await tester.tap(find.text('Accept'));
    await tester.pumpAndSettle();
    expect(find.text('What arrived'), findsNothing);
    expect(a.cats().map((c) => c.name), ['Runner']);
  });

  testWidgets('Reject puts the catalog back as it was, file first', (
    tester,
  ) async {
    a.createCat('Miezi');
    b.createCat('Runner');
    final (applied, moment) = receive();
    expect(a.cats(), hasLength(2));

    await pump(tester, applied, undo: moment);
    await tester.tap(find.text('Reject'));
    await tester.pumpAndSettle();
    // The existing confirmation, then the removal.
    await tester.tap(find.widgetWithText(FilledButton, 'Undo this import'));
    await tester.pumpAndSettle();

    expect(a.cats().map((c) => c.name), ['Miezi']);
    expect(saved.listSync().whereType<File>(), hasLength(1));
    expect(find.text('What arrived'), findsNothing);
  });

  testWidgets('Keep mine keeps a deleted cat and your own value', (
    tester,
  ) async {
    final gone = a.createCat('Gone');
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:color', 'white', date: DateTime.utc(2025, 1, 1));
    b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
    b.deleteCat(gone);
    b.append(cat, 'f:color', 'grey');
    final (applied, moment) = receive();
    expect(a.cats().map((c) => c.name), ['Miezi']);

    await pump(tester, applied, undo: moment);
    expect(find.text('Deleted'), findsOneWidget);
    expect(find.text('Gone'), findsOneWidget);
    final goneRow = find.ancestor(
        of: find.text('Gone'), matching: find.byType(ListTile));
    await tester.tap(find.descendant(
        of: goneRow, matching: find.text('Keep mine')));
    await tester.pumpAndSettle();
    expect(a.cats().map((c) => c.name), containsAll(['Gone', 'Miezi']));
    expect(find.text('Deleted'), findsNothing);

    final mieziRow = find.ancestor(
        of: find.text('Miezi'), matching: find.byType(ListTile));
    await tester.tap(find.descendant(
        of: mieziRow, matching: find.text('Keep mine')));
    await tester.pumpAndSettle();
    expect(a.current(cat, 'f:color'), 'white');
    expect(find.text('Updated'), findsNothing);

    // Nothing comes back on the next exchange.
    final again = a.applyEntries(b.entriesSince(a.versionVector()),
        senderVector: b.versionVector());
    expect(again, isEmpty);
  });

  testWidgets('a conflict is listed and resolved from the page', (
    tester,
  ) async {
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:color', 'white', date: DateTime.utc(2025, 1, 1));
    b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
    a.append(cat, 'f:color', 'black', date: DateTime.utc(2026, 1, 1));
    b.append(cat, 'f:color', 'grey', date: DateTime.utc(2026, 1, 2));
    final (applied, moment) = receive();
    expect(a.hasConflict(cat, 'f:color'), isTrue);

    await pump(tester, applied, undo: moment);
    expect(find.text('Conflicts to resolve'), findsOneWidget);
    expect(find.textContaining('grey (bob)'), findsOneWidget);
    await tester.tap(find.textContaining('grey (bob)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Resolve'));
    await tester.pumpAndSettle();
    expect(a.hasConflict(cat, 'f:color'), isFalse);
    expect(find.text('Conflicts to resolve'), findsNothing);
    // Rejecting now would undo the resolution too: the button is gone
    // and the page says why.
    expect(find.text('Reject'), findsNothing);
    expect(find.textContaining('settled a conflict'), findsOneWidget);
  });
}
