import 'entry.dart';
import 'fields.dart';
import 'store.dart';

/// What a move did, for the message afterwards.
class TransferResult {
  /// The entities that arrived, by their canonical id.
  final List<String> moved;
  final int photos;

  const TransferResult({required this.moved, required this.photos});
}

/// Transferring Cats and Clowders into another catalog.
///
/// A **Transfer** is not a Move: CONTEXT.md reserves Move for a change
/// of a Cat's Clowder membership inside one catalog. This crosses
/// catalogs, which is a different operation with different rules — the
/// interface still says "move to another catalog", because that is what
/// a keeper sees.
///
/// Two catalogs exist to keep places apart, so a move must sever the
/// lineage: the entries arrive re-stamped under the destination's own
/// device (see [CatalogStore.adoptEntries]), which stops a partner both
/// catalogs share from silently re-merging them later. Author names,
/// dates and recorded times survive, so the history still reads as what
/// happened. In the catalog it left, the entity is deleted the ordinary
/// way — its partners already hold it and that cannot be unsent, so
/// "deleted" is the truthful thing to tell them.
TransferResult transferEntities(CatalogStore from, CatalogStore to, Set<String> ids,
    {DateTime? date}) {
  final wanted = <String>{};
  for (final id in ids) {
    final canonical = from.resolveEntity(id);
    wanted.add(canonical);
    // A clowder takes the cats living in it: moving a place means
    // moving what lives there.
    if (from.current(canonical, Keys.type) == Kinds.clowder) {
      for (final cat in from.cats(clowderId: canonical)) {
        wanted.add(from.resolveEntity(cat.id));
      }
    }
  }
  if (wanted.isEmpty) return const TransferResult(moved: [], photos: 0);

  // Field definitions come along only where the destination has none of
  // its own: bringing a copy of a definition it already has would let
  // the source's wording and options win over every cat already living
  // there, which is not what moving one cat should do.
  final known = {for (final def in to.fieldDefs()) def.id};
  final defs = {
    for (final def in from.fieldDefs())
      if (!known.contains(def.id)) def.id
  };
  final entries = <Entry>[
    for (final e in from.entriesSince(const {}, includePrivate: true))
      if (wanted.contains(from.resolveEntity(e.entity)) ||
          defs.contains(e.entity))
        e
  ];

  // Photos first: a failure here leaves bytes nothing refers to, which
  // is litter. Failing after the entries were claimed would leave the
  // same cat in both catalogs, which is the mess the move exists to
  // prevent.
  var photos = 0;
  for (final id in wanted) {
    for (final hash in from.images(id)) {
      final bytes = from.imageBytes(hash);
      if (bytes == null || to.imageBytes(hash) != null) continue;
      to.putBlob(hash, bytes);
      photos++;
    }
  }
  // Everything the destination learns lands in one transaction: killed
  // halfway, it holds nothing of the cat rather than half of it.
  to.transaction(() {
    to.adoptEntries(entries);
    // A cat whose clowder did not come along has no home over there.
    for (final id in wanted) {
      if (to.current(id, Keys.type) != Kinds.cat) continue;
      final clowder = to.current(id, Keys.clowder);
      if (clowder == null || clowder.isEmpty) continue;
      if (wanted.contains(to.resolveEntity(clowder))) continue;
      to.moveCat(id, null, date: date);
    }
  });

  from.transaction(() {
    for (final id in wanted) {
      if (from.current(id, Keys.type) == Kinds.clowder) {
        from.deleteClowder(id, date: date);
      } else {
        from.deleteCat(id, date: date);
      }
    }
  });
  return TransferResult(moved: wanted.toList(), photos: photos);
}
