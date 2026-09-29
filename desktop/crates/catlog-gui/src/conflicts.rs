//! Conflicts: a Field changed in two places at once. The page lists
//! them, each row carrying its two values as buttons; a click writes
//! the decision as an entry of its own and clears the flag. The same
//! buttons sit on the arrival summary's rows.

use catlog_core::Entry;
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, keys};
use egui::Ui;

use crate::l10n::L10n;
use crate::labels::{field_label, format_day, value_label};

/// The two entries of an open conflict, newest first.
pub fn candidates(store: &Catalog, entity: &str, field: &str) -> Vec<Entry> {
    store
        .field_history(entity, field, false)
        .unwrap_or_default()
        .into_iter()
        .take(2)
        .collect()
}

/// Both entries carry the same value: nothing to pick.
pub fn same(candidates: &[Entry]) -> bool {
    let mut values: Vec<&Option<String>> = candidates.iter().map(|e| &e.value).collect();
    values.dedup();
    values.len() <= 1
}

/// Writes the decision: the kept value when it differs from what
/// stands, then the flag cleared. `kept` is the entry's seq; none for
/// a conflict with nothing to pick.
pub fn resolve(
    store: &mut Catalog,
    entity: &str,
    field: &str,
    kept: Option<i64>,
) -> catlog_core::Result<()> {
    let candidates = candidates(store, entity, field);
    let picked = candidates
        .iter()
        .find(|e| Some(e.seq) == kept)
        .and_then(|e| e.value.clone());
    let current = store.current(entity, field)?;
    if !same(&candidates) && kept.is_some() && picked != current {
        store.append(entity, field, picked.as_deref())?;
    }
    store.resolve_conflict(entity, field)
}

/// The choice on a conflict's row: one button per value with its day
/// and author, or the sentence and Resolve when both say the same.
/// `Some(kept)` on a click, the seq to keep or none.
pub fn choice(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    units: UnitSystem,
    entity: &str,
    field: &str,
) -> Option<Option<i64>> {
    let candidates = candidates(store, entity, field);
    let mut clicked = None;
    if same(&candidates) {
        let value = candidates.first().and_then(|e| e.value.as_deref());
        ui.label(t.conflict_same(&value_label(t, store, field, value, units)));
        if ui.button(t.resolve()).clicked() {
            clicked = Some(None);
        }
        return clicked;
    }
    ui.horizontal(|ui| {
        for e in &candidates {
            let day = e
                .date
                .get(..10)
                .and_then(|d| d.parse::<chrono::NaiveDate>().ok())
                .map(|d| format_day(t.locale(), d))
                .unwrap_or_else(|| e.date.clone());
            let label = format!(
                "{}   ({day} · {})",
                value_label(t, store, field, e.value.as_deref(), units),
                e.author
            );
            if ui.button(label).clicked() {
                clicked = Some(Some(e.seq));
            }
        }
    });
    clicked
}

/// The Conflicts page: one row per open conflict, the choice on it.
/// The decision made this frame, when one was.
pub fn show_conflicts(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    units: UnitSystem,
) -> Option<(String, String, Option<i64>)> {
    let mut decided = None;
    ui.heading(t.summary_conflicts());
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
        ui.add_space(6.0);
        ui.strong(format!("{name} — {}", field_label(t, store, &field)));
        if let Some(kept) = choice(ui, store, t, units, &entity, &field) {
            decided = Some((entity.clone(), field.clone(), kept));
        }
    }
    decided
}
