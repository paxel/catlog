//! Moving a Cat: into a Clowder, or out to the street as a Stray, as of
//! a day the keeper may set back.

use catlog_core::{Catalog, EntityView, Entry, keys};
use egui::{Context, Key};

use crate::l10n::L10n;

#[derive(Default)]
pub struct MoveDialog {
    pub open: bool,
    /// The Cats being moved; one of them, or every marked one.
    pub cats: Vec<String>,
    pub current: Option<String>,
    /// The Cats are not all in the same home: nothing is ticked, and
    /// whatever the keeper picks is a change — the street included.
    pub mixed: bool,
    /// A home or the street has been picked since the dialog opened.
    picked: bool,
    pub clowders: Vec<EntityView>,
    /// The chosen destination; none for the street.
    pub target: Option<String>,
    pub as_of: String,
    /// The move being corrected, from a timeline: saving replaces that
    /// entry instead of adding a move. None for a new move.
    pub correcting: Option<i64>,
    /// The day the corrected move had, to tell a new day from it.
    as_of_then: String,
    id: u64,
}

impl MoveDialog {
    pub fn ask(&mut self, store: &Catalog, cat: &str) {
        self.ask_many(store, std::slice::from_ref(&cat.to_string()));
    }

    /// The same dialog for several Cats: the home they share, when they
    /// share one, is the one already ticked.
    pub fn ask_many(&mut self, store: &Catalog, cats: &[String]) {
        self.open = true;
        self.id += 1;
        self.cats = cats.to_vec();
        let homes: Vec<Option<String>> = cats
            .iter()
            .map(|cat| store.current(cat, keys::CLOWDER).ok().flatten())
            .collect();
        let first = homes.first().cloned().unwrap_or(None);
        self.mixed = homes.iter().any(|h| *h != first);
        self.picked = false;
        self.current = if self.mixed { None } else { first };
        self.clowders = store.clowders().unwrap_or_default();
        self.target = self.current.clone();
        self.as_of = chrono::Local::now().date_naive().to_string();
        self.correcting = None;
    }

    /// The same dialog over a move already made, from a timeline: its
    /// home ticked, its day set; saving corrects where to and when.
    pub fn ask_correction(&mut self, store: &Catalog, entry: &Entry) {
        self.open = true;
        self.id += 1;
        self.cats = vec![entry.entity.clone()];
        self.mixed = false;
        self.picked = false;
        self.current = entry.value.clone();
        self.clowders = store.clowders().unwrap_or_default();
        self.target = self.current.clone();
        self.as_of = chrono::DateTime::parse_from_rfc3339(&entry.date)
            .map(|d| d.with_timezone(&chrono::Local).date_naive().to_string())
            .unwrap_or_default();
        self.as_of_then = self.as_of.clone();
        self.correcting = Some(entry.seq);
    }

    /// Draws the dialog; true when a Move was recorded.
    pub fn show(&mut self, ctx: &Context, store: &mut Catalog, t: &L10n) -> bool {
        if !self.open {
            return false;
        }
        let mut moved = false;
        let mut close = false;
        let modal = egui::Modal::new(egui::Id::new(("move-dialog", self.id))).show(ctx, |ui| {
            ui.heading(t.move_to());
            for c in &self.clowders {
                // The home they are in now is named as such; the tick
                // that used to mark it is a glyph this font has not, and
                // drew as an empty box.
                let label = if Some(&c.id) == self.current.as_ref() {
                    egui::RichText::new(&c.name).strong()
                } else {
                    egui::RichText::new(&c.name)
                };
                if ui
                    .radio(self.target.as_deref() == Some(c.id.as_str()), label)
                    .clicked()
                {
                    self.target = Some(c.id.clone());
                    self.picked = true;
                }
            }
            let stray = self.target.is_none() && (!self.mixed || self.picked);
            if ui.radio(stray, t.no_clowder_stray_option()).clicked() {
                self.target = None;
                self.picked = true;
            }
            ui.horizontal(|ui| {
                ui.label(t.as_of_date(""));
                ui.add(egui::TextEdit::singleline(&mut self.as_of).desired_width(100.0));
            });
            let escape = ui.input(|i| i.key_pressed(Key::Escape));
            ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                let changed = if self.mixed {
                    self.picked
                } else if self.correcting.is_some() {
                    self.target != self.current || self.as_of.trim() != self.as_of_then
                } else {
                    self.target != self.current
                };
                if ui
                    .add_enabled(changed, egui::Button::new(t.save()))
                    .clicked()
                {
                    let day = catlog_core::PartialDate::parse_loose(&self.as_of)
                        .and_then(|d| d.earliest())
                        .unwrap_or_else(|| chrono::Local::now().date_naive());
                    let at = day
                        .and_hms_opt(12, 0, 0)
                        .and_then(|d| d.and_local_timezone(chrono::Local).single())
                        .map(|d| {
                            d.with_timezone(&chrono::Utc)
                                .to_rfc3339_opts(chrono::SecondsFormat::Micros, true)
                        });
                    if let Some(seq) = self.correcting {
                        // The day kept keeps the move's own moment.
                        let when = if self.as_of.trim() == self.as_of_then {
                            None
                        } else {
                            at.as_deref()
                        };
                        if store
                            .correct_entry(seq, self.target.as_deref(), when)
                            .is_ok()
                        {
                            moved = true;
                        }
                    }
                    for cat in self.cats.iter().filter(|_| self.correcting.is_none()) {
                        if store
                            .append_at(
                                cat,
                                keys::CLOWDER,
                                self.target.as_deref(),
                                at.as_deref(),
                                false,
                            )
                            .is_ok()
                        {
                            moved = true;
                        }
                    }
                }
                if ui.button(t.cancel()).clicked() || escape {
                    close = true;
                }
            });
        });
        if moved || close || modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
        moved
    }
}
