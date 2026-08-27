import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';

/// One recognized line of text and where it sits on the photo. The box
/// is what makes column layouts readable: a label and its value share a
/// height, not a position in the text.
class FlierLine {
  final String text;
  final Rect box;

  const FlierLine(this.text, this.box);

  @override
  String toString() => 'FlierLine($text, $box)';
}

/// What text recognition read off a flier photo: the flat text (block
/// after block, the way the recognizer orders it) and every line with
/// its box.
class FlierText {
  final String text;
  final List<FlierLine> lines;

  const FlierText(this.text, this.lines);
}

/// Codes found on a flier photo, or the reason none could be looked
/// for. [error] is the reader's own message, verbatim — a flier without
/// a code and a reader that broke must not look alike (#32).
class FlierCodes {
  final List<String> codes;
  final String? error;

  const FlierCodes(this.codes, {this.error});

  static const none = FlierCodes([]);
}

/// On-device text recognition for flier photos. Only Android and iOS
/// ship ML Kit — everywhere else this returns null and the user types
/// the flier text themselves (#32).
///
/// Script limitation: the bundled model reads LATIN script only. ML Kit
/// offers optional packs for Chinese, Devanagari, Japanese, and Korean
/// (separate native dependencies, a few MB each — not included), and has
/// no support at all for Cyrillic, Greek, Arabic, or Hebrew. Fliers in
/// unsupported scripts fall back to manual typing.
Future<FlierText?> recognizeFlierText(Uint8List bytes) async {
  if (!Platform.isAndroid && !Platform.isIOS) return null;
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/flier-ocr.jpg');
  await file.writeAsBytes(bytes);
  final recognizer = TextRecognizer();
  try {
    final result = await recognizer.processImage(
      InputImage.fromFilePath(file.path),
    );
    final text = result.text.trim();
    if (text.isEmpty) return null;
    return FlierText(text, [
      for (final block in result.blocks)
        for (final line in block.lines)
          if (line.text.trim().isNotEmpty)
            FlierLine(line.text.trim(), line.boundingBox),
    ]);
  } catch (_) {
    return null;
  } finally {
    await recognizer.close();
    if (file.existsSync()) file.deleteSync();
  }
}

/// Codes printed on a flier photo — posters often carry a QR to the
/// registry's report page. Android and iOS only; elsewhere the photo
/// yields no codes and the link has to come from the text.
Future<FlierCodes> recognizeFlierCodes(Uint8List bytes) async {
  if (!Platform.isAndroid && !Platform.isIOS) return FlierCodes.none;
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/flier-codes.jpg');
  await file.writeAsBytes(bytes);
  final controller = MobileScannerController();
  try {
    final capture = await controller.analyzeImage(file.path);
    return FlierCodes([
      for (final code in capture?.barcodes ?? const <Barcode>[])
        if (code.rawValue case final value?)
          if (value.isNotEmpty) value,
    ]);
  } catch (e) {
    return FlierCodes(const [], error: e.toString());
  } finally {
    await controller.dispose();
    if (file.existsSync()) file.deleteSync();
  }
}
