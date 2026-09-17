//! The cat(a)log desktop app: an egui shell over `catlog_core`.
//!
//! The native window and the eframe glue live in the `catlog` binary;
//! everything that can be tested headless lives here so the kittest
//! harness can drive it.

use egui::{Context, ThemePreference, Ui};

/// The window size the app opens with when nothing was remembered.
pub const DEFAULT_WINDOW_SIZE: [f32; 2] = [1200.0, 800.0];

/// The application state drawn every frame.
#[derive(Default)]
pub struct App;

impl App {
    /// Sets the theme the app runs in: light only, on every platform.
    pub fn install_theme(ctx: &Context) {
        ctx.set_theme(ThemePreference::Light);
    }

    /// Draws the shell into `ui`.
    pub fn show(&mut self, ui: &mut Ui) {
        ui.heading(catlog_core::APP_NAME);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use egui_kittest::Harness;
    use egui_kittest::kittest::Queryable;

    fn harness() -> Harness<'static, App> {
        Harness::builder()
            .with_size(egui::vec2(1440.0, 900.0))
            .build_ui_state(
                |ui, app: &mut App| {
                    App::install_theme(ui.ctx());
                    app.show(ui);
                },
                App,
            )
    }

    #[test]
    fn the_shell_renders_at_desktop_size_in_the_light_theme() {
        let mut harness = harness();
        harness.run();
        let title = harness.get_by_label(catlog_core::APP_NAME);
        let rect = title.rect();
        assert!(
            rect.width() > 0.0 && rect.height() > 0.0,
            "title has a size"
        );
        assert!(
            rect.min.x >= 0.0 && rect.max.x <= 1440.0,
            "title within the window"
        );
        assert_eq!(harness.ctx.theme(), egui::Theme::Light);
    }
}
