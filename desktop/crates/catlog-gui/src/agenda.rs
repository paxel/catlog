//! The Agenda page: chores due today and coming up, paused ones in
//! sight, and everything planned in date order with the plans and the
//! appointments as cards.

use catlog_core::Catalog;
use catlog_core::agenda::AgendaItem;
use catlog_core::appointments::Appointment;
use catlog_core::ics::IcsEvent;
use catlog_core::keys;
use chrono::NaiveDate;
use egui::Ui;

use crate::chores::{ChoreAction, chore_row};
use crate::l10n::L10n;
use crate::labels::{clock, field_label, format_day};

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

/// One appointment or run as a card with its buttons and menu.
pub fn appointment_card(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    group: &[Appointment],
    with_names: bool,
) -> Option<AppointmentAction> {
    let mut action = None;
    let a = &group[0];
    ui.horizontal(|ui| {
        let label = ui.label(appointment_words(t, group));
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
        if ui.button(t.finish_label()).clicked() {
            action = Some(AppointmentAction::Finish(a.clone()));
        }
    });
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
        ui.label(egui::RichText::new(names.join(", ")).weak());
    }
    if !a.notes.is_empty() {
        ui.label(egui::RichText::new(&a.notes).weak());
    }
    action
}

/// The page.
pub fn show_agenda(ui: &mut Ui, store: &Catalog, t: &L10n, today: NaiveDate) -> AgendaAction {
    let mut action = AgendaAction::None;
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
        let chores = store.chores_agenda(today).unwrap_or_default();
        if !chores.today.is_empty() {
            ui.add_space(8.0);
            let today_heading = ui.strong(if chores.all_done_today(store) {
                t.all_done_today()
            } else {
                t.today_section()
            });
            crate::tips::anchor(ui, "agenda-today", &today_heading);
            for c in &chores.today {
                let a = chore_row(ui, store, t, c, today);
                if a != ChoreAction::None {
                    action = AgendaAction::Chore(a);
                }
            }
        }
        if !chores.upcoming.is_empty() {
            ui.add_space(8.0);
            ui.strong(t.upcoming_section());
            for (c, _day) in &chores.upcoming {
                let a = chore_row(ui, store, t, c, today);
                if a != ChoreAction::None {
                    action = AgendaAction::Chore(a);
                }
            }
        }
        if !chores.paused.is_empty() {
            ui.add_space(8.0);
            ui.strong(t.chore_paused());
            for c in &chores.paused {
                let a = chore_row(ui, store, t, c, today);
                if a != ChoreAction::None {
                    action = AgendaAction::Chore(a);
                }
            }
        }
        ui.add_space(8.0);
        ui.strong(t.planned_section());
        let items = store.agenda_items().unwrap_or_default();
        if items.is_empty() && chores.today.is_empty() && chores.upcoming.is_empty() {
            ui.label(t.agenda_empty());
        }
        for item in &items {
            match item {
                AgendaItem::Reminder(r) => {
                    let name = store
                        .current(&r.entity, keys::NAME)
                        .ok()
                        .flatten()
                        .unwrap_or_else(|| t.unnamed().to_string());
                    ui.horizontal(|ui| {
                        ui.label(format!(
                            "{} · {}: {}",
                            format_day(t.locale(), item.when().date()),
                            field_label(t, store, &r.field),
                            r.value
                        ));
                        if ui.link(&name).clicked() {
                            action = AgendaAction::OpenEntity(r.entity.clone());
                        }
                    });
                }
                AgendaItem::Appointments(group) => {
                    if let Some(a) = appointment_card(ui, store, t, group, true) {
                        action = AgendaAction::Appointment(a);
                    }
                }
            }
        }
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
