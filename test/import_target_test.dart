import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/import_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A shared file asks for its catalog first (#90): the active one is
/// preselected, any other can be picked, and "New catalog" names one
/// from the file.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;
  late CatalogManager catalogs;
  setUp(() {
    root = Directory.systemTemp.createTempSync('catlog-import');
    catalogs = CatalogManager.open(root.path, defaultName: 'Berlin');
    catalogs.create('Paris');
  });
  tearDown(() => root.deleteSync(recursive: true));

  Future<BuildContext> pump(WidgetTester tester) async {
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (c) {
              context = c;
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    return context;
  }

  testWidgets('the active catalog is preselected; another can be picked', (
    tester,
  ) async {
    final context = await pump(tester);
    ImportTarget? target;
    chooseImportTarget(
      context,
      catalogs,
      'Minka-share.catsync',
    ).then((t) => target = t);
    await tester.pumpAndSettle();
    expect(find.text('Minka-share.catsync'), findsOneWidget);
    expect(find.text('Berlin'), findsOneWidget);
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Paris').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Import'));
    await tester.pumpAndSettle();
    expect(target, isA<ImportInto>());
    expect((target! as ImportInto).catalog.name, 'Paris');
  });

  testWidgets('"New catalog" asks for a name prefilled from the file', (
    tester,
  ) async {
    final context = await pump(tester);
    ImportTarget? target;
    chooseImportTarget(
      context,
      catalogs,
      'Minka-share.catsync',
    ).then((t) => target = t);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Berlin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New catalog…').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Import'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextField, 'Minka-share'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(target, isA<ImportIntoNew>());
    expect((target! as ImportIntoNew).name, 'Minka-share');
  });

  testWidgets('cancel returns nothing', (tester) async {
    final context = await pump(tester);
    ImportTarget? target = const ImportIntoNew('x');
    chooseImportTarget(
      context,
      catalogs,
      'Minka-share.catsync',
    ).then((t) => target = t);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(target, isNull);
  });
}
