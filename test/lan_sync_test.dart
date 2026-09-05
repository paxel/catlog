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

    final host = await testHost(a, '123456');

    final result = await syncWith(b, host);
    expect(result.entriesReceived, greaterThan(0));
    expect(result.entriesSent, greaterThan(0));

    expect(a.cats().length, 2);
    expect(b.cats().length, 2);
    expect(b.clowders().single.name, 'Home');

    // Second sync is a no-op.
    final again = await syncWith(b, host);
    expect(again.entriesReceived, 0);
    expect(again.entriesSent, 0);
  });

  test('wrong PIN is refused', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(a.close);
    addTearDown(b.close);

    final host = await testHost(a, '123456');

    expect(() => syncWith(b, host, pin: '000000'),
        throwsA(isA<SyncException>()));
  });


  test('declined join reaches the joiner as declined, nothing applied',
      () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'stranger';
    addTearDown(a.close);
    addTearDown(b.close);
    b.createCat('Poison');

    final host = await testHost(a, '123456',
        onJoinRequest: (author, device) async {
      expect(author, 'stranger');
      return const JoinDecision(false, false);
    });

    await expectLater(
      syncWith(b, host),
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

    final host = await testHost(a, '123456',
        onJoinRequest: (_, _) async => const JoinDecision(true, true));

    await syncWith(b, host);
    expect(b.cats().map((c) => c.id), contains(secret));
    expect(b.isPrivate(secret), isTrue);
  });
  /// A 0.3.x joiner: no `format` in the /sync body.
  Future<(int, String)> postLegacySync(int port, String pin,
      Map<String, Object?> vector) async {
    final client = insecureClient();
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

    final host = await testHost(a, '123456');

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

    final host = await testHost(a, '123456');

    final (status, body) = await postLegacySync(host.port, '123456', {});
    expect(status, 403);
    expect(body, 'declined');
  });

  test('a refusal to a format-aware joiner names its reason', () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    addTearDown(a.close);
    a.createCat('Miezi');

    final host = await testHost(a, '123456');

    // A joiner from the future (format 99) — the host cannot serve it
    // and says so in a machine-readable refusal.
    final client = insecureClient();
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
    expect(refusal['format'], syncFormat);
    expect(syncFormat, 3);
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

    final host = await testHost(a, '123456');

    await syncWith(b, host);
    expect(b.activeReminders(), hasLength(1));
    expect(b.current(cat, 'f:vaccine'), isNull);
  });

  test('a certificate the pair code did not name is refused by name',
      () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(a.close);
    addTearDown(b.close);
    a.createCat('Miezi');
    final host = await testHost(a, '123456');
    final wrong = List<int>.filled(fullFingerprintBytes, 0x42);
    await expectLater(
        lanSync(b, '127.0.0.1', host.port, '123456', fingerprint: wrong),
        throwsA(isA<SyncException>()
            .having((e) => e.message, 'message', 'wrong-host')));
    expect(b.cats(), isEmpty);
  });

  test('a host without TLS is named as a version before 1.1.0', () async {
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(b.close);
    // Plain HTTP where the joiner expects TLS — a 1.0.x host.
    final plain = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => plain.close(force: true));
    plain.listen((req) => req.response.close());
    await expectLater(
        lanSync(b, '127.0.0.1', plain.port, '123456',
            fingerprint: List<int>.filled(fullFingerprintBytes, 1)),
        throwsA(isA<SyncException>()
            .having((e) => e.message, 'message', 'peer-no-tls')));
  });

  test('the typed code carries enough of the fingerprint to pin the host',
      () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    final b = CatalogStore.inMemory()..author = 'friend';
    addTearDown(a.close);
    addTearDown(b.close);
    a.createCat('Miezi');
    final host = await testHost(a, '123456');
    final typed = decodePairCode(encodePairCode(
        '127.0.0.1', host.port, '123456',
        fingerprint: host.fingerprint, typed: true))!;
    expect(typed.fingerprint, hasLength(typedFingerprintBytes));
    final result = await lanSync(b, '127.0.0.1', host.port, '123456',
        fingerprint: typed.fingerprint!);
    expect(result.entriesReceived, greaterThan(0));
    // Fewer bytes than a typed code carries pin nothing.
    await expectLater(
        lanSync(b, '127.0.0.1', host.port, '123456',
            fingerprint: host.fingerprint.take(4).toList()),
        throwsA(isA<SyncException>()));
  });

  test('a joiner from before TLS is refused as older once reminders exist',
      () async {
    final a = CatalogStore.inMemory()..author = 'axel';
    addTearDown(a.close);
    final cat = a.createCat('Miezi');
    a.append(cat, 'f:vaccine', 'refresh',
        date: DateTime.now().add(const Duration(days: 30)), reminder: true);
    final host = await testHost(a, '123456');
    final client = insecureClient();
    final req = await client
        .postUrl(Uri.parse('https://127.0.0.1:${host.port}/sync'));
    req.headers.set('x-catlog-pin', '123456');
    req.headers.contentType = ContentType.json;
    req.write(jsonEncode({
      'format': 2,
      'vector': const <String, int>{},
      'entries': const [],
      'author': 'old',
      'deviceName': 'old-phone',
      'deviceId': 'dev-old',
    }));
    final res = await req.close();
    final body = await utf8.decoder.bind(res).join();
    expect(res.statusCode, 403);
    expect((jsonDecode(body) as Map)['refusal'], 'joiner-older');
  });
}
