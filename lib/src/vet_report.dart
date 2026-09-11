import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'field_labels.dart';
import 'l10n.dart';
import 'pdf_fonts.dart';
import 'screens/clowder_card_screen.dart' show pdfThumbnail;
import 'screens/field_graph_screen.dart';

/// The report a vet reads: a patient summary, the chosen entries as a
/// timeline oldest first, one colour per field, and a curve per number
/// field. What goes in is chosen on the report page.

/// The colours the fields wear, in the order the fields are listed.
const reportColours = [
  0xffd32f2f,
  0xff1976d2,
  0xff388e3c,
  0xfff57c00,
  0xff7b1fa2,
  0xff00838f,
  0xffc2185b,
  0xff5d4037,
];

/// The colour of the [index]th field, wrapping round.
int reportColour(int index) => reportColours[index % reportColours.length];

/// The fields a cat has values for, in the catalog's field order.
List<FieldDef> reportableFields(CatalogStore store, String catId) => [
  for (final def in store.fieldDefs(scope: FieldScope.cat))
    if (store
        .fieldHistory(catId, def.key)
        .any((e) => !e.reminder && e.value != null))
      def,
];

/// The entries of [fields] on [catId] between [from] and [to] (days,
/// inclusive), oldest first: facts only, hidden values out.
List<Entry> reportEntries(
  CatalogStore store,
  String catId,
  Iterable<FieldDef> fields,
  DateTime from,
  DateTime to,
) {
  final end = DateTime(to.year, to.month, to.day + 1);
  final start = DateTime(from.year, from.month, from.day);
  final rows = <Entry>[
    for (final def in fields)
      for (final e in store.fieldHistory(catId, def.key))
        if (!e.reminder && e.value != null)
          if (!e.date.toLocal().isBefore(start) &&
              e.date.toLocal().isBefore(end))
            e,
  ];
  rows.sort((a, b) => a.date.compareTo(b.date));
  return rows;
}

/// A curve as a picture for the PDF: the app's own graph painter drawn
/// off screen. Null without two points.
Future<Uint8List?> curvePng(
  List<GraphPoint> points,
  DateTime from,
  DateTime to,
  int colour,
  String locale,
) async {
  if (points.length < 2) return null;
  const size = Size(1200, 640);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);
  GraphPainter(
    points: points,
    from: from,
    to: to,
    appointments: const [],
    lineColor: Color(colour),
    labelStyle: const TextStyle(color: Colors.black, fontSize: 22),
    tickColor: Colors.black45,
    format: (v) =>
        v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1),
    dateFormat: (d) => DateFormat.MMMd(locale).format(d),
  ).paint(canvas, size);
  final image = await recorder.endRecording().toImage(
    size.width.toInt(),
    size.height.toInt(),
  );
  try {
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data?.buffer.asUint8List();
  } finally {
    image.dispose();
  }
}

/// A cat's age from its birth date, in years and months as the app
/// says them; null without a birth date.
String? ageText(AppLocalizations t, String? birth, DateTime today) {
  if (birth == null) return null;
  final born = PartialDate.parse(birth)?.earliest;
  if (born == null) return null;
  var months = (today.year - born.year) * 12 + today.month - born.month;
  if (today.day < born.day) months--;
  if (months < 0) return null;
  final years = months ~/ 12;
  final rest = months % 12;
  return [
    if (years > 0) '$years ${t.unitYears}',
    if (rest > 0 || years == 0) '$rest ${t.unitMonths}',
  ].join(' ');
}

/// One curve page's material.
typedef ReportCurve = ({FieldDef def, Uint8List png});

/// The report as a PDF.
pw.Document vetReportPdf({
  required AppLocalizations t,
  required CatalogStore store,
  required String catId,
  required List<FieldDef> fields,
  required List<Entry> entries,
  required List<ReportCurve> curves,
  required bool summary,
  required String locale,
  required PdfFonts fonts,
  DateTime? today,
}) {
  final now = today ?? DateTime.now();
  final name = store.current(catId, Keys.name) ?? t.unnamed;
  final doc = pw.Document(
    title: '$name — ${t.vetReportTitle}',
    theme: fonts.theme,
  );
  final colourOf = {
    for (final (i, def) in fields.indexed)
      def.key: PdfColor.fromInt(reportColour(i)),
  };
  final defOf = {for (final def in fields) def.key: def};
  final day = DateFormat.yMd(locale);
  final small = const pw.TextStyle(fontSize: 8, color: PdfColors.grey700);

  pw.Widget legend() => pw.Wrap(
    spacing: 10,
    runSpacing: 4,
    children: [
      for (final def in fields)
        pw.Row(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Container(
              width: 8,
              height: 8,
              decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle,
                color: colourOf[def.key],
              ),
            ),
            pw.SizedBox(width: 4),
            pw.Text(
              fieldDefName(t, def),
              style: const pw.TextStyle(fontSize: 9),
            ),
          ],
        ),
    ],
  );

  List<pw.Widget> summaryPage() {
    String? value(String slug) {
      final v = store.current(catId, Keys.userField(slug));
      return v == null ? null : valueLabel(t, store, Keys.userField(slug), v);
    }

    final hash = store.profileImage(catId);
    final photo = hash == null ? null : store.imageBytes(hash);
    final clowder = store.current(catId, Keys.clowder);
    String? home(String slug) =>
        clowder == null ? null : store.current(clowder, Keys.userField(slug));
    final born = store.current(catId, Keys.userField('birthdate'));
    final rows = <(String, String?)>[
      (t.starterSpecies, value('species')),
      (t.starterBreed, value('breed')),
      (t.starterGender, value('gender')),
      (t.starterNeutered, value('neutered')),
      (t.starterBirthdate, value('birthdate')),
      (t.ageLabel, ageText(t, born, now)),
      (t.starterChipId, value('chipid')),
      (t.starterWeight, value('weight')),
      (t.starterLooks, value('looks')),
      if (clowder != null) (t.clowderLabel, store.current(clowder, Keys.name)),
      (t.vetReportOwner, home('responsible')),
      (t.starterAddress, home('address')),
      (t.starterPhone, home('phone')),
      (t.starterEmail, home('email')),
    ];
    return [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (photo != null)
            pw.Padding(
              padding: const pw.EdgeInsets.only(right: 16),
              child: pw.ClipRRect(
                horizontalRadius: 8,
                verticalRadius: 8,
                child: pw.Image(
                  pw.MemoryImage(pdfThumbnail(photo)),
                  width: 120,
                  height: 120,
                  fit: pw.BoxFit.cover,
                ),
              ),
            ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  name,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(t.vetReportSummary, style: small),
              ],
            ),
          ),
        ],
      ),
      pw.SizedBox(height: 14),
      for (final (label, v) in rows)
        if (v != null && v.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 130,
                  child: pw.Text(
                    label,
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey700,
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(v, style: const pw.TextStyle(fontSize: 11)),
                ),
              ],
            ),
          ),
      pw.SizedBox(height: 18),
      pw.Text(t.vetReportLegend, style: small),
      pw.SizedBox(height: 4),
      legend(),
    ];
  }

  pw.TableRow timelineRow(Entry e, bool firstOfDay) {
    final colour = colourOf[e.field] ?? PdfColors.grey;
    final def = defOf[e.field];
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 6, right: 6),
          child: pw.Text(
            firstOfDay ? day.format(e.date.toLocal()) : '',
            textAlign: pw.TextAlign.right,
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ),
        // The rail: a line down the row with the field's dot on it.
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 9),
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(color: PdfColors.grey400, width: 1.5),
              ),
            ),
            alignment: pw.Alignment.topLeft,
            child: pw.Transform.translate(
              offset: const PdfPoint(-5.75, -7),
              child: pw.Container(
                width: 10,
                height: 10,
                decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.circle,
                  color: colour,
                ),
              ),
            ),
          ),
        ),
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 6, left: 6),
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400, width: .5),
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                valueLabel(t, store, e.field, e.value),
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '${def == null ? fieldLabel(t, store, e.field) : fieldDefName(t, def)} · ${e.author}',
                style: small,
              ),
            ],
          ),
        ),
      ],
    );
  }

  final timelineRows = <pw.TableRow>[];
  String? lastDay;
  for (final e in entries) {
    final key = day.format(e.date.toLocal());
    timelineRows.add(timelineRow(e, key != lastDay));
    lastDay = key;
  }

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      footer: (context) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 8),
        child: pw.Text(
          'cat(a)log · $name · ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
        ),
      ),
      build: (context) => [
        if (summary) ...[...summaryPage(), pw.NewPage()],
        pw.Text(
          summary ? t.timeline : '$name · ${t.timeline}',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        if (!summary) ...[pw.SizedBox(height: 4), legend()],
        if (!fonts.complete) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            t.pdfFontMissing,
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.red800),
          ),
        ],
        pw.SizedBox(height: 10),
        pw.Table(
          columnWidths: const {
            0: pw.FixedColumnWidth(64),
            1: pw.FixedColumnWidth(20),
            2: pw.FlexColumnWidth(),
          },
          defaultVerticalAlignment: pw.TableCellVerticalAlignment.full,
          children: timelineRows,
        ),
        for (final c in curves) ...[
          pw.NewPage(),
          pw.Text(
            '${fieldDefName(t, c.def)} · ${t.vetReportCurves}',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Image(
            pw.MemoryImage(c.png),
            width: PdfPageFormat.a4.availableWidth,
          ),
        ],
      ],
    ),
  );
  return doc;
}
