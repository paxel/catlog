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
const _formatHeader = 'x-catlog-format';

/// The sync wire format this build speaks. Format 2 (1.0.0, #74):
/// entries carry the reminder flag. A pre-1.0.0 peer would silently
/// strip the flag and record plans as facts, so both sides refuse a
/// format-1 peer instead of corrupting it — with a message naming the
/// fix (update the other device).
const syncFormat = 2;

/// Hosts a sync session on the LAN: a small HTTP server the joiner
/// drives. The PIN gates every request — it prevents accidents in a
/// trusted group, not attackers (ADR-0002 threat model).
/// The host's answer to "may this device sync, and with privates?".
class JoinDecision {
  final bool allow;
  final bool includePrivate;
  const JoinDecision(this.allow, this.includePrivate);
}

class LanSyncHost {
  final CatalogStore store;
  final String pin;

  /// Asked once per incoming /sync with the joiner's author and device
  /// name — the human trust gate. Null allows everyone, public-only
  /// (used by tests).
  final Future<JoinDecision> Function(String author, String device)?
      onJoinRequest;

  /// Called after a joiner completed a session; receives what actually
  /// landed, so the host can show the import summary too.
  final void Function(List<Entry> applied)? onSession;

  HttpServer? _server;

  LanSyncHost(this.store, this.pin, {this.onJoinRequest, this.onSession});

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
        req.response.headers.set(_formatHeader, '$syncFormat');
        req.response.headers.contentType = ContentType.json;
        req.response.write(jsonEncode(store.versionVector()));
      } else if (req.method == 'POST' && path == '/sync') {
        final body =
            jsonDecode(await utf8.decoder.bind(req).join()) as Map;
        final joinerFormat = body['format'] as int? ?? 1;
        if (joinerFormat != syncFormat &&
            // Compatibility window: while no entry ever carried the
            // reminder flag, this catalog's payloads are byte-identical
            // to the old format — an older joiner syncs losslessly.
            !(joinerFormat < syncFormat && !store.hasReminders())) {
          req.response.statusCode = HttpStatus.forbidden;
          if (joinerFormat == 1) {
            // A pre-1.0.0 joiner cannot receive flagged entries and
            // parses only this word; it shows "host declined" — wrong
            // reason, right outcome, its shipped reader has no better.
            req.response.write('declined');
          } else {
            // From format 2 on, refusals carry their reason, so a
            // future mismatch names the fix instead of guessing.
            req.response.headers.contentType = ContentType.json;
            req.response.write(jsonEncode({
              'refusal': joinerFormat < syncFormat
                  ? 'joiner-older'
                  : 'joiner-newer',
              'format': syncFormat,
            }));
          }
          return;
        }
        final decision = onJoinRequest == null
            ? const JoinDecision(true, false)
            : await onJoinRequest!(
                body['author'] as String? ?? '?',
                '${body['deviceName'] as String? ?? '?'}'
                '|${body['deviceId'] as String? ?? ''}');
        if (!decision.allow) {
          req.response.statusCode = HttpStatus.forbidden;
          req.response.write('declined');
          return;
        }
        final joinerVector = (body['vector'] as Map)
            .map((k, v) => MapEntry(k as String, v as int));
        final incoming = [
          for (final e in body['entries'] as List)
            Entry.fromJson((e as Map).cast<String, dynamic>())
        ];
        final before = store.currentSeq();
        final applied =
            store.applyEntries(incoming, senderVector: joinerVector);
        momentFor(store,
            before: before,
            changed: applied.isNotEmpty,
            cause: MomentCause.sync,
            label: body['author'] as String?);
        req.response.headers.contentType = ContentType.json;
        req.response.write(jsonEncode({
          'entries': [
            for (final e in store.entriesSince(joinerVector,
                includePrivate: decision.includePrivate))
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
      // A joiner that vanished mid-answer makes close() itself throw;
      // that is the joiner's problem, never the host's crash screen.
      try {
        await req.response.close();
      } catch (_) {}
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
    var hostFormat = 1;
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
      hostFormat =
          int.tryParse(res.headers.value(_formatHeader) ?? '') ?? 1;
      if (res.statusCode == HttpStatus.forbidden) {
        final body = await utf8.decoder.bind(res).join();
        // A refusal from format 2 on is JSON naming its reason.
        try {
          final refusal =
              (jsonDecode(body) as Map)['refusal'] as String?;
          if (refusal == 'joiner-older') {
            throw const SyncException('peer-newer');
          }
          if (refusal == 'joiner-newer') {
            throw const SyncException('peer-older');
          }
        } on FormatException {
          // Not JSON — a plain PIN or decline refusal.
        }
        throw SyncException(
            body.contains('declined') ? 'declined' : 'Wrong PIN');
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
    // An older host would strip the reminder flag off entries and
    // record plans as facts (#74) — refuse it before anything is sent,
    // unless this catalog has never used a reminder: then the payload
    // is byte-identical to the old format and syncs losslessly. A
    // NEWER host is not prejudged — it may run the same compatibility
    // window, and if not, its refusal names the reason.
    if (hostFormat < syncFormat && store.hasReminders()) {
      throw const SyncException('peer-older');
    }
    final myVector = store.versionVector();
    final toSend =
        store.entriesSince(hostVector, includePrivate: includePrivate);

    final response = await call('POST', '/sync', body: {
      'format': syncFormat,
      'vector': myVector,
      'entries': [for (final e in toSend) e.toJson()],
      'author': store.author ?? '?',
      'deviceName': Platform.localHostname,
      'deviceId': store.deviceId,
    }) as Map;

    final received = [
      for (final e in response['entries'] as List)
        Entry.fromJson((e as Map).cast<String, dynamic>())
    ];
    final beforeApply = store.currentSeq();
    final applied =
        store.applyEntries(received, senderVector: hostVector);
    momentFor(store,
        before: beforeApply,
        changed: applied.isNotEmpty,
        cause: MomentCause.sync,
        label: host);

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
