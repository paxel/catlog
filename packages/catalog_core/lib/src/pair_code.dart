import 'dart:io';
import 'dart:typed_data';

/// The short typable pairing code: host + port + PIN packed into
/// Crockford base32 (lowercase, no i/l/o/u). IPv4 packs to 9 bytes →
/// 15 chars, shown grouped as xxxxx_xxxxx_xxxxx; IPv6 packs to 21
/// bytes → 34 chars (rare — LAN pairing prefers IPv4). The QR carries
/// the same string.
const _alphabet = '0123456789abcdefghjkmnpqrstvwxyz';

class PairInfo {
  final String host;
  final int port;
  final String pin;

  /// The host certificate's SHA-256 fingerprint, or its first bytes in
  /// a typed code (#92); null in a code from a version before TLS.
  final List<int>? fingerprint;
  const PairInfo(this.host, this.port, this.pin, {this.fingerprint});
}

/// How much of the fingerprint a typed code carries: enough against a
/// sniffer on the same network, short enough to type.
const typedFingerprintBytes = 8;

/// A whole SHA-256 fingerprint, as the QR carries it.
const fullFingerprintBytes = 32;

/// How many base32 characters a code of [addressBytes] + port + PIN +
/// [fingerprintBytes] takes — five bits per character, rounded up.
int pairCodeLength(int addressBytes, int fingerprintBytes) =>
    ((addressBytes + 5 + fingerprintBytes) * 8 + 4) ~/ 5;

/// Character count → (address bytes, fingerprint bytes) for every
/// shape a code can have; decoding tells them apart by length alone.
final Map<int, (int, int)> _shapes = {
  for (final address in const [4, 16])
    for (final fp in const [0, typedFingerprintBytes, fullFingerprintBytes])
      pairCodeLength(address, fp): (address, fp),
};

/// Whether [host] is an address on a local network — the only place
/// an in-person sync partner can be. A typed code carrying a public
/// address would send every public entry to a stranger on the internet
/// before any answer came back.
bool isPrivateHost(String host) {
  final parts = host.split('.');
  if (parts.length != 4) return false;
  final o = parts.map(int.tryParse).toList();
  if (o.any((n) => n == null || n < 0 || n > 255)) return false;
  final a = o[0]!, b = o[1]!;
  return a == 10 ||
      (a == 172 && b >= 16 && b <= 31) ||
      (a == 192 && b == 168) ||
      (a == 169 && b == 254) ||
      a == 127;
}

String encodePairCode(String host, int port, String pin,
    {List<int>? fingerprint, bool typed = false}) {
  final address = InternetAddress(host);
  final pinNumber = int.parse(pin);
  final raw = address.rawAddress;
  final fp = fingerprint == null
      ? const <int>[]
      : typed
          ? fingerprint.take(typedFingerprintBytes).toList()
          : fingerprint;
  final bytes = Uint8List(raw.length + 5 + fp.length)
    ..setAll(0, raw)
    ..[raw.length] = port >> 8
    ..[raw.length + 1] = port & 0xff
    ..[raw.length + 2] = pinNumber >> 16
    ..[raw.length + 3] = (pinNumber >> 8) & 0xff
    ..[raw.length + 4] = pinNumber & 0xff
    ..setAll(raw.length + 5, fp);
  return _group(_toBase32(bytes));
}

/// Parses a code as the user typed it: underscores, spaces, case, and
/// the classic confusions (i/l→1, o→0) are all forgiven. Returns null
/// when it is not a valid code.
PairInfo? decodePairCode(String input) {
  final cleaned = input
      .toLowerCase()
      .replaceAll(RegExp(r'[\s_\-]'), '')
      .replaceAll('i', '1')
      .replaceAll('l', '1')
      .replaceAll('o', '0')
      .replaceAll('u', 'v');
  final bytes = _fromBase32(cleaned);
  if (bytes == null) return null;
  // 4 or 16 address bytes, port, PIN, then no / typed / full
  // fingerprint bytes — base32 pads to a byte boundary, so the shape
  // is matched by the character count.
  final shape = _shapes[cleaned.length];
  if (shape == null) return null;
  final (addressLength, fpLength) = shape;
  if (bytes.length < addressLength + 5 + fpLength) return null;
  final address = InternetAddress.fromRawAddress(
      Uint8List.fromList(bytes.sublist(0, addressLength)));
  final port = (bytes[addressLength] << 8) | bytes[addressLength + 1];
  final pin = (bytes[addressLength + 2] << 16) |
      (bytes[addressLength + 3] << 8) |
      bytes[addressLength + 4];
  if (port == 0 || pin > 999999) return null;
  final fp = fpLength == 0
      ? null
      : bytes.sublist(addressLength + 5, addressLength + 5 + fpLength);
  return PairInfo(address.address, port, pin.toString().padLeft(6, '0'),
      fingerprint: fp);
}

/// xxxxx_xxxxx_xxxxx grouping for readability.
String _group(String s) {
  final parts = <String>[];
  for (var i = 0; i < s.length; i += 5) {
    parts.add(s.substring(i, i + 5 > s.length ? s.length : i + 5));
  }
  return parts.join('_');
}

String _toBase32(Uint8List bytes) {
  final out = StringBuffer();
  var buffer = 0;
  var bits = 0;
  for (final byte in bytes) {
    buffer = (buffer << 8) | byte;
    bits += 8;
    while (bits >= 5) {
      out.write(_alphabet[(buffer >> (bits - 5)) & 31]);
      bits -= 5;
    }
  }
  if (bits > 0) out.write(_alphabet[(buffer << (5 - bits)) & 31]);
  return out.toString();
}

List<int>? _fromBase32(String s) {
  final out = <int>[];
  var buffer = 0;
  var bits = 0;
  for (final rune in s.runes) {
    final value = _alphabet.indexOf(String.fromCharCode(rune));
    if (value < 0) return null;
    buffer = (buffer << 5) | value;
    bits += 5;
    if (bits >= 8) {
      out.add((buffer >> (bits - 8)) & 0xff);
      bits -= 8;
    }
  }
  return out;
}
