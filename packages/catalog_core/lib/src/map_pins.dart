import 'match.dart' show haversineMeters;

/// The kinds of thing a map pin stands for, in the order they take the
/// front of a shared spot: the home is the durable thing at an address,
/// the cats come and go, a flier marks where a cat was lost, a field is
/// a keeper's own place.
enum PinKind { home, cat, flier, field }

/// One thing at one place on the map.
class MapPin {
  final PinKind kind;
  final String id;
  final String name;
  final double lat;
  final double lon;

  /// The location field the pin comes from; the built-in position when
  /// null.
  final String? fieldKey;

  const MapPin({
    required this.kind,
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    this.fieldKey,
  });
}

/// Things within [spotMeters] of each other count as one spot.
const spotMeters = 20.0;

/// What stands on one spot: one pin on the map, the front thing's face
/// and name on it, and the rest behind it in a list.
class PinSpot {
  /// Front first: homes, then cats, then fliers, then fields; within a
  /// kind in the order the pins came, so the freshest sighting leads.
  final List<MapPin> pins;

  PinSpot(this.pins);

  MapPin get front => pins.first;
  double get lat => front.lat;
  double get lon => front.lon;
  bool get merged => pins.length > 1;

  /// "Eckesloft +2" for a shared spot, the name alone for a single one.
  String get label => merged ? '${front.name} +${pins.length - 1}' : front.name;
}

/// Groups pins that lie within [meters] of each other. A pin joins the
/// first spot whose first pin is that close, so a spot never drifts
/// along a chain of neighbours.
List<PinSpot> groupPins(Iterable<MapPin> pins, {double meters = spotMeters}) {
  final spots = <List<MapPin>>[];
  for (final pin in pins) {
    List<MapPin>? near;
    for (final spot in spots) {
      final anchor = spot.first;
      if (haversineMeters(anchor.lat, anchor.lon, pin.lat, pin.lon) <= meters) {
        near = spot;
        break;
      }
    }
    if (near == null) {
      spots.add([pin]);
    } else {
      near.add(pin);
    }
  }
  return [
    for (final spot in spots)
      PinSpot([...spot]..sort((a, b) => a.kind.index.compareTo(b.kind.index)))
  ];
}
