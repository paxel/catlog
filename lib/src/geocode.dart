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
    });
    final req = await client.getUrl(uri);
    final res = await req.close();
    if (res.statusCode != HttpStatus.ok) return const [];
    final body = await utf8.decoder.bind(res).join();
    return [
      for (final hit in jsonDecode(body) as List)
        GeoHit(
          (hit as Map)['display_name'] as String,
          double.parse(hit['lat'] as String),
          double.parse(hit['lon'] as String),
          bounds: _bounds(hit['boundingbox']),
        )
    ];
  } finally {
    client.close(force: true);
  }
}

/// Nominatim's `boundingbox`: four strings, ordered
/// [minlat, maxlat, minlon, maxlon]. Anything else is ignored.
(double, double, double, double)? _bounds(Object? raw) {
  if (raw is! List || raw.length != 4) return null;
  final v = [for (final x in raw) double.tryParse('$x')];
  if (v.any((x) => x == null)) return null;
  return (v[0]!, v[1]!, v[2]!, v[3]!);
}
