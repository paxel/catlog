import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../image_provider_cache.dart';

/// True when the cat's deceased date is set — rendered subdued
/// everywhere: desaturated photo with the mourning band, a localized
/// chip where there is room.
bool isDeceased(CatalogStore store, String catId) =>
    store.current(catId, 'f:deceased') != null;

/// The Trauerflor: a black band across the lower right corner, the
/// sign on the framed picture of one who died. Drawn over the portrait
/// of a deceased cat wherever it stands for the cat, photo or
/// placeholder; never over the other photos.
class MourningBandPainter extends CustomPainter {
  const MourningBandPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // A fifth of the picture wide, at 45°, clipped by whoever framed it.
    final d = size.shortestSide / 5;
    final near = d * 0.9;
    final far = near + d * 1.4142;
    final path = Path()
      ..moveTo(size.width, size.height - far)
      ..lineTo(size.width, size.height - near)
      ..lineTo(size.width - near, size.height)
      ..lineTo(size.width - far, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(MourningBandPainter oldDelegate) => false;
}

/// [child] with the mourning band over its lower right corner. The
/// caller clips to the portrait's shape around it.
Widget withMourningBand(Widget child) => Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        const Positioned.fill(
            child: CustomPaint(painter: MourningBandPainter())),
      ],
    );

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
    final portrait = photo == null
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
            fit: BoxFit.cover);
    final dead = isDeceased(store, catId);
    // The band stays black over the faded picture: it lies outside the
    // fade.
    final faded = dead
        ? Opacity(
            opacity: 0.65,
            child: ColorFiltered(colorFilter: greyscale, child: portrait),
          )
        : portrait;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 8),
      child: dead ? withMourningBand(faded) : faded,
    );
  }
}
