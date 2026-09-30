import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

/// Everything on one spot of the map shares one pin: homes, cats,
/// fliers and own location fields within 20 m of each other.
void main() {
  MapPin pin(PinKind kind, String name, double lat, double lon) => MapPin(
        kind: kind,
        id: '${kind.name}:$name',
        name: name,
        lat: lat,
        lon: lon,
      );

  test('things within 20 m share a spot, others keep their own', () {
    final spots = groupPins([
      pin(PinKind.cat, 'Hahn', 49.4264, 6.8376),
      // Five metres away: the same spot.
      pin(PinKind.cat, 'Schneeweißchen', 49.42644, 6.8376),
      // Three hundred metres away: another.
      pin(PinKind.home, 'Barn', 49.429, 6.8376),
    ]);
    expect(spots, hasLength(2));
    expect(spots[0].pins.map((p) => p.name), ['Hahn', 'Schneeweißchen']);
    expect(spots[0].label, 'Hahn +1');
    expect(spots[1].label, 'Barn');
    expect(spots[1].merged, isFalse);
  });

  test('the home takes the front, then cats, fliers and fields', () {
    final spots = groupPins([
      pin(PinKind.field, 'Miezi', 52.52, 13.40),
      pin(PinKind.cat, 'Oskar', 52.52001, 13.40),
      pin(PinKind.flier, 'Luna', 52.52002, 13.40),
      pin(PinKind.home, 'Eckesloft', 52.52003, 13.40),
      pin(PinKind.home, 'Patricks Loft', 52.52004, 13.40),
    ]);
    expect(spots, hasLength(1));
    final spot = spots.single;
    expect(spot.pins.map((p) => p.name),
        ['Eckesloft', 'Patricks Loft', 'Oskar', 'Luna', 'Miezi']);
    expect(spot.label, 'Eckesloft +4');
    // The spot stands where the front thing is.
    expect(spot.lat, 52.52003);
  });

  test('a spot never drifts along a chain of neighbours', () {
    // 15 m apart each: A and B share, C is 30 m from A and starts anew.
    final spots = groupPins([
      pin(PinKind.cat, 'A', 52.52, 13.40),
      pin(PinKind.cat, 'B', 52.520135, 13.40),
      pin(PinKind.cat, 'C', 52.52027, 13.40),
    ]);
    expect(spots.map((s) => s.label), ['A +1', 'C']);
  });
}
