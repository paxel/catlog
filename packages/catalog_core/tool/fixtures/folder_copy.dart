import 'dart:io';

import 'package:catalog_core/catalog_core.dart';

/// The folder as written on disk, loaded into memory so importing from
/// it writes nothing back into the fixture.
MemorySyncFolder memoryCopy(Directory folderDir) {
  final folder = MemorySyncFolder();
  final root = Directory('${folderDir.path}/catlog-sync');
  for (final f in root.listSync(recursive: true).whereType<File>()) {
    final rel = f.path.substring(root.path.length + 1);
    final cut = rel.lastIndexOf('/');
    final dir = cut < 0 ? '' : rel.substring(0, cut);
    final name = cut < 0 ? rel : rel.substring(cut + 1);
    folder.dirs.putIfAbsent(dir, () => {})[name] = f.readAsBytesSync();
  }
  return folder;
}
