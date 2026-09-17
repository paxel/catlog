//! Sync by messenger (ADR 0002 family): a `.catsync` zip carries the
//! sender's full knowledge, entries plus the photos in use. Format 2
//! keeps the entries in `entries2.jsonl` beside a `format` marker;
//! format 1 files, from before reminders, use `entries.jsonl`.

use std::collections::HashMap;
use std::io::Read;
use std::path::Path;

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::error::Error;
use crate::folder::parse_lines;

/// The bundle format this build writes and the highest it reads.
pub const BUNDLE_FORMAT: u32 = 2;

/// A photo larger than this is not one of ours and is skipped; an
/// entries file above its cap is refused before it is unpacked.
const MAX_BLOB_BYTES: u64 = 20 << 20;
const MAX_ENTRIES_BYTES: u64 = 64 << 20;

#[derive(Debug, Default, Clone, PartialEq, Eq)]
pub struct BundleResult {
    pub entries_in: usize,
    pub blobs_in: usize,
    pub applied: Vec<Entry>,
}

impl Catalog {
    /// Imports a bundle file; unknown entries and missing photos land,
    /// everything else is ignored.
    pub fn import_bundle(&mut self, path: &Path) -> Result<BundleResult> {
        let file = std::fs::File::open(path).map_err(|e| Error::io(path, e))?;
        let mut archive = zip::ZipArchive::new(file)?;
        let mut entries: Vec<Entry> = Vec::new();
        let mut blobs: HashMap<String, usize> = HashMap::new();
        for i in 0..archive.len() {
            let mut f = archive.by_index(i)?;
            if f.is_dir() {
                continue;
            }
            let name = f.name().to_string();
            if name.starts_with("blobs/") {
                if f.size() > MAX_BLOB_BYTES {
                    continue;
                }
            } else if f.size() > MAX_ENTRIES_BYTES {
                return Err(Error::BundleTooLarge);
            }
            if name == "format" {
                let mut text = String::new();
                f.read_to_string(&mut text)
                    .map_err(|e| Error::io(path, e))?;
                if let Ok(declared) = text.trim().parse::<u32>()
                    && declared > BUNDLE_FORMAT
                {
                    return Err(Error::UnsupportedBundleFormat(declared));
                }
            } else if name == "entries2.jsonl" || name == "entries.jsonl" {
                let mut text = String::new();
                f.read_to_string(&mut text)
                    .map_err(|e| Error::io(path, e))?;
                entries.extend(parse_lines(&text).unwrap_or_default());
            } else if let Some(rest) = name.strip_prefix("blobs/")
                && let Some(hash) = rest.strip_suffix(".jpg")
            {
                blobs.insert(hash.to_string(), i);
            }
        }
        let applied = self.apply_entries(entries)?;
        let mut blobs_in = 0;
        for (hash, index) in blobs {
            if !self.knows_image(&hash)? || self.image_bytes(&hash).is_some() {
                continue;
            }
            let mut f = archive.by_index(index)?;
            let mut bytes = Vec::with_capacity(f.size() as usize);
            f.read_to_end(&mut bytes).map_err(|e| Error::io(path, e))?;
            if self.put_blob(&hash, &bytes).is_ok() && self.image_bytes(&hash).is_some() {
                blobs_in += 1;
            }
        }
        Ok(BundleResult {
            entries_in: applied.len(),
            blobs_in,
            applied,
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Write;
    use zip::write::SimpleFileOptions;

    fn bundle(dir: &Path, files: &[(&str, &[u8])]) -> std::path::PathBuf {
        let path = dir.join("b.catsync");
        let mut zip = zip::ZipWriter::new(std::fs::File::create(&path).unwrap());
        for (name, bytes) in files {
            zip.start_file(*name, SimpleFileOptions::default()).unwrap();
            zip.write_all(bytes).unwrap();
        }
        zip.finish().unwrap();
        path
    }

    #[test]
    fn a_newer_format_is_refused_and_an_unknown_photo_ignored() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(&dir.path().join("cat")).unwrap();
        let path = bundle(dir.path(), &[("format", b"3"), ("entries2.jsonl", b"")]);
        assert!(matches!(
            c.import_bundle(&path),
            Err(Error::UnsupportedBundleFormat(3))
        ));
        let path = bundle(
            dir.path(),
            &[
                ("format", b"2"),
                ("entries2.jsonl", br#"{"device":"w","dseq":1,"entity":"cat:a","field":"name","value":"M","date":"2026-01-01T00:00:00Z","author":"A","recorded":"2026-01-01T00:00:00Z","reminder":true}"#),
                ("blobs/ffff.jpg", b"stray"),
                ("blobs/", b""),
            ],
        );
        let r = c.import_bundle(&path).unwrap();
        assert_eq!(r.entries_in, 1);
        assert_eq!(r.blobs_in, 0);
        assert!(
            c.import_bundle(&dir.path().join("missing.catsync"))
                .is_err()
        );
    }
}
