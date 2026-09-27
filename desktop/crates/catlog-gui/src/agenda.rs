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
use crate::labels::{clock, field_label, format_day, format_partial_date};
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
#[allow(clippy::too_many_arguments)]
pub fn show_agenda(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    faces: &mut FaceCache,
    memo: &mut AgendaMemo,
    today: NaiveDate,
    // The app's own clock, so the line across the hour it is stands
    // where a test says it does and not where the machine's clock does.
    now: chrono::NaiveDateTime,
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
    // What the page does, over both halves.
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
    ui.separator();
    // The list on the left, the calendar on the right: the page used to
    // be half empty, and its three tabs hid from each other.
    let mut mode = Calendar::of(store);
    let anchor = anchor_day(store, today);
    let mut opened = None;
    ui.horizontal_top(|ui| {
        let list_width = (ui.available_width() * 0.42).clamp(320.0, CONTENT_WIDTH);
        // A real height, or everything in the column is clipped away and
        // nothing in it can be clicked.
        let list_height = ui.available_height();
        ui.allocate_ui_with_layout(
            egui::vec2(list_width, list_height),
            egui::Layout::top_down(egui::Align::LEFT),
            |ui| {
                ui.set_min_width(list_width);
                egui::ScrollArea::vertical()
                    .id_salt("agenda-list")
                    .show(ui, |ui| {
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
                            if items.is_empty()
                                && chores.today.is_empty()
                                && chores.upcoming.is_empty()
                            {
                                ui.label(t.agenda_empty());
                            }
                            for item in items {
                                match item {
                                    AgendaItem::Reminder(r) => {
                                        if reminder_row(ui, store, t, faces, r, item.when().date())
                                        {
                                            action = AgendaAction::OpenEntity(r.entity.clone());
                                        }
                                    }
                                    AgendaItem::Appointments(group) => {
                                        if let Some(a) =
                                            appointment_card(ui, store, t, faces, group, true)
                                        {
                                            action = AgendaAction::Appointment(a);
                                        }
                                    }
                                }
                            }
                        });
                    });
            },
        );
        ui.separator();
        // The calendar: a month or a week of the same plans.
        ui.vertical(|ui| {
            ui.horizontal(|ui| {
                for one in Calendar::ALL {
                    if ui.selectable_label(mode == one, one.words(t)).clicked() {
                        mode = one;
                        let _ = store.set_local_setting(CALENDAR_KEY, one.stored());
                    }
                }
                ui.separator();
                let step = if mode == Calendar::Week { 7 } else { 0 };
                if crate::icons::icon_button(ui, crate::icons::CHEVRON_LEFT, t.month_before())
                    .clicked()
                {
                    set_anchor(store, back(anchor, step));
                }
                if ui.button(t.today()).clicked() {
                    let _ = store.remove_local_setting(ANCHOR_KEY);
                }
                if crate::icons::icon_button(ui, crate::icons::CHEVRON_RIGHT, t.month_after())
                    .clicked()
                {
                    set_anchor(store, forward(anchor, step));
                }
                // Straight to a month, without walking there.
                month_picker(ui, store, t, anchor);
            });
            ui.separator();
            let entries = day_entries(store, t, &data.items, anchor, mode, today);
            if let Some(entity) = match mode {
                Calendar::Week => week_view(ui, t, &entries, anchor, today, now),
                Calendar::Month => month_view(ui, t, &entries, anchor, today),
            } {
                opened = Some(entity);
            }
        });
    });
    if let Some(entity) = opened {
        action = AgendaAction::OpenEntity(entity);
    }
    action
}

/// How wide the agenda's list may grow, whatever the window does.
const CONTENT_WIDTH: f32 = 900.0;
const CALENDAR_KEY: &str = "agendaCalendar";

/// The two calendars, side by side with the list.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Calendar {
    Month,
    Week,
}

impl Calendar {
    const ALL: [Calendar; 2] = [Calendar::Month, Calendar::Week];

    fn stored(self) -> &'static str {
        match self {
            Calendar::Month => "month",
            Calendar::Week => "week",
        }
    }

    fn of(store: &Catalog) -> Calendar {
        match store.local_setting(CALENDAR_KEY).as_deref() {
            Some("week") => Calendar::Week,
            _ => Calendar::Month,
        }
    }

    fn words(self, t: &L10n) -> &'static str {
        match self {
            Calendar::Month => t.calendar_month(),
            Calendar::Week => t.calendar_week(),
        }
    }
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

/// The month and the year the calendar stands in, and a menu that jumps
/// to another one without walking there a month at a time.
fn month_picker(ui: &mut Ui, store: &Catalog, t: &L10n, anchor: NaiveDate) {
    use chrono::Datelike;
    let shown = format_partial_date(
        t.locale(),
        &catlog_core::PartialDate {
            year: anchor.year(),
            month: Some(anchor.month()),
            day: None,
        },
    );
    ui.menu_button(shown, |ui| {
        ui.horizontal(|ui| {
            if crate::icons::icon_button(ui, crate::icons::CHEVRON_LEFT, t.month_before()).clicked()
            {
                set_anchor(
                    store,
                    back(anchor, 0)
                        .with_month(anchor.month())
                        .unwrap_or(anchor)
                        .with_year(anchor.year() - 1)
                        .unwrap_or(anchor),
                );
            }
            ui.label(anchor.year().to_string());
            if crate::icons::icon_button(ui, crate::icons::CHEVRON_RIGHT, t.month_after()).clicked()
            {
                set_anchor(store, anchor.with_year(anchor.year() + 1).unwrap_or(anchor));
            }
        });
        ui.separator();
        for month in 1..=12u32 {
            let day = NaiveDate::from_ymd_opt(anchor.year(), month, 1).unwrap_or(anchor);
            let words = format_partial_date(
                t.locale(),
                &catlog_core::PartialDate {
                    year: anchor.year(),
                    month: Some(month),
                    day: None,
                },
            );
            if ui
                .selectable_label(month == anchor.month(), words)
                .clicked()
            {
                set_anchor(store, day);
                ui.close();
            }
        }
    })
    .response
    .on_hover_text(t.pick_month());
}

/// What stands on a day: when it is, what it says, whose it is, whether
/// it takes a time of day at all, and whether it repeats.
#[derive(Debug, Clone)]
struct DayEntry {
    day: NaiveDate,
    /// None for an all-day thing: a reminder, a chore without a time.
    at: Option<chrono::NaiveTime>,
    words: String,
    entity: String,
    repeats: bool,
}

/// The plans of the shown range, by day: the reminders and appointments
/// the list shows, and every day a chore is due in that range.
fn day_entries(
    store: &Catalog,
    t: &L10n,
    items: &[AgendaItem],
    anchor: NaiveDate,
    mode: Calendar,
    today: NaiveDate,
) -> Vec<DayEntry> {
    let (first, days) = span(anchor, mode);
    let last = first + chrono::Duration::days(days - 1);
    let mut out = Vec::new();
    for item in items {
        let when = item.when();
        if when.date() < first || when.date() > last {
            continue;
        }
        let midnight = when.time() == chrono::NaiveTime::MIN;
        match item {
            AgendaItem::Reminder(r) => out.push(DayEntry {
                day: when.date(),
                at: (!midnight).then(|| when.time()),
                words: format!(
                    "{} · {}",
                    name_of(store, t, &r.entity),
                    field_label(t, store, &r.field)
                ),
                entity: r.entity.clone(),
                repeats: false,
            }),
            AgendaItem::Appointments(group) => {
                let a = &group[0];
                out.push(DayEntry {
                    day: when.date(),
                    at: (!midnight).then(|| when.time()),
                    words: if group.len() > 1 {
                        format!("{} · {}", a.title, group.len())
                    } else {
                        format!("{} · {}", name_of(store, t, &a.entity), a.title)
                    },
                    entity: a.entity.clone(),
                    repeats: false,
                });
            }
        }
    }
    // Every day a chore is due in the range, not only the next one: a
    // daily chore belongs on every one of those days.
    for chore in store.all_chores(false).unwrap_or_default() {
        // A paused chore is due on no day: the list files it under
        // Paused, and the calendar used to print it on every cell of
        // the month all the same.
        if chore.paused || !chore.active() {
            continue;
        }
        let ticks = store.chore_ticks(&chore).unwrap_or_default();
        for occurrence in catlog_core::chores::occurrences(&chore, &ticks, first, last) {
            out.push(DayEntry {
                day: occurrence.due,
                at: chore.time.map(|hhmm| {
                    chrono::NaiveTime::from_hms_opt(hhmm.hour, hhmm.minute, 0)
                        .unwrap_or(chrono::NaiveTime::MIN)
                }),
                words: format!("{} · {}", name_of(store, t, &chore.entity), chore.title),
                entity: chore.entity.clone(),
                repeats: true,
            });
        }
    }
    let _ = today;
    out.sort_by_key(|e| (e.day, e.at));
    out
}

/// The first cell and how many cells a calendar holds: a week from its
/// Monday, a month from the Monday before its first, so a month that
/// starts mid-week keeps its days under the right columns.
fn span(anchor: NaiveDate, mode: Calendar) -> (NaiveDate, i64) {
    use chrono::Datelike;
    match mode {
        Calendar::Week => (
            anchor - chrono::Duration::days(anchor.weekday().num_days_from_monday() as i64),
            7,
        ),
        Calendar::Month => {
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

/// How tall an hour is in the week's day columns.
const HOUR: f32 = 34.0;

/// One entry, drawn where it is clicked from.
fn entry_button(ui: &mut Ui, t: &L10n, entry: &DayEntry, small: bool) -> bool {
    let words = match entry.at {
        Some(at) => format!(
            "{} {}",
            clock(catlog_core::chores::Hhmm {
                hour: at.format("%H").to_string().parse().unwrap_or(0),
                minute: at.format("%M").to_string().parse().unwrap_or(0),
            }),
            entry.words
        ),
        None => entry.words.clone(),
    };
    let text = if small {
        egui::RichText::new(words).small()
    } else {
        egui::RichText::new(words)
    };
    let clicked = ui
        .add(
            egui::Button::new(text)
                .frame(false)
                .wrap_mode(egui::TextWrapMode::Truncate),
        )
        .clicked();
    if entry.repeats {
        ui.add(
            egui::Label::new(
                egui::RichText::new(crate::icons::REFRESH)
                    .small()
                    .color(crate::theme::PALETTE.grey),
            )
            .selectable(false),
        )
        .on_hover_text(t.repeats());
    }
    clicked
}

/// The week: a column a day over the whole day, an all-day band above
/// it, and a line across the hour it is now.
fn week_view(
    ui: &mut Ui,
    t: &L10n,
    entries: &[DayEntry],
    anchor: NaiveDate,
    today: NaiveDate,
    now: chrono::NaiveDateTime,
) -> Option<String> {
    let (first, days) = span(anchor, Calendar::Week);
    let mut opened = None;
    let column = ((ui.available_width() - 56.0) / days as f32).max(90.0);
    // All day, above the hours: a reminder is not at midnight.
    ui.horizontal_top(|ui| {
        ui.allocate_ui_with_layout(
            egui::vec2(48.0, 52.0),
            egui::Layout::top_down(egui::Align::LEFT),
            |ui| {
                ui.set_min_width(48.0);
                ui.label(egui::RichText::new(t.all_day()).weak().small());
            },
        );
        for step in 0..days {
            let day = first + chrono::Duration::days(step);
            ui.allocate_ui_with_layout(
                egui::vec2(column, 52.0),
                egui::Layout::top_down(egui::Align::LEFT),
                |ui| {
                    ui.set_min_width(column);
                    let heading = format_day(t.locale(), day);
                    ui.label(if day == today {
                        egui::RichText::new(heading).strong()
                    } else {
                        egui::RichText::new(heading).weak()
                    });
                    for entry in entries.iter().filter(|e| e.day == day && e.at.is_none()) {
                        if entry_button(ui, t, entry, true) {
                            opened = Some(entry.entity.clone());
                        }
                    }
                },
            );
        }
    });
    ui.separator();
    // The day itself, midnight to midnight: animals have no hours.
    let mut scroll = egui::ScrollArea::vertical()
        .id_salt("agenda-week")
        .max_height(ui.available_height().max(240.0));
    // Opened on the hour it is, not on midnight; once, so the hand can
    // then scroll where it likes.
    let scrolled = egui::Id::new(("agenda-week-scrolled", first));
    if ui.ctx().data(|d| d.get_temp::<bool>(scrolled)) != Some(true) {
        ui.ctx().data_mut(|d| d.insert_temp(scrolled, true));
        use chrono::Timelike;
        let at = (now.time().hour() as f32 - 1.0).max(0.0) * HOUR;
        scroll = scroll.vertical_scroll_offset(at);
    }
    scroll.show(ui, |ui| {
        let (rect, _) = ui.allocate_exact_size(
            egui::vec2(48.0 + column * days as f32, HOUR * 24.0),
            egui::Sense::hover(),
        );
        let painter = ui.painter_at(rect);
        for hour in 0..=24 {
            let y = rect.top() + hour as f32 * HOUR;
            painter.hline(
                rect.x_range(),
                y,
                egui::Stroke::new(1.0, crate::theme::PALETTE.tan),
            );
            if hour < 24 {
                painter.text(
                    egui::pos2(rect.left() + 6.0, y + 2.0),
                    egui::Align2::LEFT_TOP,
                    format!("{hour:02}"),
                    egui::FontId::proportional(11.0),
                    crate::theme::PALETTE.grey,
                );
            }
        }
        for step in 0..=days {
            let x = rect.left() + 48.0 + column * step as f32;
            painter.vline(
                x,
                rect.y_range(),
                egui::Stroke::new(1.0, crate::theme::PALETTE.tan),
            );
        }
        // Where the day has got to, when today is in view.
        if (first..first + chrono::Duration::days(days)).contains(&today) {
            use chrono::Timelike;
            let minutes = now.time().hour() as f32 * 60.0 + now.time().minute() as f32;
            let y = rect.top() + minutes / 60.0 * HOUR;
            painter.hline(
                rect.x_range(),
                y,
                egui::Stroke::new(2.0, crate::theme::PALETTE.orange),
            );
        }
        for entry in entries.iter().filter(|e| e.at.is_some()) {
            let Some(at) = entry.at else { continue };
            let step = (entry.day - first).num_days();
            if !(0..days).contains(&step) {
                continue;
            }
            use chrono::Timelike;
            let minutes = at.hour() as f32 * 60.0 + at.minute() as f32;
            let at_rect = egui::Rect::from_min_size(
                egui::pos2(
                    rect.left() + 50.0 + column * step as f32,
                    rect.top() + minutes / 60.0 * HOUR,
                ),
                egui::vec2(column - 4.0, HOUR - 2.0),
            );
            let mut cell = ui.new_child(
                egui::UiBuilder::new()
                    .max_rect(at_rect)
                    .layout(egui::Layout::left_to_right(egui::Align::Center)),
            );
            cell.painter()
                .rect_filled(at_rect, 4.0, crate::theme::PALETTE.tan.gamma_multiply(0.8));
            if entry_button(&mut cell, t, entry, true) {
                opened = Some(entry.entity.clone());
            }
        }
    });
    opened
}

/// The month: the weekdays as a header, then a cell a day with its
/// all-day things first and the timed ones under them.
fn month_view(
    ui: &mut Ui,
    t: &L10n,
    entries: &[DayEntry],
    anchor: NaiveDate,
    today: NaiveDate,
) -> Option<String> {
    use chrono::Datelike;
    let (first, days) = span(anchor, Calendar::Month);
    let mut opened = None;
    let cell = ((ui.available_width() - 16.0) / 7.0).max(90.0);
    egui::ScrollArea::vertical()
        .id_salt("agenda-month")
        .show(ui, |ui| {
            egui::Grid::new(("agenda-month-grid", anchor))
                .num_columns(7)
                .spacing([2.0, 2.0])
                // A calendar's weeks are not a striped table.
                .striped(false)
                .show(ui, |ui| {
                    for step in 0..7 {
                        let day = first + chrono::Duration::days(step);
                        ui.label(
                            egui::RichText::new(crate::labels::weekday_full(
                                t,
                                day.weekday().number_from_monday(),
                            ))
                            .strong()
                            .small(),
                        );
                    }
                    ui.end_row();
                    for step in 0..days {
                        let day = first + chrono::Duration::days(step);
                        ui.allocate_ui_with_layout(
                            egui::vec2(cell, 96.0),
                            egui::Layout::top_down(egui::Align::LEFT),
                            |ui| {
                                ui.set_min_width(cell);
                                ui.set_min_height(90.0);
                                let outside = day.month() != anchor.month();
                                let number = egui::RichText::new(day.day().to_string());
                                ui.label(if day == today {
                                    number.strong().color(crate::theme::PALETTE.orange)
                                } else if outside {
                                    number.weak()
                                } else {
                                    number
                                });
                                let mine = entries.iter().filter(|e| e.day == day);
                                for entry in mine {
                                    ui.horizontal(|ui| {
                                        if entry_button(ui, t, entry, true) {
                                            opened = Some(entry.entity.clone());
                                        }
                                    });
                                }
                            },
                        );
                        if (step + 1) % 7 == 0 {
                            ui.end_row();
                        }
                    }
                });
        });
    opened
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
    fn the_entries_of_a_month_hold_the_appointments_in_it() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let visit = catlog_core::appointments::Appointment {
            id: String::new(),
            entity: "cat:a".into(),
            date: day(2026, 3, 12),
            time: catlog_core::chores::Hhmm::parse("14:30"),
            title: "Vet".into(),
            notes: String::new(),
            linked_field: None,
            linked_value: None,
            alert: catlog_core::appointments::AppointmentAlert::None,
            done: false,
            group: None,
            extra: Default::default(),
        };
        store.create_appointment("a-vet", &visit).unwrap();
        let t = L10n::new("en");
        let items = store.agenda_items().unwrap();
        assert!(!items.is_empty(), "the visit is an agenda item");
        let entries = day_entries(
            &store,
            &t,
            &items,
            day(2026, 3, 10),
            Calendar::Month,
            day(2026, 3, 10),
        );
        assert_eq!(entries.len(), 1, "one entry: {entries:?}");
        assert_eq!(entries[0].day, day(2026, 3, 12));
        assert!(entries[0].at.is_some(), "at half past two");
    }

    #[test]
    fn a_paused_chore_is_on_no_day_of_the_calendar() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let mut chore = catlog_core::chores::Chore {
            id: String::new(),
            entity: "cat:a".into(),
            title: "Brush".into(),
            schedule: catlog_core::chores::ChoreSchedule::daily(),
            time: None,
            start: day(2026, 3, 1),
            paused: false,
            ended: false,
            remind: false,
            remind_at: None,
            extra: Default::default(),
        };
        chore = store.create_chore("c-brush", &chore).unwrap();
        let t = L10n::new("en");
        let items = store.agenda_items().unwrap();
        let entries = |store: &Catalog| {
            day_entries(
                store,
                &t,
                &items,
                day(2026, 3, 10),
                Calendar::Month,
                day(2026, 3, 10),
            )
            .len()
        };
        assert!(entries(&store) > 20, "a daily chore fills the month");
        chore.paused = true;
        store.create_chore(&chore.id, &chore).unwrap();
        assert_eq!(entries(&store), 0, "paused is due on no day");
    }

    #[test]
    fn a_week_runs_from_its_monday_and_a_month_keeps_its_columns() {
        // A Wednesday: the week starts on the Monday before it.
        let (first, days) = span(day(2026, 3, 11), Calendar::Week);
        assert_eq!((first, days), (day(2026, 3, 9), 7));
        // March 2026 starts on a Sunday: six days of lead, then 31.
        let (first, days) = span(day(2026, 3, 11), Calendar::Month);
        assert_eq!((first, days), (day(2026, 2, 23), 6 + 31));
        // February 2026 starts on a Sunday too, and has 28 days.
        let (first, days) = span(day(2026, 2, 2), Calendar::Month);
        assert_eq!((first, days), (day(2026, 1, 26), 6 + 28));
        // A month that starts on a Monday has no lead at all.
        let (first, days) = span(day(2026, 6, 15), Calendar::Month);
        assert_eq!((first, days), (day(2026, 6, 1), 30));
        // Every span is whole weeks plus the lead, so the columns hold.
        for view in [Calendar::Week, Calendar::Month] {
            let (first, _) = span(day(2026, 3, 11), view);
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
