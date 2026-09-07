import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/src/sync/saf_folder.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Android folder access: every folder call becomes a platform
/// call with the tree URI, the directory and the name; the sync itself
/// runs unchanged on top of it.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(useSystemSqlite);

  const tree =
      'content://com.android.externalstorage.documents/tree/primary%3Acatlog';
  final calls = <MethodCall>[];

  /// A pretend provider: a folder in memory behind the channel.
  final memory = MemorySyncFolder();

  setUp(() {
    calls.clear();
    memory.dirs.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SafSyncFolder.channel, (call) async {
          calls.add(call);
          final args = (call.arguments as Map?)?.cast<String, Object?>() ?? {};
          expect(args['tree'], anyOf(tree, isNull));
          final dir = args['dir'] as String? ?? '';
          switch (call.method) {
            case 'pickTree':
              return tree;
            case 'name':
              return 'catlog';
            case 'list':
              return memory.list(dir);
            case 'read':
              return memory.read(dir, args['name'] as String);
            case 'write':
              await memory.write(
                dir,
                args['name'] as String,
                args['bytes'] as Uint8List,
              );
              return null;
            case 'delete':
              await memory.delete(dir, args['name'] as String);
              return null;
            case 'ensure':
              await memory.ensure(dir);
              return null;
          }
          throw PlatformException(code: 'folder', message: 'unknown');
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SafSyncFolder.channel, null);
  });

  test('picking returns the tree, and the name is the folder\'s', () async {
    expect(await SafSyncFolder.pick(), tree);
    expect(await SafSyncFolder.displayName(tree), 'catlog');
    expect(SafSyncFolder.isTree(tree), isTrue);
    expect(SafSyncFolder.isTree('/storage/emulated/0/catlog'), isFalse);
  });

  test('two stores converge through the granted folder', () async {
    final a = CatalogStore.inMemory()..author = 'anna';
    final b = CatalogStore.inMemory()..author = 'bob';
    addTearDown(a.close);
    addTearDown(b.close);
    final cat = a.createCat('Miezi');
    b.createCat('Wanderer');
    const folder = SafSyncFolder(tree);
    await folderSyncIn(a, folder);
    final result = await folderSyncIn(b, folder);
    expect(b.current(cat, 'name'), 'Miezi');
    expect(result.report.newKeys.single.record.device, a.deviceId);
    await folderSyncIn(a, folder);
    expect(a.cats().length, 2);
    // The layout on the provider is the known one.
    expect(memory.dirs['']!.keys, contains('${a.deviceId}.jsonl'));
    expect(memory.dirs['keys']!.keys, contains('${b.deviceId}.json'));
    // Every call carried the tree and a directory.
    expect(
      calls.map((c) => c.method).toSet(),
      containsAll(['ensure', 'list', 'read', 'write']),
    );
    for (final c in calls) {
      final args = (c.arguments as Map).cast<String, Object?>();
      expect(args['tree'], tree);
      expect(args.containsKey('dir'), isTrue);
    }
  });

  test('a platform error reads as an unreachable folder', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SafSyncFolder.channel, (call) async {
          throw PlatformException(code: 'folder', message: 'Permission denied');
        });
    final store = CatalogStore.inMemory()..author = 'anna';
    addTearDown(store.close);
    expect(
      () => folderSyncIn(store, const SafSyncFolder(tree)),
      throwsA(isA<FileSystemException>()),
    );
  });

  test('a display name falls back to the URI\'s last segment', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SafSyncFolder.channel, (call) async {
          throw PlatformException(code: 'folder', message: 'no');
        });
    expect(await SafSyncFolder.displayName(tree), 'catlog');
  });
}
