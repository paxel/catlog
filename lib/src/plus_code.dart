/// Open Location Code ("Plus Code") encoder — the printable, offline
/// answer to "where" on a Card: no service, no license, any maps app
/// understands it. 10-digit code ≈ 14 m × 14 m.
String encodePlusCode(double latitude, double longitude) {
  const alphabet = '23456789CFGHJMPQRVWX';
  const resolutions = [20.0, 1.0, 0.05, 0.0025, 0.000125];
  final lat = (latitude.clamp(-90.0, 90.0)) + 90.0;
  var lon = longitude;
  while (lon < -180) {
    lon += 360;
  }
  while (lon >= 180) {
    lon -= 360;
  }
  lon += 180.0;
  final sb = StringBuffer();
  for (var i = 0; i < resolutions.length; i++) {
    final res = resolutions[i];
    // The epsilon keeps exact grid points from flooring one cell low.
    sb.write(alphabet[((lat / res) + 1e-9).floor() % 20]);
    sb.write(alphabet[((lon / res) + 1e-9).floor() % 20]);
    if (i == 3) sb.write('+');
  }
  return sb.toString();
}
