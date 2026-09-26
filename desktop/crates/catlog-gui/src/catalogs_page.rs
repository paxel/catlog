//! The Catalogs page: every Catalog this device holds on the left, what
//! can be done with the chosen one on the right. Creating, switching,
//! renaming, deleting and the shared folder all live here, where the
//! phone has its Catalogs screen; before this they were scattered
//! through the menus and cost a great many clicks.

use catlog_core::Catalog;
use catlog_core::catalogs::CatalogManager;
use egui::Ui;

use crate::l10n::L10n;
use crate::theme::PALETTE;

/// What the keeper asked the page for.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CatalogsAction {
    None,
    /// Open this Catalog.
    Switch(String),
    NewCatalog,
    /// Give the open Catalog another name.
    Rename,
    /// Delete this Catalog, after the confirmation the app asks for.
    Delete(String),
    /// Choose the folder the open Catalog syncs through.
    ChooseFolder,
    /// Sync through no folder any more.
    StopSharing,
}

/// Which Catalog the right half is about; the open one until another is
/// picked.
#[derive(Debug, Default)]
pub struct CatalogsPage {
    pub chosen: Option<String>,
}

impl CatalogsPage {
    pub fn show(
        &mut self,
        ui: &mut Ui,
        manager: &CatalogManager,
        store: &Catalog,
        t: &L10n,
    ) -> CatalogsAction {
        let mut action = CatalogsAction::None;
        let active = manager.active().id.clone();
        let chosen = self
            .chosen
            .clone()
            .filter(|id| manager.by_id(id).is_some())
            .unwrap_or_else(|| active.clone());
        ui.set_min_width(640.0);
        ui.heading(t.catalogs_title());
        ui.add_space(8.0);
        ui.horizontal_top(|ui| {
            ui.allocate_ui_with_layout(
                egui::vec2(220.0, 0.0),
                egui::Layout::top_down(egui::Align::LEFT),
                |ui| {
                    ui.set_min_width(220.0);
                    for info in manager.catalogs() {
                        let label = if info.id == active {
                            egui::RichText::new(&info.name).strong()
                        } else {
                            egui::RichText::new(&info.name)
                        };
                        if ui
                            .selectable_label(info.id == chosen, label)
                            .on_hover_text(if info.id == active {
                                t.catalog_active()
                            } else {
                                t.switch_to_catalog()
                            })
                            .clicked()
                        {
                            self.chosen = Some(info.id.clone());
                        }
                    }
                    ui.add_space(8.0);
                    if crate::icons::button(
                        ui,
                        crate::icons::CREATE_NEW_FOLDER_OUTLINED,
                        t.new_catalog(),
                    )
                    .clicked()
                    {
                        action = CatalogsAction::NewCatalog;
                    }
                },
            );
            ui.separator();
            ui.vertical(|ui| {
                let Some(info) = manager.by_id(&chosen) else {
                    return;
                };
                ui.heading(&info.name);
                if chosen == active {
                    // Only the open Catalog's own settings can be read:
                    // the others' stores are not loaded.
                    ui.label(egui::RichText::new(t.catalog_active()).weak());
                    ui.add_space(8.0);
                    if crate::icons::button(
                        ui,
                        crate::icons::DRIVE_FILE_RENAME_OUTLINE,
                        t.rename_catalog(),
                    )
                    .clicked()
                    {
                        action = CatalogsAction::Rename;
                    }
                    ui.add_space(12.0);
                    ui.label(egui::RichText::new(t.shared_folder()).strong());
                    match store.sync_folder_path() {
                        Some(path) => {
                            ui.label(path.to_string_lossy());
                            ui.horizontal(|ui| {
                                if ui.button(t.shared_folder()).clicked() {
                                    action = CatalogsAction::ChooseFolder;
                                }
                                if ui.button(t.stop_sharing()).clicked() {
                                    action = CatalogsAction::StopSharing;
                                }
                            });
                        }
                        None => {
                            ui.label(egui::RichText::new(t.not_shared()).weak());
                            if ui.button(t.shared_folder()).clicked() {
                                action = CatalogsAction::ChooseFolder;
                            }
                        }
                    }
                } else {
                    ui.add_space(8.0);
                    if crate::icons::button(ui, crate::icons::LOGOUT, t.switch_to_catalog())
                        .clicked()
                    {
                        action = CatalogsAction::Switch(info.id.clone());
                    }
                }
                ui.add_space(16.0);
                // The Catalog being worked in cannot go: switch away
                // first, as the phone has it.
                let can_delete = manager.catalogs().len() > 1 && chosen != active;
                let delete = ui
                    .add_enabled(
                        can_delete,
                        egui::Button::new(
                            egui::RichText::new(t.delete_catalog()).color(PALETTE.red),
                        ),
                    )
                    .on_disabled_hover_text(t.switch_before_deleting());
                if delete.clicked() {
                    action = CatalogsAction::Delete(info.id.clone());
                }
            });
        });
        action
    }
}
