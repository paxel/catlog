import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../hidden.dart';
import '../l10n.dart';

/// Whose a plan is. Every plan editor carries the cat or clowder as its
/// first field, preset from the page it was opened on and changeable;
/// from the agenda it starts with the one looked at last.
const lastViewedKey = 'lastViewed';

/// Remembers the cat or clowder whose page opened, for the agenda's
/// plans.
void rememberViewed(CatalogStore store, String entityId) {
  store.setLocalSetting(lastViewedKey, entityId);
}

/// The cats and clowders a plan can be for, cats first.
List<EntityView> planEntities(CatalogStore store) => [
      ...store.visibleCats(),
      ...store.visibleClowders(),
    ];

/// The entity a plan starts with when no page said: the one looked at
/// last while it is still around, else the first cat, else the first
/// clowder; null in an empty catalog.
String? defaultPlanEntity(CatalogStore store) {
  final entities = planEntities(store);
  final last = store.localSetting(lastViewedKey);
  if (last != null && entities.any((e) => e.id == last)) return last;
  return entities.firstOrNull?.id;
}

/// The "For" field: a dropdown over every cat and clowder.
class PlanEntityField extends StatelessWidget {
  final CatalogStore store;
  final String? value;
  final ValueChanged<String?> onChanged;

  const PlanEntityField({
    super.key,
    required this.store,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final entities = planEntities(store);
    return DropdownButtonFormField<String>(
      initialValue: entities.any((e) => e.id == value) ? value : null,
      decoration: InputDecoration(labelText: context.t.reminderFor),
      items: [
        for (final e in entities)
          DropdownMenuItem(value: e.id, child: Text(e.name)),
      ],
      onChanged: onChanged,
    );
  }
}
