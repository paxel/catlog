//! Conflicts: a Field changed in two places at once. The page lists
//! them; the dialog shows the two entries and writes the decision as an
//! entry of its own, then clears the flag.

use catlog_core::Entry;
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, keys};
use egui::{Context, Ui};

use crate::l10n::L10n;
use crate::labels::{field_label, format_day, value_label};

/// The Conflicts page: one row per open conflict, a click opens it.
pub fn show_conflicts(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    units: UnitSystem,
) -> Option<(String, String)> {
    let mut open = None;
    ui.heading(t.summary_conflicts());
    ui.label(t.conflict_body());
    let conflicts = store.conflicts().unwrap_or_default();
    if conflicts.is_empty() {
        ui.label(t.none_label());
    }
    for (entity, field) in conflicts {
        let name = store
            .current(&entity, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string());
        let history = store
            .field_history(&entity, &field, false)
            .unwrap_or_default();
        let values: Vec<String> = history
            .iter()
            .take(2)
            .map(|e| {
                format!(
                    "{} ({})",
                    value_label(t, store, &field, e.value.as_deref(), units),
                    e.author
                )
            })
            .collect();
        let title = format!("{name} — {}", field_label(t, store, &field));
        if ui.link(&title).clicked() {
            open = Some((entity.clone(), field.clone()));
        }
        ui.label(egui::RichText::new(values.join(" · ")).weak());
    }
    open
}

/// The dialog over one conflict.
#[derive(Debug, Default)]
pub struct ConflictDialog {
    pub open: bool,
    pub entity: String,
    pub field: String,
    pub candidates: Vec<Entry>,
    /// The chosen entry's seq.
    pub chosen: Option<i64>,
    id: u64,
}

impl ConflictDialog {
    pub fn ask(&mut self, store: &Catalog, entity: &str, field: &str) {
        self.candidates = store
            .field_history(entity, field, false)
            .unwrap_or_default()
            .into_iter()
            .take(2)
            .collect();
        self.chosen = self.candidates.first().map(|e| e.seq);
        self.entity = entity.to_string();
        self.field = field.to_string();
        self.open = true;
        self.id += 1;
    }

    /// Both entries carry the same value: nothing to pick.
    pub fn same(&self) -> bool {
        let mut values: Vec<&Option<String>> = self.candidates.iter().map(|e| &e.value).collect();
        values.dedup();
        values.len() <= 1
    }

    /// Writes the decision: the picked value when it differs from what
    /// stands, then the flag cleared.
    pub fn resolve(&self, store: &mut Catalog) -> catlog_core::Result<()> {
        let picked = self
            .candidates
            .iter()
            .find(|e| Some(e.seq) == self.chosen)
            .and_then(|e| e.value.clone());
        let current = store.current(&self.entity, &self.field)?;
        if !self.same() && picked != current {
            store.append(&self.entity, &self.field, picked.as_deref())?;
        }
        store.resolve_conflict(&self.entity, &self.field)
    }

    /// Draws the dialog; true once it resolved the conflict.
    pub fn show(
        &mut self,
        ctx: &Context,
        store: &mut Catalog,
        t: &L10n,
        units: UnitSystem,
    ) -> bool {
        if !self.open {
            return false;
        }
        let mut resolved = false;
        let mut close = false;
        let title = t.conflict_on(&field_label(t, store, &self.field));
        egui::Window::new(title)
            .id(egui::Id::new(("conflict-dialog", self.id)))
            .collapsible(false)
            .resizable(false)
            .anchor(egui::Align2::CENTER_CENTER, egui::vec2(0.0, 0.0))
            .show(ctx, |ui| {
                ui.set_max_width(420.0);
                if self.same() {
                    let value = self.candidates.first().and_then(|e| e.value.as_deref());
                    ui.label(t.conflict_same(&value_label(t, store, &self.field, value, units)));
                } else {
                    ui.label(t.conflict_body());
                    for e in &self.candidates {
                        let day = e
                            .date
                            .get(..10)
                            .and_then(|d| d.parse::<chrono::NaiveDate>().ok())
                            .map(|d| format_day(t.locale(), d))
                            .unwrap_or_else(|| e.date.clone());
                        let label = format!(
                            "{}   ({day} · {})",
                            value_label(t, store, &self.field, e.value.as_deref(), units),
                            e.author
                        );
                        ui.radio_value(&mut self.chosen, Some(e.seq), label);
                    }
                }
                let escape = ui.input(|i| i.key_pressed(egui::Key::Escape));
                ui.horizontal(|ui| {
                    if ui.button(t.resolve()).clicked() {
                        resolved = true;
                    }
                    if ui.button(t.cancel()).clicked() || escape {
                        close = true;
                    }
                });
            });
        if resolved {
            if let Err(e) = self.resolve(store) {
                eprintln!("catlog: {e}");
            }
            self.open = false;
        }
        if close {
            self.open = false;
        }
        resolved
    }
}
