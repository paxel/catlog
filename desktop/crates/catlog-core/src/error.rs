use std::path::PathBuf;

/// Everything that can go wrong in the core, named so the GUI can tell
/// the keeper what failed and what to do.
#[derive(Debug, thiserror::Error)]
pub enum Error {
    #[error("database: {0}")]
    Sqlite(#[from] rusqlite::Error),
    #[error("file {path}: {source}")]
    Io {
        path: PathBuf,
        #[source]
        source: std::io::Error,
    },
    #[error("malformed JSON: {0}")]
    Json(#[from] serde_json::Error),
    #[error("bundle: {0}")]
    Zip(#[from] zip::result::ZipError),
    #[error("bundle format {0} is newer than this app reads")]
    UnsupportedBundleFormat(u32),
    #[error("bundle too large")]
    BundleTooLarge,
    #[error("photo bytes do not match their hash {0}")]
    HashMismatch(String),
    #[error("no author configured")]
    NoAuthor,
    #[error("{0}")]
    Invalid(String),
}

impl Error {
    pub(crate) fn io(path: impl Into<PathBuf>, source: std::io::Error) -> Self {
        Error::Io {
            path: path.into(),
            source,
        }
    }
}
