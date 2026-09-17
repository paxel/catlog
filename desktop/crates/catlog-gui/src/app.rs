//! The shell: a menu bar, a list pane on the left and a detail pane on
//! the right, the intro on first start. Everything the window shows
//! passes through [`App::show`], which the kittest harness drives.

use egui::{Context, ThemePreference, Ui};

use crate::l10n::{self, L10n};
use crate::settings::{AppSettings, SettingsFile};

/// What the keeper asked the shell to do; the launcher acts on it.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Request {
    None,
    Quit,
}

/// The window size the app opens with when nothing was remembered.
pub const DEFAULT_WINDOW_SIZE: [f32; 2] = [1200.0, 800.0];

/// The list pane's width when nothing was remembered.
pub const DEFAULT_PANE_WIDTH: f32 = 320.0;

pub struct App {
    settings: SettingsFile,
    t: L10n,
    /// The name typed on the intro page.
    intro_name: String,
    intro_skip_tips: bool,
    request: Request,
    about_open: bool,
}

impl App {
    /// The app over the settings in `settings`, its language from them
    /// or the system.
    pub fn new(settings: SettingsFile) -> App {
        let locale = Self::locale_of(&settings.settings);
        App {
            t: L10n::new(&locale),
            intro_name: settings.settings.author.clone().unwrap_or_default(),
            intro_skip_tips: false,
            settings,
            request: Request::None,
            about_open: false,
        }
    }

    fn locale_of(settings: &AppSettings) -> String {
        match &settings.locale {
            Some(l) if !l.is_empty() => l.clone(),
            _ => l10n::locale_for_system(sys_locale::get_locale().as_deref()).to_string(),
        }
    }

    pub fn settings(&self) -> &AppSettings {
        &self.settings.settings
    }

    /// The strings in the current language.
    pub fn t(&self) -> &L10n {
        &self.t
    }

    /// What the keeper asked for since the last frame, cleared on read.
    pub fn take_request(&mut self) -> Request {
        std::mem::replace(&mut self.request, Request::None)
    }

    /// Sets the theme the app runs in: light only, on every platform.
    pub fn install_theme(ctx: &Context) {
        ctx.set_theme(ThemePreference::Light);
    }

    /// The window size to open with.
    pub fn window_size(&self) -> [f32; 2] {
        self.settings.settings.window.unwrap_or(DEFAULT_WINDOW_SIZE)
    }

    /// Remembers the window size on the way out.
    pub fn remember_window(&mut self, size: [f32; 2]) {
        if size[0] > 200.0 && size[1] > 200.0 {
            self.settings.settings.window = Some(size);
            let _ = self.settings.save();
        }
    }

    /// Switches the language and remembers it.
    pub fn set_locale(&mut self, locale: &str) {
        self.t = L10n::new(locale);
        self.settings.settings.locale = Some(locale.to_string());
        let _ = self.settings.save();
    }

    fn finish_intro(&mut self) {
        let name = self.intro_name.trim().to_string();
        if name.is_empty() {
            return;
        }
        self.settings.settings.author = Some(name);
        self.settings.settings.intro_seen = true;
        if self.intro_skip_tips {
            self.settings.settings.tips_seen = vec!["all".into()];
        }
        let _ = self.settings.save();
    }

    /// Draws the whole window into `ui`.
    pub fn show(&mut self, ui: &mut Ui) {
        if !self.settings.settings.intro_seen {
            self.show_intro(ui);
            return;
        }
        self.show_menu_bar(ui);
        let width = self
            .settings
            .settings
            .pane_width
            .unwrap_or(DEFAULT_PANE_WIDTH);
        let pane = egui::Panel::left("list-pane")
            .resizable(true)
            .default_size(width)
            .min_size(200.0)
            .show(ui, |ui| {
                ui.heading(self.t.clowders());
                ui.label(self.t.no_clowders_yet());
            });
        let new_width = pane.response.rect.width();
        if (new_width - width).abs() > 0.5 && pane.response.rect.width() > 0.0 {
            self.settings.settings.pane_width = Some(new_width);
        }
        egui::CentralPanel::default().show(ui, |ui| {
            ui.label(self.t.select_clowder_hint());
        });
        if self.about_open {
            self.show_about(ui.ctx());
        }
    }

    fn show_menu_bar(&mut self, ui: &mut Ui) {
        let t = self.t;
        egui::Panel::top("menu-bar")
            .show_separator_line(true)
            .show(ui, |ui| {
                egui::MenuBar::new().ui(ui, |ui| {
                    ui.menu_button(t.menu_file(), |ui| {
                        if ui.button(t.quit()).clicked() {
                            self.request = Request::Quit;
                        }
                    });
                    ui.menu_button(t.menu_edit(), |ui| {
                        ui.add_enabled(false, egui::Button::new(t.rename()));
                    });
                    ui.menu_button(t.menu_view(), |ui| {
                        ui.menu_button(t.language(), |ui| {
                            let mut chosen: Option<&'static str> = None;
                            for locale in l10n::LOCALES {
                                let label = format!("{}  ({locale})", l10n::native_name(locale));
                                if ui
                                    .selectable_label(self.t.locale() == locale, label)
                                    .clicked()
                                {
                                    chosen = Some(locale);
                                }
                            }
                            if let Some(l) = chosen {
                                self.set_locale(l);
                            }
                        });
                    });
                    ui.menu_button(t.menu_catalog(), |ui| {
                        ui.add_enabled(false, egui::Button::new(t.new_clowder()));
                    });
                    ui.menu_button(t.menu_help(), |ui| {
                        if ui.button(t.about_and_feedback()).clicked() {
                            self.about_open = true;
                        }
                    });
                });
            });
    }

    fn show_about(&mut self, ctx: &Context) {
        let t = self.t;
        let mut open = self.about_open;
        egui::Window::new(t.about_and_feedback())
            .open(&mut open)
            .collapsible(false)
            .resizable(false)
            .show(ctx, |ui| {
                ui.label(format!("{} {}", t.app_title(), catlog_core::VERSION));
                ui.label(t.about_tagline());
            });
        self.about_open = open;
    }

    fn show_intro(&mut self, ui: &mut Ui) {
        let t = self.t;
        egui::CentralPanel::default().show(ui, |ui| {
            ui.vertical_centered(|ui| {
                ui.add_space(60.0);
                ui.heading(t.welcome_title());
                ui.add_space(12.0);
                ui.label(t.welcome_body());
                ui.add_space(12.0);
                ui.label(t.your_name());
                ui.add(egui::TextEdit::singleline(&mut self.intro_name).desired_width(280.0));
                ui.add_space(8.0);
                ui.checkbox(&mut self.intro_skip_tips, t.intro_skip_tips());
                ui.add_space(12.0);
                let ready = !self.intro_name.trim().is_empty();
                if ui
                    .add_enabled(ready, egui::Button::new(t.start()))
                    .clicked()
                {
                    self.finish_intro();
                }
            });
        });
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use egui_kittest::Harness;
    use egui_kittest::kittest::Queryable;

    fn app(dir: &std::path::Path, locale: &str, intro_seen: bool) -> App {
        let mut file = SettingsFile::load(dir);
        file.settings.locale = Some(locale.into());
        file.settings.intro_seen = intro_seen;
        file.settings.author = intro_seen.then(|| "Ada".to_string());
        App::new(file)
    }

    fn harness(app: App) -> Harness<'static, App> {
        Harness::builder()
            .with_size(egui::vec2(1440.0, 900.0))
            .build_ui_state(
                |ui, app: &mut App| {
                    App::install_theme(ui.ctx());
                    app.show(ui);
                },
                app,
            )
    }

    #[test]
    fn the_shell_has_a_menu_bar_and_two_panes_in_english_and_german() {
        for locale in ["en", "de"] {
            let dir = tempfile::tempdir().unwrap();
            let mut h = harness(app(dir.path(), locale, true));
            h.run();
            let t = L10n::new(locale);
            let clowders = t.clowders();
            for label in [
                t.menu_file(),
                t.menu_edit(),
                t.menu_view(),
                t.menu_catalog(),
                t.menu_help(),
            ] {
                let node = h.get_by_label(label);
                assert!(node.rect().max.y < 60.0, "{label} sits in the menu bar");
            }
            let list = h.get_by_label(clowders).rect();
            let hint = h.get_by_label(t.select_clowder_hint()).rect();
            assert!(
                list.max.x <= DEFAULT_PANE_WIDTH + 2.0,
                "the list pane keeps its width"
            );
            assert!(
                hint.min.x >= DEFAULT_PANE_WIDTH - 2.0,
                "the detail pane sits right of it"
            );
            assert_eq!(h.state().t().locale(), locale);
        }
    }

    #[test]
    fn the_intro_takes_a_name_and_then_the_shell_appears() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(app(dir.path(), "en", false));
        h.run();
        let t = L10n::new("en");
        h.get_by_label(t.welcome_title());
        h.get_by_label(t.start()).click();
        h.run();
        assert!(!h.state().settings().intro_seen, "no name, no start");
        h.state_mut().intro_name = "Ada".into();
        h.state_mut().intro_skip_tips = true;
        h.run();
        h.get_by_label(t.start()).click();
        h.run();
        let s = h.state().settings().clone();
        assert!(s.intro_seen);
        assert_eq!(s.author.as_deref(), Some("Ada"));
        assert_eq!(s.tips_seen, vec!["all"]);
        h.get_by_label(t.menu_file());
        assert_eq!(
            SettingsFile::load(dir.path()).settings.author.as_deref(),
            Some("Ada")
        );
    }

    #[test]
    fn the_language_menu_switches_every_string_and_remembers_it() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(app(dir.path(), "en", true));
        h.run();
        h.get_by_label("View").click();
        h.step();
        h.get_by_label_contains("Language").hover();
        h.step();
        h.get_by_label_contains("Deutsch").click();
        h.run();
        assert_eq!(h.state().t().locale(), "de");
        h.get_by_label(L10n::new("de").menu_file());
        assert_eq!(
            SettingsFile::load(dir.path()).settings.locale.as_deref(),
            Some("de")
        );
    }

    #[test]
    fn quit_about_and_the_window_are_requests_and_settings() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(app(dir.path(), "en", true));
        h.run();
        h.get_by_label("File").click();
        h.step();
        h.get_by_label("Quit").click();
        h.run();
        assert_eq!(h.state_mut().take_request(), Request::Quit);
        assert_eq!(h.state_mut().take_request(), Request::None);
        h.get_by_label("Help").click();
        h.step();
        h.get_by_label("About & feedback").click();
        h.run();
        h.get_by_label_contains(catlog_core::VERSION);
        assert_eq!(h.state().window_size(), DEFAULT_WINDOW_SIZE);
        h.state_mut().remember_window([10.0, 10.0]);
        assert_eq!(
            h.state().window_size(),
            DEFAULT_WINDOW_SIZE,
            "a tiny size is a glitch"
        );
        h.state_mut().remember_window([1000.0, 700.0]);
        assert_eq!(
            SettingsFile::load(dir.path()).settings.window,
            Some([1000.0, 700.0])
        );
    }

    #[test]
    fn the_language_follows_the_system_when_none_is_chosen() {
        let dir = tempfile::tempdir().unwrap();
        let file = SettingsFile::load(dir.path());
        let app = App::new(file);
        assert!(l10n::LOCALES.contains(&app.t().locale()));
    }
}
