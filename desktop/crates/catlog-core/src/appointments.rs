//! Appointments: a timed visit on a cat or clowder, what the keeper
//! leaves the vet's desk with. Stored as one `$appt:<id>` entry per
//! appointment; edits, finishing and deletion are later entries on the
//! same key. A Vet Run is several appointments sharing a group id.

use std::collections::{BTreeMap, HashMap, HashSet};

use chrono::{NaiveDate, NaiveDateTime, NaiveTime};
use serde::{Deserialize, Serialize};
use serde_json::Value;

use crate::Result;
use crate::catalog::Catalog;
use crate::chores::{Hhmm, day_key, parse_day};
use crate::keys;

/// When the calendar should ping for an appointment.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum AppointmentAlert {
    None,
    DayBefore,
    HourBefore,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Appointment {
    pub id: String,
    pub entity: String,
    /// The day; with `time` the exact moment, else all day.
    pub date: NaiveDate,
    pub time: Option<Hhmm>,
    pub title: String,
    pub notes: String,
    /// A field whose value is written when the appointment is done.
    pub linked_field: Option<String>,
    pub linked_value: Option<String>,
    pub alert: AppointmentAlert,
    pub done: bool,
    /// Shared by the appointments of one vet run with several cats.
    pub group: Option<String>,
    /// Keys this version does not know, carried through unchanged.
    pub extra: BTreeMap<String, Value>,
}

const KNOWN: [&str; 9] = [
    "date", "time", "title", "notes", "field", "value", "alert", "done", "group",
];

impl Appointment {
    pub fn key(&self) -> String {
        format!("{}{}", keys::APPOINTMENT_PREFIX, self.id)
    }

    pub fn all_day(&self) -> bool {
        self.time.is_none()
    }

    /// The moment it starts; midnight for all-day ones.
    pub fn start(&self) -> NaiveDateTime {
        let t = self
            .time
            .and_then(|t| NaiveTime::from_hms_opt(t.hour, t.minute, 0))
            .unwrap_or_default();
        self.date.and_time(t)
    }

    pub fn to_json(&self) -> Value {
        let mut m = serde_json::Map::new();
        for (k, v) in &self.extra {
            m.insert(k.clone(), v.clone());
        }
        m.insert("date".into(), Value::from(day_key(self.date)));
        if let Some(t) = self.time {
            m.insert("time".into(), Value::from(t.text()));
        }
        m.insert("title".into(), Value::from(self.title.clone()));
        if !self.notes.is_empty() {
            m.insert("notes".into(), Value::from(self.notes.clone()));
        }
        if let Some(f) = &self.linked_field {
            m.insert("field".into(), Value::from(f.clone()));
        }
        if let Some(v) = &self.linked_value {
            m.insert("value".into(), Value::from(v.clone()));
        }
        m.insert(
            "alert".into(),
            serde_json::to_value(self.alert).unwrap_or(Value::Null),
        );
        if self.done {
            m.insert("done".into(), Value::Bool(true));
        }
        if let Some(g) = &self.group {
            m.insert("group".into(), Value::from(g.clone()));
        }
        Value::Object(m)
    }

    /// Parses a stored value; none when it is not an appointment document.
    pub fn from_json(id: &str, entity: &str, raw: Option<&str>) -> Option<Appointment> {
        let json: Value = serde_json::from_str(raw?).ok()?;
        let obj = json.as_object()?;
        let text = |k: &str| obj.get(k).and_then(Value::as_str);
        let date = parse_day(text("date"))?;
        Some(Appointment {
            id: id.to_string(),
            entity: entity.to_string(),
            date,
            time: text("time").and_then(Hhmm::parse),
            title: text("title").unwrap_or_default().to_string(),
            notes: text("notes").unwrap_or_default().to_string(),
            linked_field: text("field").map(String::from),
            linked_value: text("value").map(String::from),
            alert: obj
                .get("alert")
                .and_then(|a| serde_json::from_value(a.clone()).ok())
                .unwrap_or(AppointmentAlert::DayBefore),
            done: obj.get("done") == Some(&Value::Bool(true)),
            group: text("group").map(String::from),
            extra: obj
                .iter()
                .filter(|(k, _)| !KNOWN.contains(&k.as_str()))
                .map(|(k, v)| (k.clone(), v.clone()))
                .collect(),
        })
    }
}

impl Catalog {
    /// Records a new appointment under `id` and returns it.
    pub fn create_appointment(&mut self, id: &str, draft: &Appointment) -> Result<Appointment> {
        let made = Appointment {
            id: id.to_string(),
            ..draft.clone()
        };
        self.append(&made.entity, &made.key(), Some(&made.to_json().to_string()))?;
        Ok(made)
    }

    /// One vet run, several cats: the draft becomes one appointment per
    /// entity under the given ids, all sharing `group` when there is
    /// more than one entity.
    pub fn create_appointments(
        &mut self,
        draft: &Appointment,
        members: &[(&str, &str)],
        group: &str,
    ) -> Result<Vec<Appointment>> {
        let group = (members.len() > 1).then(|| group.to_string());
        let mut out = Vec::new();
        for (entity, id) in members {
            let a = Appointment {
                entity: entity.to_string(),
                done: false,
                group: group.clone(),
                ..draft.clone()
            };
            out.push(self.create_appointment(id, &a)?);
        }
        Ok(out)
    }

    /// The open members of `a`'s group, `a` included, one per entity.
    pub fn group_of(&self, a: &Appointment) -> Result<Vec<Appointment>> {
        let Some(group) = &a.group else {
            return Ok(vec![a.clone()]);
        };
        let mut seen = HashSet::new();
        Ok(self
            .open_appointments()?
            .into_iter()
            .filter(|m| m.group.as_deref() == Some(group) && seen.insert(m.entity.clone()))
            .collect())
    }

    /// Writes `a`'s date, time, title, notes, link and alert onto every
    /// member of its group: the whole vet run moves, never one cat.
    pub fn update_appointment_group(&mut self, a: &Appointment) -> Result<()> {
        for m in self.group_of(a)? {
            let moved = Appointment {
                date: a.date,
                time: a.time,
                title: a.title.clone(),
                notes: a.notes.clone(),
                linked_field: a.linked_field.clone(),
                linked_value: a.linked_value.clone(),
                alert: a.alert,
                ..m
            };
            self.update_appointment(&moved)?;
        }
        Ok(())
    }

    /// Adds entities to an existing group under the given ids. A lone
    /// appointment becomes a group of itself plus the newcomers.
    pub fn add_to_appointment_group(
        &mut self,
        a: &Appointment,
        members: &[(&str, &str)],
        new_group: &str,
    ) -> Result<Vec<Appointment>> {
        let group = match &a.group {
            Some(g) => g.clone(),
            None => {
                let grouped = Appointment {
                    group: Some(new_group.to_string()),
                    ..a.clone()
                };
                self.update_appointment(&grouped)?;
                new_group.to_string()
            }
        };
        let mut out = Vec::new();
        for (entity, id) in members {
            let m = Appointment {
                entity: entity.to_string(),
                done: false,
                notes: a.notes.clone(),
                group: Some(group.clone()),
                ..a.clone()
            };
            out.push(self.create_appointment(id, &m)?);
        }
        Ok(out)
    }

    /// Finishes the given members with shared outcome notes.
    pub fn finish_appointments(
        &mut self,
        members: &[Appointment],
        notes: Option<&str>,
    ) -> Result<()> {
        for m in members {
            self.finish_appointment(m, notes)?;
        }
        Ok(())
    }

    /// Deletes every open member of `a`'s group.
    pub fn delete_appointment_group(&mut self, a: &Appointment) -> Result<()> {
        for m in self.group_of(a)? {
            self.delete_appointment(&m)?;
        }
        Ok(())
    }

    /// Every open appointment folded by group, earliest first.
    pub fn open_appointment_groups(&self) -> Result<Vec<Vec<Appointment>>> {
        let mut groups: Vec<(String, Vec<Appointment>)> = Vec::new();
        let mut seen: HashMap<String, HashSet<String>> = HashMap::new();
        for a in self.open_appointments()? {
            let key = a.group.clone().unwrap_or_else(|| a.id.clone());
            if !seen
                .entry(key.clone())
                .or_default()
                .insert(a.entity.clone())
            {
                continue;
            }
            match groups.iter_mut().find(|(k, _)| *k == key) {
                Some((_, list)) => list.push(a),
                None => groups.push((key, vec![a])),
            }
        }
        let mut result: Vec<Vec<Appointment>> = groups.into_iter().map(|(_, l)| l).collect();
        result.sort_by_key(|g| g[0].start());
        Ok(result)
    }

    /// Writes the appointment's current state as a new entry.
    pub fn update_appointment(&mut self, a: &Appointment) -> Result<()> {
        self.append(&a.entity, &a.key(), Some(&a.to_json().to_string()))
    }

    /// Finishes an appointment: notes may carry the outcome; a linked
    /// field receives its value.
    pub fn finish_appointment(&mut self, a: &Appointment, notes: Option<&str>) -> Result<()> {
        let closed = Appointment {
            notes: notes.map(String::from).unwrap_or_else(|| a.notes.clone()),
            done: true,
            ..a.clone()
        };
        self.update_appointment(&closed)?;
        if let Some(field) = &closed.linked_field {
            self.append(&closed.entity, field, closed.linked_value.as_deref())?;
        }
        Ok(())
    }

    /// Deletes an appointment: a cleared value, like any field.
    pub fn delete_appointment(&mut self, a: &Appointment) -> Result<()> {
        self.append(&a.entity, &a.key(), None)
    }

    /// The appointments of one entity, open ones unless `include_done`.
    pub fn appointments_of(&self, entity: &str, include_done: bool) -> Result<Vec<Appointment>> {
        let canonical = self.resolve_entity(entity)?;
        let mut result = Vec::new();
        for (key, value) in self.current_fields(&canonical)? {
            let Some(id) = key.strip_prefix(keys::APPOINTMENT_PREFIX) else {
                continue;
            };
            let Some(a) = Appointment::from_json(id, &canonical, value.as_deref()) else {
                continue;
            };
            if a.done && !include_done {
                continue;
            }
            result.push(a);
        }
        result.sort_by_key(|a| a.start());
        Ok(result)
    }

    /// Every open appointment in the Catalog, earliest first.
    pub fn open_appointments(&self) -> Result<Vec<Appointment>> {
        let mut result = Vec::new();
        for e in self.cats(None)?.into_iter().chain(self.clowders()?) {
            result.extend(self.appointments_of(&e.id, false)?);
        }
        result.sort_by_key(|a| a.start());
        Ok(result)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn d(y: i32, m: u32, day: u32) -> NaiveDate {
        NaiveDate::from_ymd_opt(y, m, day).unwrap()
    }

    fn draft(entity: &str) -> Appointment {
        Appointment {
            id: String::new(),
            entity: entity.into(),
            date: d(2026, 3, 10),
            time: Some(Hhmm {
                hour: 9,
                minute: 30,
            }),
            title: "Shots".into(),
            notes: String::new(),
            linked_field: Some("f:neutered".into()),
            linked_value: Some("yes".into()),
            alert: AppointmentAlert::DayBefore,
            done: false,
            group: None,
            extra: BTreeMap::new(),
        }
    }

    #[test]
    fn an_appointment_document_round_trips_and_keeps_unknown_keys() {
        let a = draft("cat:a");
        let json = a.to_json().to_string();
        assert_eq!(
            json,
            r#"{"alert":"dayBefore","date":"2026-03-10","field":"f:neutered","time":"09:30","title":"Shots","value":"yes"}"#
        );
        let back = Appointment::from_json("x", "cat:a", Some(&json)).unwrap();
        assert_eq!(
            Appointment {
                id: "x".into(),
                ..a.clone()
            },
            back
        );
        assert!(!back.all_day());
        assert_eq!(back.start().to_string(), "2026-03-10 09:30:00");
        let odd = Appointment::from_json(
            "y",
            "cat:a",
            Some(r#"{"date":"2026-01-01","title":"t","alert":"whenever","later":1}"#),
        )
        .unwrap();
        assert_eq!(odd.alert, AppointmentAlert::DayBefore);
        assert!(odd.all_day());
        assert_eq!(odd.to_json()["later"], 1);
        assert!(Appointment::from_json("z", "cat:a", Some(r#"{"title":"no date"}"#)).is_none());
        assert!(Appointment::from_json("z", "cat:a", None).is_none());
        assert_eq!(odd.key(), "$appt:y");
    }

    #[test]
    fn vet_runs_fan_out_move_together_and_finish_with_a_value() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        c.create_cat("cat:b", "Tom", None, "cat").unwrap();
        c.create_clowder("clowder:h", "Home").unwrap();
        let run = c
            .create_appointments(&draft("cat:a"), &[("cat:a", "a1"), ("cat:b", "a2")], "g1")
            .unwrap();
        assert_eq!(run.len(), 2);
        assert_eq!(run[0].group.as_deref(), Some("g1"));
        let alone = c
            .create_appointments(&draft("clowder:h"), &[("clowder:h", "a3")], "unused")
            .unwrap();
        assert!(alone[0].group.is_none());
        assert_eq!(c.open_appointments().unwrap().len(), 3);
        assert_eq!(c.open_appointment_groups().unwrap().len(), 2);
        assert_eq!(c.group_of(&run[0]).unwrap().len(), 2);
        assert_eq!(c.group_of(&alone[0]).unwrap().len(), 1);
        // The whole run moves.
        let moved = Appointment {
            date: d(2026, 3, 12),
            title: "Shots, moved".into(),
            ..run[0].clone()
        };
        c.update_appointment_group(&moved).unwrap();
        for m in c.group_of(&run[0]).unwrap() {
            assert_eq!((m.date, m.title.as_str()), (d(2026, 3, 12), "Shots, moved"));
        }
        // A lone appointment becomes a group with the newcomers.
        let added = c
            .add_to_appointment_group(&alone[0], &[("cat:b", "a4")], "g2")
            .unwrap();
        assert_eq!(added[0].group.as_deref(), Some("g2"));
        assert_eq!(c.group_of(&added[0]).unwrap().len(), 2);
        let more = c
            .add_to_appointment_group(&added[0], &[("cat:a", "a5")], "ignored")
            .unwrap();
        assert_eq!(more[0].group.as_deref(), Some("g2"));
        // Finishing writes the linked value; a cat leaves by deleting its own.
        let current = c.group_of(&run[0]).unwrap();
        c.finish_appointments(&current[..1], Some("all good"))
            .unwrap();
        assert_eq!(
            c.current("cat:a", "f:neutered").unwrap().as_deref(),
            Some("yes")
        );
        let done = c.appointments_of("cat:a", true).unwrap();
        assert!(done.iter().any(|a| a.done && a.notes == "all good"));
        assert_eq!(
            c.appointments_of("cat:a", false).unwrap().len(),
            1,
            "a5 stays open"
        );
        c.delete_appointment(&current[1]).unwrap();
        assert!(c.group_of(&run[0]).unwrap().is_empty());
        c.delete_appointment_group(&added[0]).unwrap();
        assert!(c.open_appointments().unwrap().is_empty());
    }
}
