import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/field_editing.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/widgets/reminder_card.dart';
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
    expect(find.textContaining('No appointments planned'), findsOneWidget);
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
    expect(find.textContaining('No appointments planned'), findsOneWidget);
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

  testWidgets('field editor: the as-of date cannot lie in the future',
      (tester) async {
    // 1.0.1: plans are made in the reminder dialog; the editor records
    // what happened, and that is never tomorrow's news.
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
    expect(find.byIcon(Icons.alarm), findsNothing);
    await tester.enterText(find.byType(TextField).first, 'vet visit');
    await tester.tap(find.byIcon(Icons.edit_calendar_outlined));
    await tester.pumpAndSettle();
    // Next month is out of range: the arrow is disabled (no tooltip
    // is offered), and OK keeps today.
    expect(find.byTooltip('Next month'), findsNothing);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(edit, isNotNull);
    expect(edit!.value, 'vet visit');
    expect(
        edit!.date.isAfter(DateTime.now().add(const Duration(days: 1))),
        isFalse);
  });

  testWidgets('the reminder dialog writes a plan with a well-formed value',
      (tester) async {
    // A choice field: the plan's value comes from its options, so done
    // later records a fact the field understands.
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatDetailScreen(store: store, catId: cat),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Add reminder'));
    await tester.pumpAndSettle();
    // The plus asks which kind first (#75).
    await tester.tap(find.textContaining('Reminder — a value'));
    await tester.pumpAndSettle();
    expect(find.textContaining('The appointment shows in the Agenda'), findsOneWidget);
    await tester.tap(find.byType(DropdownButtonFormField<String>).last);
    await tester.pumpAndSettle();
    // What a cat *is* cannot be planned: no Gender in the list.
    expect(find.text('Gender'), findsNothing);
    // Neutered is a yes/no field: the plan's value comes from its
    // options, so done later records a fact the field understands.
    await tester.tap(find.text('Neutered').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(RadioListTile<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final active = store.activeReminders();
    expect(active, hasLength(1));
    expect(active.single.field, Keys.userField('neutered'));
    expect(active.single.value, 'yes');
    // The fact is untouched; the plan shows in the Planned section.
    expect(store.current(cat, Keys.userField('neutered')), isNull);
    expect(find.text('Planned'), findsOneWidget);
  });

  testWidgets('a plan on a field without a fact shows on the cat page',
      (tester) async {
    // The Vet case: no fact yet, only a plan — read mode hides empty
    // fields, the Planned section must still show it.
    store.append(cat, Keys.userField('remarks'), 'vet check-up',
        date: inDays(20), reminder: true);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CatDetailScreen(store: store, catId: cat),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Planned'), findsOneWidget);
    expect(find.textContaining('vet check-up'), findsOneWidget);
    expect(find.byType(ReminderCard), findsOneWidget);
  });
}
