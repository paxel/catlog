import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../layout.dart';
import '../help.dart';
import '../field_editing.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import 'field_history_screen.dart';
import 'vet_report_screen.dart';

/// The timeline of an entity: every change in date order with Author —
/// or, when [field] is given, the history of that one Field.
///
/// Clowder timelines additionally weave in arrivals and departures of
/// Cats (derived from the Cats' membership histories — membership lives
/// on the Cat, see CONTEXT.md: Move). A tap corrects an entry, a long
/// press removes or restores it: a marker hides the row, nothing is
/// ever deleted, and hidden rows show on request.
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

  String get _locale => Localizations.localeOf(context).toString();

  String _date(DateTime d) => historyMoment(_locale, d);

  bool get _showVoided => store.localSetting(historyShowVoidedKey) == 'yes';

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
        ? store.timeline(widget.entityId, includeVoided: _showVoided)
        : store.fieldHistory(widget.entityId, widget.field!,
            includeVoided: _showVoided);
    final rows = <_Row>[
      for (final e in entries.where((e) =>
          e.field != Keys.type &&
          e.field != Keys.private &&
          !e.field.startsWith(Keys.conflictPrefix) &&
          !e.field.startsWith(Keys.voidPrefix) &&
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

  /// The definition an entry's value is edited with: a user field's own,
  /// a plain text one for the name; nothing for memberships, chores and
  /// the rest, which have editors of their own.
  FieldDef? _defOf(Entry e) {
    if (e.field == Keys.name) {
      return FieldDef(
        id: 'fielddef:name',
        slug: 'name',
        name: fieldLabel(context.t, store, e.field),
        type: FieldType.text,
        scope: FieldScope.cat,
      );
    }
    if (!e.field.startsWith('f:')) return null;
    for (final def in store.fieldDefs()) {
      if (def.key == e.field) return def;
    }
    return null;
  }

  Future<void> _correct(Entry e) async {
    final def = _defOf(e);
    if (def == null) return;
    final edit = await editFieldValue(
      context,
      def,
      e.value,
      store: store,
      excludeId: e.entity,
      asOf: e.date,
    );
    if (edit == null || !mounted) return;
    store.correctEntry(e.seq, edit.value, date: edit.date);
    if (edit.private != store.isFieldPrivate(e.entity, e.field)) {
      store.setFieldPrivate(e.entity, e.field, edit.private);
    }
    setState(() {});
  }

  void _remove(Entry entry) {
    store.removeEntry(entry.seq);
    final restored = store.current(entry.entity, entry.field);
    setState(() {});
    final label = fieldLabel(context.t, store, entry.field);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(restored == null
          ? context.t.fieldCleared(label)
          : context.t.fieldBackTo(
              label, valueLabel(context.t, store, entry.field, restored))),
    ));
  }

  void _entryMenu(Entry entry) {
    final t = context.t;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(children: [
          if (entry.voided)
            ListTile(
              leading: const Icon(Icons.restore),
              title: Text(t.restoreThisValue),
              onTap: () {
                Navigator.of(sheetContext).pop();
                store.restoreEntry(entry.seq);
                setState(() {});
              },
            )
          else ...[
            if (_defOf(entry) != null)
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: Text(t.correctThisValue),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _correct(entry);
                },
              ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: Text(t.removeThisValue),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _remove(entry);
              },
            ),
          ],
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
      appBar: roomyAppBar(
        context,
        title: Text(widget.field == null
            ? context.t.timelineOf(name)
            : context.t.fieldHistoryOf(
                fieldLabel(context.t, store, widget.field!), name)),
        actions: [
          IconButton(
            icon: Icon(_showVoided
                ? Icons.visibility_off_outlined
                : Icons.visibility),
            tooltip: _showVoided
                ? context.t.hideRemovedValues
                : context.t.showRemovedValues,
            onPressed: () {
              store.setLocalSetting(
                  historyShowVoidedKey, _showVoided ? 'no' : 'yes');
              setState(() {});
            },
          ),
          if (widget.entityId.startsWith('cat:'))
            IconButton(
              icon: const Icon(Icons.picture_as_pdf_outlined),
              tooltip: context.t.vetReportMenu,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    VetReportScreen(store: store, catId: widget.entityId),
              )),
            ),
          HelpButton(store: store, screenId: 'timeline'),
        ],
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, i) {
          final row = rows[i];
          final e = row.entry;
          final correctable = CatalogStore.isCorrectable(e.field);
          final muted = Theme.of(context).colorScheme.onSurfaceVariant;
          return ListTile(
            leading: Icon(row.icon, color: e.voided ? muted : null),
            title: Text(
              row.title,
              style: e.voided
                  ? TextStyle(
                      color: muted, decoration: TextDecoration.lineThrough)
                  : null,
            ),
            subtitle: Text(e.voided
                ? '${_date(e.date)} · ${e.author}\n'
                    '${voidedLine(context.t, store, e.field, e, _locale)}'
                : '${_date(e.date)} · ${e.author}'),
            isThreeLine: e.voided,
            onTap: correctable && !e.voided && _defOf(e) != null
                ? () => _correct(e)
                : null,
            onLongPress: correctable ? () => _entryMenu(e) : null,
          );
        },
      ),
    );
  }
}
