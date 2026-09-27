//! What can be done to the rows a keeper has marked in a table. Marking
//! several rows used to buy nothing; this bar is what it buys.

use egui::Ui;

use crate::icons;
use crate::l10n::L10n;

/// What the keeper asked for the marked rows.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum MarkedAction {
    None,
    /// Lay them all on the desk.
    Open,
    /// Move the marked Cats into another Clowder.
    MoveHome,
    /// Move them into another Catalog.
    MoveCatalog,
    /// Hide them on this device, or show them again.
    Hide(bool),
    /// Write them into a file.
    Export,
    /// Delete them, after the confirmation the app asks for.
    Delete,
}

/// The bar over a table while rows are marked: how many, and what can
/// be done with them. `cats` says whether moving into a home applies,
/// `hidden` whether the marked ones are hidden already.
pub fn marked_bar(
    ui: &mut Ui,
    t: &L10n,
    count: usize,
    cats: bool,
    hidden: bool,
    pet_mode: bool,
) -> MarkedAction {
    let mut action = MarkedAction::None;
    if count == 0 {
        return action;
    }
    // One menu, not a row of buttons: a row of them would make the
    // table's pane wider than the desk beside it.
    ui.horizontal(|ui| {
        // The button says how many are marked and holds what can be
        // done with them; a row of buttons would widen the pane.
        icons::more_labeled(ui, &t.marked_count(count as i64), |ui| {
            if icons::button(ui, icons::GRID_VIEW, t.marked_open()).clicked() {
                action = MarkedAction::Open;
                ui.close();
            }
            if cats {
                let home = if pet_mode {
                    t.move_to_home_neutral()
                } else {
                    t.move_to_home()
                };
                if icons::button(ui, icons::DRIVE_FILE_MOVE_OUTLINE, home).clicked() {
                    action = MarkedAction::MoveHome;
                    ui.close();
                }
            }
            if icons::button(ui, icons::DRIVE_FILE_MOVE_OUTLINE, t.move_to_catalog()).clicked() {
                action = MarkedAction::MoveCatalog;
                ui.close();
            }
            let words = if hidden {
                t.unhide_label()
            } else {
                t.hide_label()
            };
            let eye = if hidden {
                icons::VISIBILITY_OUTLINED
            } else {
                icons::VISIBILITY_OFF_OUTLINED
            };
            if icons::button(ui, eye, words).clicked() {
                action = MarkedAction::Hide(!hidden);
                ui.close();
            }
            if icons::button(ui, icons::SAVE_OUTLINED, t.marked_export()).clicked() {
                action = MarkedAction::Export;
                ui.close();
            }
            ui.separator();
            if ui
                .button(egui::RichText::new(t.marked_delete()).color(crate::theme::PALETTE.red))
                .clicked()
            {
                action = MarkedAction::Delete;
                ui.close();
            }
        });
    });
    action
}
