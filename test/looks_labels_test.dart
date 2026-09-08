import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/field_labels.dart';
import 'package:catlog/src/looks_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every Looks group and value has a word in every language; the
/// stored keys stay English.
void main() {
  test('every group and value of every species is translated', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final t = lookupAppLocalizations(locale);
      for (final species in [...speciesPresets, null]) {
        for (final group in looksGroupsFor(species)) {
          expect(
            looksGroupLabel(t, group.id),
            isNot(group.id),
            reason: '${locale.languageCode} group ${group.id}',
          );
          for (final v in group.values) {
            final label = looksValueLabel(t, group.id, v);
            expect(label, isNotEmpty);
            if (v != 'yes' && v != 'no') {
              expect(
                label,
                isNot(v),
                reason: '${locale.languageCode} value $v',
              );
            }
          }
        }
      }
    }
  });

  test('the line reads in the device language', () {
    final en = lookupAppLocalizations(const Locale('en'));
    final de = lookupAppLocalizations(const Locale('de'));
    const line = 'size=medium; colours=black,white; ring=yes';
    expect(
      looksDisplay(en, line),
      'Size: Medium · Colours: Black, White · Leg ring: yes',
    );
    expect(
      looksDisplay(de, line),
      'Größe: Mittel · Farben: Schwarz, Weiß · Fußring: ja',
    );
    expect(looksDisplay(en, 'nonsense'), 'nonsense');
  });

  test('the sync and catalog-settings help explain keys', () {
    final t = lookupAppLocalizations(const Locale('en'));
    expect(t.helpSync, contains('signs what it writes with its own key'));
    expect(t.helpCatalogSettings, contains('Your key is the code'));
  });

  test('the matches help explains Looks pairs', () {
    final t = lookupAppLocalizations(const Locale('en'));
    expect(t.helpMatches, contains('Looks agree in two traits'));
    expect(t.helpMatchesNeutral, contains('Looks agree in two traits'));
  });

  test('every cat breed has a name in every language', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final t = lookupAppLocalizations(locale);
      final def = const FieldDef(
          id: 'fielddef:breed',
          slug: 'breed',
          name: 'Breed',
          type: FieldType.choice,
          scope: FieldScope.cat);
      for (final breed in catBreeds) {
        expect(fieldValueDisplay(t, def, breed), isNotEmpty,
            reason: '${locale.languageCode} $breed');
        if (locale.languageCode == 'ja' || locale.languageCode == 'ru') {
          expect(fieldValueDisplay(t, def, breed), isNot(breed),
              reason: '${locale.languageCode} $breed');
        }
      }
    }
  });
}
