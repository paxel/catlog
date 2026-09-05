import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/sync/lan.dart';
import 'package:catlog/src/sync/tls.dart';
import 'package:flutter_test/flutter_test.dart';

/// One small identity for every LAN test — RSA 1024 keeps generation
/// under a second; the app itself uses 2048.
TlsIdentity? _identity;
TlsIdentity testIdentity() => _identity ??= generateIdentity(keySize: 1024);

/// A host on loopback with the test identity, serving until the test
/// ends.
Future<LanSyncHost> testHost(
  CatalogStore store,
  String pin, {
  Future<JoinDecision> Function(String author, String device)? onJoinRequest,
  void Function(List<Entry> applied, Moment? moment)? onSession,
}) async {
  final host = LanSyncHost(store, pin,
      identity: testIdentity(),
      onJoinRequest: onJoinRequest,
      onSession: onSession);
  await host.start(bind: InternetAddress.loopbackIPv4);
  addTearDown(host.stop);
  return host;
}

/// A joiner's sync with [host] over loopback, pinned to its certificate.
Future<SyncResult> syncWith(CatalogStore store, LanSyncHost host,
        {String pin = '123456', bool includePrivate = false}) =>
    lanSync(store, '127.0.0.1', host.port, pin,
        fingerprint: host.fingerprint, includePrivate: includePrivate);

/// A raw client that accepts the test certificate — for requests built
/// by hand, closed when the test ends.
HttpClient insecureClient() {
  final client = HttpClient()..badCertificateCallback = (_, _, _) => true;
  addTearDown(() => client.close(force: true));
  return client;
}
