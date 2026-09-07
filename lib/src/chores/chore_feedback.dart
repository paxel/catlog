import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../achievements.dart';
import '../celebration.dart';
import '../l10n.dart';

/// What every tick earns, wherever it was made — agenda, cat page, home
/// page: the day's chores all done is one cheer per day, a ladder
/// climbed is a cheer and a line saying which.
void afterChoreTick(
  BuildContext context,
  CatalogStore store, {
  CatalogManager? manager,
}) {
  final today = DateUtils.dateOnly(DateTime.now());
  final due = [
    for (final c in store.allChores())
      if (c.active && isDueOn(c, store.choreTicks(c), today)) c,
  ];
  final allDone =
      due.isNotEmpty &&
      due.every((c) => store.choreTicks(c).containsKey(today));
  var cheer = false;
  if (allDone && store.localSetting('choresCelebrated') != dayKey(today)) {
    store.setLocalSetting('choresCelebrated', dayKey(today));
    cheer = true;
  }
  if (manager != null) {
    final climbed = recordLadders(
      manager,
      ladders(gatherStats([store], today)),
      DateTime.now(),
    );
    if (climbed.isNotEmpty) {
      cheer = true;
      final t = context.t;
      // One line for all of them: queued snackbars would hide the rest.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.achievementUnlocked(
              [
                for (final s in climbed)
                  switch (s.id) {
                    fullMonthId => t.achievementMonth,
                    fullYearId => t.achievementYear,
                    fullDecadeId => t.achievementDecade,
                    fullCenturyId => t.achievementCentury,
                    _ => t.achievementMaster(s.title ?? ''),
                  },
              ].join(', '),
            ),
          ),
        ),
      );
    }
  }
  if (cheer) celebrate(context, store);
}
