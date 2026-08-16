import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../spotlight.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// A Cat's Card: photo plus current facts on one screen, exportable as
/// an image (share sheet), a PDF, or straight to the printer. The
/// original reason this app exists.
class CardScreen extends StatefulWidget {
  final CatalogStore store;
  final String catId;

  const CardScreen({super.key, required this.store, required this.catId});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final _cardKey = GlobalKey();

  CatalogStore get store => widget.store;
  String get id => widget.catId;

  /// Keys selected for the card: '\$photo', Keys.clowder, or field keys.
  /// Loaded from the remembered last selection; first time everything
  /// except position (addresses don't belong on shared images).
  late Set<String> _selected;

  static const _photoKey = r'$photo';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => runSpotlights(context, store, 'card'));
    final saved = store.localSetting('cardFields');
    if (saved != null) {
      _selected = saved.split('\n').where((k) => k.isNotEmpty).toSet();
    } else {
      _selected = {
        _photoKey,
        Keys.clowder,
        for (final def in store.visibleFieldDefs(scope: FieldScope.cat))
          if (def.slug != 'position') def.key,
      };
    }
  }

  void _toggle(String key) {
    setState(() {
      if (!_selected.remove(key)) _selected.add(key);
      store.setLocalSetting('cardFields', _selected.join('\n'));
    });
  }

  /// Field label/value pairs shown on the card: only filled Fields,
  /// labels and canonical values in the viewing device's language.
  List<(String, String)> _facts() {
    final t = context.t;
    final facts = <(String, String)>[];
    if (_selected.contains(Keys.clowder)) {
      final clowderId = store.current(id, Keys.clowder);
      facts.add((
        t.clowderLabel,
        clowderId == null
            ? t.stray
            : store.current(clowderId, Keys.name) ?? t.unnamed
      ));
    }
    for (final def in store.visibleFieldDefs(scope: FieldScope.cat)) {
      if (!_selected.contains(def.key)) continue;
      final value = store.current(id, def.key);
      if (value != null) {
        facts.add(
            (fieldDefName(t, def), fieldValueDisplay(t, def, value)));
      }
    }
    return facts;
  }

  /// Chips for everything that could be on the card: photo, clowder,
  /// and each filled field of this cat.
  Widget _contentPicker() {
    final t = context.t;
    final chips = <(String, String)>[
      if (store.profileImage(id) != null) (_photoKey, t.labelPhoto),
      (Keys.clowder, t.clowderLabel),
      for (final def in store.visibleFieldDefs(scope: FieldScope.cat))
        if (store.current(id, def.key) != null)
          (def.key, fieldDefName(t, def)),
    ];
    return Spotlight(
      id: 'card-chips',
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 0,
        children: [
          for (final (key, label) in chips)
            FilterChip(
              label: Text(label),
              selected: _selected.contains(key),
              onSelected: (_) => _toggle(key),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
      ),
    );
  }

  Future<Uint8List> _cardAsPng() async {
    final boundary = _cardKey.currentContext!.findRenderObject()!
        as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  Future<void> _shareImage() async {
    final png = await _cardAsPng();
    final name = store.current(id, Keys.name) ?? 'cat';
    await Share.shareXFiles([
      XFile.fromData(png, mimeType: 'image/png', name: '$name-card.png'),
    ]);
  }

  Future<pw.Document> _buildPdf() async {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final hash =
        _selected.contains(_photoKey) ? store.profileImage(id) : null;
    final photo = hash == null ? null : store.imageBytes(hash);
    final facts = _facts();
    final doc = pw.Document(title: '$name — cat(a)log card');
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (photo != null)
              pw.Center(
                child: pw.ClipRRect(
                  horizontalRadius: 12,
                  verticalRadius: 12,
                  child: pw.Image(
                    pw.MemoryImage(photo),
                    height: 220,
                    fit: pw.BoxFit.cover,
                  ),
                ),
              ),
            pw.SizedBox(height: 16),
            pw.Text(name,
                style: pw.TextStyle(
                    fontSize: 28, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            for (final (label, value) in facts)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Row(children: [
                  pw.SizedBox(
                    width: 140,
                    child: pw.Text(label,
                        style: const pw.TextStyle(
                            fontSize: 12, color: PdfColors.grey700)),
                  ),
                  pw.Expanded(
                      child: pw.Text(value,
                          style: const pw.TextStyle(fontSize: 12))),
                ]),
              ),
            pw.Spacer(),
            pw.Text('cat(a)log',
                style: const pw.TextStyle(
                    fontSize: 9, color: PdfColors.grey500)),
          ],
        ),
      ),
    );
    return doc;
  }

  Future<void> _printCard() async {
    final doc = await _buildPdf();
    await Printing.layoutPdf(onLayout: (_) => doc.save());
  }

  Future<void> _sharePdf() async {
    final doc = await _buildPdf();
    final name = store.current(id, Keys.name) ?? 'cat';
    await Printing.sharePdf(
        bytes: await doc.save(), filename: '$name-card.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final hash =
        _selected.contains(_photoKey) ? store.profileImage(id) : null;
    final photo = hash == null ? null : store.imageBytes(hash);
    final facts = _facts();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.cardTitle(name)),
        actions: [
          IconButton(
              icon: const Icon(Icons.ios_share),
              tooltip: context.t.shareAsImage,
              onPressed: _shareImage),
          IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: context.t.shareAsPdf,
              onPressed: _sharePdf),
          IconButton(
              icon: const Icon(Icons.print),
              tooltip: context.t.print,
              onPressed: _printCard),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 8),
          _contentPicker(),
          Padding(
          padding: const EdgeInsets.all(16),
          child: RepaintBoundary(
            key: _cardKey,
            child: Container(
              width: 360,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (photo != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(photo,
                          width: 328, height: 246, fit: BoxFit.cover),
                    ),
                  const SizedBox(height: 12),
                  Text(name,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  for (final (label, value) in facts)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(label,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall),
                          ),
                          Expanded(child: Text(value)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          ),
        ]),
      ),
    );
  }
}
