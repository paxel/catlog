import 'package:catlog/src/geocode.dart';
import 'package:flutter_test/flutter_test.dart';

/// A found address reads the way its own country writes addresses,
/// not in Nominatim's number-first order for everyone.
void main() {
  const leipzig = {
    'house_number': '12',
    'road': 'Grimmaische Straße',
    'suburb': 'Zentrum',
    'city': 'Leipzig',
    'state': 'Sachsen',
    'postcode': '04109',
    'country': 'Deutschland',
    'country_code': 'de',
  };
  const fallback = '12, Grimmaische Straße, Zentrum, Leipzig, 04109, DE';

  test('German: street, number, then postcode and town', () {
    expect(
      formatAddress(leipzig, fallback: fallback),
      'Grimmaische Straße 12, 04109 Leipzig',
    );
  });

  test('American: number, street, then town and postcode', () {
    expect(
      formatAddress({
        'house_number': '742',
        'road': 'Evergreen Terrace',
        'city': 'Springfield',
        'postcode': '62704',
        'country_code': 'us',
      }, fallback: fallback),
      '742 Evergreen Terrace, Springfield 62704',
    );
  });

  test('missing parts are simply left out', () {
    expect(
      formatAddress({
        'road': 'Dorfstraße',
        'village': 'Kleinhausen',
        'country_code': 'at',
      }, fallback: fallback),
      'Dorfstraße, Kleinhausen',
    );
    expect(
      formatAddress({
        'road': 'Rue Neuve',
        'country_code': 'fr',
      }, fallback: fallback),
      'Rue Neuve',
    );
  });

  test('a town, a region or nothing keeps the full name', () {
    expect(
      formatAddress({
        'city': 'Leipzig',
        'country_code': 'de',
      }, fallback: 'Leipzig, Sachsen, Deutschland'),
      'Leipzig, Sachsen, Deutschland',
    );
    expect(formatAddress(null, fallback: fallback), fallback);
  });
}
