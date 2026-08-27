import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/reminders/calendar_mirror.dart';
import 'package:catlog/src/screens/agenda_screen.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:catlog/src/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A fosterer's vet run: one appointment carrying several cats, each
/// keeping its own entry, folded into one card.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String home, hugo, rudi, minka;

  setUp(() {
    agendaAutoOpened = true;
    store = CatalogStore.inMemory();
    store.author = 'test';
    home = store.createClowder('Pflegestelle');
    hugo = store.createCat('Hugo', clowderId: home);
    rudi = store.createCat('Rudi', clowderId: home);
    minka = store.createCat('Minka');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, Widget home) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Types the title and saves. enterText alone pumps no frame, so the
  /// Save button would still be the disabled one at tap time.
  Future<void> saveAs(WidgetTester tester, String title) async {
    await tester.enterText(find.byType(TextField).first, title);
    await tester.pump();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
  }

  Future<void> openDialog(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Add reminder'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Appointment — a visit'));
    await tester.pumpAndSettle();
  }

  group('appointment dialog', () {
    testWidgets('from the clowder page its cats come pre-ticked', (
      tester,
    ) async {
      await pump(tester, ClowderDetailScreen(store: store, clowderId: home));
      await openDialog(tester);
      expect(find.widgetWithText(FilterChip, 'Hugo'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Rudi'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Minka'), findsNothing);
      await saveAs(tester, 'Neutering');
      expect(store.appointmentsOf(home), isEmpty);
      final h = store.appointmentsOf(hugo).single;
      final r = store.appointmentsOf(rudi).single;
      expect(h.group, isNotNull);
      expect(r.group, h.group);
      expect(store.openAppointmentGroups().single, hasLength(2));
    });

    testWidgets('no cat ticked makes it the clowder\'s own appointment', (
      tester,
    ) async {
      await pump(tester, ClowderDetailScreen(store: store, clowderId: home));
      await openDialog(tester);
      await tester.tap(find.widgetWithText(FilterChip, 'Hugo'));
      await tester.tap(find.widgetWithText(FilterChip, 'Rudi'));
      await tester.pumpAndSettle();
      expect(find.textContaining('No cat ticked'), findsOneWidget);
      await saveAs(tester, 'House visit');
      expect(store.appointmentsOf(home).single.group, isNull);
      expect(store.appointmentsOf(hugo), isEmpty);
    });

    testWidgets('from a cat page more cats can be added', (tester) async {
      await pump(tester, CatDetailScreen(store: store, catId: hugo));
      await openDialog(tester);
      expect(find.widgetWithText(FilterChip, 'Hugo'), findsOneWidget);
      await tester.tap(find.widgetWithText(ActionChip, 'Add cat'));
      await tester.pumpAndSettle();
      expect(find.text('Which cats come along?'), findsOneWidget);
      await tester.tap(find.widgetWithText(CheckboxListTile, 'Minka'));
      await tester.tap(find.widgetWithText(FilledButton, 'Add cat'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(FilterChip, 'Minka'), findsOneWidget);
      await saveAs(tester, 'Vet');
      expect(
        store.appointmentsOf(hugo).single.group,
        store.appointmentsOf(minka).single.group,
      );
      expect(store.appointmentsOf(rudi), isEmpty);
    });

    testWidgets('a lone cat appointment carries no group', (tester) async {
      await pump(tester, CatDetailScreen(store: store, catId: hugo));
      await openDialog(tester);
      await saveAs(tester, 'Vet');
      expect(store.appointmentsOf(hugo).single.group, isNull);
    });
  });

  testWidgets('editing a clowder\'s own appointment offers no cats', (
    tester,
  ) async {
    store.createAppointment(
      Appointment(
        id: '',
        entity: home,
        date: DateTime.now().add(const Duration(days: 1)),
        title: 'House visit',
      ),
    );
    await pump(tester, ClowderDetailScreen(store: store, clowderId: home));
    await tester.longPress(find.textContaining('House visit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit appointment'));
    await tester.pumpAndSettle();
    expect(find.text('Cats on this appointment'), findsNothing);
    expect(find.widgetWithText(ActionChip, 'Add cat'), findsNothing);
  });

  group('agenda and pages', () {
    late List<Appointment> run;

    setUp(() {
      run = store.createAppointments(
        Appointment(
          id: '',
          entity: hugo,
          date: DateTime.now().add(const Duration(days: 2)),
          title: 'Neutering',
          linkedField: Keys.userField('remarks'),
          linkedValue: 'neutered',
        ),
        [hugo, rudi],
      );
    });

    testWidgets('one card for the run, a chip per cat', (tester) async {
      await pump(tester, AgendaScreen(store: store));
      expect(find.byType(AppointmentCard), findsOneWidget);
      expect(find.widgetWithText(ActionChip, 'Hugo'), findsOneWidget);
      expect(find.widgetWithText(ActionChip, 'Rudi'), findsOneWidget);
      expect(find.textContaining('Hugo ·'), findsNothing);
    });

    testWidgets('finishing asks who was treated; the unticked stays open', (
      tester,
    ) async {
      await pump(tester, AgendaScreen(store: store));
      await tester.tap(find.byTooltip('Finish'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Untick the cats'), findsOneWidget);
      await tester.tap(find.widgetWithText(CheckboxListTile, 'Rudi'));
      await tester.pump();
      await tester.enterText(find.byType(TextField), 'went well');
      await tester.tap(find.widgetWithText(FilledButton, 'Finish'));
      await tester.pumpAndSettle();
      expect(store.appointmentsOf(hugo), isEmpty);
      expect(store.current(hugo, Keys.userField('remarks')), 'neutered');
      expect(store.current(rudi, Keys.userField('remarks')), isNull);
      expect(store.appointmentsOf(rudi).single.title, 'Neutering');
      expect(
        store.appointmentsOf(hugo, includeDone: true).single.notes,
        'went well',
      );
      // Rudi's own card remains.
      expect(find.byType(AppointmentCard), findsOneWidget);
      expect(find.textContaining('Rudi ·'), findsOneWidget);
    });

    testWidgets('delete on the agenda names the count and takes all', (
      tester,
    ) async {
      await pump(tester, AgendaScreen(store: store));
      await tester.longPress(find.textContaining('Neutering'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete appointment for all 2 cats'));
      await tester.pumpAndSettle();
      expect(store.openAppointments(), isEmpty);
    });

    testWidgets('delete on the cat page takes only that cat out', (
      tester,
    ) async {
      await pump(tester, CatDetailScreen(store: store, catId: rudi));
      expect(find.widgetWithText(ActionChip, 'Hugo'), findsOneWidget);
      await tester.longPress(find.textContaining('Neutering'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete appointment'));
      await tester.pumpAndSettle();
      expect(store.appointmentsOf(rudi), isEmpty);
      expect(store.appointmentsOf(hugo).single.group, run.first.group);
    });

    testWidgets('editing from the agenda moves the whole run', (tester) async {
      await pump(tester, AgendaScreen(store: store));
      await tester.longPress(find.textContaining('Neutering'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit appointment'));
      await tester.pumpAndSettle();
      // Members are shown but cannot be unticked here.
      expect(find.widgetWithText(FilterChip, 'Hugo'), findsOneWidget);
      expect(
        tester
            .widget<FilterChip>(find.widgetWithText(FilterChip, 'Hugo'))
            .onSelected,
        isNull,
      );
      await saveAs(tester, 'Neutering at 8');
      for (final cat in [hugo, rudi]) {
        expect(store.appointmentsOf(cat).single.title, 'Neutering at 8');
      }
    });

    testWidgets('a cat added while editing joins the run', (tester) async {
      await pump(tester, AgendaScreen(store: store));
      await tester.longPress(find.textContaining('Neutering'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit appointment'));
      await tester.pumpAndSettle();
      // The edit dialog is tall; the chip row may sit below the fold.
      await tester.ensureVisible(find.widgetWithText(ActionChip, 'Add cat'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ActionChip, 'Add cat'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(CheckboxListTile, 'Minka'));
      await tester.tap(find.widgetWithText(FilledButton, 'Add cat'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(store.appointmentsOf(minka).single.group, run.first.group);
      expect(store.openAppointmentGroups().single, hasLength(3));
    });

    test('the calendar mirror wants one event for the run', () {
      final t = AppLocalizationsEn();
      final events = desiredEvents(store, t);
      expect(events, hasLength(1));
      final event = events.values.single;
      expect(event.title, 'Neutering — 2 cats');
      expect(event.description, contains('Hugo'));
      expect(event.description, contains('Rudi'));
      expect(events.keys.single, 'appt|${run.first.group}');
    });
  });
}
