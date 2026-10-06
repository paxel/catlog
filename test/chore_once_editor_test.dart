import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/chores/chore_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A chore done once: the fourth repeat, on a radio line of its own
/// like the other three, with an optional due day and no Pause.
void main() {
  late Directory root;
  late CatalogStore store;
  late String miezi;

  setUpAll(useSystemSqlite);

  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-once');
    store = CatalogStore.open('${root.path}/catlog.db')..author = 'anna';
    miezi = store.createCat('Miezi');
  });

  tearDown(() {
    store.close();
    root.deleteSync(recursive: true);
  });

  // The editor is a long page: a tall window builds every row.
  void tall(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  Widget host({Chore? existing}) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () => showChoreDialog(
            context,
            store,
            entityId: miezi,
            existing: existing,
          ),
          child: const Text('open'),
        ),
      ),
    ),
  );

  testWidgets('how often is one choice of four, on radio lines', (
    tester,
  ) async {
    tall(tester);
    await tester.pumpWidget(host());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(SegmentedButton<ChoreRepeat>), findsNothing);
    expect(find.byType(RadioListTile<ChoreRepeat>), findsNWidgets(4));
    expect(find.text('No due date — any day'), findsNothing);
  });

  testWidgets('a one-time chore is saved with or without a due day', (
    tester,
  ) async {
    tall(tester);
    await tester.pumpWidget(host());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Vet papers');
    await tester.tap(find.text('One time'));
    await tester.pumpAndSettle();
    expect(find.text('No due date — any day'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final saved = store.choresOf(miezi).single;
    expect(saved.once, isTrue);
    expect(saved.due, isNull);
  });

  testWidgets('a one-time chore offers no Pause', (tester) async {
    final papers = store.createChore(
      Chore(
        id: '',
        entity: miezi,
        title: 'Vet papers',
        schedule: const ChoreSchedule.once(),
        start: DateTime(2026, 10, 5),
        due: DateTime(2026, 10, 9),
      ),
    );
    tall(tester);
    await tester.pumpWidget(host(existing: papers));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Due date:'), findsOneWidget);
    expect(find.text('Pause'), findsNothing);
    expect(find.text('Duplicate'), findsOneWidget);
    expect(find.text('End chore'), findsOneWidget);
    // Cleared, it is due any day.
    await tester.tap(find.byTooltip('No due date — any day'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(store.choresOf(miezi).single.due, isNull);
  });
}
