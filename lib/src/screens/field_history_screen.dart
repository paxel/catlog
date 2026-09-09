import 'dart:convert';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../field_labels.dart';
import '../l10n.dart';
import '../share.dart';

/// The values a field has held, newest first: facts only. Cleared
/// values, plans (reminder entries) and bookkeeping are left out; a
/// revert shows as the value it brought back, on its date.
List<Entry> valueHistory(CatalogStore store, String entityId, String field) => [
  for (final e in store.fieldHistory(entityId, field))
    if (!e.reminder && e.value != null) e,
];

/// Whether the field has a history worth a page: two values or more.
bool hasValueHistory(CatalogStore store, String entityId, String field) =>
    valueHistory(store, entityId, field).length >= 2;

/// Remembered on this device: whether the history reads oldest first.
const historyOldestFirstKey = 'historyOldestFirst';

/// The history as plain text for the share sheet: the cat and the
/// field on top, one line per value with its date and author, in the
/// order given.
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
      '${DateFormat.yMd(locale).add_Hm().format(e.date.toLocal())} · '
          '${valueLabel(t, store, def.key, e.value)} · ${e.author}',
  ].join('\n');
}

/// A field's values over time as a diary — for remarks kept as notes,
/// a status that changed hands, anything without a curve. Read-only:
/// reverting lives on the edit-mode timeline. Newest first, or oldest
/// first on request; shareable as text.
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

  List<Entry> get _entries {
    final list = valueHistory(store, widget.entityId, widget.def.key);
    return _oldestFirst ? list.reversed.toList() : list;
  }

  void _flip() {
    store.setLocalSetting(historyOldestFirstKey, _oldestFirst ? 'no' : 'yes');
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

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final name = store.current(widget.entityId, Keys.name) ?? t.unnamed;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueLabel(t, store, widget.def.key, e.value),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${DateFormat.yMd(locale).add_Hm().format(e.date.toLocal())} · ${e.author}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
