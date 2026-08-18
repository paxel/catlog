import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/field_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Regression: the date editor's CalendarDatePicker sat unbounded in the
/// AlertDialog, its viewport's page metrics degenerated, and the month
/// arrows jumped several months per tap (March 2027 -> August 2027).
void main() {
  testWidgets('date editor: month arrows step exactly one month',
      (tester) async {
    final def = FieldDef(
        id: 'fielddef:due',
        slug: 'due',
        name: 'Due',
        type: FieldType.date,
        scope: FieldScope.cat,
        options: const []);
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Builder(builder: (c) {
        context = c;
        return const SizedBox();
      })),
    ));
    editFieldValue(context, def, '2026-08-18');
    await tester.pumpAndSettle();
    expect(find.text('August 2026'), findsOneWidget);

    // Into 2027 via the year grid, then five months back.
    await tester.tap(find.text('August 2026'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2027'));
    await tester.pumpAndSettle();
    expect(find.text('August 2027'), findsOneWidget);
    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
    }
    expect(find.text('March 2027'), findsOneWidget);

    // One tap forward lands on the very next month, not months away.
    await tester.tap(find.byTooltip('Next month'));
    await tester.pumpAndSettle();
    expect(find.text('April 2027'), findsOneWidget);
  });
}
