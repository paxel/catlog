import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/clowder_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A fosterer's vet run: one appointment carrying several cats, each
/// keeping its own entry, folded into one card.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  late String home, hugo, rudi, minka;

  setUp(() {
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
}
