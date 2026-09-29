import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/sync/lan.dart';
import 'package:flutter_test/flutter_test.dart';

/// The phone joins the desk (#138): the desktop core's `lan_host`
/// example hosts on the loopback, and this app's own `lanSync` — the
/// code every phone runs — syncs with it through the certificate the
/// pair code names. Built first with
/// `cargo build -p catlog-core --example lan_host` in `desktop/`;
/// without the binary the test is skipped, unless `CATLOG_LAN_HOST`
/// names it, as CI does.
void main() {
  setUpAll(useSystemSqlite);
  final env = Platform.environment['CATLOG_LAN_HOST'];
  final binary = env ?? 'desktop/target/debug/examples/lan_host';
  final present = File(binary).existsSync();

  test('the desk host is there when CI asks for it', () {
    if (env != null) {
      expect(present, isTrue, reason: 'no host at $binary');
    }
  });

  test('a phone joins the desk over TLS, entries and photos both ways',
      () async {
    final dir = Directory.systemTemp.createTempSync('catlog-desk');
    addTearDown(() => dir.deleteSync(recursive: true));
    final desk = await Process.start(binary, ['${dir.path}/desk']);
    addTearDown(() {
      desk.stdin.close();
      desk.kill();
    });
    final lines = desk.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .asBroadcastStream();
    desk.stderr.transform(utf8.decoder).listen(stderr.write);
    final first = (await lines.first).split(' ');
    final port = int.parse(first[0]);
    final fingerprint = _hex(first[1]);
    expect(fingerprint.length, 32);

    final phone = CatalogStore.inMemory()..author = 'Ada';
    addTearDown(phone.close);
    final tom = phone.createCat('Tom');
    final tomPhoto = phone.addImage(
        tom, Uint8List.fromList([0xff, 0xd8, 0xff, ...utf8.encode('tom')]));

    // The full fingerprint, as a scanned code carries it.
    final result = await lanSync(phone, '127.0.0.1', port, '246810',
        fingerprint: fingerprint);
    expect(result.entriesReceived, greaterThan(0));
    expect(result.entriesSent, greaterThan(0));
    expect(result.blobsReceived, 1, reason: "Mia's photo came down");
    expect(result.blobsSent, 1, reason: "Tom's photo went up");
    expect(phone.cats().map((c) => c.name), containsAll(['Tom', 'Mia']));
    final mia = phone.cats().firstWhere((c) => c.name == 'Mia');
    final miaPhoto = phone.images(mia.id).single;
    expect(utf8.decode(phone.imageBytes(miaPhoto)!.sublist(3)),
        " mia's photo");
    expect(result.report.newKeys.single.trust, KeyTrust.verified);

    // The desk allowed this phone for good; the second visit carries its
    // secret and passes without a question, with nothing new to move.
    final again = await lanSync(phone, '127.0.0.1', port, '246810',
        fingerprint: fingerprint);
    expect(again.entriesReceived, 0);
    expect(again.entriesSent, 0);
    expect((again.blobsReceived, again.blobsSent), (0, 0));

    // The typed code names only the first bytes; a wrong one is refused
    // in the handshake, before anything is sent.
    final wrong = Uint8List.fromList(List.filled(8, 0x00));
    await expectLater(
        lanSync(phone, '127.0.0.1', port, '246810', fingerprint: wrong),
        throwsA(isA<SyncException>()
            .having((e) => e.message, 'message', 'wrong-host')));
    final typed = fingerprint.sublist(0, typedFingerprintBytes);
    final third = await lanSync(phone, '127.0.0.1', port, '246810',
        fingerprint: typed);
    expect(third.entriesReceived, 0);
    expect(phone.imageBytes(tomPhoto), isNotNull);
  }, skip: present ? false : 'build desktop/…/examples/lan_host first');
}

Uint8List _hex(String s) => Uint8List.fromList([
      for (var i = 0; i < s.length; i += 2)
        int.parse(s.substring(i, i + 2), radix: 16)
    ]);
