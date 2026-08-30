import 'dart:convert';
import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/sync/lan.dart';
import 'package:flutter_test/flutter_test.dart';

import 'tls_fixture.dart';

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

    final host = LanSyncHost(a, '123456',
        identity: testIdentity());
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    final result = await lanSync(b, '127.0.0.1', host.port, '123456',
          fingerprint: host.fingerprint);
    expect(result.entriesReceived, greaterThan(0));
    expect(result.entriesSent, greaterThan(0));

    expect(a.cats().length, 2);
    expect(b.cats().length, 2);
    expect(b.clowders().single.name, 'Home');

    // Second sync is a no-op.
    final again = await lanSync(b, '127.0.0.1', host.port, '123456',
          fingerprint: host.fingerprint);
    expect(again.entriesReceived, 0);
    expect(again.entriesSent, 0);
  });

  test('wrong PIN is refused', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(a.close);
    addTearDown(b.close);

    final host = LanSyncHost(a, '123456',
        identity: testIdentity());
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    expect(() => lanSync(b, '127.0.0.1', host.port, '000000',
          fingerprint: host.fingerprint),
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
        identity: testIdentity(),
        onJoinRequest: (author, device) async {
      expect(author, 'stranger');
      return const JoinDecision(false, false);
    });
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    await expectLater(
      lanSync(b, '127.0.0.1', host.port, '123456',
          fingerprint: host.fingerprint),
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
        identity: testIdentity(),
        onJoinRequest: (_, _) async => const JoinDecision(true, true));
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    await lanSync(b, '127.0.0.1', host.port, '123456',
          fingerprint: host.fingerprint);
    expect(b.cats().map((c) => c.id), contains(secret));
    expect(b.isPrivate(secret), isTrue);
  });
  /// A 0.3.x joiner: no `format` in the /sync body.
  Future<(int, String)> postLegacySync(int port, String pin,
      Map<String, Object?> vector) async {
    final client = HttpClient()
      ..badCertificateCallback = (_, _, _) => true;
    try {
      final req = await client
          .postUrl(Uri.parse('https://127.0.0.1:$port/sync'));
      req.headers.set('x-catlog-pin', pin);
      req.headers.contentType = ContentType.json;
      req.write(jsonEncode({
        'vector': vector,
        'entries': const [],
        'author': 'old',
        'deviceName': 'old-phone',
        'deviceId': 'dev-old',
      }));
      final res = await req.close();
      final body = await utf8.decoder.bind(res).join();
      return (res.statusCode, body);
    } finally {
      client.close(force: true);
    }
  }

  test('a flag-free host still syncs with a pre-1.0.0 joiner', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    addTearDown(a.close);
    a.createCat('Miezi');

    final host = LanSyncHost(a, '123456',
        identity: testIdentity());
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    final (status, body) = await postLegacySync(host.port, '123456', {});
    expect(status, 200);
    expect(body, contains('Miezi'));
    expect(body, isNot(contains('"reminder"')));
  });

  test('a host with reminders refuses a pre-1.0.0 joiner as declined',
      () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    addTearDown(a.close);
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh',
        date: DateTime.now().add(const Duration(days: 30)),
        reminder: true);

    final host = LanSyncHost(a, '123456',
        identity: testIdentity());
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    final (status, body) = await postLegacySync(host.port, '123456', {});
    expect(status, 403);
    expect(body, 'declined');
  });

  test('a refusal to a format-aware joiner names its reason', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    addTearDown(a.close);
    a.createCat('Miezi');

    final host = LanSyncHost(a, '123456',
        identity: testIdentity());
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    // A joiner from the future (format 99) — the host cannot serve it
    // and says so in a machine-readable refusal.
    final client = HttpClient()
      ..badCertificateCallback = (_, _, _) => true;
    addTearDown(() => client.close(force: true));
    final req = await client
        .postUrl(Uri.parse('https://127.0.0.1:${host.port}/sync'));
    req.headers.set('x-catlog-pin', '123456');
    req.headers.contentType = ContentType.json;
    req.write(jsonEncode({
      'format': 99,
      'vector': const <String, int>{},
      'entries': const [],
      'author': 'future',
      'deviceName': 'future-phone',
      'deviceId': 'dev-future',
    }));
    final res = await req.close();
    final body = await utf8.decoder.bind(res).join();
    expect(res.statusCode, 403);
    final refusal = (jsonDecode(body) as Map);
    expect(refusal['refusal'], 'joiner-newer');
    expect(refusal['format'], 2);
  });

  test('two 1.0.0 devices sync reminders as plans', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(a.close);
    addTearDown(b.close);
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh',
        date: DateTime.now().add(const Duration(days: 30)),
        reminder: true);

    final host = LanSyncHost(a, '123456',
        identity: testIdentity());
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    await lanSync(b, '127.0.0.1', host.port, '123456',
          fingerprint: host.fingerprint);
    expect(b.activeReminders(), hasLength(1));
    expect(b.current(cat, 'f:vaccine'), isNull);
  });
}

