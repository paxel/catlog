import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../image_provider_cache.dart';

/// True when the cat's deceased date is set — rendered subdued
/// everywhere: desaturated photo, no symbols (they don't translate
/// across cultures), a localized chip where there is room.
bool isDeceased(CatalogStore store, String catId) =>
    store.current(catId, 'f:deceased') != null;

/// Desaturation matrix for deceased cats' photos.
const greyscale = ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0, 0, 0, 1, 0,
]);

/// A Cat's Profile Image as a rounded thumbnail, or a placeholder icon.
/// Deceased cats render desaturated and slightly faded.
class CatAvatar extends StatelessWidget {
  final CatalogStore store;
  final String catId;
  final double size;

  const CatAvatar(
      {super.key, required this.store, required this.catId, this.size = 56});

  @override
  Widget build(BuildContext context) {
    final hash = store.profileImage(catId);
    final photo = hash == null ? null : imageProviderFor(store, hash);
    final child = ClipRRect(
      borderRadius: BorderRadius.circular(size / 8),
      child: photo == null
          ? Container(
              width: size,
              height: size,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(Icons.pets, size: size / 2),
            )
          : Image(
              image: ResizeImage(photo, width: (size * 3).round()),
              width: size,
              height: size,
              fit: BoxFit.cover),
    );
    if (!isDeceased(store, catId)) return child;
    return Opacity(
      opacity: 0.65,
      child: ColorFiltered(colorFilter: greyscale, child: child),
    );
  }
}
