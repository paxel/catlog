//! The shell: a menu bar, the home pane on the left and a detail pane
//! on the right, the intro on first start. Everything the window shows
//! passes through [`App::show`], which the kittest harness drives.

use std::path::{Path, PathBuf};
use std::sync::Arc;
use std::time::{Duration, Instant};

use catlog_core::achievements::{LadderState, ladders};
use catlog_core::entities::PositionKind;
use catlog_core::flier::{HttpModels, Ocr, OcrsEngine};
use catlog_core::fonts::{FontSet, FontSource, HttpFonts};
use catlog_core::geocode::Geocoder;
use catlog_core::review::{needs_attention, review_import};
use catlog_core::sync::{UnseenChanges, WatchState};
use catlog_core::tiles::{TileCache, TileFetcher};
use catlog_core::{Catalog, CatalogManager, keys};
use egui::{Context, Ui};

use crate::agenda::{AgendaAction, AppointmentAction, ics_events, show_agenda};
use crate::appointments::{AppointmentDialog, FinishDialog};
use crate::capture_page::{CaptureAction, CapturePage};
use crate::cards::{CardAction, Desk};
use crate::cats_table::{CatsTable, TableAction};
use crate::chores::{ChoreAction, ChoreDialog, ChoreHistory};
use crate::clowders_table::{ClowdersTable, TableAction as ClowderAction};
use crate::conflicts::show_conflicts;
use crate::dashboard::{self, DashboardAction};
use crate::dialogs::{ConfirmDialog, NameDialog};
use crate::documents_page::{DocAction, DocKind, DocumentPage, card_png};
use crate::duplicates_page::{DuplicatesAction, show_duplicates};
use crate::editor::{EditTarget, FieldEditor, apply_edit};
use crate::graph_image::{graph_image, to_color_image};
use crate::history::{HistoryAction, HistoryPage};
use crate::home::{HomeAction, HomePane, Selection};
use crate::housekeeping::{
    HouseAction, Housekeeping, key_code, show_archive, show_backups, show_moderation, show_moments,
    show_restore,
};
use crate::icons;
use crate::in_person::{InPerson, InPersonAction};
use crate::l10n::{self, L10n};
use crate::map::MapView;
use crate::map_page::{MapPage, MapPageAction};
use crate::merge::{MergeDialog, MergeKind, TransferDialog, apply_merge};
use crate::move_dialog::MoveDialog;
use crate::new_field::NewFieldDialog;
use crate::notify::{DesktopNotifier, Notifier};
use crate::pages::{PageAction, Pages};
use crate::photos::{EditMode, PhotoEditor, PhotoViewer, ViewerAction};
use crate::picker::PositionPicker;
use crate::settings::{AppSettings, SettingsFile};
use crate::settings_page::{SettingsAction, SettingsPage, ladder_name, show_achievements};
use crate::sounds::{
    Cheer, SOUND_FILES, SoundChoice, Sounder, Speakers, keep_own, set_sound, sound_for,
};
use crate::summary::{ArrivalSummary, SummaryAction};
use crate::sync_page::{SyncAction, SyncPage};
use crate::textures::FaceCache;
use crate::tips;
use crate::vet::VetView;
use crate::views::{self, Modal, View};

/// What the keeper asked the shell to do; the launcher acts on it.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Request {
    None,
    Quit,
}

/// The window size the app opens with when nothing was remembered.
pub const DEFAULT_WINDOW_SIZE: [f32; 2] = [1200.0, 800.0];

/// The list pane's width when nothing was remembered.
pub const DEFAULT_PANE_WIDTH: f32 = 600.0;

/// A tip about to be spotlighted: its screen, its id and its text.
/// A tip due this frame: its page, its id, its words and whether it is
/// the page's last.
type TipSpot = (&'static str, &'static str, fn(&L10n) -> &'static str, bool);

/// Asks the keeper for files: the dialog's title, the extensions it
/// shows first and the words for "all files" in, the chosen paths out.
pub type FilePicker = Box<dyn FnMut(&str, &[&str], &str) -> Vec<PathBuf>>;

/// What the photo dialogs show.
pub const IMAGE_FILES: &[&str] = &["jpg", "jpeg", "png"];
/// What the bundle and restore dialogs show.
pub const BUNDLE_FILES: &[&str] = &["catsync"];
/// Asks the keeper where to save: title and suggested name in, the path out.
pub type FileSaver = Box<dyn FnMut(&str, &str) -> Option<PathBuf>>;
/// Asks the keeper for a folder: the dialog's title in, the folder out.
pub type FolderPicker = Box<dyn FnMut(&str) -> Option<PathBuf>>;
/// Hands a file to the system, which opens it in the viewer.
pub type FileOpener = Box<dyn FnMut(&Path)>;

/// The third-party notices shown under About.
pub const LICENCES: &str = concat!(
    include_str!("../../../THIRD-PARTY.md"),
    "\n\n",
    include_str!("../../../../assets/sounds/LICENSES.md")
);

/// How often the shared folder is looked at while the app runs.
const WATCH_EVERY: Duration = Duration::from_secs(5 * 60);

/// Which dialog is up, and what its answer means.
#[derive(Debug, Clone, PartialEq, Eq)]
enum Asking {
    Nothing,
    NewClowder,
    NewCatalog,
    RenameCatalog,
    NameMoment,
    /// A new Cat in this Clowder, or a Stray.
    NewCat(Option<String>),
}

pub struct App {
    settings: SettingsFile,
    t: L10n,
    manager: CatalogManager,
    store: Catalog,
    home: HomePane,
    /// The Cats view's table.
    pub cats: CatsTable,
    /// The Clowders view's table.
    pub clowders: ClowdersTable,
    /// The cards on the desk beside them.
    pub desk: Desk,
    /// The Vet view.
    pub vet: VetView,
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
    pub pick_folder: FolderPicker,
    pub sync_page: SyncPage,
    /// The in-person host, serving while its modal is open.
    pub in_person: InPerson,
    pub summary: ArrivalSummary,
    /// Changes waiting in the folder, shown on the watch line.
    pub watch_pending: Option<UnseenChanges>,
    /// The partners' file sizes when the line was put away with "Not now".
    watch_dismissed: Option<WatchState>,
    watch_sizes: WatchState,
    last_check: Instant,
    was_focused: bool,
    pub chore_dialog: ChoreDialog,
    pub chore_history: ChoreHistory,
    pub appointment_dialog: AppointmentDialog,
    pub finish_dialog: FinishDialog,
    /// The chore the confirm dialog is about to end.
    ending_chore: Option<catlog_core::chores::Chore>,
    pub notifier: Box<dyn Notifier>,
    pub merge_dialog: MergeDialog,
    pub house: Housekeeping,
    pub document: DocumentPage,
    pub capture: CapturePage,
    geocoder: Arc<dyn Geocoder>,
    pub settings_page: SettingsPage,
    /// The machine's country code, for the units.
    pub region: Option<String>,
    pub sounder: Box<dyn Sounder>,
    /// The ladders as last computed, for the Achievements page and the
    /// title choice.
    ladders: Vec<LadderState>,
    /// A report from a run that went down, until it is sent.
    pub crash_report: Option<String>,
    /// The view in the bar.
    pub view: View,
    /// What is open over the desk.
    pub modal: Option<Modal>,
    /// The selection as last remembered for the dashboard.
    shown: Selection,
    /// Counts the view switches, so each one fades in anew.
    view_opened: u32,
    /// How often the name dice was thrown, so two throws in one moment
    /// still differ.
    roll: u64,
    /// Counts the modals opened, for the same reason; and the histories
    /// apart, so a history over a page leaves the page as it is.
    modal_opened: u32,
    history_opened: u32,
    /// The tip due this frame with a widget to point at, drawn as the
    /// spotlight once everything else is on screen.
    tip_spot: Option<TipSpot>,
    /// No tips at all: the behaviour tests, whose clicks the spotlight
    /// would lie under.
    pub tips_quiet: bool,
    /// Where the menu and the bar end, below which a tip's bubble sits.
    bar_bottom: f32,
    icon: Option<egui::TextureHandle>,
    fonts_installed: Option<String>,
    /// Opens a link in the browser or the mail program.
    pub open_url: Box<dyn FnMut(&str)>,
    /// Text recognition; the ocrs engine outside tests.
    pub ocr: Arc<dyn Ocr>,
    /// A recognition running on its thread, and its answer.
    recognizing:
        Option<std::sync::mpsc::Receiver<Result<Vec<catlog_core::flier::FlierLine>, String>>>,
    /// The fonts for the current language, once built.
    fonts: Option<(String, FontSet)>,
    pub font_source: Box<dyn FontSource>,
    pub open_file: FileOpener,
    /// Where backups are written; the Downloads folder outside tests.
    pub backups_dir: PathBuf,
    /// Where the app keeps what is its own, an own sound among it.
    pub data_dir: PathBuf,
    restore_sets: Vec<catlog_core::backup::BackupSet>,
    going_back: Option<catlog_core::moments::Moment>,
    archiving: Option<Vec<String>>,
    hard_deleting: Option<(String, String)>,
    deleting_catalog: bool,
    pub transfer_dialog: TransferDialog,
    /// The wall clock, replaceable in tests.
    pub now: Box<dyn Fn() -> chrono::NaiveDateTime>,
    /// Reminders sound once: the moment the last check ran.
    last_reminder_check: chrono::NaiveDateTime,
    /// The dashboard's and the agenda's data between frames.
    dashboard_memo: dashboard::DashboardMemo,
    agenda_memo: crate::agenda::AgendaMemo,
    asking: Asking,
    /// The name typed on the intro page.
    intro_name: String,
    request: Request,
    /// What went wrong last, shown in the detail pane until the next action.
    notice: Option<String>,
    /// The context of the frame being drawn, for the clipboard.
    ctx: Option<Context>,
}

impl App {
    /// The app over the settings in `settings` and the Catalogs under
    /// `root`, its language from the settings or the system.
    pub fn open(settings: SettingsFile, root: &Path) -> catlog_core::Result<App> {
        let tiles = TileCache::open(
            &root.join("tiles"),
            Box::new(catlog_core::tiles::OsmTiles::new()),
        )?;
        let mut app = Self::open_with(
            settings,
            root,
            Arc::new(TileFetcher::new(Arc::new(tiles))),
            Arc::new(catlog_core::geocode::Nominatim),
        )?;
        // The region decides the units when nothing was chosen; tests
        // stay metric whatever the machine says.
        app.region = sys_locale::get_locale()
            .and_then(|l| l.split(['-', '_']).nth(1).map(|c| c.to_uppercase()));
        app.apply_units();
        Ok(app)
    }

    /// [`App::open`] with the map's sources handed in: tests use
    /// stand-ins that never touch the network.
    pub fn open_with(
        settings: SettingsFile,
        root: &Path,
        tiles: Arc<TileFetcher>,
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
        let mut app = App {
            t,
            pane_width: settings.settings.pane_width.unwrap_or(DEFAULT_PANE_WIDTH),
            intro_name: settings.settings.author.clone().unwrap_or_default(),
            settings,
            manager,
            store,
            home: HomePane::default(),
            cats: CatsTable::default(),
            clowders: ClowdersTable::default(),
            desk: Desk::default(),
            vet: VetView::default(),
            pages: Pages::default(),
            editor: FieldEditor::closed(),
            new_field: NewFieldDialog::default(),
            history: HistoryPage::default(),
            history_of: None,
            map_page: MapPage::new(MapView::new(tiles.clone())).with_geocoder(geocoder.clone()),
            picker: PositionPicker::new(tiles, geocoder.clone()),
            geocoder,
            sighting_for: None,
            mover: MoveDialog::default(),
            faces: FaceCache::default(),
            dialog: NameDialog::default(),
            confirm: ConfirmDialog::default(),
            deleting_photo: None,
            viewer: PhotoViewer::default(),
            photo_editor: PhotoEditor::default(),
            pick_files: Box::new(|title, extensions, all_files| {
                // The fitting kinds lead; every file stays a choice away.
                let filter = extensions
                    .iter()
                    .map(|e| e.to_uppercase())
                    .collect::<Vec<_>>()
                    .join(", ");
                rfd::FileDialog::new()
                    .set_title(title)
                    .add_filter(filter, extensions)
                    .add_filter(all_files, &["*"])
                    .pick_files()
                    .unwrap_or_default()
            }),
            save_file: Box::new(|title, name| {
                rfd::FileDialog::new()
                    .set_title(title)
                    .set_file_name(name)
                    .save_file()
            }),
            pick_folder: Box::new(|title| rfd::FileDialog::new().set_title(title).pick_folder()),
            sync_page: SyncPage::default(),
            in_person: InPerson::default(),
            summary: ArrivalSummary::default(),
            watch_pending: None,
            watch_dismissed: None,
            watch_sizes: WatchState::default(),
            last_check: Instant::now(),
            was_focused: false,
            chore_dialog: ChoreDialog::default(),
            chore_history: ChoreHistory::default(),
            appointment_dialog: AppointmentDialog::default(),
            finish_dialog: FinishDialog::default(),
            ending_chore: None,
            notifier: Box::new(DesktopNotifier),
            merge_dialog: MergeDialog::default(),
            house: Housekeeping::default(),
            document: DocumentPage::default(),
            capture: CapturePage::default(),
            settings_page: SettingsPage::default(),
            region: None,
            sounder: Box::new(Speakers),
            ladders: Vec::new(),
            crash_report: crate::crash::last_crash(root),
            view: View::Home,
            modal: None,
            shown: Selection::None,
            view_opened: 0,
            roll: 0,
            modal_opened: 0,
            history_opened: 0,
            tip_spot: None,
            tips_quiet: false,
            bar_bottom: 0.0,
            icon: None,
            fonts_installed: None,
            open_url: Box::new(|url| {
                if let Err(e) = open::that_detached(url) {
                    eprintln!("catlog: open: {e}");
                }
            }),
            ocr: Arc::new(OcrsEngine::new(&root.join("ocr"), Box::new(HttpModels))),
            recognizing: None,
            fonts: None,
            font_source: Box::new(HttpFonts),
            open_file: Box::new(|path| {
                if let Err(e) = open::that_detached(path) {
                    eprintln!("catlog: open: {e}");
                }
            }),
            backups_dir: crate::settings::backups_dir(),
            data_dir: crate::settings::data_dir(),
            restore_sets: Vec::new(),
            going_back: None,
            archiving: None,
            hard_deleting: None,
            deleting_catalog: false,
            transfer_dialog: TransferDialog::default(),
            now: Box::new(|| chrono::Local::now().naive_local()),
            last_reminder_check: chrono::Local::now().naive_local(),
            dashboard_memo: dashboard::DashboardMemo::default(),
            agenda_memo: crate::agenda::AgendaMemo::default(),
            asking: Asking::Nothing,
            request: Request::None,
            ctx: None,
            notice: None,
        };
        app.apply_units();
        Ok(app)
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
        match selection {
            Selection::Cat(id) | Selection::Clowder(id) => self.open_record(id),
            other => {
                self.home.selection = other;
                self.history_of = None;
            }
        }
    }

    pub fn view(&self) -> View {
        self.view
    }

    pub fn modal(&self) -> Option<Modal> {
        self.modal.clone()
    }

    /// Switches the bar to `view`; Cats and Clowders keep what lies on
    /// the desk. The new view fades in.
    pub fn open_view(&mut self, view: View) {
        if view != self.view {
            self.view_opened += 1;
        }
        self.view = view;
        self.notice = None;
        self.history_of = None;
    }

    /// Opens `modal` over the desk; it fades in.
    pub fn open_modal(&mut self, modal: Modal) {
        self.modal = Some(modal);
        self.modal_opened += 1;
        self.notice = None;
    }

    /// Shows a Cat's or a Clowder's page on the desk, in the Cats or
    /// the Clowders view, whichever is open or fits.
    pub fn open_record(&mut self, id: String) {
        let is_clowder = id.starts_with("clowder:");
        if !matches!(self.view, View::Cats | View::Clowders) {
            self.view = if is_clowder {
                View::Clowders
            } else {
                View::Cats
            };
        }
        self.desk.open(&self.store, std::slice::from_ref(&id));
        self.home.selection = if is_clowder {
            Selection::Clowder(id)
        } else {
            Selection::Cat(id)
        };
        self.history_of = None;
        self.modal = None;
    }

    /// Shows a Field's history on an entity in the detail pane.
    /// Reads every path as a picture and stores it on the Cat, compressed
    /// and stripped as the phone does; the notice says how many landed
    /// or what went wrong with the first that did not.
    /// Makes the picture at `path` the cover of a Clowder, in place of
    /// the one before: a place has one picture, stored as its profile
    /// image so it travels like its other values.
    pub fn set_cover(&mut self, clowder: &str, path: &Path) {
        let old = self.store.profile_image(clowder).ok().flatten();
        let result = std::fs::read(path)
            .map_err(|e| e.to_string())
            .and_then(|raw| {
                self.store
                    .add_photo(clowder, &raw)
                    .map_err(|e| e.to_string())
            });
        match result {
            Ok(hash) => {
                if let Err(e) = self.store.set_profile_image(clowder, &hash) {
                    self.notice = Some(e.to_string());
                }
                if let Some(old) = old
                    && old != hash
                    && let Err(e) = self.store.delete_image(clowder, &old)
                {
                    self.notice = Some(e.to_string());
                }
            }
            Err(e) => self.notice = Some(format!("{}: {e}", path.display())),
        }
    }

    /// Drops a Clowder's cover; its card falls back to the house icon.
    pub fn remove_cover(&mut self, clowder: &str) {
        if let Some(hash) = self.store.profile_image(clowder).ok().flatten()
            && let Err(e) = self.store.delete_image(clowder, &hash)
        {
            self.notice = Some(e.to_string());
        }
    }

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
        crate::theme::install(ctx);
    }

    /// Installs the fonts for the current language once, and again
    /// when the language changes. New fonts bind at the next pass, so
    /// the pass that sets them is discarded and run again: true when the
    /// caller should draw nothing this pass.
    fn install_fonts(&mut self, ctx: &Context) -> bool {
        let language = self.t.locale().to_string();
        if self.fonts_installed.as_deref() == Some(language.as_str()) {
            return false;
        }
        let set = self.fonts().clone();
        ctx.set_fonts(crate::theme::fonts(&set));
        ctx.request_discard("fonts installed");
        self.fonts_installed = Some(language);
        true
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
        let _ = self.store.auto_backup(&self.backups_dir, false);
        self.store = store;
        self.manager.set_active(id)?;
        self.home.selection = Selection::None;
        self.desk.reset();
        self.faces = FaceCache::default();
        self.watch_pending = None;
        self.watch_dismissed = None;
        self.sync_page = SyncPage::default();
        self.in_person.stop();
        self.modal = self.modal.take().filter(|m| *m != Modal::InPerson);
        Ok(())
    }

    /// One watch round over the chosen folder: merges on its own when
    /// the switch says so, otherwise shows the line. Quiet without a
    /// folder, with the watch off, or after "Not now" until a file grows
    /// again.
    pub fn check_folder(&mut self) {
        self.last_check = Instant::now();
        if !self.store.sync_watch_on() {
            return;
        }
        let Some(folder) = self.store.sync_folder_path() else {
            return;
        };
        let Ok(check) = self.store.check_sync_folder(&folder) else {
            return;
        };
        if check.photos_in > 0 {
            self.faces = FaceCache::default();
        }
        self.watch_sizes = check.state.clone();
        let Some(pending) = check.pending else {
            self.watch_pending = None;
            return;
        };
        if let Some(dismissed) = &self.watch_dismissed
            && !dismissed.moved_on(&check.state)
        {
            return;
        }
        self.watch_dismissed = None;
        if self.store.sync_auto_on() {
            self.run_sync();
        } else {
            self.watch_pending = Some(pending);
        }
    }

    /// One round through the chosen folder, the result on the Sync page
    /// and the summary window when something arrived.
    pub fn run_sync(&mut self) {
        let t = self.t;
        self.sync_page.syncing = false;
        self.watch_pending = None;
        match self.store.sync_chosen_folder() {
            Ok((round, _moment)) => {
                self.sync_page.folder_result = Some(t.folder_synced(&round.to_string()));
                self.faces = FaceCache::default();
                self.open_summary(&round.applied, round.report);
            }
            Err(catlog_core::Error::Invalid(e)) if e.contains("unreachable") => {
                self.sync_page.folder_result = Some(t.folder_unreachable().to_string());
            }
            Err(e) => {
                self.sync_page.folder_result = Some(t.folder_sync_failed(&e.to_string()));
            }
        }
    }

    fn open_summary(
        &mut self,
        applied: &[catlog_core::Entry],
        report: catlog_core::signing::ImportReport,
    ) {
        if applied.is_empty() && !needs_attention(&report) {
            return;
        }
        match review_import(&self.store, applied, report) {
            Ok(review) => self.summary.open_with(review, applied.to_vec()),
            Err(e) => self.notice = Some(e.to_string()),
        }
    }

    /// Imports a `.catsync` file: from the Sync page, a drop on the
    /// window, or the file the app was started with.
    pub fn open_bundle_file(&mut self, path: &Path) {
        let t = self.t;
        let label = path.file_name().map(|n| n.to_string_lossy().into_owned());
        self.modal = Some(Modal::Sync);
        match self
            .store
            .import_with_moment(path, "import", label.as_deref())
        {
            Ok((result, _moment)) => {
                if result.applied.is_empty()
                    && result.blobs_in == 0
                    && !needs_attention(&result.report)
                {
                    self.sync_page.bundle_result = Some(t.nothing_new_in_bundle().to_string());
                } else {
                    self.sync_page.bundle_result = Some(t.bundle_imported(&format!(
                        "{} entries + {} photos in",
                        result.entries_in, result.blobs_in
                    )));
                    self.faces = FaceCache::default();
                    self.open_summary(&result.applied, result.report);
                }
            }
            Err(e) => {
                self.sync_page.bundle_result = Some(t.bundle_import_failed(&e.to_string()));
            }
        }
    }

    /// Writes the Catalog as a `.catsync` file where the keeper says.
    fn export_bundle(&mut self) {
        let t = self.t;
        let name = format!("{}.catsync", self.title());
        let Some(path) = (self.save_file)(t.export_bundle(), &name) else {
            return;
        };
        self.sync_page.bundle_result = Some(
            match self.store.write_bundle(&path, self.store.sync_private_on()) {
                Ok(()) => t.bundle_written(&path.to_string_lossy()),
                Err(e) => t.sync_failed(&e.to_string()),
            },
        );
    }

    /// The name is taken and the desk opens, with the tips or without.
    fn finish_intro(&mut self, with_tips: bool) {
        let name = self.intro_name.trim().to_string();
        if name.is_empty() {
            return;
        }
        self.settings.settings.author = Some(name.clone());
        self.settings.settings.intro_seen = true;
        if !with_tips {
            self.settings.settings.tips_seen = vec!["all".into()];
            tips::mark_all_seen(&self.store);
        }
        let _ = self.settings.save();
        let _ = self.store.set_author(&name);
    }

    /// Draws the whole window into `ui`.
    pub fn show(&mut self, ui: &mut Ui) {
        self.ctx = Some(ui.ctx().clone());
        if self.install_fonts(ui.ctx()) {
            return;
        }
        crate::motion::set(ui.ctx(), self.settings.settings.eye_candy);
        if !self.settings.settings.intro_seen {
            self.show_intro(ui);
            return;
        }
        // A round asked for last frame runs now, after "Syncing…" painted.
        if self.sync_page.syncing {
            self.run_sync();
        }
        self.poll_host(ui.ctx());
        let focused = ui.input(|i| i.focused);
        if (focused && !self.was_focused) || self.last_check.elapsed() >= WATCH_EVERY {
            self.check_folder();
        }
        self.was_focused = focused;
        self.pages.today = (self.now)().date();
        self.fire_reminders();
        ui.ctx().request_repaint_after(Duration::from_secs(60));
        self.show_menu_bar(ui);
        let t = self.t;
        self.show_watch_line(ui);
        self.show_tip();
        let bar = egui::Panel::top("view-bar")
            .show_separator_line(true)
            .show(ui, |ui| {
                if let Some(view) = views::show_bar(ui, &t, self.view) {
                    self.open_view(view);
                }
            });
        self.bar_bottom = bar.response.rect.max.y;
        // Every view opens with its name, so the bar's choice reads on
        // the page itself and the content starts below a line of air.
        egui::Panel::top("view-headline")
            .show_separator_line(false)
            .show(ui, |ui| {
                ui.add_space(8.0);
                ui.heading(self.view.label(&t));
                ui.add_space(4.0);
            });
        let mut page_action = PageAction::None;
        // In the Cats and Clowders views the table moves into a left pane
        // once cards lie on the desk. The pane opens at the remembered
        // width; a drag that ends is what gets remembered.
        self.desk.load(&self.store);
        let tabled = matches!(self.view, View::Cats | View::Clowders);
        let cards_open = tabled && !self.desk.open.is_empty();
        if cards_open {
            let pane = egui::Panel::left("table-pane")
                .resizable(true)
                .min_size(320.0)
                .default_size(self.pane_width)
                .show(ui, |ui| {
                    page_action = if self.view == View::Cats {
                        self.show_cats_table(ui)
                    } else {
                        self.show_clowders_table(ui)
                    };
                });
            let shown = pane.response.rect.width();
            let released = ui.input(|i| i.pointer.primary_released());
            if released && shown > 0.0 && Some(shown) != self.settings.settings.pane_width {
                self.settings.settings.pane_width = Some(shown);
                let _ = self.settings.save();
            }
        }
        egui::CentralPanel::default().show(ui, |ui| {
            // A view fades in when the bar switches to it.
            let fade = crate::motion::fade_in(ui.ctx(), ("view", self.view, self.view_opened));
            ui.set_opacity(fade);
            if let Some(notice) = &self.notice {
                ui.colored_label(ui.visuals().error_fg_color, notice);
            }
            let hovering = ui.input(|i| !i.raw.hovered_files.is_empty());
            if hovering && !matches!(self.home.selection, Selection::None) {
                ui.colored_label(ui.visuals().selection.bg_fill, t.drop_photos_hint());
            }
            match self.view {
                View::Home => {
                    let today = self.pages.today;
                    let units = self.pages.units;
                    match dashboard::show_dashboard(
                        ui,
                        &self.store,
                        &t,
                        &mut self.faces,
                        &mut self.dashboard_memo,
                        today,
                        units,
                    ) {
                        DashboardAction::None => {}
                        DashboardAction::OpenCats => self.open_view(View::Cats),
                        DashboardAction::OpenMissing => {
                            self.open_view(View::Cats);
                            self.cats.strays_only = false;
                            self.cats.missing_only = true;
                        }
                        DashboardAction::OpenClowders => self.open_view(View::Clowders),
                        DashboardAction::OpenStrays => self.open_strays(),
                        DashboardAction::OpenCat(id) | DashboardAction::OpenClowder(id) => {
                            page_action = PageAction::OpenCat(id);
                        }
                        DashboardAction::Chore(a) => page_action = PageAction::Chore(a),
                        DashboardAction::Appointment(a) => {
                            page_action = PageAction::Appointment(a);
                        }
                    }
                }
                View::Vet => {
                    let today = self.pages.today;
                    let units = self.pages.units;
                    let last = match &self.home.selection {
                        Selection::Cat(id) => Some(id.clone()),
                        _ => None,
                    };
                    if let Some(a) = self.vet.show(
                        ui,
                        &self.store,
                        &t,
                        &mut self.faces,
                        today,
                        units,
                        last.as_deref(),
                    ) {
                        page_action = a;
                    }
                }
                View::Agenda => {
                    let today = self.pages.today;
                    match show_agenda(
                        ui,
                        &self.store,
                        &t,
                        &mut self.faces,
                        &mut self.agenda_memo,
                        today,
                    ) {
                        AgendaAction::None => {}
                        AgendaAction::Chore(a) => page_action = PageAction::Chore(a),
                        AgendaAction::Appointment(a) => page_action = PageAction::Appointment(a),
                        AgendaAction::NewAppointment => {
                            // On the agenda a new appointment starts from the
                            // first Cat; the dialog lets others come along.
                            if let Some(first) = self
                                .store
                                .cats(None)
                                .ok()
                                .and_then(|c| c.into_iter().next())
                            {
                                page_action = PageAction::NewAppointment(first.id);
                            }
                        }
                        AgendaAction::ExportIcs => self.export_ics(),
                        AgendaAction::OpenEntity(id) => page_action = PageAction::OpenCat(id),
                    }
                }
                View::Map => match self.map_page.show(ui, &self.store, &t) {
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
                View::Cats | View::Clowders => {
                    if cards_open {
                        let units = self.pages.units;
                        let desk = ui.max_rect();
                        match self
                            .desk
                            .show(ui, &mut self.store, &t, &mut self.faces, units, desk)
                        {
                            CardAction::None => {}
                            CardAction::Page(a) => page_action = a,
                            CardAction::OpenPage(id) => self.open_modal(Modal::Page(id)),
                            CardAction::Notice(e) => self.notice = Some(e),
                            CardAction::Opened(id) => self.home.selection = Selection::Cat(id),
                        }
                    } else if self.view == View::Cats {
                        page_action = self.show_cats_table(ui);
                    } else {
                        page_action = self.show_clowders_table(ui);
                    }
                }
            }
        });
        // The modal comes before the dialogs it may open, so a dialog
        // lies on top of it.
        self.show_modal(ui.ctx());
        self.show_history_modal(ui.ctx());
        self.act_page(page_action);
        self.show_chore_dialogs(ui.ctx());
        if let Some((loser, survivor, kind)) = self.merge_dialog.show(ui.ctx(), &t) {
            match apply_merge(&mut self.store, &loser, &survivor, kind) {
                Ok(()) => {
                    self.faces = FaceCache::default();
                    // The page of the merged-away record is gone: show the survivor.
                    if kind != MergeKind::Field {
                        self.open_record(survivor);
                    }
                }
                Err(e) => self.notice = Some(e.to_string()),
            }
        }
        if let Some((target, ids)) = self.transfer_dialog.show(ui.ctx(), &t) {
            self.transfer(&target, &ids);
        }
        // A dropped bundle is imported; other files dropped on a Cat's
        // page become its photos.
        let dropped: Vec<PathBuf> = ui.input(|i| {
            i.raw
                .dropped_files
                .iter()
                .filter_map(|f| f.path.clone())
                .collect()
        });
        let (bundles, pictures): (Vec<PathBuf>, Vec<PathBuf>) =
            dropped.into_iter().partition(|p| {
                p.extension()
                    .is_some_and(|e| e.eq_ignore_ascii_case("catsync"))
            });
        for bundle in &bundles {
            self.open_bundle_file(bundle);
        }
        // Dropped pictures become a cat's photos, or a clowder's cover.
        if !pictures.is_empty() {
            match self.home.selection.clone() {
                Selection::Cat(cat) => self.add_photos(&cat, &pictures),
                Selection::Clowder(clowder) => self.set_cover(&clowder, &pictures[0]),
                Selection::None => {}
            }
        }
        match self
            .summary
            .show(ui.ctx(), &self.store, &t, self.pages.units)
        {
            SummaryAction::None => {}
            SummaryAction::Reject => {
                let applied = std::mem::take(&mut self.summary.applied);
                if let Err(e) = self.store.discard_entries(&applied) {
                    self.notice = Some(e.to_string());
                }
                self.faces = FaceCache::default();
            }
            SummaryAction::Resolve(entity, field, kept) => {
                if let Err(e) = crate::conflicts::resolve(&mut self.store, &entity, &field, kept) {
                    self.notice = Some(e.to_string());
                }
            }
            SummaryAction::OpenEntity(id) => self.open_record(id),
        }
        if self.confirm.show(ui.ctx(), t.cancel()) {
            if let Some((cat, hash)) = self.deleting_photo.take() {
                match self.store.delete_image(&cat, &hash) {
                    Ok(()) => {
                        self.faces.forget(&hash);
                        self.notice = Some(t.photo_removed().to_string());
                    }
                    Err(e) => self.notice = Some(e.to_string()),
                }
            }
            if let Some(chore) = self.ending_chore.take() {
                let ended = catlog_core::chores::Chore {
                    ended: true,
                    ..chore
                };
                if let Err(e) = self.store.update_chore(&ended) {
                    self.notice = Some(e.to_string());
                }
            }
            if let Some(moment) = self.going_back.take() {
                self.go_back(&moment);
            }
            if let Some(ids) = self.archiving.take() {
                self.archive(&ids);
            }
            if let Some((author, device)) = self.hard_deleting.take() {
                self.hard_delete(&author, &device);
            }
            if std::mem::take(&mut self.deleting_catalog) {
                self.delete_active_catalog();
            }
        }
        if !self.confirm.open {
            self.deleting_photo = None;
            self.ending_chore = None;
            self.going_back = None;
            self.archiving = None;
            self.hard_deleting = None;
            self.deleting_catalog = false;
        }
        match self.viewer.show(ui.ctx(), &self.store, &t, &mut self.faces) {
            ViewerAction::None => {}
            ViewerAction::Copy(hash) => {
                if let Some(image) = self
                    .store
                    .image_bytes(&hash)
                    .and_then(|bytes| crate::textures::decode(&bytes))
                {
                    self.copy_image(image);
                }
            }
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
        // A move into a forever home is an adoption: the party plays.
        if self.mover.show(ui.ctx(), &mut self.store, &t)
            && let Some(target) = self.mover.target.clone()
            && self
                .store
                .current(&target, &keys::user_field("status"))
                .ok()
                .flatten()
                .as_deref()
                == Some("forever-home")
        {
            self.cheer(Cheer::Adoption);
        }
        if let Some(edit) = self.editor.show(ui.ctx(), &self.store, &t)
            && let Err(e) = apply_edit(&mut self.store, &self.editor, &edit)
        {
            self.notice = Some(e.to_string());
        }
        self.new_field.show(ui.ctx(), &mut self.store, &t);
        self.show_dialog(ui.ctx());
        self.show_spotlight(ui.ctx());
        self.remember_shown();
        self.show_crash_screen(ui.ctx());
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
        let value = self.dialog.show(ctx, t.cancel());
        if std::mem::take(&mut self.dialog.rolled) {
            self.roll += 1;
            if let Some(name) = crate::names::propose(
                &self.store,
                t.locale(),
                crate::names::roll_now().wrapping_add(self.roll),
            ) {
                self.dialog.value = name;
            }
        }
        let Some(value) = value else {
            return;
        };
        match self.asking.clone() {
            Asking::Nothing => {}
            Asking::NameMoment => {
                if let Err(e) =
                    self.store
                        .add_moment(catlog_core::moments::cause::MANUAL, Some(&value), None)
                {
                    self.notice = Some(e.to_string());
                }
            }
            Asking::NewCat(clowder) => {
                let id = format!("cat:{}", new_uuid());
                let species = if self
                    .store
                    .current(
                        crate::settings_page::PET_MODE_ENTITY,
                        crate::settings_page::PET_MODE_FIELD,
                    )
                    .ok()
                    .flatten()
                    .as_deref()
                    == Some("pets")
                {
                    ""
                } else {
                    "cat"
                };
                match self
                    .store
                    .create_cat(&id, &value, clowder.as_deref(), species)
                {
                    Ok(()) => self.open_record(id),
                    Err(e) => self.notice = Some(e.to_string()),
                }
            }
            Asking::NewClowder => {
                let id = format!("clowder:{}", new_uuid());
                match self.store.create_clowder(&id, &value) {
                    Ok(()) => self.open_record(id),
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
                    // One menu under the app's name for the app's own two
                    // items; no File with only Quit, no Edit with only Settings.
                    ui.menu_button(t.app_title(), |ui| {
                        if icons::button(ui, icons::SETTINGS_OUTLINED, t.settings()).clicked() {
                            self.open_settings();
                            ui.close();
                        }
                        if icons::button(ui, icons::LOGOUT, t.quit()).clicked() {
                            self.request = Request::Quit;
                        }
                    });
                    // The language lives on the Settings page, once.
                    ui.menu_button(t.menu_view(), |ui| {
                        if ui
                            .checkbox(&mut self.home.show_hidden, t.show_hidden_label())
                            .changed()
                        {
                            ui.close();
                        }
                    });
                    let catalog_menu = ui.menu_button(t.menu_catalog(), |ui| {
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
                        if icons::button(ui, icons::CREATE_NEW_FOLDER_OUTLINED, t.new_catalog())
                            .clicked()
                        {
                            self.asking = Asking::NewCatalog;
                            self.dialog.ask(
                                t.new_catalog(),
                                t.catalog_name_label(),
                                t.create(),
                                "",
                            );
                            ui.close();
                        }
                        if icons::button(ui, icons::DRIVE_FILE_RENAME_OUTLINE, t.rename_catalog())
                            .clicked()
                        {
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
                        if icons::button(ui, icons::ADD_HOME_OUTLINED, t.new_clowder()).clicked() {
                            self.act(HomeAction::NewClowder);
                            ui.close();
                        }
                        ui.separator();
                        if icons::button(ui, icons::HISTORY, t.go_back_title()).clicked() {
                            self.open_modal(Modal::Moments);
                            ui.close();
                        }
                        if icons::button(ui, icons::INVENTORY_2_OUTLINED, t.archive_title())
                            .clicked()
                        {
                            self.open_modal(Modal::Archive);
                            ui.close();
                        }
                        if icons::button(ui, icons::SAVE_OUTLINED, t.backups_title()).clicked() {
                            self.open_modal(Modal::Backups);
                            ui.close();
                        }
                        if icons::button(ui, icons::RESTORE, t.restore_backups_menu()).clicked() {
                            self.refresh_restore_sets();
                            self.open_modal(Modal::Restore);
                            ui.close();
                        }
                        if icons::button(ui, icons::PERSON_OFF_OUTLINED, t.moderation_title())
                            .clicked()
                        {
                            self.open_modal(Modal::Moderation);
                            ui.close();
                        }
                        ui.separator();
                        if icons::button(ui, icons::ASSIGNMENT_OUTLINED, t.capture_flier())
                            .clicked()
                        {
                            self.capture.start(self.pages.today);
                            self.open_modal(Modal::Capture);
                            ui.close();
                        }
                        if icons::button(ui, icons::JOIN_INNER, t.find_duplicates()).clicked() {
                            self.open_modal(Modal::Duplicates);
                            ui.close();
                        }
                        if ui
                            .add_enabled(
                                self.manager.catalogs().len() > 1,
                                egui::Button::new(t.move_to_catalog()),
                            )
                            .clicked()
                        {
                            if !self.transfer_dialog.ask(&self.manager, &self.store) {
                                self.notice = Some(t.nothing_to_archive().to_string());
                            }
                            ui.close();
                        }
                        if icons::button(ui, icons::SYNC, t.sync_menu()).clicked() {
                            self.open_modal(Modal::Sync);
                            ui.close();
                        }
                        let conflicts = self.store.conflicts().map(|c| c.len()).unwrap_or(0);
                        if ui
                            .add_enabled(
                                conflicts > 0,
                                egui::Button::new(t.conflicts_menu(conflicts as i64)),
                            )
                            .clicked()
                        {
                            self.open_modal(Modal::Conflicts);
                            ui.close();
                        }
                    });
                    // The tips about the catalog, its sync and its menu point here.
                    for id in ["home-catalog", "home-sync", "home-menu"] {
                        tips::anchor(ui, id, &catalog_menu.response);
                    }
                    ui.menu_button(t.menu_help(), |ui| {
                        if icons::button(ui, icons::HELP_OUTLINE, t.help_menu()).clicked() {
                            self.open_modal(Modal::Help);
                            ui.close();
                        }
                        if icons::button(ui, icons::EMOJI_EVENTS, t.achievements_title()).clicked()
                        {
                            self.refresh_ladders();
                            self.open_modal(Modal::Achievements);
                            ui.close();
                        }
                        if icons::button(ui, icons::INFO_OUTLINE, t.about_and_feedback()).clicked()
                        {
                            self.open_modal(Modal::About);
                            ui.close();
                        }
                    });
                });
            });
    }

    fn act_chore(&mut self, action: ChoreAction) {
        let t = self.t;
        let today = self.pages.today;
        let result = match action {
            ChoreAction::None => Ok(()),
            ChoreAction::Toggle(chore) => {
                let ticks = self.store.chore_ticks(&chore).unwrap_or_default();
                let result = if ticks.contains_key(&today) {
                    self.store.untick_chore(&chore, today)
                } else {
                    self.store.tick_chore(&chore, today, today)
                };
                if result.is_ok() && !ticks.contains_key(&today) {
                    self.celebrate_ticks();
                }
                result
            }
            ChoreAction::Edit(chore) => {
                let entity = chore.entity.clone();
                self.chore_dialog.ask(&entity, Some(chore), today);
                Ok(())
            }
            ChoreAction::New(entity) => {
                self.chore_dialog.ask(&entity, None, today);
                Ok(())
            }
            ChoreAction::PauseResume(chore) => {
                let paused = !chore.paused;
                self.store
                    .update_chore(&catlog_core::chores::Chore { paused, ..chore })
            }
            ChoreAction::End(chore) => {
                self.ending_chore = Some(chore);
                self.confirm
                    .ask(t.chore_end(), t.chore_end_confirm(), t.chore_end());
                Ok(())
            }
            ChoreAction::History(chore) => {
                self.chore_history.open_for(&self.store, chore, today);
                Ok(())
            }
        };
        if let Err(e) = result {
            self.notice = Some(e.to_string());
        }
    }

    /// The chore and appointment dialogs, and what they save.
    fn show_chore_dialogs(&mut self, ctx: &Context) {
        let t = self.t;
        if let Some(chore) = self.chore_dialog.show(ctx, &self.store, &t) {
            let result = if chore.id.is_empty() {
                self.store.create_chore(&new_uuid(), &chore).map(|_| ())
            } else {
                self.store.update_chore(&chore)
            };
            if let Err(e) = result {
                self.notice = Some(e.to_string());
            }
        }
        self.chore_history.show(ctx, &self.store, &t);
        if let Some(draft) = self.appointment_dialog.show(ctx, &self.store, &t) {
            let newcomers = self.appointment_dialog.newcomers();
            let result = if draft.id.is_empty() {
                let own = new_uuid();
                let mut members: Vec<(String, String)> = vec![(draft.entity.clone(), own)];
                for id in &newcomers {
                    members.push((id.clone(), new_uuid()));
                }
                let borrowed: Vec<(&str, &str)> = members
                    .iter()
                    .map(|(e, i)| (e.as_str(), i.as_str()))
                    .collect();
                self.store
                    .create_appointments(&draft, &borrowed, &new_uuid())
                    .map(|_| ())
            } else {
                self.store.update_appointment_group(&draft).and_then(|()| {
                    if newcomers.is_empty() {
                        return Ok(());
                    }
                    let ids: Vec<(String, String)> =
                        newcomers.iter().map(|e| (e.clone(), new_uuid())).collect();
                    let borrowed: Vec<(&str, &str)> =
                        ids.iter().map(|(e, i)| (e.as_str(), i.as_str())).collect();
                    self.store
                        .add_to_appointment_group(&draft, &borrowed, &new_uuid())
                        .map(|_| ())
                })
            };
            if let Err(e) = result {
                self.notice = Some(e.to_string());
            }
        }
        if let Some((treated, notes)) = self.finish_dialog.show(ctx, &t)
            && let Err(e) = self.store.finish_appointments(&treated, Some(&notes))
        {
            self.notice = Some(e.to_string());
        }
    }

    /// Sounds every reminder whose moment passed since the last check.
    /// The check lists every chore and appointment, so it runs twice a
    /// minute, not once a frame; a reminder half a minute late is still
    /// a reminder.
    pub fn fire_reminders(&mut self) {
        let now = (self.now)();
        let since = self.last_reminder_check;
        if now < since + chrono::Duration::seconds(30) {
            return;
        }
        self.last_reminder_check = now;
        let Ok(planned) = self.store.planned_reminders(since) else {
            return;
        };
        for r in planned.into_iter().filter(|r| r.at <= now) {
            let name = self
                .store
                .current(&r.entity, keys::NAME)
                .ok()
                .flatten()
                .unwrap_or_default();
            self.notifier.notify(&r.title, &name);
        }
    }

    /// The fonts for the current language, fetched and cached under the
    /// data dir on first use.
    pub fn fonts(&mut self) -> &FontSet {
        let language = self
            .t
            .locale()
            .split(['-', '_'])
            .next()
            .unwrap_or("en")
            .to_string();
        if self.fonts.as_ref().is_none_or(|(l, _)| *l != language) {
            let cache = self.manager.root().join("fonts");
            let set = catlog_core::fonts::fonts_for(&language, &cache, self.font_source.as_ref())
                .or_else(|_| FontSet::bundled())
                .expect("the bundled fonts parse");
            self.fonts = Some((language.clone(), set));
        }
        &self.fonts.as_ref().expect("just built").1
    }

    /// The current document as PDF bytes.
    pub fn document_pdf(&mut self) -> Option<Vec<u8>> {
        let t = self.t;
        let units = self.pages.units;
        let today = self.pages.today;
        let kind = self.document.kind?;
        let complete = self.fonts().complete;
        let fonts = self.fonts().clone();
        Some(match kind {
            DocKind::Card => {
                let card = self.document.card_content(&self.store, &t, units);
                catlog_core::documents::card_pdf(&card, &fonts, &t.card_title(&card.name))
            }
            DocKind::Poster => {
                let poster = self.document.poster_content(&self.store, &t, units);
                catlog_core::documents::poster_pdf(&poster, &fonts)
            }
            DocKind::VetReport => {
                let report = self
                    .document
                    .report_content(&self.store, &t, units, today, complete);
                catlog_core::documents::vet_report_pdf(&report, &fonts)
            }
        })
    }

    /// Takes the recognised lines when the thread is done.
    fn poll_recognition(&mut self) {
        let t = self.t;
        let Some(rx) = &self.recognizing else {
            return;
        };
        match rx.try_recv() {
            Ok(Ok(lines)) => {
                self.recognizing = None;
                self.capture.read(&self.store, &t, lines);
            }
            Ok(Err(e)) => {
                self.recognizing = None;
                self.capture.error = Some(format!("{}\n{e}", t.ocr_unavailable()));
            }
            Err(std::sync::mpsc::TryRecvError::Empty) => {}
            Err(std::sync::mpsc::TryRecvError::Disconnected) => self.recognizing = None,
        }
    }

    /// Reads a poster picture on its own thread.
    pub fn recognize_flier(&mut self, image: Vec<u8>) {
        self.capture.image = Some(image.clone());
        self.capture.draft.photo = Some(image.clone());
        self.capture.error = None;
        let ocr = self.ocr.clone();
        let (tx, rx) = std::sync::mpsc::channel();
        std::thread::spawn(move || {
            let _ = tx.send(ocr.recognize(&image));
        });
        self.recognizing = Some(rx);
    }

    fn act_capture(&mut self, action: CaptureAction) {
        let t = self.t;
        match action {
            CaptureAction::None => {}
            CaptureAction::OpenImage => {
                let picked = (self.pick_files)(t.open_image(), IMAGE_FILES, t.all_files());
                if let Some(path) = picked.first() {
                    match std::fs::read(path) {
                        Ok(bytes) => self.recognize_flier(bytes),
                        Err(e) => self.capture.error = Some(e.to_string()),
                    }
                }
            }
            CaptureAction::LocateAddress => {
                let query = self.capture.draft.address.trim().to_string();
                if query.is_empty() {
                    return;
                }
                match self.geocoder.search(&query) {
                    Ok(hits) if !hits.is_empty() => {
                        self.capture.draft.address_position = Some((hits[0].lat, hits[0].lon));
                        self.capture.draft.flier_position = Some((hits[0].lat, hits[0].lon));
                        self.capture.address_hit = Some(hits[0].name.clone());
                    }
                    Ok(_) => self.capture.address_hit = Some(t.no_places_found().to_string()),
                    Err(e) => self.capture.error = Some(e),
                }
            }
            CaptureAction::Save => {
                self.capture.draft.missing_since = self
                    .capture
                    .missing_since
                    .trim()
                    .parse::<chrono::NaiveDate>()
                    .ok();
                let owner_of = self.capture.owner_of(&t);
                let cat = format!("cat:{}", new_uuid());
                let clowder = format!("clowder:{}", new_uuid());
                let draft = std::mem::take(&mut self.capture.draft);
                match self.store.capture_flier(&draft, &cat, &clowder, &owner_of) {
                    Ok(made) => {
                        self.capture.open = false;
                        self.faces = FaceCache::default();
                        self.open_record(made.cat);
                    }
                    Err(e) => {
                        self.capture.draft = draft;
                        self.notice = Some(e.to_string());
                    }
                }
            }
        }
    }

    fn act_document(&mut self, action: DocAction) {
        let t = self.t;
        match action {
            DocAction::None => {}
            DocAction::SavePdf => {
                let name = self.document.file_name(&self.store, &t);
                let Some(path) = (self.save_file)(t.save_pdf(), &name) else {
                    return;
                };
                let Some(bytes) = self.document_pdf() else {
                    return;
                };
                self.notice = Some(match std::fs::write(&path, bytes) {
                    Ok(()) => t.document_saved(&path.to_string_lossy()),
                    Err(e) => e.to_string(),
                });
            }
            DocAction::Print => {
                let name = self.document.file_name(&self.store, &t);
                let dir = self.manager.root().join("print");
                let Some(bytes) = self.document_pdf() else {
                    return;
                };
                let path = dir.join(name);
                match std::fs::create_dir_all(&dir).and_then(|()| std::fs::write(&path, bytes)) {
                    Ok(()) => (self.open_file)(&path),
                    Err(e) => self.notice = Some(e.to_string()),
                }
            }
            DocAction::CopyImage => {
                let card = self
                    .document
                    .card_content(&self.store, &t, self.pages.units);
                self.copy_card(&card);
            }
            DocAction::SaveImage => {
                let name = self
                    .document
                    .file_name(&self.store, &t)
                    .replace(".pdf", ".png");
                let Some(path) = (self.save_file)(t.save_image(), &name) else {
                    return;
                };
                let card = self
                    .document
                    .card_content(&self.store, &t, self.pages.units);
                let fonts = self.fonts().clone();
                let Some(png) = card_png(&card, &fonts) else {
                    return;
                };
                self.notice = Some(match std::fs::write(&path, png) {
                    Ok(()) => t.document_saved(&path.to_string_lossy()),
                    Err(e) => e.to_string(),
                });
            }
        }
    }

    fn act_house(&mut self, action: HouseAction) {
        let t = self.t;
        match action {
            HouseAction::None => {}
            HouseAction::NameMoment => {
                self.asking = Asking::NameMoment;
                self.dialog
                    .ask(t.name_this_moment(), t.name(), t.save(), "");
            }
            HouseAction::GoBack(moment) => {
                let count = self
                    .store
                    .entries_after(moment.seq)
                    .map(|e| e.len())
                    .unwrap_or(0);
                self.going_back = Some(moment);
                self.confirm.ask(
                    t.go_back_title(),
                    &t.go_back_body(count as i64),
                    t.go_back_to_here(),
                );
            }
            HouseAction::Archive(ids) => {
                let names: Vec<String> = ids
                    .iter()
                    .map(|id| {
                        self.store
                            .current(id, keys::NAME)
                            .ok()
                            .flatten()
                            .unwrap_or_else(|| t.unnamed().to_string())
                    })
                    .collect();
                self.confirm.ask(
                    &t.archive_confirm_title(ids.len() as i64),
                    &t.archive_confirm_body(&names.join(", ")),
                    t.archive_action(),
                );
                self.archiving = Some(ids);
            }
            HouseAction::BackupNow => {
                self.notice = Some(match self.store.auto_backup(&self.backups_dir, true) {
                    Ok(Some(path)) => path.to_string_lossy().into_owned(),
                    Ok(None) => t.backups_never().to_string(),
                    Err(e) => t.last_backup_failed(&e.to_string()),
                });
            }
            HouseAction::PickBackupFolder => {
                if let Some(folder) = (self.pick_folder)(t.backups_folder_pick())
                    && let Err(e) = self.store.set_local_setting(
                        catlog_core::backup::BACKUP_FOLDER_KEY,
                        &folder.to_string_lossy(),
                    )
                {
                    self.notice = Some(e.to_string());
                }
            }
            HouseAction::RemoveBackupFolder => {
                if let Err(e) = self
                    .store
                    .remove_local_setting(catlog_core::backup::BACKUP_FOLDER_KEY)
                {
                    self.notice = Some(e.to_string());
                }
            }
            HouseAction::Restore(indexes) => {
                let mut count = 0;
                for i in indexes {
                    let Some(set) = self.restore_sets.get(i).cloned() else {
                        continue;
                    };
                    match catlog_core::backup::restore_backup_set(&mut self.manager, &set) {
                        Ok(_) => count += 1,
                        Err(e) => self.notice = Some(e.to_string()),
                    }
                }
                if count > 0 || self.notice.is_none() {
                    self.notice = Some(t.restore_done(count));
                }
                self.house.restore_chosen.clear();
            }
            HouseAction::PickRestoreFiles => {
                let picked = (self.pick_files)(t.restore_pick_files(), BUNDLE_FILES, t.all_files());
                self.house.restore_files.extend(picked);
                self.refresh_restore_sets();
            }
            HouseAction::HardDelete(author, device) => {
                self.confirm.ask(
                    t.hard_delete_action(),
                    &t.hard_delete_warning_key(&author, &key_code(&self.store, &device)),
                    t.delete(),
                );
                self.hard_deleting = Some((author, device));
            }
            HouseAction::Unban(kind, value) => {
                let result = match kind.as_str() {
                    "author" => self.store.unban(Some(&value), None, None),
                    "device" => self.store.unban(None, Some(&value), None),
                    _ => self.store.unban(None, None, Some(&value)),
                };
                if let Err(e) = result {
                    self.notice = Some(e.to_string());
                }
            }
        }
    }

    /// The backup sets in the backups folder and among the picked files.
    fn refresh_restore_sets(&mut self) {
        let mut files: Vec<PathBuf> = std::fs::read_dir(&self.backups_dir)
            .map(|d| {
                d.flatten()
                    .map(|e| e.path())
                    .filter(|p| p.is_file())
                    .collect()
            })
            .unwrap_or_default();
        files.extend(self.house.restore_files.iter().cloned());
        self.restore_sets = catlog_core::backup::find_backups(&files);
    }

    /// Returns the Catalog to `moment`; what goes is kept in a file in
    /// the backups folder first.
    fn go_back(&mut self, moment: &catlog_core::moments::Moment) {
        let t = self.t;
        let stamp = (self.now)().format("%Y%m%d-%H%M%S");
        let keep_at = self
            .backups_dir
            .join(format!("catlog-undone-{stamp}.catsync"));
        if let Err(e) = std::fs::create_dir_all(&self.backups_dir) {
            self.notice = Some(t.go_back_file_failed(&e.to_string()));
            return;
        }
        match self.store.revert_to(moment, &keep_at) {
            Ok(()) => {
                self.notice = Some(t.undone_import(&keep_at.to_string_lossy()));
                self.faces = FaceCache::default();
                self.home.selection = Selection::None;
            }
            Err(e) => self.notice = Some(t.go_back_file_failed(&e.to_string())),
        }
    }

    /// Writes the archive where the keeper says, then deletes here.
    fn archive(&mut self, ids: &[String]) {
        let t = self.t;
        let Some(path) = (self.save_file)(t.archive_title(), "catlog-archive.catsync") else {
            self.notice = Some(t.archive_not_saved().to_string());
            return;
        };
        let result = self
            .store
            .add_moment(catlog_core::moments::cause::ARCHIVE, None, None)
            .and_then(|_| self.store.write_archive(&path, ids))
            .and_then(|()| self.store.delete_archived(ids));
        self.notice = Some(match result {
            Ok(()) => t.archive_done(ids.len() as i64),
            Err(e) => t.archive_failed(&e.to_string()),
        });
        self.house.archive_chosen.clear();
        self.faces = FaceCache::default();
    }

    /// Deletes everything by `author` under `device`, bans the photos
    /// that went and, when asked, the device.
    fn hard_delete(&mut self, author: &str, device: &str) {
        let t = self.t;
        let result = self
            .store
            .add_moment(catlog_core::moments::cause::HARD_DELETE, Some(author), None)
            .and_then(|_| self.store.hard_delete_author(author, Some(device)));
        match result {
            Ok(blobs) => {
                for hash in &blobs {
                    let _ = self.store.ban(None, None, Some(hash));
                }
                if self.house.also_ban {
                    let _ = self.store.ban(None, Some(device), None);
                    let _ = self
                        .store
                        .set_local_setting(&format!("bannedAs:{device}"), author);
                }
                self.notice = Some(t.deleted_done().to_string());
                self.faces = FaceCache::default();
            }
            Err(e) => self.notice = Some(e.to_string()),
        }
    }

    /// What happens when the window closes: a backup when something
    /// changed since the last one.
    pub fn on_exit(&mut self) {
        self.in_person.stop();
        let _ = self.store.auto_backup(&self.backups_dir, false);
    }

    /// Moves `ids` into the Catalog `target`.
    pub fn transfer(&mut self, target: &str, ids: &[String]) {
        let t = self.t;
        let Some(info) = self.manager.by_id(target).cloned() else {
            return;
        };
        let borrowed: Vec<&str> = ids.iter().map(String::as_str).collect();
        let result = self.manager.open_store(&info).and_then(|mut to| {
            catlog_core::entities::transfer_entities(&mut self.store, &mut to, &borrowed)
        });
        match result {
            Ok(moved) => {
                self.notice = Some(t.moved_to_catalog(moved.moved.len() as i64, &info.name));
                self.home.selection = Selection::None;
                self.faces = FaceCache::default();
            }
            Err(e) => self.notice = Some(e.to_string()),
        }
    }

    /// Writes the calendar file where the keeper says.
    fn export_ics(&mut self) {
        let t = self.t;
        let Some(path) = (self.save_file)(t.export_ics(), "catlog.ics") else {
            return;
        };
        let events = ics_events(&self.store, &t);
        let text = catlog_core::ics::write_ics(&events, chrono::Utc::now());
        self.notice = Some(match std::fs::write(&path, text) {
            Ok(()) => t.ics_saved_to(&path.to_string_lossy()),
            Err(e) => e.to_string(),
        });
    }

    /// The line under the menu bar while a partner's changes wait.
    fn show_watch_line(&mut self, ui: &mut Ui) {
        let Some(pending) = self.watch_pending.clone() else {
            return;
        };
        let t = self.t;
        let authors = if pending.authors.is_empty() {
            t.sync_another_device().to_string()
        } else {
            pending.authors.join(", ")
        };
        let catalog = self.manager.active().name.clone();
        let mut sync = false;
        let mut dismiss = false;
        egui::Panel::top("watch-line")
            .show_separator_line(true)
            .show(ui, |ui| {
                ui.horizontal(|ui| {
                    icons::label(
                        ui,
                        icons::FOLDER_COPY_OUTLINED,
                        t.sync_changes_waiting(&authors, &catalog),
                    );
                    if icons::button(ui, icons::SYNC, t.sync_now()).clicked() {
                        sync = true;
                    }
                    if icons::button(ui, icons::CLOSE, t.sync_dismiss()).clicked() {
                        dismiss = true;
                    }
                });
            });
        if sync {
            self.run_sync();
        }
        if dismiss {
            self.watch_dismissed = Some(self.watch_sizes.clone());
            self.watch_pending = None;
        }
    }

    /// The app icon as a texture, loaded once.
    fn icon_texture(&mut self, ctx: &Context) -> Option<egui::TextureHandle> {
        if self.icon.is_none() {
            self.icon = crate::icon::texture(ctx, 128);
        }
        self.icon.clone()
    }

    fn show_about(&mut self, ui: &mut Ui) {
        let t = self.t;
        self.icon_texture(ui.ctx());
        let mut links: Vec<String> = Vec::new();
        ui.heading(t.about_and_feedback());
        {
            {
                if let Some(icon) = self.icon.clone() {
                    ui.add(
                        egui::Image::from_texture(&icon).fit_to_exact_size(egui::Vec2::splat(64.0)),
                    );
                }
                ui.label(format!("{} {}", t.app_title(), catlog_core::VERSION));
                ui.label(t.about_tagline());
                ui.add_space(6.0);
                if ui.link(t.source_code()).clicked() {
                    links.push("https://github.com/paxel/catlog".to_string());
                }
                if ui.link(t.report_problem_or_idea()).clicked() {
                    links.push("https://github.com/paxel/catlog/issues".to_string());
                }
                if ui.link(t.write_the_developer()).clicked() {
                    links.push(format!(
                        "mailto:{}?subject=cat(a)log%20feedback",
                        crate::crash::CRASH_MAIL
                    ));
                }
                if ui.link(t.buy_coffee()).clicked() {
                    links.push("https://ko-fi.com/paxel7".to_string());
                }
                ui.label(egui::RichText::new(t.coffee_subtitle()).weak());
                ui.label(egui::RichText::new(t.machine_translated()).weak());
                ui.add_space(6.0);
                ui.collapsing(t.open_source_licenses(), |ui| {
                    egui::ScrollArea::vertical()
                        .max_height(240.0)
                        .show(ui, |ui| {
                            ui.label(LICENCES);
                        });
                });
            }
        }
        for url in links {
            (self.open_url)(&url);
        }
    }

    /// The help text for what is shown.
    fn show_help(&mut self, ui: &mut Ui) {
        let t = self.t;
        let text = tips::help_for(
            &t,
            self.view,
            self.modal.clone(),
            &self.home.selection,
            self.cats.strays_only,
        );
        ui.heading(t.help_title());
        ui.set_max_width(420.0);
        ui.label(text);
    }

    /// The tip's bubble, over everything drawn before: on its widget when
    /// that is on screen, under the bar when not.
    fn show_spotlight(&mut self, ctx: &Context) {
        let Some((screen, id, text, last)) = self.tip_spot.take() else {
            return;
        };
        let rect = tips::anchor_rect(ctx, id);
        let t = self.t;
        match tips::spotlight(ctx, rect, self.bar_bottom, text(&t), last, &t) {
            tips::Answer::None => {}
            tips::Answer::Next => tips::mark_seen(&self.store, screen, id),
            tips::Answer::Skip => tips::mark_page_seen(&self.store, screen),
        }
    }

    /// Remembers the Cat or Clowder on the desk for the dashboard.
    fn remember_shown(&mut self) {
        if self.home.selection == self.shown {
            return;
        }
        self.shown = self.home.selection.clone();
        if let Selection::Cat(id) | Selection::Clowder(id) = &self.shown {
            dashboard::remember(&self.store, id);
        }
    }

    /// Carries out what a page, a card or the dashboard asked for.
    fn act_page(&mut self, page_action: PageAction) {
        let t = self.t;
        match page_action {
            PageAction::None => {}
            PageAction::OpenCat(id) | PageAction::OpenClowder(id) => {
                if matches!(self.modal, Some(Modal::Page(_))) {
                    // A link inside the page turns the page; it counts as
                    // looked at last.
                    self.home.selection = if id.starts_with("clowder:") {
                        Selection::Clowder(id.clone())
                    } else {
                        Selection::Cat(id.clone())
                    };
                    self.modal = Some(Modal::Page(id));
                } else {
                    self.open_record(id);
                }
            }
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
            PageAction::History(entity, slug) => {
                self.history_of = Some((entity, slug));
                self.history_opened += 1;
            }
            PageAction::NewField(scope) => self.new_field.ask(scope),
            PageAction::Move(cat) => self.mover.ask(&self.store, &cat),
            PageAction::Sighting(cat) => {
                self.sighting_for = Some(cat);
                self.picker.ask(None, self.map_page.map.viewport);
            }
            PageAction::ShowOnMap(id) => {
                self.map_page.focus(&self.store, &id);
                self.open_view(View::Map);
            }
            PageAction::AddPhoto(cat) => {
                let paths = (self.pick_files)(t.add_photo(), IMAGE_FILES, t.all_files());
                self.add_photos(&cat, &paths);
            }
            PageAction::SetCover(clowder) => {
                let paths = (self.pick_files)(t.cover_pick(), IMAGE_FILES, t.all_files());
                if let Some(path) = paths.first() {
                    self.set_cover(&clowder, path);
                }
            }
            PageAction::RemoveCover(clowder) => self.remove_cover(&clowder),
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
            PageAction::Chore(action) => self.act_chore(action),
            PageAction::Document(kind, cat) => {
                self.document
                    .open(&self.store, kind, &cat, self.pages.today);
                self.open_modal(Modal::Document);
            }
            PageAction::CopyCard(cat) => {
                // The Card as the document page would open it, with its
                // usual content.
                let mut page = DocumentPage::default();
                page.open(&self.store, DocKind::Card, &cat, self.pages.today);
                let card = page.card_content(&self.store, &t, self.pages.units);
                self.copy_card(&card);
            }
            PageAction::NewCat(clowder) => {
                self.asking = Asking::NewCat(clowder);
                // A name is proposed to start with; the dice throws another.
                let proposed =
                    crate::names::propose(&self.store, t.locale(), crate::names::roll_now())
                        .unwrap_or_default();
                self.dialog
                    .ask(t.new_cat(), t.name(), t.create(), &proposed);
                self.dialog.dice = Some(t.propose_another_name().to_string());
            }
            PageAction::MergeInto(id) => {
                let kind = if id.starts_with("clowder:") {
                    MergeKind::Clowder
                } else {
                    MergeKind::Cat
                };
                if !self.merge_dialog.ask_into(&self.store, &id, kind) {
                    self.notice = Some(t.no_other_to_merge_into(kind.words(&t)));
                }
            }
            PageAction::NewAppointment(entity) => {
                self.appointment_dialog
                    .ask(&self.store, &entity, None, self.pages.today);
            }
            PageAction::Appointment(AppointmentAction::Finish(a)) => {
                self.finish_dialog.ask(&self.store, &a);
            }
            PageAction::Appointment(AppointmentAction::Edit(a)) => {
                let entity = a.entity.clone();
                self.appointment_dialog
                    .ask(&self.store, &entity, Some(a), self.pages.today);
            }
            PageAction::Appointment(AppointmentAction::Delete(a, whole_run)) => {
                let result = if whole_run {
                    self.store.delete_appointment_group(&a)
                } else {
                    self.store.delete_appointment(&a)
                };
                if let Err(e) = result {
                    self.notice = Some(e.to_string());
                }
            }
        }
    }

    /// The Cats view with the Strays filter on: where the homeless live.
    pub fn open_strays(&mut self) {
        self.open_view(View::Cats);
        self.cats.strays_only = true;
        self.cats.missing_only = false;
    }

    /// The Clowders table; Enter or a double-click lays a Clowder's card
    /// on the desk.
    fn show_clowders_table(&mut self, ui: &mut Ui) -> PageAction {
        let t = self.t;
        let units = self.pages.units;
        let show_hidden = self.home.show_hidden;
        let mut page_action = PageAction::None;
        match self
            .clowders
            .show(ui, &self.store, &t, &mut self.faces, units, show_hidden)
        {
            ClowderAction::None => {}
            ClowderAction::Open(id) => self.open_record(id),
            ClowderAction::NewClowder => self.act(HomeAction::NewClowder),
            ClowderAction::Strays => self.open_strays(),
            ClowderAction::ToggleFavourite(id) => self.act(HomeAction::ToggleFavourite(id)),
            ClowderAction::ToggleHidden(id) => page_action = PageAction::ToggleHidden(id),
        }
        page_action
    }

    /// The Cats table; Enter or a double-click lays the selected cats on
    /// the desk as cards.
    fn show_cats_table(&mut self, ui: &mut Ui) -> PageAction {
        let t = self.t;
        let today = self.pages.today;
        let units = self.pages.units;
        let show_hidden = self.home.show_hidden;
        let mut page_action = PageAction::None;
        match self.cats.show(
            ui,
            &self.store,
            &t,
            &mut self.faces,
            today,
            units,
            show_hidden,
        ) {
            TableAction::None => {}
            TableAction::Open(id) => {
                let mut ids = self.cats.selected_in_order();
                if !ids.contains(&id) {
                    ids = vec![id.clone()];
                }
                self.desk.open(&self.store, &ids);
                self.home.selection = Selection::Cat(id);
                self.history_of = None;
            }
            TableAction::NewCat => page_action = PageAction::NewCat(None),
            TableAction::CaptureFlier => {
                self.capture.start(today);
                self.open_modal(Modal::Capture);
            }
            TableAction::ToggleHidden(id) => page_action = PageAction::ToggleHidden(id),
        }
        page_action
    }

    /// A Field's history, as the modal over everything else.
    fn show_history(&mut self, ui: &mut Ui) -> PageAction {
        let t = self.t;
        let page_action = PageAction::None;
        if let Some((entity, slug)) = self.history_of.clone() {
            if let Ok(Some(def)) = self.store.field_def(&slug) {
                match self.history.show(ui, &self.store, &t, &entity, &def) {
                    HistoryAction::None => {}
                    HistoryAction::CopyGraph(sheet) => {
                        let fonts = self.fonts().clone();
                        if let Some(image) = graph_image(&sheet, &fonts) {
                            self.copy_image(to_color_image(&image));
                        }
                    }
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
        }
        page_action
    }

    /// The modal over the desk, when one is open.
    fn show_modal(&mut self, ctx: &Context) {
        let Some(modal) = self.modal.clone() else {
            return;
        };
        let t = self.t;
        // The opening is part of the name, so each one fades in anew.
        let id = match &modal {
            Modal::Page(_) => format!("Page#{}", self.modal_opened),
            other => format!("{other:?}#{}", self.modal_opened),
        };
        let mut page_action = PageAction::None;
        let hosting = modal == Modal::InPerson;
        let (_, close) = views::show_modal(ctx, &id, t.close_label(), |ui| match modal {
            Modal::Page(id) => {
                ui.set_min_width(560.0);
                page_action = if id.starts_with("clowder:") {
                    self.pages
                        .show_clowder(ui, &self.store, &t, &mut self.faces, &id)
                } else {
                    self.pages
                        .show_cat(ui, &self.store, &t, &mut self.faces, &id)
                };
            }
            Modal::Help => self.show_help(ui),
            Modal::About => self.show_about(ui),
            Modal::Sync => match self.sync_page.show(ui, &self.store, &t) {
                SyncAction::None => {}
                SyncAction::ChooseFolder => {
                    if let Some(folder) = (self.pick_folder)(t.shared_folder())
                        && let Err(e) = self.store.choose_sync_folder(&folder)
                    {
                        self.notice = Some(e.to_string());
                    }
                }
                SyncAction::UseLastFolder(last) => {
                    if let Err(e) = self.store.choose_sync_folder(Path::new(&last)) {
                        self.notice = Some(e.to_string());
                    }
                }
                SyncAction::SyncNow => {}
                SyncAction::HostInPerson => self.start_hosting(),
                SyncAction::ExportBundle => self.export_bundle(),
                SyncAction::ImportBundle => {
                    let picked = (self.pick_files)(t.import_bundle(), BUNDLE_FILES, t.all_files());
                    if let Some(path) = picked.first() {
                        self.open_bundle_file(path);
                    }
                }
            },
            Modal::InPerson => match self.in_person.show(ui, &t) {
                InPersonAction::None => {}
                InPersonAction::Copy(code) => ui.ctx().copy_text(code),
                InPersonAction::Stop => {
                    self.in_person.stop();
                    self.modal = None;
                }
            },
            Modal::Settings => {
                let locale = self.t.locale();
                let code = crate::housekeeping::key_code(&self.store, &self.store.device_id());
                let eye_candy = self.settings.settings.eye_candy;
                let action = self.settings_page.show(
                    ui,
                    &self.store,
                    &self.manager,
                    &t,
                    locale,
                    &code,
                    &self.ladders,
                    eye_candy,
                );
                if let Err(e) = self.settings_page.apply_pending(&mut self.store) {
                    self.notice = Some(e.to_string());
                }
                self.act_settings(action);
            }
            Modal::Achievements => {
                show_achievements(ui, &mut self.manager, &t, &self.ladders);
            }
            Modal::Capture => {
                self.poll_recognition();
                let busy = self.recognizing.is_some();
                let action = self.capture.show(ui, &self.store, &t, busy);
                self.act_capture(action);
            }
            Modal::Document => {
                let complete = self.fonts().complete;
                let action = self.document.show(ui, &self.store, &t, complete);
                self.act_document(action);
            }
            Modal::Moments => {
                let action = show_moments(ui, &self.store, &t, &mut self.house);
                self.act_house(action);
            }
            Modal::Archive => {
                let today = self.pages.today;
                let action = show_archive(ui, &self.store, &t, &mut self.house, today);
                self.act_house(action);
            }
            Modal::Backups => {
                let action = show_backups(ui, &self.store, &t, &self.backups_dir);
                self.act_house(action);
            }
            Modal::Restore => {
                let action = show_restore(ui, &t, &self.restore_sets, &mut self.house);
                self.act_house(action);
            }
            Modal::Moderation => {
                let action = show_moderation(ui, &self.store, &t, &mut self.house);
                self.act_house(action);
            }
            Modal::Duplicates => match show_duplicates(ui, &self.store, &t) {
                DuplicatesAction::None => {}
                DuplicatesAction::Merge(a, b, kind) => {
                    self.merge_dialog.ask_pair(&self.store, &t, &a, &b, kind);
                }
                DuplicatesAction::Reject(a, b) => {
                    if let Err(e) = self.store.reject_looks_match(&a, &b) {
                        self.notice = Some(e.to_string());
                    }
                }
            },
            Modal::Conflicts => {
                if let Some((entity, field, kept)) =
                    show_conflicts(ui, &self.store, &t, self.pages.units)
                    && let Err(e) =
                        crate::conflicts::resolve(&mut self.store, &entity, &field, kept)
                {
                    self.notice = Some(e.to_string());
                }
            }
        });
        if close {
            if hosting {
                self.in_person.stop();
            }
            self.modal = None;
        }
        if page_action != PageAction::None {
            self.act_page(page_action);
        }
    }

    /// The Card drawn to pixels and put on the clipboard.
    fn copy_card(&mut self, card: &catlog_core::documents::CardContent) {
        let fonts = self.fonts().clone();
        if let Some(image) = card_png(card, &fonts).and_then(|png| crate::textures::decode(&png)) {
            self.copy_image(image);
        }
    }

    /// Puts a picture on the clipboard and says so.
    fn copy_image(&mut self, image: egui::ColorImage) {
        if let Some(ctx) = &self.ctx {
            ctx.copy_image(image);
            self.notice = Some(self.t.copied().to_string());
        }
    }

    /// Opens the in-person modal with the host serving behind it.
    pub fn start_hosting(&mut self) {
        self.in_person.start(&self.store);
        self.open_modal(Modal::InPerson);
    }

    /// While hosting, the phones' requests are answered every frame and
    /// each finished session opens the summary.
    fn poll_host(&mut self, ctx: &Context) {
        if !self.in_person.hosting() {
            return;
        }
        ctx.request_repaint_after(self.in_person.poll_delay());
        for session in self.in_person.poll(&mut self.store) {
            self.after_session(session);
        }
    }

    fn after_session(&mut self, session: catlog_core::lan::Session) {
        self.faces = FaceCache::default();
        self.open_summary(&session.applied, session.report);
    }

    /// The history of a Field, over the desk and over any modal, until
    /// it is closed.
    fn show_history_modal(&mut self, ctx: &Context) {
        if self.history_of.is_none() {
            return;
        }
        let t = self.t;
        let id = format!("History#{}", self.history_opened);
        let (page_action, close) =
            views::show_modal(ctx, &id, t.close_label(), |ui| self.show_history(ui));
        if close {
            self.history_of = None;
        }
        if page_action != PageAction::None {
            self.act_page(page_action);
        }
    }

    /// The friendly screen after a run that went down.
    fn show_crash_screen(&mut self, ctx: &Context) {
        let t = self.t;
        let Some(report) = self.crash_report.clone() else {
            return;
        };
        let mut send = false;
        let mut restart = false;
        egui::Modal::new(egui::Id::new("crash-screen")).show(ctx, |ui| {
            ui.set_width(480.0);
            ui.heading(t.crash_title());
            ui.label(t.crash_body());
            ui.label(egui::RichText::new(t.restart_hint()).weak());
            ui.horizontal(|ui| {
                if ui.button(t.crash_send_report()).clicked() {
                    send = true;
                }
                if ui.button(t.crash_restart()).clicked() {
                    restart = true;
                }
            });
        });
        if send {
            let url = crate::crash::mail_url(&report);
            (self.open_url)(&url);
            crate::crash::clear(self.manager.root());
            self.crash_report = None;
        }
        if restart {
            // The report stays on disk until it is sent.
            self.crash_report = None;
        }
    }

    /// The tip due on this page, once.
    fn show_tip(&mut self) {
        if self.tips_quiet {
            return;
        }
        let Some((screen, tip, last)) = tips::due_tip(
            &self.store,
            self.view,
            self.modal.clone(),
            &self.home.selection,
            self.cats.strays_only,
        ) else {
            return;
        };
        // Drawn last, so the bubble lies over everything.
        self.tip_spot = Some((screen, tip.id, tip.text, last));
    }

    pub fn open_settings(&mut self) {
        self.refresh_ladders();
        self.settings_page
            .open(self.settings.settings.author.as_deref());
        self.open_modal(Modal::Settings);
    }

    fn refresh_ladders(&mut self) {
        let today = self.pages.today;
        self.ladders = self
            .store
            .chore_stats(today)
            .map(|s| ladders(&s))
            .unwrap_or_default();
    }

    fn act_settings(&mut self, action: SettingsAction) {
        let t = self.t;
        match action {
            SettingsAction::None => {}
            SettingsAction::Author(name) => {
                self.settings.settings.author = Some(name.clone());
                let _ = self.settings.save();
                let _ = self.store.set_author(&name);
            }
            SettingsAction::Locale(locale) => self.set_locale(locale),
            SettingsAction::Units(choice) => {
                let result = match choice {
                    Some(v) => self
                        .store
                        .set_local_setting(catlog_core::units::UNITS_SETTING, v),
                    None => self
                        .store
                        .remove_local_setting(catlog_core::units::UNITS_SETTING),
                };
                if let Err(e) = result {
                    self.notice = Some(e.to_string());
                }
                self.apply_units();
            }
            SettingsAction::ResetTips => {
                tips::reset(&self.store);
                self.notice = Some(t.spot_replay_done().to_string());
            }
            SettingsAction::RenameCatalog => {
                let current = self.manager.active().name.clone();
                self.asking = Asking::RenameCatalog;
                self.dialog.ask(
                    t.rename_catalog(),
                    t.catalog_name_label(),
                    t.rename(),
                    &current,
                );
            }
            SettingsAction::DeleteCatalog => {
                let name = self.manager.active().name.clone();
                self.confirm.ask(
                    t.delete_catalog(),
                    &t.delete_catalog_body(&name),
                    t.delete(),
                );
                self.deleting_catalog = true;
            }
            SettingsAction::EyeCandy(on) => {
                self.settings.settings.eye_candy = on;
                let _ = self.settings.save();
            }
            SettingsAction::Sound(cheer, choice) => self.choose_sound(cheer, choice),
            SettingsAction::PickSound(cheer) => {
                let picked = (self.pick_files)(t.sound_own(), SOUND_FILES, t.all_files());
                if let Some(source) = picked.first() {
                    match keep_own(&self.data_dir, cheer, source) {
                        Ok(kept) => self.choose_sound(cheer, SoundChoice::Own(kept)),
                        Err(e) => self.notice = Some(e.to_string()),
                    }
                }
            }
            SettingsAction::OpenBackups => self.open_modal(Modal::Backups),
            SettingsAction::OpenAchievements => {
                self.refresh_ladders();
                self.open_modal(Modal::Achievements);
            }
        }
    }

    /// The unit system from the setting and the language's region.
    pub fn apply_units(&mut self) {
        let setting = self.store.local_setting(catlog_core::units::UNITS_SETTING);
        self.pages.units =
            catlog_core::units::UnitSystem::for_setting(setting.as_deref(), self.region.as_deref());
    }

    /// Deletes the active Catalog after a backup: the phone's rule that
    /// the one you stand in cannot go stays.
    fn delete_active_catalog(&mut self) {
        let t = self.t;
        let active = self.manager.active().clone();
        if self.manager.catalogs().len() < 2 {
            self.notice = Some(t.switch_before_deleting().to_string());
            return;
        }
        let saved = match self.store.auto_backup(&self.backups_dir, true) {
            Ok(Some(path)) => path,
            Ok(None) => self.backups_dir.clone(),
            Err(e) => {
                self.notice = Some(t.catalog_export_failed(&e.to_string()));
                return;
            }
        };
        let other = self
            .manager
            .catalogs()
            .iter()
            .find(|c| c.id != active.id)
            .map(|c| c.id.clone());
        let Some(other) = other else {
            return;
        };
        if let Err(e) = self.switch_catalog(&other) {
            self.notice = Some(e.to_string());
            return;
        }
        match self.manager.delete(&active.id) {
            Ok(()) => self.notice = Some(t.catalog_deleted(&active.name, &saved.to_string_lossy())),
            Err(e) => self.notice = Some(e.to_string()),
        }
    }

    /// A moment's sound picked on the Settings page: kept, and heard
    /// once so the pick is known.
    fn choose_sound(&mut self, cheer: Cheer, choice: SoundChoice) {
        set_sound(&self.store, cheer, &choice);
        if let Some(bytes) = choice.bytes() {
            self.sounder.play(bytes);
        }
    }

    /// The moment's sound, as chosen on the Settings page; none is a choice.
    fn cheer(&mut self, cheer: Cheer) {
        if let Some(bytes) = sound_for(&self.store, cheer).bytes() {
            self.sounder.play(bytes);
        }
    }

    fn celebrate_ticks(&mut self) {
        let t = self.t;
        let today = self.pages.today;
        self.cheer(Cheer::Tick);
        let mut cheer = None;
        if let Ok(agenda) = self.store.chores_agenda(today)
            && agenda.all_done_today(&self.store)
            && self.store.local_setting("choresCelebrated").as_deref() != Some(&today.to_string())
        {
            let _ = self
                .store
                .set_local_setting("choresCelebrated", &today.to_string());
            cheer = Some(Cheer::DayDone);
        }
        self.refresh_ladders();
        let now = (self.now)().and_utc().to_rfc3339();
        if let Ok(climbed) = self.manager.record_ladders(&self.ladders, &now)
            && !climbed.is_empty()
        {
            cheer = Some(Cheer::Ladder);
            let names: Vec<String> = climbed.iter().map(|s| ladder_name(&t, s)).collect();
            self.notice = Some(t.achievement_unlocked(&names.join(", ")));
        }
        if let Some(cheer) = cheer {
            self.cheer(cheer);
        }
    }

    fn show_intro(&mut self, ui: &mut Ui) {
        let t = self.t;
        egui::CentralPanel::default().show(ui, |ui| {
            ui.vertical_centered(|ui| {
                ui.add_space(40.0);
                if let Some(icon) = self.icon_texture(ui.ctx()) {
                    ui.add(
                        egui::Image::from_texture(&icon).fit_to_exact_size(egui::Vec2::splat(96.0)),
                    );
                    ui.add_space(12.0);
                }
                ui.heading(t.welcome_title());
                ui.add_space(12.0);
                ui.label(t.welcome_body());
                ui.add_space(12.0);
                ui.label(t.your_name());
                ui.add(egui::TextEdit::singleline(&mut self.intro_name).desired_width(280.0));
                ui.add_space(16.0);
                // One question, two ways to start; both wait for the name.
                ui.label(t.intro_tips_question());
                ui.add_space(8.0);
                let ready = !self.intro_name.trim().is_empty();
                // A row of two, centred under the question like the rest.
                ui.allocate_ui_with_layout(
                    egui::vec2(300.0, 28.0),
                    egui::Layout::left_to_right(egui::Align::Center),
                    |ui| {
                        if ui
                            .add_enabled(ready, egui::Button::new(t.start_with_tips()))
                            .clicked()
                        {
                            self.finish_intro(true);
                        }
                        if ui
                            .add_enabled(ready, egui::Button::new(t.start_without_tips()))
                            .clicked()
                        {
                            self.finish_intro(false);
                        }
                    },
                );
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
        // Behaviour tests run with motion off, so timing never flakes them.
        file.settings.eye_candy = false;
        let tiles = TileCache::open(&dir.join("tiles"), Box::new(FakeTiles)).unwrap();
        // Without threads the map's tiles are there in the frame that
        // asks for them, so no test waits on one.
        let tiles = TileFetcher::inline(Arc::new(tiles));
        let mut app = App::open_with(
            file,
            &dir.join("data"),
            Arc::new(tiles),
            Arc::new(FakeGeocoder),
        )
        .unwrap();
        // The tips' spotlight would lie over what the tests click; the
        // tip tests switch them back on.
        app.tips_quiet = true;
        app
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

    /// Clicks a view in the bar, which comes before any heading of the
    /// same name.
    fn open_view(h: &mut Harness<'static, App>, label: &str) {
        h.get_all_by_label(label).next().unwrap().click();
        h.run();
    }

    /// Opens the Clowders view and lays the row named `label` on the
    /// desk as its card: a click on the row, then Enter.
    fn open_row(h: &mut Harness<'static, App>, label: &str) {
        open_view(h, "Clowders");
        h.get_all_by_label(label).next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
    }

    /// Opens a Cat's or a Clowder's whole page as the modal over the
    /// desk; it counts as what was looked at last.
    fn open_cat_page(h: &mut Harness<'static, App>, id: &str) {
        h.state_mut().home.selection = if id.starts_with("clowder:") {
            Selection::Clowder(id.to_string())
        } else {
            Selection::Cat(id.to_string())
        };
        h.state_mut().open_modal(Modal::Page(id.to_string()));
        h.run();
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
                t.app_title(),
                t.menu_view(),
                t.menu_catalog(),
                t.menu_help(),
            ] {
                let node = h.get_by_label(label);
                assert!(node.rect().max.y < 60.0, "{label} sits in the menu bar");
            }
            // The bar under the menu names the six views; Home is open.
            for view in View::ALL {
                let node = h.get_all_by_label(view.label(&t)).next().unwrap();
                assert!(
                    node.rect().max.y < 110.0,
                    "{} sits in the bar",
                    view.label(&t)
                );
            }
            assert_eq!(h.state().view(), View::Home);
            h.get_by_label(t.dashboard_due());
            open_view(&mut h, t.clowders());
            h.get_by_label(t.no_clowders_yet());
            h.get_by_label(t.new_clowder());
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
        h.get_by_label(t.intro_tips_question());
        h.get_by_label(t.start_with_tips()).click();
        h.get_by_label(t.start_without_tips()).click();
        h.run();
        assert!(!h.state().settings().intro_seen, "no name, no start");
        h.state_mut().intro_name = "Ada".into();
        h.run();
        h.get_by_label(t.start_without_tips()).click();
        h.run();
        let s = h.state().settings().clone();
        assert!(s.intro_seen);
        assert_eq!(s.author.as_deref(), Some("Ada"));
        assert_eq!(s.tips_seen, vec!["all"]);
        h.get_by_label(t.app_title());
        assert_eq!(
            SettingsFile::load(dir.path()).settings.author.as_deref(),
            Some("Ada")
        );
        assert_eq!(h.state().store().author().as_deref(), Some("Ada"));
    }

    #[test]
    fn the_language_setting_switches_every_string_and_remembers_it() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(app(dir.path(), "en", true));
        h.run();
        // The language is picked on the Settings page, the first combo.
        h.state_mut().open_settings();
        h.run();
        h.get_all_by_role(egui::accesskit::Role::ComboBox)
            .next()
            .expect("the language combo")
            .click();
        h.step();
        h.get_by_label_contains("Deutsch").click_accesskit();
        h.run();
        assert_eq!(h.state().t().locale(), "de");
        h.get_by_label(L10n::new("de").menu_view());
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
        h.get_by_label("cat(a)log").click();
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
    fn the_clowders_table_lists_homes_with_faces_and_stars_and_opens_cards() {
        let dir = tempfile::tempdir().unwrap();
        let foster = "clowder:00000000-0000-4000-8000-000000000001";
        let barn = "clowder:00000000-0000-4000-8000-000000000002";
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_view(&mut h, "Clowders");
        assert_eq!(h.state().clowders.order(), [foster, barn], "creation order");
        assert!(!h.state().faces.is_empty(), "the faces were loaded");
        h.get_by_label("Foster home");
        h.get_by_label("Katzenweg 3, Leipzig");
        // A click selects, Enter lays the card on the desk. The status
        // column says "Barn" too; the name comes first.
        h.get_all_by_label("Barn").next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(*h.state().selection(), Selection::Clowder(barn.into()));
        assert_eq!(h.state().desk.open, [barn]);
        assert!(h.get_all_by_label("Barn").count() >= 2, "the card shows it");
        h.get_by_label("1 cats");
        // The star moves a Clowder to the front and back.
        h.get_all_by_label("Mark as favourite")
            .nth(1)
            .unwrap()
            .click();
        h.run();
        assert_eq!(
            h.state().clowders.order(),
            [barn, foster],
            "the favourite leads"
        );
        h.get_by_label("Remove from favourites").click();
        h.run();
        assert_eq!(h.state().clowders.order(), [foster, barn]);
        // The count column sorts, turned around puts the fuller home first.
        h.get_all_by_label("Cats").last().unwrap().click();
        h.run();
        h.get_all_by_label("Cats").last().unwrap().click();
        h.run();
        assert_eq!(h.state().clowders.order()[0], foster);
        // The Strays button leads to the Cats view with the filter on.
        h.get_by_label("1 strays").click();
        h.run();
        assert_eq!(h.state().view(), View::Cats);
        assert!(h.state().cats.strays_only);
        assert_eq!(
            h.state().cats.order(),
            ["cat:00000000-0000-4000-8000-000000000003"]
        );
    }

    fn seeded_with(dir: &std::path::Path, scenario: &str) -> App {
        let mut app = app(dir, "en", true);
        let fixture =
            Path::new(env!("CARGO_MANIFEST_DIR")).join(format!("../../fixtures/{scenario}/folder"));
        app.store_mut().import_folder(&fixture, None).unwrap();
        app
    }

    #[test]
    fn a_clowder_card_shows_its_fields_and_faces_that_open_the_cats_beside_it() {
        let dir = tempfile::tempdir().unwrap();
        let foster = "clowder:00000000-0000-4000-8000-000000000001";
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_row(&mut h, "Foster Home");
        assert_eq!(h.state().desk.open, [foster]);
        h.get_by_label("1 cats");
        h.get_all_by_label("Katzenweg 3, Leipzig").last().unwrap();
        h.get_all_by_label(L10n::new("en").status_foster())
            .last()
            .unwrap();
        // The face opens the cat's card beside the home's.
        h.get_by_role_and_label(egui::accesskit::Role::Button, "Miezi")
            .click();
        h.run();
        assert_eq!(h.state().desk.open, [foster, miezi]);
        assert_eq!(*h.state().selection(), Selection::Cat(miezi.into()));
        h.get_all_by_label("tabby").next().unwrap();
        // The whole page, from the card's menu, and the way back to the home.
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label("Open the page").click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Page(miezi.into())));
        h.get_by_label("Photos (2)");
        h.get_all_by_label(L10n::new("en").value_female())
            .last()
            .unwrap();
        h.get_all_by_label("Foster Home").last().unwrap().click();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Page(foster.into())));
        h.get_by_label("Cats (1)");
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
        // New cat from the card's menu lands in the home.
        h.key_press(egui::Key::Escape);
        h.run();
        h.get_all_by_label("Actions").next().unwrap().click();
        h.step();
        h.get_by_label("New cat").click_accesskit();
        h.run();
        assert!(h.state().dialog.open);
        h.state_mut().dialog.value = "Pixel".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        let Selection::Cat(cat) = h.state().selection().clone() else {
            panic!("the new cat's card opens");
        };
        assert_eq!(
            h.state()
                .store()
                .current(&cat, keys::CLOWDER)
                .unwrap()
                .as_deref(),
            Some(foster)
        );
        assert!(h.state().desk.open.contains(&cat));
    }

    #[test]
    fn the_strays_filter_lists_homeless_cats_and_the_keyboard_walks_the_clowders() {
        let dir = tempfile::tempdir().unwrap();
        let wanderer = "cat:00000000-0000-4000-8000-000000000003";
        let mut h = harness(seeded(dir.path()));
        h.run();
        h.state_mut().open_strays();
        h.run();
        assert_eq!(h.state().cats.order(), [wanderer]);
        h.get_all_by_label("Wanderer").next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(*h.state().selection(), Selection::Cat(wanderer.into()));
        h.get_by_label(L10n::new("en").stray_no_clowder());
        // Arrows walk the homes, the end holds, Enter opens the card.
        open_view(&mut h, "Clowders");
        h.key_press(egui::Key::ArrowDown);
        h.run();
        assert_eq!(
            h.state().clowders.cursor.as_deref(),
            Some("clowder:00000000-0000-4000-8000-000000000001")
        );
        h.key_press(egui::Key::ArrowDown);
        h.run();
        h.key_press(egui::Key::ArrowDown);
        h.run();
        assert_eq!(
            h.state().clowders.cursor.as_deref(),
            Some("clowder:00000000-0000-4000-8000-000000000002"),
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
        h.get_by_label("1 cats");
    }

    #[test]
    fn values_chores_appointments_and_family_read_in_words() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "chores"));
        h.run();
        open_cat_page(&mut h, "clowder:00000000-0000-4000-8000-000000000001");
        assert!(
            h.query_by_label_contains("Worming").is_none(),
            "an ended chore is not listed"
        );
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        // The dashboard behind the page lists the chore as due too.
        h.get_all_by_label_contains("Drops · ").last().unwrap();
        assert!(
            h.query_by_label("Finish").is_none(),
            "a finished visit is no plan"
        );
        h.get_by_label(L10n::new("en").value_yes());
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "fields-all"));
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        h.get_by_label("4.25 kg");
        h.get_by_label("5/2021");
        h.get_by_label("Family");
        // "Tom" is the Mother value and the family link; the link comes last.
        h.get_all_by_label("Tom").last().unwrap().click_accesskit();
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
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        // The Visits row: a double-click edits, the menu holds the history.
        h.get_by_label("3").scroll_to_me();
        h.run();
        h.state_mut().act_page(crate::pages::PageAction::Edit(
            "cat:00000000-0000-4000-8000-000000000001".into(),
            "visits".into(),
        ));
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
        // Removing through the row menu falls back to the value before;
        // the history lies over the page, so its row comes last.
        h.get_all_by_label("4").last().unwrap().click_secondary();
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
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        h.get_all_by_label_contains(" kg")
            .last()
            .unwrap()
            .click_secondary();
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
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        h.get_by_label("DE-123 456");
        h.get_by_label("276098100123456");
    }

    #[test]
    fn the_map_shows_pins_and_stray_areas_and_remembers_its_viewport() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "moves"));
        h.run();
        h.get_by_label("Map").click();
        h.run_steps(3);
        assert_eq!(h.state().view(), View::Map);
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
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        // The Location row's editor offers the map.
        h.state_mut().act_page(crate::pages::PageAction::Edit(
            "cat:00000000-0000-4000-8000-000000000001".into(),
            "position".into(),
        ));
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
        assert_eq!(h.state().view(), View::Map);
    }

    #[test]
    fn a_cat_moves_between_clowders_and_to_the_street() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
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
        open_view(&mut h, "Clowders");
        h.get_all_by_label("Barn").next().unwrap();
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
        open_view(&mut h, "Clowders");
        h.get_by_label("New clowder").click();
        h.run();
        h.state_mut().dialog.value = "Barn".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(h.state().store().clowders().unwrap()[0].name, "Barn");
        assert!(matches!(h.state().selection(), Selection::Clowder(_)));
        assert!(h.query_by_label("Pick a clowder on the left").is_none());
        // The row, the card's title bar, the face on the dock.
        assert_eq!(h.get_all_by_label("Barn").count(), 3);
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
        open_view(&mut h, "Clowders");
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
        app.pick_files = Box::new(move |_, _, _| vec![hand.clone()]);
        let mut h = harness(app);
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
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
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
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
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
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
        h.get_all_by_label("Close").last().unwrap().click();
        h.run();
        assert!(!h.state().viewer.open);
        h.get_by_label("Photos 1").click();
        h.run();
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().viewer.open);
    }

    /// An app over its own data dir, pointed at `shared` by the folder
    /// picker, with the author `name`.
    fn partner(dir: &std::path::Path, name: &str, shared: &std::path::Path) -> App {
        let mut app = app(dir, "en", true);
        app.settings.settings.author = Some(name.into());
        app.store().set_author(name).unwrap();
        let hand = shared.to_path_buf();
        app.pick_folder = Box::new(move |_| Some(hand.clone()));
        app
    }

    fn open_sync_page(h: &mut Harness<'static, App>) {
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("Sync…").click_accesskit();
        h.run();
    }

    #[test]
    fn the_sync_page_chooses_a_folder_and_two_desks_meet_through_it() {
        let dir = tempfile::tempdir().unwrap();
        let shared = dir.path().join("shared");
        std::fs::create_dir_all(&shared).unwrap();
        let mut ada = seeded(&dir.path().join("ada"));
        let hand = shared.clone();
        ada.pick_folder = Box::new(move |_| Some(hand.clone()));
        let mut h = harness(ada);
        h.run();
        open_sync_page(&mut h);
        assert_eq!(h.state().modal(), Some(Modal::Sync));
        h.get_by_label("No folder chosen yet");
        h.get_by_label("Choose…").click();
        h.run();
        h.get_by_label(shared.to_string_lossy().as_ref());
        assert_eq!(h.state().store().sync_folder_path(), Some(shared.clone()));
        // The switches write the phone's settings.
        h.get_by_label("Share private data").click();
        h.run();
        assert!(h.state().store().sync_private_on());
        h.get_by_label("Merge them on their own").click();
        h.run();
        assert!(h.state().store().sync_auto_on());
        h.get_by_label("Merge them on their own").click();
        h.run();
        assert!(!h.state().store().sync_auto_on());
        // The round runs on the frame after the click, then reports.
        h.get_by_label("Sync folder now").click();
        h.step();
        assert!(h.state().sync_page.syncing);
        h.get_by_label("Syncing with the folder…");
        h.run();
        assert!(!h.state().sync_page.syncing);
        h.get_by_label_contains("Folder synced: 0 entries + 0 photos in, ");
        assert!(!h.state().summary.open, "nothing arrived at the writer");
        assert!(shared.join("catlog-sync").is_dir());

        // Bob joins with an empty Catalog and takes everything.
        let mut b = harness(partner(&dir.path().join("bob"), "Bob", &shared));
        b.run();
        open_sync_page(&mut b);
        h.get_by_label("Choose…");
        b.get_by_label("Choose…").click();
        b.run();
        b.get_by_label("Sync folder now").click();
        b.run();
        assert!(
            b.state().summary.open,
            "the summary opens over what arrived"
        );
        b.get_by_label("What arrived");
        b.get_by_label("New");
        b.get_all_by_label("Miezi").next().unwrap();
        b.get_all_by_label("Close").last().unwrap().click();
        b.run();
        assert!(!b.state().summary.open);
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        assert_eq!(
            b.state()
                .store()
                .current(miezi, keys::NAME)
                .unwrap()
                .as_deref(),
            Some("Miezi")
        );
        // Quiet afterwards: nothing waits.
        b.state_mut().check_folder();
        b.run();
        assert!(b.state().watch_pending.is_none());

        // Ada changes something: Bob's watch shows the line; "Not now"
        // keeps it away until the file grows again.
        h.state_mut()
            .store_mut()
            .append(miezi, "f:remarks", Some("purrs"))
            .unwrap();
        h.state_mut().run_sync();
        b.state_mut().check_folder();
        b.run();
        assert!(b.state().watch_pending.is_some());
        b.get_by_label("Changes from Ada waiting in Clowders. Tap to sync.");
        // The Sync modal still lies over the desk; Escape puts it away.
        b.key_press(egui::Key::Escape);
        b.run();
        b.get_by_label("Not now").click();
        b.run();
        assert!(b.state().watch_pending.is_none());
        b.state_mut().check_folder();
        b.run();
        assert!(
            b.state().watch_pending.is_none(),
            "dismissed until it grows"
        );
        h.state_mut()
            .store_mut()
            .append(miezi, "f:remarks", Some("purrs a lot"))
            .unwrap();
        h.state_mut().run_sync();
        b.state_mut().check_folder();
        b.run();
        b.get_by_label("Changes from Ada waiting in Clowders. Tap to sync.");
        b.get_by_label("Sync now").click();
        b.run();
        assert!(b.state().watch_pending.is_none());
        b.get_by_label("Updated");
        // The dashboard's recent changes carry the remark as well.
        b.get_all_by_label_contains("purrs a lot").next().unwrap();
        // Reject puts it back.
        b.get_by_label("Reject").click();
        b.run();
        assert!(!b.state().summary.open);
        assert_eq!(
            b.state()
                .store()
                .current(miezi, "f:remarks")
                .unwrap()
                .as_deref(),
            None,
            "rejected rows are gone"
        );
        // Merging on its own: the change lands without a line.
        b.state()
            .store()
            .set_local_setting(catlog_core::sync::SYNC_AUTO, "1")
            .unwrap();
        h.state_mut()
            .store_mut()
            .append(miezi, "f:visits", Some("2"))
            .unwrap();
        h.state_mut().run_sync();
        b.state_mut().check_folder();
        b.run();
        assert!(b.state().watch_pending.is_none());
        assert_eq!(
            b.state()
                .store()
                .current(miezi, "f:visits")
                .unwrap()
                .as_deref(),
            Some("2")
        );
        assert!(b.state().summary.open);
        // The watch is quiet with the switch off, and a folder that went
        // away fails the round with the phone's words.
        b.state()
            .store()
            .set_local_setting(catlog_core::sync::SYNC_WATCH, "0")
            .unwrap();
        b.state_mut().check_folder();
        assert!(b.state().watch_pending.is_none());
        std::fs::remove_dir_all(&shared).unwrap();
        b.state_mut().run_sync();
        b.run();
        assert_eq!(
            b.state().sync_page.folder_result.as_deref(),
            Some("Couldn't reach the folder. Is the drive or cloud folder still there?")
        );
    }

    #[test]
    fn a_bundle_travels_from_one_desk_to_another_and_opens_by_file() {
        let dir = tempfile::tempdir().unwrap();
        let bundle = dir.path().join("clowders.catsync");
        let mut ada = seeded(&dir.path().join("ada"));
        let hand = bundle.clone();
        ada.save_file = Box::new(move |_, _| Some(hand.clone()));
        let mut h = harness(ada);
        h.run();
        open_sync_page(&mut h);
        h.get_by_label("Export sync bundle…").click();
        h.run();
        assert!(bundle.is_file());
        h.get_by_label_contains("Bundle written to ");

        let mut bob = app(&dir.path().join("bob"), "en", true);
        let hand = bundle.clone();
        bob.pick_files = Box::new(move |_, _, _| vec![hand.clone()]);
        let mut b = harness(bob);
        b.run();
        open_sync_page(&mut b);
        b.get_by_label("Import sync bundle…").click();
        b.run();
        b.get_by_label_contains("Bundle imported: ");
        b.get_by_label("What arrived");
        b.get_all_by_label("Close").last().unwrap().click();
        b.run();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        assert_eq!(
            b.state()
                .store()
                .current(miezi, keys::NAME)
                .unwrap()
                .as_deref(),
            Some("Miezi")
        );
        // The same file again brings nothing; junk is refused.
        b.get_by_label("Import sync bundle…").click();
        b.run();
        b.get_by_label("Nothing new in that file — you already have everything");
        let junk = dir.path().join("junk.catsync");
        std::fs::write(&junk, b"junk").unwrap();
        b.state_mut().open_bundle_file(&junk);
        b.run();
        b.get_by_label_contains("Import failed: ");
        // A bundle dropped on the window is imported from any page.
        let mut carol = harness(app(&dir.path().join("carol"), "en", true));
        carol.run();
        carol.input_mut().dropped_files.push(egui::DroppedFile {
            path: Some(bundle.clone()),
            ..Default::default()
        });
        carol.run();
        assert_eq!(carol.state().modal(), Some(Modal::Sync));
        carol.get_by_label("What arrived");
        assert_eq!(
            carol
                .state()
                .store()
                .current(miezi, keys::NAME)
                .unwrap()
                .as_deref(),
            Some("Miezi")
        );
    }

    #[test]
    fn conflicts_are_listed_and_decided_with_an_entry() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "conflict"));
        h.run();
        let conflicts = h.state().store().conflicts().unwrap();
        assert!(!conflicts.is_empty());
        let (entity, field) = conflicts[0].clone();
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label(format!("Conflicts ({})", conflicts.len()).as_str())
            .click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Conflicts));
        h.get_by_label("Conflicts to resolve");
        let name = h
            .state()
            .store()
            .current(&entity, keys::NAME)
            .unwrap()
            .unwrap();
        h.get_by_label_contains(&format!("{name} — "));
        // The two values are buttons on the row; the second one kept is
        // written as an entry of this desk.
        let candidates = crate::conflicts::candidates(h.state().store(), &entity, &field);
        assert_eq!(candidates.len(), 2);
        assert!(!crate::conflicts::same(&candidates));
        let second = candidates[1].clone();
        let t = L10n::new("en");
        let label = crate::labels::value_label(
            &t,
            h.state().store(),
            &field,
            second.value.as_deref(),
            h.state().pages.units,
        );
        let day = second
            .date
            .get(..10)
            .and_then(|d| d.parse::<chrono::NaiveDate>().ok())
            .map(|d| crate::labels::format_day(t.locale(), d))
            .unwrap();
        h.get_by_label(&format!("{label}   ({day} · {})", second.author))
            .click();
        h.run();
        assert!(!h.state().store().has_conflict(&entity, &field).unwrap());
        assert_eq!(
            h.state().store().current(&entity, &field).unwrap(),
            second.value
        );
        let history = h
            .state()
            .store()
            .field_history(&entity, &field, false)
            .unwrap();
        assert_eq!(
            history[0].author, "Ada",
            "the decision is an entry of this desk"
        );
        assert_eq!(
            h.state().store().conflicts().unwrap().len(),
            conflicts.len() - 1
        );
    }

    fn fixed_day(app: &mut App, y: i32, m: u32, d: u32, h: u32) {
        let at = chrono::NaiveDate::from_ymd_opt(y, m, d)
            .unwrap()
            .and_hms_opt(h, 0, 0)
            .unwrap();
        app.now = Box::new(move || at);
        app.last_reminder_check = at;
    }

    #[test]
    fn chores_are_made_ticked_paused_ended_and_read_on_the_agenda() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        fixed_day(&mut app, 2026, 3, 10, 7);
        let mut h = harness(app);
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        // A new daily chore with a reminder.
        h.get_by_label("New chore").click();
        h.run();
        assert!(h.state().chore_dialog.open);
        h.get_by_label("Save").click();
        h.run();
        assert!(h.state().chore_dialog.open, "no title, no chore");
        h.state_mut().chore_dialog.title = "Feed".into();
        h.state_mut().chore_dialog.time = "08:00".into();
        h.state_mut().chore_dialog.remind = true;
        h.run();
        h.get_by_label("Save").click();
        h.run();
        let chores = h.state().store().chores_of(miezi, false).unwrap();
        assert_eq!(chores.len(), 1);
        assert_eq!(chores[0].title, "Feed");
        assert!(chores[0].remind);
        h.get_all_by_label_contains("Feed · Daily · 08:00")
            .last()
            .unwrap();
        // Tick today from the row; the streak reads one day. The
        // dashboard behind the page has a box too.
        h.get_all_by_role(egui::accesskit::Role::CheckBox)
            .last()
            .unwrap()
            .click();
        h.run();
        let ticks = h.state().store().chore_ticks(&chores[0]).unwrap();
        assert_eq!(ticks.len(), 1);
        h.get_all_by_label_contains("1 day in a row")
            .last()
            .unwrap();
        // The menu: history, pause, edit, end.
        h.get_all_by_label_contains("Feed · Daily")
            .last()
            .unwrap()
            .click_secondary();
        h.step();
        h.get_by_label("History").click_accesskit();
        h.run();
        assert!(h.state().chore_history.open);
        h.get_by_label_contains("Feed · Miezi");
        h.state_mut().chore_history.open = false;
        h.run();
        h.get_all_by_label_contains("Feed · Daily")
            .last()
            .unwrap()
            .click_secondary();
        h.step();
        h.get_by_label("Pause").click_accesskit();
        h.run();
        assert!(h.state().store().chores_of(miezi, false).unwrap()[0].paused);
        h.get_all_by_label_contains("Feed · Daily")
            .last()
            .unwrap()
            .click_secondary();
        h.step();
        h.get_by_label("Resume").click_accesskit();
        h.run();
        assert!(!h.state().store().chores_of(miezi, false).unwrap()[0].paused);
        h.get_all_by_label_contains("Feed · Daily")
            .last()
            .unwrap()
            .click_secondary();
        h.step();
        h.get_by_label("Edit chore").click_accesskit();
        h.run();
        assert_eq!(h.state().chore_dialog.title, "Feed");
        h.state_mut().chore_dialog.title = "Feed twice".into();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        assert_eq!(
            h.state().store().chores_of(miezi, false).unwrap()[0].title,
            "Feed twice"
        );
        // The agenda lists it under today, all done.
        h.key_press(egui::Key::Escape);
        h.run();
        h.get_by_label("Agenda").click();
        h.run();
        assert_eq!(h.state().view(), View::Agenda);
        h.get_by_label("Today: all done");
        h.get_by_label_contains("Feed twice");
        // End it after one confirmation: gone from the lists.
        h.get_by_label_contains("Feed twice").click_secondary();
        h.step();
        h.get_by_label("End chore").click_accesskit();
        h.run();
        assert!(h.state().confirm.open);
        h.get_all_by_label("End chore").last().unwrap().click();
        h.run();
        assert!(
            h.state()
                .store()
                .chores_of(miezi, false)
                .unwrap()
                .is_empty()
        );
        assert_eq!(h.state().store().chores_of(miezi, true).unwrap().len(), 1);
    }

    #[test]
    fn a_vet_run_is_planned_finished_with_a_value_and_reminders_sound() {
        let dir = tempfile::tempdir().unwrap();
        let ics = dir.path().join("agenda.ics");
        let mut app = seeded(dir.path());
        fixed_day(&mut app, 2026, 3, 10, 7);
        let shown = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
        app.notifier = Box::new(crate::notify::RecordingNotifier {
            shown: shown.clone(),
        });
        let hand = ics.clone();
        app.save_file = Box::new(move |_, _| Some(hand.clone()));
        let mut h = harness(app);
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        h.get_by_label("Add appointment").click();
        h.run();
        assert!(h.state().appointment_dialog.open);
        h.state_mut().appointment_dialog.title = "Neutering".into();
        h.state_mut().appointment_dialog.date = "2026-03-11".into();
        h.state_mut().appointment_dialog.time = "14:30".into();
        h.state_mut().appointment_dialog.alert =
            Some(catlog_core::appointments::AppointmentAlert::HourBefore);
        h.state_mut().appointment_dialog.linked_field = Some("f:remarks".into());
        h.state_mut().appointment_dialog.linked_value = "neutered".into();
        h.run();
        // Tom comes along: a run of two.
        h.get_all_by_label("Tom").last().unwrap().click();
        h.run();
        assert_eq!(h.state().appointment_dialog.newcomers().len(), 1);
        h.get_by_label("Save").click();
        h.run();
        let mine = h.state().store().appointments_of(miezi, false).unwrap();
        assert_eq!(mine.len(), 1);
        assert_eq!(h.state().store().group_of(&mine[0]).unwrap().len(), 2);
        h.get_by_label_contains("Neutering · 2 cats");
        // The agenda shows the run once with both names, and the
        // calendar file carries it with its alarm.
        h.key_press(egui::Key::Escape);
        h.run();
        h.get_by_label("Agenda").click();
        h.run();
        h.get_by_label_contains("Neutering · 2 cats");
        h.get_by_label_contains("Miezi, Tom");
        h.get_by_label("Export calendar file").click();
        h.run();
        let text = std::fs::read_to_string(&ics).unwrap();
        assert!(text.contains("SUMMARY:Neutering — 2 cats\r\n"));
        assert!(text.contains("TRIGGER:-PT60M\r\n"));
        h.get_by_label_contains("Calendar file saved under ");
        // An hour before: the reminder sounds once.
        let at = chrono::NaiveDate::from_ymd_opt(2026, 3, 11)
            .unwrap()
            .and_hms_opt(13, 31, 0)
            .unwrap();
        h.state_mut().now = Box::new(move || at);
        h.run();
        h.run();
        assert_eq!(
            *shown.lock().unwrap(),
            vec![("Neutering".to_string(), "Miezi".to_string())]
        );
        // Finish: Tom was not treated; Miezi's linked field is written.
        h.get_by_label("Finish").click();
        h.run();
        assert!(h.state().finish_dialog.open);
        h.state_mut().finish_dialog.notes = "went well".into();
        h.run();
        h.get_all_by_label("Tom").last().unwrap().click();
        h.run();
        h.get_all_by_label("Finish").last().unwrap().click();
        h.run();
        assert!(!h.state().finish_dialog.open);
        assert!(
            h.state()
                .store()
                .appointments_of(miezi, false)
                .unwrap()
                .is_empty()
        );
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:remarks")
                .unwrap()
                .as_deref(),
            Some("neutered")
        );
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        assert_eq!(
            h.state().store().appointments_of(tom, false).unwrap().len(),
            1,
            "Tom stays planned"
        );
        // Edit Tom's leftover, then delete it.
        h.get_by_label_contains("Neutering").click_secondary();
        h.step();
        h.get_by_label("Edit appointment").click_accesskit();
        h.run();
        assert_eq!(h.state().appointment_dialog.title, "Neutering");
        h.state_mut().appointment_dialog.title = "Check-up".into();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        assert_eq!(
            h.state().store().appointments_of(tom, false).unwrap()[0].title,
            "Check-up"
        );
        h.get_by_label_contains("Check-up").click_secondary();
        h.step();
        h.get_by_label("Delete appointment").click_accesskit();
        h.run();
        assert!(
            h.state()
                .store()
                .appointments_of(tom, false)
                .unwrap()
                .is_empty()
        );
        h.get_by_label("No appointments planned. Plan new ones here with the plus, or on a cat's or clowder's page.");
    }

    #[test]
    fn reminders_sound_once_when_their_moment_passes() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        fixed_day(&mut app, 2026, 3, 10, 7);
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let mut feed = catlog_core::chores::Chore {
            id: String::new(),
            entity: miezi.into(),
            title: "Feed".into(),
            schedule: catlog_core::chores::ChoreSchedule::daily(),
            time: Some(catlog_core::chores::Hhmm { hour: 8, minute: 0 }),
            start: chrono::NaiveDate::from_ymd_opt(2026, 3, 1).unwrap(),
            paused: false,
            ended: false,
            remind: true,
            remind_at: None,
            extra: Default::default(),
        };
        feed.remind_at = Some(catlog_core::chores::Hhmm { hour: 8, minute: 0 });
        app.store_mut().create_chore("c1", &feed).unwrap();
        let shown = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
        app.notifier = Box::new(crate::notify::RecordingNotifier {
            shown: shown.clone(),
        });
        let mut h = harness(app);
        h.run();
        assert!(shown.lock().unwrap().is_empty(), "nothing due at seven");
        let at = chrono::NaiveDate::from_ymd_opt(2026, 3, 10)
            .unwrap()
            .and_hms_opt(8, 5, 0)
            .unwrap();
        h.state_mut().now = Box::new(move || at);
        h.run();
        assert_eq!(
            *shown.lock().unwrap(),
            vec![("Feed".to_string(), "Miezi".to_string())]
        );
        h.run();
        assert_eq!(shown.lock().unwrap().len(), 1, "sounds once");
        // The next day at the same time: again.
        let next = at + chrono::Duration::days(1);
        h.state_mut().now = Box::new(move || next);
        h.run();
        assert_eq!(shown.lock().unwrap().len(), 2);
    }

    #[test]
    fn duplicates_and_match_candidates_are_listed_merged_or_rejected() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        app.store_mut()
            .create_cat("cat:dup", "miezi ", None, "cat")
            .unwrap();
        app.store_mut()
            .append(tom, "f:chipid", Some("276 0981"))
            .unwrap();
        app.store_mut()
            .append("cat:dup", "f:chipid", Some("2760981"))
            .unwrap();
        app.store_mut()
            .create_cat("cat:p", "Pixel", None, "cat")
            .unwrap();
        app.store_mut()
            .create_cat("cat:q", "Quirl", None, "cat")
            .unwrap();
        for id in ["cat:p", "cat:q"] {
            app.store_mut()
                .append(id, "f:species", Some("cat"))
                .unwrap();
            app.store_mut()
                .append(
                    id,
                    "f:looks",
                    Some("size=small;colours=black;features=extra-toes"),
                )
                .unwrap();
        }
        let mut h = harness(app);
        h.run();
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("Find duplicates").click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Duplicates));
        h.get_by_label("Miezi · miezi  (cat)");
        h.get_by_label("Name");
        h.get_by_label("Tom · miezi  (cat)");
        h.get_all_by_label_contains("Same Chip ID").next().unwrap();
        h.get_by_label("Match candidates");
        h.get_by_label("Pixel · Quirl");
        h.get_by_label("4 traits agree");
        // Not the same: the Looks pair goes and stays gone.
        h.get_by_label("Not the same").click();
        h.run();
        assert!(h.query_by_label("Pixel · Quirl").is_none());
        assert!(
            h.state()
                .store()
                .is_looks_rejected("cat:p", "cat:q")
                .unwrap()
        );
        // Merge the name pair: the second survives, after one confirmation.
        h.get_all_by_label("Merge into…").next().unwrap().click();
        h.run();
        assert!(h.state().merge_dialog.open);
        h.get_all_by_label("miezi ").last().unwrap().click();
        h.run();
        h.get_all_by_label("Merge into…").last().unwrap().click();
        h.run();
        assert!(h.state().merge_dialog.confirming);
        h.get_by_label("Merge into miezi ?");
        h.get_by_label_contains("This cannot be undone.");
        h.get_by_label("Merge").click();
        h.run();
        assert!(!h.state().merge_dialog.open);
        assert_eq!(*h.state().selection(), Selection::Cat("cat:dup".into()));
        assert_eq!(h.state().store().resolve_entity(miezi).unwrap(), "cat:dup");
    }

    #[test]
    fn a_cat_and_a_clowder_merge_into_another_from_their_pages() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        h.get_by_label("Actions").click();
        h.step();
        h.get_by_label("Merge this cat into…").click_accesskit();
        h.run();
        assert!(h.state().merge_dialog.open);
        assert_eq!(
            h.state().merge_dialog.candidates.len(),
            2,
            "the two other cats"
        );
        h.get_all_by_label("Tom").last().unwrap().click();
        h.run();
        h.get_by_label("Merge into…").click();
        h.run();
        h.get_by_label("Merge").click();
        h.run();
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        assert_eq!(*h.state().selection(), Selection::Cat(tom.into()));
        assert_eq!(h.state().store().cats(None).unwrap().len(), 2);
        // The Clowder's card offers the same; it came last onto the desk.
        open_row(&mut h, "Foster Home");
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label("Merge this clowder into…").click_accesskit();
        h.run();
        h.get_all_by_label("Barn").last().unwrap().click();
        h.run();
        h.get_by_label("Merge into…").click();
        h.run();
        h.get_by_label("Merge").click();
        h.run();
        assert_eq!(h.state().store().clowders().unwrap().len(), 1);
        assert!(matches!(h.state().selection(), Selection::Clowder(_)));
        // Nothing left to merge into: a notice instead of a dialog.
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label("Merge this clowder into…").click_accesskit();
        h.run();
        assert!(!h.state().merge_dialog.open);
        h.get_by_label("No other clowder to merge into.");
    }

    #[test]
    fn a_clowder_moves_to_another_catalog_with_its_cats() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        // One Catalog: the entry is disabled.
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("New catalog").click();
        h.run();
        h.state_mut().dialog.value = "Leipzig".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(h.state().title(), "Leipzig");
        h.get_by_label("Catalog").click();
        h.step();
        h.get_all_by_label("Clowders").last().unwrap().click();
        h.run();
        assert_eq!(h.state().title(), "Clowders");
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("Move to another catalog").click_accesskit();
        h.run();
        assert!(h.state().transfer_dialog.open);
        assert!(
            h.state().transfer_dialog.target.is_some(),
            "one other: chosen"
        );
        h.get_by_label("Foster Home (clowder)").click();
        h.run();
        h.get_all_by_label("Move to another catalog")
            .last()
            .unwrap()
            .click();
        h.run();
        assert!(!h.state().transfer_dialog.open);
        h.get_by_label("2 moved to Leipzig");
        assert_eq!(h.state().store().clowders().unwrap().len(), 1, "Barn stays");
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("Leipzig").click();
        h.run();
        assert_eq!(h.state().store().clowders().unwrap().len(), 1);
        assert_eq!(h.state().store().cats(None).unwrap().len(), 1);
        h.get_all_by_label("Foster Home").next().unwrap();
    }

    #[test]
    fn the_bar_reaches_every_view_by_click_and_by_key() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        assert_eq!(h.state().view(), View::Home);
        h.get_by_label("3 cats");
        open_view(&mut h, "Cats");
        assert_eq!(h.state().view(), View::Cats);
        // A click selects a row; Enter lays the cat's card on the desk.
        h.get_all_by_label("Tom").next().unwrap().click();
        h.run();
        assert!(
            h.state()
                .cats
                .selected
                .contains("cat:00000000-0000-4000-8000-000000000002")
        );
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(
            *h.state().selection(),
            Selection::Cat("cat:00000000-0000-4000-8000-000000000002".into())
        );
        assert_eq!(
            h.state().desk.open,
            ["cat:00000000-0000-4000-8000-000000000002"]
        );
        h.get_by_label("Actions");
        open_view(&mut h, "Vet");
        h.get_by_label("Patient summary");
        // Ctrl+4 is the Map, Ctrl+1 Home; the desk keeps its cat.
        h.key_press_modifiers(egui::Modifiers::COMMAND, egui::Key::Num4);
        h.run();
        assert_eq!(h.state().view(), View::Map);
        h.key_press_modifiers(egui::Modifiers::COMMAND, egui::Key::Num1);
        h.run();
        assert_eq!(h.state().view(), View::Home);
        open_view(&mut h, "Clowders");
        h.get_by_label("Foster Home");
        assert_eq!(
            *h.state().selection(),
            Selection::Cat("cat:00000000-0000-4000-8000-000000000002".into())
        );
    }

    #[test]
    fn the_dashboard_ticks_a_chore_finishes_an_appointment_and_remembers_the_last_cat() {
        use catlog_core::appointments::{Appointment, AppointmentAlert};
        use catlog_core::chores::{Chore, ChoreRepeat, ChoreSchedule, ChoreUnit};
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        fixed_day(&mut app, 2026, 3, 10, 7);
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let feed = Chore {
            id: String::new(),
            entity: miezi.into(),
            title: "Feed".into(),
            schedule: ChoreSchedule {
                repeat: ChoreRepeat::Daily,
                every: 1,
                unit: ChoreUnit::Days,
                weekdays: Vec::new(),
            },
            time: None,
            start: chrono::NaiveDate::from_ymd_opt(2026, 3, 1).unwrap(),
            paused: false,
            ended: false,
            remind: false,
            remind_at: None,
            extra: Default::default(),
        };
        let feed = app.store_mut().create_chore("c-feed", &feed).unwrap();
        let visit = Appointment {
            id: String::new(),
            entity: miezi.into(),
            date: chrono::NaiveDate::from_ymd_opt(2026, 3, 10).unwrap(),
            time: None,
            title: "Neutering".into(),
            notes: String::new(),
            linked_field: Some("f:remarks".into()),
            linked_value: Some("neutered".into()),
            alert: AppointmentAlert::None,
            done: false,
            group: None,
            extra: Default::default(),
        };
        app.store_mut()
            .create_appointment("a-neuter", &visit)
            .unwrap();
        let mut h = harness(app);
        h.run();
        h.get_by_label("Due today");
        h.get_by_label_contains("Feed · Daily");
        h.get_by_label_contains("Neutering");
        // The tick from Home counts like the one on the cat's page.
        h.get_by_role(egui::accesskit::Role::CheckBox).click();
        h.run();
        assert_eq!(h.state().store().chore_ticks(&feed).unwrap().len(), 1);
        // Finish writes the linked value.
        h.get_by_label("Finish").click();
        h.run();
        assert!(h.state().finish_dialog.open);
        h.get_all_by_label("Finish").last().unwrap().click();
        h.run();
        assert!(!h.state().finish_dialog.open);
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:remarks")
                .unwrap()
                .as_deref(),
            Some("neutered")
        );
        // The change shows up under recent changes; its name opens the cat.
        h.get_by_label("Recent changes");
        h.get_all_by_label_contains("Remarks: neutered")
            .next()
            .unwrap();
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        assert_eq!(h.state().view(), View::Cats);
        assert_eq!(*h.state().selection(), Selection::Cat(miezi.into()));
        // Back on Home the cat is remembered as last viewed, per catalog.
        open_view(&mut h, "Home");
        h.get_by_label("Last viewed");
        assert_eq!(
            h.state()
                .store()
                .local_setting(crate::dashboard::LAST_CAT)
                .as_deref(),
            Some(miezi)
        );
        h.get_by_role_and_label(egui::accesskit::Role::Button, "Miezi")
            .click();
        h.run();
        assert_eq!(*h.state().selection(), Selection::Cat(miezi.into()));
    }

    #[test]
    fn a_modal_lies_over_the_desk_and_escape_closes_its_dialog_first() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_catalog_menu_item(&mut h, "Go back");
        assert_eq!(h.state().modal(), Some(Modal::Moments));
        // The desk stays underneath.
        h.get_by_label("Due today");
        h.get_by_label("Name this moment").click();
        h.run();
        assert!(h.state().dialog.open);
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().dialog.open, "the dialog goes first");
        assert_eq!(h.state().modal(), Some(Modal::Moments));
        h.key_press(egui::Key::Escape);
        h.run();
        assert_eq!(h.state().modal(), None);
        // The close button in the corner does the same.
        open_catalog_menu_item(&mut h, "Go back");
        h.get_by_label("Close").click();
        h.run();
        assert_eq!(h.state().modal(), None);
        // Help names what is shown: the desk, then the modal.
        open_view(&mut h, "Map");
        h.state_mut().open_modal(Modal::Help);
        h.run();
        h.get_by_label_contains(L10n::new("en").help_map());
    }

    #[test]
    fn the_cats_table_sorts_searches_filters_and_keeps_its_columns() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        let wanderer = "cat:00000000-0000-4000-8000-000000000003";
        let mut seeded_app = seeded(dir.path());
        seeded_app
            .store_mut()
            .append(tom, "f:birthdate", Some("2020-05-01"))
            .unwrap();
        seeded_app
            .store_mut()
            .append(miezi, "f:birthdate", Some("2024-01-15"))
            .unwrap();
        fixed_day(&mut seeded_app, 2026, 3, 10, 7);
        let mut h = harness(seeded_app);
        h.run();
        open_view(&mut h, "Cats");
        // The default columns, and the rows in creation order.
        for label in [
            "Name",
            "Clowder",
            "Status",
            "Species",
            "Gender",
            "Age",
            "Last change",
        ] {
            h.get_all_by_label(label).next().unwrap();
        }
        assert_eq!(h.state().cats.order(), [miezi, tom, wanderer]);
        h.get_by_label("Stray");
        h.get_all_by_label("At home").next().unwrap();
        h.get_by_label("5 years 10 months");
        // A header click sorts, a second one turns it around, a third lets go.
        h.get_by_label("Age").click();
        h.run();
        assert_eq!(
            h.state().cats.order(),
            [miezi, tom, wanderer],
            "youngest first"
        );
        h.get_by_label("Age").click();
        h.run();
        assert_eq!(
            h.state().cats.order(),
            [wanderer, tom, miezi],
            "turned around, no birth date first"
        );
        h.get_by_label("Age").click();
        h.run();
        assert_eq!(h.state().cats.order(), [miezi, tom, wanderer]);
        h.get_by_label("Name").click();
        h.run();
        h.get_by_label("Name").click();
        h.run();
        assert_eq!(h.state().cats.order(), [wanderer, tom, miezi]);
        // The search box narrows by name, chip and what the columns show.
        h.state_mut().cats.query = "wand".into();
        h.run();
        assert_eq!(h.state().cats.order(), [wanderer]);
        h.state_mut().cats.query = "female".into();
        h.run();
        assert_eq!(h.state().cats.order(), [miezi]);
        h.state_mut().cats.query.clear();
        h.run();
        // The filters: strays, then missing.
        h.get_by_label("Strays").click();
        h.run();
        assert_eq!(h.state().cats.order(), [wanderer]);
        h.get_by_label("Strays").click();
        h.run();
        h.get_by_label("Missing").click();
        h.run();
        assert!(h.state().cats.order().is_empty());
        h.get_by_label("Missing").click();
        h.run();
        assert_eq!(h.state().cats.order().len(), 3);
        // The column chooser adds Color and drops Age, saved per Catalog.
        h.get_by_label("Columns").click();
        h.step();
        h.get_all_by_label("Color")
            .last()
            .unwrap()
            .click_accesskit();
        h.run();
        h.get_all_by_label("Age").last().unwrap().click_accesskit();
        h.run();
        let saved = h
            .state()
            .store()
            .local_setting(crate::cats_table::COLUMNS_KEY)
            .unwrap();
        assert!(
            saved.contains("f:color") && !saved.contains("age"),
            "{saved}"
        );
        h.get_by_label("tabby");
        drop(h);
        let mut h = harness(app(dir.path(), "en", true));
        h.run();
        open_view(&mut h, "Cats");
        h.get_by_label("tabby");
        assert!(h.query_by_label("5 years 10 months").is_none());
    }

    #[test]
    fn the_cats_table_selects_with_ctrl_and_shift_walks_with_keys_and_opens_with_enter() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        let wanderer = "cat:00000000-0000-4000-8000-000000000003";
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_view(&mut h, "Cats");
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        assert_eq!(h.state().cats.selected_in_order(), [miezi]);
        h.get_all_by_label("Wanderer")
            .next()
            .unwrap()
            .click_modifiers(egui::Modifiers::SHIFT);
        h.run();
        assert_eq!(h.state().cats.selected_in_order(), [miezi, tom, wanderer]);
        h.get_all_by_label("Tom")
            .next()
            .unwrap()
            .click_modifiers(egui::Modifiers::COMMAND);
        h.run();
        assert_eq!(h.state().cats.selected_in_order(), [miezi, wanderer]);
        h.get_all_by_label("Tom").next().unwrap().click();
        h.run();
        assert_eq!(h.state().cats.selected_in_order(), [tom]);
        // Arrows walk, Shift+arrow grows the range, Enter opens.
        h.key_press(egui::Key::ArrowDown);
        h.run();
        assert_eq!(h.state().cats.selected_in_order(), [wanderer]);
        h.key_press(egui::Key::ArrowUp);
        h.run();
        h.key_press_modifiers(egui::Modifiers::SHIFT, egui::Key::ArrowUp);
        h.run();
        assert_eq!(h.state().cats.selected_in_order(), [miezi, tom]);
        h.key_press(egui::Key::ArrowDown);
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(*h.state().selection(), Selection::Cat(tom.into()));
        h.get_by_label("Actions");
        assert_eq!(
            h.state().view(),
            View::Cats,
            "the card opens beside the table"
        );
        assert_eq!(h.state().desk.open, [tom]);
        // The row menu hides; the toolbar reaches the flier capture and a new cat.
        h.get_all_by_label("Wanderer")
            .next()
            .unwrap()
            .click_secondary();
        h.step();
        h.get_by_label("Hide on this device").click_accesskit();
        h.run();
        assert!(h.state().store().is_hidden(wanderer).unwrap());
        assert_eq!(h.state().cats.order().len(), 2);
        h.get_by_label("Capture flier").click();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Capture));
        h.key_press(egui::Key::Escape);
        h.run();
        h.get_by_label("New cat").click();
        h.run();
        assert!(h.state().dialog.open);
    }

    /// Drags the node named `label` by `delta` with the primary button.
    /// Drags a card by the name in its title bar: the last label so
    /// named, as the cards lie over the table; the dock's face is a
    /// button, not a label.
    fn drag(h: &mut Harness<'static, App>, label: &str, delta: egui::Vec2) {
        let from = h
            .get_all_by_role_and_label(egui::accesskit::Role::Label, label)
            .last()
            .unwrap()
            .rect()
            .center();
        let to = from + delta;
        let press = |pos, pressed| egui::Event::PointerButton {
            pos,
            button: egui::PointerButton::Primary,
            pressed,
            modifiers: egui::Modifiers::default(),
        };
        h.input_mut().events.push(egui::Event::PointerMoved(from));
        h.input_mut().events.push(press(from, true));
        h.step();
        h.input_mut()
            .events
            .push(egui::Event::PointerMoved(from + delta * 0.5));
        h.step();
        h.input_mut().events.push(egui::Event::PointerMoved(to));
        h.step();
        h.input_mut().events.push(press(to, false));
        h.run();
    }

    #[test]
    fn the_dock_tiles_stacks_raises_and_closes_the_cards() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_view(&mut h, "Cats");
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_all_by_label("Tom")
            .next()
            .unwrap()
            .click_modifiers(egui::Modifiers::SHIFT);
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(h.state().desk.open, [miezi, tom]);
        let ctx = h.state().ctx.clone().unwrap();
        // The last opened lies on top; its face on the dock wears the dot.
        assert_eq!(h.state().desk.front(&ctx).as_deref(), Some(tom));
        // Stack: a cascade, Tom a step down and right of Miezi.
        h.get_by_label("Stack").click();
        h.run();
        let a = h.state().desk.position(miezi).unwrap();
        let b = h.state().desk.position(tom).unwrap();
        assert_eq!((b.x - a.x, b.y - a.y), (24.0, 24.0));
        // Tile: side by side on one row, a gap between.
        h.get_by_label("Tile").click();
        h.run();
        let a = h.state().desk.position(miezi).unwrap();
        let b = h.state().desk.position(tom).unwrap();
        assert_eq!(a.y, b.y);
        assert!(b.x > a.x + crate::cards::CARD_WIDTH, "{a:?} {b:?}");
        // Miezi's face on the dock brings her card to the front.
        h.get_all_by_role_and_label(egui::accesskit::Role::Button, "Miezi")
            .last()
            .unwrap()
            .click();
        h.run();
        assert_eq!(h.state().desk.front(&ctx).as_deref(), Some(miezi));
        // Close all: the desk is bare, the open set empty and remembered so.
        h.get_by_label("Close all").click();
        h.run();
        assert!(h.state().desk.open.is_empty());
        assert_eq!(
            h.state()
                .store()
                .local_setting(crate::cards::OPEN_KEY)
                .as_deref(),
            Some("")
        );
    }

    #[test]
    fn cards_open_from_the_table_are_dragged_into_place_and_found_there_again() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_view(&mut h, "Cats");
        // Two rows selected, Enter: two cards side by side.
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.get_all_by_label("Tom")
            .next()
            .unwrap()
            .click_modifiers(egui::Modifiers::SHIFT);
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(h.state().desk.open, [miezi, tom]);
        let first = h.state().desk.position(miezi).unwrap();
        let second = h.state().desk.position(tom).unwrap();
        assert!(
            second.x > first.x + crate::cards::CARD_WIDTH,
            "side by side: {first:?} {second:?}"
        );
        assert_eq!(h.get_all_by_label("Actions").count(), 2, "a menu per card");
        // The card shows what the printed Card shows.
        h.get_all_by_label("Foster Home").next().unwrap();
        h.get_all_by_label("female").next().unwrap();
        h.get_all_by_label("tabby").next().unwrap();
        // Dragging Tom's card moves it; the place is remembered.
        drag(&mut h, "Tom", egui::vec2(-200.0, 150.0));
        let moved = h.state().desk.position(tom).unwrap();
        assert!(moved.y > second.y + 100.0, "{moved:?} vs {second:?}");
        assert!(moved.x < second.x - 100.0);
        assert_eq!(
            h.state()
                .store()
                .local_setting(crate::cards::OPEN_KEY)
                .as_deref(),
            Some(format!("{miezi},{tom}").as_str())
        );
        drop(h);
        let mut h = harness(app(dir.path(), "en", true));
        h.run();
        open_view(&mut h, "Cats");
        assert_eq!(h.state().desk.open, [miezi, tom]);
        assert_eq!(h.state().desk.position(tom), Some(moved));
        assert_eq!(h.get_all_by_label("Actions").count(), 2);
        // The × on the title bar closes a card; the open set follows.
        h.get_all_by_label("Close card").last().unwrap().click();
        h.run();
        assert_eq!(h.state().desk.open, [miezi]);
    }

    #[test]
    fn a_card_edits_simple_values_in_place_and_sends_the_rest_to_the_editor() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let mut h = harness(seeded_with(dir.path(), "fields-all"));
        h.run();
        open_view(&mut h, "Cats");
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(h.state().desk.open, [miezi]);
        // A number: a click opens it in place, Enter saves.
        h.get_all_by_label("3").last().unwrap().click();
        h.run();
        assert!(h.state().desk.inline.is_some(), "the number opens in place");
        h.state_mut().desk.inline.as_mut().unwrap().text = "4".into();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert!(h.state().desk.inline.is_none());
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:visits")
                .unwrap()
                .as_deref(),
            Some("4")
        );
        // A unit value: typed in the keeper's unit, stored in the base unit.
        h.get_all_by_label("4.25 kg").last().unwrap().click();
        h.run();
        h.state_mut().desk.inline.as_mut().unwrap().text = "5".into();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:weight")
                .unwrap()
                .as_deref(),
            Some("5000")
        );
        // Escape leaves a value as it was.
        h.get_all_by_label("4").last().unwrap().click();
        h.run();
        h.state_mut().desk.inline.as_mut().unwrap().text = "9".into();
        h.run();
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(h.state().desk.inline.is_none());
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:visits")
                .unwrap()
                .as_deref(),
            Some("4")
        );
        // Yes/no and a choice: picked from a combo in place.
        h.get_all_by_label("yes").last().unwrap().click();
        h.run();
        assert!(h.state().desk.inline.is_some());
        h.get_all_by_role(egui::accesskit::Role::ComboBox)
            .last()
            .unwrap()
            .click();
        h.step();
        h.get_all_by_label("no").last().unwrap().click_accesskit();
        h.run();
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:indoor")
                .unwrap()
                .as_deref(),
            Some("no")
        );
        h.get_all_by_label("sleepy").last().unwrap().click();
        h.run();
        h.get_all_by_role(egui::accesskit::Role::ComboBox)
            .last()
            .unwrap()
            .click();
        h.step();
        h.get_all_by_label("wild").last().unwrap().click_accesskit();
        h.run();
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:mood")
                .unwrap()
                .as_deref(),
            Some("wild")
        );
        // A date goes to the editor popup.
        h.get_all_by_label("5/2021").last().unwrap().click();
        h.run();
        assert!(h.state().editor.open, "dates need the editor");
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().editor.open);
        // The row menu reaches the history.
        h.get_all_by_label("4").last().unwrap().click_secondary();
        h.step();
        h.get_by_label("History").click_accesskit();
        h.run();
        assert!(h.state().history_of.is_some());
        h.get_all_by_label_contains("Visits").last().unwrap();
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(h.state().history_of.is_none());
    }

    #[test]
    fn the_card_menu_reaches_the_page_the_dialogs_and_the_documents() {
        let dir = tempfile::tempdir().unwrap();
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_view(&mut h, "Cats");
        h.get_all_by_label("Tom").next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        let menu = |h: &mut Harness<'static, App>, item: &str| {
            h.get_by_label("Actions").click();
            h.step();
            h.get_by_label(item).click_accesskit();
            h.run();
        };
        menu(&mut h, "Open the page");
        assert_eq!(h.state().modal(), Some(Modal::Page(tom.into())));
        h.get_by_label("Photos (1)");
        h.key_press(egui::Key::Escape);
        h.run();
        menu(&mut h, "New chore");
        assert!(h.state().chore_dialog.open);
        h.key_press(egui::Key::Escape);
        h.run();
        menu(&mut h, "Add appointment");
        assert!(h.state().appointment_dialog.open);
        h.key_press(egui::Key::Escape);
        h.run();
        menu(&mut h, "Move to");
        assert!(h.state().mover.open);
        h.key_press(egui::Key::Escape);
        h.run();
        menu(&mut h, "Card");
        assert_eq!(h.state().modal(), Some(Modal::Document));
        assert_eq!(h.state().document.kind, Some(DocKind::Card));
        h.key_press(egui::Key::Escape);
        h.run();
        // The fields on the card follow the printed Card's selector.
        h.get_by_label("Actions").click();
        h.step();
        h.get_by_label_contains("Fields on the card")
            .click_accesskit();
        h.step();
        h.get_all_by_label("Gender")
            .last()
            .unwrap()
            .click_accesskit();
        h.run();
        assert!(
            !h.state()
                .store()
                .local_setting("cardFields")
                .unwrap()
                .contains("f:gender")
        );
        h.key_press(egui::Key::Escape);
        h.run();
        // The table's column stays; the card's row is gone.
        assert_eq!(
            h.get_all_by_label("Gender").count(),
            1,
            "gender left the card"
        );
        menu(&mut h, "Hide on this device");
        assert!(h.state().store().is_hidden(tom).unwrap());
    }

    #[test]
    fn the_vet_view_lists_runs_open_first_finishes_one_and_shows_the_patient() {
        use catlog_core::appointments::{Appointment, AppointmentAlert};
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        let mut app = seeded_with(dir.path(), "chores");
        fixed_day(&mut app, 2026, 3, 10, 7);
        let neutering = Appointment {
            id: String::new(),
            entity: tom.into(),
            date: chrono::NaiveDate::from_ymd_opt(2026, 3, 12).unwrap(),
            time: None,
            title: "Neutering".into(),
            notes: String::new(),
            linked_field: Some("f:remarks".into()),
            linked_value: Some("neutered".into()),
            alert: AppointmentAlert::None,
            done: false,
            group: None,
            extra: Default::default(),
        };
        let neutering = app
            .store_mut()
            .create_appointment("a-neuter", &neutering)
            .unwrap();
        let mut h = harness(app);
        h.run();
        open_view(&mut h, "Vet");
        // The open run leads; the finished ones follow, newest first.
        let order = h.state().vet.order().to_vec();
        assert_eq!(order[0], neutering.id);
        assert_eq!(order.len(), 3);
        h.get_by_label("Neutering");
        h.get_by_label("Shots");
        h.get_by_label("Check-up");
        assert_eq!(h.get_all_by_label("Done").count(), 2);
        h.get_by_label("Pick a run or an appointment to see its patient");
        // The date column turns around; the open row still leads.
        h.get_by_label("When").click();
        h.run();
        assert!(h.state().vet.descending);
        let turned = h.state().vet.order().to_vec();
        assert_eq!(turned[0], neutering.id);
        assert_ne!(turned[1], order[1]);
        // A click on a row shows its patient.
        h.get_by_label("Shots").click();
        h.run();
        h.get_all_by_label("Miezi").next().unwrap();
        h.get_all_by_label("Species").next().unwrap();
        // Finish from the row writes the linked value.
        h.get_by_label("Finish").click();
        h.run();
        assert!(h.state().finish_dialog.open);
        h.get_all_by_label("Finish").last().unwrap().click();
        h.run();
        assert!(!h.state().finish_dialog.open);
        assert_eq!(
            h.state()
                .store()
                .current(tom, "f:remarks")
                .unwrap()
                .as_deref(),
            Some("neutered")
        );
        assert_eq!(h.get_all_by_label("Done").count(), 3);
        assert!(h.query_by_label("Finish").is_none());
        // One click to the report for the patient shown.
        h.get_by_label("Report for the vet…").click();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Document));
        assert_eq!(h.state().document.kind, Some(DocKind::VetReport));
        assert_eq!(h.state().document.cat, miezi);
    }

    #[test]
    fn with_eye_candy_on_the_views_modals_and_cards_fade_and_the_app_settles() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        app.settings.settings.eye_candy = true;
        let mut h = harness(app);
        h.run();
        assert_eq!(crate::motion::duration(&h.ctx), crate::motion::DEFAULT);
        open_view(&mut h, "Cats");
        h.get_all_by_label("Tom").next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(h.state().desk.open.len(), 1);
        h.state_mut().open_modal(Modal::Sync);
        h.run();
        h.get_by_label("Shared folder");
        h.key_press(egui::Key::Escape);
        h.run();
        h.state_mut().open_modal(Modal::Sync);
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Sync));
        assert!(h.state().settings.settings.eye_candy);
    }

    #[test]
    fn a_chore_is_duplicated_onto_another_cat_and_the_original_comes_back() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        let mut app = seeded_with(dir.path(), "chores");
        fixed_day(&mut app, 2026, 3, 10, 7);
        let mut h = harness(app);
        h.run();
        open_cat_page(&mut h, miezi);
        h.get_all_by_label_contains("Drops · ")
            .last()
            .unwrap()
            .click_secondary();
        h.step();
        h.get_by_label("Edit chore").click_accesskit();
        h.run();
        assert!(h.state().chore_dialog.existing.is_some());
        // Duplicate asks whose the copy is; the original's cat is listed too.
        h.get_by_label("Duplicate").click();
        h.run();
        assert!(h.state().chore_dialog.picking);
        h.get_all_by_label("Miezi").last().unwrap();
        h.get_all_by_label("Tom").last().unwrap().click();
        h.run();
        assert!(h.state().chore_dialog.existing.is_none(), "a new chore now");
        assert_eq!(h.state().chore_dialog.entity, tom);
        assert_eq!(h.state().chore_dialog.title, "Drops");
        // The page's own "New chore" button sits behind the dialog's heading.
        assert_eq!(h.get_all_by_label("New chore").count(), 2);
        h.get_by_label("Save").click();
        h.run();
        let copies = h.state().store().chores_of(tom, false).unwrap();
        assert_eq!(copies.len(), 1);
        assert_eq!(copies[0].title, "Drops");
        assert_eq!(
            copies[0].time,
            Some(catlog_core::chores::Hhmm { hour: 8, minute: 0 })
        );
        assert_eq!(
            copies[0].start,
            chrono::NaiveDate::from_ymd_opt(2026, 3, 10).unwrap()
        );
        assert!(copies[0].remind);
        // Back over the original, ready for the next kitten.
        assert!(h.state().chore_dialog.open);
        assert!(h.state().chore_dialog.existing.is_some());
        h.get_by_label("Edit chore");
        h.get_by_label("Duplicate");
        assert_eq!(h.state().store().chores_of(miezi, false).unwrap().len(), 1);
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().chore_dialog.open);
    }

    #[test]
    fn a_tip_spotlights_its_widget_next_goes_on_and_skip_ends_the_page() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        app.tips_quiet = false;
        let mut h = harness(app);
        h.run();
        // The first tip rings the Catalog menu button and speaks beside it,
        // with Skip and Next: it is not the page's last.
        let catalog = h.get_by_label("Catalog").rect();
        let ring = crate::tips::anchor_rect(&h.ctx, "home-catalog").unwrap();
        assert!(ring.contains_rect(catalog) || catalog.contains_rect(ring));
        h.get_by_label_contains("This is the catalog you are in");
        let bubble = h.get_by_label("Next").rect();
        assert!(bubble.min.y > catalog.max.y, "the bubble hangs under it");
        assert!(bubble.min.x < catalog.max.x + 200.0, "and sits beside it");
        assert!(h.query_by_label("Skip").is_some());
        assert!(h.query_by_label("Got it").is_none());
        h.get_by_label("Next").click();
        h.run();
        // The next tip points at the strays tile on the dashboard.
        h.get_by_label_contains("This card collects all strays");
        let tile = h.get_by_label("1 strays").rect();
        let ring = crate::tips::anchor_rect(&h.ctx, "home-strays").unwrap();
        assert!(ring.contains_rect(tile) || tile.contains_rect(ring));
        let bubble = h.get_by_label("Next").rect();
        assert!(bubble.min.y > tile.max.y);
        // Skip ends the Home tour: no more tips there, the map's untouched.
        h.get_by_label("Skip").click();
        h.run();
        assert!(h.query_by_label("Skip").is_none());
        assert!(
            h.query_by_label_contains("Sync with people you know")
                .is_none()
        );
        // The map's tips ring the search box, then the stray areas button;
        // the last one says Got it.
        open_view(&mut h, "Map");
        h.get_by_label_contains("Type a cat, place, or person here");
        assert!(crate::tips::anchor_rect(&h.ctx, "map-search").is_some());
        h.get_by_label("Next").click();
        h.run();
        h.get_by_label_contains("Show circles around its poster spots");
        assert!(crate::tips::anchor_rect(&h.ctx, "map-layers").is_some());
        assert!(h.query_by_label("Next").is_none());
        h.get_by_label("Got it").click();
        h.run();
        assert!(h.query_by_label("Got it").is_none());
    }

    #[test]
    fn a_clowder_gets_a_cover_from_a_file_or_a_drop_replaces_it_and_loses_it() {
        let dir = tempfile::tempdir().unwrap();
        let foster = "clowder:00000000-0000-4000-8000-000000000001";
        let first = picture_file(dir.path(), "house.png", 80, 60);
        let second = picture_file(dir.path(), "yard.png", 60, 80);
        let mut app = seeded(dir.path());
        let hand = first.clone();
        app.pick_files = Box::new(move |_, _, _| vec![hand.clone()]);
        let mut h = harness(app);
        h.run();
        open_row(&mut h, "Foster Home");
        assert!(h.state().store().profile_image(foster).unwrap().is_none());
        // The card's menu asks for the picture and makes it the cover.
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label("Cover picture…").click_accesskit();
        h.run();
        let cover = h.state().store().profile_image(foster).unwrap().unwrap();
        assert_eq!(h.state().store().images(foster).unwrap().len(), 1);
        // A second picture replaces it: one picture per place.
        let hand = second.clone();
        h.state_mut().pick_files = Box::new(move |_, _, _| vec![hand.clone()]);
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label("Cover picture…").click_accesskit();
        h.run();
        let replaced = h.state().store().profile_image(foster).unwrap().unwrap();
        assert_ne!(replaced, cover);
        assert_eq!(h.state().store().images(foster).unwrap().len(), 1);
        // Dropped on the desk with the clowder open, a picture is the cover too.
        h.input_mut().dropped_files.push(egui::DroppedFile {
            path: Some(first.clone()),
            ..Default::default()
        });
        h.run();
        assert_eq!(
            h.state().store().profile_image(foster).unwrap().unwrap(),
            cover
        );
        assert_eq!(h.state().store().images(foster).unwrap().len(), 1);
        // The page shows and removes it as well.
        open_cat_page(&mut h, foster);
        h.get_by_label("Remove cover picture").click();
        h.run();
        assert!(h.state().store().profile_image(foster).unwrap().is_none());
        assert!(h.state().store().images(foster).unwrap().is_empty());
        assert!(h.query_by_label("Remove cover picture").is_none());
    }

    #[test]
    fn the_map_search_jumps_to_a_cat_by_name_or_to_a_place_and_says_what_it_found() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let mut h = harness(seeded_with(dir.path(), "moves"));
        h.run();
        open_view(&mut h, "Map");
        // A cat by name: the map centres on her position and draws her trail.
        h.state_mut().map_page.query = "mie".into();
        h.get_by_label("Search").click();
        h.run();
        let viewport = h.state().map_page.map.viewport;
        assert!((viewport.lat - 51.35).abs() < 0.001 && (viewport.lon - 12.38).abs() < 0.001);
        assert_eq!(viewport.zoom, 15);
        assert_eq!(h.state().map_page.trail_of.as_deref(), Some(miezi));
        h.get_by_label("Miezi");
        // No record of that name: the geocoder's first hit, at its extent.
        h.state_mut().map_page.query = "Leipzig".into();
        h.get_by_label("Search").click();
        h.run();
        let viewport = h.state().map_page.map.viewport;
        assert!((viewport.lat - 51.34).abs() < 0.001);
        assert_eq!(viewport.zoom, 10, "a city's extent");
        assert!(h.state().map_page.trail_of.is_none());
        h.get_by_label("Leipzig, Sachsen");
        // Nothing at all: the reason stays readable.
        h.state_mut().map_page.query = "nowhere".into();
        h.get_by_label("Search").click();
        h.run();
        h.get_by_label("no such place");
    }

    #[test]
    fn a_new_cat_starts_with_a_proposed_name_and_the_dice_throws_another() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_view(&mut h, "Cats");
        h.get_by_label("New cat").click();
        h.run();
        assert!(h.state().dialog.open);
        let first = h.state().dialog.value.clone();
        assert!(!first.is_empty(), "a name to start with");
        let taken = ["miezi", "tom", "wanderer"];
        assert!(!taken.contains(&first.to_lowercase().as_str()));
        assert!(crate::names::pool("en", false).contains(&first.as_str()));
        // The dice throws until another name comes, never one in use.
        let mut seen = std::collections::BTreeSet::new();
        seen.insert(first);
        for _ in 0..6 {
            h.get_by_label("Propose another name").click();
            h.run();
            let name = h.state().dialog.value.clone();
            assert!(!taken.contains(&name.to_lowercase().as_str()));
            seen.insert(name);
        }
        assert!(seen.len() > 1, "the dice rolls: {seen:?}");
        // Whatever is in the field is what Create takes.
        h.state_mut().dialog.value = "Pixel".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert!(
            h.state()
                .store()
                .cats(None)
                .unwrap()
                .iter()
                .any(|c| c.name == "Pixel")
        );
        // Other name dialogs have no dice.
        open_view(&mut h, "Clowders");
        h.get_by_label("New clowder").click();
        h.run();
        assert!(h.state().dialog.dice.is_none());
        assert!(h.state().dialog.value.is_empty());
    }

    #[test]
    fn the_editor_and_the_card_refuse_the_impossible_with_the_phone_s_words() {
        let dir = tempfile::tempdir().unwrap();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let mut app = seeded(dir.path());
        app.store_mut()
            .append(miezi, "f:deceased", Some("2025-01-01"))
            .unwrap();
        let mut h = harness(app);
        h.run();
        // The editor: a birth after the death is named and Save stays shut.
        open_cat_page(&mut h, miezi);
        let def = h.state().store().field_def("birthdate").unwrap().unwrap();
        {
            let app = h.state_mut();
            let (editor, store) = (&mut app.editor, &app.store);
            editor.ask(store, &def, miezi, None, EditTarget::New, None, "en");
        }
        h.run();
        h.state_mut().editor.choice = Some("2025-02".into());
        h.run();
        h.get_by_label_contains("can't be after the date of death");
        h.get_by_label("Save").click();
        h.run();
        assert!(h.state().editor.open, "refused");
        h.state_mut().editor.choice = Some("2020".into());
        h.run();
        assert!(h.query_by_label_contains("can't be after").is_none());
        h.get_by_label("Save").click();
        h.run();
        assert!(!h.state().editor.open);
        assert_eq!(
            h.state()
                .store()
                .current(miezi, "f:birthdate")
                .unwrap()
                .as_deref(),
            Some("2020")
        );
        // The card: a pregnant tom is refused with the reason as a notice.
        h.key_press(egui::Key::Escape);
        h.run();
        h.state_mut()
            .store_mut()
            .append(miezi, "f:gender", Some("male"))
            .unwrap();
        open_view(&mut h, "Cats");
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        let pregnant = h.state().store().field_def("pregnant").unwrap().unwrap();
        h.state_mut().desk.inline =
            Some(crate::cards::Inline::picked(miezi, &pregnant.key(), "yes"));
        h.run();
        assert_eq!(
            h.state().store().current(miezi, "f:pregnant").unwrap(),
            None
        );
        h.get_by_label_contains("a male cat can't be pregnant");
    }

    fn open_catalog_menu_item(h: &mut Harness<'static, App>, label: &str) {
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label(label).click_accesskit();
        h.run();
    }

    #[test]
    fn moments_are_named_and_the_catalog_goes_back_to_one() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        app.backups_dir = dir.path().join("downloads");
        fixed_day(&mut app, 2026, 3, 10, 9);
        let mut h = harness(app);
        h.run();
        open_catalog_menu_item(&mut h, "Go back");
        assert_eq!(h.state().modal(), Some(Modal::Moments));
        h.get_by_label("Name this moment").click();
        h.run();
        h.state_mut().dialog.value = "Before the fair".into();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        h.get_by_label_contains("Before the fair · ");
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        h.state_mut()
            .store_mut()
            .append(miezi, "f:remarks", Some("later"))
            .unwrap();
        h.run();
        h.get_all_by_label("Go back to here")
            .next()
            .unwrap()
            .click();
        h.run();
        assert!(h.state().confirm.open);
        h.get_by_label_contains("1 change(s)");
        h.get_all_by_label("Go back to here")
            .last()
            .unwrap()
            .click();
        h.run();
        assert!(!h.state().confirm.open);
        h.get_by_label_contains("Undone. The file is in ");
        assert_eq!(h.state().store().current(miezi, "f:remarks").unwrap(), None);
        let kept: Vec<_> = std::fs::read_dir(dir.path().join("downloads"))
            .unwrap()
            .flatten()
            .collect();
        assert_eq!(kept.len(), 1);
        assert!(
            kept[0]
                .file_name()
                .to_string_lossy()
                .starts_with("catlog-undone-")
        );
    }

    #[test]
    fn old_records_are_archived_into_a_file_and_deleted() {
        let dir = tempfile::tempdir().unwrap();
        let archive = dir.path().join("archive.catsync");
        let mut app = seeded(dir.path());
        let tom = "cat:00000000-0000-4000-8000-000000000002";
        app.store_mut()
            .append(tom, "f:deceased", Some("2026-01-05"))
            .unwrap();
        fixed_day(&mut app, 2030, 1, 1, 9);
        let hand = archive.clone();
        app.save_file = Box::new(move |_, _| Some(hand.clone()));
        let mut h = harness(app);
        h.run();
        open_catalog_menu_item(&mut h, "Archive");
        assert_eq!(h.state().modal(), Some(Modal::Archive));
        h.get_by_label_contains("Deceased cats and empty clowders");
        // The dashboard behind the modal names Tom too.
        let toms = h.get_all_by_label("Tom").count();
        h.get_all_by_label("Tom").last().unwrap().click();
        h.run();
        h.get_by_label("Archive 1 entries").click();
        h.run();
        assert!(h.state().confirm.open);
        h.get_by_label("Archive 1 entries?");
        h.get_all_by_label("Archive").last().unwrap().click();
        h.run();
        h.get_by_label("1 entries archived and deleted");
        assert!(archive.is_file());
        assert!(h.state().store().is_deleted(tom).unwrap());
        assert_eq!(
            h.get_all_by_label("Tom").count(),
            toms - 1,
            "archived, no candidate anymore"
        );
        // Without a file nothing is deleted.
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        h.state_mut()
            .store_mut()
            .append(miezi, "f:deceased", Some("2026-01-05"))
            .unwrap();
        h.state_mut().save_file = Box::new(|_, _| None);
        h.run();
        h.get_all_by_label("Miezi").last().unwrap().click();
        h.run();
        h.get_by_label("Archive 1 entries").click();
        h.run();
        h.get_all_by_label("Archive").last().unwrap().click();
        h.run();
        h.get_by_label("Nothing was deleted: the archive was not saved anywhere.");
        assert!(!h.state().store().is_deleted(miezi).unwrap());
    }

    #[test]
    fn backups_are_written_on_demand_and_come_back_as_catalogs() {
        let dir = tempfile::tempdir().unwrap();
        let downloads = dir.path().join("downloads");
        let cloud = dir.path().join("cloud");
        std::fs::create_dir_all(&cloud).unwrap();
        let mut app = seeded(dir.path());
        app.backups_dir = downloads.clone();
        let hand = cloud.clone();
        app.pick_folder = Box::new(move |_| Some(hand.clone()));
        let mut h = harness(app);
        h.run();
        open_catalog_menu_item(&mut h, "Backups");
        h.get_by_label("No copy written yet.");
        h.get_by_label("Also copy to a folder…").click();
        h.run();
        h.get_by_label_contains("Also copied to ");
        h.get_by_label("Back up now").click();
        h.run();
        let backup = downloads.join("catlog-clowders.catsync");
        assert!(backup.is_file());
        assert!(
            cloud
                .join("catlog-backups")
                .join("catlog-clowders.catsync")
                .is_file()
        );
        h.get_by_label_contains("Last copy: ");
        h.get_by_label("Stop copying there").click();
        h.run();
        h.get_by_label("Also copy to a folder…");
        // Leaving the app writes one when something changed.
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        h.state_mut()
            .store_mut()
            .append(miezi, "f:remarks", Some("bye"))
            .unwrap();
        let before = std::fs::metadata(&backup).unwrap().len();
        h.state_mut().on_exit();
        assert_ne!(std::fs::metadata(&backup).unwrap().len(), before);
        // Restore: the set is listed, ticked and becomes a catalog.
        // The modal blocks the menu until it closes.
        h.key_press(egui::Key::Escape);
        h.run();
        open_catalog_menu_item(&mut h, "Restore backups…");
        assert_eq!(h.state().modal(), Some(Modal::Restore));
        // The pane heading says "Clowders" too; the set's box comes last.
        h.get_all_by_label("Clowders").last().unwrap().click();
        h.run();
        h.get_by_label_contains("1 file, newest ");
        h.get_by_label("Restore").click();
        h.run();
        h.get_by_label("1 catalog restored.");
        assert_eq!(h.state().manager().catalogs().len(), 2);
        assert!(
            h.state()
                .manager()
                .catalogs()
                .iter()
                .any(|c| c.name == "Clowders (2)")
        );
        // Picked files join the list.
        let other = dir.path().join("catlog-elsewhere.catsync");
        std::fs::copy(&backup, &other).unwrap();
        let hand = other.clone();
        h.state_mut().pick_files = Box::new(move |_, _, _| vec![hand.clone()]);
        h.get_by_label("Pick files…").click();
        h.run();
        h.get_by_label("Elsewhere");
    }

    #[test]
    fn the_moderation_page_deletes_an_author_and_bans_the_device() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_catalog_menu_item(&mut h, "Authors & bans");
        assert_eq!(h.state().modal(), Some(Modal::Moderation));
        h.get_by_label("Who wrote into this catalog");
        let rows = h.state().store().authors_overview().unwrap();
        let me = h.state().store().device_id();
        let (author, device, _) = rows.iter().find(|r| r.1 != me).unwrap().clone();
        assert_eq!(author, "Ada");
        h.get_by_label_contains("Ada · key ");
        h.get_by_label("Also ban — never accept their data again")
            .click();
        h.run();
        // Rows sort by author and device: Ada's foreign device comes first.
        h.get_all_by_label("Delete everything by this author")
            .next()
            .unwrap()
            .click();
        h.run();
        assert!(h.state().confirm.open);
        h.get_by_label_contains("This cannot be undone.");
        h.get_all_by_label("Delete").last().unwrap().click();
        h.run();
        h.get_by_label("Deleted.");
        let left = h.state().store().authors_overview().unwrap();
        assert!(!left.iter().any(|r| r.0 == author && r.1 == device));
        assert!(
            h.state().store().cats(None).unwrap().is_empty(),
            "the fixture's cats were theirs"
        );
        h.get_by_label("Bans");
        let bans = h.state().store().bans().unwrap();
        assert!(bans.iter().any(|(k, v)| k == "device" && *v == device));
        assert!(
            bans.iter().any(|(k, _)| k == "blob"),
            "their photos are banned too"
        );
        // Blob bans list first; the device row comes last.
        h.get_all_by_label("Remove ban").last().unwrap().click();
        h.run();
        let bans = h.state().store().bans().unwrap();
        assert!(!bans.iter().any(|(k, v)| k == "device" && *v == device));
    }

    struct OfflineFonts;

    impl FontSource for OfflineFonts {
        fn fetch(&self, _url: &str) -> Result<Vec<u8>, String> {
            Err("offline".into())
        }
    }

    fn open_cat_document(h: &mut Harness<'static, App>, item: &str) {
        open_cat_page(h, "cat:00000000-0000-4000-8000-000000000001");
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label(item).click_accesskit();
        h.run();
    }

    #[test]
    fn the_card_is_chosen_saved_as_pdf_and_image_and_printed() {
        let dir = tempfile::tempdir().unwrap();
        let target = std::sync::Arc::new(std::sync::Mutex::new(dir.path().join("card.pdf")));
        let opened = std::sync::Arc::new(std::sync::Mutex::new(Vec::<PathBuf>::new()));
        let mut app = seeded(dir.path());
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        app.store_mut()
            .append(miezi, "f:chipid", Some("276098100"))
            .unwrap();
        app.font_source = Box::new(OfflineFonts);
        let hand = target.clone();
        app.save_file = Box::new(move |_, _| Some(hand.lock().unwrap().clone()));
        let hand = opened.clone();
        app.open_file = Box::new(move |p| hand.lock().unwrap().push(p.to_path_buf()));
        let mut h = harness(app);
        h.run();
        open_cat_document(&mut h, "Card");
        assert_eq!(h.state().modal(), Some(Modal::Document));
        assert_eq!(h.state().document.kind, Some(DocKind::Card));
        h.get_by_label("Card — Miezi");
        h.get_by_label("What goes on the card");
        // Untick the clowder: the choice is remembered.
        h.get_all_by_label("Clowder").last().unwrap().click();
        h.run();
        assert!(!h.state().document.card_keys.contains(keys::CLOWDER));
        assert!(h.state().store().local_setting("cardFields").is_some());
        let card = h.state().document.card_content(
            h.state().store(),
            h.state().t(),
            catlog_core::units::UnitSystem::Metric,
        );
        assert_eq!(card.name, "Miezi");
        assert!(card.photo.is_some());
        assert!(card.facts.iter().any(|(l, _)| l == "Gender"));
        assert!(!card.facts.iter().any(|(l, _)| l == "Clowder"));
        assert_eq!(card.codes.len(), 1, "the chip prints as a code");
        h.get_by_label("Save as PDF…").click();
        h.run();
        let pdf = dir.path().join("card.pdf");
        assert!(pdf.is_file());
        assert_eq!(lopdf::Document::load(&pdf).unwrap().get_pages().len(), 1);
        h.get_by_label_contains("Saved to ");
        *target.lock().unwrap() = dir.path().join("card.png");
        h.get_by_label("Save as image…").click();
        h.run();
        let png = image::open(dir.path().join("card.png")).unwrap();
        assert_eq!(png.width(), 800);
        h.get_by_label("Print").click();
        h.run();
        let printed = opened.lock().unwrap().clone();
        assert_eq!(printed.len(), 1);
        assert!(printed[0].is_file());
        assert!(printed[0].ends_with("Miezi-card.pdf"));
    }

    #[test]
    fn the_poster_takes_its_lines_photos_and_qr_and_the_report_its_fields() {
        let dir = tempfile::tempdir().unwrap();
        let target = std::sync::Arc::new(std::sync::Mutex::new(dir.path().join("poster.pdf")));
        let mut app = seeded(dir.path());
        fixed_day(&mut app, 2026, 3, 10, 9);
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        app.store_mut()
            .append(miezi, "f:weight", Some("3.2"))
            .unwrap();
        app.store_mut()
            .append(miezi, "f:weight", Some("3.4"))
            .unwrap();
        app.store_mut()
            .append(miezi, "f:birthdate", Some("2024-01-01"))
            .unwrap();
        let home = "clowder:00000000-0000-4000-8000-000000000001";
        app.store_mut()
            .append(home, "f:phone", Some("0170 1234567"))
            .unwrap();
        app.font_source = Box::new(OfflineFonts);
        let hand = target.clone();
        app.save_file = Box::new(move |_, _| Some(hand.lock().unwrap().clone()));
        let mut h = harness(app);
        h.run();
        open_cat_document(&mut h, "Missing poster…");
        assert_eq!(h.state().document.kind, Some(DocKind::Poster));
        h.get_by_label("MISSING — Miezi");
        h.get_by_label("Photos, up to two");
        assert_eq!(
            h.state().document.photos.len(),
            1,
            "the profile image leads"
        );
        assert!(h.state().document.qr);
        h.state_mut().document.extra = "Very shy".into();
        h.state_mut().document.since = "2026-03-01".into();
        h.run();
        let poster = h.state().document.poster_content(
            h.state().store(),
            h.state().t(),
            catlog_core::units::UnitSystem::Metric,
        );
        assert_eq!(poster.name, "Miezi");
        assert_eq!(poster.phone.as_deref(), Some("0170 1234567"));
        assert!(
            poster
                .lines
                .iter()
                .any(|l| l.starts_with("Missing since: 3/1/2026"))
        );
        assert!(
            poster
                .lines
                .iter()
                .any(|l| l.starts_with("Address: Katzenweg"))
        );
        assert_eq!(poster.extra.as_deref(), Some("Very shy"));
        assert_eq!(poster.codes.len(), 1, "the share QR");
        assert!(poster.codes[0].data.starts_with("catlog-share:d:"));
        assert_eq!(poster.photos.len(), 1);
        h.get_by_label("QR code for cat(a)log").click();
        h.run();
        assert!(!h.state().document.qr);
        h.get_by_label("Save as PDF…").click();
        h.run();
        assert_eq!(
            lopdf::Document::load(dir.path().join("poster.pdf"))
                .unwrap()
                .get_pages()
                .len(),
            1
        );
        // The report: fields with a history, a range, the summary.
        *target.lock().unwrap() = dir.path().join("report.pdf");
        open_cat_document(&mut h, "Report for the vet…");
        assert_eq!(h.state().document.kind, Some(DocKind::VetReport));
        h.get_by_label("Report for the vet — Miezi");
        h.get_by_label("Patient summary");
        assert!(h.state().document.fields.contains("f:weight"));
        assert!(h.state().document.fields.contains("f:gender"));
        h.get_all_by_label("Gender").last().unwrap().click();
        h.run();
        assert!(!h.state().document.fields.contains("f:gender"));
        // The readings were written today by the wall clock: widen the range.
        h.state_mut().document.to = "2027-12-31".into();
        h.run();
        let report = h.state().document.report_content(
            h.state().store(),
            h.state().t(),
            catlog_core::units::UnitSystem::Metric,
            h.state().pages.today,
            true,
        );
        assert!(report.summary.is_some());
        let summary = report.summary.as_ref().unwrap();
        assert!(
            summary
                .facts
                .iter()
                .any(|(l, v)| l == "Age" && v == "2 years 2 months")
        );
        assert!(
            summary
                .facts
                .iter()
                .any(|(l, v)| l == "Phone" && v == "0170 1234567")
        );
        assert!(report.rows.iter().any(|r| r.label == "Weight"));
        assert!(!report.rows.iter().any(|r| r.label == "Gender"));
        assert_eq!(report.curves.len(), 1, "weight has two readings");
        assert!(report.note.is_none());
        h.get_by_label("Save as PDF…").click();
        h.run();
        let pages = lopdf::Document::load(dir.path().join("report.pdf"))
            .unwrap()
            .get_pages()
            .len();
        assert!(pages >= 3, "sheet, timeline, curve: {pages}");
    }

    #[test]
    fn a_language_without_its_fonts_says_so_on_the_page() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = app(dir.path(), "he", true);
        app.font_source = Box::new(OfflineFonts);
        let fixture = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../fixtures/fresh/folder");
        app.store_mut().import_folder(&fixture, None).unwrap();
        let mut h = harness(app);
        h.run();
        assert!(!h.state_mut().fonts().complete);
        assert!(h.state_mut().fonts().rtl);
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        {
            let app = h.state_mut();
            let today = chrono::NaiveDate::from_ymd_opt(2026, 3, 10).unwrap();
            let (document, store) = (&mut app.document, &app.store);
            document.open(store, DocKind::Card, miezi, today);
        }
        h.state_mut().modal = Some(Modal::Document);
        h.run();
        h.get_by_label_contains("Noto Sans");
        assert!(h.state_mut().document_pdf().is_some());
    }

    struct FakeOcr(bool);

    impl Ocr for FakeOcr {
        fn recognize(&self, _image: &[u8]) -> Result<Vec<catlog_core::flier::FlierLine>, String> {
            if self.0 {
                Ok(catlog_core::flier::fixtures::hugo_lines())
            } else {
                Err("no models".into())
            }
        }
    }

    fn wait_for_recognition(h: &mut Harness<'static, App>) {
        for _ in 0..50 {
            h.run();
            if h.state().capture.reading.is_some() || h.state().capture.error.is_some() {
                return;
            }
            std::thread::sleep(std::time::Duration::from_millis(20));
        }
        panic!("recognition never answered");
    }

    #[test]
    fn a_poster_image_becomes_a_missing_cat_with_its_owner_and_flier_position() {
        let dir = tempfile::tempdir().unwrap();
        let poster = picture_file(dir.path(), "poster.png", 60, 80);
        let mut app = seeded(dir.path());
        fixed_day(&mut app, 2026, 3, 10, 9);
        app.ocr = Arc::new(FakeOcr(true));
        let hand = poster.clone();
        app.pick_files = Box::new(move |_, _, _| vec![hand.clone()]);
        let mut h = harness(app);
        h.run();
        open_catalog_menu_item(&mut h, "Capture flier");
        assert_eq!(h.state().modal(), Some(Modal::Capture));
        h.get_by_label("Open image…").click();
        wait_for_recognition(&mut h);
        h.get_by_label("TASSO poster recognized. Check below which field each line goes to.");
        let draft = &h.state().capture.draft;
        assert_eq!(draft.name, "HUGO");
        assert_eq!(
            draft.missing_since,
            chrono::NaiveDate::from_ymd_opt(2025, 6, 5)
        );
        assert_eq!(draft.address, "04207 Leipzig, Colberger Weg. Deutschland");
        assert_eq!(
            draft.cat_fields.get("breed").map(String::as_str),
            Some("Europäische Langhaarkatze")
        );
        assert_eq!(
            draft.cat_fields.get("gender").map(String::as_str),
            Some("male")
        );
        assert_eq!(
            draft.cat_fields.get("birthdate").map(String::as_str),
            Some("2024-05-26")
        );
        assert_eq!(draft.registry_hits.len(), 1);
        assert_eq!(draft.registry_hits[0].value, "S2983764");
        assert!(
            draft.remarks.contains("GESUCHT!") && draft.remarks.contains("Das Tier ist gechipt.")
        );
        assert!(draft.photo.is_some());
        // Put a line aside, then take it back.
        h.get_by_label("Kennzeichnung: Das Tier ist gechipt.");
        let index = h
            .state()
            .capture
            .reading
            .as_ref()
            .unwrap()
            .entries
            .iter()
            .position(|e| e.value == "Das Tier ist gechipt.")
            .unwrap();
        let t = *h.state().t();
        {
            let app = h.state_mut();
            app.capture.hide(index);
            let (capture, store) = (&mut app.capture, &app.store);
            capture.apply_reading(store, &t);
        }
        h.run();
        h.get_by_label("1 line put aside");
        assert!(!h.state().capture.draft.remarks.contains("gechipt"));
        h.get_by_label("Undo").click();
        h.run();
        assert!(h.state().capture.draft.remarks.contains("gechipt"));
        // Send the colour line to remarks instead.
        let colour = h
            .state()
            .capture
            .reading
            .as_ref()
            .unwrap()
            .entries
            .iter()
            .position(|e| e.value == "braun")
            .unwrap();
        {
            let app = h.state_mut();
            app.capture.assign(colour, "remarks");
            let (capture, store) = (&mut app.capture, &app.store);
            capture.apply_reading(store, &t);
        }
        h.run();
        assert!(h.state().capture.draft.remarks.contains("Farbe: braun"));
        assert!(!h.state().capture.draft.cat_fields.contains_key("color"));
        // The address on the map: the fake geocoder answers Leipzig.
        h.get_by_label("Find address on the map").click_accesskit();
        h.run();
        h.get_by_label_contains("Address found");
        assert_eq!(h.state().capture.draft.flier_position, Some((51.34, 12.37)));
        h.state_mut().capture.draft.owner = "Familie Müller".into();
        h.run();
        // The page is long: the button is below the fold.
        h.get_by_label("Save").click_accesskit();
        h.run();
        let Selection::Cat(cat) = h.state().selection().clone() else {
            panic!("the new cat's page opens: {:?}", h.state().notice);
        };
        let store = h.state().store();
        assert_eq!(
            store.current(&cat, keys::NAME).unwrap().as_deref(),
            Some("HUGO")
        );
        assert!(store.strays().unwrap().iter().any(|c| c.id == cat));
        let owner = store
            .former_clowder(&cat)
            .unwrap()
            .expect("an owner clowder");
        assert_eq!(
            store.current(&owner, keys::NAME).unwrap().as_deref(),
            Some("Familie Müller")
        );
        assert_eq!(
            store.current(&owner, "f:status").unwrap().as_deref(),
            Some("owner")
        );
        assert_eq!(
            store.current(&owner, "f:address").unwrap().as_deref(),
            Some("04207 Leipzig, Colberger Weg. Deutschland")
        );
        assert_eq!(store.flier_positions(&cat).unwrap(), vec![(51.34, 12.37)]);
        assert_eq!(
            store.current(&cat, "f:breed").unwrap().as_deref(),
            Some("Europäische Langhaarkatze")
        );
        assert_eq!(
            store.current(&cat, "f:tasso").unwrap().as_deref(),
            Some("S2983764")
        );
        assert_eq!(store.images(&cat).unwrap().len(), 1, "the poster picture");
        assert!(
            store
                .current(&cat, "f:remarks")
                .unwrap()
                .unwrap()
                .contains("Farbe: braun")
        );
        assert!(!h.state().capture.open);
    }

    #[test]
    fn without_text_recognition_the_page_says_so_and_still_saves_by_hand() {
        let dir = tempfile::tempdir().unwrap();
        let poster = picture_file(dir.path(), "poster.png", 60, 80);
        let mut app = seeded(dir.path());
        app.ocr = Arc::new(FakeOcr(false));
        let hand = poster.clone();
        app.pick_files = Box::new(move |_, _, _| vec![hand.clone()]);
        let mut h = harness(app);
        h.run();
        open_catalog_menu_item(&mut h, "Capture flier");
        h.get_by_label("Open image…").click();
        wait_for_recognition(&mut h);
        h.get_by_label_contains("Text recognition is not available");
        h.state_mut().capture.draft.name = "Minka".into();
        h.run();
        h.get_by_label("Save").click();
        h.run();
        let Selection::Cat(cat) = h.state().selection().clone() else {
            panic!("saved by hand");
        };
        let store = h.state().store();
        assert_eq!(
            store.current(&cat, keys::NAME).unwrap().as_deref(),
            Some("Minka")
        );
        let owner = store.former_clowder(&cat).unwrap().unwrap();
        assert_eq!(
            store.current(&owner, keys::NAME).unwrap().as_deref(),
            Some("Owner of Minka")
        );
        assert_eq!(store.images(&cat).unwrap().len(), 1);
    }

    fn recorded_urls(app: &mut App) -> std::sync::Arc<std::sync::Mutex<Vec<String>>> {
        let urls = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
        let hand = urls.clone();
        app.open_url = Box::new(move |u| hand.lock().unwrap().push(u.to_string()));
        urls
    }

    #[test]
    fn the_settings_page_changes_units_cheers_tips_mode_and_deletes_a_catalog() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        app.backups_dir = dir.path().join("downloads");
        let mut h = harness(app);
        h.run();
        h.get_by_label("cat(a)log").click();
        h.step();
        h.get_by_label("Settings").click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Settings));
        assert_eq!(h.state().settings_page.author, "Ada");
        // Units: the second combo (language, units, title) offers three.
        let combo = |h: &Harness<'static, App>, n: usize| {
            h.get_all_by_role(egui::accesskit::Role::ComboBox)
                .nth(n)
                .expect("a combo")
                .click()
        };
        combo(&h, 1);
        h.step();
        h.get_by_label("Metric (kg, cm, ml, °C)").click_accesskit();
        h.run();
        assert_eq!(
            h.state().store().local_setting("units").as_deref(),
            Some("metric")
        );
        assert_eq!(
            h.state().pages.units,
            catlog_core::units::UnitSystem::Metric
        );
        // The popup may still be up from the pick: a click then closes it.
        h.run();
        combo(&h, 1);
        h.step();
        if h.query_by_label("Imperial (lb, in, fl oz, °F)").is_none() {
            combo(&h, 1);
            h.step();
        }
        h.get_by_label("Imperial (lb, in, fl oz, °F)")
            .click_accesskit();
        h.run();
        assert_eq!(
            h.state().pages.units,
            catlog_core::units::UnitSystem::Imperial
        );
        // The tick's sound: its combo comes right after the units, None
        // is a choice and is kept; the other moments keep theirs.
        let played = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
        h.state_mut().sounder = Box::new(crate::sounds::RecordingSounder {
            played: played.clone(),
        });
        h.run();
        combo(&h, 2);
        h.step();
        if h.query_by_label("Chorus of meows").is_none() {
            combo(&h, 2);
            h.step();
        }
        h.get_by_label("Chorus of meows").click_accesskit();
        h.run();
        assert_eq!(
            h.state().store().local_setting("sound:tick").as_deref(),
            Some("chorus")
        );
        assert_eq!(
            *played.lock().unwrap(),
            vec![crate::sounds::CHORUS.len()],
            "the pick is heard"
        );
        h.run();
        combo(&h, 2);
        h.step();
        if h.query_by_label("None").is_none() {
            combo(&h, 2);
            h.step();
        }
        h.get_by_label("None").click_accesskit();
        h.run();
        assert_eq!(
            h.state().store().local_setting("sound:tick").as_deref(),
            Some("none")
        );
        assert_eq!(played.lock().unwrap().len(), 1, "none is silent");
        assert!(h.state().store().local_setting("sound:dayDone").is_none());
        // Own sound…: the file dialog, the copy kept beside the data, heard.
        let own = dir.path().join("mine.wav");
        std::fs::write(&own, crate::sounds::MEEP).unwrap();
        let own_for_picker = own.clone();
        h.state_mut().pick_files = Box::new(move |_, _, _| vec![own_for_picker.clone()]);
        h.state_mut().data_dir = dir.path().join("data");
        h.run();
        combo(&h, 2);
        h.step();
        if h.query_by_label("Own sound…").is_none() {
            combo(&h, 2);
            h.step();
        }
        h.get_by_label("Own sound…").click_accesskit();
        h.run();
        let kept = dir.path().join("data/sounds/tick.wav");
        assert!(kept.exists(), "{:?}", h.state().notice);
        assert_eq!(
            h.state().store().local_setting("sound:tick").as_deref(),
            Some(format!("file:{}", kept.display()).as_str())
        );
        assert_eq!(
            *played.lock().unwrap().last().unwrap(),
            crate::sounds::MEEP.len()
        );
        h.get_by_label("Show tips again").click();
        h.run();
        h.get_by_label("The highlights will show again");
        // The Eye candy switch is remembered in the app's settings.
        assert!(!h.state().settings.settings.eye_candy, "tests run still");
        h.get_by_label("Eye candy: fades, slides and eased hovers")
            .click();
        h.run();
        assert!(h.state().settings.settings.eye_candy);
        assert!(SettingsFile::load(dir.path()).settings.eye_candy);
        h.get_by_label("Eye candy: fades, slides and eased hovers")
            .click();
        h.run();
        assert!(!h.state().settings.settings.eye_candy);
        // The Catalog holds pets now.
        h.get_by_label("Pets").click();
        h.run();
        assert_eq!(
            h.state()
                .store()
                .current("catalog:mode", "mode")
                .unwrap()
                .as_deref(),
            Some("pets")
        );
        h.get_by_label_contains("Your key");
        h.get_by_label_contains("Database ");
        // The last catalog cannot go.
        h.get_by_label("Delete catalog").click_accesskit();
        h.run();
        assert!(h.state().confirm.open);
        h.get_all_by_label("Delete").last().unwrap().click();
        h.run();
        h.get_by_label("This is the catalog you are in. Switch to another one, then delete it.");
        // With a second one it goes, after a backup, and the other opens.
        h.key_press(egui::Key::Escape);
        h.run();
        assert_eq!(h.state().modal(), None);
        h.get_by_label("Catalog").click();
        h.step();
        h.get_by_label("New catalog").click();
        h.run();
        h.state_mut().dialog.value = "Leipzig".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(h.state().title(), "Leipzig");
        h.get_by_label("Catalog").click();
        h.step();
        h.get_all_by_label("Clowders").last().unwrap().click();
        h.run();
        h.state_mut().open_settings();
        h.run();
        h.get_by_label("Delete catalog").click_accesskit();
        h.run();
        h.get_all_by_label("Delete").last().unwrap().click();
        h.run();
        h.get_by_label_contains("Clowders deleted. The file is in ");
        assert_eq!(h.state().title(), "Leipzig");
        assert_eq!(h.state().manager().catalogs().len(), 1);
        assert!(
            dir.path()
                .join("downloads")
                .join("catlog-clowders.catsync")
                .is_file()
        );
    }

    #[test]
    fn tips_show_once_help_opens_and_about_links_out() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        let urls = recorded_urls(&mut app);
        app.tips_quiet = false;
        let mut h = harness(app);
        h.run();
        h.get_by_label(
            "This is the catalog you are in. Tap the name to switch, or to make another one.",
        );
        h.get_by_label("Next").click();
        h.run();
        assert!(
            h.query_by_label_contains("This is the catalog you are in")
                .is_none()
        );
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        // The Cat page's first tip.
        h.get_by_label(L10n::new("en").spot_cat_edit());
        // Help for what is shown: the page closes, the cat stays looked at.
        h.key_press(egui::Key::Escape);
        h.run();
        h.state_mut().open_view(View::Cats);
        h.run();
        h.get_by_label("Help").click();
        h.step();
        h.get_by_label("Help for this page").click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Help));
        h.get_by_label_contains("Everything about this cat");
        h.state_mut().modal = None;
        h.run();
        // About: the links open outside.
        h.get_by_label("Help").click();
        h.step();
        h.get_by_label("About & feedback").click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::About));
        h.get_by_label("Source code").click();
        h.run();
        h.get_by_label("Write the developer").click();
        h.run();
        let opened = urls.lock().unwrap().clone();
        assert_eq!(opened[0], "https://github.com/paxel/catlog");
        assert!(opened[1].starts_with("mailto:taum@tuta.io"));
        h.get_by_label("Open-source licenses").click();
        h.run();
        h.get_by_label_contains("Noto Sans");
    }

    #[test]
    fn a_crash_report_shows_the_friendly_screen_and_is_kept_until_sent() {
        let dir = tempfile::tempdir().unwrap();
        let root = dir.path().join("data");
        std::fs::create_dir_all(&root).unwrap();
        crate::crash::record(&root, "panicked at 'boom'", "0: catlog_gui::app");
        let mut first = app(dir.path(), "en", true);
        let urls = recorded_urls(&mut first);
        assert!(first.crash_report.is_some());
        let mut h = harness(first);
        h.run();
        h.get_by_label("That should not have happened");
        h.get_by_label("Restart the app").click();
        h.run();
        assert!(h.state().crash_report.is_none());
        assert!(crate::crash::last_crash(&root).is_some(), "kept until sent");
        // Next start: still there; sending clears it.
        let mut again = app(dir.path(), "en", true);
        let urls2 = recorded_urls(&mut again);
        let mut h = harness(again);
        h.run();
        h.get_by_label("Send report to the developer").click();
        h.run();
        assert!(crate::crash::last_crash(&root).is_none());
        let sent = urls2.lock().unwrap().clone();
        assert_eq!(sent.len(), 1);
        assert!(
            sent[0].starts_with("mailto:taum@tuta.io?subject=cat%28a%29log%20crash%20report&body=")
        );
        assert!(sent[0].contains("boom"));
        assert!(urls.lock().unwrap().is_empty());
    }

    #[test]
    fn chores_done_cheer_once_and_ladders_are_recorded_and_shown() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        fixed_day(&mut app, 2026, 3, 10, 9);
        let played = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
        app.sounder = Box::new(crate::sounds::RecordingSounder {
            played: played.clone(),
        });
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let feed = app
            .store_mut()
            .create_chore(
                "c1",
                &catlog_core::chores::Chore {
                    id: String::new(),
                    entity: miezi.into(),
                    title: "Feed".into(),
                    schedule: catlog_core::chores::ChoreSchedule::daily(),
                    time: None,
                    start: chrono::NaiveDate::from_ymd_opt(2026, 3, 1).unwrap(),
                    paused: false,
                    ended: false,
                    remind: false,
                    remind_at: None,
                    extra: Default::default(),
                },
            )
            .unwrap();
        for d in 1..=9 {
            let day = chrono::NaiveDate::from_ymd_opt(2026, 3, d).unwrap();
            app.store_mut().tick_chore(&feed, day, day).unwrap();
        }
        let mut h = harness(app);
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        // The tenth tick: the day is done and the servant's rank reached.
        h.get_all_by_role(egui::accesskit::Role::CheckBox)
            .last()
            .unwrap()
            .click();
        h.run();
        // The tick's call, then the ladder's chorus: the day done yields to it.
        assert_eq!(
            *played.lock().unwrap(),
            vec![crate::sounds::MEEP.len(), crate::sounds::CHORUS.len()]
        );
        h.get_by_label("Achievement: Servant (Feed)");
        assert_eq!(h.state().manager().achievements().len(), 1);
        // Untick and tick again: no second cheer today, nothing new climbed.
        h.get_all_by_role(egui::accesskit::Role::CheckBox)
            .last()
            .unwrap()
            .click();
        h.run();
        h.get_all_by_role(egui::accesskit::Role::CheckBox)
            .last()
            .unwrap()
            .click();
        h.run();
        assert_eq!(
            played.lock().unwrap().len(),
            3,
            "the meow again, nothing more"
        );
        assert_eq!(
            *played.lock().unwrap().last().unwrap(),
            crate::sounds::MEEP.len()
        );
        h.key_press(egui::Key::Escape);
        h.run();
        h.get_by_label("Help").click();
        h.step();
        h.get_by_label("Achievements").click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Achievements));
        h.get_by_label("Servant (Feed)");
        h.get_by_label_contains("Done 10 times, first on ");
        // The title can be worn.
        h.state_mut().open_settings();
        h.run();
        // Language, units, the four sounds, then the title.
        h.get_all_by_role(egui::accesskit::Role::ComboBox)
            .nth(6)
            .expect("the title combo")
            .click();
        h.step();
        h.get_all_by_label("Servant (Feed)")
            .last()
            .unwrap()
            .click_accesskit();
        h.run();
        assert_eq!(
            h.state()
                .store()
                .person_title(&h.state().store().device_id())
                .unwrap()
                .as_deref(),
            Some("servant|Feed")
        );
    }

    #[test]
    fn a_new_cat_comes_from_the_clowder_page_and_a_stray_from_the_cats_table() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_cat_page(&mut h, "clowder:00000000-0000-4000-8000-000000000001");
        h.get_by_label("New cat").click();
        h.run();
        assert!(h.state().dialog.open);
        h.state_mut().dialog.value = "Pixel".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        let Selection::Cat(cat) = h.state().selection().clone() else {
            panic!("the new cat's card opens");
        };
        assert_eq!(h.state().modal(), None, "the page makes way for the card");
        let store = h.state().store();
        assert_eq!(
            store.current(&cat, keys::NAME).unwrap().as_deref(),
            Some("Pixel")
        );
        assert_eq!(
            store.current(&cat, keys::CLOWDER).unwrap().as_deref(),
            Some("clowder:00000000-0000-4000-8000-000000000001")
        );
        assert_eq!(
            store.current(&cat, "f:species").unwrap().as_deref(),
            Some("cat")
        );
        h.state_mut().open_strays();
        h.run();
        h.get_by_label("New cat").click();
        h.run();
        h.state_mut().dialog.value = "Roamer".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        let Selection::Cat(stray) = h.state().selection().clone() else {
            panic!("the stray's card opens");
        };
        assert!(
            h.state()
                .store()
                .strays()
                .unwrap()
                .iter()
                .any(|c| c.id == stray)
        );
        assert_eq!(h.state().store().cats(None).unwrap().len(), 5);
    }

    /// A phone's joiner, as far as the desk sees it: the vector, then
    /// the sync with one cat of its own; the answer's status and body.
    fn phone_joins(dir: &Path, port: u16, pin: &str) -> (u16, String) {
        let mut phone = Catalog::open(dir).unwrap();
        phone.set_author("Bob").unwrap();
        phone.create_cat("cat:rex", "Rex", None, "cat").unwrap();
        let config = ureq::Agent::config_builder()
            .tls_config(
                ureq::tls::TlsConfig::builder()
                    .disable_verification(true)
                    .build(),
            )
            .http_status_as_error(false)
            .build();
        let agent = ureq::Agent::new_with_config(config);
        let base = format!("https://127.0.0.1:{port}");
        let mut res = agent
            .get(format!("{base}/vector"))
            .header("x-catlog-pin", pin)
            .call()
            .unwrap();
        let host_vector: std::collections::BTreeMap<String, i64> =
            serde_json::from_str(&res.body_mut().read_to_string().unwrap()).unwrap();
        let body = serde_json::json!({
            "format": 3,
            "vector": phone.version_vector().unwrap(),
            "entries": phone.entries_since(&host_vector, false).unwrap(),
            "author": "Bob",
            "deviceName": "phone",
            "deviceId": phone.device_id(),
            "keys": phone.key_records().unwrap(),
        });
        let mut res = agent
            .post(format!("{base}/sync"))
            .header("x-catlog-pin", pin)
            .content_type("application/json")
            .send(serde_json::to_vec(&body).unwrap().as_slice())
            .unwrap();
        let text = res.body_mut().read_to_string().unwrap_or_default();
        (res.status().as_u16(), text)
    }

    #[test]
    fn a_phone_with_the_code_joins_the_desk_in_person_unasked() {
        let dir = tempfile::tempdir().unwrap();
        let mut app = seeded(dir.path());
        app.in_person.bind = Some(std::net::IpAddr::V4(std::net::Ipv4Addr::LOCALHOST));
        app.in_person.poll_every = Some(Duration::from_secs(5));
        let mut h = harness(app);
        h.run();
        h.state_mut().open_modal(Modal::Sync);
        h.run();
        h.get_by_label("Start hosting").click();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::InPerson));
        let (port, pin) = {
            let host = h.state().in_person.host.as_ref().expect("hosting");
            (host.port(), host.pin().to_string())
        };
        h.get_by_label("Stop hosting");
        h.get_by_label(&format!("PIN: {pin}"));
        h.get_by_label("0 session(s) so far");
        let phone_dir = dir.path().join("phone");
        let joiner = std::thread::spawn(move || phone_joins(&phone_dir, port, &pin));
        // Frames run until the phone's sync went through: the code and
        // the PIN off this screen are the keeper's yes, nothing asks.
        let deadline = Instant::now() + Duration::from_secs(30);
        while h.state().in_person.sessions == 0 {
            assert!(Instant::now() < deadline, "no phone joined");
            h.step();
            std::thread::sleep(Duration::from_millis(20));
        }
        h.run();
        let (status, body) = joiner.join().unwrap();
        assert_eq!(status, 200, "{body}");
        assert!(body.contains("Miezi"), "the desk's cats went out");
        assert_eq!(
            h.state()
                .store()
                .current("cat:rex", "name")
                .unwrap()
                .as_deref(),
            Some("Rex")
        );
        assert_eq!(h.state().in_person.sessions, 1);
        assert!(h.state().summary.open);
        h.get_by_label("What arrived");
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().summary.open);
        h.get_by_label("1 session(s) so far");
        // Escape closes the modal and the host with it.
        h.key_press(egui::Key::Escape);
        h.run();
        assert_eq!(h.state().modal(), None);
        assert!(h.state().in_person.host.is_none());
    }

    /// The picture the last frame put on the clipboard, by its size.
    fn copied_image(h: &Harness<'static, App>) -> Option<[usize; 2]> {
        h.output()
            .platform_output
            .commands
            .iter()
            .find_map(|c| match c {
                egui::OutputCommand::CopyImage(image) => Some(image.size),
                _ => None,
            })
    }

    #[test]
    fn the_card_menu_copies_the_printed_card_as_a_picture() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_view(&mut h, "Cats");
        h.get_all_by_label("Miezi").next().unwrap().click();
        h.run();
        h.key_press(egui::Key::Enter);
        h.run();
        assert_eq!(h.state().desk.open.len(), 1);
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label("Copy as image").click_accesskit();
        h.step();
        assert_eq!(copied_image(&h), Some([800, 1100]));
        assert_eq!(h.state().notice.as_deref(), Some("Copied"));
        // The document page copies the Card as chosen there.
        h.get_all_by_label("Actions").last().unwrap().click();
        h.step();
        h.get_by_label("Card").click_accesskit();
        h.run();
        assert_eq!(h.state().modal(), Some(Modal::Document));
        h.get_by_label("Copy as image").click();
        h.step();
        assert_eq!(copied_image(&h), Some([800, 1100]));
    }

    #[test]
    fn the_viewer_copies_the_photo_full_size() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded(dir.path()));
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        h.get_by_label("Photos 2").click();
        h.run();
        assert!(h.state().viewer.open);
        let hash = h.state().viewer.hashes[h.state().viewer.index].clone();
        let bytes = h.state().store().image_bytes(&hash).unwrap();
        let expected = crate::textures::decode(&bytes).unwrap().size;
        h.get_by_label("Copy photo").click();
        h.step();
        assert_eq!(copied_image(&h), Some(expected));
    }

    #[test]
    fn the_history_copies_its_graph_as_a_picture() {
        let dir = tempfile::tempdir().unwrap();
        let mut h = harness(seeded_with(dir.path(), "history-reverts"));
        h.run();
        open_cat_page(&mut h, "cat:00000000-0000-4000-8000-000000000001");
        h.get_all_by_label_contains(" kg")
            .last()
            .unwrap()
            .click_secondary();
        h.step();
        h.get_by_label("History").click_accesskit();
        h.run();
        h.get_by_label("Smoothed").click();
        h.run();
        h.get_by_label("Copy graph as image").click();
        h.step();
        assert_eq!(
            copied_image(&h),
            Some([
                crate::graph_image::WIDTH as usize,
                crate::graph_image::HEIGHT as usize
            ])
        );
        assert_eq!(h.state().notice.as_deref(), Some("Copied"));
    }
}
