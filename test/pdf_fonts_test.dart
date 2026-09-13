import 'package:catlog/src/history_share.dart';
import 'package:catlog/src/pdf_fonts.dart';
import 'package:flutter_test/flutter_test.dart';

/// The bundled Noto Sans sets Cyrillic and Greek; a language without a
/// fetched face still gets a PDF, marked incomplete when offline.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Cyrillic and Greek set in the bundled face', () async {
    final fonts = await pdfFontsFor('ru');
    expect(fonts.complete, isTrue);
    final doc = historyPdf(
      title: 'Мурка',
      subtitle: 'Вес · Βάρος',
      lines: const [(when: '1.9.2026', value: '4,1 кг', who: 'Аня', note: '')],
      whenHeader: 'Когда',
      valueHeader: 'Значение',
      whoHeader: 'Кто',
      theme: fonts.theme,
    );
    final bytes = await doc.save();
    expect(bytes.length, greaterThan(1000));
  });

  test('a script without its face offline is incomplete, not fatal', () async {
    final fonts = await pdfFontsFor('he');
    // No network in tests: the fetch fails and the bundled face stands in.
    expect(fonts.complete, isFalse);
    expect(fonts.theme, isNotNull);
  });
}
