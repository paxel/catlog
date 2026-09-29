// Builds the app icon files from a raster source (a painted picture,
// not the old SVG): assets/icon/icon.png (1024, opaque), icon_256.png,
// icon_fg.png, the Android adaptive foreground with the artwork scaled
// into the launcher's safe circle on the picture's own background
// colour, and under assets/icon/store/ what the Play Console asks for
// by hand: the 512 px icon and the 1024 × 500 feature graphic. The App
// Store takes its 1024 px icon from the iOS build.
//
//   dart run tool/icon_from_raster.dart <source> [--scale 0.8] [--shift 0.08] [--preview DIR]
//
// --shift moves the artwork down by that fraction of the canvas: the
// cats' heads sit at the top of the picture, and the circle the
// launcher cuts is centred, so without it the ears are gone.
//
// The source is cropped to a centred square. With --preview, circle
// masks at 48 and 192 px land in DIR so the launcher look can be judged
// before `dart run flutter_launcher_icons` fans the files out.
import 'dart:io';

import 'package:image/image.dart' as img;

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('usage: icon_from_raster.dart <source> [--scale S] [--preview DIR]');
    exit(2);
  }
  var scale = 0.8;
  var shift = 0.08;
  String? preview;
  for (var i = 1; i < args.length; i++) {
    if (args[i] == '--scale') scale = double.parse(args[++i]);
    if (args[i] == '--shift') shift = double.parse(args[++i]);
    if (args[i] == '--preview') preview = args[++i];
  }
  final source = img.decodeImage(File(args[0]).readAsBytesSync())!;
  final side = source.width < source.height ? source.width : source.height;
  final square = img.copyCrop(
    source,
    x: (source.width - side) ~/ 2,
    y: (source.height - side) ~/ 2,
    width: side,
    height: side,
  );
  // The background the launcher fills around the artwork: the corner
  // of the picture, which is its own plain ground.
  final corner = square.getPixel(4, 4);
  final bg = img.ColorRgb8(corner.r.toInt(), corner.g.toInt(), corner.b.toInt());
  final hex = '#${corner.r.toInt().toRadixString(16).padLeft(2, '0')}'
      '${corner.g.toInt().toRadixString(16).padLeft(2, '0')}'
      '${corner.b.toInt().toRadixString(16).padLeft(2, '0')}'.toUpperCase();

  final full = img.copyResize(square, width: 1024, height: 1024,
      interpolation: img.Interpolation.cubic);
  final opaque = full.convert(numChannels: 3);
  File('assets/icon/icon.png').writeAsBytesSync(img.encodePng(opaque));
  File('assets/icon/icon_256.png').writeAsBytesSync(img.encodePng(
      img.copyResize(opaque, width: 256, height: 256,
          interpolation: img.Interpolation.cubic)));

  // The adaptive foreground: the artwork scaled down on its own ground,
  // so the heads sit inside the circle the launcher cuts (the middle
  // two thirds of the canvas).
  final inner = (1024 * scale).round();
  final art = img.copyResize(square, width: inner, height: inner,
      interpolation: img.Interpolation.cubic);
  final fg = img.Image(width: 1024, height: 1024, numChannels: 4);
  img.fill(fg, color: img.ColorRgba8(bg.r.toInt(), bg.g.toInt(), bg.b.toInt(), 255));
  img.compositeImage(fg, art,
      dstX: (1024 - inner) ~/ 2, dstY: (1024 - inner) ~/ 2 + (1024 * shift).round());
  File('assets/icon/icon_fg.png').writeAsBytesSync(img.encodePng(fg));

  // The Play Console's own uploads: the 512 px icon, and the feature
  // graphic with the artwork centred on the picture's ground.
  Directory('assets/icon/store').createSync(recursive: true);
  File('assets/icon/store/play-icon-512.png').writeAsBytesSync(img.encodePng(
      img.copyResize(opaque, width: 512, height: 512,
          interpolation: img.Interpolation.cubic)));
  final feature = img.Image(width: 1024, height: 500, numChannels: 3);
  img.fill(feature, color: bg);
  final featureArt = img.copyResize(square, width: 460, height: 460,
      interpolation: img.Interpolation.cubic);
  img.compositeImage(feature, featureArt, dstX: (1024 - 460) ~/ 2, dstY: 20);
  File('assets/icon/store/play-feature-1024x500.png')
      .writeAsBytesSync(img.encodePng(feature));

  if (preview != null) {
    Directory(preview).createSync(recursive: true);
    for (final size in [48, 192]) {
      // What the launcher shows: the middle 72/108 of the canvas, in a circle.
      final cut = img.copyCrop(fg, x: 171, y: 171, width: 682, height: 682);
      final scaled = img.copyResize(cut, width: size, height: size,
          interpolation: img.Interpolation.cubic);
      final out = img.Image(width: size, height: size, numChannels: 4);
      final r = size / 2;
      for (var y = 0; y < size; y++) {
        for (var x = 0; x < size; x++) {
          final dx = x + 0.5 - r, dy = y + 0.5 - r;
          if (dx * dx + dy * dy <= r * r) out.setPixel(x, y, scaled.getPixel(x, y));
        }
      }
      File('$preview/circle_$size.png').writeAsBytesSync(img.encodePng(out));
    }
    File('$preview/icon_256.png').writeAsBytesSync(img.encodePng(
        img.copyResize(opaque, width: 256, height: 256)));
  }
  stdout.writeln('background $hex, scale $scale, shift $shift, '
      'source ${source.width}x${source.height} cropped to $side');
}
