import 'package:catlog/src/plus_code.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('encodes the reference vectors', () {
    // Official Open Location Code test vectors.
    expect(encodePlusCode(47.0000625, 8.0000625), '8FVC2222+22');
    expect(encodePlusCode(20.3701125, 2.7821875), '7FG49QCJ+2V');
    expect(encodePlusCode(-41.2730625, 174.7859375), '4VCPPQGP+Q9');
  });
}
