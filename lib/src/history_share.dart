import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'l10n.dart';

/// One line of a history as the PDF and the clipboard get it: when,
/// what, who, and a remark for a hidden or late value.
typedef HistoryLine = ({String when, String value, String who, String note});

/// The history as a PDF: a title line, the name under it, one table
/// row per line. A4 portrait, pages as needed.
pw.Document historyPdf({
  required String title,
  required String subtitle,
  required List<HistoryLine> lines,
  required String whenHeader,
  required String valueHeader,
  required String whoHeader,
  pw.ThemeData? theme,
  String? warning,
}) {
  final doc = pw.Document(title: '$title — cat(a)log', theme: theme);
  final hasNotes = lines.any((l) => l.note.isNotEmpty);
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          subtitle,
          style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
        ),
        if (warning != null) ...[
          pw.SizedBox(height: 6),
          pw.Text(
            warning,
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.red800),
          ),
        ],
        pw.SizedBox(height: 14),
        pw.TableHelper.fromTextArray(
          headers: [whenHeader, valueHeader, whoHeader, if (hasNotes) ''],
          data: [
            for (final l in lines)
              [l.when, l.value, l.who, if (hasNotes) l.note],
          ],
          headerStyle: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
          cellStyle: const pw.TextStyle(fontSize: 10),
          cellAlignment: pw.Alignment.topLeft,
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
          border: const pw.TableBorder(
            horizontalInside: pw.BorderSide(
              color: PdfColors.grey400,
              width: .5,
            ),
          ),
        ),
      ],
      footer: (context) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 8),
        child: pw.Text(
          'cat(a)log · ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
        ),
      ),
    ),
  );
  return doc;
}

/// The lines as plain text for the clipboard: title, name, one line
/// each with a middle dot between the parts.
String historyText(String title, String subtitle, List<HistoryLine> lines) => [
  '$title · $subtitle',
  for (final l in lines)
    [l.when, l.value, l.who, if (l.note.isNotEmpty) l.note].join(' · '),
].join('\n');

/// Puts [text] on the clipboard and says so.
Future<void> copyText(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) return;
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(context.t.copied)));
}

/// Hands the PDF to the phone's share sheet under [fileName].
Future<void> sharePdf(pw.Document doc, String fileName) async =>
    Printing.sharePdf(bytes: await doc.save(), filename: fileName);

/// Hands the PDF to the system print dialog.
Future<void> printPdf(pw.Document doc) async =>
    Printing.layoutPdf(onLayout: (_) => doc.save());
