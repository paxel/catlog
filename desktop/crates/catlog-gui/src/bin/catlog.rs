//! The desktop launcher: opens the native window and hands every frame to
//! `catlog_gui::App`. On Windows it is built without a console window.
#![cfg_attr(windows, windows_subsystem = "windows")]

use catlog_gui::App;

struct Native(App);

impl eframe::App for Native {
    fn ui(&mut self, ui: &mut egui::Ui, _frame: &mut eframe::Frame) {
        App::install_theme(ui.ctx());
        egui::CentralPanel::default().show(ui, |ui| self.0.show(ui));
    }
}

fn main() {
    let options = eframe::NativeOptions {
        viewport: egui::ViewportBuilder::default()
            .with_title(catlog_core::APP_NAME)
            .with_inner_size(catlog_gui::DEFAULT_WINDOW_SIZE),
        ..Default::default()
    };
    let result = eframe::run_native(
        catlog_core::APP_NAME,
        options,
        Box::new(|_cc| Ok(Box::new(Native(App)))),
    );
    if let Err(e) = result {
        eprintln!("catlog: {e}");
        std::process::exit(1);
    }
}
