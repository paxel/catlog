import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/screens/cat_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catlog/src/hidden.dart';

/// The shared cat list (#87): filter over names and values, a table
/// with an age column, and a pre-filtered set of cats.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;
  setUp(() {
    store = CatalogStore.inMemory()..author = 'test';
    final a = store.createCat('Anton');
    store.append(a, Keys.userField('gender'), 'male');
    store.append(a, Keys.userField('color'), 'black');
    store.append(a, Keys.userField('birthdate'), '2020');
    final z = store.createCat('Zora');
    store.append(z, Keys.userField('color'), 'white');
  });
  tearDown(() => store.close());

  Future<void> pump(WidgetTester tester, {CatSource? source}) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: CatListScreen(
          store: store,
          title: 'Cats',
          source: source ?? (s) => s.visibleCats(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the filter matches a value, not only the name', (tester) async {
    await pump(tester);
    expect(find.text('Anton'), findsOneWidget);
    expect(find.text('Zora'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'white');
    await tester.pumpAndSettle();
    expect(find.text('Anton'), findsNothing);
    expect(find.text('Zora'), findsOneWidget);
  });

  testWidgets('the table shows the age column and sorts by it', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await pump(tester);
    await tester.tap(find.byTooltip('Show as table'));
    await tester.pumpAndSettle();
    expect(find.byType(DataTable), findsOneWidget);
    expect(find.text('Age'), findsOneWidget);
    expect(find.textContaining('yrs'), findsOneWidget);
    await tester.tap(find.text('Age'));
    await tester.pumpAndSettle();
    expect(store.localSetting(catSortKey), 'age,asc');
    // The cat with a known age comes first; the unknown one last.
    expect(
      tester.getTopLeft(find.text('Anton')).dy,
      lessThan(tester.getTopLeft(find.text('Zora')).dy),
    );
  });

  testWidgets('a pre-filtered set lists only those cats', (tester) async {
    final ids = {store.cats().firstWhere((c) => c.name == 'Zora').id};
    await pump(
      tester,
      source: (s) => [
        for (final c in s.visibleCats())
          if (ids.contains(c.id)) c,
      ],
    );
    expect(find.text('Zora'), findsOneWidget);
    expect(find.text('Anton'), findsNothing);
  });
}
