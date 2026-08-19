import 'dart:io';
import 'dart:typed_data';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

/// On-device text recognition for flier photos. Only Android and iOS
/// ship ML Kit — everywhere else this returns null and the user types
/// the flier text themselves (#32).
Future<String?> recognizeFlierText(Uint8List bytes) async {
  if (!Platform.isAndroid && !Platform.isIOS) return null;
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/flier-ocr.jpg');
  await file.writeAsBytes(bytes);
  final recognizer = TextRecognizer();
  try {
    final result =
        await recognizer.processImage(InputImage.fromFilePath(file.path));
    final text = result.text.trim();
    return text.isEmpty ? null : text;
  } catch (_) {
    return null;
  } finally {
    await recognizer.close();
    if (file.existsSync()) file.deleteSync();
  }
}
