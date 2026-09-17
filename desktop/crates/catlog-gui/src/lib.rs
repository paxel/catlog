//! The cat(a)log desktop app: an egui shell over `catlog_core`.
//!
//! The native window and the eframe glue live in the `catlog` binary;
//! everything that can be tested headless lives here so the kittest
//! harness can drive it.

pub mod app;
pub mod dialogs;
pub mod home;
pub mod l10n;
pub mod labels;
pub mod pages;
pub mod settings;
pub mod textures;

pub use app::{App, DEFAULT_PANE_WIDTH, DEFAULT_WINDOW_SIZE, Request, catalogs_root};
pub use home::Selection;
pub use settings::{AppSettings, SettingsFile, data_dir};
