import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../layout.dart';
import '../help.dart';
import '../field_editing.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../celebration.dart';
import 'field_history_screen.dart';
import 'map_screen.dart';

/// The timeline of an entity: every change in date order with Author —
/// or, when [field] is given, the history of that one Field.
///
/// Clowder timelines additionally weave in arrivals and departures of
/// Cats (derived from the Cats' membership histories — membership lives
/// on the Cat, see CONTEXT.md: Move). A tap corrects an entry, the bin
/// removes it and a removed row offers its way back: a marker hides the
/// row, nothing is ever deleted, and hidden rows show on request.
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

  /// The day a chore tick counts for, from its key; null for any other
  /// entry.
  String? _tickDue(Entry e) {
    if (!e.field.startsWith(Keys.chorePrefix)) return null;
    final at = e.field.indexOf('@');
    return at < 0 ? null : e.field.substring(at + 1);
  }

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
        else if (_tickDue(e) case final due?)
          // A tick: which chore, and the day it counts for when that is
          // not the day it was ticked on.
          _Row(
              e,
              Icons.check_circle_outline,
              due == dayKey(dayOf(e.date.toLocal()))
                  ? fieldLabel(t, store, e.field)
                  : '${fieldLabel(t, store, e.field)} · ${t.choreDoneFor(DateFormat.yMEd(_locale).format(DateTime.parse(due)))}')
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
    setState(() {});
    paw(context);
  }

  /// The spot a position or location value names; null for any other
  /// row.
  LatLng? _spotOf(Entry e) {
    if (e.field != CatalogStore.positionKey &&
        _defOf(e)?.type != FieldType.location) {
      return null;
    }
    final pos = CatalogStore.parsePosition(e.value);
    return pos == null ? null : LatLng(pos.$1, pos.$2);
  }

  /// The map centered on the row's spot, with the field's trail on and
  /// this value's dot marked.
  Future<void> _showOnMap(Entry e, LatLng spot) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => MapScreen(
        store: store,
        initialCenter: spot,
        focus: (e.entity, spot),
        trailOf: (e.entity, e.field),
        dot: e.seq,
      ),
    ));
    if (mounted) setState(() {});
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
          HelpButton(store: store, screenId: 'timeline'),
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
        ],
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, i) {
          final row = rows[i];
          final e = row.entry;
          final correctable = CatalogStore.isCorrectable(e.field);
          final muted = Theme.of(context).colorScheme.onSurfaceVariant;
          final spot = _spotOf(e);
          final tile = ListTile(
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
            // A position leads to the map: the spot, the trail, this
            // dot. The bin removes, a removed row offers its way back.
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              if (spot != null)
                IconButton(
                  icon: const Icon(Icons.map_outlined),
                  tooltip: context.t.showOnMap,
                  onPressed: () => _showOnMap(e, spot),
                ),
              if (correctable && e.voided)
                IconButton(
                  icon: const Icon(Icons.restore),
                  tooltip: context.t.restoreThisValue,
                  onPressed: () {
                    store.restoreEntry(e.seq);
                    setState(() {});
                  },
                )
              else if (correctable)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: context.t.removeThisValue,
                  onPressed: () => _remove(e),
                ),
            ]),
            onTap: correctable && !e.voided && _defOf(e) != null
                ? () => _correct(e)
                : null,
          );
          return tile;
        },
      ),
    );
  }
}
