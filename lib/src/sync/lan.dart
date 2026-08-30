import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data' show BytesBuilder;

import 'package:catalog_core/catalog_core.dart';

import 'package:flutter/foundation.dart';
import 'dart:async';
import 'tls.dart';

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
const _deviceHeader = 'x-catlog-device';

String _randomSecret() {
  final r = Random.secure();
  return List.generate(32, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
}
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

  /// "Always allow this device": the host issues it a secret and lets
  /// it in without asking from then on — the secret, not the device's
  /// self-declared id, is what is trusted.
  final bool remember;
  const JoinDecision(this.allow, this.includePrivate, {this.remember = false});
}

/// How many wrong PINs one address may send before it is locked out,
/// and how many in total before the host stops serving: a 6-digit PIN
/// on plain HTTP survives only if guessing is not free.
const pinFailuresPerAddress = 5;
const pinFailuresTotal = 20;

/// Local-setting key of a trusted joiner: `private|author|name|secret`.
String trustKey(String deviceId) => 'trust:$deviceId';

/// Local-setting key, on the joiner, of the secret a host issued.
String trustSecretKey(String hostDeviceId) => 'trustSecret:$hostDeviceId';

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
  final _failures = <String, int>{};
  var _failuresTotal = 0;

  /// Sync requests are handled one after the other: two joiners at once
  /// would stack two trust dialogs and interleave their imports.
  Future<void> _syncTurn = Future.value();

  /// The certificate the host serves with; its fingerprint goes into
  /// the pair code (#92).
  final TlsIdentity identity;

  LanSyncHost(this.store, this.pin,
      {required this.identity, this.onJoinRequest, this.onSession});

  Uint8List get fingerprint => identity.fingerprint;

  int get port => _server!.port;

  /// True once too many wrong PINs arrived: the host no longer answers
  /// anything and must be started again with a new PIN.
  bool get lockedOut => _failuresTotal >= pinFailuresTotal;

  /// Starts serving and returns the address to show the joiner. Bound
  /// to the LAN interface only — not to every interface the phone has
  /// (cellular, VPN); [bind] overrides for tests.
  Future<String> start({InternetAddress? bind}) async {
    var address = bind;
    if (address == null) {
      for (final iface in await NetworkInterface.list(
          type: InternetAddressType.IPv4, includeLoopback: false)) {
        if (iface.addresses.isNotEmpty) {
          address = iface.addresses.first;
          break;
        }
      }
    }
    address ??= InternetAddress.loopbackIPv4;
    _server = await HttpServer.bindSecure(address, 0, identity.context);
    _server!.listen(_handle, onError: (_) {});
    return address.address;
  }

  Future<void> stop() async => _server?.close(force: true);

  /// The trust a joiner claims, checked against the secret this host
  /// issued it. A stored trust without a secret (older versions) counts
  /// as none: the keeper is asked once more and the secret is issued.
  JoinDecision? _trusted(String deviceId, String? secret) {
    if (deviceId.isEmpty || secret == null || secret.isEmpty) return null;
    final stored = store.localSetting(trustKey(deviceId));
    if (stored == null) return null;
    final parts = stored.split('|');
    if (parts.length < 4 || parts[3] != secret) return null;
    return JoinDecision(true, parts.first == 'private');
  }

  String _remember(String deviceId, String author, String name,
      bool includePrivate) {
    final secret = _randomSecret();
    store.setLocalSetting(trustKey(deviceId),
        '${includePrivate ? 'private' : 'public'}|$author|$name|$secret');
    return secret;
  }

  Future<void> _handle(HttpRequest req) async {
    if (req.method == 'POST' && req.uri.path == '/sync') {
      final previous = _syncTurn;
      final done = Completer<void>();
      _syncTurn = done.future;
      try {
        await previous;
        await _handleNow(req);
      } finally {
        done.complete();
      }
      return;
    }
    await _handleNow(req);
  }

  Future<void> _handleNow(HttpRequest req) async {
    try {
      final from = req.connectionInfo?.remoteAddress.address ?? '?';
      if (lockedOut || (_failures[from] ?? 0) >= pinFailuresPerAddress) {
        req.response.statusCode = HttpStatus.forbidden;
        req.response.write('locked');
        return;
      }
      if (req.headers.value(_pinHeader) != pin) {
        _failures[from] = (_failures[from] ?? 0) + 1;
        _failuresTotal++;
        req.response.statusCode = HttpStatus.forbidden;
        return;
      }
      final path = req.uri.path;
      if (req.method == 'GET' && path == '/vector') {
        req.response.headers.set(_formatHeader, '$syncFormat');
        req.response.headers.set(_deviceHeader, store.deviceId);
        req.response.headers.contentType = ContentType.json;
        req.response.write(jsonEncode(store.versionVector()));
      } else if (req.method == 'POST' && path == '/sync') {
        final raw = await _readBody(req, maxEntriesBytes);
        if (raw == null) {
          req.response.statusCode = HttpStatus.requestEntityTooLarge;
          return;
        }
        final body = jsonDecode(utf8.decode(raw)) as Map;
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
        final author = body['author'] as String? ?? '?';
        final deviceName = body['deviceName'] as String? ?? '?';
        final deviceId = body['deviceId'] as String? ?? '';
        final decision = _trusted(deviceId, body['trustSecret'] as String?) ??
            (onJoinRequest == null
                ? const JoinDecision(true, false)
                : await onJoinRequest!(author, '$deviceName|$deviceId'));
        if (!decision.allow) {
          req.response.statusCode = HttpStatus.forbidden;
          req.response.write('declined');
          return;
        }
        final issued = decision.remember && deviceId.isNotEmpty
            ? _remember(deviceId, author, deviceName, decision.includePrivate)
            : null;
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
          'trust': ?issued,
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
        final bytes = await _readBody(req, maxBlobBytes);
        if (bytes == null) {
          req.response.statusCode = HttpStatus.requestEntityTooLarge;
          return;
        }
        final hash = path.substring('/blob/'.length);
        // Only a photo this catalog's log mentions — anything else is
        // storage filled by whoever holds the PIN.
        if (!store.knowsImage(hash)) {
          req.response.statusCode = HttpStatus.notFound;
          return;
        }
        store.putBlob(hash, bytes);
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

/// The request body, or null once it exceeds [limit] — the rest is
/// not read; a peer with the PIN must not be able to fill the memory.
Future<Uint8List?> _readBody(HttpRequest req, int limit) async {
  final builder = BytesBuilder();
  await for (final chunk in req) {
    builder.add(chunk);
    if (builder.length > limit) return null;
  }
  return builder.takeBytes();
}

/// Joins a hosted session and runs a full two-way sync: entries both
/// directions, then photos both directions.
Future<SyncResult> lanSync(
    CatalogStore store, String host, int port, String pin,
    {required List<int> fingerprint, bool includePrivate = false}) async {
  // Generous timeout: on iOS the first-ever local connection blocks on
  // the Local Network permission prompt until the user answers it.
  // The host's self-signed certificate is accepted only when it is the
  // one the pair code named (#92).
  final client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 25)
    ..badCertificateCallback =
        (cert, _, _) => certificateMatches(cert, fingerprint);
  try {
    var hostFormat = 1;
    Future<dynamic> call(String method, String path,
        {Object? body, void Function(HttpHeaders)? onHeaders}) async {
      final HttpClientRequest req;
      try {
        req = await client.openUrl(
            method, Uri.parse('https://$host:$port$path'));
      } on HandshakeException {
        // No TLS on the other side: a version before 1.1.0, or not the
        // host the code named.
        throw const SyncException('peer-older');
      }
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
      onHeaders?.call(res.headers);
      if (res.statusCode == HttpStatus.notFound && path.startsWith('/blob/')) {
        // A photo the peer's log mentions but nobody holds any more —
        // permanent in an append-only log; skip it, never fail on it.
        return null;
      }
      if (res.statusCode != HttpStatus.ok) {
        throw SyncException('Peer answered ${res.statusCode}');
      }
      final bytes = BytesBuilder();
      await for (final chunk in res) {
        bytes.add(chunk);
        if (bytes.length > maxEntriesBytes) {
          throw const SyncException('Peer sent too much');
        }
      }
      final data = bytes.takeBytes();
      final type = res.headers.contentType?.mimeType;
      return type == 'application/json'
          ? jsonDecode(utf8.decode(data))
          : Uint8List.fromList(data);
    }

    String? hostDevice;
    final hostVector = (await call('GET', '/vector',
            onHeaders: (h) => hostDevice = h.value(_deviceHeader)) as Map)
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
      'trustSecret': ?(hostDevice == null
          ? null
          : store.localSetting(trustSecretKey(hostDevice!))),
    }) as Map;
    if (hostDevice != null && response['trust'] is String) {
      // "Always allow" on the host: keep its secret for next time.
      store.setLocalSetting(
          trustSecretKey(hostDevice!), response['trust'] as String);
    }

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

    // The entries are in and recorded; whatever happens to the photos
    // now (host gone, a bad blob) the keeper gets the summary with its
    // undo — and the next sync fetches what is still missing.
    var blobsIn = 0, blobsOut = 0;
    try {
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
    } catch (_) {
      // Counted what landed; the rest waits for the next sync.
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
