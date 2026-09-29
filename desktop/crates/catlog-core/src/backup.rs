//! Backups: a full copy of a Catalog, photos included, written whenever
//! the keeper leaves the app after changes, and the way back from such
//! files after a reinstall.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use crate::Result;
use crate::catalog::Catalog;
use crate::catalogs::{CATALOG_NAME_KEY, CatalogInfo, CatalogManager};
use crate::error::Error;

pub const BACKUP_VECTOR_KEY: &str = "lastBackupVector";
pub const BACKUP_AT_KEY: &str = "lastBackupAt";
pub const BACKUP_ERROR_KEY: &str = "lastBackupError";
/// A folder of the keeper's choice that receives every copy too.
pub const BACKUP_FOLDER_KEY: &str = "backupFolder";
/// The subfolder inside that folder.
pub const BACKUP_TREE: &str = "catlog-backups";

/// The file a Catalog's backup wears: `catlog-<name>.catsync`.
pub fn backup_file_name(catalog_name: Option<&str>) -> String {
    let name = catalog_name.unwrap_or("").trim();
    if name.is_empty() {
        return "catlog-backup.catsync".into();
    }
    let stem = crate::sync::catalog_folder_name(Some(name));
    if stem.starts_with("catalog-") && !name.to_lowercase().starts_with("catalog") {
        return format!("catlog-{}.catsync", stem.replace("catalog-", ""));
    }
    format!("catlog-{stem}.catsync")
}

/// The stem of a backup file name, `.catsync` and a `.zip` stripped.
pub fn backup_stem(file_name: &str) -> String {
    let mut stem = file_name.to_string();
    if let Some(s) = stem.strip_suffix(".zip") {
        stem = s.to_string();
    }
    if let Some(s) = stem.strip_suffix(".catsync") {
        stem = s.to_string();
    }
    if let Some(s) = stem.strip_prefix("catlog-") {
        stem = s.to_string();
    }
    stem
}

/// A Catalog name read back from its backup file: `catlog-leipzig-nord`
/// gives "Leipzig Nord".
pub fn catalog_name_from_file(file_name: &str) -> String {
    let stem = backup_stem(file_name);
    let raw = stem.strip_prefix("catlog-").unwrap_or(&stem);
    let words: Vec<String> = raw
        .split('-')
        .filter(|w| !w.is_empty())
        .map(|w| {
            let mut c = w.chars();
            match c.next() {
                Some(first) => first.to_uppercase().collect::<String>() + c.as_str(),
                None => String::new(),
            }
        })
        .collect();
    if words.is_empty() {
        "Backup".into()
    } else {
        words.join(" ")
    }
}

pub fn is_restorable_backup(file_name: &str) -> bool {
    (file_name.ends_with(".catsync") || file_name.ends_with(".catsync.zip"))
        && file_name.starts_with("catlog-")
}

/// The backup files of one Catalog, newest first.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct BackupSet {
    pub name: String,
    pub files: Vec<PathBuf>,
    /// When the newest file was written, seconds since the epoch.
    pub newest: i64,
}

fn modified(path: &Path) -> i64 {
    std::fs::metadata(path)
        .and_then(|m| m.modified())
        .ok()
        .and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok())
        .map(|d| d.as_secs() as i64)
        .unwrap_or(0)
}

/// Groups files by Catalog, newest set first.
pub fn find_backups(files: &[PathBuf]) -> Vec<BackupSet> {
    let mut by_stem: BTreeMap<String, Vec<PathBuf>> = BTreeMap::new();
    for f in files {
        let name = f
            .file_name()
            .map(|n| n.to_string_lossy().into_owned())
            .unwrap_or_default();
        if !is_restorable_backup(&name) {
            continue;
        }
        by_stem
            .entry(backup_stem(&name))
            .or_default()
            .push(f.clone());
    }
    let mut sets: Vec<BackupSet> = by_stem
        .into_iter()
        .map(|(stem, mut files)| {
            files.sort_by_key(|f| std::cmp::Reverse(modified(f)));
            let newest = files.first().map(|f| modified(f)).unwrap_or(0);
            BackupSet {
                name: catalog_name_from_file(&format!("catlog-{stem}.catsync")),
                files,
                newest,
            }
        })
        .collect();
    sets.sort_by_key(|s| std::cmp::Reverse(s.newest));
    sets
}

/// The backup sets in a folder.
pub fn backups_in(folder: &Path) -> Vec<BackupSet> {
    let files: Vec<PathBuf> = std::fs::read_dir(folder)
        .map(|d| {
            d.flatten()
                .map(|e| e.path())
                .filter(|p| p.is_file())
                .collect()
        })
        .unwrap_or_default();
    find_backups(&files)
}

/// A backup set becomes a Catalog again, under its name or a numbered
/// one when that is taken; every file of the set is imported.
pub fn restore_backup_set(manager: &mut CatalogManager, set: &BackupSet) -> Result<CatalogInfo> {
    let mut made = None;
    for n in 1..100 {
        let name = if n == 1 {
            set.name.clone()
        } else {
            format!("{} ({n})", set.name)
        };
        match manager.create(&name) {
            Ok(info) => {
                made = Some(info);
                break;
            }
            Err(Error::Invalid(_)) => continue,
            Err(e) => return Err(e),
        }
    }
    let info = made.ok_or_else(|| Error::Invalid("no free name".into()))?;
    let mut store = manager.open_store(&info)?;
    for file in &set.files {
        store.import_bundle(file)?;
    }
    Ok(info)
}

impl Catalog {
    /// The moment of the last backup, ISO 8601, and the last error.
    pub fn last_backup(&self) -> (Option<String>, Option<String>) {
        let error = self
            .local_setting(BACKUP_ERROR_KEY)
            .filter(|e| !e.is_empty());
        (self.local_setting(BACKUP_AT_KEY), error)
    }

    /// Writes the backup into `dir` unless nothing changed since the
    /// last one (or `force`), and copies it into the chosen folder too.
    /// Returns the file written, none when nothing was due. An error is
    /// remembered for the Backups page and returned.
    pub fn auto_backup(&self, dir: &Path, force: bool) -> Result<Option<PathBuf>> {
        let vector = serde_json::to_string(&self.version_vector()?)?;
        if !force && self.local_setting(BACKUP_VECTOR_KEY).as_deref() == Some(&vector) {
            return Ok(None);
        }
        if self.cats(None)?.is_empty() && self.clowders()?.is_empty() {
            return Ok(None);
        }
        let name = backup_file_name(self.local_setting(CATALOG_NAME_KEY).as_deref());
        let result = (|| -> Result<PathBuf> {
            std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
            let path = dir.join(&name);
            self.write_bundle(&path, true)?;
            if let Some(tree) = self
                .local_setting(BACKUP_FOLDER_KEY)
                .filter(|t| !t.is_empty())
            {
                let target = Path::new(&tree).join(BACKUP_TREE);
                std::fs::create_dir_all(&target).map_err(|e| Error::io(&target, e))?;
                std::fs::copy(&path, target.join(&name)).map_err(|e| Error::io(&target, e))?;
            }
            Ok(path)
        })();
        match result {
            Ok(path) => {
                self.set_local_setting(BACKUP_VECTOR_KEY, &vector)?;
                self.set_local_setting(BACKUP_AT_KEY, &self.now_iso())?;
                self.set_local_setting(BACKUP_ERROR_KEY, "")?;
                Ok(Some(path))
            }
            Err(e) => {
                self.set_local_setting(BACKUP_ERROR_KEY, &e.to_string())?;
                Err(e)
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn backup_names_round_trip_to_catalog_names() {
        assert_eq!(backup_file_name(None), "catlog-backup.catsync");
        assert_eq!(backup_file_name(Some("  ")), "catlog-backup.catsync");
        assert_eq!(backup_file_name(Some("Leipzig")), "catlog-leipzig.catsync");
        assert_eq!(
            backup_file_name(Some("Leipzig Nord")),
            "catlog-leipzig-nord.catsync"
        );
        assert_eq!(
            backup_file_name(Some("Katzen & Co")),
            "catlog-katzen-co-aefa64e0.catsync"
        );
        assert_eq!(backup_stem("catlog-leipzig.catsync.zip"), "leipzig");
        assert_eq!(
            catalog_name_from_file("catlog-leipzig-nord.catsync"),
            "Leipzig Nord"
        );
        assert_eq!(catalog_name_from_file("catlog-.catsync"), "Backup");
        assert!(is_restorable_backup("catlog-x.catsync"));
        assert!(is_restorable_backup("catlog-x.catsync.zip"));
        assert!(!is_restorable_backup("notes.catsync"));
        assert!(!is_restorable_backup("catlog-x.txt"));
    }

    #[test]
    fn a_backup_is_written_once_per_change_and_restored_as_a_catalog() {
        let dir = tempfile::tempdir().unwrap();
        let downloads = dir.path().join("downloads");
        let tree = dir.path().join("cloud");
        std::fs::create_dir_all(&tree).unwrap();
        let mut manager = CatalogManager::open(&dir.path().join("root"), "Clowders").unwrap();
        let info = manager.active().clone();
        let mut store = manager.open_store(&info).unwrap();
        store.set_author("Ada").unwrap();
        assert_eq!(
            store.auto_backup(&downloads, false).unwrap(),
            None,
            "an empty catalog"
        );
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        store
            .set_local_setting(BACKUP_FOLDER_KEY, &tree.to_string_lossy())
            .unwrap();
        let written = store.auto_backup(&downloads, false).unwrap().unwrap();
        assert_eq!(written, downloads.join("catlog-clowders.catsync"));
        assert!(
            tree.join(BACKUP_TREE)
                .join("catlog-clowders.catsync")
                .is_file()
        );
        let (at, error) = store.last_backup();
        assert!(at.is_some());
        assert!(error.is_none());
        assert_eq!(
            store.auto_backup(&downloads, false).unwrap(),
            None,
            "nothing changed"
        );
        assert!(
            store.auto_backup(&downloads, true).unwrap().is_some(),
            "forced"
        );
        store.append("cat:a", "f:remarks", Some("x")).unwrap();
        assert!(store.auto_backup(&downloads, false).unwrap().is_some());
        // A folder that cannot be written is remembered as the error.
        store
            .set_local_setting(
                BACKUP_FOLDER_KEY,
                &dir.path().join("nofile.txt/x").to_string_lossy(),
            )
            .unwrap();
        std::fs::write(dir.path().join("nofile.txt"), "x").unwrap();
        store.append("cat:a", "f:remarks", Some("y")).unwrap();
        assert!(store.auto_backup(&downloads, false).is_err());
        assert!(store.last_backup().1.is_some());
        drop(store);
        // Restore: the set is found and becomes a Catalog with a free name.
        let sets = backups_in(&downloads);
        assert_eq!(sets.len(), 1);
        assert_eq!(sets[0].name, "Clowders");
        assert_eq!(sets[0].files.len(), 1);
        let restored = restore_backup_set(&mut manager, &sets[0]).unwrap();
        assert_eq!(restored.name, "Clowders (2)");
        let again = manager.open_store(&restored).unwrap();
        assert_eq!(
            again
                .current("cat:a", crate::keys::NAME)
                .unwrap()
                .as_deref(),
            Some("Miezi")
        );
        assert!(backups_in(&dir.path().join("missing")).is_empty());
        assert!(find_backups(&[dir.path().join("nofile.txt")]).is_empty());
    }
}
