import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

/// Whether this device has a camera to offer.
bool get _hasCamera => Platform.isAndroid || Platform.isIOS;

/// Takes or picks a picture and makes it the cover; false when nothing
/// came.
Future<bool> pickCover(
  BuildContext context,
  CatalogStore store,
  String entityId,
  ImageSource source,
) async {
  // No crop step: its prompt asks for the animal, and a place is none;
  // the card crops the picture to its tile anyway.
  final bytes = await pickImageBytes(context, allowCrop: false, source: source);
  if (bytes == null) return false;
  return await setCover(store, entityId, bytes) != null;
}

/// The menu behind a cover: take a photo, choose one, or remove the
/// one there. The choices are the sheet; nothing to read first.
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
          if (_hasCamera)
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text(t.takePhoto),
              onTap: () => Navigator.of(context).pop('camera'),
            ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(t.chooseFromGallery),
            onTap: () => Navigator.of(context).pop('gallery'),
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
  return pickCover(
    context,
    store,
    entityId,
    choice == 'camera' ? ImageSource.camera : ImageSource.gallery,
  );
}

/// The cover on a page: the picture across the width, with the menu on
/// a hold; without one, a row that says what it is, with the camera
/// and the gallery as buttons right there.
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
    final changed = await coverMenu(context, store, entityId);
    if (changed && context.mounted) onChanged();
  }

  Future<void> _pick(BuildContext context, ImageSource source) async {
    final changed = await pickCover(context, store, entityId, source);
    if (changed && context.mounted) onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final image = coverImage(store, entityId);
    if (image == null) {
      final t = context.t;
      return ListTile(
        leading: const Icon(Icons.image_outlined),
        title: Text(t.coverLabel),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.photo_library),
              tooltip: t.chooseFromGallery,
              onPressed: () => _pick(context, ImageSource.gallery),
            ),
            if (_hasCamera)
              IconButton(
                icon: const Icon(Icons.photo_camera),
                tooltip: t.takePhoto,
                onPressed: () => _pick(context, ImageSource.camera),
              ),
          ],
        ),
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
