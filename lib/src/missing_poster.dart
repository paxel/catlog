import 'dart:math' as math;
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_fonts.dart';

/// A poster for a lamp post: read from across the street, and still
/// after rain. One or two photos on top, the headline and the name as
/// large as the lines below leave room for, the ticked lines of the
/// record, the phone in a black band, Looks and the standing text small
/// above a row of codes. Black on white only, bold throughout, no thin
/// strokes, no tints.
class PosterContent {
  final String headline;
  final String name;

  /// Up to two, side by side when two.
  final List<PosterPhoto> photos;

  /// "Label: value" lines, in the order ticked; the first is usually
  /// "Missing since: date".
  final List<String> lines;

  /// Goes into the black band.
  final String? phone;
  final String? looks;
  final String? extra;
  final String standing;

  /// The bottom row: the cat(a)log code, a registry link per ID, a map
  /// link per location.
  final List<PosterCode> codes;

  const PosterContent({
    required this.headline,
    required this.name,
    required this.standing,
    this.photos = const [],
    this.lines = const [],
    this.phone,
    this.looks,
    this.extra,
    this.codes = const [],
  });
}

/// A photo and the part of it that shows: a rectangle in fractions of
/// the picture, (0, 0, 1, 1) for all of it. The frame keeps the
/// rectangle's aspect, so the picture is never squeezed.
class PosterPhoto {
  final Uint8List bytes;
  final double x;
  final double y;
  final double w;
  final double h;

  const PosterPhoto(
    this.bytes, {
    this.x = 0,
    this.y = 0,
    this.w = 1,
    this.h = 1,
  });
}

/// One scannable code with its caption.
class PosterCode {
  final String data;
  final String caption;

  const PosterCode(this.data, this.caption);
}

/// Beyond this the QR stops scanning; the poster then goes without.
const posterQrLimit = 2300;

const _page = PdfPageFormat.a4;
const _margin = 28.0;
const _photoRowHeight = 230.0;
const _photoGap = 10.0;

/// The width the poster's content spans.
double get posterWidth => _page.width - 2 * _margin;

/// Width by height of photo frame [index] when [count] photos show.
/// The screen frames the picture with the same ratio, so what the
/// keeper sees in the frame is what prints.
double posterFrameAspect(int count, int index) => count <= 1
    ? posterWidth / _photoRowHeight
    : ((posterWidth - _photoGap) / 2) / _photoRowHeight;

/// The headline and name sizes that leave room for [lines]: the
/// headline gives first, the name second, and the lines shrink only
/// after both stand at their smallest.
({double headline, double name}) posterTitleSizes({
  required List<String> lines,
  required bool photos,
  required bool phone,
  required bool codes,
}) {
  const headlineMax = 62.0, headlineMin = 38.0;
  const nameMax = 96.0, nameMin = 52.0;
  var spent = 0.0;
  if (photos) spent += _photoRowHeight + _photoGap;
  spent += 18; // gaps around the titles
  if (phone) spent += 64 + 10;
  spent += 14 + 96 + (codes ? 132 : 0); // looks, standing, code row
  final need = lines.fold<double>(
    0,
    (sum, l) => sum + 26 * (l.length > 42 ? 2 : 1),
  );
  final room = _page.height - 2 * _margin - spent - need;
  var headline = headlineMax;
  var name = nameMax;
  var short = headline + name - room;
  if (short > 0) {
    final give = math.min(short, headlineMax - headlineMin);
    headline -= give;
    short -= give;
  }
  if (short > 0) name -= math.min(short, nameMax - nameMin);
  return (headline: headline, name: name);
}

/// The poster as one A4 page.
pw.Document missingPosterPdf(PosterContent c, PdfFonts fonts) {
  final doc = pw.Document(
    title: '${c.name} — ${c.headline}',
    theme: fonts.theme,
  );
  final width = posterWidth;
  final bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);
  final sizes = posterTitleSizes(
    lines: [...c.lines, if ((c.extra ?? '').isNotEmpty) c.extra!],
    photos: c.photos.isNotEmpty,
    phone: c.phone != null,
    codes: c.codes.isNotEmpty,
  );

  pw.Widget big(
    String text,
    double size, {
    pw.BoxFit fit = pw.BoxFit.scaleDown,
  }) => pw.FittedBox(
    fit: fit,
    alignment: pw.Alignment.centerLeft,
    child: pw.Text(
      text,
      style: bold.copyWith(fontSize: size, color: PdfColors.black),
      maxLines: 1,
    ),
  );

  pw.Widget frame(PosterPhoto p, double fw, double fh) {
    // The frame shows the rectangle (x, y, w, h) of the picture: draw
    // the whole picture at the size that makes the rectangle fill the
    // frame, shifted so the rectangle's corner sits at the frame's.
    final drawnW = fw / p.w;
    final drawnH = fh / p.h;
    return pw.ClipRect(
      child: pw.SizedBox(
        width: fw,
        height: fh,
        child: pw.Stack(
          children: [
            pw.Positioned(
              left: -p.x * drawnW,
              top: -p.y * drawnH,
              child: pw.Image(
                pw.MemoryImage(p.bytes),
                width: drawnW,
                height: drawnH,
                fit: pw.BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final photos = c.photos.take(2).toList();
  final lines = [...c.lines, if ((c.extra ?? '').isNotEmpty) c.extra!];
  final codeSize = c.codes.isEmpty
      ? 0.0
      : math.min(120.0, (width - 14 * (c.codes.length - 1)) / c.codes.length);

  doc.addPage(
    pw.Page(
      pageFormat: _page,
      margin: const pw.EdgeInsets.all(_margin),
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          if (photos.length == 1)
            frame(photos.first, width, _photoRowHeight)
          else if (photos.length == 2)
            pw.Row(
              children: [
                frame(photos[0], (width - _photoGap) / 2, _photoRowHeight),
                pw.SizedBox(width: _photoGap),
                frame(photos[1], (width - _photoGap) / 2, _photoRowHeight),
              ],
            ),
          if (photos.isNotEmpty) pw.SizedBox(height: _photoGap),
          pw.SizedBox(
            width: width,
            height: sizes.headline + 2,
            child: big(c.headline, sizes.headline),
          ),
          // The name is what the poster is for: it takes the width, grown
          // or shrunk, up to the band's height.
          pw.SizedBox(
            width: width,
            height: sizes.name,
            child: big(c.name, sizes.name - 6, fit: pw.BoxFit.contain),
          ),
          pw.SizedBox(height: 8),
          // The lines in the middle give way; the phone band and the
          // footer below keep their place whatever the lines do.
          // An empty middle would scale nothing by nothing: a plain gap.
          if (lines.isEmpty)
            pw.Spacer()
          else
            pw.Expanded(
              child: pw.FittedBox(
                fit: pw.BoxFit.scaleDown,
                alignment: pw.Alignment.topLeft,
                child: pw.SizedBox(
                  width: width,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      for (final line in lines)
                        pw.Text(
                          line,
                          style: bold.copyWith(fontSize: 20),
                          maxLines: 2,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          pw.SizedBox(height: 10),
          if (c.phone != null)
            pw.Container(
              color: PdfColors.black,
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              child: pw.SizedBox(
                height: 48,
                child: pw.FittedBox(
                  fit: pw.BoxFit.scaleDown,
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    c.phone!,
                    style: bold.copyWith(fontSize: 46, color: PdfColors.white),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          pw.SizedBox(height: 14),
          if (c.looks != null)
            pw.Text(c.looks!, style: bold.copyWith(fontSize: 13), maxLines: 3),
          pw.SizedBox(height: 6),
          pw.Text(c.standing, style: bold.copyWith(fontSize: 13), maxLines: 3),
          if (c.codes.isNotEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                for (final (i, code) in c.codes.indexed) ...[
                  if (i > 0) pw.SizedBox(width: 14),
                  pw.SizedBox(
                    width: codeSize,
                    child: pw.Column(
                      children: [
                        pw.BarcodeWidget(
                          barcode: pw.Barcode.qrCode(),
                          data: code.data,
                          width: codeSize,
                          height: codeSize,
                          color: PdfColors.black,
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          code.caption,
                          style: const pw.TextStyle(fontSize: 8),
                          maxLines: 2,
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    ),
  );
  return doc;
}
