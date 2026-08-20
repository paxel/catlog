import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'entry.dart';
import 'fields.dart';
import 'store.dart';

/// Public cat share for fliers (#40): a whitelist subset of one cat and
/// its clowder in the ordinary `.catsync` format, plus the QR payload
/// codec (hosted URL or tiny inline data).
///
/// Exported entries are re-stamped under a fresh share device id — a
/// partial file must never carry the original (device, dseq) rows, or
/// the importer's version vector would claim knowledge of the withheld
/// entries and a later real sync would skip them forever. Re-asserted
/// copies collapse in timelines like merge re-assertions do.
Uint8List catShareBytes(CatalogStore store,
    {required String catId,
    required Set<String> fields,
    bool includePhotos = true}) {
  final cat = store.resolveEntity(catId);
  // Private stays home, hard: a Private cat never leaves through the
  // public share (CONTEXT.md: Private). The UI refuses earlier with an
  // explanation; this guard catches every other caller.
  if (store.isPrivate(cat)) {
    throw StateError('Private cats are never shared publicly');
  }
  final clowderId = store.current(cat, Keys.clowder);
  var clowder = clowderId == null ? null : store.resolveEntity(clowderId);
  // A Private clowder stays out of the share entirely.
  if (clowder != null && store.isPrivate(clowder)) clowder = null;

  final device = 'share-${_randomId()}';
  var dseq = 0;
  final out = <Entry>[];
  void emit(String entity, String field, String? value,
      {DateTime? date, String? author, DateTime? recorded}) {
    dseq++;
    out.add(Entry(
      seq: -1,
      device: device,
      dseq: dseq,
      entity: entity,
      field: field,
      value: value,
      date: date ?? DateTime.now(),
      author: author ?? 'share',
      recorded: recorded ?? DateTime.now(),
    ));
  }

  /// The current winning entry for (entity, field), re-stamped with its
  /// original date and author so provenance survives.
  void emitCurrent(String entity, String field) {
    for (final e in store.fieldHistory(entity, field)) {
      if (store.current(entity, field) == e.value) {
        emit(entity, field, e.value,
            date: e.date, author: e.author, recorded: e.recorded);
        return;
      }
    }
    final value = store.current(entity, field);
    if (value != null) emit(entity, field, value);
  }

  // Field definitions for every whitelisted field, so the importer can
  // render types and formats. Private field definitions never travel,
  // whitelisted or not.
  final shareable = {
    for (final def in store.fieldDefs())
      if (fields.contains(def.key) && !store.isPrivate(def.id)) def.key
  };
  fields = shareable;
  final defs = {
    for (final def in store.fieldDefs())
      if (fields.contains(def.key)) def
  };
  for (final def in defs) {
    emit(def.id, Keys.type, Kinds.fieldDef);
    for (final prop in [
      Keys.name,
      Keys.fieldType,
      Keys.fieldScope,
      Keys.fieldOptions,
      Keys.fieldIdDisplay,
    ]) {
      final value = store.current(def.id, prop);
      if (value != null) emit(def.id, prop, value);
    }
  }

  // The cat: identity, name, membership, whitelisted fields.
  emit(cat, Keys.type, Kinds.cat);
  emitCurrent(cat, Keys.name);
  if (clowder != null) emit(cat, Keys.clowder, clowder);
  for (final key in fields) {
    if (store.current(cat, key) != null) emitCurrent(cat, key);
  }
  final images = includePhotos ? store.images(cat) : const <String>[];
  for (final hash in images) {
    emit(cat, Keys.image(hash), 'added');
  }
  if (includePhotos && store.profileImage(cat) != null) {
    emit(cat, Keys.profileImage, store.profileImage(cat));
  }

  // The owner clowder: identity, name, whitelisted clowder fields.
  if (clowder != null) {
    emit(clowder, Keys.type, Kinds.clowder);
    emitCurrent(clowder, Keys.name);
    for (final key in fields) {
      if (store.current(clowder, key) != null) {
        emitCurrent(clowder, key);
      }
    }
  }

  final archive = Archive();
  final jsonl = out.map((e) => jsonEncode(e.toJson())).join('\n');
  final jsonlBytes = utf8.encode(jsonl);
  archive
      .addFile(ArchiveFile('entries.jsonl', jsonlBytes.length, jsonlBytes));
  for (final hash in images) {
    final bytes = store.imageBytes(hash);
    if (bytes != null) {
      archive.addFile(ArchiveFile('blobs/$hash.jpg', bytes.length, bytes));
    }
  }
  return Uint8List.fromList(ZipEncoder().encode(archive)!);
}

/// Writes the share to a `.catsync` file and returns its path.
String writeCatShare(CatalogStore store, String path,
    {required String catId,
    required Set<String> fields,
    bool includePhotos = true}) {
  File(path).writeAsBytesSync(catShareBytes(store,
      catId: catId, fields: fields, includePhotos: includePhotos));
  return path;
}

const _urlMarker = 'catlog-share:u:';
const _dataMarker = 'catlog-share:d:';

/// QR payload for a hosted share file.
String encodeShareUrl(String url) =>
    '$_urlMarker${base64Url.encode(utf8.encode(url))}';

/// QR payload embedding a tiny (photo-free) share directly.
String encodeShareData(Uint8List shareBytes) =>
    '$_dataMarker${base64Url.encode(shareBytes)}';

/// A decoded share QR: exactly one of [url] or [data] is set.
class ShareQr {
  final String? url;
  final Uint8List? data;
  const ShareQr({this.url, this.data});
}

/// Decodes a scanned share QR; null when the code is not a cat(a)log
/// share — garbage never throws.
ShareQr? decodeShareQr(String raw) {
  try {
    if (raw.startsWith(_urlMarker)) {
      final url = utf8
          .decode(base64Url.decode(raw.substring(_urlMarker.length)));
      final uri = Uri.tryParse(url);
      if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
        return null;
      }
      return ShareQr(url: url);
    }
    if (raw.startsWith(_dataMarker)) {
      return ShareQr(
          data: Uint8List.fromList(
              base64Url.decode(raw.substring(_dataMarker.length))));
    }
  } catch (_) {
    // Malformed base64 or worse — not ours.
  }
  return null;
}

final _random = Random.secure();

String _randomId() =>
    List.generate(8, (_) => _random.nextInt(16).toRadixString(16)).join();
