import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/pet_mode.dart';
import 'package:catlog/src/screens/cat_detail_screen.dart';
import 'package:catlog/src/screens/match_candidates_screen.dart';
import 'package:catlog/src/widgets/looks_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Looks in the UI: the chip editor, the read-mode line, the pairs it
/// yields on the match list with their Reject, and the question after
/// a capture.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() => store = CatalogStore.inMemory()..author = 'anna');
  tearDown(() {
    petMode.value = false;
    store.close();
  });

  Widget app(Widget home) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );

  FieldDef looksDef() => store.fieldDefs().firstWhere((d) => d.slug == 'looks');

  testWidgets('chips: one-value groups swap, many-value groups collect', (
    tester,
  ) async {
    String? value;
    await tester.pumpWidget(
      app(
        Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: LooksInput(
                species: 'cat',
                value: value,
                onChanged: (v) => setState(() => value = v),
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Pattern'), findsOneWidget);
    expect(find.text('Crest'), findsNothing);
    await tester.tap(find.text('Small'));
    await tester.pump();
    expect(value, 'size=small');
    await tester.tap(find.text('Large'));
    await tester.pump();
    expect(value, 'size=large');
    await tester.tap(find.text('Black'));
    await tester.pump();
    await tester.tap(find.text('White'));
    await tester.pump();
    expect(value, 'size=large; colours=black,white');
    await tester.tap(find.text('Large'));
    await tester.pump();
    expect(value, 'colours=black,white');
  });

  testWidgets('a bird gets plumage groups, an unknown species two', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                LooksInput(species: 'bird', value: null, onChanged: (_) {}),
                LooksInput(species: null, value: null, onChanged: (_) {}),
              ],
            ),
          ),
        ),
      ),
    );
    expect(find.text('Beak'), findsOneWidget);
    expect(find.text('Fur'), findsNothing);
    expect(find.text('Size'), findsNWidgets(2));
    expect(find.text('Marks'), findsOneWidget);
  });

  testWidgets('the cat page reads the line and edits it with chips', (
    tester,
  ) async {
    final cat = store.createCat('Miezi');
    store.append(cat, 'f:looks', 'size=medium; colours=black,white');
    await tester.pumpWidget(app(CatDetailScreen(store: store, catId: cat)));
    await tester.pumpAndSettle();
    expect(find.text('Looks'), findsOneWidget);
    expect(find.text('Size: Medium · Colours: Black, White'), findsOneWidget);

    // Edit mode: the editor dialog shows the cat's groups.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Looks'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Looks'));
    await tester.pumpAndSettle();
    expect(find.text('Tabby'), findsOneWidget);
    await tester.tap(find.text('Tabby'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(
      store.current(cat, 'f:looks'),
      'size=medium; colours=black,white; pattern=tabby',
    );
  });

  testWidgets('a Looks pair lists with its traits; Reject hides it', (
    tester,
  ) async {
    final home = store.createClowder('Müllers');
    final lost = store.createCat('Minka', clowderId: home);
    final seen = store.createCat('Fundkatze');
    store.append(lost, 'f:looks', 'size=small; fur=long; colours=black');
    store.append(seen, 'f:looks', 'size=small; fur=long; colours=black,white');
    store.append(lost, 'f:gender', 'female');
    store.append(seen, 'f:gender', 'female');
    await tester.pumpWidget(app(MatchCandidatesScreen(store: store)));
    await tester.pumpAndSettle();
    expect(find.text('Minka · Fundkatze'), findsOneWidget);
    expect(find.text('4 traits agree'), findsOneWidget);
    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Fur'), findsOneWidget);

    await tester.tap(find.byTooltip('Not the same'));
    await tester.pumpAndSettle();
    expect(find.text('No match candidates right now.'), findsOneWidget);
    expect(isLooksRejected(store, lost, seen), isTrue);
  });

  testWidgets('after a capture: species in a pets catalog, then Looks', (
    tester,
  ) async {
    petMode.value = true;
    final cat = store.createCat('Stray');
    late BuildContext ctx;
    await tester.pumpWidget(
      app(
        Scaffold(
          body: Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    final done = askLooksAfterCapture(ctx, store, cat);
    await tester.pumpAndSettle();
    expect(find.text('Species'), findsOneWidget);
    await tester.tap(find.text('Dog'));
    await tester.pumpAndSettle();
    expect(store.current(cat, 'f:species'), 'dog');
    expect(store.localSetting(lastSpeciesKey), 'dog');
    // The dog's own pattern list, then a save.
    expect(find.text('Brindle'), findsOneWidget);
    await tester.tap(find.text('Brindle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Small'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await done;
    expect(store.current(cat, looksDef().key), 'size=small; pattern=brindle');
  });

  testWidgets('a cats catalog skips the species question', (tester) async {
    final cat = store.createCat('Stray');
    late BuildContext ctx;
    await tester.pumpWidget(
      app(
        Scaffold(
          body: Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    final done = askLooksAfterCapture(ctx, store, cat);
    await tester.pumpAndSettle();
    expect(find.text('Species'), findsNothing);
    expect(find.text('Tabby'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await done;
    expect(store.current(cat, 'f:looks'), isNull);
  });
}
