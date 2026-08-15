import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:image/image.dart' as img;
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

/// A synthetic JPEG of the given size.
Uint8List makeJpeg(int width, int height) =>
    Uint8List.fromList(img.encodeJpg(img.Image(width: width, height: height)));

void main() {
  late CatalogStore store;

  setUpAll(useSystemSqlite);

  setUp(() {
    store = CatalogStore.inMemory();
    store.author = 'axel';
  });

  tearDown(() => store.close());

  group('author', () {
    test('is null until configured, then persists', () {
      final fresh = CatalogStore.inMemory();
      expect(fresh.author, isNull);
      fresh.author = 'friend';
      expect(fresh.author, 'friend');
      fresh.close();
    });

    test('rejects empty names', () {
      expect(() => store.author = '  ', throwsArgumentError);
    });

    test('appending without an author fails', () {
      final fresh = CatalogStore.inMemory();
      expect(() => fresh.append('x', 'name', 'y'), throwsStateError);
      fresh.close();
    });
  });

  group('clowders', () {
    test('created clowder appears in list with its name', () {
      final id = store.createClowder('Foster Home South');
      expect(store.clowders().map((c) => c.id), contains(id));
      expect(
        store.clowders().firstWhere((c) => c.id == id).name,
        'Foster Home South',
      );
    });

    test('address and responsible person are ordinary field values', () {
      final id = store.createClowder('Home');
      final address = store
          .fieldDefs(scope: FieldScope.clowder)
          .firstWhere((d) => d.slug == 'address');
      store.append(id, address.key, 'Main Street 7');
      expect(store.current(id, address.key), 'Main Street 7');
    });
  });

  group('latest-wins projection (ADR-0001)', () {
    test('edit twice: latest shows, both stay in history', () {
      final id = store.createClowder('Old Name');
      store.append(id, Keys.name, 'New Name');
      expect(store.current(id, Keys.name), 'New Name');

      final history = store.fieldHistory(id, Keys.name);
      expect(history.map((e) => e.value), containsAll(['Old Name', 'New Name']));
      expect(history.first.value, 'New Name');
      expect(history.every((e) => e.author == 'axel'), isTrue);
    });

    test('later effective date wins even if recorded earlier', () {
      final id = store.createClowder('Home');
      store.append(id, Keys.name, 'Future Name',
          date: DateTime.utc(2030, 1, 1));
      store.append(id, Keys.name, 'Present Name');
      expect(store.current(id, Keys.name), 'Future Name');
    });

    test('backdated entry does not override the present', () {
      final id = store.createClowder('Home');
      store.append(id, Keys.name, 'Historic Name',
          date: DateTime.utc(2020, 5, 3));
      expect(store.current(id, Keys.name), 'Home');
      expect(store.fieldHistory(id, Keys.name).last.value, 'Historic Name');
    });

    test('currentFields returns the latest value per field', () {
      final id = store.createClowder('Home');
      store.append(id, 'f:color', 'white');
      store.append(id, 'f:color', 'black');
      expect(store.currentFields(id)['f:color'], 'black');
    });
  });

  group('timeline', () {
    test('contains every change with date and author', () {
      final id = store.createClowder('Home');
      store.append(id, Keys.name, 'Renamed');
      final timeline = store.timeline(id);
      expect(timeline.length, 3); // $type + two names
      expect(timeline.every((e) => e.author == 'axel'), isTrue);
    });

    test('orders by effective date, so backdated events sort into place', () {
      final cat = store.createCat('Miezi');
      store.append(cat, 'f:neutered', 'yes', date: DateTime.utc(2026, 5, 3));
      store.append(cat, 'f:color', 'black');
      final dates = store.timeline(cat).map((e) => e.date).toList();
      final sorted = [...dates]..sort((a, b) => b.compareTo(a));
      expect(dates, sorted);
      expect(store.current(cat, 'f:neutered'), 'yes');
    });
  });

  group('cats', () {
    test('created cat lives in its clowder', () {
      final home = store.createClowder('Home');
      final cat = store.createCat('Miezi', clowderId: home);
      expect(store.cats(clowderId: home).map((c) => c.id), [cat]);
      expect(store.cats().first.name, 'Miezi');
    });

    test('cat without clowder is listed among all cats', () {
      store.createCat('Wanderer');
      expect(store.cats().map((c) => c.name), contains('Wanderer'));
      expect(store.cats(clowderId: 'clowder:none'), isEmpty);
    });
  });

  group('images', () {
    test('compressImage scales the long edge down to 2560', () {
      final compressed = CatalogStore.compressImage(makeJpeg(4000, 2000));
      final decoded = img.decodeImage(compressed)!;
      expect(decoded.width, CatalogStore.maxImageEdge);
      expect(decoded.height, CatalogStore.maxImageEdge ~/ 2);
    });

    test('small images are not upscaled', () {
      final compressed = CatalogStore.compressImage(makeJpeg(800, 600));
      final decoded = img.decodeImage(compressed)!;
      expect(decoded.width, 800);
    });

    test('added image is content-addressed and retrievable', () {
      final cat = store.createCat('Miezi');
      final bytes = CatalogStore.compressImage(makeJpeg(100, 100));
      final hash = store.addImage(cat, bytes);
      expect(store.images(cat), [hash]);
      expect(store.imageBytes(hash), bytes);
    });

    test('adding identical bytes twice yields the same hash once', () {
      final cat = store.createCat('Miezi');
      final bytes = CatalogStore.compressImage(makeJpeg(50, 50));
      final h1 = store.addImage(cat, bytes);
      final h2 = store.addImage(cat, bytes);
      expect(h1, h2);
      expect(store.images(cat), [h1]);
    });

    test('profile image defaults to the first and stays stable', () {
      final cat = store.createCat('Miezi');
      final first = store.addImage(
          cat, CatalogStore.compressImage(makeJpeg(60, 60)));
      store.addImage(cat, CatalogStore.compressImage(makeJpeg(70, 70)));
      expect(store.profileImage(cat), first);
    });

    test('profile image can be chosen explicitly', () {
      final cat = store.createCat('Miezi');
      store.addImage(cat, CatalogStore.compressImage(makeJpeg(60, 60)));
      final second = store.addImage(
          cat, CatalogStore.compressImage(makeJpeg(70, 70)));
      store.setProfileImage(cat, second);
      expect(store.profileImage(cat), second);
    });
  });

  group('move and stray', () {
    test('moving a cat changes its clowder and is kept as history', () {
      final foster = store.createClowder('Foster Home');
      final adopter = store.createClowder('Adopter Home');
      final cat = store.createCat('Miezi', clowderId: foster);

      store.moveCat(cat, adopter);
      expect(store.cats(clowderId: foster), isEmpty);
      expect(store.cats(clowderId: adopter).single.id, cat);

      final moves = store.fieldHistory(cat, Keys.clowder);
      expect(moves.map((e) => e.value), containsAll([foster, adopter]));
    });

    test('leaving with no destination makes the cat a stray', () {
      final foster = store.createClowder('Foster Home');
      final cat = store.createCat('Runner', clowderId: foster);
      expect(store.strays(), isEmpty);

      store.moveCat(cat, null);
      expect(store.strays().single.id, cat);
      expect(store.cats(clowderId: foster), isEmpty);
    });

    test('a stray moving into a clowder stops being a stray', () {
      final cat = store.createCat('Foundling');
      expect(store.strays().single.id, cat);

      final home = store.createClowder('Home');
      store.moveCat(cat, home);
      expect(store.strays(), isEmpty);
      expect(store.cats(clowderId: home).single.id, cat);
    });
  });

  group('device identity', () {
    test('device id is stable and stamped with a growing dseq', () {
      expect(store.deviceId, store.deviceId);
      final cat = store.createCat('Miezi');
      store.append(cat, 'f:color', 'black');
      final entries = store.timeline(cat);
      expect(entries.every((e) => e.device == store.deviceId), isTrue);
      final dseqs = entries.map((e) => e.dseq).toList();
      expect(dseqs.toSet().length, dseqs.length); // unique per device
    });

    test('two stores have different device ids', () {
      final other = CatalogStore.inMemory();
      expect(other.deviceId, isNot(store.deviceId));
      other.close();
    });

    test('a v1 database migrates: rows claimed by the local device', () {
      final dir = Directory.systemTemp.createTempSync('catlog_test');
      addTearDown(() => dir.deleteSync(recursive: true));
      final path = '${dir.path}/v1.db';

      // Build a pre-sync (M1) database by hand.
      final raw = sqlite3.open(path);
      raw.execute('''
        CREATE TABLE entries (
          seq      INTEGER PRIMARY KEY AUTOINCREMENT,
          entity   TEXT NOT NULL,
          field    TEXT NOT NULL,
          value    TEXT,
          date     TEXT NOT NULL,
          author   TEXT NOT NULL,
          recorded TEXT NOT NULL
        );
        CREATE TABLE local_settings (key TEXT PRIMARY KEY, value TEXT NOT NULL);
        INSERT INTO entries (entity, field, value, date, author, recorded)
        VALUES ('cat:x', '\$type', 'cat', '2026-01-01T00:00:00.000Z', 'axel', '2026-01-01T00:00:00.000Z'),
               ('cat:x', 'name', 'Miezi', '2026-01-01T00:00:00.000Z', 'axel', '2026-01-01T00:00:00.000Z');
      ''');
      raw.dispose();

      final migrated = CatalogStore.open(path);
      addTearDown(migrated.close);
      expect(migrated.cats().single.name, 'Miezi');
      final entries = migrated.timeline('cat:x');
      expect(entries.every((e) => e.device == migrated.deviceId), isTrue);
      expect(entries.map((e) => e.dseq).toSet().length, entries.length);
    });
  });

  group('clowder occupancy', () {
    test('arrivals and departures derive from cat membership history', () {
      final a = store.createClowder('A');
      final b = store.createClowder('B');
      final cat = store.createCat('Miezi', clowderId: a);
      store.moveCat(cat, b);

      final atA = store.clowderOccupancy(a);
      expect(atA.length, 2);
      expect(atA.map((e) => e.arrived), containsAll([true, false]));
      final departure = atA.firstWhere((e) => !e.arrived);
      expect(departure.counterpart, b);

      final atB = store.clowderOccupancy(b);
      expect(atB.single.arrived, isTrue);
      expect(atB.single.counterpart, a);
    });

    test('clowder delete fallout shows as departure to stray', () {
      final home = store.createClowder('Home');
      final cat = store.createCat('Miezi', clowderId: home);
      store.deleteClowder(home);

      final events = store.clowderOccupancy(home);
      final departure = events.firstWhere((e) => !e.arrived);
      expect(departure.counterpart, isNull);
      expect(departure.catId, cat);
    });
  });

  group('revert', () {
    test('reverting a rename restores the previous name as a new entry', () {
      final cat = store.createCat('Miezi');
      store.append(cat, Keys.name, 'Mizzi');
      final rename = store.fieldHistory(cat, Keys.name).first;

      final restored = store.revertEntry(rename.seq);
      expect(restored, 'Miezi');
      expect(store.current(cat, Keys.name), 'Miezi');
      // Nothing deleted: original, rename, and revert all in history.
      expect(store.fieldHistory(cat, Keys.name).length, 3);
    });

    test('reverting a move puts the cat back', () {
      final a = store.createClowder('A');
      final b = store.createClowder('B');
      final cat = store.createCat('Miezi', clowderId: a);
      store.moveCat(cat, b);
      final move = store.fieldHistory(cat, Keys.clowder).first;

      store.revertEntry(move.seq);
      expect(store.current(cat, Keys.clowder), a);
    });

    test('reverting the first entry of a field clears it', () {
      final cat = store.createCat('Miezi');
      store.append(cat, 'f:color', 'black');
      final first = store.fieldHistory(cat, 'f:color').first;

      expect(store.revertEntry(first.seq), isNull);
      expect(store.current(cat, 'f:color'), isNull);
    });

    test('structural and photo entries are not revertable', () {
      final cat = store.createCat('Miezi');
      final hash = store.addImage(
          cat, CatalogStore.compressImage(makeJpeg(30, 30)));
      store.deleteImage(cat, hash);
      final marker = store.fieldHistory(cat, Keys.image(hash)).first;
      expect(() => store.revertEntry(marker.seq), throwsArgumentError);
      expect(CatalogStore.isRevertable(Keys.type), isFalse);
      expect(CatalogStore.isRevertable(Keys.name), isTrue);
    });
  });

  group('csv export', () {
    test('stable columns, values, stray and clowder cats', () {
      final home = store.createClowder('Home, sweet');
      final a = store.createCat('Miezi', clowderId: home);
      store.append(a, 'f:gender', 'female');
      store.createCat('Roamer'); // stray

      final csv = exportCsv(store);
      final lines = csv.split('\r\n');
      expect(lines.first, startsWith('name,clowder,photos,'));
      expect(lines.first, contains('gender'));
      // Comma in the clowder name forces quoting.
      expect(csv, contains('"Home, sweet"'));
      expect(csv, contains('Roamer,stray,0'));
    });

    test('quotes, newlines, and doubled quotes survive', () {
      final cat = store.createCat('Weird "One"');
      store.append(cat, 'f:color', 'black\nwhite');
      final csv = exportCsv(store);
      expect(csv, contains('"Weird ""One"""'));
      expect(csv, contains('"black\nwhite"'));
    });

    test('deleted cats are absent', () {
      final cat = store.createCat('Ghost');
      store.deleteCat(cat);
      expect(exportCsv(store), isNot(contains('Ghost')));
    });
  });

  group('positions', () {
    test('position field is seeded and parses', () {
      expect(store.fieldDefs().map((d) => d.slug), contains('position'));
      final cat = store.createCat('Roamer');
      store.recordPosition(cat, 52.52, 13.405);
      expect(store.positionOf(cat), (52.52, 13.405));
      // Sightings accumulate as history.
      store.recordPosition(cat, 52.53, 13.41);
      expect(
          store.fieldHistory(cat, CatalogStore.positionKey).length, 2);
    });

    test('malformed positions parse to null', () {
      expect(CatalogStore.parsePosition('garbage'), isNull);
      expect(CatalogStore.parsePosition('91,0'), isNull);
      expect(CatalogStore.parsePosition(null), isNull);
    });
  });

  group('search', () {
    test('finds cats by name across clowders and strays', () {
      final home = store.createClowder('Home');
      store.createCat('Miezi', clowderId: home);
      store.createCat('Mizzi'); // stray
      store.createCat('Balu', clowderId: home);

      expect(store.searchCats('mi').map((c) => c.name),
          containsAll(['Miezi', 'Mizzi']));
      expect(store.searchCats('MI').length, 2);
      expect(store.searchCats('balu').single.name, 'Balu');
      expect(store.searchCats(''), isEmpty);
    });

    test('renamed cats are found under the current name only', () {
      final cat = store.createCat('Old');
      store.append(cat, Keys.name, 'New');
      expect(store.searchCats('old'), isEmpty);
      expect(store.searchCats('new').single.id, cat);
    });

    test('deleted cats never appear', () {
      final cat = store.createCat('Ghost');
      store.deleteCat(cat);
      expect(store.searchCats('ghost'), isEmpty);
    });
  });

  group('deletes', () {
    test('deleting a photo drops the bytes and hides it', () {
      final cat = store.createCat('Miezi');
      final hash = store.addImage(
          cat, CatalogStore.compressImage(makeJpeg(40, 40)));
      store.deleteImage(cat, hash);
      expect(store.images(cat), isEmpty);
      expect(store.imageBytes(hash), isNull);
      expect(store.fieldHistory(cat, Keys.image(hash)).first.value, 'deleted');
    });

    test('bytes survive while another cat still shows the same photo', () {
      final a = store.createCat('A');
      final b = store.createCat('B');
      final bytes = CatalogStore.compressImage(makeJpeg(42, 42));
      final hash = store.addImage(a, bytes);
      store.addImage(b, bytes);

      store.deleteImage(a, hash);
      expect(store.imageBytes(hash), isNotNull);

      store.deleteImage(b, hash);
      expect(store.imageBytes(hash), isNull);
    });

    test('deleting a cat hides it everywhere and drops its photos', () {
      final home = store.createClowder('Home');
      final cat = store.createCat('Mistake', clowderId: home);
      final hash = store.addImage(
          cat, CatalogStore.compressImage(makeJpeg(30, 30)));

      store.deleteCat(cat);
      expect(store.cats(), isEmpty);
      expect(store.strays(), isEmpty);
      expect(store.imageBytes(hash), isNull);
    });

    test('deleting a clowder turns its cats into strays', () {
      final home = store.createClowder('Owner Home');
      final cat = store.createCat('Survivor', clowderId: home);

      store.deleteClowder(home);
      expect(store.clowders(), isEmpty);
      expect(store.strays().single.id, cat);
      // The fallout is an ordinary Move in the cat's history.
      expect(store.fieldHistory(cat, Keys.clowder).first.value, isNull);
    });
  });

  group('user-defined fields', () {
    test('a new field is defined and immediately usable', () {
      store.defineField('Flea treatment', FieldType.date,
          scope: FieldScope.cat);
      final def = store
          .fieldDefs(scope: FieldScope.cat)
          .firstWhere((d) => d.slug == 'flea-treatment');
      expect(def.type, FieldType.date);

      final cat = store.createCat('Miezi');
      store.append(cat, def.key, '2026-08-01');
      expect(store.current(cat, def.key), '2026-08-01');
    });

    test('choice fields carry their options', () {
      store.defineField('Mood', FieldType.choice,
          options: ['calm', 'wild']);
      final def =
          store.fieldDefs().firstWhere((d) => d.slug == 'mood');
      expect(def.options, ['calm', 'wild']);
    });

    test('definitions are dated, authored entries', () {
      final id = store.defineField('Chip number', FieldType.text);
      expect(store.timeline(id).every((e) => e.author == 'axel'), isTrue);
    });

    test('duplicate names are rejected', () {
      store.defineField('Weight', FieldType.number);
      expect(() => store.defineField('Weight', FieldType.number),
          throwsArgumentError);
    });

    test('renaming a field keeps its key, values, and history', () {
      final id = store.defineField('Waight', FieldType.number);
      final cat = store.createCat('Miezi');
      store.append(cat, 'f:waight', '4.2');

      store.renameField(id, 'Weight');
      final def = store.fieldDefs().firstWhere((d) => d.id == id);
      expect(def.name, 'Weight');
      expect(def.slug, 'waight'); // slug is internal, stays
      expect(store.current(cat, def.key), '4.2');
      expect(store.fieldHistory(id, Keys.name).map((e) => e.value),
          containsAll(['Waight', 'Weight']));
    });

    test('renameField refuses non-definitions', () {
      final cat = store.createCat('Miezi');
      expect(() => store.renameField(cat, 'X'), throwsArgumentError);
    });
  });

  group('starter fields', () {
    test('seeded once with types and scopes', () {
      final defs = store.fieldDefs();
      expect(defs.map((d) => d.slug),
          containsAll(['gender', 'color', 'neutered', 'pregnant']));
      final gender = defs.firstWhere((d) => d.slug == 'gender');
      expect(gender.type, FieldType.choice);
      expect(gender.options, contains('female'));
    });

    test('clowder scope filter includes both-scoped fields only once', () {
      final defs = store.fieldDefs(scope: FieldScope.clowder);
      expect(defs.map((d) => d.slug), contains('address'));
      expect(defs.map((d) => d.slug), isNot(contains('gender')));
    });
  });
}
