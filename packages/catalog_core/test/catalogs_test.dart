import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Several catalogs on one device, each self-contained, with the app's
/// own settings shared so a second catalog is not a fresh install.
void main() {
  setUpAll(useSystemSqlite);

  late Directory root;

  setUp(() => root = Directory.systemTemp.createTempSync('catlog-root'));

  tearDown(() {
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  CatalogManager open({String defaultName = 'Clowders'}) =>
      CatalogManager.open(root.path, defaultName: defaultName);

  test('a fresh root holds exactly one catalog, named as asked', () {
    final m = open();
    addTearDown(m.close);
    expect(m.catalogs(), hasLength(1));
    expect(m.catalogs().single.name, 'Clowders');
    expect(m.active.name, 'Clowders');
  });

  test('a catalog carries its own name, so a copied folder is complete',
      () {
    final m = open();
    addTearDown(m.close);
    final store = m.openStore(m.active);
    expect(store.localSetting(catalogNameKey), 'Clowders');
    store.close();
  });

  test('two catalogs are independent and have different device ids', () {
    final m = open();
    addTearDown(m.close);
    final berlin = m.active;
    final paris = m.create('Paris');

    final a = m.openStore(berlin)..author = 'me';
    final b = m.openStore(paris);
    a.createClowder('Hinterhof');
    expect(a.clowders(), hasLength(1));
    expect(b.clowders(), isEmpty);
    expect(a.deviceId, isNot(b.deviceId));
    a.close();
    b.close();
  });

  test('the app settings are shared, the catalog settings are not', () {
    final m = open();
    addTearDown(m.close);
    final a = m.openStore(m.active)..author = 'me';
    a.setLocalSetting('locale', 'de');
    a.setLocalSetting('spot2:home', 'home-strays');
    a.setLocalSetting('mapViewport', '52.5,13.4,12');
    a.close();

    final b = m.openStore(m.create('Paris'));
    expect(b.author, 'me', reason: 'you are one person');
    expect(b.localSetting('locale'), 'de');
    expect(b.localSetting('spot2:home'), 'home-strays',
        reason: 'tips already seen must not run again');
    expect(b.localSetting('mapViewport'), isNull,
        reason: 'Berlin is not Paris');
    b.close();
  });

  test('names are unique', () {
    final m = open();
    addTearDown(m.close);
    m.create('Paris');
    expect(() => m.create('paris'), throwsA(isA<DuplicateCatalogName>()));
    expect(() => m.create('  '), throwsArgumentError);
  });

  test('renaming updates the registry and the catalog itself', () {
    final m = open();
    addTearDown(m.close);
    final paris = m.create('Paris');
    m.rename(paris.id, 'Paris 11e');
    expect(m.byId(paris.id)!.name, 'Paris 11e');
    final store = m.openStore(m.byId(paris.id)!);
    expect(store.localSetting(catalogNameKey), 'Paris 11e');
    store.close();
  });

  test('deleting removes the folder; the last one cannot go', () {
    final m = open();
    addTearDown(m.close);
    final paris = m.create('Paris');
    m.delete(paris.id);
    expect(m.catalogs(), hasLength(1));
    expect(Directory('${root.path}/catalogs/${paris.id}').existsSync(),
        isFalse);
    expect(() => m.delete(m.active.id), throwsStateError);
  });

  test('a catalog knows what it costs in space', () {
    final m = open();
    addTearDown(m.close);
    final store = m.openStore(m.active)..author = 'me';
    store.createClowder('Hinterhof');
    store.close();
    expect(m.active.sizeInBytes, greaterThan(0));
  });

  group('migration from a single catalog', () {
    void seedOldLayout() {
      final store = CatalogStore.open('${root.path}/catlog.db')
        ..author = 'Patrick';
      final clowder = store.createClowder('Hinterhof');
      store.createCat('Miezi');
      store.setLocalSetting('locale', 'de');
      store.setLocalSetting('spot2:home', 'home-strays');
      store.setLocalSetting('mapViewport', '52.5,13.4,12');
      expect(clowder, isNotEmpty);
      store.close();
      Directory('${root.path}/images').createSync();
      File('${root.path}/images/deadbeef').writeAsStringSync('photo');
    }

    test('everything moves in, under the name we were given', () {
      seedOldLayout();
      final m = open();
      addTearDown(m.close);
      expect(m.catalogs(), hasLength(1));
      expect(m.active.name, 'Clowders');

      final store = m.openStore(m.active);
      expect(store.author, 'Patrick');
      expect(store.clowders().map((c) => c.name), ['Hinterhof']);
      expect(store.cats().map((c) => c.name), ['Miezi']);
      expect(store.localSetting('mapViewport'), '52.5,13.4,12');
      store.close();

      expect(File('${root.path}/images/deadbeef').existsSync(), isFalse);
      expect(File('${m.active.dir.path}/images/deadbeef').existsSync(),
          isTrue);
      expect(File('${root.path}/catlog.db').existsSync(), isFalse);
    });

    test('the settings that are now shared come along', () {
      seedOldLayout();
      final m = open();
      addTearDown(m.close);
      expect(m.get('author'), 'Patrick');
      expect(m.get('locale'), 'de');
      expect(m.get('spot2:home'), 'home-strays');
      expect(m.get('mapViewport'), isNull);
    });

    test('a second catalog created after the move starts set up', () {
      seedOldLayout();
      final m = open();
      addTearDown(m.close);
      final paris = m.openStore(m.create('Paris'));
      expect(paris.author, 'Patrick');
      expect(paris.localSetting('locale'), 'de');
      paris.close();
    });

    test('running twice moves nothing twice', () {
      seedOldLayout();
      final first = open();
      final id = first.active.id;
      first.close();
      final second = open();
      addTearDown(second.close);
      expect(second.catalogs(), hasLength(1));
      expect(second.active.id, id);
    });

    test('a move that cannot finish leaves the old catalog openable', () {
      seedOldLayout();
      // The destination exists as a file, so creating the folder fails.
      Directory('${root.path}/catalogs').createSync();
      File('${root.path}/catalogs/blocked').writeAsStringSync('x');
      // Nothing can be written under a file: force the failure by making
      // the catalogs directory read-only for the duration.
      Process.runSync('chmod', ['500', '${root.path}/catalogs']);
      addTearDown(() =>
          Process.runSync('chmod', ['700', '${root.path}/catalogs']));

      expect(open, throwsA(isA<MigrationFailed>()));
      Process.runSync('chmod', ['700', '${root.path}/catalogs']);
      final old = CatalogStore.open('${root.path}/catlog.db');
      expect(old.clowders().map((c) => c.name), ['Hinterhof']);
      old.close();
    });
  });
}
