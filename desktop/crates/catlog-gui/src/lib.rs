//! The cat(a)log desktop app: an egui shell over `catlog_core`.
//!
//! The native window and the eframe glue live in the `catlog` binary;
//! everything that can be tested headless lives here so the kittest
//! harness can drive it.

pub mod app;
pub mod codes;
pub mod conflicts;
pub mod dialogs;
pub mod editor;
pub mod history;
pub mod home;
pub mod l10n;
pub mod labels;
pub mod map;
pub mod map_page;
pub mod move_dialog;
pub mod new_field;
pub mod pages;
pub mod photos;
pub mod picker;
pub mod settings;
pub mod summary;
pub mod sync_page;
pub mod textures;

pub use app::{App, DEFAULT_PANE_WIDTH, DEFAULT_WINDOW_SIZE, Request, catalogs_root};
pub use home::Selection;
pub use settings::{AppSettings, SettingsFile, data_dir};
