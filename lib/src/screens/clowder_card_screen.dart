import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../layout.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../plus_code.dart';
import '../share.dart';
import '../widgets/cat_avatar.dart';
import 'card_screen.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../exclusive.dart';

/// A Clowder's Card: its facts and the cats living there on one sheet,
/// exportable as an image (share sheet), a PDF, or straight to the
/// printer — the clowder-sized sibling of the Cat's Card.
class ClowderCardScreen extends StatefulWidget {
  final CatalogStore store;
  final String clowderId;

  const ClowderCardScreen(
      {super.key, required this.store, required this.clowderId});

  @override
  State<ClowderCardScreen> createState() => _ClowderCardScreenState();
}

class _ClowderCardScreenState extends State<ClowderCardScreen> {
  final _cardKey = GlobalKey();

  CatalogStore get store => widget.store;
  String get id => widget.clowderId;

  /// Keys selected for the card: '\$cats' or clowder field keys.
  /// Loaded from the remembered last selection; first time everything
  /// except position (addresses don't belong on shared images).
  late Set<String> _selected;

  static const _catsKey = r'$cats';

  @override
  void initState() {
    super.initState();
    final saved = store.localSetting('clowderCardFields');
    if (saved != null) {
      _selected = saved.split('\n').where((k) => k.isNotEmpty).toSet();
    } else {
      _selected = {
        _catsKey,
        for (final def
            in store.visibleFieldDefs(scope: FieldScope.clowder))
          if (def.slug != 'position') def.key,
      };
    }
  }

  void _toggle(String key) {
    setState(() {
      if (!_selected.remove(key)) _selected.add(key);
      store.setLocalSetting('clowderCardFields', _selected.join('\n'));
    });
  }

  /// Field label/value pairs shown on the card: only filled Fields,
  /// labels and canonical values in the viewing device's language.
  List<(String, String)> _facts() {
    final t = context.t;
    final facts = <(String, String)>[];
    for (final def in store.visibleFieldDefs(scope: FieldScope.clowder)) {
      if (!_selected.contains(def.key)) continue;
      // Location renders as a scannable QR + Plus Code, not as a row;
      // scannable IDs render as their code alone — a fact row would
      // repeat the label and number.
      if (def.type == FieldType.location) continue;
      if (def.type == FieldType.id && def.idDisplay != IdDisplay.plain) {
        continue;
      }
      final value = store.current(id, def.key);
      if (value == null) continue;
      if (def.type == FieldType.cat) {
        // A linked cat prints by name; the entity id means nothing to
        // whoever holds the card, so an unresolvable link is left off.
        final name = store.current(store.resolveEntity(value), Keys.name);
        if (name != null && name.isNotEmpty) {
          facts.add((fieldDefName(t, def), name));
        }
        continue;
      }
      facts.add((fieldDefName(t, def), fieldValueDisplay(t, def, value)));
    }
    return facts;
  }

  /// Selected, filled location Fields — the Card shows them as a
  /// scannable geo QR plus the printable Plus Code, because "on the
  /// map" means nothing on paper.
  List<(FieldDef, double, double)> _cardPositions() => [
        for (final def
            in store.visibleFieldDefs(scope: FieldScope.clowder))
          if (def.type == FieldType.location &&
              _selected.contains(def.key))
            if (CatalogStore.parsePosition(store.current(id, def.key))
                case final pos?)
              (def, pos.$1, pos.$2)
      ];

  /// Selected, filled ID Fields that render scannable (QR/barcode).
  List<(FieldDef, String)> _scannableIds() => [
        for (final def
            in store.visibleFieldDefs(scope: FieldScope.clowder))
          if (def.type == FieldType.id &&
              def.idDisplay != IdDisplay.plain &&
              _selected.contains(def.key) &&
              store.current(id, def.key) != null)
            (def, store.current(id, def.key)!)
      ];

  Widget _scannable(FieldDef def, String value) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(children: [
          if (def.idDisplay == IdDisplay.qr) ...[
            QrImageView(data: value, size: 110),
            // The QR alone shows nothing readable — one caption line.
            Text('${fieldDefName(context.t, def)}: $value',
                style: Theme.of(context).textTheme.bodySmall),
          ] else if (printsAsCode128(value))
            // Code128 prints the number under the bars itself.
            BarcodeWidget(
              barcode: Barcode.code128(),
              data: value,
              width: 220,
              height: 64,
            )
          else
            Text('${fieldDefName(context.t, def)}: $value',
                style: Theme.of(context).textTheme.bodySmall),
        ]),
      );

  /// Chips for everything that could be on the card: the cats and each
  /// filled field of this clowder.
  Widget _contentPicker(List<EntityView> cats) {
    final t = context.t;
    final chips = <(String, String)>[
      if (cats.isNotEmpty) (_catsKey, t.cats),
      for (final def in store.visibleFieldDefs(scope: FieldScope.clowder))
        if (store.current(id, def.key) != null)
          (def.key, fieldDefName(t, def)),
    ];
    return Padding(
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
    final name = store.current(id, Keys.name) ?? 'clowder';
    if (!mounted) return;
    await shareFiles(context, [
      XFile.fromData(png, mimeType: 'image/png', name: '$name-card.png'),
    ]);
  }

  Future<pw.Document> _buildPdf(List<EntityView> cats) async {
    final t = context.t;
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final facts = _facts();
    final roster = _selected.contains(_catsKey) ? cats : <EntityView>[];
    final doc = pw.Document(title: '$name — cat(a)log card');
    doc.addPage(
      // MultiPage: a long roster flows onto further pages instead of
      // silently clipping at the bottom of a single one.
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5,
        footer: (context) => pw.Text('cat(a)log',
            style:
                const pw.TextStyle(fontSize: 9, color: PdfColors.grey500)),
        build: (context) => [
          // The cats lead the card, like the photo leads the cat card.
          if (roster.isNotEmpty) ...[
            pw.Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final cat in roster) _pdfCatTile(cat),
              ],
            ),
            pw.SizedBox(height: 12),
          ],
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
          for (final (def, lat, lon) in _cardPositions())
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10),
              child: pw.Column(children: [
                pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: 'geo:$lat,$lon',
                  width: 80,
                  height: 80,
                ),
                pw.Text(
                    '${fieldDefName(t, def)}: '
                    '${encodePlusCode(lat, lon)}',
                    style: const pw.TextStyle(
                        fontSize: 9, color: PdfColors.grey700)),
              ]),
            ),
          for (final (def, value) in _scannableIds())
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10),
              child: pw.Column(children: [
                if (def.idDisplay == IdDisplay.qr ||
                    printsAsCode128(value))
                  pw.BarcodeWidget(
                    barcode: def.idDisplay == IdDisplay.qr
                        ? pw.Barcode.qrCode()
                        : pw.Barcode.code128(),
                    data: value,
                    width: def.idDisplay == IdDisplay.qr ? 80 : 180,
                    height: def.idDisplay == IdDisplay.qr ? 80 : 44,
                  )
                else
                  pw.Text('${fieldDefName(t, def)}: $value',
                      style: const pw.TextStyle(fontSize: 9)),
                if (def.idDisplay == IdDisplay.qr)
                  pw.Text('${fieldDefName(t, def)}: $value',
                      style: const pw.TextStyle(
                          fontSize: 9, color: PdfColors.grey700)),
              ]),
            ),
        ],
      ),
    );
    return doc;
  }

  pw.Widget _pdfCatTile(EntityView cat) {
    final hash = store.profileImage(cat.id);
    final photo = hash == null ? null : store.imageBytes(hash);
    return pw.Column(children: [
      if (photo != null)
        pw.ClipRRect(
          horizontalRadius: 8,
          verticalRadius: 8,
          child: pw.Image(pw.MemoryImage(photo),
              width: 60, height: 60, fit: pw.BoxFit.cover),
        )
      else
        pw.Container(
          width: 60,
          height: 60,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey300,
            borderRadius: pw.BorderRadius.circular(8),
          ),
        ),
      pw.SizedBox(
        width: 64,
        child: pw.Text(cat.name,
            style: const pw.TextStyle(fontSize: 9),
            textAlign: pw.TextAlign.center,
            maxLines: 1,
            overflow: pw.TextOverflow.clip),
      ),
    ]);
  }

  Future<void> _printCard(List<EntityView> cats) => runExclusive('print', () async {
        final doc = await _buildPdf(cats);
        await Printing.layoutPdf(onLayout: (_) => doc.save());
      }, context: context);

  Future<void> _sharePdf(List<EntityView> cats) => runExclusive('share', () async {
        await _sharePdfNow(cats);
      }, context: context);

  Future<void> _sharePdfNow(List<EntityView> cats) async {
    final doc = await _buildPdf(cats);
    final name = store.current(id, Keys.name) ?? 'clowder';
    await Printing.sharePdf(
        bytes: await doc.save(), filename: '$name-card.pdf');
  }

  Widget _catTile(EntityView cat) => SizedBox(
        width: 72,
        child: Column(children: [
          CatAvatar(store: store, catId: cat.id, size: 64),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(cat.name,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final name = store.current(id, Keys.name) ?? '(unnamed)';
    final cats = store.visibleCats(clowderId: id);
    final facts = _facts();
    final roster = _selected.contains(_catsKey) ? cats : <EntityView>[];
    return Scaffold(
      appBar: roomyAppBar(
        context,
        title: Text(context.t.cardTitle(name)),
        actions: [
          IconButton(
              icon: const Icon(Icons.ios_share),
              tooltip: context.t.shareAsImage,
              onPressed: _shareImage),
          IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: context.t.shareAsPdf,
              onPressed: () => _sharePdf(cats)),
          IconButton(
              icon: const Icon(Icons.print),
              tooltip: context.t.print,
              onPressed: () => _printCard(cats)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 8),
          _contentPicker(cats),
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
                      color:
                          Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The cats lead the card, like the photo leads the
                    // cat card. A plain Wrap, not a lazy grid: the whole
                    // roster must be laid out for the image export —
                    // the card simply grows tall.
                    if (roster.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final cat in roster) _catTile(cat),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    Text(name,
                        style:
                            Theme.of(context).textTheme.headlineMedium),
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
                    for (final (def, value) in _scannableIds())
                      Center(child: _scannable(def, value)),
                    for (final (def, lat, lon) in _cardPositions())
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(children: [
                            QrImageView(
                                data: 'geo:$lat,$lon',
                                size: 110,
                                backgroundColor: Colors.white),
                            Text(
                                '${fieldDefName(context.t, def)}: '
                                '${encodePlusCode(lat, lon)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall),
                          ]),
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
