//! The shared folder (ADR 0002): `catlog-sync/` with each device's
//! history in numbered segments beside a manifest (ADR 0010), `keys/`
//! with each device's key list, `blobs/` with the photos. Every
//! partner's files are imported read-only, from where this store left
//! off; photos the entries name are fetched as far as the folder has
//! them. A device from before writes one whole-history file; it is read
//! whole, as it always was.

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
    /// The entries actually new to this store.
    pub applied: Vec<Entry>,
    /// Devices still writing the whole-history file and no manifest:
    /// their app needs the update before they see this device's segments.
    pub lagging: Vec<String>,
    /// Refused rows and the keys met.
    pub report: ImportReport,
    /// Fields with unresolved concurrent edits after this round.
    pub conflicts: Vec<(String, String)>,
}

/// The vector a writer's file states: the highest number per device in it.
pub(crate) fn writer_vector(entries: &[Entry]) -> HashMap<String, i64> {
    let mut vector: HashMap<String, i64> = HashMap::new();
    for e in entries {
        let slot = vector.entry(e.device.clone()).or_insert(0);
        if e.dseq > *slot {
            *slot = e.dseq;
        }
    }
    vector
}

impl FolderImport {
    /// The round as the fixture corpus records it.
    pub fn to_json(&self) -> serde_json::Value {
        serde_json::json!({
            "entriesIn": self.entries_in,
            "blobsIn": self.blobs_in,
            "blobsMissing": self.blobs_missing,
            "conflicts": self.conflicts.iter().map(|(e, f)| vec![e.clone(), f.clone()]).collect::<Vec<_>>(),
        })
    }
}

/// The subfolder the sync lives in under the folder a keeper picked.
pub const SYNC_DIR: &str = "catlog-sync";

/// A segment past this many bytes is closed; the next change opens the
/// next one (ADR 0010).
pub const SEGMENT_CAP: usize = 64 * 1024;

/// The manifest's format; a reader leaves a higher one alone.
pub const MANIFEST_FORMAT: i64 = 1;

pub fn manifest_name(device: &str) -> String {
    format!("{device}.manifest")
}

pub fn segment_name(device: &str, n: usize) -> String {
    format!("{device}.{n}.seg")
}

/// What a device says about its segments: its full version vector, the
/// segments in order with the line count each held, and the generation
/// that moves on when the history shrank and the segments were rewritten.
#[derive(Debug, Clone, PartialEq, Eq, serde::Serialize, serde::Deserialize)]
pub struct Manifest {
    pub format: i64,
    /// Moves on whenever the segments were rewritten from the start.
    pub generation: i64,
    /// The writer's own count of history shrinks.
    #[serde(default)]
    pub history: i64,
    pub private: bool,
    pub vector: BTreeMap<String, i64>,
    pub segments: Vec<Segment>,
}

#[derive(Debug, Clone, PartialEq, Eq, serde::Serialize, serde::Deserialize)]
pub struct Segment {
    pub name: String,
    pub lines: usize,
}

impl Manifest {
    /// The manifest as a file says it, or none when it is half-written or
    /// of a format this core does not read.
    pub fn parse(text: &str) -> Option<Manifest> {
        let m: Manifest = serde_json::from_str(text).ok()?;
        (m.format <= MANIFEST_FORMAT).then_some(m)
    }

    pub fn lines(&self) -> usize {
        self.segments.iter().map(|s| s.lines).sum()
    }

    /// `<generation>:<lines>`, what the watch compares between rounds.
    pub fn state(&self) -> String {
        format!("{}:{}", self.generation, self.lines())
    }
}

/// The device ids a directory holds files for, from any of the names a
/// device writes: segments, manifest, the whole-history file.
fn devices_in<'a>(
    names: impl IntoIterator<Item = &'a String>,
) -> std::collections::BTreeSet<String> {
    let mut out = std::collections::BTreeSet::new();
    for name in names {
        if let Some(d) = name.strip_suffix(".manifest") {
            out.insert(d.to_string());
        } else if let Some(d) = name.strip_suffix(".jsonl2") {
            out.insert(d.to_string());
        } else if let Some(d) = name.strip_suffix(".jsonl") {
            out.insert(d.to_string());
        } else if name.ends_with(".seg")
            && let Some(dot) = name.find('.')
            && dot > 0
        {
            out.insert(name[..dot].to_string());
        }
    }
    out
}

/// What this store remembers of a writer's segments: the generation it
/// read and how many lines of each segment it took. A local setting per
/// catalog directory, never synced.
#[derive(Debug, Default, Clone, serde::Serialize, serde::Deserialize)]
struct ReadState {
    generation: i64,
    lines: BTreeMap<String, usize>,
}

fn read_state_key(dir: &str, device: &str) -> String {
    format!("folderRead:{dir}/{device}")
}

impl Catalog {
    fn read_state(&self, dir: &str, device: &str) -> ReadState {
        self.local_setting(&read_state_key(dir, device))
            .and_then(|raw| serde_json::from_str(&raw).ok())
            .unwrap_or(ReadState {
                generation: -1,
                lines: BTreeMap::new(),
            })
    }

    fn save_read_state(&self, dir: &str, device: &str, manifest: &Manifest) -> Result<()> {
        let state = ReadState {
            generation: manifest.generation,
            lines: manifest
                .segments
                .iter()
                .map(|s| (s.name.clone(), s.lines))
                .collect(),
        };
        self.set_local_setting(
            &read_state_key(dir, device),
            &serde_json::to_string(&state)?,
        )
    }

    /// The lines of a writer's segments this store has not read yet, by
    /// the manifest and the remembered state — or none when a segment the
    /// manifest names is not there yet or shorter than announced: the
    /// cloud client is still delivering, the whole device waits a round.
    pub fn unread_lines(
        &self,
        path: &Path,
        dir: &str,
        device: &str,
        manifest: &Manifest,
    ) -> Option<Vec<String>> {
        let mut state = self.read_state(dir, device);
        if state.generation != manifest.generation {
            state = ReadState {
                generation: manifest.generation,
                lines: BTreeMap::new(),
            };
        }
        let mut fresh = Vec::new();
        for segment in &manifest.segments {
            let have = state.lines.get(&segment.name).copied().unwrap_or(0);
            if segment.lines <= have {
                continue;
            }
            let text = std::fs::read_to_string(path.join(&segment.name)).ok()?;
            let lines: Vec<&str> = text.lines().collect();
            if lines.len() < segment.lines {
                return None;
            }
            fresh.extend(lines[have..segment.lines].iter().map(|l| l.to_string()));
        }
        Some(fresh)
    }
}

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
        let read_dir_names: Vec<String> = match catalog {
            Some(c) => vec![c.to_string(), String::new()],
            None => vec![String::new()],
        };
        for (dir, dir_name) in read_dirs.iter().zip(read_dir_names.iter()) {
            let names = list_files(dir)?;
            let mut with_manifest: std::collections::BTreeSet<String> =
                std::collections::BTreeSet::new();
            for name in &names {
                let Some(device) = name.strip_suffix(".manifest") else {
                    continue;
                };
                if device == me {
                    continue;
                }
                let Ok(text) = std::fs::read_to_string(dir.join(name)) else {
                    continue;
                };
                let Some(manifest) = Manifest::parse(&text) else {
                    continue; // half-written, or a newer format
                };
                with_manifest.insert(device.to_string());
                let Some(lines) = self.unread_lines(dir, dir_name, device, &manifest) else {
                    continue; // still on its way: next round
                };
                let Some(foreign) = parse_lines(&lines.join("\n")) else {
                    continue; // a damaged segment: skipped this round
                };
                // The manifest's vector is the writer's knowledge — the
                // causal context for conflict detection, whatever a single
                // segment holds.
                let vector: HashMap<String, i64> = manifest.vector.clone().into_iter().collect();
                self.apply_foreign(foreign, &vector, &mut result)?;
                self.save_read_state(dir_name, device, &manifest)?;
            }
            // Devices from before the segments still write one file with
            // all they know: `.jsonl2` carries the reminder flag, plain
            // `.jsonl` is what pre-1.0.0 devices write. Read whole.
            for name in &names {
                if !(name.ends_with(".jsonl") || name.ends_with(".jsonl2")) {
                    continue;
                }
                let device = &name[..name.rfind('.').unwrap_or(name.len())];
                if device == me || with_manifest.contains(device) {
                    continue;
                }
                if !result.lagging.iter().any(|d| d == device) {
                    result.lagging.push(device.to_string());
                }
                let Ok(text) = std::fs::read_to_string(dir.join(name)) else {
                    continue;
                };
                let Some(foreign) = parse_lines(&text) else {
                    continue;
                };
                // The writer's knowledge is exactly what its file contains.
                let vector = writer_vector(&foreign);
                self.apply_foreign(foreign, &vector, &mut result)?;
            }
        }
        let blob_name = match catalog {
            Some(c) => format!("{c}/blobs"),
            None => "blobs".to_string(),
        };
        let blob_dir = root.join(&blob_name);
        let legacy = root.join("blobs");
        result.blobs_in = self.fetch_missing_blobs(&blob_dir, &legacy)?;
        result.blobs_missing = self.missing_blobs()?.len();
        result.conflicts = self.conflicts()?;
        Ok(result)
    }

    /// Applies what this store has not seen of a writer's entries, with
    /// the writer's vector as the causal context.
    fn apply_foreign(
        &mut self,
        foreign: Vec<Entry>,
        writer_vector: &HashMap<String, i64>,
        result: &mut FolderImport,
    ) -> Result<()> {
        let mine = self.version_vector()?;
        // A value this device only ever received as withheld sits below
        // the watermark for good; without this it could never arrive,
        // however often the writer shares with private included.
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
        let imported =
            self.apply_entries_from(fresh, writer_vector, None, None, &mut result.report)?;
        result.entries_in += imported.len();
        result.applied.extend(imported);
        Ok(())
    }

    /// Writes this device's changes to the folder (ADR 0010): what is new
    /// since the manifest goes to the last segment, or to a fresh one
    /// once the last passed [`SEGMENT_CAP`]; the manifest follows. The
    /// segments are rewritten from the start only when the history shrank
    /// or the private switch changed — then the generation moves on.
    /// Returns how many entries went out.
    ///
    /// The whole-history file of before stays frozen beside the segments
    /// until every other device in the folder has a manifest, so a phone
    /// not yet updated keeps what it had; then it goes.
    pub fn publish_own(
        &self,
        folder: &Path,
        catalog: Option<&str>,
        include_private: bool,
    ) -> Result<usize> {
        let root = folder.join(SYNC_DIR);
        let own_root = match catalog {
            Some(c) => root.join(c),
            None => root.clone(),
        };
        std::fs::create_dir_all(&own_root).map_err(|e| Error::io(&own_root, e))?;
        let me = self.device_id();
        let names = list_files(&own_root)?;
        let previous = std::fs::read_to_string(own_root.join(manifest_name(&me)))
            .ok()
            .and_then(|t| Manifest::parse(&t));
        let history = self.history_generation();
        let write_manifest = |generation: i64, segments: Vec<Segment>| -> Result<()> {
            let manifest = Manifest {
                format: MANIFEST_FORMAT,
                generation,
                history,
                private: include_private,
                vector: self.version_vector()?,
                segments,
            };
            write_atomically(
                &own_root.join(manifest_name(&me)),
                serde_json::to_string(&manifest)?.as_bytes(),
            )
        };
        let line_of = |e: &Entry| serde_json::to_string(&e.wire());
        let mut out = 0;
        let rewrite = match &previous {
            None => true,
            Some(p) => {
                p.format != MANIFEST_FORMAT || p.private != include_private || p.history != history
            }
        };
        if rewrite {
            // From the start: every segment of before goes, the history is
            // cut into fresh ones.
            for name in &names {
                if name.starts_with(&format!("{me}.")) && name.ends_with(".seg") {
                    remove_if_present(&own_root.join(name))?;
                }
            }
            let all = self.entries_since(&BTreeMap::new(), include_private)?;
            let mut segments = Vec::new();
            let mut buffer: Vec<String> = Vec::new();
            let mut size = 0usize;
            let flush = |buffer: &mut Vec<String>, segments: &mut Vec<Segment>| -> Result<()> {
                if buffer.is_empty() {
                    return Ok(());
                }
                let name = segment_name(&me, segments.len() + 1);
                write_atomically(&own_root.join(&name), buffer.join("\n").as_bytes())?;
                segments.push(Segment {
                    name,
                    lines: buffer.len(),
                });
                buffer.clear();
                Ok(())
            };
            for e in &all {
                let line = line_of(e)?;
                size += line.len() + 1;
                buffer.push(line);
                if size >= SEGMENT_CAP {
                    flush(&mut buffer, &mut segments)?;
                    size = 0;
                }
            }
            flush(&mut buffer, &mut segments)?;
            let generation = previous.as_ref().map(|p| p.generation).unwrap_or(0) + 1;
            write_manifest(generation, segments)?;
            out = all.len();
        } else if let Some(previous) = &previous {
            // Only what the manifest does not know yet. Private rows below
            // the vector went out already: the private switch is unchanged.
            let fresh: Vec<Entry> = self
                .entries_since(&previous.vector, include_private)?
                .into_iter()
                .filter(|e| e.dseq > previous.vector.get(&e.device).copied().unwrap_or(0))
                .collect();
            if !fresh.is_empty() {
                let mut segments = previous.segments.clone();
                let lines: Vec<String> = fresh
                    .iter()
                    .map(line_of)
                    .collect::<std::result::Result<_, _>>()?;
                let tail = segments.last().and_then(|last| {
                    let text = std::fs::read_to_string(own_root.join(&last.name)).ok()?;
                    (text.len() < SEGMENT_CAP).then_some((last.name.clone(), text))
                });
                match tail {
                    Some((name, text)) => {
                        // The segment is read back rather than appended to:
                        // a segment is small by design, and the phones do
                        // the same through a folder that knows no append.
                        let mut held: Vec<String> = text.lines().map(String::from).collect();
                        let count = held.len() + lines.len();
                        held.extend(lines);
                        write_atomically(&own_root.join(&name), held.join("\n").as_bytes())?;
                        if let Some(last) = segments.last_mut() {
                            last.lines = count;
                        }
                    }
                    None => {
                        let name = segment_name(&me, segments.len() + 1);
                        write_atomically(&own_root.join(&name), lines.join("\n").as_bytes())?;
                        segments.push(Segment {
                            name,
                            lines: lines.len(),
                        });
                    }
                }
                write_manifest(previous.generation, segments)?;
                out = fresh.len();
            }
        }

        // The frozen whole-history file: gone once nobody needs it.
        let mut others = devices_in(names.iter());
        for name in list_files(&own_root.join("keys"))? {
            if let Some(d) = name.strip_suffix(".json") {
                others.insert(d.to_string());
            }
        }
        others.remove(&me);
        let manifests: std::collections::BTreeSet<String> = names
            .iter()
            .filter_map(|n| n.strip_suffix(".manifest").map(String::from))
            .collect();
        if others.iter().all(|d| manifests.contains(d)) {
            remove_if_present(&own_root.join(format!("{me}.jsonl")))?;
            remove_if_present(&own_root.join(format!("{me}.jsonl2")))?;
        }
        // A catalog that moved into its subfolder leaves no stale root file.
        if catalog.is_some() {
            remove_if_present(&root.join(format!("{me}.jsonl")))?;
            remove_if_present(&root.join(format!("{me}.jsonl2")))?;
        }
        Ok(out)
    }

    /// One full round through a shared folder: partners' files in, this
    /// device's own changes out, photos both ways.
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

        // Own changes: segments and manifest (ADR 0010).
        result.entries_out = self.publish_own(folder, catalog, include_private)?;

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

    /// Fetches the photos the entries name and this store lacks from a
    /// shared folder, on its own: a cloud client copies photo files after
    /// the entries. Returns how many came in.
    pub fn fetch_folder_blobs(&self, folder: &Path, catalog: Option<&str>) -> Result<usize> {
        let root = folder.join(SYNC_DIR);
        let blob_name = match catalog {
            Some(c) => format!("{c}/blobs"),
            None => "blobs".to_string(),
        };
        self.fetch_missing_blobs(&root.join(&blob_name), &root.join("blobs"))
    }

    /// Fetches the photos the entries name and this store lacks, as far
    /// as the folder has them. A file that is not the photo it is named
    /// after is left alone: the writer's next round may replace it.
    /// Returns how many came in.
    fn fetch_missing_blobs(&self, blob_dir: &Path, legacy: &Path) -> Result<usize> {
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
            let file = format!("{hash}.jpg");
            let dir = if names.contains(&file) {
                blob_dir
            } else if legacy_names.contains(&file) {
                legacy
            } else {
                continue;
            };
            let Ok(bytes) = std::fs::read(dir.join(&file)) else {
                continue;
            };
            if crate::photo::image_too_large(&bytes) {
                continue;
            }
            if hex::encode(Sha256::digest(&bytes)) != hash {
                continue;
            }
            self.put_blob(&hash, &bytes)?;
            if self.image_bytes(&hash).is_none() {
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
        assert!(sync.join("leipzig").join("aaaa.manifest").exists());
        assert!(sync.join("leipzig").join("aaaa.1.seg").exists());
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

        // A second round of a takes b's cat and appends only what the
        // manifest did not know: b's rows and a's new plan.
        let segment = sync.join("leipzig").join("aaaa.1.seg");
        let lines_before = std::fs::read_to_string(&segment).unwrap().lines().count();
        a.append_at(
            "cat:m",
            "f:vet",
            Some("shots"),
            Some("2026-03-01T00:00:00Z"),
            true,
        )
        .unwrap();
        let r = a.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!((r.entries_in, r.entries_out), (seeded + 3, seeded + 4));
        assert_eq!(r.report.new_keys[0].record.device, "bbbb");
        let text = std::fs::read_to_string(&segment).unwrap();
        assert_eq!(text.lines().count(), lines_before + seeded + 4);
        let manifest = Manifest::parse(
            &std::fs::read_to_string(sync.join("leipzig").join("aaaa.manifest")).unwrap(),
        )
        .unwrap();
        assert_eq!(manifest.segments[0].lines, lines_before + seeded + 4);
        assert_eq!(manifest.generation, 1);
        // A forged line in b's segment, announced by its manifest, is
        // refused by a now that b's key is pinned.
        let own = sync.join("leipzig").join("bbbb.1.seg");
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
        let manifest_path = sync.join("leipzig").join("bbbb.manifest");
        let mut forged_manifest =
            Manifest::parse(&std::fs::read_to_string(&manifest_path).unwrap()).unwrap();
        forged_manifest.segments[0].lines = lines.len();
        std::fs::write(
            &manifest_path,
            serde_json::to_string(&forged_manifest).unwrap(),
        )
        .unwrap();
        let r = a.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!(r.entries_in, 0);
        assert_eq!(
            r.report.refused[&("Bea".to_string(), "bbbb".to_string())],
            1
        );
        assert!(!sync.join("leipzig").join("aaaa.jsonl2").exists());
        assert!(!sync.join("leipzig").join("aaaa.jsonl").exists());
        assert_eq!(a.cats(None).unwrap().len(), 2);
        // Going back on a shrinks its history: the segments are rewritten
        // under the next generation, and b reads them afresh.
        let mark = a.current_seq().unwrap();
        a.append("cat:m", "f:color", Some("grey")).unwrap();
        a.sync_folder(&share, Some("leipzig"), false).unwrap();
        b.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!(
            b.current("cat:m", "f:color").unwrap().as_deref(),
            Some("grey")
        );
        a.remove_entries_after(mark).unwrap();
        a.sync_folder(&share, Some("leipzig"), false).unwrap();
        let manifest = Manifest::parse(
            &std::fs::read_to_string(sync.join("leipzig").join("aaaa.manifest")).unwrap(),
        )
        .unwrap();
        assert_eq!(manifest.generation, 2);
        let r = b.sync_folder(&share, Some("leipzig"), false).unwrap();
        assert_eq!(r.entries_in, 0);

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
        assert_eq!(r.lagging, vec!["broken".to_string(), "w".to_string()]);
        // A catalog subfolder without photos of its own falls back to the
        // root's, where partners from before keep theirs; the wrong bytes
        // are left alone there too.
        let r = c
            .import_folder(&dir.path().join("share"), Some("leipzig"))
            .unwrap();
        assert_eq!(r.entries_in, 0);
        assert_eq!(r.blobs_missing, 1);
        std::fs::remove_file(sync.join("blobs").join(format!("{hash}.jpg"))).unwrap();
        let r = c.import_folder(&dir.path().join("share"), None).unwrap();
        assert_eq!(r.blobs_missing, 1);
    }
}
