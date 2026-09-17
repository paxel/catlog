//! The shared folder (ADR 0002): `catlog-sync/` with one entry file per
//! device, `keys/` with each device's key list, `blobs/` with the photos.
//! Every partner's file is imported read-only; photos the entries name
//! are fetched as far as the folder has them.

use std::path::{Path, PathBuf};

use sha2::{Digest, Sha256};

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::error::Error;

/// The outcome of one folder round, for the summary line.
#[derive(Debug, Default, Clone, PartialEq, Eq)]
pub struct FolderImport {
    pub entries_in: usize,
    pub blobs_in: usize,
    /// Photos the entries name that no device has put in the folder yet.
    pub blobs_missing: usize,
    /// One line per photo that could not be fetched this round and why.
    pub blob_problems: Vec<String>,
    /// The entries actually new to this store.
    pub applied: Vec<Entry>,
}

/// The subfolder the sync lives in under the folder a keeper picked.
pub const SYNC_DIR: &str = "catlog-sync";

impl Catalog {
    /// Imports every partner file under `folder/catlog-sync` (and, with
    /// `catalog`, under its subfolder too), then fetches missing photos.
    /// Writing this device's own file is the sync round's job.
    pub fn import_folder(&mut self, folder: &Path, catalog: Option<&str>) -> Result<FolderImport> {
        let root = folder.join(SYNC_DIR);
        let mut read_dirs: Vec<PathBuf> = Vec::new();
        if let Some(c) = catalog {
            read_dirs.push(root.join(c));
        }
        read_dirs.push(root.clone());
        let me = self.device_id();
        let mut result = FolderImport::default();
        for dir in &read_dirs {
            for name in list_files(dir)? {
                if !(name.ends_with(".jsonl") || name.ends_with(".jsonl2")) {
                    continue;
                }
                if name == format!("{me}.jsonl") || name == format!("{me}.jsonl2") {
                    continue;
                }
                let Ok(text) = std::fs::read_to_string(dir.join(&name)) else {
                    continue;
                };
                let Some(foreign) = parse_lines(&text) else {
                    continue;
                };
                let mine = self.version_vector()?;
                let fresh: Vec<Entry> = foreign
                    .into_iter()
                    .filter(|e| e.dseq > mine.get(&e.device).copied().unwrap_or(0))
                    .collect();
                let imported = self.apply_entries(fresh)?;
                result.entries_in += imported.len();
                result.applied.extend(imported);
            }
        }
        let blob_dir = match catalog {
            Some(c) => root.join(c).join("blobs"),
            None => root.join("blobs"),
        };
        let legacy = root.join("blobs");
        result.blobs_in =
            self.fetch_missing_blobs(&blob_dir, &legacy, &mut result.blob_problems)?;
        result.blobs_missing = self.missing_blobs()?.len();
        Ok(result)
    }

    /// Fetches the photos the entries name and this store lacks, as far
    /// as the folder has them. Returns how many came in.
    fn fetch_missing_blobs(
        &self,
        blob_dir: &Path,
        legacy: &Path,
        problems: &mut Vec<String>,
    ) -> Result<usize> {
        let missing = self.missing_blobs()?;
        if missing.is_empty() {
            return Ok(0);
        }
        let names = list_files(blob_dir)?;
        let legacy_names = if legacy == blob_dir {
            Vec::new()
        } else {
            list_files(legacy)?
        };
        let mut blobs_in = 0;
        for hash in missing {
            let short = &hash[..hash.len().min(8)];
            let file = format!("{hash}.jpg");
            let dir = if names.contains(&file) {
                blob_dir
            } else if legacy_names.contains(&file) {
                legacy
            } else {
                problems.push(format!(
                    "{short} not listed in {} ({} files)",
                    blob_dir.display(),
                    names.len()
                ));
                continue;
            };
            let bytes = match std::fs::read(dir.join(&file)) {
                Ok(b) => b,
                Err(e) => {
                    problems.push(format!("{short} {e}"));
                    continue;
                }
            };
            let actual = hex::encode(Sha256::digest(&bytes));
            if actual != hash {
                let head = hex::encode(&bytes[..bytes.len().min(4)]);
                problems.push(format!(
                    "{short} read {} bytes, sha {actual} head {head}",
                    bytes.len()
                ));
                continue;
            }
            self.put_blob(&hash, &bytes)?;
            if self.image_bytes(&hash).is_none() {
                problems.push(format!("{short} read {} bytes, not kept", bytes.len()));
                continue;
            }
            blobs_in += 1;
        }
        Ok(blobs_in)
    }
}

/// The file names directly in `dir`; an absent directory lists as empty.
fn list_files(dir: &Path) -> Result<Vec<String>> {
    let entries = match std::fs::read_dir(dir) {
        Ok(e) => e,
        Err(e) if e.kind() == std::io::ErrorKind::NotFound => return Ok(Vec::new()),
        Err(e) => return Err(Error::io(dir, e)),
    };
    let mut names = Vec::new();
    for entry in entries {
        let entry = entry.map_err(|e| Error::io(dir, e))?;
        if entry.file_type().map_err(|e| Error::io(dir, e))?.is_file() {
            names.push(entry.file_name().to_string_lossy().into_owned());
        }
    }
    names.sort();
    Ok(names)
}

/// Parses a device file: one entry per line. A damaged line means the
/// whole file is skipped for this round, as the phones do.
pub(crate) fn parse_lines(text: &str) -> Option<Vec<Entry>> {
    let mut out = Vec::new();
    for line in text.lines() {
        if line.trim().is_empty() {
            continue;
        }
        out.push(serde_json::from_str::<Entry>(line).ok()?);
    }
    Some(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_damaged_line_skips_the_file() {
        assert!(parse_lines("{\"device\":1}\n").is_none());
        assert_eq!(parse_lines("\n\n").unwrap().len(), 0);
    }

    #[test]
    fn an_absent_folder_imports_nothing_and_a_bad_photo_is_reported() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(&dir.path().join("cat")).unwrap();
        let r = c.import_folder(&dir.path().join("nowhere"), None).unwrap();
        assert_eq!(r, FolderImport::default());
        let hash = "b".repeat(64);
        let sync = dir.path().join("share").join(SYNC_DIR);
        std::fs::create_dir_all(sync.join("blobs")).unwrap();
        std::fs::write(sync.join("blobs").join(format!("{hash}.jpg")), b"wrong").unwrap();
        std::fs::write(
            sync.join("w.jsonl"),
            format!(
                r#"{{"device":"w","dseq":1,"entity":"cat:a","field":"$image:{hash}","value":"added","date":"2026-01-01T00:00:00Z","author":"A","recorded":"2026-01-01T00:00:00Z"}}"#
            ),
        )
        .unwrap();
        std::fs::write(sync.join("broken.jsonl"), "not json").unwrap();
        std::fs::write(sync.join(format!("{}.jsonl", c.device_id())), "own file").unwrap();
        let r = c.import_folder(&dir.path().join("share"), None).unwrap();
        assert_eq!(r.entries_in, 1);
        assert_eq!(r.blobs_in, 0);
        assert_eq!(r.blobs_missing, 1);
        assert_eq!(r.blob_problems.len(), 1);
        assert!(r.blob_problems[0].contains("sha"));
        // A catalog subfolder without photos of its own falls back to the
        // root's, where partners from before keep theirs.
        let r = c
            .import_folder(&dir.path().join("share"), Some("leipzig"))
            .unwrap();
        assert_eq!(r.entries_in, 0);
        assert!(r.blob_problems[0].contains("sha"));
        std::fs::remove_file(sync.join("blobs").join(format!("{hash}.jpg"))).unwrap();
        let r = c.import_folder(&dir.path().join("share"), None).unwrap();
        assert!(r.blob_problems[0].contains("not listed"));
    }
}
