import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../achievements.dart';
import '../celebration.dart';
import '../l10n.dart';
import '../notes.dart';

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
      if (c.active && countsToday(c, store.choreTicks(c), today)) c,
  ];
  final allDone =
      due.isNotEmpty && !due.any((c) => openToday(c, store.choreTicks(c), today));
  Cheer? cheer;
  if (allDone && store.localSetting('choresCelebrated') != dayKey(today)) {
    store.setLocalSetting('choresCelebrated', dayKey(today));
    cheer = Cheer.dayDone;
  }
  if (manager != null) {
    final climbed = recordLadders(
      manager,
      ladders(gatherStats([store], today)),
      DateTime.now(),
    );
    if (climbed.isNotEmpty) {
      cheer = Cheer.ladder;
      final t = context.t;
      // One note for all of them: one at a time would hide the rest.
      noteDone(
        t.achievementUnlocked(
          [
            for (final s in climbed)
              switch (s.id) {
                fullMonthId => t.achievementMonth,
                fullYearId => t.achievementYear,
                fullDecadeId => t.achievementDecade,
                fullCenturyId => t.achievementCentury,
                _ => titleWithChore(t, rankFor(s.tier)!, s.title ?? ''),
              },
          ].join(', '),
        ),
      );
    }
  }
  if (cheer != null) celebrate(context, store, cheer);
}

/// The chores of a cat or home, split as the pages list them: today's
/// in today's order (see [todayOrder]) — one-time chores stand there
/// until the day after they are done; the rest by their next due day;
/// paused ones apart.
({List<Chore> due, List<Chore> later, List<Chore> paused}) partitionChores(
  CatalogStore store,
  List<Chore> chores,
  DateTime today,
) {
  int minutes(Chore c) =>
      c.time == null ? -1 : c.time!.hour * 60 + c.time!.minute;
  int byTime(Chore a, Chore b) {
    final t = minutes(a).compareTo(minutes(b));
    return t != 0 ? t : a.title.toLowerCase().compareTo(b.title.toLowerCase());
  }

  final due = <Chore>[];
  final later = <(Chore, DateTime?)>[];
  final paused = <Chore>[];
  for (final c in chores) {
    final ticks = store.choreTicks(c);
    if (c.paused) {
      paused.add(c);
    } else if (showsToday(c, ticks, today)) {
      due.add(c);
    } else if (!c.once) {
      later.add((c, nextDue(c, ticks, today)));
    }
  }
  final ordered = todayOrder(due, store.choreTicks, today);
  later.sort((a, b) {
    if (a.$2 == null && b.$2 == null) return byTime(a.$1, b.$1);
    if (a.$2 == null) return 1;
    if (b.$2 == null) return -1;
    final d = a.$2!.compareTo(b.$2!);
    return d != 0 ? d : byTime(a.$1, b.$1);
  });
  paused.sort(byTime);
  return (
    due: ordered,
    later: [for (final (c, _) in later) c],
    paused: paused,
  );
}
