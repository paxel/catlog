import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/screens/in_person_screen.dart';
import 'package:flutter_test/flutter_test.dart';

/// Typing or pasting a pair code (#92): the field must hold the whole
/// 1.1.0 code — a cap at the pre-TLS length would truncate it into a
/// valid-looking old code and blame the peer.
void main() {
  test('the code field keeps a whole 1.1.0 code while typing', () {
    final code = encodePairCode('192.168.1.23', 4040, '123456',
        fingerprint: List<int>.generate(fullFingerprintBytes, (i) => i),
        typed: true);
    final formatted = PairCodeFormatter()
        .formatEditUpdate(TextEditingValue.empty,
            TextEditingValue(text: code))
        .text;
    final info = decodePairCode(formatted);
    expect(info, isNotNull);
    expect(info!.fingerprint, hasLength(typedFingerprintBytes),
        reason: 'a truncated code would decode as one from before TLS');
    // The whole QR payload can be pasted too.
    final full = encodePairCode('192.168.1.23', 4040, '123456',
        fingerprint: List<int>.generate(fullFingerprintBytes, (i) => i));
    expect(
        decodePairCode(PairCodeFormatter()
            .formatEditUpdate(
                TextEditingValue.empty, TextEditingValue(text: full))
            .text),
        isNotNull);
  });
}
