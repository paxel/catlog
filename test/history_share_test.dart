import 'package:catlog/src/history_share.dart';
import 'package:flutter_test/flutter_test.dart';

/// A history as text and as PDF: lines in order, notes only where
/// there are any.
void main() {
  const lines = <HistoryLine>[
    (when: '9/1/2026 10:30', value: '4.1 kg', who: 'anna', note: ''),
    (
      when: '8/1/2026 09:00',
      value: '4.0 kg',
      who: 'anna',
      note: 'Replaced by 4.05 kg · anna · 9/2/2026 08:00',
    ),
  ];

  test('text keeps the order and the note', () {
    final text = historyText('Miezi', 'Weight', lines);
    expect(text.split('\n').first, 'Miezi · Weight');
    expect(text, contains('9/1/2026 10:30 · 4.1 kg · anna'));
    expect(text, contains('· Replaced by 4.05 kg'));
    expect(text.indexOf('4.1 kg'), lessThan(text.indexOf('4.0 kg')));
  });

  test('the PDF builds and carries the title', () async {
    final doc = historyPdf(
      title: 'Miezi',
      subtitle: 'Weight',
      lines: lines,
      whenHeader: 'When',
      valueHeader: 'Value',
      whoHeader: 'Who',
    );
    final bytes = await doc.save();
    expect(bytes.length, greaterThan(1000));
    expect(String.fromCharCodes(bytes.take(8)), startsWith('%PDF-'));
  });
}
