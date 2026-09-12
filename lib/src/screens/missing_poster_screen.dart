import 'dart:async';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import '../field_labels.dart';
import '../help.dart';
import '../hidden.dart';
import '../image_provider_cache.dart';
import '../history_share.dart';
import '../l10n.dart';
import '../missing_poster.dart';
import '../pdf_fonts.dart';
import '../widgets/date_entry.dart';
import '../widgets/poster_frame.dart';
import 'card_screen.dart' show cardQrPayload;

/// What the poster says, ticked from the record: every filled field of
/// the cat and of its home as a "Label: value" line, the day the cat
/// went missing, one free line, and a code row at the bottom: the
/// cat(a)log code, a registry link per ticked ID, a map link per ticked
/// location.
class MissingPosterScreen extends StatefulWidget {
  final CatalogStore store;
  final String catId;

  /// Where the PDF goes; the share sheet by default. Tests inject.
  final Future<void> Function(pw.Document doc, String fileName)? share;

  /// The print dialog by default. Tests inject.
  final Future<void> Function(pw.Document doc)? print;

  /// Renders the first page for the preview; the printing plugin by
  /// default, which tests replace or leave to fail quietly.
  final Future<Uint8List?> Function(Uint8List pdf) preview;

  const MissingPosterScreen({
    super.key,
    required this.store,
    required this.catId,
    this.share,
    this.print,
    this.preview = rasterFirstPage,
  });

  @override
  State<MissingPosterScreen> createState() => _MissingPosterScreenState();
}

/// One tickable line of the record.
class _Row {
  /// The entity the value lives on: the cat or its home.
  final String entity;
  final FieldDef def;
  final String value;

  const _Row(this.entity, this.def, this.value);

  String get id => '$entity/${def.key}';
}

class _MissingPosterScreenState extends State<MissingPosterScreen> {
  CatalogStore get store => widget.store;
  final _extra = TextEditingController();
  DateTime _since = DateUtils.dateOnly(DateTime.now());
  bool _qr = true;

  /// The chosen pictures, hash to the framed part; at most two, the
  /// profile picture from the start.
  final _photos = <String, PosterPhoto>{};
  bool _photosSet = false;
  bool _busy = false;
  Set<String>? _ticked;
  Uint8List? _previewPng;
  bool _previewBusy = false;
  bool _previewDirty = false;
  Timer? _previewTimer;

  @override
  void initState() {
    super.initState();
    _extra.addListener(_schedulePreview);
    _schedulePreview();
  }

  /// Every change redraws the preview, half a second after the last one.
  void _schedulePreview() {
    _previewTimer?.cancel();
    _previewTimer = Timer(const Duration(milliseconds: 500), _renderPreview);
  }

  Future<void> _renderPreview() async {
    if (!mounted) return;
    if (_previewBusy) {
      _previewDirty = true;
      return;
    }
    _previewBusy = true;
    setState(() {});
    try {
      final language = Localizations.localeOf(context).languageCode;
      final content = _content();
      final fonts = await pdfFontsFor(language);
      final pdf = await missingPosterPdf(content, fonts).save();
      final png = await widget.preview(pdf);
      if (mounted && png != null) setState(() => _previewPng = png);
    } catch (_) {
      // No plugin, no preview: the share and print buttons still work.
    } finally {
      _previewBusy = false;
      if (mounted) setState(() {});
      if (_previewDirty) {
        _previewDirty = false;
        _schedulePreview();
      }
    }
  }

  /// A change of the poster: redraw the page and the preview.
  void _changed(VoidCallback fn) {
    setState(fn);
    _schedulePreview();
  }

  String? get _clowder => store.current(widget.catId, Keys.clowder);

  Map<String, PosterPhoto> _pictures() {
    if (!_photosSet) {
      _photosSet = true;
      final hash = store.profileImage(widget.catId);
      final bytes = hash == null ? null : store.imageBytes(hash);
      if (hash != null && bytes != null) _photos[hash] = PosterPhoto(bytes);
    }
    return _photos;
  }

  void _togglePhoto(String hash) {
    final photos = _pictures();
    if (photos.containsKey(hash)) {
      photos.remove(hash);
    } else if (photos.length < 2) {
      final bytes = store.imageBytes(hash);
      if (bytes != null) photos[hash] = PosterPhoto(bytes);
    }
    _changed(() {});
  }

  /// Every filled field of the cat, then of its home.
  List<_Row> _rows() {
    final rows = <_Row>[];
    for (final def in store.visibleFieldDefs(scope: FieldScope.cat)) {
      final v = store.current(widget.catId, def.key);
      if (v != null && v.isNotEmpty) rows.add(_Row(widget.catId, def, v));
    }
    final home = _clowder;
    if (home != null) {
      for (final def in store.visibleFieldDefs(scope: FieldScope.clowder)) {
        final v = store.current(home, def.key);
        if (v != null && v.isNotEmpty) rows.add(_Row(home, def, v));
      }
    }
    return rows;
  }

  /// Ticked from the start: Looks, address, phone, every ID.
  bool _defaultOn(_Row r) =>
      r.def.type == FieldType.id ||
      const {'looks', 'address', 'phone'}.contains(r.def.slug);

  Set<String> _ticks(List<_Row> rows) => _ticked ??= {
    for (final r in rows)
      if (_defaultOn(r)) r.id,
  };

  String _label(_Row r) => fieldDefName(context.t, r.def);

  String _value(_Row r) => valueLabel(context.t, store, r.def.key, r.value);

  @override
  void dispose() {
    _previewTimer?.cancel();
    _extra.dispose();
    super.dispose();
  }

  /// The public share behind the cat(a)log code: the ticked fields,
  /// photos out. Null when so much is ticked that the code stops
  /// scanning.
  String? _qrPayload(List<_Row> ticked) {
    final payload = encodeShareData(
      catShareBytes(
        store,
        catId: widget.catId,
        fields: {for (final r in ticked) r.def.key},
        includePhotos: false,
      ),
    );
    return payload.length > posterQrLimit ? null : payload;
  }

  PosterContent _content() {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final name = store.current(widget.catId, Keys.name) ?? t.unnamed;
    final rows = _rows();
    final ticks = _ticks(rows);
    final ticked = [
      for (final r in rows)
        if (ticks.contains(r.id)) r,
    ];
    String? phone;
    String? looks;
    final lines = <String>[
      '${t.missingSinceLabel}: ${DateFormat.yMd(locale).format(_since)}',
    ];
    final codes = <PosterCode>[];
    final payload = _qr ? _qrPayload(ticked) : null;
    if (payload != null) codes.add(PosterCode(payload, t.posterQr));
    for (final r in ticked) {
      if (r.def.slug == 'phone') {
        phone = r.value;
      } else if (r.def.slug == 'looks') {
        looks = _value(r);
      } else {
        lines.add('${_label(r)}: ${_value(r)}');
      }
      if (r.def.type == FieldType.id) {
        codes.add(
          PosterCode(cardQrPayload(r.def, r.value), '${_label(r)}: ${r.value}'),
        );
      } else if (r.def.type == FieldType.location) {
        if (CatalogStore.parsePosition(r.value) case final pos?) {
          codes.add(PosterCode('geo:${pos.$1},${pos.$2}', _label(r)));
        }
      }
    }
    return PosterContent(
      headline: t.posterHeadline,
      name: name,
      photos: _pictures().values.toList(),
      lines: lines,
      phone: phone,
      looks: looks,
      extra: _extra.text.trim(),
      standing: t.posterStanding,
      codes: codes,
    );
  }

  Future<(pw.Document, String)?> _build() async {
    final t = context.t;
    final language = Localizations.localeOf(context).languageCode;
    final content = _content();
    setState(() => _busy = true);
    try {
      final fonts = await pdfFontsFor(language);
      return (
        missingPosterPdf(content, fonts),
        '${content.name} ${t.posterHeadline}.pdf',
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share() async {
    final built = await _build();
    if (built == null || !mounted) return;
    await (widget.share ?? sharePdf)(built.$1, built.$2);
  }

  Future<void> _print() async {
    final built = await _build();
    if (built == null || !mounted) return;
    await (widget.print ?? printPdf)(built.$1);
  }

  /// Thumbnails of the cat's pictures to tick up to two, and a frame
  /// per ticked picture to drag and pinch.
  List<Widget> _photoSection(AppLocalizations t) {
    final images = store.images(widget.catId);
    if (images.isEmpty) return const [];
    final photos = _pictures();
    final chosen = photos.keys.toList();
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: Text(
          t.posterPhotos,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      SizedBox(
        height: 64,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final hash = images[i];
            final photo = imageProviderFor(store, hash);
            final on = photos.containsKey(hash);
            return InkWell(
              onTap: () => _togglePhoto(hash),
              child: Container(
                width: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: on
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: photo == null
                    ? const Icon(Icons.broken_image_outlined)
                    : Image(image: photo, fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
      if (chosen.isNotEmpty) ...[
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (i, hash) in chosen.indexed) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(
                child: PosterFrame(
                  key: ValueKey('frame-$hash'),
                  bytes: photos[hash]!.bytes,
                  aspect: posterFrameAspect(chosen.length, i),
                  onChanged: (p) {
                    photos[hash] = p;
                    _schedulePreview();
                  },
                ),
              ),
            ],
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            t.posterFrameHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final rows = _rows();
    final ticks = _ticks(rows);
    final ticked = [
      for (final r in rows)
        if (ticks.contains(r.id)) r,
    ];
    final qrFits = _qrPayload(ticked) != null;
    return Scaffold(
      // The same two buttons as the card page: share as PDF, print.
      appBar: AppBar(
        title: Text(t.posterMenu.replaceAll('…', '')),
        actions: [
          HelpButton(store: widget.store, screenId: 'poster'),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: t.shareAsPdf,
            onPressed: _busy ? null : _share,
          ),
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: t.print,
            onPressed: _busy ? null : _print,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // The page as it prints, redrawn after every change.
          if (_previewPng != null) ...[
            Text(
              t.posterPreview,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 595 / 842,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Image.memory(
                      _previewPng!,
                      fit: BoxFit.contain,
                      gaplessPlayback: true,
                    ),
                  ),
                ),
                if (_previewBusy)
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: LinearProgressIndicator(),
                  ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event),
            title: Text(t.missingSinceLabel),
            subtitle: Text(DateFormat.yMd(locale).format(_since)),
            onTap: () async {
              final picked = await pickDay(
                context,
                initial: _since,
                lastDate: DateTime.now(),
              );
              if (picked != null && mounted) _changed(() => _since = picked);
            },
          ),
          ..._photoSection(t),
          for (final r in rows)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: ticks.contains(r.id),
              onChanged: (v) => _changed(() {
                if (v == true) {
                  ticks.add(r.id);
                } else {
                  ticks.remove(r.id);
                }
              }),
              title: Text(_label(r)),
              subtitle: Text(_value(r)),
            ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _qr && qrFits,
            onChanged: qrFits ? (v) => _changed(() => _qr = v!) : null,
            title: Text(t.posterQr),
            subtitle: qrFits ? null : Text(t.posterQrTooBig),
          ),
          TextField(
            controller: _extra,
            decoration: InputDecoration(labelText: t.posterFreeText),
            maxLength: 60,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
