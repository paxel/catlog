import 'dart:convert';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../field_editing.dart';
import '../field_labels.dart';
import '../l10n.dart';
import '../share.dart';

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

/// The history as plain text for the share sheet: the cat and the
/// field on top, one line per value with its moment and author, in the
/// order given; a hidden value says so.
String historyAsText(
  AppLocalizations t,
  CatalogStore store,
  String entityId,
  FieldDef def,
  List<Entry> entries,
  String locale,
) {
  final name = store.current(entityId, Keys.name) ?? t.unnamed;
  return [
    '$name · ${fieldDefName(t, def)}',
    for (final e in entries)
      '${historyMoment(locale, e.date)} · '
          '${valueLabel(t, store, def.key, e.value)} · ${e.author}'
          '${e.voided ? ' · ${voidedLine(t, store, def.key, e, locale)}' : ''}',
  ].join('\n');
}

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
/// corrects it (the new value takes its place, the old one hides), a
/// long press removes or restores it; hidden values show on request.
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

  Future<void> _share() async {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final text = historyAsText(
      t,
      store,
      widget.entityId,
      widget.def,
      _entries,
      locale,
    );
    final name = store.current(widget.entityId, Keys.name) ?? 'cat';
    await shareFiles(context, [
      XFile.fromData(
        Uint8List.fromList(utf8.encode(text)),
        mimeType: 'text/plain',
        name: '$name ${fieldDefName(t, widget.def)}.txt',
      ),
    ]);
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

  void _menu(Entry e) {
    final t = context.t;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheet) => SafeArea(
        child: Wrap(
          children: [
            if (e.voided)
              ListTile(
                leading: const Icon(Icons.restore),
                title: Text(t.restoreThisValue),
                onTap: () {
                  Navigator.of(sheet).pop();
                  _restore(e);
                },
              )
            else ...[
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: Text(t.correctThisValue),
                onTap: () {
                  Navigator.of(sheet).pop();
                  _correct(e);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(t.removeThisValue),
                onTap: () {
                  Navigator.of(sheet).pop();
                  _remove(e);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final name = store.current(widget.entityId, Keys.name) ?? t.unnamed;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.fieldHistoryOf(fieldDefName(t, widget.def), name)),
        actions: [
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
            icon: const Icon(Icons.ios_share),
            tooltip: t.shareAsText,
            onPressed: _share,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final e in _entries)
            Card(
              child: InkWell(
                onTap: e.voided ? null : () => _correct(e),
                onLongPress: () => _menu(e),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueLabel(t, store, widget.def.key, e.value),
                        style: e.voided
                            ? theme.textTheme.bodyLarge?.copyWith(
                                color: muted,
                                decoration: TextDecoration.lineThrough,
                              )
                            : theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${historyMoment(locale, e.date)} · ${e.author}',
                        style: theme.textTheme.bodySmall,
                      ),
                      if (e.voided)
                        Text(
                          voidedLine(t, store, widget.def.key, e, locale),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: muted,
                          ),
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}
