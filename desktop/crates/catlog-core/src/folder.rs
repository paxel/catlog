//! The shared folder (ADR 0002): `catlog-sync/` with one entry file per
//! device, `keys/` with each device's key list, `blobs/` with the photos.
//! Every partner's file is imported read-only; photos the entries name
//! are fetched as far as the folder has them.

use std::collections::{BTreeMap, HashMap};
use std::path::{Path, PathBuf};

use sha2::{Digest, Sha256};

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::error::Error;
use crate::signing::{ImportReport, KeyRecord, parse_keys};

/// The outcome of one folder round, for the summary line.
#[derive(Debug, Default, Clone, PartialEq, Eq)]
pub struct FolderImport {
    pub entries_in: usize,
    pub entries_out: usize,
    pub blobs_in: usize,
    pub blobs_out: usize,
    /// Photos the entries name that no device has put in the folder yet.
    pub blobs_missing: usize,
    /// One line per photo that could not be fetched this round and why.
    pub blob_problems: Vec<String>,
    /// The entries actually new to this store.
    pub applied: Vec<Entry>,
    /// Refused rows and the keys met.
    pub report: ImportReport,
}

impl FolderImport {
    /// The round as the fixture corpus records it.
    pub fn to_json(&self) -> serde_json::Value {
        serde_json::json!({
            "entriesIn": self.entries_in,
            "blobsIn": self.blobs_in,
            "blobsMissing": self.blobs_missing,
            "blobProblems": self.blob_problems,
        })
    }
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
        // Keys first: every device publishes the keys it holds under
        // `keys/<deviceId>.json`; what the others published is learned
        // before their entries are judged.
        let mut foreign_keys: Vec<KeyRecord> = Vec::new();
        for dir in &read_dirs {
            let key_dir = dir.join("keys");
            for name in list_files(&key_dir)? {
                if !name.ends_with(".json") || name == format!("{me}.json") {
                    continue;
                }
                if let Ok(text) = std::fs::read_to_string(key_dir.join(&name)) {
                    foreign_keys.extend(parse_keys(&text));
                }
            }
        }
        self.learn_keys(&foreign_keys, None, &mut result.report, &HashMap::new())?;
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
                // A value this device only ever received as withheld sits
                // below the watermark for good; without this it could never
                // arrive, however often the writer shares with private
                // included.
                let any_withheld = self.has_withheld()?;
                let mut withheld: HashMap<(String, String), bool> = HashMap::new();
                let mut fresh: Vec<Entry> = Vec::new();
                for e in foreign {
                    let unseen = e.dseq > mine.get(&e.device).copied().unwrap_or(0);
                    let held_back = any_withheld && {
                        let key = (e.entity.clone(), e.field.clone());
                        match withheld.get(&key) {
                            Some(w) => *w,
                            None => {
                                let w = self.is_withheld(&e.entity, &e.field)?;
                                withheld.insert(key, w);
                                w
                            }
                        }
                    };
                    if unseen || held_back {
                        fresh.push(e);
                    }
                }
                let imported = self.apply_entries_with(fresh, None, None, &mut result.report)?;
                result.entries_in += imported.len();
                result.applied.extend(imported);
            }
        }
        let blob_name = match catalog {
            Some(c) => format!("{c}/blobs"),
            None => "blobs".to_string(),
        };
        let blob_dir = root.join(&blob_name);
        let legacy = root.join("blobs");
        result.blobs_in =
            self.fetch_missing_blobs(&blob_dir, &blob_name, &legacy, &mut result.blob_problems)?;
        result.blob_problems.sort();
        result.blobs_missing = self.missing_blobs()?.len();
        Ok(result)
    }

    /// One full round through a shared folder: partners' files in, this
    /// device's file with its full knowledge out, photos both ways.
    /// Private values stay home unless `include_private`. With `catalog`
    /// the files live in `catlog-sync/<catalog>/`; the root is still
    /// read, for partners from before.
    pub fn sync_folder(
        &mut self,
        folder: &Path,
        catalog: Option<&str>,
        include_private: bool,
    ) -> Result<FolderImport> {
        let root = folder.join(SYNC_DIR);
        let own_root = match catalog {
            Some(c) => root.join(c),
            None => root.clone(),
        };
        for dir in [&own_root, &own_root.join("blobs"), &own_root.join("keys")] {
            std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
        }
        // Android's media scanner must not show the photos in the phone's
        // gallery; every other system ignores the file.
        let nomedia = root.join(".nomedia");
        if !nomedia.exists() {
            write_atomically(&nomedia, &[])?;
        }
        let mut result = self.import_folder(folder, catalog)?;

        // Own keys, rewritten only when they changed.
        let me = self.device_id();
        let own_keys = serde_json::to_string(&self.key_records()?)?;
        let keys_path = own_root.join("keys").join(format!("{me}.json"));
        if std::fs::read_to_string(&keys_path).ok().as_deref() != Some(&own_keys) {
            write_atomically(&keys_path, own_keys.as_bytes())?;
        }

        // Own file: full knowledge. Without a flagged entry the payload is
        // byte-identical to the old format and keeps the `.jsonl` name.
        let all = self.entries_since(&BTreeMap::new(), include_private)?;
        let flagged = all.iter().any(|e| e.reminder);
        let own_name = format!("{me}.jsonl{}", if flagged { "2" } else { "" });
        let stale_name = format!("{me}.jsonl{}", if flagged { "" } else { "2" });
        let previous_lines = std::fs::read_to_string(own_root.join(&own_name))
            .map(|t| t.lines().count())
            .unwrap_or(0);
        let mut text = String::new();
        for (i, e) in all.iter().enumerate() {
            if i > 0 {
                text.push('\n');
            }
            text.push_str(&serde_json::to_string(&e.wire())?);
        }
        write_atomically(&own_root.join(&own_name), text.as_bytes())?;
        remove_if_present(&own_root.join(&stale_name))?;
        if catalog.is_some() {
            remove_if_present(&root.join(&own_name))?;
            remove_if_present(&root.join(&stale_name))?;
        }
        result.entries_out = all.len().saturating_sub(previous_lines);

        // Photos: publish the ones in use, drop the ones every device
        // knows as deleted.
        let blob_dir = own_root.join("blobs");
        let names = list_files(&blob_dir)?;
        let live = self.live_images(include_private)?;
        for hash in &live {
            let file = format!("{hash}.jpg");
            if names.contains(&file) {
                continue;
            }
            if let Some(bytes) = self.image_bytes(hash) {
                write_atomically(&blob_dir.join(&file), &bytes)?;
                result.blobs_out += 1;
            }
        }
        for name in names {
            let Some(hash) = name.strip_suffix(".jpg") else {
                continue;
            };
            if !live.iter().any(|h| h == hash) && self.known_deleted(hash)? {
                remove_if_present(&blob_dir.join(&name))?;
            }
        }
        result.blobs_missing = self.missing_blobs()?.len();
        Ok(result)
    }

    /// Fetches the photos the entries name and this store lacks, as far
    /// as the folder has them. Returns how many came in.
    fn fetch_missing_blobs(
        &self,
        blob_dir: &Path,
        blob_name: &str,
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
                    "{short} not listed in {blob_name} ({} files)",
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
            if crate::photo::image_too_large(&bytes) {
                problems.push(format!("{short} too large ({} bytes)", bytes.len()));
                continue;
            }
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

/// Writes via a temporary file and a rename: a cloud client must never
/// upload half a file as the whole.
fn write_atomically(path: &Path, bytes: &[u8]) -> Result<()> {
    let tmp = path.with_extension(match path.extension() {
        Some(ext) => format!("{}.tmp", ext.to_string_lossy()),
        None => "tmp".to_string(),
    });
    std::fs::write(&tmp, bytes).map_err(|e| Error::io(&tmp, e))?;
    std::fs::rename(&tmp, path).map_err(|e| Error::io(path, e))
}

fn remove_if_present(path: &Path) -> Result<()> {
    match std::fs::remove_file(path) {
        Ok(()) => Ok(()),
        Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(()),
        Err(e) => Err(Error::io(path, e)),
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
    fn a_round_publishes_own_rows_and_photos_and_two_catalogs_converge() {
        let dir = tempfile::tempdir().unwrap();
        let share = dir.path().join("share");
        let mut a = Catalog::open_with_device(&dir.path().join("a"), "aaaa").unwrap();
        a.set_author("Ada").unwrap();
        let seeded = a.all_entries().unwrap().len();
        a.create_clowder("clowder:h", "Home").unwrap();
        a.create_cat("cat:m", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        let photo = a.add_image("cat:m", b"jpeg bytes").unwrap();
        let r = a.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!(
            (r.entries_out, r.blobs_out, r.entries_in),
            (seeded + 7, 1, 0)
        );
        let sync = share.join(SYNC_DIR);
        assert!(sync.join(".nomedia").exists());
        assert!(sync.join("leipzig").join("aaaa.jsonl").exists());
        assert!(sync.join("leipzig").join("keys").join("aaaa.json").exists());
        assert!(
            sync.join("leipzig")
                .join("blobs")
                .join(format!("{photo}.jpg"))
                .exists()
        );

        let mut b = Catalog::open_with_device(&dir.path().join("b"), "bbbb").unwrap();
        b.set_author("Bea").unwrap();
        b.create_cat("cat:w", "Wanderer", None, "cat").unwrap();
        let r = b.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!(
            (r.entries_in, r.blobs_in, r.entries_out),
            (seeded + 7, 1, 2 * seeded + 10)
        );
        assert_eq!(r.report.new_keys[0].record.device, "aaaa");
        assert!(b.pinned_key("aaaa").is_some());
        assert_eq!(b.cats(None).unwrap().len(), 2);
        assert_eq!(b.image_bytes(&photo).as_deref(), Some(&b"jpeg bytes"[..]));

        // A second round of a changes nothing but takes b's cat; a plan
        // moves the file to the flagged name and the old one goes.
        a.append_at(
            "cat:m",
            "f:vet",
            Some("shots"),
            Some("2026-03-01T00:00:00Z"),
            true,
        )
        .unwrap();
        let r = a.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!((r.entries_in, r.entries_out), (seeded + 3, 2 * seeded + 11));
        assert_eq!(r.report.new_keys[0].record.device, "bbbb");
        // A forged line in b's file is refused by a now that b's key is pinned.
        let own = sync.join("leipzig").join("bbbb.jsonl");
        let mut lines: Vec<String> = std::fs::read_to_string(&own)
            .unwrap()
            .lines()
            .map(String::from)
            .collect();
        let last: serde_json::Value = serde_json::from_str(lines.last().unwrap()).unwrap();
        let mut forged = last.clone();
        forged["dseq"] = serde_json::json!(last["dseq"].as_i64().unwrap() + 1);
        forged["value"] = serde_json::json!("x");
        lines.push(forged.to_string());
        std::fs::write(&own, lines.join("\n")).unwrap();
        let r = a.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!(r.entries_in, 0);
        assert_eq!(
            r.report.refused[&("Bea".to_string(), "bbbb".to_string())],
            1
        );
        assert!(sync.join("leipzig").join("aaaa.jsonl2").exists());
        assert!(!sync.join("leipzig").join("aaaa.jsonl").exists());
        assert_eq!(a.cats(None).unwrap().len(), 2);

        // A deleted photo leaves the folder once its deletion is known.
        a.delete_image("cat:m", &photo).unwrap();
        a.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert!(
            !sync
                .join("leipzig")
                .join("blobs")
                .join(format!("{photo}.jpg"))
                .exists()
        );
        let r = b.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert!(b.images("cat:m").unwrap().is_empty());
        assert_eq!(r.blobs_missing, 0);
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
