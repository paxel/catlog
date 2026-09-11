import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;

/// Signed entries (1.2.0): every catalog signs what it writes with an
/// Ed25519 key made once per catalog and bound to its device id. A
/// partner who has met the key refuses entries claiming that device
/// without a valid signature, so nobody can write in someone else's
/// name from a hand-made file. Keys travel with the data (bundle,
/// shared folder, in-person session); the first key seen for a device
/// is trusted on first use, an in-person session makes it verified.
/// Entries from before the key — and from versions before 1.2 — pass
/// as unsigned.
class SigningKey {
  final Uint8List seed;
  final ed.PrivateKey _private;
  final Uint8List publicKey;

  SigningKey._(this.seed, this._private, this.publicKey);

  factory SigningKey.fromSeed(Uint8List seed) {
    final private = ed.newKeyFromSeed(seed);
    return SigningKey._(
        seed, private, Uint8List.fromList(ed.public(private).bytes));
  }

  factory SigningKey.generate() {
    final pair = ed.generateKey();
    return SigningKey.fromSeed(Uint8List.fromList(ed.seed(pair.privateKey)));
  }

  String get seedHex => hex(seed);
  String get publicBase64 => base64.encode(publicKey);

  /// The key's fingerprint: SHA-256 of the public key, hex.
  String get fingerprint => keyFingerprint(publicKey);

  /// What the UI shows next to a name: `7f3a-c21e`.
  String get code => keyCode(publicKey);

  String sign(Uint8List message) => base64.encode(ed.sign(_private, message));
}

String hex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

Uint8List fromHex(String s) => Uint8List.fromList([
      for (var i = 0; i + 1 < s.length; i += 2)
        int.parse(s.substring(i, i + 2), radix: 16)
    ]);

String keyFingerprint(List<int> publicKey) =>
    hex(sha256.convert(publicKey).bytes);

/// The short form of a fingerprint, for people: eight hex digits with a
/// dash, `7f3a-c21e`.
String keyCode(List<int> publicKey) {
  final f = keyFingerprint(publicKey);
  return '${f.substring(0, 4)}-${f.substring(4, 8)}';
}

/// A device id for a new catalog, derived from its key: the first 16
/// bytes of the fingerprint as hex. Older catalogs keep their random id.
String deviceIdFromKey(List<int> publicKey) =>
    keyFingerprint(publicKey).substring(0, 32);

/// Whether [signature] (base64) signs [message] under [publicKey]. Any
/// malformed input is simply invalid.
bool verifySignature(
    List<int> publicKey, Uint8List message, String? signature) {
  if (signature == null || publicKey.length != ed.PublicKeySize) return false;
  try {
    final sig = base64.decode(signature);
    if (sig.length != ed.SignatureSize) return false;
    return ed.verify(ed.PublicKey(Uint8List.fromList(publicKey)), message,
        Uint8List.fromList(sig));
  } catch (_) {
    return false;
  }
}

/// The bytes an entry's signature covers: a fixed-order JSON list, so
/// a null value and an empty one differ and free text needs no escaping
/// rules of its own. Dates go in as the store writes them.
Uint8List entryBytes({
  required String device,
  required int dseq,
  required String entity,
  required String field,
  required String? value,
  required String dateIso,
  required String author,
  required String recordedIso,
  required bool reminder,
}) =>
    Uint8List.fromList(utf8.encode(jsonEncode([
      device,
      dseq,
      entity,
      field,
      value,
      dateIso,
      author,
      recordedIso,
      reminder,
    ])));

/// How far a pinned key is trusted: seen in a file, or met in person
/// over a session the pair code authenticated.
enum KeyTrust { tofu, verified }

/// A key as it travels: which device it speaks for, the public key, and
/// from which of the device's entries on the signing began. The record
/// signs itself, so nobody can publish a key for a device they do not
/// hold or move [since] to smuggle unsigned rows past it.
class KeyRecord {
  final String device;
  final Uint8List publicKey;
  final int since;
  final String signature;

  const KeyRecord(this.device, this.publicKey, this.since, this.signature);

  static Uint8List _bytes(String device, List<int> publicKey, int since) =>
      Uint8List.fromList(
          utf8.encode(jsonEncode([device, base64.encode(publicKey), since])));

  /// A record for [device], signed by [key].
  factory KeyRecord.make(SigningKey key, String device, int since) => KeyRecord(
      device,
      key.publicKey,
      since,
      key.sign(_bytes(device, key.publicKey, since)));

  /// True when the record was signed by the key it carries.
  bool get selfSigned =>
      verifySignature(publicKey, _bytes(device, publicKey, since), signature);

  String get fingerprint => keyFingerprint(publicKey);
  String get code => keyCode(publicKey);

  Map<String, dynamic> toJson() => {
        'device': device,
        'key': base64.encode(publicKey),
        'since': since,
        'sig': signature,
      };

  static KeyRecord? fromJson(Map<String, dynamic> json) {
    try {
      return KeyRecord(
        json['device'] as String,
        Uint8List.fromList(base64.decode(json['key'] as String)),
        json['since'] as int,
        json['sig'] as String,
      );
    } catch (_) {
      return null;
    }
  }
}

/// A key this catalog holds for a partner's device, with how far it is
/// trusted.
class PinnedKey {
  final KeyRecord record;
  final KeyTrust trust;

  const PinnedKey(this.record, this.trust);

  Map<String, dynamic> toJson() => {...record.toJson(), 'trust': trust.name};

  static PinnedKey? fromJson(Map<String, dynamic> json) {
    final record = KeyRecord.fromJson(json);
    if (record == null) return null;
    return PinnedKey(
        record, KeyTrust.values.asNameMap()[json['trust']] ?? KeyTrust.tofu);
  }
}

/// What an import found out about the people behind the entries: what
/// it refused and why, which keys it met, which it would not take.
class ImportReport {
  /// Entries dropped for a missing or wrong signature, by (author,
  /// device): the count of rows.
  final Map<(String author, String device), int> refused = {};

  /// Keys pinned by this import — the first time these devices spoke.
  final List<PinnedKey> newKeys = [];

  /// A new key calling itself by a name this catalog already knows
  /// under another key: (name, device of the new key).
  final List<(String name, String device)> impostors = [];

  /// Devices that offered a key other than the one pinned here — kept
  /// out; the pinned one stands.
  final List<String> changedKeys = [];

  int get refusedCount => refused.values.fold(0, (a, b) => a + b);

  bool get isEmpty =>
      refused.isEmpty &&
      newKeys.isEmpty &&
      impostors.isEmpty &&
      changedKeys.isEmpty;
}
