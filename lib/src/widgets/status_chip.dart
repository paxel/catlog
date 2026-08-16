import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_labels.dart';
import '../l10n.dart';

/// Colored chip for a recognized Clowder status; free-text statuses get
/// a plain chip. Nothing when the clowder has no status.
class StatusChip extends StatelessWidget {
  final CatalogStore store;
  final String clowderId;

  const StatusChip({super.key, required this.store, required this.clowderId});

  static const _colors = <String, Color>{
    'foster': Color(0xFF7CB342),
    'forever-home': Color(0xFFE91E63),
    'clinic': Color(0xFF42A5F5),
    'shelter': Color(0xFFFFA726),
    'barn': Color(0xFF8D6E63),
  };

  static const _icons = <String, IconData>{
    'foster': Icons.volunteer_activism,
    'forever-home': Icons.favorite,
    'clinic': Icons.medical_services_outlined,
    'shelter': Icons.night_shelter_outlined,
    'barn': Icons.agriculture_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final value = store.current(clowderId, 'f:status');
    if (value == null) return const SizedBox.shrink();
    final label = statusDisplay(context.t, value) ?? value;
    final color = _colors[value];
    return Chip(
      avatar: _icons[value] != null
          ? Icon(_icons[value], size: 18, color: Colors.white)
          : null,
      label: Text(label),
      labelStyle: color != null ? const TextStyle(color: Colors.white) : null,
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
