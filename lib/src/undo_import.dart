import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'auto_backup.dart';
import 'l10n.dart';

/// Undoing an import (#65).
///
/// A moment is recorded before every import, and the summary that
/// already appears afterwards offers to go back to it. Nothing is
/// destroyed: what is removed is written to a file first, in the place
/// automatic backups go, and importing that file puts it back.

/// Where a file the app saves for the keeper is put. Injectable so a
/// test sees the file without a platform channel.
typedef SaveFile = Future<String> Function(String path, String name);

/// Imports a bundle and records the moment before it — but only if
/// something actually arrived, so a sync that finds nothing new does
/// not fill the list with meaningless entries.
({BundleResult result, SavePoint? point}) importWithSavePoint(
    CatalogStore store, String path,
    {String cause = SaveCause.import, String? label}) {
  final before = store.currentSeq();
  final result = importBundle(store, path);
  return (
    result: result,
    point: result.applied.isEmpty
        ? null
        : _pointFor(store, store.addSavePoint(cause: cause, label: label, seq: before)),
  );
}

/// Records the moment before an import that has already happened, given
/// the mark taken before it. For transports that do their own importing.
SavePoint? savePointForImport(CatalogStore store,
    {required int before, required BundleResult result,
    String cause = SaveCause.sync, String? label}) {
  if (result.applied.isEmpty) return null;
  return _pointFor(
      store, store.addSavePoint(cause: cause, label: label, seq: before));
}

SavePoint _pointFor(CatalogStore store, int id) =>
    savePointsOf(store).firstWhere((p) => p.id == id);

/// Asks, then goes back to [point]. Returns true when it happened.
Future<bool> confirmAndRevert(
    BuildContext context, CatalogStore store, SavePoint point,
    {SaveFile? saveTo,
    String Function(AppLocalizations t, int count)? body}) async {
  final t = context.t;
  final removed = store.entriesAfter(point.seq).length;
  final yes = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(body == null ? t.undoThisImport : t.goBackTitle),
      content: Text(body == null ? t.undoImportBody(removed) : body(t, removed)),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel)),
        FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(body == null ? t.undoThisImport : t.goBackToHere)),
      ],
    ),
  );
  if (yes != true || !context.mounted) return false;
  try {
    final tmp = Directory.systemTemp.createTempSync('catlog-undo');
    final name = undoFileName(point.at);
    revertTo(store, point, keepAt: '${tmp.path}/$name');
    final where = await (saveTo ?? saveBesideBackups)('${tmp.path}/$name', name);
    tmp.deleteSync(recursive: true);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.undoneImport(where))));
    }
    return true;
  } catch (e) {
    // Nothing was removed: the file has to exist first.
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.catalogExportFailed('$e'))));
    }
    return false;
  }
}

/// One file per undo, so an earlier one is never overwritten.
String undoFileName(DateTime at) {
  final stamp = at
      .toIso8601String()
      .substring(0, 16)
      .replaceAll(RegExp(r'[:T]'), '-');
  return 'catlog-undone-$stamp.catsync';
}
