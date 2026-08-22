import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

/// Two-way sync with per-side privacy choice, as the transports do it.
void sync(CatalogStore a, CatalogStore b,
    {bool aPrivate = false, bool bPrivate = false}) {
  final va = a.versionVector();
  final vb = b.versionVector();
  b.applyEntries(a.entriesSince(vb, includePrivate: aPrivate),
      senderVector: va);
  a.applyEntries(b.entriesSince(va, includePrivate: bPrivate),
      senderVector: vb);
}

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a, b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'ben';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  group('private stripping', () {
    test('public sync carries neither the entity nor its marker', () {
      final home = a.createClowder('Home');
      final cat = a.createCat('Secret', clowderId: home);
      a.setPrivate(cat, true);
      sync(a, b);
      expect(b.cats(), isEmpty);
      expect(b.clowders().map((c) => c.id), contains(home));
      expect(
          b.entriesSince(const {}, includePrivate: true), isNot(isEmpty));
      expect(
          b
              .entriesSince(const {}, includePrivate: true)
              .where((e) => e.entity == cat),
          isEmpty);
    });

    test('private clowder stays home, its marker too', () {
      final hidden = a.createClowder('Hideout');
      a.setPrivate(hidden, true);
      sync(a, b);
      expect(b.clowders(), isEmpty);
    });

    test('private field definition strips its values on every cat', () {
      final cat = a.createCat('Miezi');
      final def =
          a.defineField('Secret note', FieldType.text, scope: FieldScope.cat);
      final key = 'f:${def.substring('fielddef:'.length)}';
      a.append(cat, key, 'do not tell');
      a.setPrivate(def, true);
      sync(a, b);
      expect(b.cats().map((c) => c.id), contains(cat));
      expect(b.fieldDefs().where((d) => d.id == def), isEmpty);
      expect(b.current(cat, key), isNull);
    });

    test('include-private transfers the entity AND the marker', () {
      final cat = a.createCat('Secret');
      a.setPrivate(cat, true);
      sync(a, b, aPrivate: true);
      expect(b.cats().map((c) => c.id), contains(cat));
      expect(b.isPrivate(cat), isTrue);
      // The receiving device withholds it from third parties in turn.
      final c = CatalogStore.inMemory()..author = 'cleo';
      sync(b, c);
      expect(c.cats(), isEmpty);
      c.close();
    });

    test('unmark re-asserts history past peers\' advanced vectors', () {
      final cat = a.createCat('Shy');
      a.append(cat, 'f:color', 'black', date: DateTime.utc(2020, 1, 1));
      a.setPrivate(cat, true);
      sync(a, b); // b's vector advances past the withheld rows
      expect(b.cats(), isEmpty);
      a.setPrivate(cat, false);
      sync(a, b);
      expect(b.cats().map((c) => c.id), contains(cat));
      expect(b.current(cat, 'f:color'), 'black');
    });

    test('re-assertion does not double the diary', () {
      final cat = a.createCat('Shy');
      a.append(cat, 'f:color', 'black');
      a.setPrivate(cat, true);
      a.setPrivate(cat, false);
      final colorRows =
          a.timeline(cat).where((e) => e.field == 'f:color');
      expect(colorRows.length, 1);
    });
  });

  group('bundle privacy', () {
    test('public bundle excludes private cats, entries and photos', () {
      final cat = a.createCat('Secret');
      a.addImage(cat, jpeg(40, 40));
      a.setPrivate(cat, true);
      final pub = a.createCat('Public');
      final dir = Directory.systemTemp.createTempSync('catlog-private');
      addTearDown(() => dir.deleteSync(recursive: true));

      importBundle(b, writeBundle(a, '${dir.path}/pub.catsync'));
      expect(b.cats().map((c) => c.id), [pub]);
      expect(b.missingBlobs(), isEmpty);

      final c = CatalogStore.inMemory()..author = 'cleo';
      importBundle(
          c,
          writeBundle(a, '${dir.path}/all.catsync',
              includePrivate: true));
      expect(c.cats().length, 2);
      expect(c.isPrivate(cat), isTrue);
      expect(c.missingBlobs(), isEmpty);
      c.close();
    });
  });
}
