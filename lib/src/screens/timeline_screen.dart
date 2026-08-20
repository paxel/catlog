import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../help.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';

/// The timeline of an entity: every change in date order with Author —
/// or, when [field] is given, the history of that one Field.
///
/// Clowder timelines additionally weave in arrivals and departures of
/// Cats (derived from the Cats' membership histories — membership lives
/// on the Cat, see CONTEXT.md: Move). Entries can be reverted git-style:
/// the previous value is appended as a new, authored entry at the
/// current time; nothing is ever deleted.
class TimelineScreen extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final String? field;

  const TimelineScreen(
      {super.key, required this.store, required this.entityId, this.field});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _Row {
  final Entry entry;
  final IconData icon;
  final String title;
  const _Row(this.entry, this.icon, this.title);
}

class _TimelineScreenState extends State<TimelineScreen> {
  CatalogStore get store => widget.store;

  String _clowderName(String? id) => id == null
      ? context.t.stray
      : store.current(id, Keys.name) ?? context.t.unnamed;

  String _date(DateTime d) =>
      DateFormat.yMd(Localizations.localeOf(context).toString())
          .format(d.toLocal());

  /// Friendly rendering for a Cat's own membership entry.
  _Row _membershipRow(Entry e) => _Row(
        e,
        e.value == null ? Icons.explore : Icons.drive_file_move_outline,
        e.value == null
            ? context.t.leftStray
            : context.t.movedTo(_clowderName(e.value)),
      );

  List<_Row> _rows() {
    final t = context.t;
    final entries = widget.field == null
        ? store.timeline(widget.entityId)
        : store.fieldHistory(widget.entityId, widget.field!);
    final rows = <_Row>[
      for (final e in entries.where((e) =>
          e.field != Keys.type &&
          e.field != Keys.private &&
          !e.field.startsWith(Keys.conflictPrefix) &&
          (showHidden.value ||
              !e.field.startsWith('f:') ||
              !store.isHidden('fielddef:${e.field.substring(2)}'))))
        if (e.field == Keys.clowder)
          _membershipRow(e)
        else if (e.field == Keys.mergedInto)
          _Row(e, Icons.merge, t.duplicateMergedIn)
        else
          _Row(e, Icons.history,
              '${fieldLabel(t, store, e.field)}: ${valueLabel(t, store, e.field, e.value)}'),
    ];
    // Clowder timeline: weave in cat arrivals/departures.
    if (widget.field == null && widget.entityId.startsWith('clowder:')) {
      for (final ev in store.clowderOccupancy(widget.entityId)) {
        final cat = store.current(ev.catId, Keys.name) ?? t.unnamed;
        rows.add(_Row(
          ev.entry,
          ev.arrived ? Icons.login : Icons.logout,
          ev.arrived
              ? (ev.counterpart == null
                  ? t.arrivedPlain(cat)
                  : t.arrivedFrom(cat, _clowderName(ev.counterpart)))
              : t.leftTo(cat, _clowderName(ev.counterpart)),
        ));
      }
      rows.sort((a, b) {
        final byDate = b.entry.date.compareTo(a.entry.date);
        if (byDate != 0) return byDate;
        return b.entry.seq.compareTo(a.entry.seq);
      });
    }
    return rows;
  }

  void _entryMenu(Entry entry) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.undo),
            title: Text(context.t.revertThisChange),
            subtitle: Text(context.t.revertSubtitle),
            onTap: () {
              Navigator.of(sheetContext).pop();
              final restored = store.revertEntry(entry.seq);
              setState(() {});
              final label = fieldLabel(context.t, store, entry.field);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(restored == null
                    ? context.t.fieldCleared(label)
                    : context.t.fieldBackTo(label,
                        valueLabel(context.t, store, entry.field, restored))),
              ));
            },
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name =
        store.current(widget.entityId, Keys.name) ?? context.t.unnamed;
    final rows = _rows();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.field == null
            ? context.t.timelineOf(name)
            : context.t.fieldHistoryOf(
                fieldLabel(context.t, store, widget.field!), name)),
        actions: [HelpButton(store: store, screenId: 'timeline')],
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, i) {
          final row = rows[i];
          final e = row.entry;
          final revertable = CatalogStore.isRevertable(e.field);
          return ListTile(
            leading: Icon(row.icon),
            title: Text(row.title),
            subtitle: Text('${_date(e.date)} · ${e.author}'),
            trailing: revertable ? const Icon(Icons.undo, size: 18) : null,
            onTap: revertable ? () => _entryMenu(e) : null,
          );
        },
      ),
    );
  }
}
