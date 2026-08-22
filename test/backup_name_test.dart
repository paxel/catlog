import 'package:catlog/src/auto_backup.dart';
import 'package:flutter_test/flutter_test.dart';

/// One backup file per catalog, named after it: using Paris must not
/// overwrite Berlin's safety net, and a folder of these files has to
/// still say which is which months later.
void main() {
  test('a catalog backs up under its own name', () {
    expect(backupFileName('Berlin'), 'catlog-berlin.catsync');
    expect(backupFileName('Paris 11e'), 'catlog-paris-11e.catsync');
  });

  test('two catalogs never share a file', () {
    expect(backupFileName('Berlin'), isNot(backupFileName('Paris')));
  });

  test('a name the file system cannot carry still gets its own file', () {
    // The app ships 38 languages; a Chinese or Russian name must not
    // collapse into the shared fallback and overwrite another catalog.
    expect(backupFileName('北京'), isNot('catlog-backup.catsync'));
    expect(backupFileName('北京'), isNot(backupFileName('上海')));
    expect(backupFileName('Москва'), isNot(backupFileName('Київ')));
    expect(backupFileName(null), 'catlog-backup.catsync');
    expect(backupFileName('   '), 'catlog-backup.catsync');
  });

  test('names that differ only in punctuation keep separate files', () {
    expect(backupFileName('Cats!'), isNot(backupFileName('Cats?')));
  });

  test('the same name always gives the same file', () {
    for (final name in ['Berlin', '北京', 'Cats!']) {
      expect(backupFileName(name), backupFileName(name));
    }
  });

  test('the name is a file name, not a path', () {
    for (final name in ['../etc', 'a/b', 'Kathrin: Second Flow']) {
      final file = backupFileName(name);
      expect(file, isNot(contains('/')));
      expect(file, endsWith('.catsync'));
      expect(file, startsWith('catlog-'));
    }
  });
}
