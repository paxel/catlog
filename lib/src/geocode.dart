import 'dart:convert';
import 'dart:io';

/// One place found for a search — enough to jump the map near it.
/// [bounds] is the place's own extent (south, north, west, east) when
/// the service reports it: a street deserves street zoom, a country
/// country zoom.
class GeoHit {
  final String name;
  final double lat;
  final double lon;
  final (double, double, double, double)? bounds;

  const GeoHit(this.name, this.lat, this.lon, {this.bounds});
}

/// Signature the picker takes, so tests inject a stub instead of the
/// network.
typedef GeocodeSearch = Future<List<GeoHit>> Function(String query);

/// Address/city/country search via OSM Nominatim — besides map tiles,
/// the app's only outbound call (named in the privacy policy). Runs
/// only when the user submits a search in the position picker, on the
/// map when the catalog knows no such name, or when the flier scan is
/// asked to locate the owner's address; no reverse geocoding anywhere.
Future<List<GeoHit>> nominatimSearch(String query) async {
  final client = HttpClient()
    ..userAgent = 'catlog/0.2 (https://github.com/paxel/catlog)'
    ..connectionTimeout = const Duration(seconds: 10);
  try {
    final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
      'q': query,
      'format': 'jsonv2',
      'limit': '8',
      // The address in parts, so it can be written the way the place
      // itself writes addresses — not in Nominatim's one order for all.
      'addressdetails': '1',
    });
    final req = await client.getUrl(uri);
    final res = await req.close();
    if (res.statusCode != HttpStatus.ok) return const [];
    final body = await utf8.decoder.bind(res).join();
    return [
      for (final hit in jsonDecode(body) as List)
        GeoHit(
          formatAddress((hit as Map)['address'],
              fallback: hit['display_name'] as String),
          double.parse(hit['lat'] as String),
          double.parse(hit['lon'] as String),
          bounds: _bounds(hit['boundingbox']),
        )
    ];
  } finally {
    client.close(force: true);
  }
}

/// Countries that write the house number before the street and the
/// postcode after the town ("12 Main Street, Springfield 62704").
/// Everywhere else the street comes first and the postcode before the
/// town ("Grimmaische Straße 12, 04109 Leipzig").
const _numberFirst = {
  'us', 'ca', 'gb', 'ie', 'fr', 'au', 'nz', 'za', 'in', 'sg', 'hk', 'my',
  'ph', 'lu',
};

/// A street address from Nominatim's `address` parts, in the order the
/// hit's own country uses. Hits without a street — a town, a region, a
/// country — keep [fallback], Nominatim's full name, which reads fine
/// for those. The country itself is left off: an address is looked up
/// where the cats live.
String formatAddress(Object? address, {required String fallback}) {
  if (address is! Map) return fallback;
  String? part(List<String> keys) {
    for (final k in keys) {
      final v = address[k];
      if (v is String && v.trim().isNotEmpty) return v.trim();
    }
    return null;
  }

  final street = part(['road', 'pedestrian', 'footway', 'path', 'square']);
  if (street == null) return fallback;
  final number = part(['house_number']);
  final place =
      part(['city', 'town', 'village', 'municipality', 'hamlet', 'suburb']);
  final postcode = part(['postcode']);
  final numberFirst =
      _numberFirst.contains(part(['country_code'])?.toLowerCase());
  final streetLine = number == null
      ? street
      : numberFirst
          ? '$number $street'
          : '$street $number';
  final placeLine = [
    if (numberFirst) ...[?place, ?postcode] else ...[?postcode, ?place],
  ].join(' ');
  return placeLine.isEmpty ? streetLine : '$streetLine, $placeLine';
}

/// Nominatim's `boundingbox`: four strings, ordered
/// [minlat, maxlat, minlon, maxlon]. Anything else is ignored.
(double, double, double, double)? _bounds(Object? raw) {
  if (raw is! List || raw.length != 4) return null;
  final v = [for (final x in raw) double.tryParse('$x')];
  if (v.any((x) => x == null)) return null;
  return (v[0]!, v[1]!, v[2]!, v[3]!);
}
