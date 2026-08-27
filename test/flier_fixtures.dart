import 'dart:ui';

import 'package:catlog/src/flier_ocr.dart';

FlierLine flierLine(
  String text,
  double left,
  double top, {
  double width = 300,
  double height = 30,
}) => FlierLine(text, Rect.fromLTWH(left, top, width, height));

/// The TASSO poster for Hugo, in the order ML Kit returned it: the
/// label block first, the value block after, name and body text
/// around them.
List<FlierLine> hugoLines() {
  const labels = [
    'Suchdienstnummer',
    'Tierart, Geschlecht, Kastriert',
    'Rasse',
    'Farbe',
    'Geburtsdatum',
    'Kennzeichnung',
    'Verlustdatum',
    'Verlustort',
  ];
  const values = [
    'S2983764',
    'Katze, männich, kastriert',
    'Europäische Langhaarkatze',
    'braun',
    '26.05.2024',
    'Das Tier ist gechipt.',
    '05.06.2025',
    '04207 Leipzig, Colberger Weg. Deutschland',
  ];
  return [
    flierLine('GESUCHT!', 450, 250, width: 900, height: 150),
    for (var i = 0; i < labels.length; i++)
      flierLine(labels[i], 130, 990 + 55.0 * i, width: 380),
    flierLine('Kater HUGO', 560, 890, width: 300, height: 60),
    for (var i = 0; i < values.length; i++)
      flierLine(values[i], 540, 993 + 55.0 * i, width: 600),
    flierLine(
      'TASSO-Tipp: Katzen werden oft versehentlich eingesperrt. Werfen Sie deshalb bitte auch einen Blick in',
      130,
      1330,
      width: 1200,
    ),
    flierLine(
      'Ihre Garagen, Kellerräume und Gartenhäuser.',
      130,
      1360,
      width: 500,
    ),
    flierLine('24-Stunden-Notruf-Nummer:', 300, 1690),
    flierLine('06190/ 93 73 00', 300, 1730, width: 400, height: 50),
    flierLine(
      'Fax: 0 61 90/93 74 00 info@tasso.net www.tasso.net',
      400,
      1920,
      width: 700,
    ),
  ];
}
