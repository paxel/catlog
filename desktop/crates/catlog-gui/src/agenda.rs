//! The Agenda page: chores due today and coming up, paused ones in
//! sight, and everything planned in date order with the plans and the
//! appointments as cards.

use catlog_core::Catalog;
use catlog_core::agenda::{AgendaItem, ChoresAgenda};
use catlog_core::appointments::Appointment;
use catlog_core::ics::IcsEvent;
use catlog_core::keys;
use chrono::NaiveDate;
use egui::Ui;

use crate::chores::{ChoreAction, chore_row};
use crate::l10n::L10n;
use crate::labels::{clock, field_label, format_day};
use crate::memo::Memo;
use crate::sections::{PlanRow, plan_row, section_card, section_card_tipped};
use crate::textures::FaceCache;

/// What the keeper did on the Agenda page this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AgendaAction {
    None,
    Chore(ChoreAction),
    Appointment(AppointmentAction),
    NewAppointment,
    ExportIcs,
    OpenEntity(String),
}

/// What the keeper did on an appointment card.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AppointmentAction {
    Finish(Appointment),
    Edit(Appointment),
    /// Delete the appointment, or the whole run when `bool` is true.
    Delete(Appointment, bool),
}

/// The words of an appointment: day, time, what, and for a run the
/// count.
pub fn appointment_words(t: &L10n, group: &[Appointment]) -> String {
    let a = &group[0];
    let mut when = format_day(t.locale(), a.date);
    if let Some(time) = a.time {
        when.push(' ');
        when.push_str(&clock(time));
    }
    if group.len() > 1 {
        format!(
            "{when} · {} · {}",
            a.title,
            t.cats_count(group.len() as i64)
        )
    } else {
        format!("{when} · {}", a.title)
    }
}

/// One appointment or run as a two-line row: when and what, then whose
/// with the face and the notes; Finish on the right, edit and delete
/// behind a right-click.
pub fn appointment_card(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    faces: &mut FaceCache,
    group: &[Appointment],
    with_names: bool,
) -> Option<AppointmentAction> {
    let mut action = None;
    let a = &group[0];
    let face = store
        .profile_image(&a.entity)
        .ok()
        .flatten()
        .and_then(|hash| faces.face(ui.ctx(), store, &hash));
    let mut line2 = Vec::new();
    if with_names {
        let names: Vec<String> = group
            .iter()
            .map(|m| {
                store
                    .current(&m.entity, keys::NAME)
                    .ok()
                    .flatten()
                    .unwrap_or_else(|| t.unnamed().to_string())
            })
            .collect();
        line2.push(names.join(", "));
    }
    if !a.notes.is_empty() {
        line2.push(a.notes.clone());
    }
    let line1 = appointment_words(t, group);
    let mut finish = false;
    let label = plan_row(
        ui,
        PlanRow {
            face,
            line1: &line1,
            line2: line2.join(" · "),
        },
        |_ui| {},
        |ui| {
            if ui.button(t.finish_label()).clicked() {
                finish = true;
            }
        },
    );
    label.context_menu(|ui| {
        if ui.button(t.edit_label_appointment()).clicked() {
            action = Some(AppointmentAction::Edit(a.clone()));
            ui.close();
        }
        let delete = if group.len() > 1 {
            t.delete_appointment_group(group.len() as i64)
        } else {
            t.delete_appointment().to_string()
        };
        if ui.button(delete).clicked() {
            action = Some(AppointmentAction::Delete(a.clone(), group.len() > 1));
            ui.close();
        }
    });
    if finish {
        action = Some(AppointmentAction::Finish(a.clone()));
    }
    action
}

/// One reminder as a two-line row: the day and the value, then whose
/// with the face; Open on the right.
fn reminder_row(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    faces: &mut FaceCache,
    r: &catlog_core::entities::ActiveReminder,
    when: NaiveDate,
) -> bool {
    let name = store
        .current(&r.entity, keys::NAME)
        .ok()
        .flatten()
        .unwrap_or_else(|| t.unnamed().to_string());
    let face = store
        .profile_image(&r.entity)
        .ok()
        .flatten()
        .and_then(|hash| faces.face(ui.ctx(), store, &hash));
    let line1 = format!(
        "{} · {}: {}",
        format_day(t.locale(), when),
        field_label(t, store, &r.field),
        r.value
    );
    let mut open = false;
    plan_row(
        ui,
        PlanRow {
            face,
            line1: &line1,
            line2: name.clone(),
        },
        |_ui| {},
        |ui| {
            if ui.link(t.open()).clicked() {
                open = true;
            }
        },
    );
    open
}

/// What the page shows, as built for one write of the store.
#[derive(Debug, Clone, Default)]
pub struct AgendaData {
    pub chores: ChoresAgenda,
    pub all_done_today: bool,
    pub items: Vec<AgendaItem>,
}

/// The page's data between frames.
pub type AgendaMemo = Memo<NaiveDate, AgendaData>;

/// The page: the sections as cards, the plans as two-line rows.
pub fn show_agenda(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    faces: &mut FaceCache,
    memo: &mut AgendaMemo,
    today: NaiveDate,
) -> AgendaAction {
    let mut action = AgendaAction::None;
    let data = memo.get(store, today, || {
        let chores = store.chores_agenda(today).unwrap_or_default();
        AgendaData {
            all_done_today: chores.all_done_today(store),
            items: store.agenda_items().unwrap_or_default(),
            chores,
        }
    });
    egui::ScrollArea::vertical().show(ui, |ui| {
        ui.horizontal(|ui| {
            let add = ui.button(t.add_appointment());
            crate::tips::anchor(ui, "agenda-add", &add);
            if add.clicked() {
                action = AgendaAction::NewAppointment;
            }
            if ui.button(t.export_ics()).clicked() {
                action = AgendaAction::ExportIcs;
            }
        });
        let chores = &data.chores;
        if !chores.today.is_empty() {
            ui.add_space(8.0);
            let heading = if data.all_done_today {
                t.all_done_today()
            } else {
                t.today_section()
            };
            section_card_tipped(ui, heading, Some("agenda-today"), |ui| {
                for c in &chores.today {
                    let a = chore_row(ui, store, t, faces, c, today);
                    if a != ChoreAction::None {
                        action = AgendaAction::Chore(a);
                    }
                }
            });
        }
        if !chores.upcoming.is_empty() {
            ui.add_space(8.0);
            section_card(ui, t.upcoming_section(), |ui| {
                for (c, _day) in &chores.upcoming {
                    let a = chore_row(ui, store, t, faces, c, today);
                    if a != ChoreAction::None {
                        action = AgendaAction::Chore(a);
                    }
                }
            });
        }
        if !chores.paused.is_empty() {
            ui.add_space(8.0);
            section_card(ui, t.chore_paused(), |ui| {
                for c in &chores.paused {
                    let a = chore_row(ui, store, t, faces, c, today);
                    if a != ChoreAction::None {
                        action = AgendaAction::Chore(a);
                    }
                }
            });
        }
        ui.add_space(8.0);
        let items = &data.items;
        section_card(ui, t.planned_section(), |ui| {
            if items.is_empty() && chores.today.is_empty() && chores.upcoming.is_empty() {
                ui.label(t.agenda_empty());
            }
            for item in items {
                match item {
                    AgendaItem::Reminder(r) => {
                        if reminder_row(ui, store, t, faces, r, item.when().date()) {
                            action = AgendaAction::OpenEntity(r.entity.clone());
                        }
                    }
                    AgendaItem::Appointments(group) => {
                        if let Some(a) = appointment_card(ui, store, t, faces, group, true) {
                            action = AgendaAction::Appointment(a);
                        }
                    }
                }
            }
        });
    });
    action
}

/// The calendar file's events: reminders all-day, appointments timed
/// with their alarm, a Vet Run as one event; the same as the phone's.
pub fn ics_events(store: &Catalog, t: &L10n) -> Vec<IcsEvent> {
    let name_of = |entity: &str| {
        store
            .current(entity, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string())
    };
    let mut events = Vec::new();
    for item in store.agenda_items().unwrap_or_default() {
        match &item {
            AgendaItem::Reminder(r) => {
                let key = format!("{}|{}", r.entity, r.field);
                events.push(IcsEvent {
                    uid: format!("catlog-{}@catlog", key.replace([':', '|'], "-")),
                    start: item.when(),
                    end: None,
                    summary: format!(
                        "{} — {}",
                        name_of(&r.entity),
                        field_label(t, store, &r.field)
                    ),
                    description: format!("{}\ncat(a)log", r.value),
                    alert_minutes_before: None,
                });
            }
            AgendaItem::Appointments(group) => {
                let a = &group[0];
                let names: Vec<String> = group.iter().map(|m| name_of(&m.entity)).collect();
                let names = names.join(", ");
                let start = a.start();
                let key = format!("appt|{}", a.group.clone().unwrap_or_else(|| a.id.clone()));
                let (summary, description) = if group.len() == 1 {
                    (
                        format!("{names} — {}", a.title),
                        format!("{}\ncat(a)log", a.notes).trim().to_string(),
                    )
                } else {
                    (
                        format!("{} — {}", a.title, t.cats_count(group.len() as i64)),
                        format!("{names}\n{}\ncat(a)log", a.notes)
                            .trim()
                            .to_string(),
                    )
                };
                events.push(IcsEvent {
                    uid: format!("catlog-{}@catlog", key.replace([':', '|'], "-")),
                    start,
                    end: (!a.all_day()).then(|| start + chrono::Duration::hours(1)),
                    summary,
                    description,
                    alert_minutes_before: match a.alert {
                        catlog_core::appointments::AppointmentAlert::None => None,
                        catlog_core::appointments::AppointmentAlert::DayBefore => Some(24 * 60),
                        catlog_core::appointments::AppointmentAlert::HourBefore => Some(60),
                    },
                });
            }
        }
    }
    events
}
