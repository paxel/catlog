//! The home pane: the Clowders of the open Catalog as rows with their
//! faces and counts, favourites first right after the Strays. A tap
//! opens, a right-click holds the secondary actions, the star marks a
//! favourite.

use catlog_core::{Catalog, EntityView};
use egui::{Ui, Vec2};

use crate::l10n::L10n;
use crate::textures::FaceCache;

/// What is selected in the list pane.
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub enum Selection {
    #[default]
    None,
    Strays,
    Clowder(String),
    Cat(String),
    Map,
    Sync,
    Conflicts,
    Agenda,
    Duplicates,
    Moments,
    Archive,
    Backups,
    Restore,
    Moderation,
}

/// What the keeper did on the home pane this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum HomeAction {
    None,
    Open(Selection),
    ToggleFavourite(String),
    ToggleHidden(String),
    NewClowder,
}

/// One row as the pane draws it, worked out before drawing.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ClowderRow {
    pub view: EntityView,
    pub favourite: bool,
    pub hidden: bool,
    /// Profile image hashes of up to five of its Cats.
    pub faces: Vec<String>,
    pub cat_count: usize,
}

/// How many faces a row shows before the count takes over.
pub const FACES_SHOWN: usize = 5;

/// The rows in the order the pane shows them: favourites first, then
/// creation order; hidden ones only when asked for.
pub fn clowder_rows(store: &Catalog, show_hidden: bool) -> catlog_core::Result<Vec<ClowderRow>> {
    let mut rows = Vec::new();
    for view in store.clowders()? {
        let hidden = store.is_hidden(&view.id)?;
        if hidden && !show_hidden {
            continue;
        }
        let cats = store.cats(Some(&view.id))?;
        let mut faces = Vec::new();
        for cat in &cats {
            if faces.len() >= FACES_SHOWN {
                break;
            }
            if let Some(hash) = store.profile_image(&cat.id)? {
                faces.push(hash);
            }
        }
        rows.push(ClowderRow {
            favourite: store.local_setting(&format!("fav:{}", view.id)).as_deref() == Some("yes"),
            hidden,
            faces,
            cat_count: cats.len(),
            view,
        });
    }
    rows.sort_by_key(|r| !r.favourite);
    Ok(rows)
}

pub struct HomePane {
    pub selection: Selection,
    pub show_hidden: bool,
}

impl Default for HomePane {
    fn default() -> Self {
        HomePane {
            selection: Selection::None,
            show_hidden: false,
        }
    }
}

impl HomePane {
    /// Draws the pane into `ui` and says what the keeper did.
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
    ) -> HomeAction {
        let mut action = HomeAction::None;
        // A resizable panel shrinks to its content; the list claims the
        // whole pane so the width the keeper chose holds.
        ui.set_min_width(ui.available_width());
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        let rows = clowder_rows(store, self.show_hidden).unwrap_or_default();
        let strays = store.strays().map(|s| s.len()).unwrap_or(0);
        // The keyboard walks the list while nothing is being typed:
        // arrows move, Enter opens.
        if ui.ctx().memory(|m| m.focused()).is_none() {
            let (down, up, enter) = ui.input(|i| {
                (
                    i.key_pressed(egui::Key::ArrowDown),
                    i.key_pressed(egui::Key::ArrowUp),
                    i.key_pressed(egui::Key::Enter),
                )
            });
            let order: Vec<Selection> = std::iter::once(Selection::Strays)
                .chain(rows.iter().map(|r| Selection::Clowder(r.view.id.clone())))
                .collect();
            let at = order.iter().position(|s| *s == self.selection);
            if down || up {
                let next = match (at, down) {
                    (None, _) => 0,
                    (Some(i), true) => (i + 1).min(order.len() - 1),
                    (Some(i), false) => i.saturating_sub(1),
                };
                self.selection = order[next].clone();
                action = HomeAction::Open(self.selection.clone());
            } else if enter && at.is_some() {
                action = HomeAction::Open(self.selection.clone());
            }
        }
        ui.heading(if pet_mode {
            t.clowders_neutral()
        } else {
            t.clowders()
        });
        egui::ScrollArea::vertical().show(ui, |ui| {
            // The Strays lead: every Cat with no home right now.
            let selected = self.selection == Selection::Strays;
            let strays_label = format!("{}  ({strays})", t.strays());
            if ui.selectable_label(selected, strays_label).clicked() {
                self.selection = Selection::Strays;
                action = HomeAction::Open(Selection::Strays);
            }
            if rows.is_empty() {
                ui.add_space(8.0);
                ui.label(if pet_mode {
                    t.no_clowders_yet_neutral()
                } else {
                    t.no_clowders_yet()
                });
                ui.add_space(8.0);
                if ui
                    .button(if pet_mode {
                        t.new_clowder_neutral()
                    } else {
                        t.new_clowder()
                    })
                    .clicked()
                {
                    action = HomeAction::NewClowder;
                }
                return;
            }
            for row in &rows {
                let selected = self.selection == Selection::Clowder(row.view.id.clone());
                let response = ui
                    .horizontal(|ui| {
                        let name = if row.hidden {
                            egui::RichText::new(&row.view.name).weak()
                        } else {
                            egui::RichText::new(&row.view.name)
                        };
                        let label = ui.selectable_label(selected, name);
                        for hash in &row.faces {
                            if let Some(texture) = faces.face(ui.ctx(), store, hash) {
                                ui.add(
                                    egui::Image::from_texture(&texture)
                                        .fit_to_exact_size(Vec2::splat(24.0))
                                        .corner_radius(12.0),
                                );
                            }
                        }
                        // The number only says what the faces cannot: the
                        // rest past five.
                        if row.cat_count > FACES_SHOWN {
                            ui.label(format!("+{}", row.cat_count - FACES_SHOWN));
                        }
                        let star = if row.favourite { "★" } else { "☆" };
                        let tip = if row.favourite {
                            t.favourite_remove()
                        } else {
                            t.favourite_add()
                        };
                        if ui.button(star).on_hover_text(tip).clicked() {
                            action = HomeAction::ToggleFavourite(row.view.id.clone());
                        }
                        label
                    })
                    .inner;
                if response.clicked() {
                    self.selection = Selection::Clowder(row.view.id.clone());
                    action = HomeAction::Open(self.selection.clone());
                }
                response.context_menu(|ui| {
                    if ui.button(t.open()).clicked() {
                        self.selection = Selection::Clowder(row.view.id.clone());
                        action = HomeAction::Open(self.selection.clone());
                        ui.close();
                    }
                    let hide = if row.hidden {
                        t.unhide_label()
                    } else {
                        t.hide_label()
                    };
                    if ui.button(hide).clicked() {
                        action = HomeAction::ToggleHidden(row.view.id.clone());
                        ui.close();
                    }
                    let fav = if row.favourite {
                        t.favourite_remove()
                    } else {
                        t.favourite_add()
                    };
                    if ui.button(fav).clicked() {
                        action = HomeAction::ToggleFavourite(row.view.id.clone());
                        ui.close();
                    }
                });
            }
            ui.add_space(8.0);
            if ui
                .button(if pet_mode {
                    t.new_clowder_neutral()
                } else {
                    t.new_clowder()
                })
                .clicked()
            {
                action = HomeAction::NewClowder;
            }
        });
        action
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn rows_put_favourites_first_and_count_past_five_faces() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_clowder("clowder:a", "Alpha").unwrap();
        store.create_clowder("clowder:b", "Beta").unwrap();
        store.create_clowder("clowder:h", "Hidden").unwrap();
        for i in 0..7 {
            let id = format!("cat:{i}");
            store
                .create_cat(&id, &format!("Cat {i}"), Some("clowder:a"), "cat")
                .unwrap();
            store
                .add_image(&id, format!("photo {i}").as_bytes())
                .unwrap();
        }
        store.set_local_setting("fav:clowder:b", "yes").unwrap();
        store.set_hidden("clowder:h", true).unwrap();
        let rows = clowder_rows(&store, false).unwrap();
        assert_eq!(
            rows.iter()
                .map(|r| r.view.name.as_str())
                .collect::<Vec<_>>(),
            vec!["Beta", "Alpha"]
        );
        assert!(rows[0].favourite && !rows[1].favourite);
        assert_eq!(rows[1].faces.len(), FACES_SHOWN);
        assert_eq!(rows[1].cat_count, 7);
        let all = clowder_rows(&store, true).unwrap();
        assert_eq!(all.len(), 3);
        assert!(all[2].hidden);
    }
}
