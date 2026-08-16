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


  test('declined join reaches the joiner as declined, nothing applied',
      () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'stranger';
    addTearDown(a.close);
    addTearDown(b.close);
    b.createCat('Poison');

    final host = LanSyncHost(a, '123456',
        onJoinRequest: (author, device) async {
      expect(author, 'stranger');
      return const JoinDecision(false, false);
    });
    await host.start();
    addTearDown(host.stop);

    await expectLater(
      lanSync(b, '127.0.0.1', host.port, '123456'),
      throwsA(isA<SyncException>()
          .having((e) => e.message, 'message', 'declined')),
    );
    expect(a.cats(), isEmpty);
  });

  test('include-private decision from the trust gate is honored',
      () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'tablet';
    addTearDown(a.close);
    addTearDown(b.close);
    final secret = a.createCat('Secret');
    a.setPrivate(secret, true);

    final host = LanSyncHost(a, '123456',
        onJoinRequest: (_, _) async => const JoinDecision(true, true));
    await host.start();
    addTearDown(host.stop);

    await lanSync(b, '127.0.0.1', host.port, '123456');
    expect(b.cats().map((c) => c.id), contains(secret));
    expect(b.isPrivate(secret), isTrue);
  });
}
