//! "What arrived": the window after a sync round or a bundle import,
//! with the new, updated and deleted Cats and Clowders, the conflicts
//! raised, what was refused, and the smaller things. Reject puts the
//! Catalog back as it was.

use catlog_core::Entry;
use catlog_core::review::{ImportReview, MetaChange, needs_attention};
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, keys};
use egui::Context;

use crate::l10n::L10n;
use crate::labels::{field_label, value_label};

/// What the keeper did in the summary window this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum SummaryAction {
    None,
    /// Drop what arrived.
    Reject,
    /// A conflict decided on its row: the entry to keep, none when
    /// both said the same.
    Resolve(String, String, Option<i64>),
    OpenEntity(String),
}

#[derive(Debug, Default)]
pub struct ArrivalSummary {
    pub open: bool,
    pub review: ImportReview,
    pub applied: Vec<Entry>,
    id: u64,
}

impl ArrivalSummary {
    /// Opens the window over what one import brought.
    pub fn open_with(&mut self, review: ImportReview, applied: Vec<Entry>) {
        self.review = review;
        self.applied = applied;
        self.open = true;
        self.id += 1;
    }

    pub fn show(
        &mut self,
        ctx: &Context,
        store: &Catalog,
        t: &L10n,
        units: UnitSystem,
    ) -> SummaryAction {
        if !self.open {
            return SummaryAction::None;
        }
        let mut action = SummaryAction::None;
        let name_of = |id: &str| {
            store
                .current(id, keys::NAME)
                .ok()
                .flatten()
                .unwrap_or_else(|| t.unnamed().to_string())
        };
        let modal = egui::Modal::new(egui::Id::new(("arrival-summary", self.id))).show(ctx, |ui| {
            ui.set_max_width(520.0);
            ui.heading(t.sync_summary_title());
            egui::ScrollArea::vertical()
                .max_height(480.0)
                .show(ui, |ui| {
                    ui.label(t.arrival_intro());
                    let review = &self.review;
                    let sections = [
                        (t.summary_new(), &review.new_ones),
                        (t.summary_updated(), &review.updated),
                        (t.summary_deleted(), &review.deleted),
                    ];
                    for (title, arrivals) in sections {
                        if arrivals.is_empty() {
                            continue;
                        }
                        ui.add_space(6.0);
                        ui.strong(title);
                        for a in arrivals {
                            ui.horizontal(|ui| {
                                if ui.link(name_of(&a.id)).clicked() {
                                    action = SummaryAction::OpenEntity(a.id.clone());
                                }
                                let mut tags: Vec<&str> = Vec::new();
                                for tag in &a.tags {
                                    tags.push(match tag.as_str() {
                                        "adopted" => t.summary_adopted(),
                                        "deceased" => t.summary_deceased(),
                                        _ => t.summary_escaped(),
                                    });
                                }
                                if !tags.is_empty() {
                                    ui.label(egui::RichText::new(tags.join(", ")).weak());
                                }
                            });
                            if !a.is_new {
                                for c in a.changes.iter().filter(|c| !c.is_photo()) {
                                    ui.label(format!(
                                        "    {}: {} → {}",
                                        field_label(t, store, &c.field),
                                        value_label(t, store, &c.field, c.before.as_deref(), units),
                                        value_label(t, store, &c.field, c.after.as_deref(), units)
                                    ));
                                }
                            }
                        }
                    }
                    // The conflicts still open, each with its two values as
                    // buttons right here; a decided one leaves the list.
                    let open: Vec<&(String, String)> = review
                        .conflicts
                        .iter()
                        .filter(|(e, f)| store.has_conflict(e, f).unwrap_or(false))
                        .collect();
                    if !open.is_empty() {
                        ui.add_space(6.0);
                        ui.strong(t.summary_conflicts());
                        for (entity, field) in open {
                            ui.label(format!(
                                "{} — {}",
                                name_of(entity),
                                field_label(t, store, field)
                            ));
                            if let Some(kept) =
                                crate::conflicts::choice(ui, store, t, units, entity, field)
                            {
                                action =
                                    SummaryAction::Resolve(entity.clone(), field.clone(), kept);
                            }
                        }
                    }
                    if needs_attention(&review.report) {
                        ui.add_space(6.0);
                        ui.strong(t.summary_refused());
                        for ((author, _device), count) in &review.report.refused {
                            ui.label(t.refused_entries(*count as i64, author));
                        }
                        for (name, device) in &review.report.impostors {
                            ui.label(t.new_key_calls_itself(&key_code_of(device), name));
                        }
                        for device in &review.report.changed_keys {
                            ui.label(t.key_changed_refused(&key_code_of(device)));
                        }
                    }
                    if !review.meta.is_empty() || !review.report.new_keys.is_empty() {
                        ui.add_space(6.0);
                        ui.strong(t.summary_meta());
                        for m in &review.meta {
                            let line = match m {
                                MetaChange::FieldAdded(id) => {
                                    t.meta_field_added(&field_name(store, id))
                                }
                                MetaChange::FieldChanged(id) => {
                                    t.meta_field_changed(&field_name(store, id))
                                }
                                MetaChange::FieldMerged(id, target)
                                | MetaChange::Merged(id, target) => {
                                    t.meta_merged(&name_of(id), &name_of(target))
                                }
                                MetaChange::Mode => t.catalog_settings().to_string(),
                                MetaChange::Photos(n) => t.meta_photos(*n as i64),
                            };
                            ui.label(line);
                        }
                        for k in &review.report.new_keys {
                            ui.label(t.new_key_pinned(&key_code_of(&k.record.device)));
                        }
                    }
                });
            ui.separator();
            ui.horizontal(|ui| {
                if ui
                    .add_enabled(
                        !self.applied.is_empty(),
                        egui::Button::new(t.reject_arrival()),
                    )
                    .clicked()
                {
                    action = SummaryAction::Reject;
                }
                if ui.button(t.close()).clicked() {
                    action = SummaryAction::None;
                    self.open = false;
                }
            });
        });
        if modal.should_close() {
            self.open = false;
        }
        if action != SummaryAction::None {
            self.open = false;
        }
        if !self.open {
            ctx.request_repaint();
        }
        action
    }
}

/// A device's short code, as the phone shows it: the first eight hex
/// digits of its id, which is the key's fingerprint.
fn key_code_of(device: &str) -> String {
    if device.len() >= 8 {
        format!("{}-{}", &device[..4], &device[4..8])
    } else {
        device.to_string()
    }
}

/// A Field definition's name from its entity id.
fn field_name(store: &Catalog, id: &str) -> String {
    store
        .current(id, keys::NAME)
        .ok()
        .flatten()
        .unwrap_or_else(|| id.to_string())
}
