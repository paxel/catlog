import 'package:catalog_core/catalog_core.dart';

/// Achievements (1.2.0): what the chores add up to over a lifetime.
/// Counted from the ticks of every catalog on this device, kept in the
/// app database as the keeper's own — nothing here syncs.
///
/// Two kinds of ladder: the full stretches — a month, a year, a decade,
/// a century with every due chore done — counted each time reached;
/// and one "master" ladder per chore title, climbing 10, 50, 100,
/// 1,000, 10,000, 100,000 times done.

const fullMonthId = 'full-month';
const fullYearId = 'full-year';
const fullDecadeId = 'full-decade';
const fullCenturyId = 'full-century';
const masterPrefix = 'master:';

const masterTiers = [10, 50, 100, 1000, 10000, 100000];

/// What the chores of the device's catalogs add up to, as of [today].
class ChoreStats {
  /// Ticks per chore title, the title lower-cased and trimmed.
  final Map<String, int> ticksByTitle;

  /// Titles as first seen, for the ladder names.
  final Map<String, String> titles;

  /// Calendar months with at least one occurrence and none missed,
  /// as `YYYY-MM`.
  final Set<String> fullMonths;

  const ChoreStats({
    required this.ticksByTitle,
    required this.titles,
    required this.fullMonths,
  });
}

/// Reads the stats from [stores]: every chore ever, ended ones too.
ChoreStats gatherStats(Iterable<CatalogStore> stores, DateTime today) {
  today = dayOf(today);
  final ticksByTitle = <String, int>{};
  final titles = <String, String>{};
  // Per month: occurrences seen, occurrences missed.
  final seen = <String, int>{};
  final missed = <String, int>{};
  for (final store in stores) {
    for (final chore in store.allChores(includeEnded: true)) {
      final ticks = store.choreTicks(chore);
      final key = chore.title.trim().toLowerCase();
      if (key.isEmpty) continue;
      titles.putIfAbsent(key, () => chore.title.trim());
      ticksByTitle[key] = (ticksByTitle[key] ?? 0) + ticks.length;
      for (final o in occurrences(chore, ticks, chore.start, today)) {
        if (o.due == today && !o.done) continue; // still pending
        final month =
            '${o.due.year.toString().padLeft(4, '0')}-'
            '${o.due.month.toString().padLeft(2, '0')}';
        seen[month] = (seen[month] ?? 0) + 1;
        if (!o.done) missed[month] = (missed[month] ?? 0) + 1;
      }
    }
  }
  // A month still running is not full yet.
  final thisMonth =
      '${today.year.toString().padLeft(4, '0')}-'
      '${today.month.toString().padLeft(2, '0')}';
  final fullMonths = {
    for (final m in seen.keys)
      if (m != thisMonth && (missed[m] ?? 0) == 0) m,
  };
  return ChoreStats(
    ticksByTitle: ticksByTitle,
    titles: titles,
    fullMonths: fullMonths,
  );
}

/// One ladder as the stats read it now.
class LadderState {
  final String id;

  /// For master ladders the title; null for the full stretches.
  final String? title;

  /// The tier reached: for the stretches the count of stretches, for a
  /// master ladder the index into [masterTiers] plus one, zero for none.
  final int tier;

  /// How many times: full stretches counted, or ticks done.
  final int times;

  /// The next threshold, null at the top.
  final int? next;

  const LadderState({
    required this.id,
    this.title,
    required this.tier,
    required this.times,
    this.next,
  });

  bool get reached => tier > 0;
}

/// The ladders from the stats: the four stretches first, then a master
/// ladder per title, most ticks first.
List<LadderState> ladders(ChoreStats stats) {
  final months = stats.fullMonths;
  // Years whose twelve months are all full, and so on up.
  final years = <String>{
    for (final y in months.map((m) => m.substring(0, 4)))
      if (List.generate(
        12,
        (i) => '$y-${(i + 1).toString().padLeft(2, '0')}',
      ).every(months.contains))
        y,
  };
  final decades = <String>{
    for (final d in years.map((y) => y.substring(0, 3)))
      if (List.generate(10, (i) => '$d$i').every(years.contains)) d,
  };
  final centuries = <String>{
    for (final c in decades.map((d) => d.substring(0, 2)))
      if (List.generate(10, (i) => '$c$i').every(decades.contains)) c,
  };
  LadderState stretch(String id, Set<String> reached) => LadderState(
    id: id,
    tier: reached.length,
    times: reached.length,
    next: null,
  );
  final masters = [
    for (final MapEntry(key: key, value: count) in stats.ticksByTitle.entries)
      LadderState(
        id: '$masterPrefix$key',
        title: stats.titles[key],
        tier: masterTiers.where((t) => count >= t).length,
        times: count,
        next: masterTiers.where((t) => count < t).firstOrNull,
      ),
  ]..sort((a, b) => b.times.compareTo(a.times));
  return [
    stretch(fullMonthId, months),
    stretch(fullYearId, years),
    stretch(fullDecadeId, decades),
    stretch(fullCenturyId, centuries),
    ...masters,
  ];
}

/// Records the ladders in the app database and returns the ones that
/// climbed since last time — a new tier, or another full stretch — for
/// the celebration. A ladder not reached is not recorded.
List<LadderState> recordLadders(
  CatalogManager manager,
  List<LadderState> states,
  DateTime at,
) {
  final before = {for (final a in manager.achievements()) a.id: a};
  final climbed = <LadderState>[];
  for (final s in states) {
    if (!s.reached) continue;
    final old = before[s.id];
    if (old == null || s.tier > old.tier) climbed.add(s);
    if (old == null || s.tier != old.tier || s.times != old.times) {
      manager.recordAchievement(s.id, tier: s.tier, times: s.times, at: at);
    }
  }
  return climbed;
}
