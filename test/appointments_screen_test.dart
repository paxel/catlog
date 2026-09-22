import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/timeline_screen.dart';
import 'package:catlog/src/widgets/appointment_card.dart';
import 'package:catlog/src/widgets/reminder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #75: appointments — timed visits with notes — next to reminders.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String cat;

  setUp(() {
    agendaAutoOpened = true;
    store = CatalogStore.inMemory();
    store.author = 'test';
    cat = store.createCat('Miezi');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget home) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('the plus fans Appointment out, which records a visit',
      (tester) async {
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Appointment').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Vet');
    await tester.enterText(find.byType(TextField).last, 'bring the form');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final open = store.appointmentsOf(cat);
    expect(open, hasLength(1));
    expect(open.single.title, 'Vet');
    expect(open.single.notes, 'bring the form');
    expect(open.single.allDay, isTrue);
    // It shows in the Planned section right away.
    expect(find.text('Planned'), findsOneWidget);
    expect(find.byType(AppointmentCard), findsOneWidget);
  });

  testWidgets('the agenda mixes both kinds by date', (tester) async {
    final soon = DateTime.now().add(const Duration(days: 2));
    final later = DateTime.now().add(const Duration(days: 9));
    store.append(cat, Keys.userField('remarks'), 'worming',
        date: later, reminder: true);
    store.createAppointment(Appointment(
        id: '',
        entity: cat,
        date: DateTime(soon.year, soon.month, soon.day),
        time: (hour: 14, minute: 30),
        title: 'Vet'));
    await pump(tester, AgendaScreen(store: store));
    expect(find.byType(AppointmentCard), findsOneWidget);
    expect(find.byType(ReminderCard), findsOneWidget);
    final apptY = tester.getTopLeft(find.byType(AppointmentCard)).dy;
    final remY = tester.getTopLeft(find.byType(ReminderCard)).dy;
    expect(apptY, lessThan(remY));
    expect(find.textContaining('2:30'), findsOneWidget);
  });

  testWidgets('finishing asks for the outcome and closes the visit',
      (tester) async {
    store.createAppointment(Appointment(
        id: '',
        entity: cat,
        date: DateTime.now().add(const Duration(days: 1)),
        title: 'Vet',
        linkedField: Keys.userField('remarks'),
        linkedValue: 'checked'));
    await pump(tester, AgendaScreen(store: store));
    await tester.tap(find.byTooltip('Finish'));
    await tester.pumpAndSettle();
    expect(find.text('How did it go?'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'all fine');
    await tester.tap(find.text('Finish').last);
    await tester.pumpAndSettle();
    expect(store.appointmentsOf(cat), isEmpty);
    final closed = store.appointmentsOf(cat, includeDone: true).single;
    expect(closed.notes, 'all fine');
    expect(store.current(cat, Keys.userField('remarks')), 'checked');
    // Finished today, the card stays for the day: box checked, the
    // notes on it, a tap to change them.
    expect(find.byType(AppointmentCard), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(find.textContaining('all fine'), findsOneWidget);
    await tester.tap(find.byType(AppointmentCard));
    await tester.pumpAndSettle();
    expect(find.text('How did it go?'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'all fine, 4.2 kg');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(store.appointmentsOf(cat, includeDone: true).single.notes,
        'all fine, 4.2 kg');

    // Unticked: open again, the linked value gone with it.
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(store.appointmentsOf(cat), hasLength(1));
    expect(store.current(cat, Keys.userField('remarks')), isNull);

    // Finished once more, the bin takes it off the list.
    await tester.tap(find.byTooltip('Finish'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Finish').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Take off the list'));
    await tester.pumpAndSettle();
    expect(find.byType(AppointmentCard), findsNothing);
    expect(store.appointmentsOf(cat, includeDone: true).single.done, isTrue);
  });

  testWidgets('long-press deletes an appointment', (tester) async {
    store.createAppointment(Appointment(
        id: '',
        entity: cat,
        date: DateTime.now().add(const Duration(days: 1)),
        title: 'Vet'));
    await pump(tester, AgendaScreen(store: store));
    // The bin on the card deletes it.
    await tester.tap(find.byTooltip('Delete appointment'));
    await tester.pumpAndSettle();
    expect(store.appointmentsOf(cat, includeDone: true), isEmpty);
  });

  testWidgets('an appointment within three days wants attention',
      (tester) async {
    expect(agendaWantsAttention(store), isFalse);
    store.createAppointment(Appointment(
        id: '',
        entity: cat,
        date: DateTime.now().add(const Duration(days: 2)),
        title: 'Vet'));
    expect(agendaWantsAttention(store), isTrue);
  });

  testWidgets('the timeline shows the visit, not its JSON', (tester) async {
    store.createAppointment(Appointment(
        id: '',
        entity: cat,
        date: DateTime(2026, 9, 3),
        time: (hour: 14, minute: 30),
        title: 'Vet'));
    await pump(tester, TimelineScreen(store: store, entityId: cat));
    expect(find.textContaining('Vet 14:30'), findsOneWidget);
    expect(find.textContaining('{"date"'), findsNothing);

    // Finished with notes: the timeline shows how it went.
    final visit = store.appointmentsOf(cat).single;
    store.finishAppointment(visit, notes: 'all fine');
    await pump(tester, TimelineScreen(store: store, entityId: cat));
    expect(find.textContaining('Vet 14:30 ✓\nall fine'), findsOneWidget);
  });
}
