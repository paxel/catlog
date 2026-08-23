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
    test('public sync carries the cat and its name, not its values', () {
      final home = a.createClowder('Home');
      final cat = a.createCat('Secret', clowderId: home);
      a.append(cat, 'f:color', 'black');
      a.setPrivate(cat, true);
      sync(a, b);
      expect(b.cats().map((c) => c.id), contains(cat));
      expect(b.current(cat, Keys.name), 'Secret');
      expect(b.current(cat, 'f:color'), isNull);
      expect(b.isWithheld(cat, 'f:color'), isTrue);
      // Which values are private is not the partner's business.
      expect(b.isPrivate(cat), isFalse);
      expect(b.current(cat, Keys.privateField('f:color')), isNull);
    });

    test('a private clowder keeps its name and loses its address', () {
      final hidden = a.createClowder('Hideout');
      a.append(hidden, 'f:address', 'holbeinstr 15');
      a.setPrivate(hidden, true);
      sync(a, b);
      expect(b.clowders().map((c) => c.id), contains(hidden));
      expect(b.current(hidden, Keys.name), 'Hideout');
      expect(b.current(hidden, 'f:address'), isNull);
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
      // The definition travels — a partner needs it to render the field
      // at all — but no cat's value for it does.
      expect(b.fieldDefs().map((d) => d.id), contains(def));
      expect(b.current(cat, key), isNull);
      expect(b.isWithheld(cat, key), isTrue);
    });

    test('include-private transfers the values AND the marker', () {
      final cat = a.createCat('Secret');
      a.append(cat, 'f:color', 'black');
      a.setPrivate(cat, true);
      sync(a, b, aPrivate: true);
      expect(b.current(cat, 'f:color'), 'black');
      expect(b.isPrivate(cat), isTrue);
      // The receiving device withholds it from third parties in turn.
      final c = CatalogStore.inMemory()..author = 'cleo';
      sync(b, c);
      expect(c.cats().map((x) => x.id), contains(cat));
      expect(c.current(cat, 'f:color'), isNull);
      c.close();
    });

    test('unmark re-asserts values past peers\' advanced vectors', () {
      final cat = a.createCat('Shy');
      a.append(cat, 'f:color', 'black', date: DateTime.utc(2020, 1, 1));
      a.setPrivate(cat, true);
      sync(a, b); // b's vector advances past the withheld rows
      expect(b.current(cat, 'f:color'), isNull);
      a.setPrivate(cat, false);
      sync(a, b);
      expect(b.current(cat, 'f:color'), 'black');
      expect(b.isWithheld(cat, 'f:color'), isFalse);
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
    test('public bundle excludes private values and their photos', () {
      final cat = a.createCat('Secret');
      a.addImage(cat, jpeg(40, 40));
      a.setPrivate(cat, true);
      final pub = a.createCat('Public');
      final dir = Directory.systemTemp.createTempSync('catlog-private');
      addTearDown(() => dir.deleteSync(recursive: true));

      importBundle(b, writeBundle(a, '${dir.path}/pub.catsync'));
      expect(b.cats().map((c) => c.id).toSet(), {cat, pub});
      expect(b.images(cat), isEmpty);
      expect(b.missingBlobs(), isEmpty);

      final c = CatalogStore.inMemory()..author = 'cleo';
      importBundle(
          c,
          writeBundle(a, '${dir.path}/all.catsync',
              includePrivate: true));
      expect(c.cats().length, 2);
      expect(c.isPrivate(cat), isTrue);
      expect(c.images(cat).length, 1);
      expect(c.missingBlobs(), isEmpty);
      c.close();
    });
  });
}
