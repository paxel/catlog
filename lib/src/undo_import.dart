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

/// Asks before undoing an import, then does it.
Future<bool> confirmUndoImport(
        BuildContext context, CatalogStore store, Moment point,
        {SaveFile? saveTo}) =>
    _confirmGoBack(context, store, point,
        saveTo: saveTo,
        title: (t) => t.undoThisImport,
        body: (t, count) => t.undoImportBody(count),
        confirm: (t) => t.undoThisImport);

/// Asks before returning the catalog to an earlier moment, then does it.
Future<bool> confirmGoBack(
        BuildContext context, CatalogStore store, Moment point,
        {SaveFile? saveTo}) =>
    _confirmGoBack(context, store, point,
        saveTo: saveTo,
        title: (t) => t.goBackTitle,
        body: (t, count) => t.goBackBody(count),
        confirm: (t) => t.goBackToHere);

Future<bool> _confirmGoBack(
    BuildContext context, CatalogStore store, Moment point,
    {required String Function(AppLocalizations t) title,
    required String Function(AppLocalizations t, int count) body,
    required String Function(AppLocalizations t) confirm,
    SaveFile? saveTo}) async {
  final t = context.t;
  final removed = store.entriesAfter(point.seq).length;
  // Names, not just a number: being "told exactly what going back will
  // remove" means the cats and clowders it touches.
  final names = [
    for (final id in changedSince(store, point))
      store.current(id, Keys.name) ?? t.unnamed
  ]..sort();
  final yes = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title(t)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(body(t, removed)),
        if (names.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(names.join(', '),
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel)),
        FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirm(t))),
      ],
    ),
  );
  if (yes != true || !context.mounted) return false;
  final tmp = Directory.systemTemp.createTempSync('catlog-undo');
  try {
    // Write the file, put it where the keeper can reach it, and only
    // then remove anything: a file that never arrived must not cost the
    // entries it was supposed to hold.
    final name = undoFileName(point.at);
    final seqBefore = store.currentSeq();
    writeGoBackFile(store, point, '${tmp.path}/$name');
    final where = await (saveTo ?? saveBesideBackups)('${tmp.path}/$name', name);
    // Anything that arrived while the file was being saved (a sync in
    // the background) is not in it — removing it would lose it.
    if (store.currentSeq() != seqBefore) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(t.goBackChanged)));
      }
      return false;
    }
    applyGoBack(store, point);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.undoneImport(where))));
    }
    return true;
  } catch (e) {
    // Nothing was removed: the file has to exist first.
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.goBackFileFailed('$e'))));
    }
    return false;
  } finally {
    if (tmp.existsSync()) tmp.deleteSync(recursive: true);
  }
}

/// One file per undo, so an earlier one is never overwritten.
String undoFileName(DateTime at) {
  final stamp = at
      .toIso8601String()
      .substring(0, 19)
      .replaceAll(RegExp(r'[:T]'), '-');
  return 'catlog-undone-$stamp.catsync';
}
