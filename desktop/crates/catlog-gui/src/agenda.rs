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
            deceased: crate::textures::is_deceased(store, &a.entity),
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
            deceased: crate::textures::is_deceased(store, &r.entity),
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
    let mut view = AgendaView::of(store);
    egui::ScrollArea::vertical().show(ui, |ui| {
        // A column, not a wall: on a wide screen the agenda would
        // otherwise run a metre across and be unreadable.
        let width = ui.available_width().min(CONTENT_WIDTH);
        let margin = ((ui.available_width() - width) / 2.0).max(0.0);
        ui.horizontal(|ui| {
            ui.add_space(margin);
            ui.vertical(|ui| {
                ui.set_max_width(width);
                ui.set_min_width(width);
                ui.horizontal(|ui| {
                    let add = ui.button(t.add_appointment());
                    crate::tips::anchor(ui, "agenda-add", &add);
                    if add.clicked() {
                        action = AgendaAction::NewAppointment;
                    }
                    if ui.button(t.export_ics()).clicked() {
                        action = AgendaAction::ExportIcs;
                    }
                    ui.separator();
                    // The same plans, laid out three ways.
                    for one in AgendaView::ALL {
                        if ui.selectable_label(view == one, one.words(t)).clicked() {
                            view = one;
                            let _ = store.set_local_setting(AGENDA_VIEW_KEY, one.stored());
                        }
                    }
                });
                if view != AgendaView::List {
                    let anchor = anchor_day(store, today);
                    ui.horizontal(|ui| {
                        // Back and forth a week or a month, and home to today.
                        let step = if view == AgendaView::Week { 7 } else { 0 };
                        if crate::icons::icon_button(
                            ui,
                            crate::icons::CHEVRON_LEFT,
                            t.month_before(),
                        )
                        .clicked()
                        {
                            set_anchor(store, back(anchor, step));
                        }
                        if ui.button(t.today()).clicked() {
                            let _ = store.remove_local_setting(ANCHOR_KEY);
                        }
                        if crate::icons::icon_button(
                            ui,
                            crate::icons::CHEVRON_RIGHT,
                            t.month_after(),
                        )
                        .clicked()
                        {
                            set_anchor(store, forward(anchor, step));
                        }
                    });
                    if let Some(entity) =
                        calendar(ui, store, t, &data.items, &data.chores, anchor, today, view)
                    {
                        action = AgendaAction::OpenEntity(entity);
                    }
                    return;
                }
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
                                if let Some(a) = appointment_card(ui, store, t, faces, group, true)
                                {
                                    action = AgendaAction::Appointment(a);
                                }
                            }
                        }
                    }
                });
            });
        });
    });
    action
}

/// How wide the agenda's column may grow, whatever the window does.
const CONTENT_WIDTH: f32 = 900.0;
const AGENDA_VIEW_KEY: &str = "agendaView";

/// The three ways to look at the same plans.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AgendaView {
    List,
    Week,
    Month,
}

impl AgendaView {
    const ALL: [AgendaView; 3] = [AgendaView::List, AgendaView::Week, AgendaView::Month];

    fn stored(self) -> &'static str {
        match self {
            AgendaView::List => "list",
            AgendaView::Week => "week",
            AgendaView::Month => "month",
        }
    }

    fn of(store: &Catalog) -> AgendaView {
        match store.local_setting(AGENDA_VIEW_KEY).as_deref() {
            Some("week") => AgendaView::Week,
            Some("month") => AgendaView::Month,
            _ => AgendaView::List,
        }
    }

    fn words(self, t: &L10n) -> &'static str {
        match self {
            AgendaView::List => t.agenda_list(),
            AgendaView::Week => t.agenda_week(),
            AgendaView::Month => t.agenda_month(),
        }
    }
}

/// The plans laid out by day: seven days in a row for a week, the whole
/// month in rows of seven. The same items the list shows, so the views
/// cannot disagree.
#[allow(clippy::too_many_arguments)]
fn calendar(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    items: &[AgendaItem],
    chores: &ChoresAgenda,
    anchor: NaiveDate,
    today: NaiveDate,
    view: AgendaView,
) -> Option<String> {
    let mut opened = None;
    let (first, days) = calendar_span(anchor, view);
    let cell = ((ui.available_width() - 24.0) / 7.0).max(80.0);
    egui::Grid::new(("agenda-calendar", view.stored()))
        .num_columns(7)
        .spacing([4.0, 4.0])
        .show(ui, |ui| {
            for step in 0..days {
                let day = first + chrono::Duration::days(step);
                ui.allocate_ui_with_layout(
                    egui::vec2(cell, 0.0),
                    egui::Layout::top_down(egui::Align::LEFT),
                    |ui| {
                        ui.set_min_width(cell);
                        ui.set_min_height(72.0);
                        let heading = format_day(t.locale(), day);
                        let heading = if day == today {
                            egui::RichText::new(heading).strong()
                        } else {
                            egui::RichText::new(heading).weak()
                        };
                        ui.label(heading);
                        for (entity, words) in day_entries(store, t, items, chores, day) {
                            if ui
                                .add(
                                    egui::Button::new(egui::RichText::new(words).small())
                                        .frame(false)
                                        .wrap_mode(egui::TextWrapMode::Wrap),
                                )
                                .clicked()
                            {
                                opened = Some(entity);
                            }
                        }
                    },
                );
                if (step + 1) % 7 == 0 {
                    ui.end_row();
                }
            }
        });
    opened
}

const ANCHOR_KEY: &str = "agendaAnchor";

/// The day the calendar is built around: today, until the keeper walks
/// to another week or month.
fn anchor_day(store: &Catalog, today: NaiveDate) -> NaiveDate {
    store
        .local_setting(ANCHOR_KEY)
        .and_then(|raw| raw.parse::<NaiveDate>().ok())
        .unwrap_or(today)
}

fn set_anchor(store: &Catalog, day: NaiveDate) {
    let _ = store.set_local_setting(ANCHOR_KEY, &day.to_string());
}

/// A week back, or a month when `days` is zero.
fn back(day: NaiveDate, days: i64) -> NaiveDate {
    if days > 0 {
        day - chrono::Duration::days(days)
    } else {
        day.checked_sub_months(chrono::Months::new(1))
            .unwrap_or(day)
    }
}

fn forward(day: NaiveDate, days: i64) -> NaiveDate {
    if days > 0 {
        day + chrono::Duration::days(days)
    } else {
        day.checked_add_months(chrono::Months::new(1))
            .unwrap_or(day)
    }
}

/// The first cell and how many cells a view holds: a week from its
/// Monday, a month from the Monday before its first, so a month that
/// starts mid-week keeps its days under the right columns.
fn calendar_span(anchor: NaiveDate, view: AgendaView) -> (NaiveDate, i64) {
    use chrono::Datelike;
    match view {
        AgendaView::Week => (
            anchor - chrono::Duration::days(anchor.weekday().num_days_from_monday() as i64),
            7,
        ),
        _ => {
            let first = NaiveDate::from_ymd_opt(anchor.year(), anchor.month(), 1).unwrap_or(anchor);
            let lead = first.weekday().num_days_from_monday() as i64;
            let length = first
                .checked_add_months(chrono::Months::new(1))
                .map(|next| next.signed_duration_since(first).num_days())
                .unwrap_or(30);
            (first - chrono::Duration::days(lead), lead + length)
        }
    }
}

/// What stands on one day: the reminders and appointments the list
/// shows, and the chores due that day, each with the Cat or Clowder it
/// belongs to.
fn day_entries(
    store: &Catalog,
    t: &L10n,
    items: &[AgendaItem],
    chores: &ChoresAgenda,
    day: NaiveDate,
) -> Vec<(String, String)> {
    let mut out = Vec::new();
    for item in items {
        if item.when().date() != day {
            continue;
        }
        match item {
            AgendaItem::Reminder(r) => out.push((
                r.entity.clone(),
                format!(
                    "{} · {}",
                    name_of(store, t, &r.entity),
                    field_label(t, store, &r.field)
                ),
            )),
            AgendaItem::Appointments(group) => {
                let a = &group[0];
                let words = if group.len() > 1 {
                    format!("{} · {}", a.title, group.len())
                } else {
                    format!("{} · {}", name_of(store, t, &a.entity), a.title)
                };
                out.push((a.entity.clone(), words));
            }
        }
    }
    for (chore, on) in chores.upcoming.iter().map(|(c, on)| (c, *on)) {
        if on == day {
            out.push((
                chore.entity.clone(),
                format!("{} · {}", name_of(store, t, &chore.entity), chore.title),
            ));
        }
    }
    out
}

/// A Cat's or Clowder's name for a calendar cell.
fn name_of(store: &Catalog, t: &L10n, entity: &str) -> String {
    store
        .current(entity, keys::NAME)
        .ok()
        .flatten()
        .unwrap_or_else(|| t.unnamed().to_string())
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

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Datelike;

    fn day(y: i32, m: u32, d: u32) -> NaiveDate {
        NaiveDate::from_ymd_opt(y, m, d).unwrap()
    }

    #[test]
    fn a_week_runs_from_its_monday_and_a_month_keeps_its_columns() {
        // A Wednesday: the week starts on the Monday before it.
        let (first, days) = calendar_span(day(2026, 3, 11), AgendaView::Week);
        assert_eq!((first, days), (day(2026, 3, 9), 7));
        // March 2026 starts on a Sunday: six days of lead, then 31.
        let (first, days) = calendar_span(day(2026, 3, 11), AgendaView::Month);
        assert_eq!((first, days), (day(2026, 2, 23), 6 + 31));
        // February 2026 starts on a Sunday too, and has 28 days.
        let (first, days) = calendar_span(day(2026, 2, 2), AgendaView::Month);
        assert_eq!((first, days), (day(2026, 1, 26), 6 + 28));
        // A month that starts on a Monday has no lead at all.
        let (first, days) = calendar_span(day(2026, 6, 15), AgendaView::Month);
        assert_eq!((first, days), (day(2026, 6, 1), 30));
        // Every span is whole weeks plus the lead, so the columns hold.
        for view in [AgendaView::Week, AgendaView::Month] {
            let (first, _) = calendar_span(day(2026, 3, 11), view);
            assert_eq!(first.weekday(), chrono::Weekday::Mon);
        }
    }

    #[test]
    fn the_chevrons_walk_a_week_or_a_month() {
        assert_eq!(back(day(2026, 3, 11), 7), day(2026, 3, 4));
        assert_eq!(forward(day(2026, 3, 11), 7), day(2026, 3, 18));
        assert_eq!(back(day(2026, 3, 31), 0), day(2026, 2, 28), "a short month");
        assert_eq!(forward(day(2026, 12, 15), 0), day(2027, 1, 15));
    }
}
