//! The cat(a)log desktop app: an egui shell over `catlog_core`.
//!
//! The native window and the eframe glue live in the `catlog` binary;
//! everything that can be tested headless lives here so the kittest
//! harness can drive it.

pub mod agenda;
pub mod app;
pub mod appointments;
pub mod capture_page;
pub mod cards;
pub mod cats_table;
pub mod chores;
pub mod clowders_table;
pub mod codes;
pub mod conflicts;
pub mod crash;
pub mod dashboard;
pub mod dialogs;
pub mod documents_page;
pub mod duplicates_page;
pub mod editor;
pub mod history;
pub mod home;
pub mod housekeeping;
pub mod icon;
pub mod icons;
pub mod l10n;
pub mod labels;
pub mod map;
pub mod map_page;
pub mod merge;
pub mod motion;
pub mod move_dialog;
pub mod names;
pub mod new_field;
pub mod notify;
pub mod pages;
pub mod photos;
pub mod picker;
pub mod settings;
pub mod settings_page;
pub mod sounds;
pub mod summary;
pub mod sync_page;
pub mod textures;
pub mod theme;
pub mod tips;
pub mod vet;
pub mod views;

pub use app::{App, DEFAULT_PANE_WIDTH, DEFAULT_WINDOW_SIZE, Request, catalogs_root};
pub use home::Selection;
pub use settings::{AppSettings, SettingsFile, data_dir};
pub use views::{Modal, View};
