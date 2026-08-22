import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/clowder_list_screen.dart';
import 'package:catlog/src/screens/strays_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #52: strays as a pseudo-clowder card on top of the grid, and a
/// stray list showing gender/color, sortable.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'test';
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

  testWidgets('the strays card leads the clowder grid and opens the list',
      (tester) async {
    store.createClowder('Home');
    store.createCat('Foundling');
    await pump(tester, ClowderListScreen(store: store));
    expect(find.text('Strays (1)'), findsOneWidget);
    // The pseudo card sits above the real clowder.
    expect(tester.getTopLeft(find.text('Strays (1)')).dy,
        lessThanOrEqualTo(tester.getTopLeft(find.text('Home')).dy));
    await tester.tap(find.text('Strays (1)'));
    await tester.pumpAndSettle();
    expect(find.byType(StraysScreen), findsOneWidget);
    expect(find.text('Foundling'), findsOneWidget);
  });

  testWidgets('the stray list shows gender and color and sorts by them',
      (tester) async {
    final a = store.createCat('Anton');
    store.append(a, Keys.userField('gender'), 'male');
    store.append(a, Keys.userField('color'), 'black');
    final z = store.createCat('Zora');
    store.append(z, Keys.userField('gender'), 'female');
    store.append(z, Keys.userField('color'), 'white');

    await pump(tester, StraysScreen(store: store));
    expect(find.text('male · black'), findsOneWidget);
    expect(find.text('female · white'), findsOneWidget);
    // Name sort: Anton first.
    expect(tester.getTopLeft(find.text('Anton')).dy,
        lessThan(tester.getTopLeft(find.text('Zora')).dy));
    // Gender sort: female first.
    await tester.tap(find.byTooltip('Sort'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gender'));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.text('Zora')).dy,
        lessThan(tester.getTopLeft(find.text('Anton')).dy));
  });
}
