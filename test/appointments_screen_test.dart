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

  testWidgets('the plus asks appointment or reminder, then records a visit',
      (tester) async {
    await pump(tester, CatDetailScreen(store: store, catId: cat));
    await tester.tap(find.byTooltip('Add reminder'));
    await tester.pumpAndSettle();
    expect(find.text('Appointment or reminder?'), findsOneWidget);
    await tester.tap(find.textContaining('Appointment — a visit'));
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
    expect(find.byType(AppointmentCard), findsNothing);
  });

  testWidgets('long-press deletes an appointment', (tester) async {
    store.createAppointment(Appointment(
        id: '',
        entity: cat,
        date: DateTime.now().add(const Duration(days: 1)),
        title: 'Vet'));
    await pump(tester, AgendaScreen(store: store));
    await tester.longPress(find.textContaining('Vet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete appointment'));
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
  });
}
