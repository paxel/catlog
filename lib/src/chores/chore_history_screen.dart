import 'dart:convert';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n.dart';
import '../share.dart';

/// Remembered on this device: whether the log reads oldest first.
const choreLogOldestFirstKey = 'choreLogOldestFirst';

/// The chore's log, day by day: done when and by whom, missed, or still
/// open — the page a medicine needs. Newest first, or oldest first on
/// request; shareable as text.
class ChoreHistoryScreen extends StatefulWidget {
  final CatalogStore store;
  final Chore chore;

  const ChoreHistoryScreen({
    super.key,
    required this.store,
    required this.chore,
  });

  @override
  State<ChoreHistoryScreen> createState() => _ChoreHistoryScreenState();
}

class _ChoreHistoryScreenState extends State<ChoreHistoryScreen> {
  CatalogStore get store => widget.store;

  bool get _oldestFirst => store.localSetting(choreLogOldestFirstKey) == 'yes';

  List<ChoreLogRow> get _rows {
    final rows = store.choreLog(widget.chore, DateTime.now());
    return _oldestFirst ? rows.reversed.toList() : rows;
  }

  String _line(AppLocalizations t, String locale, ChoreLogRow r) {
    final day = DateFormat.yMEd(locale);
    switch (r.state) {
      case ChoreDay.done:
        final when = r.recorded == null
            ? day.format(r.doneOn!)
            : DateFormat.yMd(locale).add_Hm().format(r.recorded!.toLocal());
        final base = t.choreDoneAt(when, r.author ?? '');
        if (r.early) return '$base · ${t.choreDoneEarly}';
        if (r.late) return '$base · ${t.choreDoneLate}';
        return base;
      case ChoreDay.missed:
        return t.choreMissed;
      case ChoreDay.pending:
        return t.choreStillOpen;
      default:
        return '';
    }
  }

  Future<void> _share() async {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final name = store.current(widget.chore.entity, Keys.name) ?? t.unnamed;
    final text = [
      '${widget.chore.title} · $name',
      for (final r in _rows)
        '${DateFormat.yMEd(locale).format(r.due)} · ${_line(t, locale, r)}',
    ].join('\n');
    await shareFiles(context, [
      XFile.fromData(
        Uint8List.fromList(utf8.encode(text)),
        mimeType: 'text/plain',
        name: '$name ${widget.chore.title}.txt',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final name = store.current(widget.chore.entity, Keys.name) ?? t.unnamed;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.chore.title} · $name'),
        actions: [
          IconButton(
            icon: Icon(
              _oldestFirst ? Icons.arrow_upward : Icons.arrow_downward,
            ),
            tooltip: _oldestFirst ? t.sortNewestFirst : t.sortOldestFirst,
            onPressed: () {
              store.setLocalSetting(
                choreLogOldestFirstKey,
                _oldestFirst ? 'no' : 'yes',
              );
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.ios_share),
            tooltip: t.shareAsText,
            onPressed: _share,
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final r in _rows)
            ListTile(
              leading: Icon(
                switch (r.state) {
                  ChoreDay.done => Icons.check_circle,
                  ChoreDay.missed => Icons.cancel_outlined,
                  _ => Icons.radio_button_unchecked,
                },
                color: switch (r.state) {
                  ChoreDay.done => Colors.green,
                  ChoreDay.missed => theme.colorScheme.error,
                  _ => null,
                },
              ),
              title: Text(DateFormat.yMEd(locale).format(r.due)),
              subtitle: Text(_line(t, locale, r)),
            ),
        ],
      ),
    );
  }
}
