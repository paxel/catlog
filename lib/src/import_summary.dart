import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'conflict_dialog.dart';
import 'event_toasts.dart';
import 'field_labels.dart';
import 'l10n.dart';
import 'pet_mode.dart';
import 'undo_import.dart';
import 'widgets/cat_avatar.dart';

/// One field of a cat or a home that reads differently after an import
/// than before it. [field] is a key; a photo shows as [Keys.imagePrefix]
/// with the hash and [after] `deleted` when it went away.
class FieldChange {
  final String field;
  final String? before;
  final String? after;

  const FieldChange(this.field, this.before, this.after);

  bool get isPhoto => field.startsWith(Keys.imagePrefix);
}

/// A cat or a home the import touched: new to this catalog, or an
/// existing one with its effective changes. [tags] name the events among
/// them — adopted, deceased, escaped — for the row.
class EntityArrival {
  final String id;
  final bool isNew;
  final List<FieldChange> changes;
  final Set<String> tags;

  /// The arrived entries about this entity — what "Keep mine" discards.
  final List<Entry> entries;

  const EntityArrival(this.id,
      {required this.isNew,
      required this.changes,
      required this.tags,
      required this.entries});

  bool get isCat => id.startsWith('cat:');
}

/// What came along that is configuration or bookkeeping rather than
/// news about an animal.
enum MetaKind { fieldAdded, fieldChanged, fieldMerged, merged, mode, photos }

class MetaChange {
  final MetaKind kind;
  final String? entity;
  final String? target;
  final int count;

  const MetaChange(this.kind, {this.entity, this.target, this.count = 0});
}

/// Everything one import meant for this catalog, read against the
/// catalog as it is now: what is new, what changed and how, which
/// fields two people edited at once, and what else came along.
class ImportReview {
  final List<EntityArrival> newOnes;
  final List<EntityArrival> updated;

  /// Cats and homes you have that a partner deleted.
  final List<EntityArrival> deleted;
  final List<(String entity, String field)> conflicts;
  final List<MetaChange> meta;

  const ImportReview(
      {required this.newOnes,
      required this.updated,
      required this.deleted,
      required this.conflicts,
      required this.meta});

  bool get isEmpty =>
      newOnes.isEmpty &&
      updated.isEmpty &&
      deleted.isEmpty &&
      conflicts.isEmpty &&
      meta.isEmpty;

  List<String> get newCats => [for (final a in newOnes) if (a.isCat) a.id];
  List<String> get newClowders =>
      [for (final a in newOnes) if (!a.isCat) a.id];

  List<String> _tagged(String tag) =>
      [for (final a in updated) if (a.tags.contains(tag)) a.id];

  /// Known cats whose update was an adoption, a death, an escape — the
  /// toasts' input.
  List<String> get adopted => _tagged(tagAdopted);
  List<String> get deceased => _tagged(tagDeceased);
  List<String> get escaped => _tagged(tagEscaped);
}

const tagAdopted = 'adopted';
const tagDeceased = 'deceased';
const tagEscaped = 'escaped';

/// Reads [applied] against the store after the import. An entry that
/// changed nothing visible — older than what was here, so it lost — is
/// not a change; a cat with only such entries does not appear.
ImportReview reviewImport(CatalogStore store, List<Entry> applied) {
  final arrived = {for (final e in applied) (e.device, e.dseq)};
  bool isArrived(Entry e) => arrived.contains((e.device, e.dseq));
  final byEntity = <String, List<Entry>>{};
  for (final e in applied) {
    byEntity.putIfAbsent(store.resolveEntity(e.entity), () => []).add(e);
  }
  final newOnes = <EntityArrival>[];
  final updated = <EntityArrival>[];
  final deleted = <EntityArrival>[];
  final conflicts = <(String, String)>[];
  final meta = <MetaChange>[];
  var photos = 0;

  /// Nothing of this entity was here before the import.
  bool newHere(String entity) =>
      !store.fieldHistory(entity, Keys.type).any((e) => !isArrived(e));

  /// The value the field read before the import: the winner among the
  /// entries that were already here.
  String? before(String entity, String field) => store
      .fieldHistory(entity, field)
      .where((e) => !e.reminder && !isArrived(e))
      .firstOrNull
      ?.value;

  bool isMarker(String field) =>
      field == Keys.type ||
      field == Keys.deleted ||
      field == Keys.mergedInto ||
      field == Keys.private ||
      field == Keys.profileImage ||
      field.startsWith(Keys.privatePrefix) ||
      field.startsWith(Keys.withheldPrefix) ||
      field.startsWith(Keys.conflictPrefix);

  /// Each touched field once, only where the import changed what it
  /// reads. A brand-new entity lists everything it has.
  List<FieldChange> effective(String entity, List<Entry> entries,
      {required bool isNew}) {
    final changes = <FieldChange>[];
    for (final field in {for (final e in entries) e.field}) {
      if (isMarker(field)) continue;
      final after = store.current(entity, field);
      final was = isNew ? null : before(entity, field);
      if (!isNew && was == after) continue;
      changes.add(FieldChange(field, was, after));
    }
    return changes;
  }

  for (final MapEntry(key: entity, value: entries) in byEntity.entries) {
    if (isCatalogSetting(entity)) {
      if (effective(entity, entries, isNew: false)
          .any((c) => c.field == catalogModeField)) {
        meta.add(const MetaChange(MetaKind.mode));
      }
      continue;
    }
    final kind = store.current(entity, Keys.type);
    final isNew = newHere(entity);
    final mergedInto = entries
        .where((e) => e.field == Keys.mergedInto && e.value != null)
        .lastOrNull
        ?.value;
    if (entity.startsWith('${Kinds.fieldDef}:') || kind == Kinds.fieldDef) {
      if (mergedInto != null) {
        meta.add(MetaChange(MetaKind.fieldMerged,
            entity: entity, target: mergedInto));
      } else if (isNew) {
        meta.add(MetaChange(MetaKind.fieldAdded, entity: entity));
      } else if (effective(entity, entries, isNew: false).isNotEmpty) {
        meta.add(MetaChange(MetaKind.fieldChanged, entity: entity));
      }
      continue;
    }
    if (kind != Kinds.cat && kind != Kinds.clowder) continue;
    // Hidden is this device's business: what arrives for a hidden cat
    // syncs on unchanged and is not announced.
    if (store.isHidden(entity)) continue;
    if (mergedInto != null) {
      meta.add(MetaChange(MetaKind.merged, entity: entity, target: mergedInto));
    }
    // A partner deleted something you have: its own section, so the
    // keeper can keep it instead.
    if (!isNew &&
        entries.any((e) => e.field == Keys.deleted) &&
        store.current(entity, Keys.deleted) == 'true' &&
        before(entity, Keys.deleted) != 'true') {
      deleted.add(EntityArrival(entity,
          isNew: false, changes: const [], tags: const {}, entries: entries));
      continue;
    }

    final changes = effective(entity, entries, isNew: isNew);
    final tags = <String>{};
    for (final c in changes) {
      if (c.isPhoto) {
        if (c.after != 'deleted') photos++;
      } else if (c.field == Keys.clowder && !isNew) {
        if (c.after == null) {
          tags.add(tagEscaped);
        } else if (store.current(store.resolveEntity(c.after!), 'f:status') ==
            'forever-home') {
          tags.add(tagAdopted);
        }
      } else if (c.field == 'f:deceased' && c.after != null && !isNew) {
        tags.add(tagDeceased);
      }
    }
    // Open conflicts on the fields this import touched — raised by it,
    // or arriving flagged from a partner. Either way they need a look.
    for (final field in {for (final e in entries) e.field}) {
      final real = field.startsWith(Keys.conflictPrefix)
          ? field.substring(Keys.conflictPrefix.length)
          : field;
      if (store.hasConflict(entity, real) &&
          !conflicts.contains((entity, real))) {
        conflicts.add((entity, real));
      }
    }
    if (isNew) {
      newOnes.add(EntityArrival(entity,
          isNew: true, changes: changes, tags: const {}, entries: entries));
    } else if (changes.isNotEmpty) {
      updated.add(EntityArrival(entity,
          isNew: false, changes: changes, tags: tags, entries: entries));
    }
  }
  if (photos > 0) meta.add(MetaChange(MetaKind.photos, count: photos));

  String name(EntityArrival a) => store.current(a.id, Keys.name) ?? '';
  int byName(EntityArrival a, EntityArrival b) =>
      name(a).toLowerCase().compareTo(name(b).toLowerCase());
  newOnes.sort(byName);
  updated.sort(byName);
  deleted.sort(byName);
  return ImportReview(
      newOnes: newOnes,
      updated: updated,
      deleted: deleted,
      conflicts: conflicts,
      meta: meta);
}

/// Shows what arrived, when anything did: a full page with Accept and
/// Reject. The data is already in the catalog; Reject returns to the
/// moment before ([undo]), writing the removed entries to a file first.
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
  final review = reviewImport(store, applied);
  if (review.isEmpty || !context.mounted) return;
  await Navigator.of(context).push(MaterialPageRoute(
    fullscreenDialog: true,
    builder: (_) => ArrivalScreen(
        store: store, review: review, undo: undo, saveTo: saveTo),
  ));
  // The emotional echo after the sober digest.
  if (context.mounted) showEventToasts(context, store, applied);
}

/// The page after an import: new, updated, conflicts, and what else
/// came along, with Accept and Reject at the bottom. Back is Accept —
/// nothing is pending, the data is in place.
class ArrivalScreen extends StatefulWidget {
  final CatalogStore store;
  final ImportReview review;

  /// The moment before this import, when there is one to go back to.
  final Moment? undo;
  final SaveFile? saveTo;

  const ArrivalScreen(
      {super.key,
      required this.store,
      required this.review,
      this.undo,
      this.saveTo});

  @override
  State<ArrivalScreen> createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends State<ArrivalScreen> {
  CatalogStore get store => widget.store;

  /// A conflict was settled from this page. Rejecting now would undo
  /// that too, so Reject goes and says why.
  bool _resolved = false;

  /// Cats and homes whose arrival was discarded with "Keep mine": their
  /// rows leave the page.
  final _kept = <String>{};

  /// Drops what arrived about [a], for good and locally, and says so.
  void _keepMine(EntityArrival a) {
    final name = _name(a.id);
    store.discardEntries(a.entries);
    setState(() => _kept.add(a.id));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(context.t.keptMine(name))));
  }

  String _name(String id) => store.current(id, Keys.name) ?? context.t.unnamed;

  Widget _header(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(title, style: Theme.of(context).textTheme.titleSmall),
      );

  Widget _leading(String id) => id.startsWith('cat:')
      ? CatAvatar(store: store, catId: id, size: 36)
      : const Icon(Icons.home_outlined);

  String _tag(String tag) => switch (tag) {
        tagAdopted => context.t.summaryAdopted,
        tagDeceased => context.t.summaryDeceased,
        _ => context.t.summaryEscaped,
      };

  void _openChanges(EntityArrival a) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => _ChangesScreen(store: store, arrival: a),
    ));
  }

  Widget _entityRow(EntityArrival a) {
    final t = context.t;
    final subtitle = [
      if (!a.isNew) t.changesCount(a.changes.length),
      for (final tag in a.tags) _tag(tag),
    ].join(' · ');
    return ListTile(
      leading: _leading(a.id),
      title: Text(_name(a.id)),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        if (a.isNew)
          IconButton(
            icon: Icon(store.isHidden(a.id)
                ? Icons.visibility_off
                : Icons.visibility_outlined),
            tooltip: store.isHidden(a.id) ? t.unhideLabel : t.hideLabel,
            onPressed: () =>
                setState(() => store.setHidden(a.id, !store.isHidden(a.id))),
          )
        else
          TextButton(
              onPressed: () => _keepMine(a), child: Text(t.keepMine)),
        const Icon(Icons.chevron_right),
      ]),
      onTap: () => _openChanges(a),
    );
  }

  Widget _deletedRow(EntityArrival a) => ListTile(
        leading: _leading(a.id),
        title: Text(_name(a.id)),
        trailing: TextButton(
            onPressed: () => _keepMine(a), child: Text(context.t.keepMine)),
      );

  Widget _conflictRow((String, String) c) {
    final t = context.t;
    final (entity, field) = c;
    final candidates = store.fieldHistory(entity, field).take(2).toList();
    return ListTile(
      leading: const Icon(Icons.warning_amber, color: Colors.amber),
      title: Text('${_name(entity)} — ${fieldLabel(t, store, field)}'),
      subtitle: Text([
        for (final e in candidates)
          '${valueLabel(t, store, field, e.value)} (${e.author})'
      ].join(' · ')),
      onTap: () async {
        final changed = await showConflictDialog(context, store, entity, field);
        if (!mounted) return;
        setState(() => _resolved = _resolved || changed);
      },
    );
  }

  String _metaLine(MetaChange m) {
    final t = context.t;
    String nameOf(String? id) =>
        id == null ? '' : store.current(id, Keys.name) ?? t.unnamed;
    return switch (m.kind) {
      MetaKind.fieldAdded => t.metaFieldAdded(nameOf(m.entity)),
      MetaKind.fieldChanged => t.metaFieldChanged(nameOf(m.entity)),
      MetaKind.fieldMerged =>
        t.metaMerged(nameOf(m.entity), nameOf(m.target)),
      MetaKind.merged => t.metaMerged(nameOf(m.entity), nameOf(m.target)),
      MetaKind.mode =>
        '${t.catalogHolds}: ${isPetMode(store) ? t.modePets : t.modeCats}',
      MetaKind.photos => t.metaPhotos(m.count),
    };
  }

  Future<void> _reject() async {
    final done = await confirmUndoImport(context, store, widget.undo!,
        saveTo: widget.saveTo);
    if (done && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final r = widget.review;
    // Conflicts resolved meanwhile leave the list.
    final conflicts = [
      for (final c in r.conflicts) if (store.hasConflict(c.$1, c.$2)) c
    ];
    List<EntityArrival> shown(List<EntityArrival> list) =>
        [for (final a in list) if (!_kept.contains(a.id)) a];
    final updated = shown(r.updated);
    final deleted = shown(r.deleted);
    return Scaffold(
      appBar: AppBar(title: Text(t.syncSummaryTitle)),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Text(t.arrivalIntro,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        if (r.newOnes.isNotEmpty) ...[
          _header(t.summaryNew),
          for (final a in r.newOnes) _entityRow(a),
        ],
        if (updated.isNotEmpty) ...[
          _header(t.summaryUpdated),
          for (final a in updated) _entityRow(a),
        ],
        if (deleted.isNotEmpty) ...[
          _header(t.summaryDeleted),
          for (final a in deleted) _deletedRow(a),
        ],
        if (conflicts.isNotEmpty) ...[
          _header(t.summaryConflicts),
          for (final c in conflicts) _conflictRow(c),
        ],
        if (r.meta.isNotEmpty) ...[
          _header(t.summaryMeta),
          for (final m in r.meta)
            ListTile(
              dense: true,
              leading: const Icon(Icons.settings_outlined),
              title: Text(_metaLine(m)),
            ),
        ],
        const SizedBox(height: 80),
      ]),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            if (widget.undo != null && !_resolved) ...[
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.undo),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error),
                  label: Text(t.rejectArrival),
                  onPressed: _reject,
                ),
              ),
              const SizedBox(width: 12),
            ] else if (_resolved) ...[
              Expanded(
                child: Text(t.rejectAfterResolve,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: FilledButton.icon(
                icon: const Icon(Icons.check),
                label: Text(t.acceptArrival),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

/// The effective changes of one cat or home: each field once, the value
/// before the import and the value now — not the whole history.
class _ChangesScreen extends StatelessWidget {
  final CatalogStore store;
  final EntityArrival arrival;

  const _ChangesScreen({required this.store, required this.arrival});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
          title: Text(store.current(arrival.id, Keys.name) ?? t.unnamed)),
      body: ListView(children: [
        for (final c in arrival.changes)
          if (c.isPhoto)
            ListTile(
              dense: true,
              leading: const Icon(Icons.photo_outlined),
              title: Text(c.after == 'deleted' ? t.photoRemoved : t.photoAdded),
            )
          else
            ListTile(
              dense: true,
              title: Text(fieldLabel(t, store, c.field)),
              subtitle: Text(arrival.isNew
                  ? valueLabel(t, store, c.field, c.after)
                  : '${valueLabel(t, store, c.field, c.before)} → '
                      '${valueLabel(t, store, c.field, c.after)}'),
            ),
      ]),
    );
  }
}
