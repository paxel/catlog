import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../image_provider_cache.dart';

/// A Cat's Profile Image as a rounded thumbnail, or a placeholder icon.
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
    return ClipRRect(
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
  }
}
