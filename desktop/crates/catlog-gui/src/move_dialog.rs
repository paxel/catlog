//! Moving a Cat: into a Clowder, or out to the street as a Stray, as of
//! a day the keeper may set back.

use catlog_core::{Catalog, EntityView, keys};
use egui::{Context, Key};

use crate::l10n::L10n;

#[derive(Default)]
pub struct MoveDialog {
    pub open: bool,
    pub cat: String,
    pub current: Option<String>,
    pub clowders: Vec<EntityView>,
    /// The chosen destination; none for the street.
    pub target: Option<String>,
    pub as_of: String,
    id: u64,
}

impl MoveDialog {
    pub fn ask(&mut self, store: &Catalog, cat: &str) {
        self.open = true;
        self.id += 1;
        self.cat = cat.to_string();
        self.current = store.current(cat, keys::CLOWDER).ok().flatten();
        self.clowders = store.clowders().unwrap_or_default();
        self.target = self.current.clone();
        self.as_of = chrono::Local::now().date_naive().to_string();
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
                let label = if Some(&c.id) == self.current.as_ref() {
                    format!("✓ {}", c.name)
                } else {
                    c.name.clone()
                };
                if ui
                    .radio(self.target.as_deref() == Some(c.id.as_str()), label)
                    .clicked()
                {
                    self.target = Some(c.id.clone());
                }
            }
            if ui
                .radio(self.target.is_none(), t.no_clowder_stray_option())
                .clicked()
            {
                self.target = None;
            }
            ui.horizontal(|ui| {
                ui.label(t.as_of_date(""));
                ui.add(egui::TextEdit::singleline(&mut self.as_of).desired_width(100.0));
            });
            let escape = ui.input(|i| i.key_pressed(Key::Escape));
            ui.horizontal(|ui| {
                let changed = self.target != self.current;
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
                    if store
                        .append_at(
                            &self.cat,
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
