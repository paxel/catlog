import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/field_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The date editor is typed first (#79): a day, a month or a year lands
/// at the precision entered (#76); a wrong spelling names the forms that
/// work; the calendar waits behind its icon.
void main() {
  final def = FieldDef(
      id: 'fielddef:due',
      slug: 'due',
      name: 'Due',
      type: FieldType.date,
      scope: FieldScope.cat,
      options: const []);

  Future<BuildContext> pump(WidgetTester tester) async {
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Builder(builder: (c) {
        context = c;
        return const SizedBox();
      })),
    ));
    return context;
  }

  // The field's own calendar icon — the "as of" tile below carries the
  // same icon.
  final calendarIcon = find.descendant(
      of: find.byType(TextField),
      matching: find.byIcon(Icons.edit_calendar_outlined));

  testWidgets('a typed month is stored as a month', (tester) async {
    final context = await pump(tester);
    FieldEdit? edit;
    editFieldValue(context, def, '2026-08-18').then((e) => edit = e);
    await tester.pumpAndSettle();
    expect(find.text('2026-08-18'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '05.2021');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(edit?.value, '2021-05');
  });

  testWidgets('a wrong spelling is named, a bare year is fine',
      (tester) async {
    final context = await pump(tester);
    editFieldValue(context, def, null);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'last summer');
    await tester.pumpAndSettle();
    expect(find.textContaining('Wrong format'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '2021');
    await tester.pumpAndSettle();
    expect(find.textContaining('Wrong format'), findsNothing);
  });

  testWidgets('the calendar behind the icon fills the field',
      (tester) async {
    final context = await pump(tester);
    editFieldValue(context, def, '2026-08-18');
    await tester.pumpAndSettle();
    await tester.tap(calendarIcon);
    await tester.pumpAndSettle();
    expect(find.text('August 2026'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('2026-08-18'), findsOneWidget);
  });

  testWidgets('a birth date in the future is refused while typing',
      (tester) async {
    final context = await pump(tester);
    final birth = FieldDef(
        id: 'fielddef:birthdate',
        slug: 'birthdate',
        name: 'Birth date',
        type: FieldType.date,
        scope: FieldScope.cat,
        options: const []);
    FieldEdit? edit;
    editFieldValue(context, birth, null).then((e) => edit = e);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '2099');
    await tester.pumpAndSettle();
    expect(find.text("This date can't be in the future."), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(edit?.value, isNull);
  });
}
