import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';
import 'units.dart';

/// Metric or imperial, or whatever the region says (#96). Device-local
/// and immediate: every value on screen changes its unit.
Future<void> showUnitsDialog(BuildContext context, CatalogStore store) async {
  final current = store.localSetting(unitsSettingKey) ?? 'auto';
  final t = context.t;
  final chosen = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(t.unitsLabel),
      children: [
        for (final (value, label) in [
          ('auto', t.unitsAuto),
          ('metric', t.unitsMetric),
          ('imperial', t.unitsImperial),
        ])
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(value),
            child: Row(children: [
              Icon(value == current
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off),
              const SizedBox(width: 12),
              Expanded(child: Text(label)),
            ]),
          ),
      ],
    ),
  );
  if (chosen == null || !context.mounted) return;
  store.setLocalSetting(unitsSettingKey, chosen);
  applyUnitSystem(store, Localizations.localeOf(context));
}
