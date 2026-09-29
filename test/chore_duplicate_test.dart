import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/chores/chore_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Three kittens, one feeding: Duplicate in a chore's editor opens a
/// preset copy over the original, whose it is as the copy's first field;
/// the copy carries the title, schedule and time while the original
/// stays open.
void main() {
  late Directory root;
  late CatalogManager manager;
  late CatalogStore store;
  late String miezi;
  late String tom;
  late Chore feed;

  setUpAll(useSystemSqlite);

  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-dup');
    manager = CatalogManager.open(root.path, defaultName: 'Leipzig');
    store = manager.openStore(manager.active)..author = 'anna';
    miezi = store.createCat('Miezi');
    tom = store.createCat('Tom');
    feed = store.createChore(
      Chore(
        id: '',
        entity: miezi,
        title: 'Feed',
        schedule: ChoreSchedule.every(2, ChoreUnit.days),
        time: (hour: 8, minute: 30),
        start: DateTime(2026, 1, 1),
      ),
    );
  });

  tearDown(() {
    store.close();
    manager.close();
    root.deleteSync(recursive: true);
  });

  Widget host() => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () => showChoreDialog(context, store, existing: feed),
          child: const Text('open'),
        ),
      ),
    ),
  );

  testWidgets('a duplicate lands on the picked cat and the editor stays', (
    tester,
  ) async {
    await tester.pumpWidget(host());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Edit chore'), findsOneWidget);
    await tester.tap(find.text('Duplicate'));
    await tester.pumpAndSettle();
    // The preset editor opens at once: a new chore with the copied
    // values, whose it is as its first field.
    expect(find.text('New chore'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      'Feed',
    );
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tom').last);
    await tester.pumpAndSettle();
    expect(find.text('every 2 days'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final copies = store.choresOf(tom);
    expect(copies, hasLength(1));
    expect(copies.single.title, 'Feed');
    expect(copies.single.schedule.repeat, ChoreRepeat.everyDays);
    expect(copies.single.schedule.every, 2);
    expect(copies.single.schedule.unit, ChoreUnit.days);
    expect(copies.single.time, (hour: 8, minute: 30));
    expect(copies.single.start, dayOf(DateTime.now()), reason: 'starts today');
    expect(copies.single.paused, isFalse);
    expect(store.choresOf(miezi), hasLength(1), reason: 'the original as it was');
    // Back in the original's editor, ready for the next kitten.
    expect(find.text('Edit chore'), findsOneWidget);
    expect(find.text('Duplicate'), findsOneWidget);
  });
}
