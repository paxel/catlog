import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

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
    final bytes = hash == null ? null : store.imageBytes(hash);
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 8),
      child: bytes == null
          ? Container(
              width: size,
              height: size,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(Icons.pets, size: size / 2),
            )
          : Image.memory(bytes,
              width: size,
              height: size,
              fit: BoxFit.cover,
              cacheWidth: (size * 3).round()),
    );
  }
}
