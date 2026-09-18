//! Chores on the desk: the row with its tick box and week dots, the
//! dialog that makes or changes one, and the history window.

use catlog_core::chores::{
    Chore, ChoreDay, ChoreLogRow, ChoreRepeat, ChoreSchedule, ChoreUnit, Hhmm, state_on, streak,
    week_dots,
};
use catlog_core::{Catalog, keys};
use chrono::NaiveDate;
use egui::{Color32, Context, Ui};

use crate::l10n::L10n;
use crate::labels::{chore_words, format_day, weekday_short};

/// What the keeper did on a chore row this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ChoreAction {
    None,
    /// Tick or untick today's occurrence.
    Toggle(Chore),
    Edit(Chore),
    PauseResume(Chore),
    End(Chore),
    History(Chore),
    New(String),
}

/// One chore as a row: tick box, words, streak, the week's dots, and a
/// right-click menu with the rest.
pub fn chore_row(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    chore: &Chore,
    today: NaiveDate,
) -> ChoreAction {
    let mut action = ChoreAction::None;
    let ticks = store.chore_ticks(chore).unwrap_or_default();
    let state = state_on(chore, &ticks, today, today);
    let due_today = matches!(state, ChoreDay::Pending | ChoreDay::Done | ChoreDay::Missed);
    let mut done = ticks.contains_key(&today);
    ui.horizontal(|ui| {
        if chore.paused {
            ui.label(t.chore_paused());
        } else if ui
            .add_enabled(due_today, egui::Checkbox::without_text(&mut done))
            .changed()
        {
            action = ChoreAction::Toggle(chore.clone());
        }
        let mut parts = vec![chore_words(t, chore)];
        let run = streak(chore, &ticks, today);
        if run > 0 {
            parts.push(t.streak_days(run as i64));
        }
        if !due_today && let Some(next) = catlog_core::chores::next_due(chore, &ticks, today) {
            parts.push(t.chore_due(&format_day(t.locale(), next)));
        }
        let label = ui.label(parts.join(" · "));
        label.context_menu(|ui| {
            if ui.button(t.chore_edit()).clicked() {
                action = ChoreAction::Edit(chore.clone());
                ui.close();
            }
            let pause = if chore.paused {
                t.chore_resume()
            } else {
                t.chore_pause()
            };
            if ui.button(pause).clicked() {
                action = ChoreAction::PauseResume(chore.clone());
                ui.close();
            }
            if ui.button(t.chore_history()).clicked() {
                action = ChoreAction::History(chore.clone());
                ui.close();
            }
            if ui.button(t.chore_end()).clicked() {
                action = ChoreAction::End(chore.clone());
                ui.close();
            }
        });
        paint_week_dots(ui, &week_dots(chore, &ticks, today));
    });
    action
}

/// Seven dots, one per day of the week ending today.
fn paint_week_dots(ui: &mut Ui, dots: &[ChoreDay]) {
    let (rect, _) = ui.allocate_exact_size(
        egui::vec2(dots.len() as f32 * 12.0, 12.0),
        egui::Sense::hover(),
    );
    let painter = ui.painter();
    for (i, d) in dots.iter().enumerate() {
        let centre = rect.min + egui::vec2(6.0 + i as f32 * 12.0, 6.0);
        let (fill, stroke) = match d {
            ChoreDay::Done => (Color32::from_rgb(76, 175, 80), Color32::TRANSPARENT),
            ChoreDay::Missed => (Color32::from_rgb(230, 90, 40), Color32::TRANSPARENT),
            ChoreDay::Pending => (Color32::TRANSPARENT, Color32::from_rgb(230, 90, 40)),
            ChoreDay::Upcoming | ChoreDay::NotDue => (Color32::TRANSPARENT, Color32::GRAY),
        };
        painter.circle(centre, 4.0, fill, egui::Stroke::new(1.0, stroke));
    }
}

/// The chore editor: what, how often, when, and whether to remind. An
/// existing chore can be duplicated: the dialog asks whose the copy is,
/// turns into a new chore preset from the original, and comes back to
/// the original once the copy is saved or dismissed, so three kittens
/// get their feeding with pick, Save, pick, Save.
#[derive(Debug, Default)]
pub struct ChoreDialog {
    pub open: bool,
    pub entity: String,
    pub existing: Option<Chore>,
    /// The picker for the copy's cat or home is up.
    pub picking: bool,
    /// The original to come back to after a copy.
    pub return_to: Option<Chore>,
    today: NaiveDate,
    pub title: String,
    pub repeat: Option<ChoreRepeat>,
    pub every: String,
    pub unit: Option<ChoreUnit>,
    pub weekdays: [bool; 7],
    pub time: String,
    pub start: String,
    pub remind: bool,
    pub remind_at: String,
    pub error: Option<String>,
    id: u64,
}

impl ChoreDialog {
    /// Opens for a new chore on `entity`, or over `existing`.
    pub fn ask(&mut self, entity: &str, existing: Option<Chore>, today: NaiveDate) {
        self.entity = entity.to_string();
        self.open = true;
        self.error = None;
        self.picking = false;
        self.today = today;
        self.id += 1;
        match &existing {
            Some(c) => {
                self.title = c.title.clone();
                self.repeat = Some(c.schedule.repeat);
                self.every = c.schedule.every.max(1).to_string();
                self.unit = Some(c.schedule.unit);
                self.weekdays = [false; 7];
                for d in &c.schedule.weekdays {
                    if (1..=7).contains(d) {
                        self.weekdays[(*d - 1) as usize] = true;
                    }
                }
                self.time = c.time.map(|t| t.text()).unwrap_or_default();
                self.start = c.start.to_string();
                self.remind = c.remind;
                self.remind_at = c.remind_at.or(c.time).map(|t| t.text()).unwrap_or_default();
            }
            None => {
                self.title.clear();
                self.repeat = Some(ChoreRepeat::Daily);
                self.every = "2".into();
                self.unit = Some(ChoreUnit::Days);
                self.weekdays = [false; 7];
                self.time.clear();
                self.start = today.to_string();
                self.remind = false;
                self.remind_at.clear();
            }
        }
        self.existing = existing;
    }

    /// Turns the dialog into a new chore for `target`, preset from the
    /// chore edited: title, schedule, time and reminder come along, the
    /// start is today, pause and end and unknown keys stay behind. The
    /// original waits underneath.
    pub fn duplicate_onto(&mut self, target: &str) {
        let Some(original) = self.existing.take() else {
            return;
        };
        let today = self.today;
        self.ask(target, Some(original.clone()), today);
        self.existing = None;
        self.start = today.to_string();
        self.return_to = Some(original);
    }

    /// The chore as typed, or what is wrong with it.
    pub fn draft(&self) -> Result<Chore, String> {
        let title = self.title.trim().to_string();
        if title.is_empty() {
            return Err("title".into());
        }
        let schedule = match self.repeat.unwrap_or(ChoreRepeat::Daily) {
            ChoreRepeat::Daily => ChoreSchedule::daily(),
            ChoreRepeat::EveryDays => ChoreSchedule::every(
                self.every
                    .trim()
                    .parse::<u32>()
                    .map_err(|_| "every".to_string())?
                    .max(1),
                self.unit.unwrap_or(ChoreUnit::Days),
            ),
            ChoreRepeat::Weekdays => {
                let days: Vec<u32> = (0..7u32)
                    .filter(|i| self.weekdays[*i as usize])
                    .map(|i| i + 1)
                    .collect();
                if days.is_empty() {
                    return Err("weekdays".into());
                }
                ChoreSchedule::weekdays(days)
            }
        };
        let time = match self.time.trim() {
            "" => None,
            raw => Some(Hhmm::parse(raw).ok_or_else(|| "time".to_string())?),
        };
        let start = self
            .start
            .trim()
            .parse::<NaiveDate>()
            .map_err(|_| "start".to_string())?;
        let remind_at = match self.remind_at.trim() {
            "" => None,
            raw => Some(Hhmm::parse(raw).ok_or_else(|| "remindAt".to_string())?),
        };
        let base = self.existing.clone().unwrap_or(Chore {
            id: String::new(),
            entity: self.entity.clone(),
            title: String::new(),
            schedule: ChoreSchedule::daily(),
            time: None,
            start,
            paused: false,
            ended: false,
            remind: false,
            remind_at: None,
            extra: Default::default(),
        });
        Ok(Chore {
            title,
            schedule,
            time,
            start,
            remind: self.remind,
            remind_at: if self.remind {
                remind_at.or(time)
            } else {
                remind_at
            },
            ..base
        })
    }

    /// Draws the dialog; the chore to save once Save was clicked.
    pub fn show(&mut self, ctx: &Context, store: &Catalog, t: &L10n) -> Option<Chore> {
        if !self.open {
            return None;
        }
        let mut result = None;
        let mut close = false;
        let mut duplicate = false;
        let title = if self.existing.is_some() {
            t.chore_edit()
        } else {
            t.new_chore()
        };
        let modal = egui::Modal::new(egui::Id::new(("chore-dialog", self.id))).show(ctx, |ui| {
            ui.heading(title);
            egui::Grid::new("chore-grid").num_columns(2).show(ui, |ui| {
                ui.label(t.chore_title_label());
                ui.add(egui::TextEdit::singleline(&mut self.title).desired_width(260.0));
                ui.end_row();
                ui.label(t.chore_repeat_every());
                ui.vertical(|ui| {
                    ui.radio_value(
                        &mut self.repeat,
                        Some(ChoreRepeat::Daily),
                        t.chore_repeat_daily(),
                    );
                    ui.horizontal(|ui| {
                        ui.radio_value(
                            &mut self.repeat,
                            Some(ChoreRepeat::EveryDays),
                            t.every_label(),
                        );
                        ui.add(egui::TextEdit::singleline(&mut self.every).desired_width(40.0));
                        egui::ComboBox::from_id_salt("chore-unit")
                            .selected_text(unit_words(t, self.unit.unwrap_or(ChoreUnit::Days)))
                            .show_ui(ui, |ui| {
                                for unit in [
                                    ChoreUnit::Days,
                                    ChoreUnit::Weeks,
                                    ChoreUnit::Months,
                                    ChoreUnit::Years,
                                ] {
                                    ui.selectable_value(
                                        &mut self.unit,
                                        Some(unit),
                                        unit_words(t, unit),
                                    );
                                }
                            });
                    });
                    ui.radio_value(
                        &mut self.repeat,
                        Some(ChoreRepeat::Weekdays),
                        t.chore_repeat_weekdays(),
                    );
                    if self.repeat == Some(ChoreRepeat::Weekdays) {
                        ui.horizontal(|ui| {
                            for (i, on) in self.weekdays.iter_mut().enumerate() {
                                ui.checkbox(on, weekday_short(t, i as u32 + 1));
                            }
                        });
                    }
                });
                ui.end_row();
                ui.label(t.time_label());
                ui.horizontal(|ui| {
                    ui.add(
                        egui::TextEdit::singleline(&mut self.time)
                            .desired_width(60.0)
                            .hint_text("HH:MM"),
                    );
                    ui.label(egui::RichText::new(t.chore_no_time()).weak());
                });
                ui.end_row();
                ui.label(t.start());
                ui.add(
                    egui::TextEdit::singleline(&mut self.start)
                        .desired_width(100.0)
                        .hint_text("YYYY-MM-DD"),
                );
                ui.end_row();
                ui.label(t.remind_me());
                ui.horizontal(|ui| {
                    ui.checkbox(&mut self.remind, "");
                    if self.remind {
                        ui.label(t.remind_at_label());
                        ui.add(
                            egui::TextEdit::singleline(&mut self.remind_at)
                                .desired_width(60.0)
                                .hint_text("HH:MM"),
                        );
                    }
                });
                ui.end_row();
            });
            if let Some(e) = &self.error {
                ui.colored_label(ui.visuals().error_fg_color, e);
            }
            ui.horizontal(|ui| {
                if ui.button(t.save()).clicked() {
                    match self.draft() {
                        Ok(chore) => result = Some(chore),
                        Err(field) => self.error = Some(field),
                    }
                }
                if ui.button(t.cancel()).clicked() {
                    close = true;
                }
                if self.existing.is_some()
                    && crate::icons::button(ui, crate::icons::COPY, t.chore_duplicate()).clicked()
                {
                    duplicate = true;
                }
            });
        });
        if duplicate {
            self.picking = true;
        }
        if self.picking {
            self.show_picker(ctx, store, t);
        }
        if result.is_some() || close || modal.should_close() {
            match self.return_to.take() {
                // The copy is done with; the original comes back.
                Some(original) => {
                    let today = self.today;
                    self.ask(&original.entity.clone(), Some(original), today);
                }
                None => self.open = false,
            }
            ctx.request_repaint();
        }
        result
    }

    /// Whose is the copy: every visible cat and home, the original's
    /// among them, so "same cat, other time" is one more click.
    fn show_picker(&mut self, ctx: &Context, store: &Catalog, t: &L10n) {
        let mut target: Option<String> = None;
        let modal =
            egui::Modal::new(egui::Id::new(("chore-copy-target", self.id))).show(ctx, |ui| {
                ui.heading(t.reminder_for());
                let cats = store.cats(None).unwrap_or_default();
                let homes = store.clowders().unwrap_or_default();
                for e in cats.iter().chain(homes.iter()) {
                    if store.is_hidden(&e.id).unwrap_or(false) {
                        continue;
                    }
                    if ui.button(&e.name).clicked() {
                        target = Some(e.id.clone());
                    }
                }
            });
        if let Some(target) = target {
            self.picking = false;
            self.duplicate_onto(&target);
        } else if modal.should_close() {
            self.picking = false;
        }
    }
}

fn unit_words(t: &L10n, unit: ChoreUnit) -> &'static str {
    match unit {
        ChoreUnit::Days => t.unit_days(),
        ChoreUnit::Weeks => t.unit_weeks(),
        ChoreUnit::Months => t.unit_months(),
        ChoreUnit::Years => t.unit_years(),
    }
}

/// The history window: every occurrence with its state.
#[derive(Debug, Default)]
pub struct ChoreHistory {
    pub open: bool,
    pub chore: Option<Chore>,
    pub rows: Vec<ChoreLogRow>,
}

impl ChoreHistory {
    pub fn open_for(&mut self, store: &Catalog, chore: Chore, today: NaiveDate) {
        self.rows = store.chore_log(&chore, today).unwrap_or_default();
        self.chore = Some(chore);
        self.open = true;
    }

    pub fn show(&mut self, ctx: &Context, store: &Catalog, t: &L10n) {
        if !self.open {
            return;
        }
        let Some(chore) = &self.chore else {
            self.open = false;
            return;
        };
        let name = store
            .current(&chore.entity, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_default();
        let modal = egui::Modal::new(egui::Id::new("chore-history")).show(ctx, |ui| {
            ui.heading(format!("{} · {}", chore.title, name));
            ui.strong(t.chore_history());
            egui::ScrollArea::vertical()
                .max_height(360.0)
                .show(ui, |ui| {
                    egui::Grid::new("chore-log").striped(true).show(ui, |ui| {
                        for row in &self.rows {
                            ui.label(format_day(t.locale(), row.due));
                            ui.label(match row.state {
                                ChoreDay::Done => t.chore_done_state(),
                                ChoreDay::Missed => t.chore_missed(),
                                ChoreDay::Pending => t.chore_pending(),
                                ChoreDay::Upcoming => t.chore_upcoming(),
                                ChoreDay::NotDue => t.chore_not_due(),
                            });
                            let mut note = String::new();
                            if let Some(on) = row.done_on
                                && on != row.due
                            {
                                note = t.done_on(&format_day(t.locale(), on));
                            }
                            if let Some(author) = &row.author {
                                if !note.is_empty() {
                                    note.push_str(" · ");
                                }
                                note.push_str(author);
                            }
                            ui.label(note);
                            ui.end_row();
                        }
                    });
                });
        });
        if modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_dialog_reads_every_schedule_and_refuses_what_is_missing() {
        let today = NaiveDate::from_ymd_opt(2026, 3, 10).unwrap();
        let mut d = ChoreDialog::default();
        d.ask("cat:a", None, today);
        assert_eq!(d.draft().unwrap_err(), "title");
        d.title = "Feed".into();
        let c = d.draft().unwrap();
        assert_eq!(c.schedule, ChoreSchedule::daily());
        assert_eq!(c.start, today);
        assert_eq!(c.entity, "cat:a");
        d.repeat = Some(ChoreRepeat::EveryDays);
        d.every = "x".into();
        assert_eq!(d.draft().unwrap_err(), "every");
        d.every = "3".into();
        d.unit = Some(ChoreUnit::Weeks);
        assert_eq!(
            d.draft().unwrap().schedule,
            ChoreSchedule::every(3, ChoreUnit::Weeks)
        );
        d.repeat = Some(ChoreRepeat::Weekdays);
        assert_eq!(d.draft().unwrap_err(), "weekdays");
        d.weekdays[0] = true;
        d.weekdays[4] = true;
        assert_eq!(
            d.draft().unwrap().schedule,
            ChoreSchedule::weekdays(vec![1, 5])
        );
        d.time = "8:70".into();
        assert!(d.draft().is_ok(), "Hhmm::parse is lenient on minutes");
        d.time = "eight".into();
        assert_eq!(d.draft().unwrap_err(), "time");
        d.time = "08:00".into();
        d.start = "someday".into();
        assert_eq!(d.draft().unwrap_err(), "start");
        d.start = "2026-03-01".into();
        d.remind = true;
        let c = d.draft().unwrap();
        assert_eq!(
            c.remind_at,
            Some(Hhmm { hour: 8, minute: 0 }),
            "reminder falls back to the time"
        );
        d.remind_at = "07:30".into();
        assert_eq!(
            d.draft().unwrap().remind_at,
            Some(Hhmm {
                hour: 7,
                minute: 30
            })
        );
        // Editing keeps id and flags.
        let mut existing = c.clone();
        existing.id = "c1".into();
        existing.paused = true;
        d.ask("cat:a", Some(existing), today);
        assert_eq!(d.title, "Feed");
        assert_eq!(d.repeat, Some(ChoreRepeat::Weekdays));
        assert!(d.weekdays[0] && d.weekdays[4]);
        let saved = d.draft().unwrap();
        assert_eq!(saved.id, "c1");
        assert!(saved.paused);
        // Duplicating: a new chore for the target with the same words,
        // schedule and time, today's start, not paused; the original
        // waits underneath.
        d.duplicate_onto("cat:b");
        assert!(d.existing.is_none());
        assert_eq!(d.entity, "cat:b");
        assert_eq!(d.title, "Feed");
        assert_eq!(d.repeat, Some(ChoreRepeat::Weekdays));
        let copy = d.draft().unwrap();
        assert_eq!(copy.id, "");
        assert_eq!(copy.entity, "cat:b");
        assert_eq!(copy.start, today);
        assert!(!copy.paused);
        assert_eq!(d.return_to.as_ref().map(|c| c.id.as_str()), Some("c1"));
    }
}
