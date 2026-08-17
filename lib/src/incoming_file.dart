import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'l10n.dart';

/// Opening a .catsync from a messenger or file manager lands here: the
/// platform side (Android intent filter, desktop argv) delivers a local
/// path, we import it and report via snackbar. Garbage in is absorbed
/// with a message, never a crash.
const _channel = MethodChannel('catlog/openfile');

void initIncomingFiles(GlobalKey<NavigatorState> navigator,
    CatalogStore store, List<String> args) {
  _channel.setMethodCallHandler((call) async {
    if (call.method == 'open') {
      _import(navigator, store, call.arguments as String);
    }
  });
  if (Platform.isAndroid || Platform.isIOS) {
    _channel.invokeMethod<String>('pending').then((path) {
      if (path != null) _import(navigator, store, path);
    }).catchError((_) => null);
  }
  // Desktop: the associated file arrives as a launch argument.
  for (final arg in args) {
    if (arg.endsWith('.catsync') && File(arg).existsSync()) {
      _import(navigator, store, arg);
    }
  }
}

Future<void> _import(GlobalKey<NavigatorState> navigator,
    CatalogStore store, String path) async {
  // The first frame may not be up yet on a cold start.
  await Future<void>.delayed(const Duration(milliseconds: 300));
  final context = navigator.currentContext;
  if (context == null || !context.mounted) return;
  try {
    final result = importBundle(store, path);
    if (!context.mounted) return;
    _snack(context, context.t.bundleImported('$result'));
  } catch (e) {
    if (context.mounted) {
      _snack(context, context.t.bundleImportFailed('$e'));
    }
  }
}

void _snack(BuildContext context, String message) =>
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(SnackBar(content: Text(message)));
