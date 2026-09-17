//! The shell: a menu bar, the home pane on the left and a detail pane
//! on the right, the intro on first start. Everything the window shows
//! passes through [`App::show`], which the kittest harness drives.

use std::path::{Path, PathBuf};
use std::sync::Arc;

use catlog_core::entities::PositionKind;
use catlog_core::geocode::Geocoder;
use catlog_core::tiles::TileCache;
use catlog_core::{Catalog, CatalogManager, keys};
use egui::{Context, ThemePreference, Ui};

use crate::dialogs::{ConfirmDialog, NameDialog};
use crate::editor::{EditTarget, FieldEditor, apply_edit};
use crate::history::{HistoryAction, HistoryPage};
use crate::home::{HomeAction, HomePane, Selection};
use crate::l10n::{self, L10n};
use crate::map::MapView;
use crate::map_page::{MapPage, MapPageAction};
use crate::move_dialog::MoveDialog;
use crate::new_field::NewFieldDialog;
use crate::pages::{PageAction, Pages};
use crate::photos::{EditMode, PhotoEditor, PhotoViewer, ViewerAction};
use crate::picker::PositionPicker;
use crate::settings::{AppSettings, SettingsFile};
use crate::textures::FaceCache;

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

/// Asks the keeper for files: the dialog's title in, the chosen paths out.
pub type FilePicker = Box<dyn FnMut(&str) -> Vec<PathBuf>>;
/// Asks the keeper where to save: title and suggested name in, the path out.
pub type FileSaver = Box<dyn FnMut(&str, &str) -> Option<PathBuf>>;

/// Which dialog is up, and what its answer means.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Asking {
    Nothing,
    NewClowder,
    NewCatalog,
    RenameCatalog,
}

pub struct App {
    settings: SettingsFile,
    t: L10n,
    manager: CatalogManager,
    store: Catalog,
    home: HomePane,
    pages: Pages,
    editor: FieldEditor,
    new_field: NewFieldDialog,
    history: HistoryPage,
    /// A history page in the detail pane: entity and Field slug.
    history_of: Option<(String, String)>,
    map_page: MapPage,
    picker: PositionPicker,
    /// The Cat a sighting is being picked for.
    sighting_for: Option<String>,
    mover: MoveDialog,
    /// The list pane's width when the window opened.
    pane_width: f32,
    faces: FaceCache,
    dialog: NameDialog,
    pub confirm: ConfirmDialog,
    /// The photo the confirm dialog is about: Cat and hash.
    deleting_photo: Option<(String, String)>,
    pub viewer: PhotoViewer,
    pub photo_editor: PhotoEditor,
    /// Asks the keeper for image files; the system dialog outside tests.
    pub pick_files: FilePicker,
    /// Asks the keeper where to save a file; the system dialog outside tests.
    pub save_file: FileSaver,
    asking: Asking,
    /// The name typed on the intro page.
    intro_name: String,
    intro_skip_tips: bool,
    request: Request,
    about_open: bool,
    /// What went wrong last, shown in the detail pane until the next action.
    notice: Option<String>,
}

impl App {
    /// The app over the settings in `settings` and the Catalogs under
    /// `root`, its language from the settings or the system.
    pub fn open(settings: SettingsFile, root: &Path) -> catlog_core::Result<App> {
        let tiles = TileCache::open(&root.join("tiles"), Box::new(catlog_core::tiles::OsmTiles))?;
        Self::open_with(
            settings,
            root,
            Arc::new(tiles),
            Arc::new(catlog_core::geocode::Nominatim),
        )
    }

    /// [`App::open`] with the map's sources handed in: tests use
    /// stand-ins that never touch the network.
    pub fn open_with(
        settings: SettingsFile,
        root: &Path,
        tiles: Arc<TileCache>,
        geocoder: Arc<dyn Geocoder>,
    ) -> catlog_core::Result<App> {
        let locale = Self::locale_of(&settings.settings);
        let t = L10n::new(&locale);
        let manager = CatalogManager::open(root, t.clowders())?;
        let mut store = manager.open_store(manager.active())?;
        if let Some(author) = &settings.settings.author {
            store.set_author(author)?;
        }
        let _ = store.strip_photo_locations();
        Ok(App {
            t,
            pane_width: settings.settings.pane_width.unwrap_or(DEFAULT_PANE_WIDTH),
            intro_name: settings.settings.author.clone().unwrap_or_default(),
            intro_skip_tips: false,
            settings,
            manager,
            store,
            home: HomePane::default(),
            pages: Pages::default(),
            editor: FieldEditor::closed(),
            new_field: NewFieldDialog::default(),
            history: HistoryPage::default(),
            history_of: None,
            map_page: MapPage::new(MapView::new(tiles.clone())),
            picker: PositionPicker::new(tiles, geocoder),
            sighting_for: None,
            mover: MoveDialog::default(),
            faces: FaceCache::default(),
            dialog: NameDialog::default(),
            confirm: ConfirmDialog::default(),
            deleting_photo: None,
            viewer: PhotoViewer::default(),
            photo_editor: PhotoEditor::default(),
            pick_files: Box::new(|title| {
                rfd::FileDialog::new()
                    .set_title(title)
                    .add_filter("JPEG, PNG", &["jpg", "jpeg", "png"])
                    .pick_files()
                    .unwrap_or_default()
            }),
            save_file: Box::new(|title, name| {
                rfd::FileDialog::new()
                    .set_title(title)
                    .set_file_name(name)
                    .save_file()
            }),
            asking: Asking::Nothing,
            request: Request::None,
            about_open: false,
            notice: None,
        })
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

    /// The open Catalog.
    pub fn store(&self) -> &Catalog {
        &self.store
    }

    pub fn store_mut(&mut self) -> &mut Catalog {
        &mut self.store
    }

    pub fn manager(&self) -> &CatalogManager {
        &self.manager
    }

    pub fn selection(&self) -> &Selection {
        &self.home.selection
    }

    /// Shows a page in the detail pane, as a click in the list would.
    pub fn select(&mut self, selection: Selection) {
        self.home.selection = selection;
        self.history_of = None;
    }

    /// Shows a Field's history on an entity in the detail pane.
    /// Reads every path as a picture and stores it on the Cat, compressed
    /// and stripped as the phone does; the notice says how many landed
    /// or what went wrong with the first that did not.
    pub fn add_photos(&mut self, cat: &str, paths: &[PathBuf]) {
        let t = self.t;
        let mut added = 0usize;
        for path in paths {
            let result = std::fs::read(path)
                .map_err(|e| e.to_string())
                .and_then(|raw| self.store.add_photo(cat, &raw).map_err(|e| e.to_string()));
            match result {
                Ok(_) => added += 1,
                Err(e) => {
                    self.notice = Some(format!("{}: {e}", path.display()));
                    return;
                }
            }
        }
        if added > 0 {
            let name = self
                .store
                .current(cat, keys::NAME)
                .ok()
                .flatten()
                .unwrap_or_default();
            self.notice = Some(t.photos_added_to(&added.to_string(), &name));
        }
    }

    pub fn open_history(&mut self, entity: &str, slug: &str) {
        self.history_of = Some((entity.to_string(), slug.to_string()));
    }

    /// The window title: the open Catalog's name.
    pub fn title(&self) -> String {
        self.manager.active().name.clone()
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
        if size[0] > 200.0 && size[1] > 200.0 && self.settings.settings.window != Some(size) {
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

    /// Opens another Catalog of this device.
    pub fn switch_catalog(&mut self, id: &str) -> catlog_core::Result<()> {
        let Some(info) = self.manager.by_id(id).cloned() else {
            return Ok(());
        };
        let store = self.manager.open_store(&info)?;
        if let Some(author) = &self.settings.settings.author {
            store.set_author(author)?;
        }
        self.store = store;
        self.manager.set_active(id)?;
        self.home.selection = Selection::None;
        self.faces = FaceCache::default();
        Ok(())
    }

    fn finish_intro(&mut self) {
        let name = self.intro_name.trim().to_string();
        if name.is_empty() {
            return;
        }
        self.settings.settings.author = Some(name.clone());
        self.settings.settings.intro_seen = true;
        if self.intro_skip_tips {
            self.settings.settings.tips_seen = vec!["all".into()];
        }
        let _ = self.settings.save();
        let _ = self.store.set_author(&name);
    }

    /// Draws the whole window into `ui`.
    pub fn show(&mut self, ui: &mut Ui) {
        if !self.settings.settings.intro_seen {
            self.show_intro(ui);
            return;
        }
        self.show_menu_bar(ui);
        let t = self.t;
        let mut action = HomeAction::None;
        // The pane opens at the remembered width; egui keeps the width
        // between frames, and a drag that ends is what gets remembered.
        let pane = egui::Panel::left("list-pane")
            .resizable(true)
            .min_size(200.0)
            .default_size(self.pane_width)
            .show(ui, |ui| {
                action = self.home.show(ui, &self.store, &t, &mut self.faces);
            });
        let shown = pane.response.rect.width();
        let released = ui.input(|i| i.pointer.primary_released());
        if released && shown > 0.0 && Some(shown) != self.settings.settings.pane_width {
            self.settings.settings.pane_width = Some(shown);
            let _ = self.settings.save();
        }
        self.act(action);
        let mut page_action = PageAction::None;
        egui::CentralPanel::default().show(ui, |ui| {
            if let Some(notice) = &self.notice {
                ui.colored_label(ui.visuals().error_fg_color, notice);
            }
            let hovering = ui.input(|i| !i.raw.hovered_files.is_empty());
            if hovering && matches!(self.home.selection, Selection::Cat(_)) {
                ui.colored_label(ui.visuals().selection.bg_fill, t.drop_photos_hint());
            }
            if let Some((entity, slug)) = self.history_of.clone() {
                if let Ok(Some(def)) = self.store.field_def(&slug) {
                    match self.history.show(ui, &self.store, &t, &entity, &def) {
                        HistoryAction::None => {}
                        HistoryAction::Back => self.history_of = None,
                        HistoryAction::Correct(seq) => {
                            if let Ok(Some(e)) = self.store.entry_by_seq(seq) {
                                self.editor.ask(
                                    &self.store,
                                    &def,
                                    &entity,
                                    e.value.as_deref(),
                                    EditTarget::Correct(seq),
                                    Some(&e.date),
                                    t.locale(),
                                );
                            }
                        }
                        HistoryAction::Remove(seq) => {
                            if let Err(e) = self.store.remove_entry(seq) {
                                self.notice = Some(e.to_string());
                            }
                        }
                        HistoryAction::Restore(seq) => {
                            if let Err(e) = self.store.restore_entry(seq) {
                                self.notice = Some(e.to_string());
                            }
                        }
                    }
                } else {
                    self.history_of = None;
                }
                return;
            }
            match self.home.selection.clone() {
                Selection::None => {
                    ui.label(t.select_clowder_hint());
                }
                Selection::Strays => {
                    page_action = self.pages.show_strays(ui, &self.store, &t, &mut self.faces);
                }
                Selection::Clowder(id) => {
                    page_action =
                        self.pages
                            .show_clowder(ui, &self.store, &t, &mut self.faces, &id);
                }
                Selection::Cat(id) => {
                    page_action = self
                        .pages
                        .show_cat(ui, &self.store, &t, &mut self.faces, &id);
                }
                Selection::Map => match self.map_page.show(ui, &self.store, &t) {
                    MapPageAction::None => {}
                    MapPageAction::OpenCat(id) => page_action = PageAction::OpenCat(id),
                    MapPageAction::OpenClowder(id) => page_action = PageAction::OpenClowder(id),
                    MapPageAction::Sighting(id, lat, lon) => {
                        if let Err(e) =
                            self.store
                                .record_position(&id, lat, lon, PositionKind::Sighting, None)
                        {
                            self.notice = Some(e.to_string());
                        }
                    }
                },
            }
        });
        match page_action {
            PageAction::None => {}
            PageAction::OpenCat(id) => self.home.selection = Selection::Cat(id),
            PageAction::OpenClowder(id) => self.home.selection = Selection::Clowder(id),
            PageAction::ToggleHidden(id) => self.act(HomeAction::ToggleHidden(id)),
            PageAction::Edit(entity, slug) => {
                if let Ok(Some(def)) = self.store.field_def(&slug) {
                    let current = self.store.current(&entity, &def.key()).ok().flatten();
                    self.editor.ask(
                        &self.store,
                        &def,
                        &entity,
                        current.as_deref(),
                        EditTarget::New,
                        None,
                        t.locale(),
                    );
                }
            }
            PageAction::History(entity, slug) => self.history_of = Some((entity, slug)),
            PageAction::NewField(scope) => self.new_field.ask(scope),
            PageAction::Move(cat) => self.mover.ask(&self.store, &cat),
            PageAction::Sighting(cat) => {
                self.sighting_for = Some(cat);
                self.picker.ask(None, self.map_page.map.viewport);
            }
            PageAction::ShowOnMap(id) => {
                self.map_page.focus(&self.store, &id);
                self.home.selection = Selection::Map;
            }
            PageAction::AddPhoto(cat) => {
                let paths = (self.pick_files)(t.add_photo());
                self.add_photos(&cat, &paths);
            }
            PageAction::ViewPhoto(cat, hash) => {
                let hashes = self.store.images(&cat).unwrap_or_default();
                self.viewer.open_at(hashes, &hash);
            }
            PageAction::SetProfile(cat, hash) => {
                if let Err(e) = self.store.set_profile_image(&cat, &hash) {
                    self.notice = Some(e.to_string());
                }
            }
            PageAction::CropPhoto(cat, hash) => {
                self.photo_editor
                    .ask(&self.store, EditMode::Crop, &cat, &hash);
            }
            PageAction::MarkPhoto(cat, hash) => {
                self.photo_editor
                    .ask(&self.store, EditMode::Mark, &cat, &hash);
            }
            PageAction::DeletePhoto(cat, hash) => {
                self.deleting_photo = Some((cat, hash));
                self.confirm
                    .ask(t.delete_photo_title(), t.delete_photo_body(), t.delete());
            }
        }
        // Files dropped on a Cat's page become its photos.
        let dropped: Vec<PathBuf> = ui.input(|i| {
            i.raw
                .dropped_files
                .iter()
                .filter_map(|f| f.path.clone())
                .collect()
        });
        if !dropped.is_empty()
            && let Selection::Cat(cat) = self.home.selection.clone()
        {
            self.add_photos(&cat, &dropped);
        }
        if self.confirm.show(ui.ctx(), t.cancel())
            && let Some((cat, hash)) = self.deleting_photo.take()
        {
            match self.store.delete_image(&cat, &hash) {
                Ok(()) => {
                    self.faces.forget(&hash);
                    self.notice = Some(t.photo_removed().to_string());
                }
                Err(e) => self.notice = Some(e.to_string()),
            }
        }
        if !self.confirm.open {
            self.deleting_photo = None;
        }
        match self.viewer.show(ui.ctx(), &self.store, &t, &mut self.faces) {
            ViewerAction::None => {}
            ViewerAction::Save(hash) => {
                let name = format!("{}-{}.jpg", self.title(), self.viewer.index + 1);
                if let Some(path) = (self.save_file)(t.save_photo_as(), &name)
                    && let Some(bytes) = self.store.image_bytes(&hash)
                    && let Err(e) = std::fs::write(&path, bytes)
                {
                    self.notice = Some(e.to_string());
                }
            }
        }
        match self
            .photo_editor
            .show(ui.ctx(), &self.store, &t, &mut self.faces)
        {
            None => {}
            Some(Ok((cat, bytes))) => match self.store.add_image(&cat, &bytes) {
                Ok(_) => self.notice = Some(t.photo_added().to_string()),
                Err(e) => self.notice = Some(e.to_string()),
            },
            Some(Err(e)) => self.notice = Some(e),
        }
        if self.editor.wants_picker {
            self.editor.wants_picker = false;
            let current = self.editor.text.clone();
            self.picker.ask(Some(&current), self.map_page.map.viewport);
        }
        if let Some(picked) = self.picker.show(ui.ctx(), &t) {
            if let Some(cat) = self.sighting_for.take() {
                if let Some((lat, lon)) = catlog_core::entities::parse_position(Some(&picked)) {
                    match self
                        .store
                        .record_position(&cat, lat, lon, PositionKind::Sighting, None)
                    {
                        Ok(()) => self.notice = Some(t.sighting_recorded().to_string()),
                        Err(e) => self.notice = Some(e.to_string()),
                    }
                }
            } else if self.editor.open {
                self.editor.text = picked;
            }
        }
        self.mover.show(ui.ctx(), &mut self.store, &t);
        if let Some(edit) = self.editor.show(ui.ctx(), &self.store, &t)
            && let Err(e) = apply_edit(&mut self.store, &self.editor, &edit)
        {
            self.notice = Some(e.to_string());
        }
        self.new_field.show(ui.ctx(), &mut self.store, &t);
        self.show_dialog(ui.ctx());
        if self.about_open {
            self.show_about(ui.ctx());
        }
    }

    fn act(&mut self, action: HomeAction) {
        let t = self.t;
        match action {
            HomeAction::None => {}
            HomeAction::Open(_) => {
                self.notice = None;
                self.history_of = None;
            }
            HomeAction::ToggleFavourite(id) => {
                let key = format!("fav:{id}");
                let now = self.store.local_setting(&key).as_deref() == Some("yes");
                let _ = self
                    .store
                    .set_local_setting(&key, if now { "no" } else { "yes" });
            }
            HomeAction::ToggleHidden(id) => {
                let now = self.store.is_hidden(&id).unwrap_or(false);
                let _ = self.store.set_hidden(&id, !now);
            }
            HomeAction::NewClowder => {
                self.asking = Asking::NewClowder;
                self.dialog.ask(t.new_clowder(), t.name(), t.create(), "");
            }
        }
    }

    fn show_dialog(&mut self, ctx: &Context) {
        let t = self.t;
        let Some(value) = self.dialog.show(ctx, t.cancel()) else {
            return;
        };
        match self.asking {
            Asking::Nothing => {}
            Asking::NewClowder => {
                let id = format!("clowder:{}", new_uuid());
                match self.store.create_clowder(&id, &value) {
                    Ok(()) => self.home.selection = Selection::Clowder(id),
                    Err(e) => self.notice = Some(e.to_string()),
                }
            }
            Asking::NewCatalog => match self.manager.create(&value) {
                Ok(info) => {
                    if let Err(e) = self.switch_catalog(&info.id) {
                        self.notice = Some(e.to_string());
                    }
                }
                Err(_) => self.dialog.refuse(t.catalog_name_taken(&value)),
            },
            Asking::RenameCatalog => {
                let id = self.manager.active().id.clone();
                if self.manager.rename(&id, &value).is_err() {
                    self.dialog.refuse(t.catalog_name_taken(&value));
                }
            }
        }
        if !self.dialog.open {
            self.asking = Asking::Nothing;
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
                        if ui.button(t.map()).clicked() {
                            self.home.selection = Selection::Map;
                            self.history_of = None;
                            ui.close();
                        }
                        if ui
                            .checkbox(&mut self.home.show_hidden, t.show_hidden_label())
                            .changed()
                        {
                            ui.close();
                        }
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
                        let active = self.manager.active().id.clone();
                        let mut switch: Option<String> = None;
                        for info in self.manager.catalogs() {
                            if ui.selectable_label(info.id == active, &info.name).clicked() {
                                switch = Some(info.id.clone());
                            }
                        }
                        if let Some(id) = switch
                            && let Err(e) = self.switch_catalog(&id)
                        {
                            self.notice = Some(e.to_string());
                        }
                        ui.separator();
                        if ui.button(t.new_catalog()).clicked() {
                            self.asking = Asking::NewCatalog;
                            self.dialog.ask(
                                t.new_catalog(),
                                t.catalog_name_label(),
                                t.create(),
                                "",
                            );
                            ui.close();
                        }
                        if ui.button(t.rename_catalog()).clicked() {
                            let current = self.manager.active().name.clone();
                            self.asking = Asking::RenameCatalog;
                            self.dialog.ask(
                                t.rename_catalog(),
                                t.catalog_name_label(),
                                t.rename(),
                                &current,
                            );
                            ui.close();
                        }
                        ui.separator();
                        if ui.button(t.new_clowder()).clicked() {
                            self.act(HomeAction::NewClowder);
                            ui.close();
                        }
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

/// A fresh v4 UUID for a new entity, as the phones make them.
pub fn new_uuid() -> String {
    let mut b = [0u8; 16];
    let _ = getrandom::fill(&mut b);
    b[6] = (b[6] & 0x0f) | 0x40;
    b[8] = (b[8] & 0x3f) | 0x80;
    let h = hex::encode(b);
    format!(
        "{}-{}-{}-{}-{}",
        &h[..8],
        &h[8..12],
        &h[12..16],
        &h[16..20],
        &h[20..]
    )
}

/// Where the Catalogs of this device live.
pub fn catalogs_root(data_dir: &Path) -> PathBuf {
    data_dir.to_path_buf()
}

#[cfg(test)]
mod tests {
    use super::*;
    use catlog_core::keys;
    use catlog_core::tiles::TileSource;
    use egui_kittest::Harness;
    use egui_kittest::kittest::Queryable;

    fn app(dir: &std::path::Path, locale: &str, intro_seen: bool) -> App {
        let mut file = SettingsFile::load(dir);
        file.settings.locale = Some(locale.into());
        file.settings.intro_seen = intro_seen;
        file.settings.author = intro_seen.then(|| "Ada".to_string());
        let tiles = TileCache::open(&dir.join("tiles"), Box::new(FakeTiles)).unwrap();
        App::open_with(
            file,
            &dir.join("data"),
            Arc::new(tiles),
            Arc::new(FakeGeocoder),
        )
        .unwrap()
    }

    /// A tile source that answers every tile with one grey PNG.
    struct FakeTiles;

    impl TileSource for FakeTiles {
        fn fetch(&self, _tile: catlog_core::tiles::TileId) -> Result<Vec<u8>, String> {
            let img = image::DynamicImage::new_rgb8(256, 256);
            let mut out = Vec::new();
            img.write_to(&mut std::io::Cursor::new(&mut out), image::ImageFormat::Png)
                .map_err(|e| e.to_string())?;
            Ok(out)
        }
    }

    struct FakeGeocoder;

    impl Geocoder for FakeGeocoder {
        fn search(&self, query: &str) -> Result<Vec<catlog_core::geocode::GeoHit>, String> {
            if query == "nowhere" {
                return Err("no such place".into());
            }
            Ok(vec![catlog_core::geocode::GeoHit {
                name: format!("{query}, Sachsen"),
                lat: 51.34,
                lon: 12.37,
                bounds: Some((51.2, 51.4, 12.2, 12.5)),
            }])
        }
    }

    /// The app over the `fresh` fixture: two Clowders, three Cats, photos.
    fn seeded(dir: &std::path::Path) -> App {
        let mut app = app(dir, "en", true);
        let fixture = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../fixtures/fresh/folder");
        app.store_mut().import_folder(&fixture, None).unwrap();
        app
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
            let list = h.get_by_label(t.clowders()).rect();
            let hint = h.get_by_label(t.select_clowder_hint()).rect();
            assert!(
                list.max.x <= DEFAULT_PANE_WIDTH + 2.0,
                "the list pane keeps its width"
            );
            assert!(
                hint.min.x >= DEFAULT_PANE_WIDTH - 2.0,
                "the detail pane sits right of it"
            );
            h.get_by_label(t.no_clowders_yet());
            assert_eq!(h.state().t().locale(), locale);
            assert_eq!(h.state().title(), t.clowders());
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
        assert_eq!(h.state().store().author().as_deref(), Some("Ada"));
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
        let app = App::open(file, &dir.path().join("data")).unwrap();
        assert!(l10n::LOCALES.contains(&app.t().locale()));
        assert_eq!(app.manager().catalogs().len(), 1);
    }

    #[test]
    fn the_home_pane_lists_strays_and_clowders_with_faces_and_opens_them() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.get_by_label_contains("Strays  (1)");
        let home = h.get_by_label("Foster Home").rect();
        let barn = h.get_by_label("Barn").rect();
        assert!(home.min.y < barn.min.y, "creation order");
        assert!(home.max.x < DEFAULT_PANE_WIDTH);
        assert!(!h.state().faces.is_empty(), "the faces were loaded");
        h.get_by_label("Barn").click();
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Clowder("clowder:00000000-0000-4000-8000-000000000002".into())
        );
        assert!(
            h.get_all_by_label("Barn").count() >= 2,
            "the detail pane shows it"
        );
        h.get_by_label_contains("Strays  (1)").click();
        h.run();
        assert_eq!(*h.state().selection(), Selection::Strays);
        // The star moves a Clowder to the front and back.
        h.get_all_by_label("☆").nth(1).unwrap().click();
        h.run();
        let home = h.get_by_label("Foster Home").rect();
        let barn = h.get_by_label("Barn").rect();
        assert!(barn.min.y < home.min.y, "the favourite leads");
        h.get_by_label("★").click();
        h.run();
        let home = h.get_by_label("Foster Home").rect();
        let barn = h.get_by_label("Barn").rect();
        assert!(home.min.y < barn.min.y);
    }

    fn seeded_with(dir: &std::path::Path, scenario: &str) -> App {
        let mut app = app(dir, "en", true);
        let fixture =
            Path::new(env!("CARGO_MANIFEST_DIR")).join(format!("../../fixtures/{scenario}/folder"));
        app.store_mut().import_folder(&fixture, None).unwrap();
        app
    }

    #[test]
    fn the_clowder_page_shows_its_cats_fields_and_a_way_to_each_cat() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_by_label("Cats (1)");
        h.get_by_label("Katzenweg 3, Leipzig");
        h.get_by_label(L10n::new("en").status_foster());
        let miezi = h.get_by_label("Miezi").rect();
        assert!(
            miezi.min.x > DEFAULT_PANE_WIDTH,
            "the cat sits in the detail pane: {miezi:?}"
        );
        h.get_by_label("Miezi").click();
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Cat("cat:00000000-0000-4000-8000-000000000001".into())
        );
        h.get_by_label("Photos (2)");
        h.get_by_label(L10n::new("en").value_female());
        h.get_by_label("tabby");
        // The Clowder line leads back to the place; the list row comes
        // first in the tree, the link in the detail pane last.
        h.get_all_by_label("Foster Home").last().unwrap().click();
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Clowder("clowder:00000000-0000-4000-8000-000000000001".into())
        );
        // The timeline unfolds and remembers it.
        h.get_by_label("Timeline").click();
        h.run();
        assert!(
            h.get_all_by_label_contains("Ada · ").count() > 0,
            "the rows show author and day"
        );
        assert_eq!(
            h.state().store().local_setting("fold:timeline").as_deref(),
            Some("open")
        );
    }

    #[test]
    fn the_strays_page_lists_homeless_cats_and_the_keyboard_walks_the_list() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.get_by_label_contains("Strays  (1)").click();
        h.run();
        h.get_by_label("Wanderer").click();
        h.run();
        assert!(matches!(h.state().selection(), Selection::Cat(_)));
        h.get_by_label(L10n::new("en").stray_no_clowder());
        // Down from the Strays row lands on the first Clowder, also
        // right after a click left the focus on the row.
        h.get_by_label_contains("Strays  (1)").click();
        h.run();
        h.key_press(egui::Key::ArrowDown);
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Clowder("clowder:00000000-0000-4000-8000-000000000001".into())
        );
        h.key_press(egui::Key::ArrowDown);
        h.run();
        h.key_press(egui::Key::ArrowDown);
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Clowder("clowder:00000000-0000-4000-8000-000000000002".into()),
            "the end holds"
        );
        h.key_press(egui::Key::ArrowUp);
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Clowder("clowder:00000000-0000-4000-8000-000000000001".into())
        );
        h.get_by_label("Cats (1)");
    }

    #[test]
    fn values_chores_appointments_and_family_read_in_words() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "chores"));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        assert!(
            h.query_by_label_contains("Worming").is_none(),
            "an ended chore is not listed"
        );
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_by_label_contains("Drops · ");
        assert!(
            h.query_by_label("Planned").is_none(),
            "a finished visit is no plan"
        );
        h.get_by_label(L10n::new("en").value_yes());
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "fields-all"));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_by_label("4.25 kg");
        h.get_by_label("5/2021");
        h.get_by_label("Family");
        // "Tom" is the Mother value and the family link; the link comes last.
        h.get_all_by_label("Tom").last().unwrap().click();
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Cat("cat:00000000-0000-4000-8000-000000000002".into())
        );
        h.get_by_label("Kittens");
        // Hidden through the row menu action, on the phone a hold.
        h.get_all_by_label("Foster Home").next().unwrap().click();
        h.run();
        h.state_mut().act(HomeAction::ToggleHidden(
            "cat:00000000-0000-4000-8000-000000000002".into(),
        ));
        h.run();
        assert!(
            h.state()
                .store()
                .is_hidden("cat:00000000-0000-4000-8000-000000000002")
                .unwrap()
        );
    }

    #[test]
    fn a_value_is_edited_in_place_and_its_history_opens_from_the_row_menu() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "fields-all"));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        // The Visits row's menu: edit, then history.
        h.get_by_label("3").click_secondary();
        h.step();
        h.get_by_label("Edit value").click_accesskit();
        h.run();
        assert!(h.state().editor.open);
        h.state_mut().editor.text = "4".into();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:visits")
                .unwrap()
                .as_deref(),
            Some("4")
        );
        h.get_by_label("4").click_secondary();
        h.step();
        h.get_by_label("History").click_accesskit();
        h.run();
        assert!(h.state().history_of.is_some());
        h.get_by_label_contains("Miezi · ");
        // Correcting from the history opens the editor as of the entry.
        h.get_all_by_label("3").next().unwrap().click();
        h.run();
        assert!(matches!(h.state().editor.target, EditTarget::Correct(_)));
        h.state_mut().editor.text = "5".into();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        assert_eq!(
            h.state()
                .store()
                .field_history(miezi, "f:visits", false)
                .unwrap()
                .len(),
            2
        );
        // Removing through the row menu falls back to the value before.
        h.get_all_by_label("4").next().unwrap().click_secondary();
        h.step();
        h.get_by_label("Remove this value").click_accesskit();
        h.run();
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:visits")
                .unwrap()
                .as_deref(),
            Some("5")
        );
        h.get_by_label("Back").click();
        h.run();
        assert!(h.state().history_of.is_none());
    }

    #[test]
    fn the_weight_history_draws_a_graph_and_a_new_field_comes_from_the_page() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "history-reverts"));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_by_label_contains(" kg").click_secondary();
        h.step();
        h.get_by_label("History").click_accesskit();
        h.run();
        h.get_by_label("Smoothed").click();
        h.run();
        h.get_by_label("Trend").click();
        h.run();
        h.get_by_label_contains("per month");
        assert_eq!(
            h.state().store().local_setting("graphSmooth").as_deref(),
            Some("yes")
        );
        h.get_by_label("Show corrected and removed values").click();
        h.run();
        assert!(
            h.get_all_by_label_contains(" kg").count() >= 5,
            "hidden rows show on request"
        );
        h.get_by_label("Back").click();
        h.run();
        h.get_by_label("New field").click();
        h.run();
        assert!(h.state().new_field.open);
        h.state_mut().new_field.name = "Mood".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert!(h.state().store().field_def("mood").unwrap().is_some());
        h.get_by_label("Mood");
    }

    #[test]
    fn an_id_field_shows_its_code_and_a_registry_link() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "fields-all"));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_by_label("DE-123 456");
        h.get_by_label("276098100123456");
    }

    #[test]
    fn the_map_shows_pins_and_stray_areas_and_remembers_its_viewport() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "moves"));
        h.run();
        h.get_by_label("View").click();
        h.step();
        h.get_by_label("Map").click();
        h.run_steps(3);
        assert_eq!(*h.state().selection(), Selection::Map);
        let pins = MapPage::pins(h.state().store(), None, &std::collections::HashSet::new());
        assert_eq!(
            pins.iter().map(|p| p.label.as_str()).collect::<Vec<_>>(),
            vec!["Miezi"]
        );
        h.get_by_label("Possible stray area").click();
        h.run_steps(3);
        h.get_by_label("Miezi").click();
        h.run_steps(3);
        assert!(
            h.state()
                .map_page
                .stray_areas
                .contains("cat:00000000-0000-4000-8000-000000000001")
        );
        assert!(
            h.state()
                .store()
                .local_setting(crate::map_page::VIEWPORT_KEY)
                .is_some()
        );
        // Focus from a Cat page jumps to its position with its trail.
        let app = h.state_mut();
        app.map_page
            .focus(&app.store, "cat:00000000-0000-4000-8000-000000000001");
        assert_eq!(h.state().map_page.map.viewport.zoom, 15);
        assert_eq!(
            h.state().map_page.trail_of.as_deref(),
            Some("cat:00000000-0000-4000-8000-000000000001")
        );
        assert_eq!(MapPage::missing_cats(h.state().store()).len(), 1);
    }

    #[test]
    fn a_location_is_picked_on_the_map_and_a_sighting_recorded() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "fields-all"));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        // The Location row's editor offers the map.
        h.get_by_label("On the map").click_secondary();
        h.step();
        h.get_by_label("Edit value").click_accesskit();
        h.run();
        h.get_by_label("Pick on map").click();
        h.run_steps(3);
        assert!(h.state().picker.open);
        h.state_mut().picker.query = "Leipzig".into();
        h.run_steps(2);
        h.get_by_label("Search").click();
        h.run_steps(3);
        h.get_by_label_contains("Leipzig, Sachsen");
        assert_eq!(
            h.state().picker.map.viewport.zoom,
            10,
            "a city-sized extent"
        );
        h.state_mut().picker.picked = Some((51.34, 12.37));
        h.run_steps(2);
        h.get_by_label("OK").click();
        h.run_steps(3);
        assert_eq!(h.state().editor.text, "51.34,12.37");
        h.get_by_label("Save").click();
        h.run();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        assert_eq!(
            h.state().store().position_of(miezi).unwrap(),
            Some((51.34, 12.37))
        );
        // Seen here now: the picker again, this time a sighting.
        h.get_by_label("Actions").click();
        h.step();
        h.get_by_label("Seen here now").click();
        h.run_steps(3);
        assert!(h.state().picker.open);
        h.state_mut().picker.picked = Some((51.35, 12.38));
        h.run_steps(2);
        h.get_by_label("OK").click();
        h.run_steps(3);
        assert_eq!(
            h.state().store().sighting_position_of(miezi).unwrap(),
            Some((51.35, 12.38))
        );
        h.get_by_label("Sighting recorded at your position.");
        h.state_mut().picker.query = "nowhere".into();
        h.state_mut().picker.search();
        assert!(h.state().picker.error.is_some());
        // Show on map lands on the Cat.
        h.get_by_label("Actions").click();
        h.step();
        h.get_by_label("Show on map").click();
        h.run_steps(3);
        assert_eq!(*h.state().selection(), Selection::Map);
    }

    #[test]
    fn a_cat_moves_between_clowders_and_to_the_street() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_by_label("Actions").click();
        h.step();
        h.get_by_label("Move to").click();
        h.run();
        assert!(h.state().mover.open);
        // The list pane says "Barn" too; the dialog's radio comes last.
        h.get_all_by_label("Barn").last().unwrap().click();
        h.run();
        h.state_mut().mover.as_of = "2026-03-01".into();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        assert_eq!(
            h.state()
                .store()
                .current(miezi, keys::CLOWDER)
                .unwrap()
                .as_deref(),
            Some("clowder:00000000-0000-4000-8000-000000000002")
        );
        h.get_by_label("Actions").click();
        h.step();
        h.get_by_label("Move to").click();
        h.run();
        h.get_by_label("No clowder — stray / ran away").click();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        assert_eq!(
            h.state().store().current(miezi, keys::CLOWDER).unwrap(),
            None
        );
        assert_eq!(h.state().store().strays().unwrap().len(), 2);
    }

    #[test]
    fn the_row_menu_hides_and_the_view_menu_shows_hidden_again() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.state_mut().act(HomeAction::ToggleHidden(
            "clowder:00000000-0000-4000-8000-000000000002".into(),
        ));
        h.run();
        assert!(h.query_by_label("Barn").is_none(), "hidden on this device");
        h.get_by_label("View").click();
        h.step();
        h.get_by_label("Show hidden").click();
        h.run();
        h.get_by_label("Barn");
        h.state_mut().act(HomeAction::ToggleHidden(
            "clowder:00000000-0000-4000-8000-000000000002".into(),
        ));
        h.run();
        assert!(
            !h.state()
                .store()
                .is_hidden("clowder:00000000-0000-4000-8000-000000000002")
                .unwrap()
        );
        h.state_mut().act(HomeAction::ToggleFavourite(
            "clowder:00000000-0000-4000-8000-000000000001".into(),
        ));
        assert_eq!(
            h.state()
                .store()
                .local_setting("fav:clowder:00000000-0000-4000-8000-000000000001")
                .as_deref(),
            Some("yes")
        );
    }

    #[test]
    fn a_new_clowder_comes_from_the_dialog_and_is_selected() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(app(dir.path(), "en", true));
        h.run();
        h.get_by_label("New clowder").click();
        h.run();
        h.state_mut().dialog.value = "Barn".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(h.state().store().clowders().unwrap()[0].name, "Barn");
        assert!(matches!(h.state().selection(), Selection::Clowder(_)));
        assert!(h.query_by_label("Pick a clowder on the left").is_none());
        assert_eq!(h.get_all_by_label("Barn").count(), 2);
    }

    #[test]
    fn catalogs_are_created_renamed_and_switched_from_the_menu() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("New catalog").click();
        h.run();
        h.state_mut().dialog.value = "Clowders".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert!(h.state().dialog.open, "a taken name is refused");
        h.get_by_label_contains("already exists");
        h.state_mut().dialog.value = "Leipzig".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(h.state().title(), "Leipzig");
        assert_eq!(h.state().manager().catalogs().len(), 2);
        h.get_by_label("No clowders yet. A clowder is a place where cats live — your foster home, an adopter's flat. Create the first one below.");
        // Rename the open one.
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("Rename catalog").click();
        h.run();
        h.state_mut().dialog.value = "Leipzig Nord".into();
        h.run();
        h.get_by_label("Rename").click();
        h.run();
        assert_eq!(h.state().title(), "Leipzig Nord");
        // Switch back to the first, which still holds its Clowders.
        h.get_by_label("Catalog").click();
        h.step();
        // The pane heading says "Clowders" too; the menu entry comes last.
        h.get_all_by_label("Clowders").last().unwrap().click();
        h.run();
        assert_eq!(h.state().title(), "Clowders");
        h.get_by_label("Foster Home");
        assert_eq!(new_uuid().len(), 36);
        assert_eq!(catalogs_root(Path::new("/x")), Path::new("/x"));
    }

    /// A PNG file on disk to add as a photo.
    fn picture_file(dir: &std::path::Path, name: &str, w: u32, h: u32) -> PathBuf {
        let img = image::DynamicImage::new_rgb8(w, h);
        let mut out = Vec::new();
        img.write_to(&mut std::io::Cursor::new(&mut out), image::ImageFormat::Png)
            .unwrap();
        let path = dir.join(name);
        std::fs::write(&path, out).unwrap();
        path
    }

    #[test]
    fn photos_come_from_the_file_dialog_and_from_dropped_files() {
        let dir = tempfile::tempdir().unwrap();
        let picked = picture_file(dir.path(), "picked.png", 30, 20);
        let dropped = picture_file(dir.path(), "dropped.png", 20, 30);
        let mut app = seeded(dir.path());
        let hand = picked.clone();
        app.pick_files = Box::new(move |_| vec![hand.clone()]);
        let mut h = harness(app);
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        assert_eq!(h.state().store().images(miezi).unwrap().len(), 2);
        h.get_by_label("Add photo").click();
        h.run();
        assert_eq!(h.state().store().images(miezi).unwrap().len(), 3);
        h.get_by_label("1 photo(s) added to Miezi");
        // A file dropped on the page lands too; a junk file is refused
        // with its name in the notice.
        h.input_mut().dropped_files.push(egui::DroppedFile {
            path: Some(dropped),
            ..Default::default()
        });
        h.run();
        assert_eq!(h.state().store().images(miezi).unwrap().len(), 4);
        let junk = dir.path().join("junk.png");
        std::fs::write(&junk, b"not a picture").unwrap();
        h.input_mut().dropped_files.push(egui::DroppedFile {
            path: Some(junk),
            ..Default::default()
        });
        h.run();
        assert_eq!(h.state().store().images(miezi).unwrap().len(), 4);
        h.get_by_label_contains("junk.png");
        // Every stored photo is a stripped JPEG.
        for hash in h.state().store().images(miezi).unwrap() {
            let bytes = h.state().store().image_bytes(&hash).unwrap();
            assert!(bytes.starts_with(&[0xFF, 0xD8]));
            assert!(!catlog_core::photo::has_jpeg_metadata(&bytes));
        }
    }

    #[test]
    fn the_photo_menu_sets_the_profile_crops_marks_and_deletes() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let images = h.state().store().images(miezi).unwrap();
        assert_eq!(images.len(), 2);
        assert_eq!(
            h.state().store().profile_image(miezi).unwrap().as_deref(),
            Some(images[1].as_str())
        );
        // The first photo becomes the Profile Image.
        h.get_by_label("Photos 1").click_secondary();
        h.step();
        h.get_by_label("Set as profile image").click_accesskit();
        h.run();
        assert_eq!(
            h.state().store().profile_image(miezi).unwrap().as_deref(),
            Some(images[0].as_str())
        );
        // Crop: the editor opens, a selection is dragged, the verb adds a
        // new photo and the original stays.
        h.get_by_label("Photos 1").click_secondary();
        h.step();
        h.get_by_label("Crop…").click_accesskit();
        h.run();
        assert!(h.state().photo_editor.open);
        assert_eq!(h.state().photo_editor.mode, Some(EditMode::Crop));
        h.get_by_label("Drag a rectangle around the cat");
        h.state_mut().photo_editor.selection =
            Some((egui::Vec2::new(0.1, 0.1), egui::Vec2::new(0.9, 0.9)));
        h.run();
        h.get_by_label("Crop").click();
        h.run();
        assert!(!h.state().photo_editor.open);
        assert_eq!(h.state().store().images(miezi).unwrap().len(), 3);
        h.get_by_label("Photo added");
        // Mark: the ellipse is baked into a fourth photo.
        h.get_by_label("Photos 1").click_secondary();
        h.step();
        h.get_by_label("Mark…").click_accesskit();
        h.run();
        assert_eq!(h.state().photo_editor.mode, Some(EditMode::Mark));
        h.get_by_label("Drag an ellipse over the cat");
        h.state_mut().photo_editor.selection =
            Some((egui::Vec2::new(0.2, 0.2), egui::Vec2::new(0.8, 0.8)));
        h.run();
        h.get_by_label("Done").click();
        h.run();
        assert_eq!(h.state().store().images(miezi).unwrap().len(), 4);
        // A sliver refuses with a message and the editor stays open.
        h.get_by_label("Photos 1").click_secondary();
        h.step();
        h.get_by_label("Crop…").click_accesskit();
        h.run();
        h.state_mut().photo_editor.selection =
            Some((egui::Vec2::new(0.5, 0.5), egui::Vec2::new(0.501, 0.501)));
        h.run();
        h.get_by_label("Crop").click();
        h.run();
        assert!(h.state().photo_editor.open);
        h.get_by_label("Cancel").click();
        h.run();
        assert!(!h.state().photo_editor.open);
        // Delete asks once; Cancel keeps, Delete removes photo and bytes.
        h.get_by_label("Photos 4").click_secondary();
        h.step();
        h.get_by_label("Delete photo").click_accesskit();
        h.run();
        assert!(h.state().confirm.open);
        h.get_by_label("Cancel").click();
        h.run();
        assert_eq!(h.state().store().images(miezi).unwrap().len(), 4);
        h.get_by_label("Photos 4").click_secondary();
        h.step();
        h.get_by_label("Delete photo").click_accesskit();
        h.run();
        h.get_by_label("Delete").click();
        h.run();
        let left = h.state().store().images(miezi).unwrap();
        assert_eq!(left.len(), 3);
        h.get_by_label("Photo removed");
        // The dragged selection works through the pointer too.
        h.get_by_label("Photos 1").click_secondary();
        h.step();
        h.get_by_label("Crop…").click_accesskit();
        h.run();
        h.drag_at(egui::pos2(200.0, 200.0));
        h.step();
        h.hover_at(egui::pos2(500.0, 500.0));
        h.step();
        h.drop_at(egui::pos2(500.0, 500.0));
        h.run();
        assert!(h.state().photo_editor.rect().is_some(), "a drag selects");
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().photo_editor.open);
    }

    #[test]
    fn the_viewer_walks_the_photos_and_saves_one_to_a_file() {
        let dir = tempfile::tempdir().unwrap();
        let target = dir.path().join("saved.jpg");
        let mut app = seeded(dir.path());
        let hand = target.clone();
        app.save_file = Box::new(move |_, _| Some(hand.clone()));
        let mut h = harness(app);
        h.run();
        h.get_by_label("Foster Home").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_by_label("Photos 2").click();
        h.run();
        assert!(h.state().viewer.open);
        h.get_by_label("2 / 2");
        h.get_by_label("Next").click();
        h.run();
        h.get_by_label("1 / 2");
        h.key_press(egui::Key::ArrowLeft);
        h.run();
        h.get_by_label("2 / 2");
        h.get_by_label("Save photo as…").click();
        h.run();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let images = h.state().store().images(miezi).unwrap();
        assert_eq!(
            std::fs::read(&target).unwrap(),
            h.state().store().image_bytes(&images[1]).unwrap()
        );
        h.get_by_label("Close").click();
        h.run();
        assert!(!h.state().viewer.open);
        h.get_by_label("Photos 1").click();
        h.run();
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().viewer.open);
    }
}
