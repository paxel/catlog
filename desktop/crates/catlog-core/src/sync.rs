//! The shared-folder sync as the desk runs it: the settings the phone
//! keeps under the same names, the Catalog's subfolder name, and the
//! watch that notices a partner's file growing between rounds.

use std::collections::BTreeMap;
use std::path::Path;

use crate::Result;
use crate::catalog::Catalog;
use crate::error::Error;
use crate::folder::{FolderImport, SYNC_DIR, parse_lines};

/// The chosen shared folder, a path.
pub const SYNC_FOLDER: &str = "syncFolder";
/// The folder chosen last, for "use the same folder as the other catalogs".
pub const SYNC_FOLDER_LAST: &str = "syncFolderLast";
/// `0` off; on once a folder is chosen.
pub const SYNC_WATCH: &str = "syncWatch";
/// `1` merges on its own.
pub const SYNC_AUTO: &str = "syncAuto";
/// `1` lets private values travel.
pub const SYNC_PRIVATE: &str = "syncPrivate";
/// JSON: file to size at the last sync.
pub const SYNC_SIZES: &str = "syncWatchSizes";

/// The subfolder a Catalog uses inside a shared folder, from its name:
/// `leipzig`, so one folder can carry every Catalog and partners find
/// each other by the name they agreed on. A name the file system cannot
/// carry, or an empty one, gets a short fingerprint instead.
pub fn catalog_folder_name(catalog_name: Option<&str>) -> String {
    let name = catalog_name.unwrap_or("").trim();
    let lower = name.to_lowercase();
    let mut safe = String::new();
    let mut dash = false;
    for c in lower.chars() {
        if c.is_ascii_lowercase() || c.is_ascii_digit() {
            safe.push(c);
            dash = false;
        } else if !dash {
            safe.push('-');
            dash = true;
        }
    }
    let safe = safe.trim_matches('-').to_string();
    let spaced: String = lower
        .split(char::is_whitespace)
        .filter(|s| !s.is_empty())
        .collect::<Vec<_>>()
        .join("-");
    let faithful = safe == spaced;
    if safe.is_empty() {
        return format!("catalog-{}", fingerprint(name));
    }
    if faithful {
        safe
    } else {
        format!("{safe}-{}", fingerprint(name))
    }
}

/// FNV-1a over the name's characters, as the phone computes it.
fn fingerprint(value: &str) -> String {
    let mut hash: u32 = 0x811c9dc5;
    for c in value.chars() {
        hash ^= c as u32;
        hash = hash.wrapping_mul(0x01000193);
    }
    format!("{hash:08x}")
}

/// Sizes of the partners' entry files, keyed `<dir>/<name>` where dir is
/// the Catalog's subfolder or empty for the root.
pub fn foreign_file_sizes(
    folder: &Path,
    device_id: &str,
    catalog: Option<&str>,
) -> BTreeMap<String, u64> {
    let root = folder.join(SYNC_DIR);
    let mut out = BTreeMap::new();
    let own = [format!("{device_id}.jsonl"), format!("{device_id}.jsonl2")];
    let dirs: Vec<&str> = match catalog {
        Some(c) => vec![c, ""],
        None => vec![""],
    };
    for dir in dirs {
        let Ok(read) = std::fs::read_dir(root.join(dir)) else {
            continue;
        };
        for entry in read.flatten() {
            let name = entry.file_name().to_string_lossy().into_owned();
            if !(name.ends_with(".jsonl") || name.ends_with(".jsonl2")) || own.contains(&name) {
                continue;
            }
            if let Ok(meta) = entry.metadata()
                && meta.is_file()
            {
                out.insert(format!("{dir}/{name}"), meta.len());
            }
        }
    }
    out
}

/// The files that grew since `before`, or are new.
pub fn grown_files(before: &BTreeMap<String, u64>, after: &BTreeMap<String, u64>) -> Vec<String> {
    after
        .iter()
        .filter(|(file, size)| **size > before.get(*file).copied().unwrap_or(0))
        .map(|(file, _)| file.clone())
        .collect()
}

/// What waits in the folder: rows this Catalog has not seen, and who
/// wrote them.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct UnseenChanges {
    pub count: usize,
    pub authors: Vec<String>,
}

impl UnseenChanges {
    pub fn is_empty(&self) -> bool {
        self.count == 0
    }
}

/// Counts the rows in `files` that are ahead of this Catalog's version
/// vector. A file that will not parse counts nothing.
pub fn unseen_changes(store: &Catalog, folder: &Path, files: &[String]) -> Result<UnseenChanges> {
    let clock = store.version_vector()?;
    let me = store.device_id();
    let mut seen = std::collections::BTreeSet::new();
    let mut authors = std::collections::BTreeSet::new();
    for file in files {
        let path = folder.join(SYNC_DIR).join(file.trim_start_matches('/'));
        let Ok(text) = std::fs::read_to_string(&path) else {
            continue;
        };
        let Some(entries) = parse_lines(&text) else {
            continue;
        };
        for e in entries {
            if e.device == me || e.dseq <= clock.get(&e.device).copied().unwrap_or(0) {
                continue;
            }
            if seen.insert((e.device.clone(), e.dseq))
                && !e.author.is_empty()
                && e.author != crate::SEED_AUTHOR
            {
                authors.insert(e.author.clone());
            }
        }
    }
    Ok(UnseenChanges {
        count: seen.len(),
        authors: authors.into_iter().collect(),
    })
}

/// What one watch round found.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct WatchCheck {
    /// Changes waiting, when a partner's file grew with unseen rows.
    pub pending: Option<UnseenChanges>,
    /// The partners' file sizes as they are now.
    pub sizes: BTreeMap<String, u64>,
    /// Photos fetched on the side, for entries that arrived earlier.
    pub photos_in: usize,
}

impl std::fmt::Display for FolderImport {
    /// The summary line as the phone words it.
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{} entries + {} photos in, {} entries + {} photos out",
            self.entries_in, self.blobs_in, self.entries_out, self.blobs_out
        )?;
        if self.blobs_missing > 0 {
            write!(f, ", {} photos not in the folder yet", self.blobs_missing)?;
        }
        for p in &self.blob_problems {
            write!(f, "\n{p}")?;
        }
        Ok(())
    }
}

impl Catalog {
    /// The chosen shared folder, when one is set.
    pub fn sync_folder_path(&self) -> Option<std::path::PathBuf> {
        self.local_setting(SYNC_FOLDER)
            .map(std::path::PathBuf::from)
    }

    /// This Catalog's subfolder inside a shared folder.
    pub fn sync_catalog_dir(&self) -> String {
        catalog_folder_name(
            self.local_setting(crate::catalogs::CATALOG_NAME_KEY)
                .as_deref(),
        )
    }

    /// True unless the watch was switched off.
    pub fn sync_watch_on(&self) -> bool {
        self.local_setting(SYNC_WATCH).as_deref() != Some("0")
    }

    pub fn sync_auto_on(&self) -> bool {
        self.local_setting(SYNC_AUTO).as_deref() == Some("1")
    }

    pub fn sync_private_on(&self) -> bool {
        self.local_setting(SYNC_PRIVATE).as_deref() == Some("1")
    }

    /// Chooses the shared folder: watched from now on, sizes forgotten.
    pub fn choose_sync_folder(&self, folder: &Path) -> Result<()> {
        let text = folder.to_string_lossy();
        self.set_local_setting(SYNC_FOLDER, &text)?;
        self.set_local_setting(SYNC_FOLDER_LAST, &text)?;
        self.set_local_setting(SYNC_WATCH, "1")?;
        self.set_local_setting(SYNC_SIZES, "{}")
    }

    /// The sizes recorded at the last sync, none before the first.
    pub fn recorded_sync_sizes(&self) -> Option<BTreeMap<String, u64>> {
        let raw = self.local_setting(SYNC_SIZES)?;
        serde_json::from_str(&raw).ok()
    }

    /// Records the partners' file sizes as they are now: what the next
    /// watch round compares against.
    pub fn record_sync_sizes(&self, folder: &Path) -> Result<()> {
        let sizes = foreign_file_sizes(folder, &self.device_id(), Some(&self.sync_catalog_dir()));
        self.set_local_setting(SYNC_SIZES, &serde_json::to_string(&sizes)?)
    }

    /// One watch round: fetches photos still missing, then compares the
    /// partners' file sizes with the recorded ones and counts the unseen
    /// rows in the files that grew. The first round only records.
    pub fn check_sync_folder(&mut self, folder: &Path) -> Result<WatchCheck> {
        if !folder.join(SYNC_DIR).is_dir() {
            return Err(Error::Invalid("folder unreachable".into()));
        }
        let catalog = self.sync_catalog_dir();
        let before = self.recorded_sync_sizes();
        let after = foreign_file_sizes(folder, &self.device_id(), Some(&catalog));
        let mut check = WatchCheck {
            pending: None,
            sizes: after.clone(),
            photos_in: 0,
        };
        if !self.missing_blobs()?.is_empty() {
            check.photos_in = self.fetch_folder_blobs(folder, Some(&catalog))?;
        }
        let Some(before) = before else {
            self.set_local_setting(SYNC_SIZES, &serde_json::to_string(&after)?)?;
            return Ok(check);
        };
        let grown = grown_files(&before, &after);
        if grown.is_empty() {
            return Ok(check);
        }
        let unseen = unseen_changes(self, folder, &grown)?;
        if unseen.is_empty() {
            self.set_local_setting(SYNC_SIZES, &serde_json::to_string(&after)?)?;
            return Ok(check);
        }
        check.pending = Some(unseen);
        Ok(check)
    }

    /// One full round through the chosen folder with this Catalog's
    /// settings, the sizes recorded after, and the Moment before it when
    /// something arrived.
    pub fn sync_chosen_folder(&mut self) -> Result<(FolderImport, Option<crate::moments::Moment>)> {
        let folder = self
            .sync_folder_path()
            .ok_or_else(|| Error::Invalid("no folder chosen".into()))?;
        if !folder.is_dir() {
            return Err(Error::Invalid("folder unreachable".into()));
        }
        let catalog = self.sync_catalog_dir();
        let before = self.current_seq()?;
        let result = self.sync_folder(&folder, Some(&catalog), self.sync_private_on())?;
        let moment = self.moment_for(before, !result.applied.is_empty(), "sync", None)?;
        self.record_sync_sizes(&folder)?;
        Ok((result, moment))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn folder_names_match_the_phone() {
        // Computed by the Dart core's catalogFolderName.
        for (name, expected) in [
            (None, "catalog-811c9dc5"),
            (Some(""), "catalog-811c9dc5"),
            (Some("Leipzig"), "leipzig"),
            (Some("Leipzig Nord"), "leipzig-nord"),
            (Some("Katzen & Co"), "katzen-co-aefa64e0"),
            (Some("Zürich"), "z-rich-dc81153d"),
            (Some("  spaced  "), "spaced"),
            (Some("a--b"), "a-b-258cd9e8"),
            (Some("日本"), "catalog-5ffcbea4"),
        ] {
            assert_eq!(catalog_folder_name(name), expected, "{name:?}");
        }
    }

    fn two_catalogs(dir: &Path) -> (Catalog, Catalog) {
        let a = Catalog::open(&dir.join("a")).unwrap();
        a.set_author("Ada").unwrap();
        let b = Catalog::open(&dir.join("b")).unwrap();
        b.set_author("Bob").unwrap();
        a.set_local_setting(crate::catalogs::CATALOG_NAME_KEY, "Leipzig")
            .unwrap();
        b.set_local_setting(crate::catalogs::CATALOG_NAME_KEY, "Leipzig")
            .unwrap();
        (a, b)
    }

    #[test]
    fn the_watch_notices_a_partner_file_growing_with_unseen_rows() {
        let dir = tempfile::tempdir().unwrap();
        let shared = dir.path().join("shared");
        let (mut a, mut b) = two_catalogs(dir.path());
        assert!(a.check_sync_folder(&shared).is_err(), "no folder yet");
        std::fs::create_dir_all(&shared).unwrap();
        a.choose_sync_folder(&shared).unwrap();
        assert_eq!(a.sync_folder_path(), Some(shared.clone()));
        assert!(a.sync_watch_on());
        assert!(!a.sync_auto_on());
        assert_eq!(a.sync_catalog_dir(), "leipzig");
        b.choose_sync_folder(&shared).unwrap();
        a.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let (round, moment) = a.sync_chosen_folder().unwrap();
        assert!(moment.is_none(), "nothing arrived at the writer");
        assert!(round.entries_out > 0);
        assert!(round.to_string().starts_with("0 entries + 0 photos in, "));
        // B takes the lot; the sizes are recorded with the round, so the
        // next checks are quiet.
        let (round, moment) = b.sync_chosen_folder().unwrap();
        assert!(moment.is_some());
        assert!(round.entries_in > 0);
        assert!(b.check_sync_folder(&shared).unwrap().pending.is_none());
        let quiet = b.check_sync_folder(&shared).unwrap();
        assert!(quiet.pending.is_none());
        assert_eq!(quiet.sizes.len(), 1);
        // A writes more: the file grows, the row is unseen at B.
        a.append("cat:a", "f:remarks", Some("friendly")).unwrap();
        a.sync_chosen_folder().unwrap();
        let check = b.check_sync_folder(&shared).unwrap();
        let pending = check.pending.expect("changes waiting");
        assert_eq!(pending.count, 1);
        assert_eq!(pending.authors, vec!["Ada".to_string()]);
        // Still waiting until B merges; then quiet again.
        assert!(b.check_sync_folder(&shared).unwrap().pending.is_some());
        let (round, moment) = b.sync_chosen_folder().unwrap();
        assert!(moment.is_some());
        assert_eq!(round.entries_in, 1);
        assert!(b.check_sync_folder(&shared).unwrap().pending.is_none());
        assert_eq!(
            b.current("cat:a", "f:remarks").unwrap().as_deref(),
            Some("friendly")
        );
        // Own rows in the folder are never "unseen".
        let grown = grown_files(
            &BTreeMap::new(),
            &foreign_file_sizes(&shared, "nobody", Some("leipzig")),
        );
        assert_eq!(grown.len(), 2);
        let unseen = unseen_changes(&b, &shared, &grown).unwrap();
        assert_eq!(unseen.count, 0);
        // A file that will not parse counts nothing.
        std::fs::write(
            shared.join(SYNC_DIR).join("leipzig").join("x.jsonl"),
            "junk",
        )
        .unwrap();
        let unseen = unseen_changes(&b, &shared, &["leipzig/x.jsonl".to_string()]).unwrap();
        assert!(unseen.is_empty());
    }

    #[test]
    fn switches_and_a_folder_that_went_away() {
        let dir = tempfile::tempdir().unwrap();
        let store = Catalog::open(dir.path()).unwrap();
        assert!(store.sync_folder_path().is_none());
        assert!(store.recorded_sync_sizes().is_none());
        store.set_local_setting(SYNC_AUTO, "1").unwrap();
        store.set_local_setting(SYNC_PRIVATE, "1").unwrap();
        store.set_local_setting(SYNC_WATCH, "0").unwrap();
        assert!(store.sync_auto_on());
        assert!(store.sync_private_on());
        assert!(!store.sync_watch_on());
        assert_eq!(store.sync_catalog_dir(), "catalog-811c9dc5");
        let mut store = store;
        store
            .set_local_setting(SYNC_FOLDER, "/nowhere/at/all")
            .unwrap();
        assert!(store.sync_chosen_folder().is_err());
        store.set_local_setting(SYNC_SIZES, "not json").unwrap();
        assert!(store.recorded_sync_sizes().is_none());
        let mut round = FolderImport {
            blobs_missing: 2,
            blob_problems: vec!["abc not listed".into()],
            ..Default::default()
        };
        assert_eq!(
            round.to_string(),
            "0 entries + 0 photos in, 0 entries + 0 photos out, 2 photos not in the folder yet\nabc not listed"
        );
        round.blobs_missing = 0;
        round.blob_problems.clear();
        assert_eq!(
            round.to_string(),
            "0 entries + 0 photos in, 0 entries + 0 photos out"
        );
    }
}
