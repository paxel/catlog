import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/services.dart';

/// The shared folder on Android, through the access the folder picker
/// granted: a tree URI (`content://…`), not a path. Every call goes to
/// the platform, which lists, reads and writes the documents by name.
/// A platform error becomes a [FileSystemException], the same thing a
/// vanished drive raises on desktop.
class SafSyncFolder implements SyncFolder {
  static const channel = MethodChannel('catlog/folder');

  /// The tree URI the picker returned.
  final String tree;

  /// The folder inside the tree everything lives in: `catlog-sync` for
  /// the shared folder, `catlog-backups` for the copies.
  final String root;

  const SafSyncFolder(this.tree, {this.root = 'catlog-sync'});

  /// Whether a stored folder setting is a tree URI rather than a path.
  static bool isTree(String setting) => setting.startsWith('content://');

  /// Opens the system folder picker; the tree URI, or null when the
  /// keeper backed out.
  static Future<String?> pick() => channel.invokeMethod<String>('pickTree');

  /// The folder's own name, for the screen — the URI is not for people.
  static Future<String> displayName(String tree) async {
    try {
      final name = await channel.invokeMethod<String>('name', {'tree': tree});
      if (name != null && name.isNotEmpty) return name;
    } catch (_) {}
    // The last segment reads `primary:catlog`; the part after the colon
    // is the folder.
    final last = Uri.decodeComponent(tree.split('/').last);
    return last.contains(':') ? last.substring(last.indexOf(':') + 1) : last;
  }

  Map<String, Object> _args(String dir, [String? name]) => {
    'tree': tree,
    'root': root,
    'dir': dir,
    'name': ?name,
  };

  Future<T?> _call<T>(String method, Map<String, Object> args) async {
    try {
      return await channel.invokeMethod<T>(method, args);
    } on PlatformException catch (e) {
      throw FileSystemException(e.message ?? method, tree);
    } on MissingPluginException {
      throw FileSystemException('No folder access on this platform', tree);
    }
  }

  @override
  Future<List<String>> list(String dir) async {
    final names = await _call<List<Object?>>('list', _args(dir));
    return [
      for (final n in names ?? const [])
        if (n is String) n,
    ];
  }

  @override
  Future<Uint8List?> read(String dir, String name) =>
      _call<Uint8List>('read', _args(dir, name));

  @override
  Future<void> write(String dir, String name, List<int> bytes) => _call<void>(
    'write',
    {..._args(dir, name), 'bytes': Uint8List.fromList(bytes)},
  );

  @override
  Future<void> delete(String dir, String name) =>
      _call<void>('delete', _args(dir, name));

  @override
  Future<void> ensure(String dir) => _call<void>('ensure', _args(dir));
}
