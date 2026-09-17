//! Achievements: the ladders a keeper climbs with chores, every full
//! month, year, decade and century of nothing missed, and the mastery
//! of one chore counted in ticks. Recorded per device, never synced.

use std::collections::{BTreeMap, BTreeSet};

use chrono::{Datelike, NaiveDate};
use serde::{Deserialize, Serialize};

use crate::Result;
use crate::catalog::Catalog;
use crate::catalogs::CatalogManager;
use crate::chores::occurrences;

pub const FULL_MONTH: &str = "full-month";
pub const FULL_YEAR: &str = "full-year";
pub const FULL_DECADE: &str = "full-decade";
pub const FULL_CENTURY: &str = "full-century";
pub const MASTER_PREFIX: &str = "master:";
pub const MASTER_TIERS: [i64; 6] = [10, 50, 100, 1000, 10000, 100000];
pub const TITLE_RANKS: [&str; 5] = ["servant", "butler", "steward", "chancellor", "minister"];
pub const COAT_UNLOCKS: [&str; 5] = ["calico", "snowLeopard", "siamese", "lynx", "tortoiseshell"];

/// The rank a mastery tier confers.
pub fn rank_for(tier: i64) -> Option<&'static str> {
    if tier <= 0 {
        return None;
    }
    let index = ((tier - 1) as usize).min(TITLE_RANKS.len() - 1);
    Some(TITLE_RANKS[index])
}

/// The coats unlocked by full months.
pub fn unlocked_coats(full_months: usize) -> Vec<&'static str> {
    COAT_UNLOCKS.iter().copied().take(full_months).collect()
}

/// What the chores add up to.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct ChoreStats {
    /// Ticks per chore title, lowercased.
    pub ticks_by_title: BTreeMap<String, i64>,
    /// The title as written, per lowercased key.
    pub titles: BTreeMap<String, String>,
    /// Months (`YYYY-MM`) with nothing missed; this month never counts.
    pub full_months: BTreeSet<String>,
}

impl Catalog {
    /// The stats over every chore, ended ones included, up to `today`.
    pub fn chore_stats(&self, today: NaiveDate) -> Result<ChoreStats> {
        let mut stats = ChoreStats::default();
        let mut seen: BTreeMap<String, i64> = BTreeMap::new();
        let mut missed: BTreeMap<String, i64> = BTreeMap::new();
        for chore in self.all_chores(true)? {
            let ticks = self.chore_ticks(&chore)?;
            let key = chore.title.trim().to_lowercase();
            if key.is_empty() {
                continue;
            }
            stats
                .titles
                .entry(key.clone())
                .or_insert_with(|| chore.title.trim().to_string());
            *stats.ticks_by_title.entry(key).or_insert(0) += ticks.len() as i64;
            for o in occurrences(&chore, &ticks, chore.start, today) {
                if o.due == today && !o.done() {
                    continue;
                }
                let month = format!("{:04}-{:02}", o.due.year(), o.due.month());
                *seen.entry(month.clone()).or_insert(0) += 1;
                if !o.done() {
                    *missed.entry(month).or_insert(0) += 1;
                }
            }
        }
        let this_month = format!("{:04}-{:02}", today.year(), today.month());
        stats.full_months = seen
            .keys()
            .filter(|m| **m != this_month && missed.get(*m).copied().unwrap_or(0) == 0)
            .cloned()
            .collect();
        Ok(stats)
    }
}

/// One ladder as it stands.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct LadderState {
    pub id: String,
    /// The chore's title for a mastery ladder.
    pub title: Option<String>,
    pub tier: i64,
    pub times: i64,
    /// The next mastery tier, when there is one.
    pub next: Option<i64>,
}

impl LadderState {
    pub fn reached(&self) -> bool {
        self.tier > 0
    }
}

/// Every ladder from the stats: the stretches first, then masteries
/// by ticks.
pub fn ladders(stats: &ChoreStats) -> Vec<LadderState> {
    let months = &stats.full_months;
    let years: BTreeSet<String> = months
        .iter()
        .map(|m| m[..4].to_string())
        .filter(|y| (1..=12).all(|i| months.contains(&format!("{y}-{i:02}"))))
        .collect();
    let decades: BTreeSet<String> = years
        .iter()
        .map(|y| y[..3].to_string())
        .filter(|d| (0..10).all(|i| years.contains(&format!("{d}{i}"))))
        .collect();
    let centuries: BTreeSet<String> = decades
        .iter()
        .map(|d| d[..2].to_string())
        .filter(|c| (0..10).all(|i| decades.contains(&format!("{c}{i}"))))
        .collect();
    let stretch = |id: &str, reached: &BTreeSet<String>| LadderState {
        id: id.to_string(),
        title: None,
        tier: reached.len() as i64,
        times: reached.len() as i64,
        next: None,
    };
    let mut masters: Vec<LadderState> = stats
        .ticks_by_title
        .iter()
        .map(|(key, count)| LadderState {
            id: format!("{MASTER_PREFIX}{key}"),
            title: stats.titles.get(key).cloned(),
            tier: MASTER_TIERS.iter().filter(|t| count >= t).count() as i64,
            times: *count,
            next: MASTER_TIERS.iter().find(|t| count < t).copied(),
        })
        .collect();
    masters.sort_by_key(|m| std::cmp::Reverse(m.times));
    let mut out = vec![
        stretch(FULL_MONTH, months),
        stretch(FULL_YEAR, &years),
        stretch(FULL_DECADE, &decades),
        stretch(FULL_CENTURY, &centuries),
    ];
    out.extend(masters);
    out
}

/// A ladder as recorded: tier, times, first and last time.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct Achievement {
    pub id: String,
    pub tier: i64,
    pub times: i64,
    pub first: String,
    pub last: String,
}

impl CatalogManager {
    /// Records the ladders reached; returns the ones climbed since the
    /// last time, newly reached or a tier up.
    pub fn record_ladders(&mut self, states: &[LadderState], at: &str) -> Result<Vec<LadderState>> {
        let before: BTreeMap<String, Achievement> = self
            .achievements()
            .iter()
            .map(|a| (a.id.clone(), a.clone()))
            .collect();
        let mut climbed = Vec::new();
        for s in states {
            if !s.reached() {
                continue;
            }
            let old = before.get(&s.id);
            if old.is_none_or(|o| s.tier > o.tier) {
                climbed.push(s.clone());
            }
            if old.is_none_or(|o| o.tier != s.tier || o.times != s.times) {
                self.record_achievement(&s.id, s.tier, s.times, at)?;
            }
        }
        Ok(climbed)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::chores::{Chore, ChoreSchedule};

    fn day(y: i32, m: u32, d: u32) -> NaiveDate {
        NaiveDate::from_ymd_opt(y, m, d).unwrap()
    }

    #[test]
    fn a_month_of_ticks_is_a_full_month_and_ten_ticks_make_a_servant() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let feed = store
            .create_chore(
                "c1",
                &Chore {
                    id: String::new(),
                    entity: "cat:a".into(),
                    title: " Feed ".into(),
                    schedule: ChoreSchedule::daily(),
                    time: None,
                    start: day(2026, 2, 1),
                    paused: false,
                    ended: false,
                    remind: false,
                    remind_at: None,
                    extra: Default::default(),
                },
            )
            .unwrap();
        // Every day of February done, one day of March missed so far.
        for d in 1..=28 {
            store
                .tick_chore(&feed, day(2026, 2, d), day(2026, 2, d))
                .unwrap();
        }
        let today = day(2026, 3, 3);
        let stats = store.chore_stats(today).unwrap();
        assert_eq!(stats.ticks_by_title.get("feed"), Some(&28));
        assert_eq!(stats.titles.get("feed").map(String::as_str), Some("Feed"));
        assert_eq!(
            stats.full_months.iter().cloned().collect::<Vec<_>>(),
            vec!["2026-02"]
        );
        let states = ladders(&stats);
        assert_eq!(states[0].id, FULL_MONTH);
        assert_eq!(states[0].tier, 1);
        assert_eq!(states[1].tier, 0, "no full year");
        let master = states.iter().find(|s| s.id == "master:feed").unwrap();
        assert_eq!(master.tier, 1, "ten ticks make a servant");
        assert_eq!(master.next, Some(50));
        assert_eq!(master.title.as_deref(), Some("Feed"));
        assert_eq!(rank_for(master.tier), Some("servant"));
        assert_eq!(rank_for(0), None);
        assert_eq!(rank_for(99), Some("minister"));
        assert_eq!(unlocked_coats(2), vec!["calico", "snowLeopard"]);
        assert!(unlocked_coats(0).is_empty());
        // Recorded once, climbed once; again with the same numbers: nothing.
        let mut manager = CatalogManager::open(&dir.path().join("root"), "Clowders").unwrap();
        let climbed = manager
            .record_ladders(&states, "2026-03-03T10:00:00Z")
            .unwrap();
        assert_eq!(
            climbed.iter().map(|s| s.id.as_str()).collect::<Vec<_>>(),
            vec![FULL_MONTH, "master:feed"]
        );
        assert_eq!(manager.achievements().len(), 2);
        assert!(
            manager
                .record_ladders(&states, "2026-03-04T10:00:00Z")
                .unwrap()
                .is_empty()
        );
        // More ticks: times move, tier does not, nothing climbed.
        store
            .tick_chore(&feed, day(2026, 3, 1), day(2026, 3, 1))
            .unwrap();
        let states = ladders(&store.chore_stats(today).unwrap());
        assert!(
            manager
                .record_ladders(&states, "2026-03-04T11:00:00Z")
                .unwrap()
                .is_empty()
        );
        let feed_record = manager
            .achievements()
            .iter()
            .find(|a| a.id == "master:feed")
            .unwrap()
            .clone();
        assert_eq!(feed_record.times, 29);
        assert_eq!(feed_record.first, "2026-03-03T10:00:00Z");
        assert_eq!(feed_record.last, "2026-03-04T11:00:00Z");
        // The registry keeps them across reopening.
        let again = CatalogManager::open(&dir.path().join("root"), "Clowders").unwrap();
        assert_eq!(again.achievements().len(), 2);
    }

    #[test]
    fn years_decades_and_centuries_stack_on_full_months() {
        let mut stats = ChoreStats::default();
        for y in 2000..2010 {
            for m in 1..=12 {
                stats.full_months.insert(format!("{y}-{m:02}"));
            }
        }
        let states = ladders(&stats);
        assert_eq!(states[0].tier, 120);
        assert_eq!(states[1].tier, 10);
        assert_eq!(states[2].tier, 1, "the 2000s");
        assert_eq!(states[3].tier, 0);
        assert!(states[2].reached());
    }
}
