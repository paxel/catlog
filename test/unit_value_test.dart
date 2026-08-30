import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/l10n/app_localizations_de.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/field_editing.dart';
import 'package:catlog/src/field_labels.dart';
import 'package:catlog/src/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Unit Values (#96): entered and shown in the device's unit, stored in
/// the base unit, the device side chosen from the region or by hand.
void main() {
  setUpAll(useSystemSqlite);
  tearDown(() => unitSystem.value = UnitSystem.metric);

  const weight = FieldDef(
      id: 'fielddef:weight',
      slug: 'weight',
      name: 'Weight',
      type: FieldType.unitValue,
      scope: FieldScope.cat,
      dimension: Dimension.weight);

  test('the region picks the side unless the keeper did', () {
    expect(unitSystemFor(null, const Locale('en', 'US')), UnitSystem.imperial);
    expect(unitSystemFor(null, const Locale('de', 'DE')), UnitSystem.metric);
    expect(unitSystemFor('metric', const Locale('en', 'US')),
        UnitSystem.metric);
    expect(unitSystemFor('imperial', const Locale('de', 'DE')),
        UnitSystem.imperial);
  });

  test('display follows the device side and the locale', () {
    expect(fieldValueDisplay(AppLocalizationsEn(), weight, '4250'), '4.25 kg');
    expect(fieldValueDisplay(AppLocalizationsDe(), weight, '4250'), '4,25 kg');
    unitSystem.value = UnitSystem.imperial;
    expect(fieldValueDisplay(AppLocalizationsEn(), weight, '4250'), '9.4 lb');
  });

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

  testWidgets('the editor shows kilograms and stores grams', (tester) async {
    final context = await pump(tester);
    FieldEdit? edit;
    editFieldValue(context, weight, '4250').then((e) => edit = e);
    await tester.pumpAndSettle();
    expect(find.text('4.25'), findsOneWidget);
    expect(find.text('kg'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '5,1');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(edit?.value, '5100');
  });

  testWidgets('an imperial device types pounds, stores grams', (tester) async {
    unitSystem.value = UnitSystem.imperial;
    final context = await pump(tester);
    FieldEdit? edit;
    editFieldValue(context, weight, '4250').then((e) => edit = e);
    await tester.pumpAndSettle();
    expect(find.text('9.37'), findsOneWidget);
    expect(find.text('lb'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '10');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(edit?.value, '4535.9');
  });
}
