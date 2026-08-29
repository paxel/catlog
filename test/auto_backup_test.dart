import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/auto_backup.dart';
import 'package:flutter_test/flutter_test.dart';

/// The backup's staging file is private and gone once it was saved.
void main() {
  setUpAll(useSystemSqlite);

  test('the staging file is deleted after the backup was handed over',
      () async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    store.createCat('Sissi');
    String? staged;
    await autoBackup(store, save: (path, name) async {
      staged = path;
      expect(File(path).existsSync(), isTrue);
      expect(path, contains('/catlog-'));
      return path;
    });
    expect(staged, isNotNull);
    expect(File(staged!).existsSync(), isFalse);
    expect(File(staged!).parent.existsSync(), isFalse);
    expect(store.localSetting('lastBackupVector'), isNotNull);
  });

  test('two backups asked at once run as one', () async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    store.createCat('Sissi');
    var saves = 0;
    Future<String> save(String path, String name) async {
      saves++;
      await Future<void>.delayed(const Duration(milliseconds: 50));
      return path;
    }

    await Future.wait([
      autoBackup(store, save: save),
      autoBackup(store, save: save),
    ]);
    expect(saves, 1);
  });
}
