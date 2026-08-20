import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Registry lookups: an ID field pointed at a service, the link a
/// poster carries, and learning an unknown service from that link.
void main() {
  setUpAll(useSystemSqlite);

  const tasso =
      'https://www.tasso.net/Tierregister/Suchmeldungen?snr={value}';
  // Exactly what a poster's link looks like — extra parameters included.
  const scanned = 'https://www.tasso.net/Tierregister/Suchmeldungen'
      '?lang=de-DE&snr=S3101849&lp=0';

  test('the template builds a working link', () {
    expect(buildLookupUrl(tasso, ' S3101849 '),
        'https://www.tasso.net/Tierregister/Suchmeldungen?snr=S3101849');
  });

  test('a scanned link yields its number despite extra parameters', () {
    expect(idFromLookupUrl(tasso, scanned), 'S3101849');
    final hit = recognizeLookupUrl(scanned);
    expect(hit!.preset.name, 'Tasso');
    expect(hit.value, 'S3101849');
  });

  test('another service is not mistaken for a known one', () {
    expect(recognizeLookupUrl('https://www.findefix.com/suche?nr=P0815'),
        isNull);
    expect(idFromLookupUrl(tasso, 'https://www.tasso.net/Kontakt?snr=1'),
        isNull);
  });

  test('an unknown service is learned from the link and the number', () {
    final learned =
        learnLookupTemplate('https://pets.example/search?id=AB-12&lang=en',
            'ab12');
    expect(learned, 'https://pets.example/search?id={value}');
    expect(idFromLookupUrl(learned!, 'https://pets.example/search?id=XY9'),
        'XY9');
  });

  test('a number sitting in the path is learned too', () {
    final learned =
        learnLookupTemplate('https://pets.example/pet/AB12/report', 'AB12');
    expect(learned, 'https://pets.example/pet/{value}/report');
    expect(idFromLookupUrl(learned!, 'https://pets.example/pet/ZZ9/report'),
        'ZZ9');
  });

  test('links are picked out of flier text', () {
    final urls = urlsIn('Vermisst! Infos unter '
        'www.tasso.net/Tierregister/Suchmeldungen?snr=S3101849, '
        'oder https://example.org/lost.');
    expect(urls, [
      'https://www.tasso.net/Tierregister/Suchmeldungen?snr=S3101849',
      'https://example.org/lost',
    ]);
  });

  test('a field carries its service through define and projection', () {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'test';
    store.defineField('Tasso', FieldType.id,
        scope: FieldScope.cat, lookupUrl: tasso);
    final def =
        store.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    expect(def.lookupUrl, tasso);
    expect(lookupUrl(def, 'S3101849'),
        'https://www.tasso.net/Tierregister/Suchmeldungen?snr=S3101849');

    // Detaching the service leaves the values alone.
    store.setFieldLookupUrl(def.id, null);
    expect(store.fieldDefs().firstWhere((d) => d.slug == 'tasso').lookupUrl,
        isNull);
  });

  test('a shared cat brings the service along', () {
    final store = CatalogStore.inMemory();
    addTearDown(store.close);
    store.author = 'test';
    store.defineField('Tasso', FieldType.id,
        scope: FieldScope.cat, lookupUrl: tasso);
    final cat = store.createCat('Simba');
    store.append(cat, Keys.userField('tasso'), 'S3101849');

    final bytes = catShareBytes(store,
        catId: cat, fields: {Keys.userField('tasso')},
        includePhotos: false);
    final other = CatalogStore.inMemory();
    addTearDown(other.close);
    other.author = 'other';
    importBundleBytes(other, bytes);
    final def =
        other.fieldDefs().firstWhere((d) => d.slug == 'tasso');
    expect(def.lookupUrl, tasso);
  });
}
