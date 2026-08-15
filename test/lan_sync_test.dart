import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/sync/lan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(useSystemSqlite);

  test('full two-way sync over localhost HTTP', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(a.close);
    addTearDown(b.close);

    final home = a.createClowder('Home');
    a.createCat('Miezi', clowderId: home);
    b.createCat('Wanderer');

    final host = LanSyncHost(a, '123456');
    await host.start();
    addTearDown(host.stop);

    final result = await lanSync(b, '127.0.0.1', host.port, '123456');
    expect(result.entriesReceived, greaterThan(0));
    expect(result.entriesSent, greaterThan(0));

    expect(a.cats().length, 2);
    expect(b.cats().length, 2);
    expect(b.clowders().single.name, 'Home');

    // Second sync is a no-op.
    final again = await lanSync(b, '127.0.0.1', host.port, '123456');
    expect(again.entriesReceived, 0);
    expect(again.entriesSent, 0);
  });

  test('wrong PIN is refused', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(a.close);
    addTearDown(b.close);

    final host = LanSyncHost(a, '123456');
    await host.start();
    addTearDown(host.stop);

    expect(() => lanSync(b, '127.0.0.1', host.port, '000000'),
        throwsA(isA<SyncException>()));
  });
}
