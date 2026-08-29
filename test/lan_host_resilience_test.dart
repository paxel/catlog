import 'dart:convert';
import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/sync/lan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

/// A joiner that drops the connection mid-request must not take the
/// host down: the next joiner still syncs.
void main() {
  setUpAll(useSystemSqlite);

  test('a half-sent request and a vanished client leave the host serving',
      () async {
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    addTearDown(a.close);
    addTearDown(b.close);
    a.createCat('Miezi');
    final host = LanSyncHost(a, '123456');
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);

    final socket = await Socket.connect('127.0.0.1', host.port);
    socket.write('POST /sync HTTP/1.1\r\nHost: x\r\n'
        'X-Catlog-Pin: 123456\r\nContent-Length: 999999\r\n\r\n{"form');
    await socket.flush();
    socket.destroy();
    // Another vanishing client, this time after the headers of a GET.
    final second = await Socket.connect('127.0.0.1', host.port);
    second.write('GET /vector HTTP/1.1\r\nHost: x\r\n\r\n');
    await second.flush();
    second.destroy();
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final result = await lanSync(b, '127.0.0.1', host.port, '123456');
    expect(result.entriesReceived, greaterThan(0));
    expect(b.cats().map((c) => c.name), contains('Miezi'));
  });

  test('a photo nobody holds is skipped, the entries still land',
      () async {
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    addTearDown(a.close);
    addTearDown(b.close);
    final cat = a.createCat('Miezi');
    // A photo entry whose bytes are gone — permanent in the log.
    a.append(cat, '\$image:${'b' * 64}', 'added');
    final host = LanSyncHost(a, '123456');
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);
    final result = await lanSync(b, '127.0.0.1', host.port, '123456');
    expect(result.entriesReceived, greaterThan(0));
    expect(result.blobsReceived, 0);
    expect(b.cats().map((c) => c.name), contains('Miezi'));
  });

  test('a blob above the cap is refused with 413', () async {
    final a = CatalogStore.inMemory()..author = 'a';
    addTearDown(a.close);
    final host = LanSyncHost(a, '123456');
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    final req = await client.openUrl(
        'POST', Uri.parse('http://127.0.0.1:${host.port}/blob/${'c' * 64}'));
    req.headers.set('x-catlog-pin', '123456');
    req.contentLength = maxBlobBytes + 1;
    req.add(List<int>.filled(maxBlobBytes + 1, 0));
    // The host answers 413 and closes; the client may see the answer
    // or a closed connection — either way nothing was stored.
    try {
      final res = await req.close();
      expect(res.statusCode, HttpStatus.requestEntityTooLarge);
      await res.drain<void>();
    } on HttpException {
      // connection closed before the full body went out
    }
    expect(a.imageBytes('c' * 64), isNull);
  });

  test('five wrong PINs lock an address out, even with the right PIN',
      () async {
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    addTearDown(a.close);
    addTearDown(b.close);
    final host = LanSyncHost(a, '123456');
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);
    for (var i = 0; i < pinFailuresPerAddress; i++) {
      await expectLater(lanSync(b, '127.0.0.1', host.port, '000000'),
          throwsA(isA<SyncException>()));
    }
    await expectLater(lanSync(b, '127.0.0.1', host.port, '123456'),
        throwsA(isA<SyncException>()));
  });

  test('"always allow" hands the joiner a secret; a bare device id is asked',
      () async {
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    addTearDown(a.close);
    addTearDown(b.close);
    var asked = 0;
    final host = LanSyncHost(a, '123456', onJoinRequest: (_, _) async {
      asked++;
      return const JoinDecision(true, false, remember: true);
    });
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);
    await lanSync(b, '127.0.0.1', host.port, '123456');
    expect(asked, 1);
    expect(b.localSetting(trustSecretKey(a.deviceId)), isNotNull);
    // Second time: no question.
    await lanSync(b, '127.0.0.1', host.port, '123456');
    expect(asked, 1);
    // Another device claiming b's id without the secret is asked.
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    final req = await client.openUrl(
        'POST', Uri.parse('http://127.0.0.1:${host.port}/sync'));
    req.headers.set('x-catlog-pin', '123456');
    req.headers.contentType = ContentType.json;
    req.write(jsonEncode({
      'format': 2,
      'author': 'c',
      'deviceName': 'impostor',
      'deviceId': b.deviceId,
      'vector': <String, int>{},
      'entries': <Object>[],
    }));
    final res = await req.close();
    await res.drain<void>();
    expect(asked, 2);
  });

  test('a blob the log never mentions is not stored', () async {
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    addTearDown(a.close);
    addTearDown(b.close);
    final hash = b.addImage(
        b.createCat('X'),
        CatalogStore.compressImage(Uint8List.fromList(
            img.encodeJpg(img.Image(width: 8, height: 8)))));
    final host = LanSyncHost(a, '123456');
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    final req = await client.openUrl(
        'POST', Uri.parse('http://127.0.0.1:${host.port}/blob/$hash'));
    req.headers.set('x-catlog-pin', '123456');
    req.add(b.imageBytes(hash)!);
    final res = await req.close();
    await res.drain<void>();
    expect(res.statusCode, HttpStatus.notFound);
    expect(a.imageBytes(hash), isNull);
  });

  test('two joiners are served one after the other', () async {
    final a = CatalogStore.inMemory()..author = 'a';
    final b = CatalogStore.inMemory()..author = 'b';
    final c = CatalogStore.inMemory()..author = 'c';
    addTearDown(a.close);
    addTearDown(b.close);
    addTearDown(c.close);
    b.createCat('B');
    c.createCat('C');
    var inFlight = 0, peak = 0;
    final host = LanSyncHost(a, '123456', onJoinRequest: (_, _) async {
      inFlight++;
      peak = inFlight > peak ? inFlight : peak;
      await Future<void>.delayed(const Duration(milliseconds: 100));
      inFlight--;
      return const JoinDecision(true, false);
    });
    await host.start(bind: InternetAddress.loopbackIPv4);
    addTearDown(host.stop);
    await Future.wait([
      lanSync(b, '127.0.0.1', host.port, '123456'),
      lanSync(c, '127.0.0.1', host.port, '123456'),
    ]);
    expect(peak, 1);
    expect(a.cats().map((x) => x.name), containsAll(['B', 'C']));
  });
}
