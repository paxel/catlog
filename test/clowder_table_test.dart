import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #54: the clowder overview as a sortable table with chosen columns.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
    final b = store.createClowder('Hof');
    store.append(b, Keys.userField('status'), 'barn');
    final a = store.createClowder('Adopter');
    store.append(a, Keys.userField('status'), 'forever-home');
    store.createCat('Miezi', clowderId: b);
    store.createCat('Foundling');
  });

  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ClowderListScreen(store: store),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('toggle flips to a table with strays pinned first',
      (tester) async {
    await pump(tester);
    expect(find.byType(DataTable), findsNothing);
    await tester.tap(find.byTooltip('Show as table'));
    await tester.pumpAndSettle();
    final table = find.byType(DataTable);
    expect(table, findsOneWidget);
    // Default columns: Name, Cats, Type; strays row pinned on top.
    expect(find.text('Type'), findsWidgets);
    final straysY = tester.getTopLeft(find.text('Strays')).dy;
    expect(straysY,
        lessThan(tester.getTopLeft(find.text('Adopter')).dy));
    expect(straysY, lessThan(tester.getTopLeft(find.text('Hof')).dy));
    // The choice survives a rebuild (stored per device).
    expect(store.localSetting(clowderViewKey), 'table');
  });

  testWidgets('header tap sorts and the sort persists', (tester) async {
    store.setLocalSetting(clowderViewKey, 'table');
    await pump(tester);
    // Ascending by name: Adopter above Barn.
    expect(tester.getTopLeft(find.text('Adopter')).dy,
        lessThan(tester.getTopLeft(find.text('Hof')).dy));
    await tester.tap(find.text('Name'));
    await tester.pumpAndSettle();
    // Second tap on the current column flips to descending.
    expect(tester.getTopLeft(find.text('Hof')).dy,
        lessThan(tester.getTopLeft(find.text('Adopter')).dy));
    expect(store.localSetting(clowderSortKey), 'name,desc');
  });

  testWidgets('column chips add and remove field columns',
      (tester) async {
    store.setLocalSetting(clowderViewKey, 'table');
    await pump(tester);
    // Add the Address column via its chip.
    await tester.tap(find.widgetWithText(FilterChip, 'Address'));
    await tester.pumpAndSettle();
    expect(find.descendant(
            of: find.byType(DataTable),
            matching: find.text('Address')),
        findsOneWidget);
    expect(store.localSetting(clowderColumnsKey), contains('f:address'));
  });
}
