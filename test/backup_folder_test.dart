import 'dart:io';

import 'package:catlog/src/auto_backup.dart';
import 'package:flutter_test/flutter_test.dart';

/// The copy of a backup kept for the next install: written beside the
/// visible one, replaced on every run, gone after a rename.
void main() {
  late Directory dir;
  late Directory folder;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('catlog-bfolder');
    folder = Directory('${dir.path}/media/backups');
  });

  tearDown(() => dir.deleteSync(recursive: true));

  test('copies, replaces, removes', () async {
    final staged = File('${dir.path}/staged.catsync')..writeAsStringSync('v1');
    await copyToBackupFolder(
      staged.path,
      'catlog-berlin.catsync',
      folder: folder,
    );
    expect(
      File('${folder.path}/catlog-berlin.catsync').readAsStringSync(),
      'v1',
    );

    staged.writeAsStringSync('v2');
    await copyToBackupFolder(
      staged.path,
      'catlog-berlin.catsync',
      folder: folder,
    );
    expect(
      File('${folder.path}/catlog-berlin.catsync').readAsStringSync(),
      'v2',
    );
    expect(folder.listSync(), hasLength(1));

    await removeFromBackupFolder('catlog-berlin.catsync', folder: folder);
    expect(folder.listSync(), isEmpty);
  });

  test('a missing source is not a failure', () async {
    await copyToBackupFolder(
      '${dir.path}/nope.catsync',
      'x.catsync',
      folder: folder,
    );
    expect(folder.existsSync() ? folder.listSync() : const [], isEmpty);
  });
}
