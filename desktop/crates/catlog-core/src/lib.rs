//! Core of the cat(a)log desktop app.
//!
//! Holds the Catalog store and, ticket by ticket, the append-only entries,
//! signing, shared-folder sync and bundles that the phones speak. Nothing in
//! here knows about a window: the GUI crate draws, this crate owns the data.

/// The version the desktop app reports, taken from the crate.
pub const VERSION: &str = env!("CARGO_PKG_VERSION");

/// The name shown in the window title and in reports.
pub const APP_NAME: &str = "cat(a)log";

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_version_is_the_crate_version() {
        assert_eq!(VERSION, "2.0.0");
        assert_eq!(APP_NAME, "cat(a)log");
    }
}
