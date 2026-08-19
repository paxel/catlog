import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/share_import.dart';
import 'package:catlog/src/share_publicly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// #40 app side: whitelist chips on the share screen, preview-then-
/// confirm on the finder's scan.
void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore owner;
  late String cat;

  setUp(() {
    owner = CatalogStore.inMemory();
    owner.author = 'owner';
    final home = owner.createClowder('Familie Huber');
    cat = owner.createCat('Minka', clowderId: home);
    owner.append(cat, Keys.userField('gender'), 'female');
    owner.append(cat, Keys.userField('remarks'), 'private notes');
  });

  tearDown(() => owner.close());

  testWidgets('the share screen offers filled fields and an inline QR',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SharePubliclyScreen(store: owner, catId: cat),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Remarks'), findsOneWidget);
    expect(find.text('Inline QR (text only, no photos)'), findsOneWidget);
  });

  testWidgets('scan, preview, confirm — only then the cat lands',
      (tester) async {
    final bytes = catShareBytes(owner,
        catId: cat,
        fields: {Keys.userField('gender')},
        includePhotos: false);
    final code = encodeShareData(bytes);
    final finder = CatalogStore.inMemory();
    addTearDown(finder.close);
    finder.author = 'finder';

    late BuildContext context;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ScaffoldMessenger(
        child: Builder(builder: (c) {
          context = c;
          return const Scaffold(body: SizedBox());
        }),
      ),
    ));

    await tester.runAsync(() async {
      final future = scanShareCode(context, finder,
          scan: (_) async => code,
          fetch: (_) async => Uint8List(0));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
      // Preview shows the cat and its owner clowder; nothing imported yet.
      expect(find.text('Minka'), findsOneWidget);
      expect(find.text('Familie Huber'), findsOneWidget);
      expect(finder.cats(), isEmpty);
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();
      await future;
    });

    final imported = finder.cats().single;
    expect(imported.name, 'Minka');
    expect(finder.current(imported.id, Keys.userField('gender')),
        'female');
    // The un-whitelisted remarks never arrived.
    expect(finder.current(imported.id, Keys.userField('remarks')), isNull);
  });

  testWidgets('garbage codes explain themselves and import nothing',
      (tester) async {
    final finder = CatalogStore.inMemory();
    addTearDown(finder.close);
    finder.author = 'finder';
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(builder: (c) {
        context = c;
        return const Scaffold(body: SizedBox());
      }),
    ));
    await scanShareCode(context, finder,
        scan: (_) async => 'https://random.example/whatever',
        fetch: (_) async => Uint8List(0));
    await tester.pump();
    expect(find.text('That code is not a cat(a)log share.'),
        findsOneWidget);
    expect(finder.cats(), isEmpty);
  });
}
