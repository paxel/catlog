import 'package:catalog_core/catalog_core.dart';

import '../l10n/app_localizations.dart';
import 'achievements.dart';

/// A worn title as text: "Chancellor (Feed)", from the `rank|chore`
/// on a person record; null when none is worn or the record is odd.
String? titleText(AppLocalizations t, CatalogStore store, String device) {
  final raw = store.titleOf(device);
  if (raw == null) return null;
  final cut = raw.indexOf('|');
  if (cut <= 0) return null;
  final rank = raw.substring(0, cut);
  if (!titleRanks.contains(rank)) return null;
  return titleWithChore(t, rank, raw.substring(cut + 1));
}

/// A person as partners see them: the name, then the title worn.
String personLabel(
  AppLocalizations t,
  CatalogStore store,
  String name,
  String device,
) {
  final title = titleText(t, store, device);
  return title == null ? name : '$name · $title';
}

/// The titles this keeper may wear, from the ladders of [stores]: one
/// per chore at its rank, as `rank|chore` values.
List<({String value, String text})> earnedTitles(
  AppLocalizations t,
  List<CatalogStore> stores,
  DateTime today,
) {
  final states = ladders(gatherStats(stores, today));
  return [
    for (final s in states)
      if (s.reached && s.title != null)
        (
          value: '${rankFor(s.tier)}|${s.title}',
          text: titleWithChore(t, rankFor(s.tier)!, s.title!),
        ),
  ];
}
