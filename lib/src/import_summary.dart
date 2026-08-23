import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'event_toasts.dart';
import 'field_labels.dart';
import 'l10n.dart';
import 'undo_import.dart';
import 'widgets/cat_avatar.dart';

/// What one sync/import actually meant, in fosterer terms.
class ImportSummary {
  final List<String> adopted; // cat ids
  final List<String> deceased; // cat ids
  final List<String> escaped; // cat ids
  final List<String> newCats; // cat ids
  final List<String> newClowders; // clowder ids
  final int conflicts;
  final int other;

  const ImportSummary({
    required this.adopted,
    required this.deceased,
    required this.escaped,
    required this.newCats,
    required this.newClowders,
    required this.conflicts,
    required this.other,
  });

  bool get isEmpty =>
      adopted.isEmpty &&
      deceased.isEmpty &&
      escaped.isEmpty &&
      newCats.isEmpty &&
      newClowders.isEmpty &&
      conflicts == 0 &&
      other == 0;
}

/// Classifies applied entries against the post-import store state.
ImportSummary classifyImport(CatalogStore store, List<Entry> applied) {
  final adopted = <String>{};
  final deceased = <String>{};
  final escaped = <String>{};
  final newCats = <String>{};
  final newClowders = <String>{};
  var conflicts = 0;
  var other = 0;
  for (final e in applied) {
    final entity = store.resolveEntity(e.entity);
    // Field definitions are configuration, not news. Every catalog is
    // seeded with the same starter Fields, so an empty catalog arriving
    // used to report "58 other changes" — the definitions, not one cat.
    if (entity.startsWith('${Kinds.fieldDef}:') ||
        store.current(entity, Keys.type) == Kinds.fieldDef) {
      continue;
    }
    if (e.field == Keys.type) {
      if (e.value == Kinds.cat) {
        newCats.add(entity);
      } else if (e.value == Kinds.clowder) {
        newClowders.add(entity);
      }
    } else if (e.field == Keys.clowder) {
      if (e.value == null) {
        escaped.add(entity);
      } else if (store.current(store.resolveEntity(e.value!), 'f:status') ==
          'forever-home') {
        adopted.add(entity);
      } else {
        other++;
      }
    } else if (e.field == 'f:deceased' && e.value != null) {
      deceased.add(entity);
    } else if (e.field.startsWith(Keys.conflictPrefix)) {
      if (e.value == 'open') conflicts++;
    } else if (e.field == Keys.private ||
        e.field.startsWith(Keys.privatePrefix) ||
        e.field.startsWith(Keys.withheldPrefix)) {
      // Marker bookkeeping, not news.
    } else {
      other++;
    }
  }
  // A brand-new cat's own membership/deceased rows are not events —
  // they are part of "new".
  adopted.removeAll(newCats);
  escaped.removeAll(newCats);
  deceased.removeWhere(newCats.contains);
  return ImportSummary(
    adopted: adopted.toList(),
    deceased: deceased.toList(),
    escaped: escaped.toList(),
    newCats: newCats.toList(),
    newClowders: newClowders.toList(),
    conflicts: conflicts,
    other: other,
  );
}

/// Shows the post-sync sheet when anything arrived. New arrivals carry a
/// hide toggle — the "import filter" is a hide, by design.
Future<void> showImportSummary(
    BuildContext context, CatalogStore store, List<Entry> applied,
    {Moment? undo, SaveFile? saveTo}) async {
  // An archive file coming home: what it carries is deleted here, and
  // deletion outranks every entry in the file. Ask before undoing it.
  final restorable = restorableEntities(store, applied);
  if (restorable.isNotEmpty && context.mounted) {
    final t = context.t;
    final names = [
      for (final id in restorable)
        store.current(id, Keys.name) ?? t.unnamed
    ];
    final restore = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.restoreDeletedTitle(restorable.length)),
        content: Text(t.restoreDeletedBody(names.join(', '))),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.keepDeleted)),
          FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.restoreAction)),
        ],
      ),
    );
    if (restore == true) {
      for (final id in restorable) {
        store.restoreEntity(id);
      }
    }
  }
  final summary = classifyImport(store, applied);
  if (summary.isEmpty || !context.mounted) return;
  await showModalBottomSheet<void>(
    context: context,
    builder: (context) => _SummarySheet(
        store: store,
        summary: summary,
        applied: applied,
        undo: undo,
        saveTo: saveTo),
  );
  // The emotional echo after the sober digest.
  if (context.mounted) showEventToasts(context, store, applied);
}

class _SummarySheet extends StatefulWidget {
  final CatalogStore store;
  final ImportSummary summary;
  final List<Entry> applied;

  /// The moment before this import, when there is one to go back to.
  final Moment? undo;
  final SaveFile? saveTo;

  const _SummarySheet(
      {required this.store,
      required this.summary,
      required this.applied,
      this.undo,
      this.saveTo});

  @override
  State<_SummarySheet> createState() => _SummarySheetState();
}

class _SummarySheetState extends State<_SummarySheet> {
  CatalogStore get store => widget.store;

  String _name(String id) => store.current(id, Keys.name) ?? '?';

  Widget _section(String title, List<String> ids,
      {IconData? icon, bool hideToggle = false}) {
    if (ids.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(title, style: Theme.of(context).textTheme.titleSmall),
      ),
      for (final id in ids)
        ListTile(
          dense: true,
          leading: id.startsWith('cat:')
              ? CatAvatar(store: store, catId: id, size: 36)
              : Icon(icon ?? Icons.home_outlined),
          title: Text(_name(id)),
          trailing: hideToggle
              ? IconButton(
                  icon: Icon(store.isHidden(id)
                      ? Icons.visibility_off
                      : Icons.visibility_outlined),
                  tooltip: store.isHidden(id)
                      ? context.t.unhideLabel
                      : context.t.hideLabel,
                  onPressed: () => setState(
                      () => store.setHidden(id, !store.isHidden(id))),
                )
              : null,
        ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final s = widget.summary;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(t.syncSummaryTitle,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          _section('💚 ${t.summaryAdopted}', s.adopted),
          _section(t.summaryDeceased, s.deceased),
          _section(t.summaryEscaped, s.escaped),
          _section(t.summaryNew, [...s.newCats, ...s.newClowders],
              hideToggle: true),
          if (s.conflicts > 0)
            ListTile(
              dense: true,
              leading:
                  const Icon(Icons.warning_amber, color: Colors.amber),
              title: Text('${t.summaryConflicts}: ${s.conflicts}'),
            ),
          if (s.other > 0)
            ListTile(
              dense: true,
              leading: const Icon(Icons.history),
              title: Text(t.summaryOther('${s.other}')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => _SyncChangesScreen(
                    store: store, applied: widget.applied),
              )),
            ),
          // Where somebody realises they imported the wrong file.
          if (widget.undo != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: OutlinedButton.icon(
                icon: const Icon(Icons.undo),
                label: Text(t.undoThisImport),
                onPressed: () async {
                  final done = await confirmUndoImport(
                      context, store, widget.undo!,
                      saveTo: widget.saveTo);
                  if (done && context.mounted) Navigator.of(context).pop();
                },
              ),
            ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}

/// Every entry of one sync, human-readable — the "other changes" drill-in.
class _SyncChangesScreen extends StatelessWidget {
  final CatalogStore store;
  final List<Entry> applied;

  const _SyncChangesScreen({required this.store, required this.applied});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.syncSummaryTitle)),
      body: ListView(children: [
        for (final e in applied.reversed)
          if (e.field != Keys.type && e.field != Keys.private)
            ListTile(
              dense: true,
              title: Text(
                  '${store.current(store.resolveEntity(e.entity), Keys.name) ?? ''}'
                  ' — ${fieldLabel(t, store, e.field)}: '
                  '${valueLabel(t, store, e.field, e.value)}'),
              subtitle: Text(
                  '${e.date.toLocal().toIso8601String().substring(0, 10)} · ${e.author}'),
            ),
      ]),
    );
  }
}
