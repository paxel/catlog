import 'package:catalog_core/catalog_core.dart';

import '../l10n/app_localizations.dart';

/// The name of a Looks group as the user reads it.
String looksGroupLabel(AppLocalizations t, String group) => _capitalize(group);

/// The name of a Looks value as the user reads it.
String looksValueLabel(AppLocalizations t, String group, String value) =>
    _capitalize(value);

String _capitalize(String s) =>
    s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

/// A stored Looks line as one readable line: `Size: medium · Colours:
/// black, white`.
String looksDisplay(AppLocalizations t, String value) {
  final looks = parseLooks(value);
  final parts = [
    for (final g in looksGroupOrder)
      if (looks[g] case final values?)
        '${looksGroupLabel(t, g)}: '
            '${(values.toList()..sort()).map((v) => looksValueLabel(t, g, v)).join(', ')}',
  ];
  return parts.isEmpty ? value : parts.join(' · ');
}
