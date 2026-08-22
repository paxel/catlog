import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../geocode.dart';

/// Zoom for a found place the search reported no extent for — street
/// level, not the country-wide view a centered street used to get.
const placeZoom = 16.0;

/// The camera fit for a found place, or null when the search reported
/// no extent and the caller should move to [GeoHit.lat]/[GeoHit.lon]
/// at [placeZoom] instead. A town fills the screen, a street does too.
CameraFit? placeFit(GeoHit hit) {
  final b = hit.bounds;
  if (b == null) return null;
  return CameraFit.bounds(
    bounds: LatLngBounds(LatLng(b.$1, b.$3), LatLng(b.$2, b.$4)),
    padding: const EdgeInsets.all(48),
    maxZoom: 17,
  );
}
