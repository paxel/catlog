//! Core of the cat(a)log desktop app.
//!
//! The Catalog is an append-only entry log over SQLite with a
//! latest-wins projection (ADR 0001). This crate reads and writes the
//! same shared-folder files and `.catsync` bundles as the phones, which
//! is the contract the fixture corpus under `desktop/fixtures/` pins
//! down. Nothing in here knows about a window: the GUI crate draws, this
//! crate owns the data.

mod bundle;
mod catalog;
pub mod corpus;
mod dump;
mod entry;
mod error;
mod folder;
pub mod keys;

pub use bundle::BundleResult;
pub use catalog::{Catalog, Clock, EntityView};
pub use entry::{Entry, dart_iso, iso};
pub use error::Error;
pub use folder::FolderImport;

/// The version the desktop app reports, taken from the crate.
pub const VERSION: &str = env!("CARGO_PKG_VERSION");

/// The name shown in the window title and in reports.
pub const APP_NAME: &str = "cat(a)log";

/// Author name stamped on entries the store seeds itself.
pub const SEED_AUTHOR: &str = "cat(a)log";

/// The result type of everything in this crate.
pub type Result<T> = std::result::Result<T, Error>;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_version_is_the_crate_version() {
        assert_eq!(VERSION, "2.0.0");
        assert_eq!(APP_NAME, "cat(a)log");
    }
}
