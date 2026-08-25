import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/field_editing.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #74: the agenda lists every active plan ordered by date, pins
/// overdue on top, and done records the fact with an optional repeat.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  setUp(() {
    agendaAutoOpened = false;
    store = CatalogStore.inMemory();
    store.author = 'test';
    cat = store.createCat('Miezi');
  });

  tearDown(() => store.close());

  DateTime inDays(int days) => DateTime.now().add(Duration(days: days));

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: AgendaScreen(store: store),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('plans list ordered by date, overdue marked on top',
      (tester) async {
    store.append(cat, Keys.userField('remarks'), 'vaccine refresh',
        date: inDays(30), reminder: true);
    store.append(cat, Keys.userField('status'), 'check her paw',
        date: inDays(-2), reminder: true);
    await pump(tester);
    expect(find.textContaining('check her paw'), findsOneWidget);
    expect(find.textContaining('vaccine refresh'), findsOneWidget);
    expect(find.textContaining('2 days overdue'), findsOneWidget);
    final overdueY =
        tester.getTopLeft(find.textContaining('check her paw')).dy;
    final futureY =
        tester.getTopLeft(find.textContaining('vaccine refresh')).dy;
    expect(overdueY, lessThan(futureY));
  });

  testWidgets('empty agenda explains itself', (tester) async {
    await pump(tester);
    expect(find.textContaining('Nothing is due'), findsOneWidget);
  });

  testWidgets('done records the fact; declining repeat ends the plan',
      (tester) async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(1), reminder: true);
    await pump(tester);
    await tester.tap(find.byTooltip('Done'));
    await tester.pumpAndSettle();
    // The repeat dialog is open; decline it.
    await tester.tap(find.text('No repeat'));
    await tester.pumpAndSettle();
    expect(store.activeReminders(), isEmpty);
    expect(store.current(cat, Keys.userField('remarks')), 'worming');
    expect(find.textContaining('Nothing is due'), findsOneWidget);
  });

  testWidgets('done with a repeat schedules the next cycle',
      (tester) async {
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: inDays(1), reminder: true);
    await pump(tester);
    await tester.tap(find.byTooltip('Done'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final active = store.activeReminders();
    expect(active, hasLength(1));
    // Default is "3 months" from today.
    final expected = DateTime(DateTime.now().year,
        DateTime.now().month + 3, DateTime.now().day);
    expect(DateUtils.isSameDay(active.single.due, expected), isTrue);
    expect(store.current(cat, Keys.userField('remarks')), 'worming');
  });

  testWidgets('long-press menu removes a reminder without a fact',
      (tester) async {
    store.append(cat, Keys.userField('remarks'), 'planned visit',
        date: inDays(5), reminder: true);
    await pump(tester);
    await tester.longPress(find.textContaining('planned visit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove reminder'));
    await tester.pumpAndSettle();
    expect(store.activeReminders(), isEmpty);
    expect(store.current(cat, Keys.userField('remarks')), isNull);
  });

  testWidgets('agendaWantsAttention only within the 3-day window',
      (tester) async {
    expect(agendaWantsAttention(store), isFalse);
    store.append(cat, Keys.userField('remarks'), 'far away',
        date: inDays(30), reminder: true);
    expect(agendaWantsAttention(store), isFalse);
    store.append(cat, Keys.userField('status'), 'soon',
        date: inDays(2), reminder: true);
    expect(agendaWantsAttention(store), isTrue);
  });

  testWidgets('field editor: picking a future date flags the reminder',
      (tester) async {
    final def = FieldDef(
        id: 'fielddef:due',
        slug: 'due',
        name: 'Due',
        type: FieldType.text,
        scope: FieldScope.cat,
        options: const []);
    late BuildContext context;
    FieldEdit? edit;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Builder(builder: (c) {
        context = c;
        return const SizedBox();
      })),
    ));
    editFieldValue(context, def, null).then((e) => edit = e);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'vet visit');
    // Open the as-of picker and jump one month ahead.
    await tester.tap(find.byIcon(Icons.edit_calendar_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Next month'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('15').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    // The future date auto-enabled the reminder checkbox.
    final box = tester.widget<CheckboxListTile>(find.ancestor(
        of: find.byIcon(Icons.alarm),
        matching: find.byType(CheckboxListTile)));
    expect(box.value, isTrue);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(edit, isNotNull);
    expect(edit!.reminder, isTrue);
    expect(edit!.value, 'vet visit');
    expect(edit!.date.isAfter(DateTime.now()), isTrue);
  });
}
