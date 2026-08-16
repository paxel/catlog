import 'dart:convert';
import 'dart:io';

/// One place found for a search — enough to jump the map near it.
class GeoHit {
  final String name;
  final double lat;
  final double lon;

  const GeoHit(this.name, this.lat, this.lon);
}

/// Signature the picker takes, so tests inject a stub instead of the
/// network.
typedef GeocodeSearch = Future<List<GeoHit>> Function(String query);

/// Address/city/country search via OSM Nominatim — the app's single
/// outbound call besides map tiles (named in the privacy policy). Only
/// runs when the user submits a search in the position picker; no
/// reverse geocoding anywhere.
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
        )
    ];
  } finally {
    client.close(force: true);
  }
}
