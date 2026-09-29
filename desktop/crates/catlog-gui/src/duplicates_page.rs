//! The duplicates page: records that may be one, and match candidates
//! for a Missing Cat.

use catlog_core::duplicates::{DuplicateKind, MatchReason};
use catlog_core::{Catalog, keys};
use egui::Ui;

use crate::l10n::L10n;
use crate::labels::{field_def_name, field_label};
use crate::merge::MergeKind;

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum DuplicatesAction {
    None,
    Merge(String, String, MergeKind),
    /// These two are not the same, remember that.
    Reject(String, String),
}

pub fn show_duplicates(ui: &mut Ui, store: &Catalog, t: &L10n) -> DuplicatesAction {
    let mut action = DuplicatesAction::None;
    let name_of = |id: &str| {
        if id.starts_with("fielddef:") {
            return store
                .current(id, keys::NAME)
                .ok()
                .flatten()
                .unwrap_or_else(|| id.to_string());
        }
        store
            .current(id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string())
    };
    egui::ScrollArea::vertical().show(ui, |ui| {
        ui.heading(t.find_duplicates());
        let duplicates = store.duplicate_candidates().unwrap_or_default();
        if duplicates.is_empty() {
            ui.label(t.no_duplicates());
        }
        for d in &duplicates {
            let kind = match d.kind {
                DuplicateKind::Cats => MergeKind::Cat,
                DuplicateKind::Clowders => MergeKind::Clowder,
                DuplicateKind::Fields => MergeKind::Field,
            };
            let reasons: Vec<String> = d
                .matched
                .iter()
                .map(|key| {
                    if key == keys::NAME {
                        if d.tier == catlog_core::duplicates::DuplicateTier::Exact {
                            t.label_name().to_string()
                        } else {
                            t.similar_name().to_string()
                        }
                    } else {
                        t.same_id_field(&field_label(t, store, key))
                    }
                })
                .collect();
            ui.horizontal(|ui| {
                ui.label(format!(
                    "{} · {} ({})",
                    name_of(&d.a),
                    name_of(&d.b),
                    kind.words(t)
                ));
                if ui.button(t.merge_into()).clicked() {
                    action = DuplicatesAction::Merge(d.a.clone(), d.b.clone(), kind);
                }
            });
            ui.label(egui::RichText::new(reasons.join(" · ")).weak());
        }
        ui.add_space(12.0);
        ui.heading(t.match_candidates_title());
        let matches = store.match_candidates().unwrap_or_default();
        if matches.is_empty() {
            ui.label(t.no_match_candidates());
        }
        for m in &matches {
            let mut reason = match &m.reason {
                MatchReason::IdExact(def) => t.same_id_field(&field_def_name(t, def)),
                MatchReason::Geo => String::new(),
                MatchReason::Looks(groups) => {
                    let weight: i32 = groups
                        .iter()
                        .map(|g| catlog_core::duplicates::looks_group_weight(g))
                        .sum();
                    t.traits_agree(weight as i64)
                }
            };
            if let Some(d) = m.distance_meters {
                if !reason.is_empty() {
                    reason.push_str(" · ");
                }
                reason.push_str(&t.meters_apart(&format!("{}", d.round() as i64)));
            }
            ui.horizontal(|ui| {
                ui.label(format!("{} · {}", name_of(&m.a), name_of(&m.b)));
                if ui.button(t.merge_into()).clicked() {
                    action = DuplicatesAction::Merge(m.a.clone(), m.b.clone(), MergeKind::Cat);
                }
                if matches!(m.reason, MatchReason::Looks(_))
                    && ui.button(t.reject_match()).clicked()
                {
                    action = DuplicatesAction::Reject(m.a.clone(), m.b.clone());
                }
            });
            ui.label(egui::RichText::new(reason).weak());
        }
    });
    action
}
