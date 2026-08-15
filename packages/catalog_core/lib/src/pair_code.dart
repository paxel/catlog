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
  const PairInfo(this.host, this.port, this.pin);
}

String encodePairCode(String host, int port, String pin) {
  final address = InternetAddress(host);
  final pinNumber = int.parse(pin);
  final raw = address.rawAddress;
  final bytes = Uint8List(raw.length + 5)
    ..setAll(0, raw)
    ..[raw.length] = port >> 8
    ..[raw.length + 1] = port & 0xff
    ..[raw.length + 2] = pinNumber >> 16
    ..[raw.length + 3] = (pinNumber >> 8) & 0xff
    ..[raw.length + 4] = pinNumber & 0xff;
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
  if (cleaned.length != 15 && cleaned.length != 34) return null;
  final bytes = _fromBase32(cleaned);
  if (bytes == null) return null;
  final addressLength = cleaned.length == 15 ? 4 : 16;
  if (bytes.length < addressLength + 5) return null;
  final address = InternetAddress.fromRawAddress(
      Uint8List.fromList(bytes.sublist(0, addressLength)));
  final port = (bytes[addressLength] << 8) | bytes[addressLength + 1];
  final pin = (bytes[addressLength + 2] << 16) |
      (bytes[addressLength + 3] << 8) |
      bytes[addressLength + 4];
  if (port == 0 || pin > 999999) return null;
  return PairInfo(
      address.address, port, pin.toString().padLeft(6, '0'));
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
