import 'package:catlog/src/share_publicly.dart';
import 'package:flutter_test/flutter_test.dart';

/// A cat's name is not a file name. "Mia/Mimi" used to send the export
/// into a directory that does not exist, which took the app down.
void main() {
  test('a name with a slash cannot escape the directory', () {
    expect(shareFileName('Mia/Mimi'), isNot(contains('/')));
    expect(shareFileName('../../etc/passwd'), isNot(contains('/')));
    expect(shareFileName(r'C:\cats'), isNot(contains(r'\')));
  });

  test('ordinary names survive intact', () {
    expect(shareFileName('Minka'), 'Minka-share.catsync');
    expect(shareFileName('Kathrins Zweiter'),
        'Kathrins Zweiter-share.catsync');
    expect(shareFileName('Мурка'), 'Мурка-share.catsync');
  });

  test('a name with nothing usable still gets a file', () {
    expect(shareFileName('///'), 'cat-share.catsync');
    expect(shareFileName(null), 'cat-share.catsync');
  });
}
