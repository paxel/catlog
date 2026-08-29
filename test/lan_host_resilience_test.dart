import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/sync/lan.dart';
import 'package:flutter_test/flutter_test.dart';

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
    await host.start();
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
}
