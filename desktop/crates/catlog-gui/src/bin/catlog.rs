//! The desktop launcher: opens the native window and hands every frame to
//! `catlog_gui::App`. On Windows it is built without a console window.
#![cfg_attr(windows, windows_subsystem = "windows")]

use catlog_gui::{App, Request, SettingsFile};

struct Native(App);

impl eframe::App for Native {
    fn ui(&mut self, ui: &mut egui::Ui, _frame: &mut eframe::Frame) {
        App::install_theme(ui.ctx());
        self.0.show(ui);
        if self.0.take_request() == Request::Quit {
            ui.ctx().send_viewport_cmd(egui::ViewportCommand::Close);
        }
        let size = ui.ctx().viewport_rect().size();
        self.0.remember_window([size.x, size.y]);
    }
}

fn main() {
    let app = App::new(SettingsFile::load(&catlog_gui::data_dir()));
    let options = eframe::NativeOptions {
        viewport: egui::ViewportBuilder::default()
            .with_title(catlog_core::APP_NAME)
            .with_inner_size(app.window_size()),
        ..Default::default()
    };
    let result = eframe::run_native(
        catlog_core::APP_NAME,
        options,
        Box::new(|_cc| Ok(Box::new(Native(app)))),
    );
    if let Err(e) = result {
        eprintln!("catlog: {e}");
        std::process::exit(1);
    }
}
