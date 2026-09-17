import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

import '../tool/fixtures/dump.dart';
import '../tool/fixtures/folder_copy.dart';

/// The reverse direction of the fixture corpus: the desktop core wrote
/// every scenario (`cargo run -p catlog-core --example reverse_corpus --
/// target/reverse`), and this core has to read it back to the state the
/// desktop core recorded in `rust-expected.json`.
///
/// Without the corpus the test is skipped; CI sets `CATLOG_REVERSE_DIR`
/// and then a missing corpus is a failure.
void main() {
  setUpAll(useSystemSqlite);

  final env = Platform.environment['CATLOG_REVERSE_DIR'];
  final root = Directory(env ?? '../../desktop/target/reverse');
  final scenarios = root.existsSync()
      ? (root.listSync().whereType<Directory>().toList()
        ..sort((a, b) => a.path.compareTo(b.path)))
      : <Directory>[];

  test('the reverse corpus is there when CI asks for it', () {
    if (env != null) {
      expect(root.existsSync(), isTrue, reason: 'no corpus at ${root.path}');
      expect(scenarios, isNotEmpty);
    }
  });

  for (final dir in scenarios) {
    final name = dir.uri.pathSegments.where((s) => s.isNotEmpty).last;
    final expected = _canon(
        jsonDecode(File('${dir.path}/rust-expected.json').readAsStringSync()));

    test('$name: what the desktop wrote into the folder reads back', () async {
      final reader = CatalogStore.inMemory()..author = 'Reader';
      await folderSyncIn(reader, memoryCopy(Directory('${dir.path}/folder')));
      expect(_canon(dumpState(reader)), expected);
      reader.close();
    });

    test('$name: the bundle the desktop wrote reads back', () {
      final reader = CatalogStore.inMemory()..author = 'Reader';
      importBundle(reader, '${dir.path}/bundle.catsync');
      expect(_canon(dumpState(reader)), expected);
      reader.close();
    });
  }
}

/// JSON with every map's keys sorted, so two dumps compare as text.
String _canon(Object? value) =>
    const JsonEncoder.withIndent('  ').convert(_sorted(value));

Object? _sorted(Object? value) {
  if (value is Map) {
    return SplayTreeMap<String, dynamic>.fromIterable(value.keys,
        key: (k) => k as String, value: (k) => _sorted(value[k]));
  }
  if (value is List) return [for (final v in value) _sorted(v)];
  return value;
}
