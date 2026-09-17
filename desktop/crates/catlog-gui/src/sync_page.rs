//! The Sync page: the shared folder with its switches and the round
//! button, and the `.catsync` bundle files for partners without a
//! shared folder.

use catlog_core::Catalog;
use catlog_core::sync::{SYNC_AUTO, SYNC_FOLDER_LAST, SYNC_PRIVATE, SYNC_WATCH};
use egui::Ui;

use crate::l10n::L10n;

/// What the keeper asked for on the Sync page this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum SyncAction {
    None,
    ChooseFolder,
    /// Use the folder chosen last for another Catalog.
    UseLastFolder(String),
    SyncNow,
    ExportBundle,
    ImportBundle,
}

/// The page's own state: what the last rounds said.
#[derive(Debug, Default)]
pub struct SyncPage {
    /// A round is due on the next frame, so the label paints first.
    pub syncing: bool,
    pub folder_result: Option<String>,
    pub bundle_result: Option<String>,
}

impl SyncPage {
    pub fn show(&mut self, ui: &mut Ui, store: &Catalog, t: &L10n) -> SyncAction {
        let mut action = SyncAction::None;
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.heading(t.sync());
            ui.add_space(8.0);
            ui.strong(t.shared_folder());
            ui.label(t.shared_folder_explainer());
            let folder = store.sync_folder_path();
            ui.horizontal(|ui| {
                match &folder {
                    Some(path) => ui.label(path.to_string_lossy().into_owned()),
                    None => ui.label(t.no_folder_chosen_yet()),
                };
                if ui.button(t.choose()).clicked() {
                    action = SyncAction::ChooseFolder;
                }
            });
            if folder.is_none()
                && let Some(last) = store.local_setting(SYNC_FOLDER_LAST)
                && ui.button(t.use_same_folder()).clicked()
            {
                action = SyncAction::UseLastFolder(last);
            }
            if folder.is_some() {
                ui.label(t.folder_catalog_hint(&store.sync_catalog_dir()));
            }
            let mut private = store.sync_private_on();
            if ui.checkbox(&mut private, t.include_private()).changed() {
                let _ = store.set_local_setting(SYNC_PRIVATE, if private { "1" } else { "0" });
            }
            if folder.is_some() {
                let mut watch = store.sync_watch_on();
                if ui.checkbox(&mut watch, t.sync_watch_switch()).changed() {
                    let _ = store.set_local_setting(SYNC_WATCH, if watch { "1" } else { "0" });
                }
                if watch {
                    let mut auto = store.sync_auto_on();
                    if ui.checkbox(&mut auto, t.sync_auto_switch()).changed() {
                        let _ = store.set_local_setting(SYNC_AUTO, if auto { "1" } else { "0" });
                    }
                }
            }
            ui.label(egui::RichText::new(t.folder_hint()).weak());
            ui.horizontal(|ui| {
                if ui
                    .add_enabled(
                        folder.is_some() && !self.syncing,
                        egui::Button::new(t.sync_folder_now()),
                    )
                    .clicked()
                {
                    self.syncing = true;
                    action = SyncAction::SyncNow;
                }
                if self.syncing {
                    ui.spinner();
                    ui.label(t.sync_running());
                }
            });
            if let Some(result) = &self.folder_result {
                ui.label(result);
            }
            ui.add_space(16.0);
            ui.strong(t.bundles_section());
            ui.label(t.by_messenger_explainer());
            ui.horizontal(|ui| {
                if ui.button(t.export_bundle()).clicked() {
                    action = SyncAction::ExportBundle;
                }
                if ui.button(t.import_bundle()).clicked() {
                    action = SyncAction::ImportBundle;
                }
            });
            if let Some(result) = &self.bundle_result {
                ui.label(result);
            }
        });
        action
    }
}
