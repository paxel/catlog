import 'dart:collection';
import 'dart:convert';

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
  // An entity counts once a partner wrote a row for it: the reader's
  // own starter fields are its own business.
  bool foreign(String id) =>
      store.timeline(id, includeVoided: true).any((e) => e.device != self);
  final entities = SplayTreeMap<String, dynamic>();
  for (final view in [...store.clowders(), ...store.cats()]) {
    if (foreign(view.id)) entities[view.id] = _entity(store, view.id);
  }
  for (final def in store.fieldDefs()) {
    if (foreign(def.id)) entities[def.id] = _entity(store, def.id);
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
  // Every change, per entity and field, with corrections marked.
  final histories = SplayTreeMap<String, dynamic>();
  for (final id in entities.keys) {
    final perField = SplayTreeMap<String, List<dynamic>>();
    for (final e in store.timeline(id, includeVoided: true)) {
      if (e.device == self) continue;
      perField.putIfAbsent(store.canonicalKey(e.field), () => []).add({
        'device': e.device,
        'dseq': e.dseq,
        'value': e.value,
        'date': e.date.toIso8601String(),
        'author': e.author,
        'voided': e.voided,
      });
    }
    histories[id] = perField;
  }
  final keys = [
    for (final k
        in store.pinnedKeys()
          ..sort((a, b) => a.record.device.compareTo(b.record.device)))
      {
        'device': k.record.device,
        'key': base64.encode(k.record.publicKey),
        'since': k.record.since,
        'trust': k.trust.name,
      }
  ];
  return {
    'vector': vector,
    'entities': entities,
    'blobs': blobs.toList(),
    'histories': histories,
    'keys': keys,
    'entries': entries,
  };
}

/// What an import reported, as the corpus records it.
Map<String, dynamic> reportJson(ImportReport report) => {
      'refused': SplayTreeMap<String, int>.from({
        for (final MapEntry(key: (author, device), value: n)
            in report.refused.entries)
          '$author@$device': n
      }),
      'newKeys': [for (final k in report.newKeys) k.record.device]..sort(),
      'impostors': [
        for (final (name, device) in report.impostors) [name, device]
      ]..sort((a, b) => a.join().compareTo(b.join())),
      'changedKeys': [...report.changedKeys]..sort(),
    };

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

/// One folder round as the corpus records it.
Map<String, dynamic> syncJson(FolderSyncResult r, CatalogStore store) => {
      'entriesIn': r.entriesIn,
      'blobsIn': r.blobsIn,
      'blobsMissing': r.blobsMissing,
      'conflicts': _conflicts(store),
    };

/// One bundle import as the corpus records it.
Map<String, dynamic> bundleJson(BundleResult r, CatalogStore store) => {
      'entriesIn': r.entriesIn,
      'blobsIn': r.blobsIn,
      'conflicts': _conflicts(store),
    };

/// Open conflicts as (entity, field) pairs, sorted.
List<List<String>> _conflicts(CatalogStore store) => [
      for (final (entity, field) in store.conflicts()) [entity, field]
    ]..sort((a, b) => a.join().compareTo(b.join()));
