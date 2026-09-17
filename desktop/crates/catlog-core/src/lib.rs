//! Core of the cat(a)log desktop app.
//!
//! The Catalog is an append-only entry log over SQLite with a
//! latest-wins projection (ADR 0001). This crate reads and writes the
//! same shared-folder files and `.catsync` bundles as the phones, which
//! is the contract the fixture corpus under `desktop/fixtures/` pins
//! down. Nothing in here knows about a window: the GUI crate draws, this
//! crate owns the data.

pub mod agenda;
pub mod appointments;
pub mod archive;
pub mod backup;
mod bundle;
mod catalog;
pub mod catalogs;
pub mod chores;
pub mod corpus;
pub mod documents;
mod dump;
pub mod duplicates;
pub mod entities;
mod entry;
mod error;
pub mod fields;
pub mod flier;
mod folder;
pub mod fonts;
pub mod geo;
pub mod geocode;
pub mod graph;
pub mod ics;
pub mod keys;
pub mod looks;
pub mod moments;
pub mod partial_date;
pub mod pdf;
pub mod photo;
pub mod plus_code;
pub mod registry;
pub mod review;
pub mod share;
pub mod signing;
pub mod sync;
pub mod tiles;
pub mod units;

pub use appointments::{Appointment, AppointmentAlert};
pub use bundle::BundleResult;
pub use catalog::{Catalog, Clock, EntityView};
pub use catalogs::{CATALOG_NAME_KEY, CatalogInfo, CatalogManager};
pub use chores::{Chore, ChoreDay, ChoreRepeat, ChoreSchedule, ChoreUnit, Hhmm};
pub use entities::{
    ActiveReminder, ClowderEvent, Family, PositionKind, TransferResult, transfer_entities,
};
pub use entry::{Entry, dart_iso, iso};
pub use error::Error;
pub use fields::{FieldDef, FieldScope, FieldType, IdDisplay};
pub use folder::FolderImport;
pub use graph::{GraphPoint, Trend};
pub use moments::Moment;
pub use partial_date::PartialDate;
pub use signing::{ImportReport, KeyRecord, KeyTrust, PinnedKey, SigningKey};
pub use units::{Dimension, UnitSystem};

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
