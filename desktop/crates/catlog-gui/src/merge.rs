//! Two records become one, and records cross to another Catalog: the
//! Merge dialog with its survivor choice and one confirmation, and the
//! Transfer dialog.

use catlog_core::catalogs::CatalogManager;
use catlog_core::{Catalog, keys};
use egui::Context;

use crate::l10n::L10n;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MergeKind {
    Cat,
    Clowder,
    Field,
}

impl MergeKind {
    pub fn words(self, t: &L10n) -> &'static str {
        match self {
            MergeKind::Cat => t.kind_cat(),
            MergeKind::Clowder => t.kind_clowder(),
            MergeKind::Field => t.kind_field(),
        }
    }
}

/// The Merge dialog: which record survives, then one confirmation
/// with the blast radius spelled out.
#[derive(Debug, Default)]
pub struct MergeDialog {
    pub open: bool,
    pub kind: Option<MergeKind>,
    /// The record being merged away, when the dialog started from one.
    pub loser: Option<String>,
    /// The records offered as survivor: id and name.
    pub candidates: Vec<(String, String)>,
    pub survivor: Option<String>,
    pub confirming: bool,
    id: u64,
}

fn name_of(store: &Catalog, t: &L10n, id: &str) -> String {
    store
        .current(id, keys::NAME)
        .ok()
        .flatten()
        .unwrap_or_else(|| t.unnamed().to_string())
}

impl MergeDialog {
    /// Two records that may be one: either can survive.
    pub fn ask_pair(&mut self, store: &Catalog, t: &L10n, a: &str, b: &str, kind: MergeKind) {
        self.kind = Some(kind);
        self.loser = None;
        self.candidates = vec![
            (a.to_string(), name_of(store, t, a)),
            (b.to_string(), name_of(store, t, b)),
        ];
        self.survivor = None;
        self.confirming = false;
        self.open = true;
        self.id += 1;
    }

    /// "Merge this … into…": every other record of the kind is offered.
    /// Nothing opens when there is none.
    pub fn ask_into(&mut self, store: &Catalog, loser: &str, kind: MergeKind) -> bool {
        let others: Vec<(String, String)> = match kind {
            MergeKind::Cat => store
                .cats(None)
                .unwrap_or_default()
                .into_iter()
                .map(|v| (v.id, v.name))
                .collect(),
            MergeKind::Clowder => store
                .clowders()
                .unwrap_or_default()
                .into_iter()
                .map(|v| (v.id, v.name))
                .collect(),
            MergeKind::Field => store
                .field_defs(None)
                .unwrap_or_default()
                .into_iter()
                .map(|d| (d.id, d.name))
                .collect(),
        };
        let others: Vec<(String, String)> =
            others.into_iter().filter(|(id, _)| id != loser).collect();
        if others.is_empty() {
            return false;
        }
        self.kind = Some(kind);
        self.loser = Some(loser.to_string());
        self.candidates = others;
        self.survivor = None;
        self.confirming = false;
        self.open = true;
        self.id += 1;
        true
    }

    /// The pair to merge: loser, survivor.
    pub fn decision(&self) -> Option<(String, String)> {
        let survivor = self.survivor.clone()?;
        let loser = match &self.loser {
            Some(l) => l.clone(),
            None => self
                .candidates
                .iter()
                .map(|(id, _)| id.clone())
                .find(|id| *id != survivor)?,
        };
        Some((loser, survivor))
    }

    /// Draws the dialog; loser, survivor and kind once confirmed.
    pub fn show(&mut self, ctx: &Context, t: &L10n) -> Option<(String, String, MergeKind)> {
        if !self.open {
            return None;
        }
        let kind = self.kind.unwrap_or(MergeKind::Cat);
        let mut result = None;
        let mut close = false;
        let survivor_name = self
            .survivor
            .as_ref()
            .and_then(|s| self.candidates.iter().find(|(id, _)| id == s))
            .map(|(_, n)| n.clone())
            .unwrap_or_default();
        let title = if self.confirming {
            t.merge_into_question(&survivor_name)
        } else if self.loser.is_some() {
            t.merge_this_into(kind.words(t))
        } else {
            t.merge_into().to_string()
        };
        let modal = egui::Modal::new(egui::Id::new(("merge-dialog", self.id))).show(ctx, |ui| {
            ui.set_max_width(420.0);
            ui.heading(title);
            if self.confirming {
                ui.label(t.merge_body(&survivor_name));
                ui.horizontal(|ui| {
                    if ui.button(t.merge()).clicked()
                        && let Some((loser, survivor)) = self.decision()
                    {
                        result = Some((loser, survivor, kind));
                    }
                    if ui.button(t.cancel()).clicked() {
                        close = true;
                    }
                });
            } else {
                egui::ScrollArea::vertical()
                    .max_height(300.0)
                    .show(ui, |ui| {
                        for (id, name) in &self.candidates {
                            ui.radio_value(&mut self.survivor, Some(id.clone()), name.as_str());
                        }
                    });
                ui.horizontal(|ui| {
                    if ui
                        .add_enabled(self.survivor.is_some(), egui::Button::new(t.merge_into()))
                        .clicked()
                    {
                        self.confirming = true;
                    }
                    if ui.button(t.cancel()).clicked() {
                        close = true;
                    }
                });
            }
        });
        if result.is_some() || close || modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
        result
    }
}

/// Runs the merge the dialog decided.
pub fn apply_merge(
    store: &mut Catalog,
    loser: &str,
    survivor: &str,
    kind: MergeKind,
) -> catlog_core::Result<()> {
    match kind {
        MergeKind::Cat => store.merge_cat(loser, survivor),
        MergeKind::Clowder => store.merge_clowder(loser, survivor),
        MergeKind::Field => store.merge_field(loser, survivor),
    }
}

/// Moves Clowders with their Cats, or Strays, into another Catalog.
#[derive(Debug, Default)]
pub struct TransferDialog {
    pub open: bool,
    /// The other Catalogs: id and name.
    pub targets: Vec<(String, String)>,
    pub target: Option<String>,
    /// What can move: id, name, is a Clowder, chosen.
    pub options: Vec<(String, String, bool, bool)>,
    id: u64,
}

impl TransferDialog {
    /// Opens when there is another Catalog and something to move.
    pub fn ask(&mut self, manager: &CatalogManager, store: &Catalog) -> bool {
        let active = manager.active().id.clone();
        self.targets = manager
            .catalogs()
            .iter()
            .filter(|c| c.id != active)
            .map(|c| (c.id.clone(), c.name.clone()))
            .collect();
        self.options = Vec::new();
        for c in store.clowders().unwrap_or_default() {
            self.options.push((c.id, c.name, true, false));
        }
        for c in store.strays().unwrap_or_default() {
            self.options.push((c.id, c.name, false, false));
        }
        if self.targets.is_empty() || self.options.is_empty() {
            return false;
        }
        self.target = (self.targets.len() == 1).then(|| self.targets[0].0.clone());
        self.open = true;
        self.id += 1;
        true
    }

    pub fn chosen(&self) -> Vec<String> {
        self.options
            .iter()
            .filter(|(_, _, _, on)| *on)
            .map(|(id, _, _, _)| id.clone())
            .collect()
    }

    /// Draws the dialog; the target Catalog and the ids once confirmed.
    pub fn show(&mut self, ctx: &Context, t: &L10n) -> Option<(String, Vec<String>)> {
        if !self.open {
            return None;
        }
        let mut result = None;
        let mut close = false;
        let modal = egui::Modal::new(egui::Id::new(("transfer-dialog", self.id))).show(ctx, |ui| {
            ui.set_max_width(420.0);
            ui.heading(t.move_to_catalog());
            ui.strong(t.menu_catalog());
            for (id, name) in &self.targets {
                ui.radio_value(&mut self.target, Some(id.clone()), name.as_str());
            }
            ui.add_space(6.0);
            ui.strong(t.choose_what_to_move());
            egui::ScrollArea::vertical()
                .max_height(240.0)
                .show(ui, |ui| {
                    for (_, name, is_clowder, on) in &mut self.options {
                        let label = if *is_clowder {
                            format!("{name} ({})", t.kind_clowder())
                        } else {
                            format!("{name} ({})", t.stray())
                        };
                        ui.checkbox(on, label);
                    }
                });
            ui.horizontal(|ui| {
                let ready = self.target.is_some() && !self.chosen().is_empty();
                if ui
                    .add_enabled(ready, egui::Button::new(t.move_to_catalog()))
                    .clicked()
                    && let Some(target) = self.target.clone()
                {
                    result = Some((target, self.chosen()));
                }
                if ui.button(t.cancel()).clicked() {
                    close = true;
                }
            });
        });
        if result.is_some() || close || modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
        result
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_merge_dialog_knows_loser_and_survivor_either_way() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        store.create_cat("cat:b", "Mietzi", None, "cat").unwrap();
        let t = L10n::new("en");
        let mut d = MergeDialog::default();
        d.ask_pair(&store, &t, "cat:a", "cat:b", MergeKind::Cat);
        assert!(d.open);
        assert_eq!(d.decision(), None);
        d.survivor = Some("cat:b".into());
        assert_eq!(d.decision(), Some(("cat:a".into(), "cat:b".into())));
        assert!(d.ask_into(&store, "cat:a", MergeKind::Cat));
        assert_eq!(
            d.candidates,
            vec![("cat:b".to_string(), "Mietzi".to_string())]
        );
        d.survivor = Some("cat:b".into());
        assert_eq!(d.decision(), Some(("cat:a".into(), "cat:b".into())));
        assert!(
            !d.ask_into(&store, "clowder:none", MergeKind::Clowder),
            "nothing to merge into"
        );
        assert!(d.ask_into(&store, "fielddef:name", MergeKind::Field));
        assert!(!d.candidates.iter().any(|(id, _)| id == "fielddef:name"));
        apply_merge(&mut store, "cat:a", "cat:b", MergeKind::Cat).unwrap();
        assert_eq!(store.cats(None).unwrap().len(), 1);
    }
}
