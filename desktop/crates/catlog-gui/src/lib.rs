//! The cat(a)log desktop app: an egui shell over `catlog_core`.
//!
//! The native window and the eframe glue live in the `catlog` binary;
//! everything that can be tested headless lives here so the kittest
//! harness can drive it.

pub mod app;
pub mod l10n;
pub mod settings;

pub use app::{App, DEFAULT_PANE_WIDTH, DEFAULT_WINDOW_SIZE, Request};
pub use settings::{AppSettings, SettingsFile, data_dir};
