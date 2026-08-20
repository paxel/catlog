import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'field_labels.dart';
import 'l10n.dart';
import 'share.dart';

/// Practical ceiling for the inline QR payload; beyond it the codes stop
/// scanning reliably.
const _inlineQrLimit = 2300;

/// "Share publicly…" (#40): whitelist export of one cat for its flier —
/// a `.catsync` file to host, a QR for the hosted link, or a tiny
/// inline QR with the data itself (text only, no photos).
class SharePubliclyScreen extends StatefulWidget {
  final CatalogStore store;
  final String catId;

  const SharePubliclyScreen(
      {super.key, required this.store, required this.catId});

  @override
  State<SharePubliclyScreen> createState() => _SharePubliclyScreenState();
}

class _SharePubliclyScreenState extends State<SharePubliclyScreen> {
  CatalogStore get store => widget.store;
  String get id => widget.catId;

  late final Set<String> _selected = {
    for (final (def, _) in _filled()) def.key,
  };
  final _url = TextEditingController();

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  /// Filled fields of the cat and its clowder — the whitelist universe.
  /// Private field definitions and private clowders are not offered:
  /// Private stays home (CONTEXT.md).
  List<(FieldDef, String)> _filled() {
    var clowderId = store.current(id, Keys.clowder);
    if (clowderId != null && store.isPrivate(clowderId)) clowderId = null;
    final result = <(FieldDef, String)>[];
    for (final def in store.fieldDefs()) {
      if (store.isPrivate(def.id)) continue;
      final onCat = store.current(id, def.key);
      if (onCat != null && onCat.isNotEmpty) {
        result.add((def, onCat));
        continue;
      }
      if (clowderId != null) {
        final onClowder = store.current(clowderId, def.key);
        if (onClowder != null && onClowder.isNotEmpty) {
          result.add((def, onClowder));
        }
      }
    }
    return result;
  }

  Uint8List _bytes({required bool photos}) => catShareBytes(store,
      catId: id, fields: _selected, includePhotos: photos);

  Future<void> _exportFile() async {
    final dir = await getTemporaryDirectory();
    final name = store.current(id, Keys.name) ?? 'cat';
    final path = writeCatShare(store, '${dir.path}/$name-share.catsync',
        catId: id, fields: _selected);
    if (!mounted) return;
    await shareFiles(
        context, [XFile(path, mimeType: 'application/zip')]);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    if (store.isPrivate(id)) {
      // Refusal with the reason — house law for error cases.
      return Scaffold(
        appBar: AppBar(title: Text(t.sharePublicly)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(t.privateNoShare, textAlign: TextAlign.center),
          ),
        ),
      );
    }
    final inline = encodeShareData(_bytes(photos: false));
    final url = _url.text.trim();
    return Scaffold(
      appBar: AppBar(title: Text(t.sharePublicly)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(t.shareWhitelistExplainer,
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 0, children: [
          for (final (def, _) in _filled())
            FilterChip(
              label: Text(fieldDefName(t, def)),
              selected: _selected.contains(def.key),
              onSelected: (_) => setState(() {
                if (!_selected.remove(def.key)) _selected.add(def.key);
              }),
              visualDensity: VisualDensity.compact,
            ),
        ]),
        const Divider(height: 32),
        FilledButton.icon(
          icon: const Icon(Icons.ios_share),
          label: Text(t.exportShareFile),
          onPressed: _exportFile,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _url,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(labelText: t.hostedLink),
          onChanged: (_) => setState(() {}),
        ),
        if (url.isNotEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                  data: encodeShareUrl(url),
                  size: 220,
                  backgroundColor: Colors.white),
            ),
          ),
        const Divider(height: 32),
        Text(t.inlineQr,
            style: Theme.of(context).textTheme.titleMedium),
        if (inline.length > _inlineQrLimit)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(t.inlineTooBig),
          )
        else
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                  data: inline, size: 220, backgroundColor: Colors.white),
            ),
          ),
      ]),
    );
  }
}
