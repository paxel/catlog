import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Pair codes carry the host certificate's fingerprint (#92): all of
/// it in a QR, its first bytes in a typed code, none in an old code.
void main() {
  final fp = List<int>.generate(32, (i) => (i * 7 + 3) & 0xff);

  test('a QR code round-trips the whole fingerprint', () {
    final code = encodePairCode('192.168.1.20', 4242, '123456', fingerprint: fp);
    final info = decodePairCode(code)!;
    expect(info.host, '192.168.1.20');
    expect(info.port, 4242);
    expect(info.pin, '123456');
    expect(info.fingerprint, fp);
  });

  test('a typed code carries the first bytes and forgives typing', () {
    final code =
        encodePairCode('10.0.0.5', 80, '000042', fingerprint: fp, typed: true);
    expect(code.length, lessThan(40));
    final info = decodePairCode(code.toUpperCase().replaceAll('_', ' '))!;
    expect(info.fingerprint, fp.take(typedFingerprintBytes).toList());
    expect(info.pin, '000042');
  });

  test('a code from before TLS decodes with no fingerprint', () {
    final old = encodePairCode('192.168.1.20', 4242, '123456');
    final info = decodePairCode(old)!;
    expect(info.fingerprint, isNull);
    expect(decodePairCode('nonsense'), isNull);
  });
  codeLengthTests();
}

void codeLengthTests() {
  test('the code length follows the address and fingerprint sizes', () {
    // 9 bytes → 15 chars, 17 → 28, 41 → 66; IPv6 21 → 34, 29 → 47, 53 → 85.
    expect(pairCodeLength(4, 0), 15);
    expect(pairCodeLength(4, typedFingerprintBytes), 28);
    expect(pairCodeLength(4, fullFingerprintBytes), 66);
    expect(pairCodeLength(16, 0), 34);
    expect(pairCodeLength(16, typedFingerprintBytes), 47);
    expect(pairCodeLength(16, fullFingerprintBytes), 85);
    final fp = List<int>.generate(fullFingerprintBytes, (i) => i);
    expect(encodePairCode('192.168.1.2', 8080, '123456', fingerprint: fp, typed: true)
        .replaceAll('_', '').length, pairCodeLength(4, typedFingerprintBytes));
  });
}
