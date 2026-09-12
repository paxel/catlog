import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'image_import.dart';
import 'image_provider_cache.dart';
import 'l10n.dart';

/// A place's own picture — the house, the yard, the feeding spot —
/// shown on its card instead of a cat. Stored as the entity's profile
/// image, so a home's cover travels like its other values; the strays'
/// cover hangs on the pseudo entity [straysEntity], which no partner
/// receives the bytes of, so their card falls back to a cat.
const straysEntity = 'strays';

/// The cover's content hash, or null when none was chosen.
String? coverHash(CatalogStore store, String entityId) =>
    store.images(entityId).isEmpty ? null : store.profileImage(entityId);

/// The cover as a picture for a card, or null.
ImageProvider? coverImage(CatalogStore store, String entityId) {
  final hash = coverHash(store, entityId);
  return hash == null ? null : imageProviderFor(store, hash);
}

/// Stores [bytes] as the cover, replacing the one before.
Future<String?> setCover(
  CatalogStore store,
  String entityId,
  Uint8List bytes,
) async {
  final old = coverHash(store, entityId);
  final hash = await addCompressedImage(store, entityId, bytes);
  if (hash == null) return null;
  store.setProfileImage(entityId, hash);
  if (old != null && old != hash) store.deleteImage(entityId, old);
  return hash;
}

/// Drops the cover; the card falls back to a cat.
void removeCover(CatalogStore store, String entityId) {
  final hash = coverHash(store, entityId);
  if (hash != null) store.deleteImage(entityId, hash);
}

/// Asks for a picture and makes it the cover; false when nothing came.
Future<bool> pickCover(
  BuildContext context,
  CatalogStore store,
  String entityId,
) async {
  // No crop step: its prompt asks for the animal, and a place is none;
  // the card crops the picture to its tile anyway.
  final bytes = await pickImageBytes(context, allowCrop: false);
  if (bytes == null) return false;
  return await setCover(store, entityId, bytes) != null;
}

/// The menu behind a cover button: choose, or remove the one there.
Future<bool> coverMenu(
  BuildContext context,
  CatalogStore store,
  String entityId,
) async {
  final t = context.t;
  final has = coverHash(store, entityId) != null;
  final choice = await showModalBottomSheet<String>(
    context: context,
    builder: (context) => SafeArea(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(t.coverHint),
          ),
          ListTile(
            leading: const Icon(Icons.image_outlined),
            title: Text(t.coverPick),
            onTap: () => Navigator.of(context).pop('pick'),
          ),
          if (has)
            ListTile(
              leading: const Icon(Icons.hide_image_outlined),
              title: Text(t.coverRemove),
              onTap: () => Navigator.of(context).pop('remove'),
            ),
        ],
      ),
    ),
  );
  if (choice == null || !context.mounted) return false;
  if (choice == 'remove') {
    removeCover(store, entityId);
    return true;
  }
  return pickCover(context, store, entityId);
}

/// The cover on a page: the picture across the width, with the menu on
/// a hold; without one, a plain row that opens the menu on tap.
class CoverBanner extends StatelessWidget {
  final CatalogStore store;
  final String entityId;
  final VoidCallback onChanged;

  const CoverBanner({
    super.key,
    required this.store,
    required this.entityId,
    required this.onChanged,
  });

  Future<void> _menu(BuildContext context) async {
    if (await coverMenu(context, store, entityId)) onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final image = coverImage(store, entityId);
    if (image == null) {
      return ListTile(
        leading: const Icon(Icons.image_outlined),
        title: Text(context.t.coverPick),
        subtitle: Text(context.t.coverHint),
        onTap: () => _menu(context),
      );
    }
    return GestureDetector(
      onLongPress: () => _menu(context),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: Image(image: ResizeImage(image, width: 1200), fit: BoxFit.cover),
      ),
    );
  }
}
