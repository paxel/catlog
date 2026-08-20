import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n.dart';

/// Opens the registry page for an ID value in the browser. cat(a)log
/// never talks to the service itself — this hands the link to the
/// system, nothing more.
Future<void> openLookup(
    BuildContext context, FieldDef def, String value) async {
  final t = context.t;
  final url = lookupUrl(def, value);
  if (url == null) return;
  final uri = Uri.tryParse(url);
  var opened = false;
  if (uri != null) {
    try {
      opened =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }
  }
  if (opened || !context.mounted) return;
  // Say what failed and what fixes it — never a bare "failed".
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(t.lookupFailed(url))));
}
