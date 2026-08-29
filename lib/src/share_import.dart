import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';
import 'screens/scan_screen.dart';
import 'exclusive.dart';

/// Downloads a hosted share file; injectable for tests.
Future<Uint8List> fetchShare(String url) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();
    if (response.statusCode != 200) {
      throw HttpException('HTTP ${response.statusCode}', uri: Uri.parse(url));
    }
    final builder = BytesBuilder();
    await for (final chunk in response) {
      builder.add(chunk);
      // A share is one cat and a few photos; anything bigger is not one.
      if (builder.length > maxEntriesBytes) {
        throw HttpException('Share too large', uri: Uri.parse(url));
      }
    }
    return builder.takeBytes();
  } finally {
    client.close();
  }
}

/// Finder side of #40: scan a share QR, download or unpack it, preview
/// the cat, and import only after an explicit confirmation. Nothing
/// enters the catalog silently, and a malformed code explains itself.
Future<void> scanShareCode(BuildContext context, CatalogStore store,
        {Future<String?> Function(BuildContext)? scan,
        Future<Uint8List> Function(String url)? fetch}) =>
    runExclusive('scan', () => _scanShareCode(context, store, scan: scan, fetch: fetch),
        context: context);

Future<void> _scanShareCode(BuildContext context, CatalogStore store,
    {Future<String?> Function(BuildContext)? scan,
    Future<Uint8List> Function(String url)? fetch}) async {
  final raw = await (scan ??
      (BuildContext c) => Navigator.of(c)
          .push<String>(MaterialPageRoute(builder: (_) => const ScanScreen())))(
      context);
  if (raw == null || raw.isEmpty) return;
  if (!context.mounted) return;
  final decoded = decodeShareQr(raw);
  if (decoded == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.notAShareCode)));
    return;
  }
  Uint8List bytes;
  try {
    bytes = decoded.data ?? await (fetch ?? fetchShare)(decoded.url!);
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.t.bundleImportFailed('$e'))));
    }
    return;
  }
  if (!context.mounted) return;

  // Preview in a throwaway store — the catalog stays untouched until
  // the finder confirms.
  final preview = CatalogStore.inMemory();
  String? name;
  String? clowderName;
  Uint8List? photo;
  try {
    preview.author = 'preview';
    importBundleBytes(preview, bytes);
    final cat = preview.cats().firstOrNull;
    if (cat == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.t.notAShareCode)));
      }
      return;
    }
    name = cat.name;
    clowderName = preview.clowders().firstOrNull?.name;
    final hash = preview.profileImage(cat.id);
    photo = hash == null ? null : preview.imageBytes(hash);
  } finally {
    preview.close();
  }
  if (!context.mounted) return;
  final catName = name;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.t.importShareTitle),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        if (photo != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(photo,
                height: 140, cacheHeight: 420, fit: BoxFit.cover),
          ),
        const SizedBox(height: 8),
        Text(catName, style: Theme.of(context).textTheme.titleMedium),
        if (clowderName != null) Text(clowderName),
        if (decoded.url != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              context.t.shareSource(decoded.url!),
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.t.importLabel),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;
  // A shared cat arrives like any other import, so it is undoable like
  // any other import.
  final before = store.currentSeq();
  final result = importBundleBytes(store, bytes);
  momentFor(store,
      before: before,
      changed: result.applied.isNotEmpty,
      cause: MomentCause.import,
      label: name);
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.t.bundleImported('$result'))));
}
