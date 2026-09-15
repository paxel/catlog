import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'fields.dart';
import 'store.dart';

/// Photos travel without their metadata. Two reasons. A phone camera
/// writes where the picture was taken into the file, and a shared
/// folder would carry the keeper's home to every partner. And Android
/// rewrites such a file when another app reads it (the location bytes
/// are blanked, the length stays), so a partner's copy no longer
/// matched its name and was refused. Without the metadata there is
/// nothing to blank.

/// [jpeg] without its APP1..APP15 and COM segments (Exif, XMP, ICC,
/// comments). The picture data is untouched: no re-encoding, so every
/// device that strips the same file gets the same bytes. Bytes that
/// are not a JPEG come back as they are.
Uint8List stripJpegMetadata(Uint8List jpeg) {
  if (jpeg.length < 4 || jpeg[0] != 0xFF || jpeg[1] != 0xD8) return jpeg;
  final out = BytesBuilder(copy: false)..add(const [0xFF, 0xD8]);
  var i = 2;
  var changed = false;
  while (i + 4 <= jpeg.length && jpeg[i] == 0xFF) {
    final marker = jpeg[i + 1];
    if (marker == 0xD9) break; // EOI: nothing follows
    if (marker == 0xDA) break; // SOS: the scan runs to the end
    if (marker == 0xFF) {
      i++; // fill byte
      continue;
    }
    if (marker >= 0xD0 && marker <= 0xD7) {
      out.add(jpeg.sublist(i, i + 2)); // RSTn carries no length
      i += 2;
      continue;
    }
    final length = (jpeg[i + 2] << 8) | jpeg[i + 3];
    final end = i + 2 + length;
    if (end > jpeg.length) return jpeg; // truncated: leave it alone
    final drop = (marker >= 0xE1 && marker <= 0xEF) || marker == 0xFE;
    if (drop) {
      changed = true;
    } else {
      out.add(jpeg.sublist(i, end));
    }
    i = end;
  }
  if (!changed) return jpeg;
  out.add(jpeg.sublist(i));
  return out.toBytes();
}

/// True when [jpeg] still carries a segment [stripJpegMetadata] drops.
bool hasJpegMetadata(Uint8List jpeg) =>
    !identical(stripJpegMetadata(jpeg), jpeg);

/// Rewrites every stored photo that still carries metadata: the
/// stripped bytes become a new photo under their own hash, the old one
/// is marked deleted, a profile picture follows. Runs once per catalog
/// at start and after photos arrive; the marker keeps it from running
/// twice for nothing. Returns how many photos were rewritten.
int stripPhotoLocations(CatalogStore store) {
  var rewritten = 0;
  for (final entity in [...store.cats(), ...store.clowders()]) {
    for (final hash in store.images(entity.id)) {
      final bytes = store.imageBytes(hash);
      if (bytes == null) continue;
      final clean = stripJpegMetadata(bytes);
      if (identical(clean, bytes)) continue;
      final newHash = sha256.convert(clean).toString();
      if (store.imageBytes(newHash) == null) store.putBlob(newHash, clean);
      final wasProfile = store.profileImage(entity.id) == hash;
      final private = store.isFieldPrivate(entity.id, Keys.image(hash));
      store.append(entity.id, Keys.image(newHash), 'added');
      if (private) store.setFieldPrivate(entity.id, Keys.image(newHash), true);
      store.deleteImage(entity.id, hash);
      if (wasProfile) store.setProfileImage(entity.id, newHash);
      rewritten++;
    }
  }
  return rewritten;
}
