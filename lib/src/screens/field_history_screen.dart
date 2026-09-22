import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../field_editing.dart';
import '../field_labels.dart';
import '../help.dart';
import '../history_share.dart';
import '../l10n.dart';
import '../layout.dart';
import '../spotlight.dart';
import '../pdf_fonts.dart';
import 'map_screen.dart';

/// The values a field has held, newest first: facts only. Cleared
/// values, plans (reminder entries) and bookkeeping are left out;
/// corrected and removed values come only with [includeVoided], marked.
List<Entry> valueHistory(
  CatalogStore store,
  String entityId,
  String field, {
  bool includeVoided = false,
}) => [
  for (final e in store.fieldHistory(
    entityId,
    field,
    includeVoided: includeVoided,
  ))
    if (!e.reminder && e.value != null) e,
];

/// Whether the field has a history worth a page: two values or more.
bool hasValueHistory(CatalogStore store, String entityId, String field) =>
    valueHistory(store, entityId, field).length >= 2;

/// Remembered on this device: whether the history reads oldest first.
const historyOldestFirstKey = 'historyOldestFirst';

/// Remembered on this device: whether corrected and removed values show.
const historyShowVoidedKey = 'historyShowVoided';

/// A moment as the history writes it: date and time of day.
String historyMoment(String locale, DateTime d) =>
    DateFormat.yMd(locale).add_Hm().format(d.toLocal());

/// The history's lines for the clipboard and the PDF, in the order
/// given: moment, value, author, and what happened to a hidden value.
List<HistoryLine> historyLines(
  AppLocalizations t,
  CatalogStore store,
  FieldDef def,
  List<Entry> entries,
  String locale,
) => [
  for (final e in entries)
    (
      when: historyMoment(locale, e.date),
      value: valueLabel(t, store, def.key, e.value),
      who: e.author,
      note: e.voided ? voidedLine(t, store, def.key, e, locale) : '',
    ),
];

/// The history as plain text: the cat and the field on top, one line
/// per value with its moment and author, in the order given; a hidden
/// value says so.
String historyAsText(
  AppLocalizations t,
  CatalogStore store,
  String entityId,
  FieldDef def,
  List<Entry> entries,
  String locale,
) => historyText(
  store.current(entityId, Keys.name) ?? t.unnamed,
  fieldDefName(t, def),
  historyLines(t, store, def, entries, locale),
);

/// What happened to a hidden value: replaced by which value, or
/// removed, by whom and when.
String voidedLine(
  AppLocalizations t,
  CatalogStore store,
  String field,
  Entry e,
  String locale,
) {
  final marker = store.voidMarker(e);
  final who = marker?.author ?? '';
  final when = marker == null ? '' : historyMoment(locale, marker.recorded);
  final replacement = store.replacementOf(e);
  return replacement == null
      ? t.entryRemovedBy(who, when)
      : t.entryReplacedBy(
          valueLabel(t, store, field, replacement.value),
          who,
          when,
        );
}

/// A field's values over time as a diary — for remarks kept as notes,
/// a status that changed hands, anything without a curve. Newest first,
/// or oldest first on request; shareable as text. A tap on a value
/// corrects it (the new value takes its place, the old one hides), the
/// bin removes it, a removed one shows on request with its way back.
class FieldHistoryScreen extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final FieldDef def;

  const FieldHistoryScreen({
    super.key,
    required this.store,
    required this.entityId,
    required this.def,
  });

  @override
  State<FieldHistoryScreen> createState() => _FieldHistoryScreenState();
}

class _FieldHistoryScreenState extends State<FieldHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => runSpotlights(context, store, 'history'),
    );
  }

  CatalogStore get store => widget.store;

  bool get _oldestFirst => store.localSetting(historyOldestFirstKey) == 'yes';

  bool get _showVoided => store.localSetting(historyShowVoidedKey) == 'yes';

  List<Entry> get _entries {
    final list = valueHistory(
      store,
      widget.entityId,
      widget.def.key,
      includeVoided: _showVoided,
    );
    return _oldestFirst ? list.reversed.toList() : list;
  }

  void _flip() {
    store.setLocalSetting(historyOldestFirstKey, _oldestFirst ? 'no' : 'yes');
    setState(() {});
  }

  void _flipVoided() {
    store.setLocalSetting(historyShowVoidedKey, _showVoided ? 'no' : 'yes');
    setState(() {});
  }

  Future<void> _copy() => copyText(
    context,
    historyAsText(
      context.t,
      store,
      widget.entityId,
      widget.def,
      _entries,
      Localizations.localeOf(context).toString(),
    ),
  );

  Future<void> _sharePdf() async {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final name = store.current(widget.entityId, Keys.name) ?? t.unnamed;
    final fonts = await pdfFontsFor(
      Localizations.localeOf(context).languageCode,
    );
    final doc = historyPdf(
      title: name,
      subtitle: fieldDefName(t, widget.def),
      lines: historyLines(t, store, widget.def, _entries, locale),
      whenHeader: t.colWhen,
      valueHeader: t.colValue,
      whoHeader: t.colWho,
      theme: fonts.theme,
      warning: fonts.complete ? null : t.pdfFontMissing,
    );
    await sharePdf(doc, '$name ${fieldDefName(t, widget.def)}.pdf');
  }

  Future<void> _correct(Entry e) async {
    final edit = await editFieldValue(
      context,
      widget.def,
      e.value,
      store: store,
      excludeId: widget.entityId,
      asOf: e.date,
    );
    if (edit == null || !mounted) return;
    store.correctEntry(e.seq, edit.value, date: edit.date);
    if (edit.private != store.isFieldPrivate(widget.entityId, widget.def.key)) {
      store.setFieldPrivate(widget.entityId, widget.def.key, edit.private);
    }
    setState(() {});
  }

  void _remove(Entry e) {
    store.removeEntry(e.seq);
    setState(() {});
  }

  void _restore(Entry e) {
    store.restoreEntry(e.seq);
    setState(() {});
  }

  /// The spot a location value names; null for any other field.
  LatLng? _spotOf(Entry e) {
    if (widget.def.type != FieldType.location) return null;
    final pos = CatalogStore.parsePosition(e.value);
    return pos == null ? null : LatLng(pos.$1, pos.$2);
  }

  /// The map centered on the value's spot, with the field's trail on
  /// and this value's dot marked.
  Future<void> _showOnMap(Entry e, LatLng spot) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MapScreen(
          store: store,
          initialCenter: spot,
          focus: (widget.entityId, spot),
          trailOf: (widget.entityId, widget.def.key),
          dot: e.seq,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final name = store.current(widget.entityId, Keys.name) ?? t.unnamed;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return Scaffold(
      appBar: roomyAppBar(
        context,
        title: Text(t.fieldHistoryOf(fieldDefName(t, widget.def), name)),
        actions: [
          HelpButton(store: store, screenId: 'history'),
          IconButton(
            icon: Icon(
              _oldestFirst ? Icons.arrow_upward : Icons.arrow_downward,
            ),
            tooltip: _oldestFirst ? t.sortNewestFirst : t.sortOldestFirst,
            onPressed: _flip,
          ),
          IconButton(
            icon: Icon(
              _showVoided ? Icons.visibility_off_outlined : Icons.visibility,
            ),
            tooltip: _showVoided ? t.hideRemovedValues : t.showRemovedValues,
            onPressed: _flipVoided,
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: t.copyText,
            onPressed: _copy,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: t.shareAsPdf,
            onPressed: _sharePdf,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final (i, e) in _entries.indexed)
            if (i == 0)
              Spotlight(
                id: 'history-hold',
                child: _card(e, t, locale, theme, muted),
              )
            else
              _card(e, t, locale, theme, muted),
        ],
      ),
    );
  }

  /// The shape every history row has: tap corrects, the bin removes, a
  /// removed value offers its way back; a location value leads to the
  /// map.
  Widget _card(
    Entry e,
    AppLocalizations t,
    String locale,
    ThemeData theme,
    Color muted,
  ) {
    final spot = _spotOf(e);
    return Card(
      child: ListTile(
        onTap: e.voided ? null : () => _correct(e),
        title: Text(
          valueLabel(t, store, widget.def.key, e.value),
          style: e.voided
              ? theme.textTheme.bodyLarge?.copyWith(
                  color: muted,
                  decoration: TextDecoration.lineThrough,
                )
              : theme.textTheme.bodyLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${historyMoment(locale, e.date)} · ${e.author}',
              style: theme.textTheme.bodySmall,
            ),
            if (e.voided)
              Text(
                voidedLine(t, store, widget.def.key, e, locale),
                style: theme.textTheme.bodySmall?.copyWith(color: muted),
              )
            else if (store.correctedBy(e) != null)
              Text(
                t.entryCorrection,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (spot != null)
              IconButton(
                icon: const Icon(Icons.map_outlined),
                tooltip: t.showOnMap,
                onPressed: () => _showOnMap(e, spot),
              ),
            if (e.voided)
              IconButton(
                icon: const Icon(Icons.restore),
                tooltip: t.restoreThisValue,
                onPressed: () => _restore(e),
              )
            else
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: t.removeThisValue,
                onPressed: () => _remove(e),
              ),
          ],
        ),
      ),
    );
  }
}
