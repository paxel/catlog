import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../field_editing.dart';
import '../field_labels.dart';
import '../l10n.dart';
import '../looks_labels.dart';
import '../pet_mode.dart';

/// Chip rows, one per Looks group of the animal's species: a one-value
/// group behaves like radio buttons, a many-value group like checkboxes.
/// No typing — the values are the same on every phone, so they compare.
class LooksInput extends StatelessWidget {
  final String? species;
  final String? value;
  final ValueChanged<String?> onChanged;

  const LooksInput({
    super.key,
    required this.species,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final looks = parseLooks(value);
    final theme = Theme.of(context);
    return Column(
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
    );
  }
}

/// Asks which species a new animal is, from the presets; null when
/// dismissed. The pick is remembered as the next default.
Future<String?> askSpecies(BuildContext context, CatalogStore store) async {
  final t = context.t;
  final picked = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(t.starterSpecies),
      children: [
        for (final s in speciesPresets)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(s),
            child: Text(speciesDisplay(t, s)),
          ),
      ],
    ),
  );
  if (picked != null) store.setLocalSetting(lastSpeciesKey, picked);
  return picked;
}

/// After the Stray Cam took its picture: in a pets catalog the species
/// first, then the Looks — the two things a match needs and a photo
/// cannot give. Either step can be skipped; the animal exists already.
Future<void> askLooksAfterCapture(
  BuildContext context,
  CatalogStore store,
  String catId,
) async {
  if (petMode.value) {
    final species = await askSpecies(context, store);
    if (species == null || !context.mounted) return;
    store.append(catId, Keys.userField('species'), species);
  }
  final def = store.fieldDefs().where((d) => d.slug == 'looks').firstOrNull;
  if (def == null || !context.mounted) return;
  final edit = await editFieldValue(
    context,
    def,
    store.current(catId, def.key),
    store: store,
    excludeId: catId,
  );
  if (edit == null || edit.value == null || !store.isOpen) return;
  store.append(catId, def.key, edit.value, date: edit.date);
}
