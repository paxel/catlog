//! The agenda as the desk reads it: chores due today and coming up,
//! the plans and appointments in date order, and the moments a reminder
//! should sound while the app runs.

use chrono::{NaiveDate, NaiveDateTime, NaiveTime};

use crate::Result;
use crate::appointments::{Appointment, AppointmentAlert};
use crate::catalog::Catalog;
use crate::chores::{Chore, days_from, is_due_on, next_due, upcoming};
use crate::entities::ActiveReminder;

/// The chores section of the agenda.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct ChoresAgenda {
    pub day: NaiveDate,
    /// Due today, done or not, by time of day, chores without a time
    /// first.
    pub today: Vec<Chore>,
    /// The next due day of every chore due within the week.
    pub upcoming: Vec<(Chore, NaiveDate)>,
    /// Paused chores stay in sight, so one tap on Pause never hides one
    /// for good.
    pub paused: Vec<Chore>,
}

impl ChoresAgenda {
    /// True when every chore due today is ticked.
    pub fn all_done_today(&self, store: &Catalog) -> bool {
        !self.today.is_empty()
            && self.today.iter().all(|c| {
                store
                    .chore_ticks(c)
                    .map(|ticks| ticks.contains_key(&self.day))
                    .unwrap_or(false)
            })
    }
}

fn by_time(a: &Chore, b: &Chore) -> std::cmp::Ordering {
    let minutes = |c: &Chore| {
        c.time
            .map(|t| t.hour as i64 * 60 + t.minute as i64)
            .unwrap_or(-1)
    };
    minutes(a)
        .cmp(&minutes(b))
        .then_with(|| a.title.to_lowercase().cmp(&b.title.to_lowercase()))
}

impl Catalog {
    /// The chores section for `today`.
    pub fn chores_agenda(&self, today: NaiveDate) -> Result<ChoresAgenda> {
        let all = self.all_chores(false)?;
        let mut agenda = ChoresAgenda {
            day: today,
            ..Default::default()
        };
        for c in &all {
            if c.paused {
                agenda.paused.push(c.clone());
                continue;
            }
            if !c.active() {
                continue;
            }
            let ticks = self.chore_ticks(c)?;
            if is_due_on(c, &ticks, today) {
                agenda.today.push(c.clone());
            }
            if let Some(day) = upcoming(c, &ticks, today, 7).into_iter().next() {
                agenda.upcoming.push((c.clone(), day));
            }
        }
        agenda.today.sort_by(by_time);
        agenda
            .upcoming
            .sort_by(|a, b| a.1.cmp(&b.1).then_with(|| by_time(&a.0, &b.0)));
        agenda.paused.sort_by_key(|c| c.title.to_lowercase());
        Ok(agenda)
    }

    /// Everything planned, in date order: one item per active plan and
    /// one per open appointment group (a Vet Run is one item).
    pub fn agenda_items(&self) -> Result<Vec<AgendaItem>> {
        let mut items: Vec<AgendaItem> = self
            .active_reminders()?
            .into_iter()
            .map(|r| AgendaItem::Reminder(Box::new(r)))
            .collect();
        for group in self.open_appointment_groups()? {
            items.push(AgendaItem::Appointments(group));
        }
        items.sort_by_key(|i| i.when());
        Ok(items)
    }

    /// The reminders that should sound after `now`, soonest first: a
    /// chore's next due day at its reminder time, an appointment a day
    /// or an hour before it starts.
    pub fn planned_reminders(&self, now: NaiveDateTime) -> Result<Vec<PlannedReminder>> {
        let today = now.date();
        let mut out = Vec::new();
        for chore in self.all_chores(false)? {
            if !chore.active() || !chore.remind {
                continue;
            }
            let Some(at) = chore.remind_at.or(chore.time) else {
                continue;
            };
            let Some(time) = NaiveTime::from_hms_opt(at.hour, at.minute, 0) else {
                continue;
            };
            let ticks = self.chore_ticks(&chore)?;
            let Some(due) = next_due(&chore, &ticks, today) else {
                continue;
            };
            let mut when = due.and_time(time);
            if when <= now {
                let Some(later) = next_due(&chore, &ticks, days_from(today, 1)) else {
                    continue;
                };
                when = later.and_time(time);
            }
            out.push(PlannedReminder {
                id: format!("chore:{}", chore.id),
                at: when,
                title: chore.title.clone(),
                entity: chore.entity.clone(),
            });
        }
        for group in self.open_appointment_groups()? {
            let a = &group[0];
            let minutes = match a.alert {
                AppointmentAlert::None => continue,
                AppointmentAlert::DayBefore => 24 * 60,
                AppointmentAlert::HourBefore => 60,
            };
            let at = a.start() - chrono::Duration::minutes(minutes);
            if at <= now {
                continue;
            }
            out.push(PlannedReminder {
                id: format!("appt:{}", a.group.clone().unwrap_or_else(|| a.id.clone())),
                at,
                title: a.title.clone(),
                entity: a.entity.clone(),
            });
        }
        out.sort_by(|x, y| x.at.cmp(&y.at).then_with(|| x.id.cmp(&y.id)));
        Ok(out)
    }
}

/// One line of the agenda's Planned section.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AgendaItem {
    Reminder(Box<ActiveReminder>),
    /// One appointment, or a Vet Run's members.
    Appointments(Vec<Appointment>),
}

impl AgendaItem {
    /// When it is: a plan's day, an appointment's start.
    pub fn when(&self) -> NaiveDateTime {
        match self {
            AgendaItem::Reminder(r) => r
                .entry
                .date
                .get(..10)
                .and_then(|d| d.parse::<NaiveDate>().ok())
                .map(|d| d.and_time(NaiveTime::default()))
                .unwrap_or_default(),
            AgendaItem::Appointments(group) => group.first().map(|a| a.start()).unwrap_or_default(),
        }
    }
}

/// One reminder to sound: what, when, whose.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct PlannedReminder {
    /// Stable per chore or appointment group, so one sounds once.
    pub id: String,
    pub at: NaiveDateTime,
    pub title: String,
    pub entity: String,
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::chores::{ChoreSchedule, Hhmm};
    use std::collections::BTreeMap;

    fn day(y: i32, m: u32, d: u32) -> NaiveDate {
        NaiveDate::from_ymd_opt(y, m, d).unwrap()
    }

    fn chore(title: &str, schedule: ChoreSchedule, start: NaiveDate) -> Chore {
        Chore {
            id: String::new(),
            entity: "cat:a".into(),
            title: title.into(),
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
    fn the_chores_agenda_sorts_today_upcoming_and_paused() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let today = day(2026, 3, 10);
        let mut feed = chore("Feed", ChoreSchedule::daily(), day(2026, 3, 1));
        feed.time = Some(Hhmm { hour: 8, minute: 0 });
        let feed = store.create_chore("c1", &feed).unwrap();
        let brush = store
            .create_chore(
                "c2",
                &chore("Brush", ChoreSchedule::weekdays(vec![3]), day(2026, 3, 1)),
            )
            .unwrap();
        let mut litter = chore("Litter", ChoreSchedule::daily(), day(2026, 3, 1));
        litter.paused = true;
        store.create_chore("c3", &litter).unwrap();
        let mut ended = chore("Old", ChoreSchedule::daily(), day(2026, 3, 1));
        ended.ended = true;
        store.create_chore("c4", &ended).unwrap();
        // 2026-03-10 is a Tuesday: Brush comes Wednesday.
        let agenda = store.chores_agenda(today).unwrap();
        assert_eq!(
            agenda
                .today
                .iter()
                .map(|c| c.title.as_str())
                .collect::<Vec<_>>(),
            vec!["Feed"]
        );
        assert_eq!(agenda.upcoming.len(), 1);
        assert_eq!(agenda.upcoming[0].0.title, "Brush");
        assert_eq!(agenda.upcoming[0].1, day(2026, 3, 11));
        assert_eq!(agenda.paused.len(), 1);
        assert_eq!(agenda.paused[0].title, "Litter");
        // Ticked today: still listed, the row shows it done.
        store.tick_chore(&feed, today, today).unwrap();
        assert_eq!(store.chores_agenda(today).unwrap().today.len(), 1);
        assert!(store.chores_agenda(today).unwrap().all_done_today(&store));
        // A timeless chore sorts before a timed one on the same day.
        store
            .create_chore(
                "c5",
                &chore("Water", ChoreSchedule::daily(), day(2026, 3, 1)),
            )
            .unwrap();
        store.untick_chore(&feed, today).unwrap();
        let agenda = store.chores_agenda(today).unwrap();
        assert_eq!(
            agenda
                .today
                .iter()
                .map(|c| c.title.as_str())
                .collect::<Vec<_>>(),
            vec!["Water", "Feed"]
        );
        let _ = brush;
    }

    #[test]
    fn reminders_are_planned_at_the_chore_time_and_before_appointments() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        store.create_cat("cat:b", "Tom", None, "cat").unwrap();
        let mut feed = chore("Feed", ChoreSchedule::daily(), day(2026, 3, 1));
        feed.remind = true;
        feed.remind_at = Some(Hhmm { hour: 8, minute: 0 });
        let feed = store.create_chore("c1", &feed).unwrap();
        let mut quiet = chore("Quiet", ChoreSchedule::daily(), day(2026, 3, 1));
        quiet.remind = true;
        store.create_chore("c2", &quiet).unwrap();
        let now = day(2026, 3, 10).and_hms_opt(7, 0, 0).unwrap();
        let planned = store.planned_reminders(now).unwrap();
        assert_eq!(planned.len(), 1, "a reminder without a time is silent");
        assert_eq!(
            planned[0].at,
            day(2026, 3, 10).and_hms_opt(8, 0, 0).unwrap()
        );
        assert_eq!(planned[0].title, "Feed");
        // Past the time: tomorrow.
        let later = day(2026, 3, 10).and_hms_opt(9, 0, 0).unwrap();
        let planned = store.planned_reminders(later).unwrap();
        assert_eq!(
            planned[0].at,
            day(2026, 3, 11).and_hms_opt(8, 0, 0).unwrap()
        );
        // Done today: tomorrow too.
        store
            .tick_chore(&feed, day(2026, 3, 10), day(2026, 3, 10))
            .unwrap();
        let planned = store.planned_reminders(now).unwrap();
        assert_eq!(
            planned[0].at,
            day(2026, 3, 11).and_hms_opt(8, 0, 0).unwrap()
        );
        // A vet run for two cats: one reminder an hour before.
        let draft = Appointment {
            id: String::new(),
            entity: String::new(),
            date: day(2026, 3, 12),
            time: Some(Hhmm {
                hour: 14,
                minute: 30,
            }),
            title: "Neutering".into(),
            notes: String::new(),
            linked_field: None,
            linked_value: None,
            alert: AppointmentAlert::HourBefore,
            done: false,
            group: None,
            extra: BTreeMap::new(),
        };
        store
            .create_appointments(&draft, &[("cat:a", "a1"), ("cat:b", "a2")], "g1")
            .unwrap();
        let none = Appointment {
            alert: AppointmentAlert::None,
            date: day(2026, 3, 13),
            entity: "cat:a".into(),
            ..draft.clone()
        };
        store.create_appointment("a3", &none).unwrap();
        let day_before = Appointment {
            alert: AppointmentAlert::DayBefore,
            date: day(2026, 3, 14),
            time: None,
            entity: "cat:a".into(),
            ..draft.clone()
        };
        store.create_appointment("a4", &day_before).unwrap();
        let planned = store.planned_reminders(now).unwrap();
        let ids: Vec<&str> = planned.iter().map(|p| p.id.as_str()).collect();
        assert_eq!(ids, vec!["chore:c1", "appt:g1", "appt:a4"]);
        assert_eq!(
            planned[1].at,
            day(2026, 3, 12).and_hms_opt(13, 30, 0).unwrap()
        );
        assert_eq!(
            planned[2].at,
            day(2026, 3, 13).and_hms_opt(0, 0, 0).unwrap()
        );
        // The agenda lists the run once, in date order with a plan.
        store
            .append_at(
                "cat:a",
                "f:vaccine",
                Some("planned"),
                Some("2026-03-11T10:00:00Z"),
                true,
            )
            .unwrap();
        let items = store.agenda_items().unwrap();
        assert_eq!(items.len(), 4);
        assert!(matches!(&items[0], AgendaItem::Reminder(r) if r.field == "f:vaccine"));
        assert!(matches!(&items[1], AgendaItem::Appointments(g) if g.len() == 2));
        assert!(items.windows(2).all(|w| w[0].when() <= w[1].when()));
    }
}
