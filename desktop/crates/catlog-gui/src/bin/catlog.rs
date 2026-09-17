//! The desktop launcher: opens the native window and hands every frame to
//! `catlog_gui::App`. On Windows it is built without a console window.
#![cfg_attr(windows, windows_subsystem = "windows")]

use catlog_gui::{App, Request, SettingsFile};

struct Native {
    app: App,
    title: String,
}

impl eframe::App for Native {
    fn ui(&mut self, ui: &mut egui::Ui, _frame: &mut eframe::Frame) {
        App::install_theme(ui.ctx());
        if ui.ctx().input(|i| i.viewport().close_requested()) {
            self.app.on_exit();
        }
        self.app.show(ui);
        if self.app.take_request() == Request::Quit {
            ui.ctx().send_viewport_cmd(egui::ViewportCommand::Close);
        }
        let title = format!("{} – {}", self.app.title(), catlog_core::APP_NAME);
        if title != self.title {
            ui.ctx()
                .send_viewport_cmd(egui::ViewportCommand::Title(title.clone()));
            self.title = title;
        }
        let size = ui.ctx().viewport_rect().size();
        self.app.remember_window([size.x, size.y]);
    }
}

fn main() {
    let data = catlog_gui::data_dir();
    catlog_gui::crash::install(&catlog_gui::catalogs_root(&data));
    let mut app = match App::open(SettingsFile::load(&data), &catlog_gui::catalogs_root(&data)) {
        Ok(app) => app,
        Err(e) => {
            eprintln!("catlog: {e}");
            std::process::exit(1);
        }
    };
    // A `.catsync` file the app was started with, by a double-click.
    if let Some(arg) = std::env::args().nth(1) {
        app.open_bundle_file(std::path::Path::new(&arg));
    }
    app.check_folder();
    let options = eframe::NativeOptions {
        viewport: egui::ViewportBuilder::default()
            .with_title(catlog_core::APP_NAME)
            // The app id the launcher entry's StartupWMClass names, so the
            // taskbar shows the icon on Wayland.
            .with_app_id(catlog_gui::settings::APP_ID)
            .with_inner_size(app.window_size()),
        ..Default::default()
    };
    let result = eframe::run_native(
        catlog_core::APP_NAME,
        options,
        Box::new(|_cc| {
            Ok(Box::new(Native {
                app,
                title: String::new(),
            }))
        }),
    );
    if let Err(e) = result {
        eprintln!("catlog: {e}");
        std::process::exit(1);
    }
}
