//! The dialogs the shell asks one thing with: a name, confirmed with
//! one verb or cancelled. One question, two actions, as the UI laws say.

use egui::{Context, Key};

/// A dialog asking for one line of text.
#[derive(Debug, Default)]
pub struct NameDialog {
    pub open: bool,
    pub title: String,
    pub label: String,
    pub confirm: String,
    pub value: String,
    /// What went wrong the last time the value was confirmed.
    pub error: Option<String>,
    id: u64,
}

impl NameDialog {
    /// Opens the dialog with a fresh value.
    pub fn ask(&mut self, title: &str, label: &str, confirm: &str, value: &str) {
        self.open = true;
        self.title = title.to_string();
        self.label = label.to_string();
        self.confirm = confirm.to_string();
        self.value = value.to_string();
        self.error = None;
        self.id += 1;
    }

    /// Draws the dialog; the value on confirm, none while open or when
    /// cancelled. Enter confirms, Escape cancels.
    pub fn show(&mut self, ctx: &Context, cancel: &str) -> Option<String> {
        if !self.open {
            return None;
        }
        let mut result = None;
        let mut close = false;
        let modal = egui::Modal::new(egui::Id::new(("name-dialog", self.id))).show(ctx, |ui| {
            ui.heading(&self.title);
            ui.label(&self.label);
            let edit = ui.add(egui::TextEdit::singleline(&mut self.value).desired_width(320.0));
            if !edit.has_focus() && self.error.is_none() && self.value.is_empty() {
                edit.request_focus();
            }
            if let Some(e) = &self.error {
                ui.colored_label(ui.visuals().error_fg_color, e);
            }
            let enter = edit.lost_focus() && ui.input(|i| i.key_pressed(Key::Enter));
            let escape = ui.input(|i| i.key_pressed(Key::Escape));
            ui.horizontal(|ui| {
                let ready = !self.value.trim().is_empty();
                if ui
                    .add_enabled(ready, egui::Button::new(&self.confirm))
                    .clicked()
                    || (enter && ready)
                {
                    result = Some(self.value.trim().to_string());
                }
                if crate::icons::button(ui, crate::icons::CLOSE, cancel).clicked() || escape {
                    close = true;
                }
            });
        });
        if result.is_some() || close || modal.should_close() {
            self.open = false;
            // One more frame lets the modal underneath become the top one.
            ctx.request_repaint();
        }
        result
    }

    /// Keeps the dialog open with a message, after a value was refused.
    pub fn refuse(&mut self, error: String) {
        self.open = true;
        self.error = Some(error);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use egui_kittest::Harness;
    use egui_kittest::kittest::Queryable;

    #[test]
    fn a_name_dialog_confirms_cancels_and_refuses() {
        let mut dialog = NameDialog::default();
        dialog.ask("New clowder", "Name", "Create", "");
        let mut h = Harness::builder()
            .with_size(egui::vec2(800.0, 600.0))
            .build_ui_state(
                |ui, d: &mut NameDialog| {
                    if let Some(name) = d.show(ui.ctx(), "Cancel") {
                        d.title = format!("got {name}");
                    }
                },
                dialog,
            );
        h.run();
        h.get_by_label("New clowder");
        h.get_by_label("Create").click();
        h.run();
        assert!(h.state().open, "an empty name cannot be confirmed");
        h.state_mut().value = " Barn ".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert!(!h.state().open);
        assert_eq!(h.state().title, "got Barn");
        h.state_mut().ask("Rename", "Name", "Rename", "Barn");
        h.run();
        h.state_mut().refuse("taken".into());
        h.run();
        h.get_by_label("taken");
        h.get_by_label("Cancel").click();
        h.run();
        assert!(!h.state().open);
        assert!(
            h.state_mut()
                .show(&egui::Context::default(), "Cancel")
                .is_none()
        );
    }
}

/// A dialog asking one yes-or-no question before something that cannot
/// be undone.
#[derive(Debug, Default)]
pub struct ConfirmDialog {
    pub open: bool,
    pub title: String,
    pub body: String,
    pub confirm: String,
    id: u64,
}

impl ConfirmDialog {
    /// Opens the dialog.
    pub fn ask(&mut self, title: &str, body: &str, confirm: &str) {
        self.open = true;
        self.title = title.to_string();
        self.body = body.to_string();
        self.confirm = confirm.to_string();
        self.id += 1;
    }

    /// Draws the dialog; true once on confirm. Escape cancels.
    pub fn show(&mut self, ctx: &Context, cancel: &str) -> bool {
        if !self.open {
            return false;
        }
        let mut confirmed = false;
        let mut close = false;
        let modal = egui::Modal::new(egui::Id::new(("confirm-dialog", self.id))).show(ctx, |ui| {
            ui.set_max_width(360.0);
            ui.heading(&self.title);
            ui.label(&self.body);
            let escape = ui.input(|i| i.key_pressed(Key::Escape));
            ui.horizontal(|ui| {
                if crate::icons::button(ui, crate::icons::CHECK, &self.confirm).clicked() {
                    confirmed = true;
                }
                if crate::icons::button(ui, crate::icons::CLOSE, cancel).clicked() || escape {
                    close = true;
                }
            });
        });
        if confirmed || close || modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
        confirmed
    }
}
