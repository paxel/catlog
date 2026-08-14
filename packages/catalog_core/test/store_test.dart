import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

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
