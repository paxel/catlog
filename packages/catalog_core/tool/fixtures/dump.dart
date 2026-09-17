import 'dart:collection';

import 'package:catalog_core/catalog_core.dart';

/// The state of a catalog as the fixture corpus records it, and as the
/// desktop core must reproduce it after importing the same files.
///
/// Only what came from partners counts: the reading catalog's own rows
/// (its starter fields, its markers) are left out, so a fresh reader of
/// any implementation dumps the same picture. Keys are sorted so the
/// JSON compares byte for byte.
Map<String, dynamic> dumpState(CatalogStore store) {
  final self = store.deviceId;
  final vector = SplayTreeMap<String, int>.from({
    for (final e in store.versionVector().entries)
      if (e.key != self) e.key: e.value
  });
  final entities = SplayTreeMap<String, dynamic>();
  for (final view in [...store.clowders(), ...store.cats()]) {
    entities[view.id] = _entity(store, view.id);
  }
  for (final def in store.fieldDefs()) {
    entities[def.id] = _entity(store, def.id);
  }
  final entries = [
    for (final e in store.entriesSince(const {}, includePrivate: true))
      if (e.device != self) e.toJson()
  ];
  final blobs = SplayTreeSet<String>();
  for (final view in [...store.clowders(), ...store.cats()]) {
    for (final hash in store.images(view.id)) {
      if (store.imageBytes(hash) != null) blobs.add(hash);
    }
  }
  return {
    'vector': vector,
    'entities': entities,
    'blobs': blobs.toList(),
    'entries': entries,
  };
}

Map<String, dynamic> _entity(CatalogStore store, String id) {
  final fields = SplayTreeMap<String, dynamic>.from(store.currentFields(id));
  final kind = fields[Keys.type];
  final out = <String, dynamic>{
    'kind': kind,
    'fields': fields,
  };
  if (kind == Kinds.cat || kind == Kinds.clowder) {
    out['images'] = store.images(id);
    out['profile'] = store.profileImage(id);
  }
  return out;
}
