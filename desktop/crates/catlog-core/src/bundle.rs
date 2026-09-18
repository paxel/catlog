//! Sync by messenger (ADR 0002 family): a `.catsync` zip carries the
//! sender's full knowledge, entries plus the photos in use. Format 2
//! keeps the entries in `entries2.jsonl` beside a `format` marker;
//! format 1 files, from before reminders, use `entries.jsonl`.

use std::collections::{BTreeMap, HashMap};
use std::io::{Read, Write};
use std::path::Path;

use zip::write::SimpleFileOptions;

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::error::Error;
use crate::folder::parse_lines;
use crate::signing::{ImportReport, KeyRecord, parse_keys};

/// The key list inside a bundle.
pub const KEYS_FILE: &str = "keys.json";

/// The bundle format this build writes and the highest it reads.
pub const BUNDLE_FORMAT: u32 = 2;

/// A photo larger than this is not one of ours and is skipped; an
/// entries file above its cap is refused before it is unpacked.
pub const MAX_BLOB_BYTES: u64 = 20 << 20;
pub const MAX_ENTRIES_BYTES: u64 = 64 << 20;

#[derive(Debug, Default, Clone, PartialEq, Eq)]
pub struct BundleResult {
    pub entries_in: usize,
    pub blobs_in: usize,
    pub applied: Vec<Entry>,
    /// Refused rows and the keys met.
    pub report: ImportReport,
    /// Fields with unresolved concurrent edits after this import.
    pub conflicts: Vec<(String, String)>,
}

impl BundleResult {
    /// The import as the fixture corpus records it.
    pub fn to_json(&self) -> serde_json::Value {
        serde_json::json!({
            "entriesIn": self.entries_in,
            "blobsIn": self.blobs_in,
            "conflicts": self.conflicts.iter().map(|(e, f)| vec![e.clone(), f.clone()]).collect::<Vec<_>>(),
        })
    }
}

impl Catalog {
    /// Writes the bundle zip: this Catalog's full knowledge plus the
    /// photos in use. Private values and the photos among them stay out
    /// unless `include_private`.
    pub fn write_bundle(&self, path: &Path, include_private: bool) -> Result<()> {
        let entries = self.entries_since(&BTreeMap::new(), include_private)?;
        let hashes = self.live_images(include_private)?;
        self.write_zip(path, &entries, &hashes)
    }

    /// Writes a bundle of exactly `entries` plus the photos they mention.
    /// Used by going back: the rows keep their original (device, dseq),
    /// so the file comes home exact.
    pub fn write_entries_bundle(&self, path: &Path, entries: &[Entry]) -> Result<()> {
        let mut seen = std::collections::HashSet::new();
        let hashes: Vec<String> = entries
            .iter()
            .filter_map(|e| e.field.strip_prefix(crate::keys::IMAGE_PREFIX))
            .filter(|h| seen.insert(h.to_string()))
            .map(String::from)
            .collect();
        self.write_zip(path, entries, &hashes)
    }

    fn write_zip(&self, path: &Path, entries: &[Entry], hashes: &[String]) -> Result<()> {
        let mut jsonl = String::new();
        for (i, e) in entries.iter().enumerate() {
            if i > 0 {
                jsonl.push('\n');
            }
            jsonl.push_str(&serde_json::to_string(&e.wire())?);
        }
        let flagged = entries.iter().any(|e| e.reminder);
        let file = std::fs::File::create(path).map_err(|e| Error::io(path, e))?;
        let mut zip = zip::ZipWriter::new(file);
        let deflated = SimpleFileOptions::default()
            .compression_method(zip::CompressionMethod::Deflated)
            .last_modified_time(zip::DateTime::default());
        let stored = SimpleFileOptions::default()
            .compression_method(zip::CompressionMethod::Stored)
            .last_modified_time(zip::DateTime::default());
        // A payload without a flagged entry is byte-identical to the
        // pre-1.0.0 format and ships under the old name.
        if flagged {
            zip.start_file("format", deflated)?;
            zip.write_all(BUNDLE_FORMAT.to_string().as_bytes())
                .map_err(|e| Error::io(path, e))?;
            zip.start_file("entries2.jsonl", deflated)?;
        } else {
            zip.start_file("entries.jsonl", deflated)?;
        }
        zip.write_all(jsonl.as_bytes())
            .map_err(|e| Error::io(path, e))?;
        // The keys the entries were signed with; a reader from before
        // ignores the file, as it ignores the signatures.
        zip.start_file(KEYS_FILE, deflated)?;
        zip.write_all(serde_json::to_string(&self.key_records()?)?.as_bytes())
            .map_err(|e| Error::io(path, e))?;
        for hash in hashes {
            let Some(bytes) = self.image_bytes(hash) else {
                continue;
            };
            zip.start_file(format!("blobs/{hash}.jpg"), stored)?;
            zip.write_all(&bytes).map_err(|e| Error::io(path, e))?;
        }
        zip.finish()?;
        Ok(())
    }

    /// Imports a bundle file; unknown entries and missing photos land,
    /// everything else is ignored.
    pub fn import_bundle(&mut self, path: &Path) -> Result<BundleResult> {
        let file = std::fs::File::open(path).map_err(|e| Error::io(path, e))?;
        let mut archive = zip::ZipArchive::new(file)?;
        let mut entries: Vec<Entry> = Vec::new();
        let mut keys: Vec<KeyRecord> = Vec::new();
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
            } else if name == KEYS_FILE {
                let mut text = String::new();
                f.read_to_string(&mut text)
                    .map_err(|e| Error::io(path, e))?;
                keys = parse_keys(&text);
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
        let mut report = ImportReport::default();
        let writer_vector = crate::folder::writer_vector(&entries);
        let applied =
            self.apply_entries_from(entries, &writer_vector, Some(&keys), None, &mut report)?;
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
        let conflicts = self.conflicts()?;
        Ok(BundleResult {
            entries_in: applied.len(),
            blobs_in,
            applied,
            report,
            conflicts,
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
    fn a_written_bundle_comes_back_whole_and_a_plan_forces_format_two() {
        let dir = tempfile::tempdir().unwrap();
        let mut a = Catalog::open_with_device(&dir.path().join("a"), "aaaa").unwrap();
        a.set_author("Ada").unwrap();
        let seeded = a.all_entries().unwrap().len();
        a.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        let photo = a.add_image("cat:m", b"jpeg bytes").unwrap();
        let path = dir.path().join("a.catsync");
        a.write_bundle(&path, false).unwrap();
        let names: Vec<String> = {
            let z = zip::ZipArchive::new(std::fs::File::open(&path).unwrap()).unwrap();
            z.file_names().map(String::from).collect()
        };
        assert!(names.contains(&"entries.jsonl".to_string()));
        assert!(names.contains(&KEYS_FILE.to_string()));
        assert!(!names.contains(&"format".to_string()));

        let mut b = Catalog::open_with_device(&dir.path().join("b"), "bbbb").unwrap();
        let r = b.import_bundle(&path).unwrap();
        assert_eq!((r.entries_in, r.blobs_in), (seeded + 4, 1));
        assert_eq!(r.report.new_keys[0].record.device, "aaaa");
        assert!(b.import_bundle(&path).unwrap().report.is_empty());
        assert_eq!(b.image_bytes(&photo).as_deref(), Some(&b"jpeg bytes"[..]));
        assert_eq!(b.import_bundle(&path).unwrap().entries_in, 0);

        a.append_at(
            "cat:m",
            "f:vet",
            Some("shots"),
            Some("2026-03-01T00:00:00Z"),
            true,
        )
        .unwrap();
        a.write_bundle(&path, false).unwrap();
        let names: Vec<String> = {
            let z = zip::ZipArchive::new(std::fs::File::open(&path).unwrap()).unwrap();
            z.file_names().map(String::from).collect()
        };
        assert!(names.contains(&"entries2.jsonl".to_string()));
        assert!(names.contains(&"format".to_string()));
        assert_eq!(b.import_bundle(&path).unwrap().entries_in, 1);
        assert!(
            a.write_bundle(&dir.path().join("nowhere").join("x.catsync"), false)
                .is_err()
        );
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
