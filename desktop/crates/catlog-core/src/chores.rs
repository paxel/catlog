//! Chores: the recurring care of a cat or a home as a daily checklist
//! with streaks. A chore is one `$chore:<id>` entry whose value is a
//! small JSON document; edits, pausing and ending are later entries on
//! the same key. A tick is its own entry keyed by the occurrence day.

use std::collections::BTreeMap;

use chrono::{Datelike, Days, NaiveDate, Weekday};
use serde::{Deserialize, Serialize};
use serde_json::Value;

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::keys;

/// How often a chore comes around.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum ChoreRepeat {
    Daily,
    EveryDays,
    Weekdays,
}

/// The unit of an every-N gap. Months and years step by the calendar.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum ChoreUnit {
    Days,
    Weeks,
    Months,
    Years,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ChoreSchedule {
    pub repeat: ChoreRepeat,
    /// For every-N: the gap in units, counted from the day the chore was
    /// last done.
    pub every: u32,
    pub unit: ChoreUnit,
    /// For weekdays: Monday = 1 .. Sunday = 7.
    pub weekdays: Vec<u32>,
}

impl ChoreSchedule {
    pub fn daily() -> ChoreSchedule {
        ChoreSchedule {
            repeat: ChoreRepeat::Daily,
            every: 1,
            unit: ChoreUnit::Days,
            weekdays: Vec::new(),
        }
    }

    pub fn every(every: u32, unit: ChoreUnit) -> ChoreSchedule {
        ChoreSchedule {
            repeat: ChoreRepeat::EveryDays,
            every,
            unit,
            weekdays: Vec::new(),
        }
    }

    pub fn weekdays(mut days: Vec<u32>) -> ChoreSchedule {
        days.sort_unstable();
        days.dedup();
        ChoreSchedule {
            repeat: ChoreRepeat::Weekdays,
            every: 1,
            unit: ChoreUnit::Days,
            weekdays: days,
        }
    }

    /// `day` moved forward by the gap.
    pub fn step(&self, day: NaiveDate) -> NaiveDate {
        match self.unit {
            ChoreUnit::Days => days_from(day, self.every as i64),
            ChoreUnit::Weeks => days_from(day, 7 * self.every as i64),
            ChoreUnit::Months => months_from(day, self.every as i32),
            ChoreUnit::Years => months_from(day, 12 * self.every as i32),
        }
    }

    pub fn to_json(&self) -> Value {
        let mut m = serde_json::Map::new();
        m.insert(
            "repeat".into(),
            serde_json::to_value(self.repeat).unwrap_or(Value::Null),
        );
        if self.repeat == ChoreRepeat::EveryDays {
            m.insert("every".into(), Value::from(self.every));
            // Absent for days, so a 1.2.0 reader sees the old shape.
            if self.unit != ChoreUnit::Days {
                m.insert(
                    "unit".into(),
                    serde_json::to_value(self.unit).unwrap_or(Value::Null),
                );
            }
        }
        if self.repeat == ChoreRepeat::Weekdays {
            m.insert("days".into(), Value::from(self.weekdays.clone()));
        }
        Value::Object(m)
    }

    pub fn from_json(json: &Value) -> ChoreSchedule {
        match json.get("repeat").and_then(Value::as_str) {
            Some("everyDays") => ChoreSchedule::every(
                json.get("every").and_then(Value::as_u64).unwrap_or(1) as u32,
                json.get("unit")
                    .and_then(|u| serde_json::from_value(u.clone()).ok())
                    .unwrap_or(ChoreUnit::Days),
            ),
            Some("weekdays") => ChoreSchedule::weekdays(
                json.get("days")
                    .and_then(Value::as_array)
                    .map(|d| {
                        d.iter()
                            .filter_map(Value::as_u64)
                            .map(|d| d as u32)
                            .collect()
                    })
                    .unwrap_or_default(),
            ),
            _ => ChoreSchedule::daily(),
        }
    }
}

/// A time of day.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Hhmm {
    pub hour: u32,
    pub minute: u32,
}

impl Hhmm {
    pub fn text(&self) -> String {
        format!("{:02}:{:02}", self.hour, self.minute)
    }

    pub fn parse(raw: &str) -> Option<Hhmm> {
        let (h, m) = raw.split_once(':')?;
        Some(Hhmm {
            hour: h.parse().ok()?,
            minute: m.parse().ok()?,
        })
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Chore {
    pub id: String,
    pub entity: String,
    pub title: String,
    pub schedule: ChoreSchedule,
    /// Time of day it is meant for; none when any time will do.
    pub time: Option<Hhmm>,
    /// The first day it is due.
    pub start: NaiveDate,
    pub paused: bool,
    pub ended: bool,
    /// A reminder on due days, at `remind_at`; off by default.
    pub remind: bool,
    pub remind_at: Option<Hhmm>,
    /// Keys this version does not know, carried through unchanged.
    pub extra: BTreeMap<String, Value>,
}

const KNOWN: [&str; 8] = [
    "title", "schedule", "time", "start", "paused", "ended", "remind", "remindAt",
];

impl Chore {
    pub fn key(&self) -> String {
        format!("{}{}", keys::CHORE_PREFIX, self.id)
    }

    pub fn active(&self) -> bool {
        !self.paused && !self.ended
    }

    pub fn to_json(&self) -> Value {
        let mut m = serde_json::Map::new();
        for (k, v) in &self.extra {
            m.insert(k.clone(), v.clone());
        }
        m.insert("title".into(), Value::from(self.title.clone()));
        m.insert("schedule".into(), self.schedule.to_json());
        if let Some(t) = self.time {
            m.insert("time".into(), Value::from(t.text()));
        }
        m.insert("start".into(), Value::from(day_key(self.start)));
        if self.paused {
            m.insert("paused".into(), Value::Bool(true));
        }
        if self.ended {
            m.insert("ended".into(), Value::Bool(true));
        }
        if self.remind {
            m.insert("remind".into(), Value::Bool(true));
        }
        if let Some(t) = self.remind_at {
            m.insert("remindAt".into(), Value::from(t.text()));
        }
        Value::Object(m)
    }

    /// Parses a stored value; none when it is not a chore document.
    pub fn from_json(id: &str, entity: &str, raw: Option<&str>) -> Option<Chore> {
        let json: Value = serde_json::from_str(raw?).ok()?;
        let obj = json.as_object()?;
        let text = |k: &str| obj.get(k).and_then(Value::as_str);
        Some(Chore {
            id: id.to_string(),
            entity: entity.to_string(),
            title: text("title").unwrap_or_default().to_string(),
            schedule: ChoreSchedule::from_json(obj.get("schedule").unwrap_or(&Value::Null)),
            time: text("time").and_then(Hhmm::parse),
            start: parse_day(text("start"))
                .unwrap_or(NaiveDate::from_ymd_opt(1970, 1, 1).unwrap_or_default()),
            paused: obj.get("paused") == Some(&Value::Bool(true)),
            ended: obj.get("ended") == Some(&Value::Bool(true)),
            remind: obj.get("remind") == Some(&Value::Bool(true)),
            remind_at: text("remindAt").and_then(Hhmm::parse),
            extra: obj
                .iter()
                .filter(|(k, _)| !KNOWN.contains(&k.as_str()))
                .map(|(k, v)| (k.clone(), v.clone()))
                .collect(),
        })
    }
}

/// `n` calendar days on from `d`.
pub fn days_from(d: NaiveDate, n: i64) -> NaiveDate {
    if n >= 0 {
        d.checked_add_days(Days::new(n as u64)).unwrap_or(d)
    } else {
        d.checked_sub_days(Days::new((-n) as u64)).unwrap_or(d)
    }
}

/// `day` plus `n` calendar months, the day of month clamped to the
/// target month's last day.
pub fn months_from(day: NaiveDate, n: i32) -> NaiveDate {
    let month0 = day.month0() as i32 + n;
    let year = day.year() + month0.div_euclid(12);
    let month = month0.rem_euclid(12) as u32 + 1;
    let last = last_day(year, month);
    NaiveDate::from_ymd_opt(year, month, day.day().min(last)).unwrap_or(day)
}

fn last_day(year: i32, month: u32) -> u32 {
    let next = if month == 12 {
        NaiveDate::from_ymd_opt(year + 1, 1, 1)
    } else {
        NaiveDate::from_ymd_opt(year, month + 1, 1)
    };
    next.and_then(|n| n.pred_opt())
        .map(|d| d.day())
        .unwrap_or(28)
}

/// `YYYY-MM-DD` of a day: the tick key's suffix and the tick's value.
pub fn day_key(d: NaiveDate) -> String {
    format!("{:04}-{:02}-{:02}", d.year(), d.month(), d.day())
}

pub fn parse_day(raw: Option<&str>) -> Option<NaiveDate> {
    let parts: Vec<&str> = raw?.split('-').collect();
    if parts.len() != 3 {
        return None;
    }
    NaiveDate::from_ymd_opt(
        parts[0].parse().ok()?,
        parts[1].parse().ok()?,
        parts[2].parse().ok()?,
    )
}

/// What a day is for a chore.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ChoreDay {
    NotDue,
    Pending,
    Done,
    Missed,
    Upcoming,
}

/// One occurrence of a chore: the day it was due and, when done, the
/// day it was done.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ChoreOccurrence {
    pub due: NaiveDate,
    pub done_on: Option<NaiveDate>,
}

impl ChoreOccurrence {
    pub fn done(&self) -> bool {
        self.done_on.is_some()
    }
}

/// The ticks of a chore: occurrence day to the day it was done.
pub type Ticks = BTreeMap<NaiveDate, NaiveDate>;

fn weekday_number(d: NaiveDate) -> u32 {
    match d.weekday() {
        Weekday::Mon => 1,
        Weekday::Tue => 2,
        Weekday::Wed => 3,
        Weekday::Thu => 4,
        Weekday::Fri => 5,
        Weekday::Sat => 6,
        Weekday::Sun => 7,
    }
}

/// The occurrences of `chore` with due day in `from..=to`, oldest first.
/// For an every-N chore the next due day counts N from the day it was
/// last done; a due day with no tick is a miss.
pub fn occurrences(
    chore: &Chore,
    ticks: &Ticks,
    from: NaiveDate,
    to: NaiveDate,
) -> Vec<ChoreOccurrence> {
    let start = chore.start;
    let mut result = Vec::new();
    let mut add = |due: NaiveDate| {
        if due < from || due > to {
            return;
        }
        result.push(ChoreOccurrence {
            due,
            done_on: ticks.get(&due).copied(),
        });
    };
    match chore.schedule.repeat {
        ChoreRepeat::Daily | ChoreRepeat::Weekdays => {
            let mut day = if start > from { start } else { from };
            while day <= to {
                if chore.schedule.repeat == ChoreRepeat::Daily
                    || chore.schedule.weekdays.contains(&weekday_number(day))
                {
                    add(day);
                }
                day = days_from(day, 1);
            }
        }
        ChoreRepeat::EveryDays => {
            let schedule = if chore.schedule.every < 1 {
                ChoreSchedule::every(1, chore.schedule.unit)
            } else {
                chore.schedule.clone()
            };
            let mut anchor = start;
            for (occurrence, done) in ticks {
                while anchor < *occurrence {
                    add(anchor);
                    anchor = schedule.step(anchor);
                }
                add(*occurrence);
                anchor = schedule.step(*done);
            }
            while anchor <= to {
                add(anchor);
                anchor = schedule.step(anchor);
            }
        }
    }
    result
}

/// The state of `day` for `chore`, seen from `today`.
pub fn state_on(chore: &Chore, ticks: &Ticks, day: NaiveDate, today: NaiveDate) -> ChoreDay {
    let hit = occurrences(chore, ticks, day, day);
    let Some(first) = hit.first() else {
        return ChoreDay::NotDue;
    };
    if first.done() {
        ChoreDay::Done
    } else if day < today {
        ChoreDay::Missed
    } else if day > today {
        ChoreDay::Upcoming
    } else {
        ChoreDay::Pending
    }
}

/// Whether the chore is due on `day` (done or not).
pub fn is_due_on(chore: &Chore, ticks: &Ticks, day: NaiveDate) -> bool {
    !occurrences(chore, ticks, day, day).is_empty()
}

/// The first due day on or after `today` that is not done yet.
pub fn next_due(chore: &Chore, ticks: &Ticks, today: NaiveDate) -> Option<NaiveDate> {
    occurrences(chore, ticks, today, days_from(today, 3660))
        .into_iter()
        .find(|o| !o.done())
        .map(|o| o.due)
}

/// Due days after `today` within `days` that are not done. Dailies are
/// left out, they are upcoming by nature.
pub fn upcoming(chore: &Chore, ticks: &Ticks, today: NaiveDate, days: i64) -> Vec<NaiveDate> {
    if chore.schedule.repeat == ChoreRepeat::Daily {
        return Vec::new();
    }
    occurrences(chore, ticks, days_from(today, 1), days_from(today, days))
        .into_iter()
        .filter(|o| !o.done())
        .map(|o| o.due)
        .collect()
}

/// Consecutive done occurrences up to `today`. Today counts when done
/// and is skipped while still pending; a missed day before that ends
/// the run.
pub fn streak(chore: &Chore, ticks: &Ticks, today: NaiveDate) -> u32 {
    let mut run = 0;
    for o in occurrences(chore, ticks, chore.start, today).iter().rev() {
        if o.done() {
            run += 1;
        } else if o.due == today {
            continue;
        } else {
            break;
        }
    }
    run
}

/// The longest run of done occurrences ever, up to `today`.
pub fn best_streak(chore: &Chore, ticks: &Ticks, today: NaiveDate) -> u32 {
    let mut best = 0;
    let mut run = 0;
    for o in occurrences(chore, ticks, chore.start, today) {
        if o.done() {
            run += 1;
            best = best.max(run);
        } else if o.due != today {
            run = 0;
        }
    }
    best
}

/// The last seven days ending `today`, one state each: the week dots.
pub fn week_dots(chore: &Chore, ticks: &Ticks, today: NaiveDate) -> Vec<ChoreDay> {
    (0..7)
        .rev()
        .map(|i| state_on(chore, ticks, days_from(today, -i), today))
        .collect()
}

/// One due day of a chore as the log tells it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ChoreLogRow {
    pub due: NaiveDate,
    pub state: ChoreDay,
    pub done_on: Option<NaiveDate>,
    pub author: Option<String>,
    pub recorded: Option<String>,
    /// The tick entry behind a done day.
    pub tick: Option<Entry>,
}

impl ChoreLogRow {
    pub fn early(&self) -> bool {
        self.done_on.is_some_and(|d| d < self.due)
    }

    pub fn late(&self) -> bool {
        self.done_on.is_some_and(|d| d > self.due)
    }
}

impl Catalog {
    /// Records a new chore under `id` and returns it.
    pub fn create_chore(&mut self, id: &str, draft: &Chore) -> Result<Chore> {
        let made = Chore {
            id: id.to_string(),
            ..draft.clone()
        };
        self.append(&made.entity, &made.key(), Some(&made.to_json().to_string()))?;
        Ok(made)
    }

    /// Writes the chore as it now is: an edit, a pause, an end.
    pub fn update_chore(&mut self, chore: &Chore) -> Result<()> {
        self.append(
            &chore.entity,
            &chore.key(),
            Some(&chore.to_json().to_string()),
        )
    }

    /// The chores of one cat or home, ended ones on request, by title.
    pub fn chores_of(&self, entity: &str, include_ended: bool) -> Result<Vec<Chore>> {
        let canonical = self.resolve_entity(entity)?;
        let mut result = Vec::new();
        for (key, value) in self.current_fields(&canonical)? {
            let Some(id) = key.strip_prefix(keys::CHORE_PREFIX) else {
                continue;
            };
            if id.contains('@') {
                continue;
            }
            let Some(c) = Chore::from_json(id, &canonical, value.as_deref()) else {
                continue;
            };
            if c.ended && !include_ended {
                continue;
            }
            result.push(c);
        }
        result.sort_by_key(|c| c.title.to_lowercase());
        Ok(result)
    }

    /// Every chore in the Catalog.
    pub fn all_chores(&self, include_ended: bool) -> Result<Vec<Chore>> {
        let mut out = Vec::new();
        for e in self.cats(None)?.into_iter().chain(self.clowders()?) {
            out.extend(self.chores_of(&e.id, include_ended)?);
        }
        Ok(out)
    }

    /// The ticks of a chore: occurrence day to the day it was done.
    pub fn chore_ticks(&self, chore: &Chore) -> Result<Ticks> {
        let prefix = format!("{}@", chore.key());
        let mut ticks = Ticks::new();
        for (key, value) in self.current_fields(&self.resolve_entity(&chore.entity)?)? {
            let Some(due) = key.strip_prefix(&prefix) else {
                continue;
            };
            if let (Some(due), Some(done)) = (parse_day(Some(due)), parse_day(value.as_deref())) {
                ticks.insert(due, done);
            }
        }
        Ok(ticks)
    }

    /// Marks the occurrence due on `occurrence` done on `done_on`.
    pub fn tick_chore(
        &mut self,
        chore: &Chore,
        occurrence: NaiveDate,
        done_on: NaiveDate,
    ) -> Result<()> {
        let key = format!("{}@{}", chore.key(), day_key(occurrence));
        self.append(&chore.entity, &key, Some(&day_key(done_on)))
    }

    /// Takes a tick back.
    pub fn untick_chore(&mut self, chore: &Chore, occurrence: NaiveDate) -> Result<()> {
        let key = format!("{}@{}", chore.key(), day_key(occurrence));
        self.append(&chore.entity, &key, None)
    }

    /// The chore's due days from its start to `today`, newest first,
    /// each with what happened.
    pub fn chore_log(&self, chore: &Chore, today: NaiveDate) -> Result<Vec<ChoreLogRow>> {
        let ticks = self.chore_ticks(chore)?;
        let entity = self.resolve_entity(&chore.entity)?;
        let mut rows = Vec::new();
        for o in occurrences(chore, &ticks, chore.start, today) {
            let state = state_on(chore, &ticks, o.due, today);
            let tick = if o.done() {
                self.field_history(
                    &entity,
                    &format!("{}@{}", chore.key(), day_key(o.due)),
                    false,
                )?
                .into_iter()
                .find(|e| e.value.is_some())
            } else {
                None
            };
            rows.push(ChoreLogRow {
                due: o.due,
                state,
                done_on: o.done_on,
                author: tick.as_ref().map(|t| t.author.clone()),
                recorded: tick.as_ref().map(|t| t.recorded.clone()),
                tick,
            });
        }
        rows.sort_by_key(|r| std::cmp::Reverse(r.due));
        Ok(rows)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn d(y: i32, m: u32, day: u32) -> NaiveDate {
        NaiveDate::from_ymd_opt(y, m, day).unwrap()
    }

    fn chore(schedule: ChoreSchedule, start: NaiveDate) -> Chore {
        Chore {
            id: "c1".into(),
            entity: "cat:a".into(),
            title: "Drops".into(),
            schedule,
            time: None,
            start,
            paused: false,
            ended: false,
            remind: false,
            remind_at: None,
            extra: BTreeMap::new(),
        }
    }

    #[test]
    fn schedules_round_trip_their_json_like_the_phones() {
        let daily = ChoreSchedule::daily();
        assert_eq!(daily.to_json().to_string(), r#"{"repeat":"daily"}"#);
        let every = ChoreSchedule::every(2, ChoreUnit::Weeks);
        assert_eq!(
            every.to_json().to_string(),
            r#"{"every":2,"repeat":"everyDays","unit":"weeks"}"#
        );
        let days = ChoreSchedule::every(3, ChoreUnit::Days);
        assert_eq!(
            days.to_json().to_string(),
            r#"{"every":3,"repeat":"everyDays"}"#
        );
        let week = ChoreSchedule::weekdays(vec![5, 1, 1]);
        assert_eq!(
            week.to_json().to_string(),
            r#"{"days":[1,5],"repeat":"weekdays"}"#
        );
        for s in [&daily, &every, &days, &week] {
            assert_eq!(&ChoreSchedule::from_json(&s.to_json()), s);
        }
        assert_eq!(ChoreSchedule::from_json(&Value::Null), daily);
        assert_eq!(
            ChoreSchedule::from_json(&serde_json::json!({"repeat": "everyDays"})).every,
            1
        );
        assert_eq!(every.step(d(2026, 1, 1)), d(2026, 1, 15));
        assert_eq!(
            ChoreSchedule::every(1, ChoreUnit::Months).step(d(2026, 1, 31)),
            d(2026, 2, 28)
        );
        assert_eq!(
            ChoreSchedule::every(1, ChoreUnit::Years).step(d(2024, 2, 29)),
            d(2025, 2, 28)
        );
        assert_eq!(months_from(d(2026, 11, 15), 3), d(2027, 2, 15));
        assert_eq!(months_from(d(2026, 3, 15), -3), d(2025, 12, 15));
        assert_eq!(days_from(d(2026, 1, 1), -1), d(2025, 12, 31));
        assert_eq!(day_key(d(2026, 1, 5)), "2026-01-05");
        assert_eq!(parse_day(Some("2026-01-05")), Some(d(2026, 1, 5)));
        assert_eq!(parse_day(Some("nope")), None);
        assert_eq!(parse_day(None), None);
        assert_eq!(Hhmm::parse("07:30").unwrap().text(), "07:30");
        assert_eq!(Hhmm::parse("x"), None);
    }

    #[test]
    fn a_chore_document_keeps_unknown_keys() {
        let raw = r#"{"title":"Drops","schedule":{"repeat":"daily"},"time":"08:00","start":"2026-01-01","paused":true,"remind":true,"remindAt":"07:30","future":42}"#;
        let c = Chore::from_json("c1", "cat:a", Some(raw)).unwrap();
        assert_eq!(c.time, Some(Hhmm { hour: 8, minute: 0 }));
        assert!(c.paused && !c.ended && c.remind && !c.active());
        assert_eq!(c.extra["future"], 42);
        let back = c.to_json();
        assert_eq!(back["future"], 42);
        assert_eq!(back["remindAt"], "07:30");
        assert_eq!(c.key(), "$chore:c1");
        assert!(Chore::from_json("c1", "cat:a", None).is_none());
        assert!(Chore::from_json("c1", "cat:a", Some("junk")).is_none());
        let bare = Chore::from_json("c1", "cat:a", Some("{}")).unwrap();
        assert_eq!(bare.start, d(1970, 1, 1));
    }

    #[test]
    fn occurrences_follow_the_schedule_and_the_ticks() {
        let start = d(2026, 1, 1);
        let daily = chore(ChoreSchedule::daily(), start);
        let ticks = Ticks::new();
        assert_eq!(
            occurrences(&daily, &ticks, d(2025, 12, 30), d(2026, 1, 3)).len(),
            3
        );
        let weekdays = chore(ChoreSchedule::weekdays(vec![1, 4]), start);
        let due: Vec<NaiveDate> = occurrences(&weekdays, &ticks, start, d(2026, 1, 14))
            .iter()
            .map(|o| o.due)
            .collect();
        assert_eq!(
            due,
            vec![d(2026, 1, 1), d(2026, 1, 5), d(2026, 1, 8), d(2026, 1, 12)]
        );
        // Every three days: a late tick pushes the schedule, an early one pulls it.
        let every = chore(ChoreSchedule::every(3, ChoreUnit::Days), start);
        let mut ticks = Ticks::new();
        ticks.insert(d(2026, 1, 4), d(2026, 1, 5));
        let due: Vec<(NaiveDate, bool)> = occurrences(&every, &ticks, start, d(2026, 1, 12))
            .iter()
            .map(|o| (o.due, o.done()))
            .collect();
        assert_eq!(
            due,
            vec![
                (d(2026, 1, 1), false),
                (d(2026, 1, 4), true),
                (d(2026, 1, 8), false),
                (d(2026, 1, 11), false)
            ]
        );
        let zero = chore(ChoreSchedule::every(0, ChoreUnit::Days), start);
        assert_eq!(
            occurrences(&zero, &Ticks::new(), start, d(2026, 1, 3)).len(),
            3
        );
        // States, next due, upcoming, streaks, dots.
        let today = d(2026, 1, 8);
        assert_eq!(
            state_on(&every, &ticks, d(2026, 1, 1), today),
            ChoreDay::Missed
        );
        assert_eq!(
            state_on(&every, &ticks, d(2026, 1, 4), today),
            ChoreDay::Done
        );
        assert_eq!(
            state_on(&every, &ticks, d(2026, 1, 8), today),
            ChoreDay::Pending
        );
        assert_eq!(
            state_on(&every, &ticks, d(2026, 1, 11), today),
            ChoreDay::Upcoming
        );
        assert_eq!(
            state_on(&every, &ticks, d(2026, 1, 9), today),
            ChoreDay::NotDue
        );
        assert!(is_due_on(&every, &ticks, d(2026, 1, 11)));
        assert_eq!(next_due(&every, &ticks, today), Some(d(2026, 1, 8)));
        assert_eq!(
            upcoming(&every, &ticks, today, 7),
            vec![d(2026, 1, 11), d(2026, 1, 14)]
        );
        assert!(upcoming(&daily, &ticks, today, 7).is_empty());
        assert_eq!(streak(&every, &ticks, today), 1);
        assert_eq!(best_streak(&every, &ticks, today), 1);
        let mut all = Ticks::new();
        for day in 1..=7 {
            all.insert(d(2026, 1, day), d(2026, 1, day));
        }
        assert_eq!(
            streak(&daily, &all, d(2026, 1, 8)),
            7,
            "today pending is skipped"
        );
        assert_eq!(
            streak(&daily, &all, d(2026, 1, 9)),
            0,
            "yesterday missed ends the run"
        );
        assert_eq!(best_streak(&daily, &all, d(2026, 1, 9)), 7);
        assert_eq!(week_dots(&daily, &all, d(2026, 1, 8)).len(), 7);
        assert_eq!(week_dots(&daily, &all, d(2026, 1, 8))[6], ChoreDay::Pending);
        assert_eq!(week_dots(&daily, &all, d(2026, 1, 8))[0], ChoreDay::Done);
    }

    #[test]
    fn chores_live_in_the_log_with_their_ticks() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let drops = c
            .create_chore("c1", &chore(ChoreSchedule::daily(), d(2026, 1, 1)))
            .unwrap();
        let mut feed = chore(ChoreSchedule::every(2, ChoreUnit::Days), d(2026, 1, 1));
        feed.title = "Feed".into();
        let feed = c.create_chore("c2", &feed).unwrap();
        assert_eq!(
            c.chores_of("cat:a", false)
                .unwrap()
                .iter()
                .map(|x| x.title.as_str())
                .collect::<Vec<_>>(),
            vec!["Drops", "Feed"]
        );
        c.tick_chore(&drops, d(2026, 1, 1), d(2026, 1, 1)).unwrap();
        c.tick_chore(&drops, d(2026, 1, 2), d(2026, 1, 2)).unwrap();
        c.untick_chore(&drops, d(2026, 1, 2)).unwrap();
        let ticks = c.chore_ticks(&drops).unwrap();
        assert_eq!(ticks.len(), 1);
        let log = c.chore_log(&drops, d(2026, 1, 3)).unwrap();
        assert_eq!(log.len(), 3);
        assert_eq!(log[0].state, ChoreDay::Pending);
        assert_eq!(log[1].state, ChoreDay::Missed);
        assert_eq!(
            (log[2].state, log[2].author.as_deref()),
            (ChoreDay::Done, Some("Ada"))
        );
        assert!(!log[2].early() && !log[2].late());
        let mut ended = feed.clone();
        ended.ended = true;
        c.update_chore(&ended).unwrap();
        assert_eq!(c.chores_of("cat:a", false).unwrap().len(), 1);
        assert_eq!(c.all_chores(true).unwrap().len(), 2);
    }
}
