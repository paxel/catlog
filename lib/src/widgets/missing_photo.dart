import 'package:flutter/material.dart';

import '../l10n.dart';

/// A photo the catalog knows of but has no bytes for — it came by sync
/// and the bytes never followed. Says so in the grid tile and in the
/// viewer, instead of an empty square or a black page; the next sync
/// with whoever has it fills it in.
class MissingPhoto extends StatelessWidget {
  /// On the viewer's black page the text is light.
  final bool onDark;

  const MissingPhoto({super.key, this.onDark = false});

  @override
  Widget build(BuildContext context) {
    final color = onDark ? Colors.white70 : Theme.of(context).hintColor;
    return Container(
      decoration: BoxDecoration(
        color: onDark
            ? null
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, color: color, size: 32),
          const SizedBox(height: 6),
          Text(
            context.t.photoNotReceived,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
