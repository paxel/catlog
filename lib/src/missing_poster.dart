import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_fonts.dart';

/// A poster for a lamp post: read from across the street, and still
/// after rain. Photo on top, the headline and the name as large as the
/// width allows, two short lines, the phone in a black band, the rest
/// small at the bottom. Black on white only, bold throughout, no thin
/// strokes, no tints.
class PosterContent {
  final String headline;
  final String name;
  final Uint8List? photo;

  /// "Missing since" and its date, as one line.
  final String? since;

  /// "Last seen near" and the place, as one line.
  final String? place;
  final String? phone;
  final String? email;
  final String? looks;
  final String? extra;
  final String standing;

  /// The QR payload another cat(a)log reads; null for no code.
  final String? qr;
  final String qrCaption;

  const PosterContent({
    required this.headline,
    required this.name,
    required this.standing,
    required this.qrCaption,
    this.photo,
    this.since,
    this.place,
    this.phone,
    this.email,
    this.looks,
    this.extra,
    this.qr,
  });
}

/// Beyond this the QR stops scanning; the poster then goes without.
const posterQrLimit = 2300;

/// The poster as one A4 page.
pw.Document missingPosterPdf(PosterContent c, PdfFonts fonts) {
  final doc = pw.Document(
    title: '${c.name} — ${c.headline}',
    theme: fonts.theme,
  );
  const page = PdfPageFormat.a4;
  final width = page.availableWidth;
  final bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);

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

  doc.addPage(
    pw.Page(
      pageFormat: page,
      margin: const pw.EdgeInsets.all(28),
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          if (c.photo != null)
            pw.SizedBox(
              height: page.availableHeight * 0.30,
              child: pw.Image(
                pw.MemoryImage(c.photo!),
                fit: pw.BoxFit.cover,
                width: width,
              ),
            ),
          pw.SizedBox(height: 10),
          pw.SizedBox(width: width, height: 62, child: big(c.headline, 60)),
          // The name is what the poster is for: it takes the width, grown
          // or shrunk, up to the band's height.
          pw.SizedBox(
            width: width,
            height: 96,
            child: big(c.name, 90, fit: pw.BoxFit.contain),
          ),
          pw.SizedBox(height: 8),
          // The lines in the middle give way; the phone band and the
          // footer below keep their place whatever the lines do.
          // An empty middle would scale nothing by nothing: a plain gap.
          if (c.since == null && c.place == null && (c.extra ?? '').isEmpty)
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
                      if (c.since != null)
                        pw.Text(c.since!, style: bold.copyWith(fontSize: 20)),
                      if (c.place != null)
                        pw.Text(
                          c.place!,
                          style: bold.copyWith(fontSize: 20),
                          maxLines: 2,
                        ),
                      if (c.extra != null && c.extra!.isNotEmpty)
                        pw.Text(
                          c.extra!,
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
          if (c.email != null)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 6),
              child: pw.Text(
                c.email!,
                style: bold.copyWith(fontSize: 18),
                maxLines: 1,
              ),
            ),
          pw.SizedBox(height: 14),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (c.looks != null)
                      pw.Text(
                        c.looks!,
                        style: bold.copyWith(fontSize: 13),
                        maxLines: 3,
                      ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      c.standing,
                      style: bold.copyWith(fontSize: 13),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              if (c.qr != null) ...[
                pw.SizedBox(width: 14),
                pw.Column(
                  children: [
                    pw.BarcodeWidget(
                      barcode: pw.Barcode.qrCode(),
                      data: c.qr!,
                      width: 130,
                      height: 130,
                      color: PdfColors.black,
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      c.qrCaption,
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    ),
  );
  return doc;
}
