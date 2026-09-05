import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

Uint8List jpeg(int w, int h) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: w, height: h)));

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore store;

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'axel';
  });

  tearDown(() => store.close());

  group('cat merge', () {
    test('survivor keeps its values, loser fills gaps, history unites', () {
      final home = store.createClowder('Home');
      final survivor = store.createCat('Miezi', clowderId: home);
      store.append(survivor, 'f:neutered', 'yes');

      final loser = store.createCat('Mizzi', clowderId: home);
      store.append(loser, 'f:color', 'black');
      // Loser's rename is NEWER — survivor must still win after merge.
      store.append(loser, Keys.name, 'Mizzi II');

      store.mergeCat(loser, survivor);

      expect(store.cats().single.id, survivor);
      expect(store.current(survivor, Keys.name), 'Miezi');
      expect(store.current(survivor, 'f:neutered'), 'yes');
      expect(store.current(survivor, 'f:color'), 'black'); // gap filled
      // Combined timeline holds the loser's past.
      expect(store.timeline(survivor).map((e) => e.value),
          contains('Mizzi II'));
    });

    test('loser photos show on the survivor', () {
      final survivor = store.createCat('Miezi');
      final loser = store.createCat('Mizzi');
      final hash = store.addImage(
          loser, CatalogStore.compressImage(jpeg(40, 40)));

      store.mergeCat(loser, survivor);
      expect(store.images(survivor), contains(hash));
    });

    test('merge is guarded: self, cycle, double merge', () {
      final a = store.createCat('A');
      final b = store.createCat('B');
      final c = store.createCat('C');
      expect(() => store.mergeCat(a, a), throwsArgumentError);
      store.mergeCat(a, b);
      expect(() => store.mergeCat(b, a), throwsArgumentError); // cycle
      expect(() => store.mergeCat(a, c), throwsArgumentError); // re-merge
    });
  });

  group('clowder merge', () {
    test('membership pointing at the loser resolves to the survivor', () {
      final survivor = store.createClowder('Foster Home');
      final loser = store.createClowder('Foster Home (dup)');
      final cat = store.createCat('Miezi', clowderId: loser);

      store.mergeClowder(loser, survivor);

      expect(store.clowders().single.id, survivor);
      expect(store.current(cat, Keys.clowder), survivor);
      expect(store.cats(clowderId: survivor).single.id, cat);
      // Querying by the old id also lands on the survivor.
      expect(store.cats(clowderId: loser).single.id, cat);
    });

    test('offline case: a move to the loser arriving after the merge', () {
      final other = CatalogStore.inMemory()..author = 'friend';
      final survivor = store.createClowder('Foster Home');
      final loser = store.createClowder('Foster Home (dup)');
      final cat = store.createCat('Miezi');
      // Friend gets everything, then (offline) moves the cat to the dup.
      other.applyEntries(store.entriesSince({}));
      final catOnOther = other.cats().single.id;
      final loserOnOther = other
          .clowders()
          .firstWhere((c) => c.name.contains('dup'))
          .id;
      // Meanwhile we merge the duplicate away.
      store.mergeClowder(loser, survivor);
      other.moveCat(catOnOther, loserOnOther);
      // The move syncs in AFTER the merge.
      store.applyEntries(other.entriesSince(store.versionVector()));
      expect(store.current(cat, Keys.clowder), survivor);
      expect(store.cats(clowderId: survivor).single.id, cat);
      other.close();
    });
  });

  group('field merge', () {
    test('values under either key read as the survivor field', () {
      final legs = store.defineField('Number of legs', FieldType.number);
      final limbs = store.defineField('Limbs', FieldType.number);
      final cat = store.createCat('Miezi');
      store.append(cat, 'f:limbs', '4');

      store.mergeField(limbs, legs);

      expect(store.current(cat, 'f:number-of-legs'), '4');
      expect(store.fieldDefs().map((d) => d.slug),
          isNot(contains('limbs')));
      // History reads across both keys.
      expect(store.fieldHistory(cat, 'f:number-of-legs'), isNotEmpty);
      // Display key of the raw stored key resolves to the survivor.
      expect(store.canonicalKey('f:limbs'), 'f:number-of-legs');
    });

    test('latest-wins across aliased keys for per-cat values', () {
      final legs = store.defineField('Number of legs', FieldType.number);
      final limbs = store.defineField('Limbs', FieldType.number);
      final cat = store.createCat('Miezi');
      store.append(cat, 'f:number-of-legs', '4',
          date: DateTime.utc(2026, 1, 1));
      store.append(cat, 'f:limbs', '3', date: DateTime.utc(2026, 6, 1));

      store.mergeField(limbs, legs);
      expect(store.current(cat, 'f:number-of-legs'), '3');
    });

    test('different types merge; the survivor type wins', () {
      final a = store.defineField('Girth', FieldType.number);
      final b = store.defineField('Notes', FieldType.text);
      final cat = store.createCat('Miezi');
      store.append(cat, 'f:girth', '4.2', date: DateTime.utc(2026, 1, 1));
      store.mergeField(a, b);
      // Old numeric value resolves through the alias to the text field.
      expect(store.current(cat, 'f:notes'), '4.2');
      expect(store.fieldDefs().where((d) => d.slug == 'girth'), isEmpty);
      final notes = store.fieldDefs().firstWhere((d) => d.slug == 'notes');
      expect(notes.type, FieldType.text);
    });

    test('non-field entities still refuse to merge with fields', () {
      final a = store.defineField('Girth', FieldType.number);
      final cat = store.createCat('Miezi');
      expect(() => store.mergeField(a, cat), throwsArgumentError);
    });
  });
}
