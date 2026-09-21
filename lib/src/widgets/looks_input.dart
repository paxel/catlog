import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../looks_labels.dart';
import '../spotlight.dart';

/// Chip rows, one per Looks group of the animal's species: a one-value
/// group behaves like radio buttons, a many-value group like checkboxes.
/// No typing — the values are the same on every phone, so they compare.
class LooksInput extends StatefulWidget {
  final String? species;
  final String? value;
  final ValueChanged<String?> onChanged;

  /// With a store the field's tip can run once, the first time.
  final CatalogStore? store;

  const LooksInput({
    super.key,
    required this.species,
    required this.value,
    required this.onChanged,
    this.store,
  });

  @override
  State<LooksInput> createState() => _LooksInputState();
}

class _LooksInputState extends State<LooksInput> {
  String? get species => widget.species;
  String? get value => widget.value;
  ValueChanged<String?> get onChanged => widget.onChanged;

  @override
  void initState() {
    super.initState();
    final store = widget.store;
    if (store != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => runSpotlights(context, store, 'looks'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final looks = parseLooks(value);
    final theme = Theme.of(context);
    return Spotlight(
      id: 'looks-chips',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final group in looksGroupsFor(species)) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 2),
              child: Text(
                looksGroupLabel(t, group.id),
                style: theme.textTheme.titleSmall,
              ),
            ),
            Wrap(
              spacing: 6,
              runSpacing: 0,
              children: [
                for (final v in group.values)
                  FilterChip(
                    label: Text(looksValueLabel(t, group.id, v)),
                    selected: looks[group.id]?.contains(v) ?? false,
                    visualDensity: VisualDensity.compact,
                    onSelected: (on) {
                      final next = {
                        for (final e in looks.entries) e.key: {...e.value},
                      };
                      final chosen = next.putIfAbsent(group.id, () => {});
                      if (on) {
                        if (group.single) chosen.clear();
                        chosen.add(v);
                      } else {
                        chosen.remove(v);
                      }
                      onChanged(encodeLooks(next));
                    },
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
