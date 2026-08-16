import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show BytesBuilder;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/foundation.dart';

/// Outcome of one sync session, for the summary line.
class SyncResult {
  final int entriesSent;
  final int entriesReceived;
  final int blobsSent;
  final int blobsReceived;

  /// The entries actually new to this store — the import summary's input.
  final List<Entry> applied;

  const SyncResult(this.entriesSent, this.entriesReceived, this.blobsSent,
      this.blobsReceived,
      {this.applied = const []});

  @override
  String toString() =>
      '$entriesReceived entries + $blobsReceived photos in, '
      '$entriesSent entries + $blobsSent photos out';
}

const _pinHeader = 'x-catlog-pin';

/// Hosts a sync session on the LAN: a small HTTP server the joiner
/// drives. The PIN gates every request — it prevents accidents in a
/// trusted group, not attackers (ADR-0002 threat model).
class LanSyncHost {
  final CatalogStore store;
  final String pin;

  /// Whether this host's outbound entries include Private data — the
  /// host's own choice; the joiner's outbound is governed by its own flag.
  final bool includePrivate;

  /// Called after a joiner completed a session; receives what actually
  /// landed, so the host can show the import summary too.
  final void Function(List<Entry> applied)? onSession;

  HttpServer? _server;

  LanSyncHost(this.store, this.pin,
      {this.includePrivate = false, this.onSession});

  int get port => _server!.port;

  /// Starts serving and returns the LAN address to show the joiner.
  Future<String> start() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, 0);
    _server!.listen(_handle, onError: (_) {});
    for (final iface in await NetworkInterface.list(
        type: InternetAddressType.IPv4, includeLoopback: false)) {
      if (iface.addresses.isNotEmpty) return iface.addresses.first.address;
    }
    return 'localhost';
  }

  Future<void> stop() async => _server?.close(force: true);

  Future<void> _handle(HttpRequest req) async {
    try {
      if (req.headers.value(_pinHeader) != pin) {
        req.response.statusCode = HttpStatus.forbidden;
        await req.response.close();
        return;
      }
      final path = req.uri.path;
      if (req.method == 'GET' && path == '/vector') {
        req.response.headers.contentType = ContentType.json;
        req.response.write(jsonEncode(store.versionVector()));
      } else if (req.method == 'POST' && path == '/sync') {
        final body =
            jsonDecode(await utf8.decoder.bind(req).join()) as Map;
        final joinerVector = (body['vector'] as Map)
            .map((k, v) => MapEntry(k as String, v as int));
        final incoming = [
          for (final e in body['entries'] as List)
            Entry.fromJson((e as Map).cast<String, dynamic>())
        ];
        final applied =
            store.applyEntries(incoming, senderVector: joinerVector);
        req.response.headers.contentType = ContentType.json;
        req.response.write(jsonEncode({
          'entries': [
            for (final e in store.entriesSince(joinerVector,
                includePrivate: includePrivate))
              e.toJson()
          ],
          'wantBlobs': store.missingBlobs(),
        }));
        onSession?.call(applied);
      } else if (req.method == 'GET' && path.startsWith('/blob/')) {
        final bytes = store.imageBytes(path.substring('/blob/'.length));
        if (bytes == null) {
          req.response.statusCode = HttpStatus.notFound;
        } else {
          req.response.headers.contentType = ContentType.binary;
          req.response.add(bytes);
        }
      } else if (req.method == 'POST' && path.startsWith('/blob/')) {
        final builder = BytesBuilder();
        await for (final chunk in req) {
          builder.add(chunk);
        }
        store.putBlob(
            path.substring('/blob/'.length), builder.takeBytes());
        onSession?.call(const []);
      } else {
        req.response.statusCode = HttpStatus.notFound;
      }
    } catch (_) {
      req.response.statusCode = HttpStatus.internalServerError;
    } finally {
      await req.response.close();
    }
  }
}

/// Joins a hosted session and runs a full two-way sync: entries both
/// directions, then photos both directions.
Future<SyncResult> lanSync(
    CatalogStore store, String host, int port, String pin,
    {bool includePrivate = false}) async {
  // Generous timeout: on iOS the first-ever local connection blocks on
  // the Local Network permission prompt until the user answers it.
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 25);
  try {
    Future<dynamic> call(String method, String path, {Object? body}) async {
      final req = await client.openUrl(method, Uri.parse('http://$host:$port$path'));
      req.headers.set(_pinHeader, pin);
      if (body is Map) {
        req.headers.contentType = ContentType.json;
        req.write(jsonEncode(body));
      } else if (body is Uint8List) {
        req.add(body);
      }
      final res = await req.close();
      if (res.statusCode == HttpStatus.forbidden) {
        throw const SyncException('Wrong PIN');
      }
      if (res.statusCode != HttpStatus.ok) {
        throw SyncException('Peer answered ${res.statusCode}');
      }
      final bytes = BytesBuilder();
      await for (final chunk in res) {
        bytes.add(chunk);
      }
      final data = bytes.takeBytes();
      final type = res.headers.contentType?.mimeType;
      return type == 'application/json'
          ? jsonDecode(utf8.decode(data))
          : Uint8List.fromList(data);
    }

    final hostVector = (await call('GET', '/vector') as Map)
        .map((k, v) => MapEntry(k as String, v as int));
    final myVector = store.versionVector();
    final toSend =
        store.entriesSince(hostVector, includePrivate: includePrivate);

    final response = await call('POST', '/sync', body: {
      'vector': myVector,
      'entries': [for (final e in toSend) e.toJson()],
    }) as Map;

    final received = [
      for (final e in response['entries'] as List)
        Entry.fromJson((e as Map).cast<String, dynamic>())
    ];
    final applied =
        store.applyEntries(received, senderVector: hostVector);

    var blobsIn = 0, blobsOut = 0;
    for (final hash in store.missingBlobs()) {
      final bytes = await call('GET', '/blob/$hash');
      if (bytes is Uint8List) {
        store.putBlob(hash, bytes);
        blobsIn++;
      }
    }
    for (final hash in (response['wantBlobs'] as List).cast<String>()) {
      final bytes = store.imageBytes(hash);
      if (bytes != null) {
        await call('POST', '/blob/$hash', body: bytes);
        blobsOut++;
      }
    }
    return SyncResult(toSend.length, received.length, blobsOut, blobsIn,
        applied: applied);
  } finally {
    client.close(force: true);
  }
}

class SyncException implements Exception {
  final String message;
  const SyncException(this.message);
  @override
  String toString() => message;
}
