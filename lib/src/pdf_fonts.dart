import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// The type every PDF the app writes is set in. Noto Sans travels with
/// the app and covers Latin, Greek and Cyrillic; Arabic, Hebrew, Farsi,
/// Japanese and Chinese need a face of their own, fetched from Google
/// Fonts the first time a PDF is made in that language and kept on the
/// phone. Offline on that first time, the page is set in Noto Sans and
/// [complete] says the letters of that script are missing.
class PdfFonts {
  final pw.Font regular;
  final pw.Font bold;

  /// The script's own face, when the language needs one and it came.
  final pw.Font? scriptRegular;
  final pw.Font? scriptBold;

  const PdfFonts(
    this.regular,
    this.bold, {
    this.scriptRegular,
    this.scriptBold,
    required this.complete,
  });

  /// False when the language needs a fetched face and it did not come.
  final bool complete;

  pw.ThemeData get theme => pw.ThemeData.withFont(
    base: scriptRegular ?? regular,
    bold: scriptBold ?? bold,
    fontFallback: [regular, bold],
  );
}

pw.Font? _regular;
pw.Font? _bold;

/// The bundled faces, read once.
Future<(pw.Font, pw.Font)> _bundled() async {
  _regular ??= pw.Font.ttf(await rootBundle.load('fonts/NotoSans-Regular.ttf'));
  _bold ??= pw.Font.ttf(await rootBundle.load('fonts/NotoSans-Bold.ttf'));
  return (_regular!, _bold!);
}

/// Which fetched face a language needs, if any.
(Future<pw.Font> Function(), Future<pw.Font> Function())? _scriptFaces(
  String language,
) => switch (language) {
  'ar' || 'fa' => (
    PdfGoogleFonts.notoSansArabicRegular,
    PdfGoogleFonts.notoSansArabicBold,
  ),
  'he' => (
    PdfGoogleFonts.notoSansHebrewRegular,
    PdfGoogleFonts.notoSansHebrewBold,
  ),
  'ja' => (PdfGoogleFonts.notoSansJPRegular, PdfGoogleFonts.notoSansJPBold),
  'zh' => (PdfGoogleFonts.notoSansSCRegular, PdfGoogleFonts.notoSansSCBold),
  _ => null,
};

/// The fonts for a PDF in [language] (a locale's language code).
Future<PdfFonts> pdfFontsFor(String language) async {
  final (regular, bold) = await _bundled();
  final faces = _scriptFaces(language);
  if (faces == null) return PdfFonts(regular, bold, complete: true);
  try {
    final scriptRegular = await faces.$1();
    final scriptBold = await faces.$2();
    // Offline, the fetch does not throw: it hands back Helvetica and
    // says so in the log. That is not the script's face.
    if (_isFallback(scriptRegular) || _isFallback(scriptBold)) {
      return PdfFonts(regular, bold, complete: false);
    }
    return PdfFonts(
      regular,
      bold,
      scriptRegular: scriptRegular,
      scriptBold: scriptBold,
      complete: true,
    );
  } catch (_) {
    return PdfFonts(regular, bold, complete: false);
  }
}

bool _isFallback(pw.Font font) => font.fontName.startsWith('Helvetica');
