import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../achievements.dart';
import '../l10n.dart';

/// The keeper's achievements: what was earned, and only that — full
/// stretches with their count, one title per chore at its rank, the
/// coats unlocked. No progress bars, no next steps: the rewards are a
/// quiet bonus, not a goal to chase.
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
    String since(LadderState s) =>
        DateFormat.yMd(locale).format(recorded[s.id]?.first.toLocal() ?? today);
    final stretches = [
      for (final s in states)
        if (s.reached && s.title == null) s,
    ];
    final titled = [
      for (final s in states)
        if (s.reached && s.title != null) s,
    ];
    final months = states.firstWhere((s) => s.id == fullMonthId).times;
    final coats = unlockedCoats(months);
    final nothing = stretches.isEmpty && titled.isEmpty && coats.isEmpty;
    return Scaffold(
      appBar: AppBar(title: Text(t.achievementsTitle)),
      body: ListView(
        children: [
          if (nothing)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(t.achievementsEmpty),
            ),
          for (final s in stretches)
            ListTile(
              leading: Icon(Icons.emoji_events, color: Colors.amber.shade700),
              title: Text(switch (s.id) {
                fullMonthId => t.achievementMonth,
                fullYearId => t.achievementYear,
                fullDecadeId => t.achievementDecade,
                _ => t.achievementCentury,
              }),
              subtitle: Text(t.achievementReached(s.times, since(s))),
            ),
          for (final s in titled)
            ListTile(
              leading: const Icon(Icons.workspace_premium_outlined),
              title: Text(titleWithChore(t, rankFor(s.tier)!, s.title!)),
              subtitle: Text(t.achievementReached(s.times, since(s))),
            ),
          for (final coat in coats)
            ListTile(
              leading: const Icon(Icons.pets),
              title: Text(t.coatUnlocked(coatName(t, coat))),
              subtitle: Text(t.coatUnlockedHow),
            ),
        ],
      ),
    );
  }
}
