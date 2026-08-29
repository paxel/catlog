import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'import_summary.dart';
import 'import_target.dart';
import 'incoming_images.dart';
import 'l10n.dart';

/// Opening a .catsync from a messenger or file manager lands here: the
/// platform side (Android intent filter, iOS document type, desktop
/// argv) delivers a local path, we import it and show the summary.
/// Garbage in is absorbed with a message, never a crash.
const _channel = MethodChannel('catlog/openfile');
Future<void> _queue = Future.value();

/// [store] is a getter, not a store: switching catalogs replaces the
/// open one, and a file shared in afterwards belongs to the new one.
/// With [catalogs] and [switchTo], a .catsync first asks which catalog
/// it goes into — or creates one (#90); without them it lands in the
/// open catalog as before.
void initIncomingFiles(GlobalKey<NavigatorState> navigator,
    CatalogStore Function() store, List<String> args,
    {CatalogManager? catalogs, void Function(CatalogInfo)? switchTo}) {
  // One file at a time: a second file while the first still asks for
  // its catalog waits its turn instead of stacking a second dialog.
  void import(String path) => _queue = _queue.then((_) =>
      _import(navigator, store, path, catalogs: catalogs, switchTo: switchTo));
  _channel.setMethodCallHandler((call) async {
    if (call.method == 'open') {
      import(call.arguments as String);
    }
    if (call.method == 'sharedImages') {
      handleSharedImages(navigator, store(),
          (call.arguments as List).cast<String>());
    }
  });
  if (Platform.isAndroid || Platform.isIOS) {
    _channel.invokeMethod<String>('pending').then((path) {
      if (path != null) import(path);
    }).catchError((_) => null);
    _channel.invokeMethod<List<Object?>>('pendingImages').then((paths) {
      if (paths != null && paths.isNotEmpty) {
        handleSharedImages(
            navigator, store(), paths.cast<String>());
      }
    }).catchError((_) => null);
  }
  // Desktop: the associated file arrives as a launch argument.
  for (final arg in args) {
    if (arg.endsWith('.catsync') && File(arg).existsSync()) {
      import(arg);
    }
  }
}

Future<void> _import(GlobalKey<NavigatorState> navigator,
    CatalogStore Function() storeOf, String path,
    {CatalogManager? catalogs, void Function(CatalogInfo)? switchTo}) async {
  // The first frame may not be up yet on a cold start — poll instead of
  // one fixed delay, or a slow start silently swallows the file.
  BuildContext? context;
  for (var i = 0; i < 40 && context == null; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    context = navigator.currentContext;
  }
  if (context == null || !context.mounted) return;
  final fileName = path.split(Platform.pathSeparator).last;
  if (catalogs != null && switchTo != null) {
    // Which catalog, before anything happens — a mis-tap in a chat
    // stops here, and a cat one only wants to look at gets a catalog
    // of its own (#90).
    final target = await chooseImportTarget(context, catalogs, fileName);
    if (target == null || !context.mounted) return;
    CatalogInfo? to;
    switch (target) {
      case ImportInto(:final catalog):
        if (catalog.id != catalogs.active.id) to = catalog;
      case ImportIntoNew(:final name):
        try {
          to = catalogs.create(name);
        } on DuplicateCatalogName {
          _snack(context, context.t.catalogNameTaken(name));
          return;
        }
    }
    if (to != null) {
      switchTo(to);
      // The switch closes the old store a frame later; the new one is
      // the getter's answer from here on.
      await Future<void>.delayed(Duration.zero);
      if (!context.mounted) return;
    }
  }
  final store = storeOf();
  try {
    final imported = importWithMoment(store, path, label: fileName);
    final result = imported.result;
    if (!context.mounted) return;
    if (result.applied.isEmpty && result.blobsIn == 0) {
      _snack(context, context.t.nothingNewInBundle);
    } else {
      await showImportSummary(context, store, result.applied,
          undo: imported.moment);
    }
  } catch (_) {
    if (context.mounted) _snack(context, context.t.notACatlogFile);
  }
}

void _snack(BuildContext context, String message) =>
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(SnackBar(content: Text(message)));
