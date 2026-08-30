import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Species grew from free text to a choice with presets (#94): a
/// catalog seeded before that gets the list once, on open, as synced
/// field-definition entries; values already stored stay as they are.
void main() {
  setUpAll(useSystemSqlite);

  test('an old catalog with a text Species field gets the presets on open',
      () {
    final root = Directory.systemTemp.createTempSync('catlog-species');
    addTearDown(() => root.deleteSync(recursive: true));
    final path = '${root.path}/catlog.db';
    final old = CatalogStore.open(path)..author = 'test';
    final cat = old.createCat('Miezi');
    old.append(cat, 'f:species', 'lynx');
    // What a 1.0.x catalog carries: the field as free text, no list.
    old.append('fielddef:species', Keys.fieldType, FieldType.text.name);
    old.append('fielddef:species', Keys.fieldOptions, '');
    old.close();

    final store = CatalogStore.open(path)..author = 'test';
    addTearDown(store.close);
    final species = store.fieldDefs().firstWhere((d) => d.slug == 'species');
    expect(species.type, FieldType.choice);
    expect(species.options, speciesPresets);
    expect(store.current(cat, 'f:species'), 'lynx');
    // The change is an entry like any other, so partners receive it.
    final defEntries = store
        .entriesSince(const {})
        .where((e) => e.entity == 'fielddef:species')
        .map((e) => e.field);
    expect(defEntries, contains(Keys.fieldType));
    expect(defEntries, contains(Keys.fieldOptions));

    // A second open changes nothing more.
    final before = store.entriesSince(const {}).length;
    store.close();
    final again = CatalogStore.open(path);
    addTearDown(again.close);
    expect(again.entriesSince(const {}).length, before);
  });
}
