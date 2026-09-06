import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../achievements.dart';
import '../l10n.dart';

/// The keeper's achievements: the full stretches and a master ladder
/// per chore, reached ones with their count and first date, the rest
/// greyed with the next step.
class AchievementsScreen extends StatelessWidget {
  final CatalogManager manager;

  /// The catalogs' stores to count from, opened by the caller.
  final List<CatalogStore> stores;

  const AchievementsScreen({
    super.key,
    required this.manager,
    required this.stores,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final today = DateUtils.dateOnly(DateTime.now());
    final states = ladders(gatherStats(stores, today));
    recordLadders(manager, states, DateTime.now());
    final recorded = {for (final a in manager.achievements()) a.id: a};
    final locale = Localizations.localeOf(context).toString();
    String name(LadderState s) => switch (s.id) {
      fullMonthId => t.achievementMonth,
      fullYearId => t.achievementYear,
      fullDecadeId => t.achievementDecade,
      fullCenturyId => t.achievementCentury,
      _ => t.achievementMaster(s.title ?? ''),
    };
    return Scaffold(
      appBar: AppBar(title: Text(t.achievementsTitle)),
      body: ListView(
        children: [
          for (final s in states)
            ListTile(
              leading: Icon(
                s.reached ? Icons.emoji_events : Icons.emoji_events_outlined,
                color: s.reached ? Colors.amber.shade700 : null,
              ),
              title: Text(name(s)),
              subtitle: Text(
                s.reached
                    ? t.achievementReached(
                        s.times,
                        DateFormat.yMd(locale)
                            .format(recorded[s.id]?.first.toLocal() ?? today),
                      )
                    : s.id == fullCenturyId
                    ? t.achievementCenturyHint
                    : s.next == null
                    ? t.achievementLocked
                    : t.achievementNext(s.next!),
              ),
              enabled: s.reached,
            ),
        ],
      ),
    );
  }
}
