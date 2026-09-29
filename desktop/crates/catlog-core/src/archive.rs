//! Archiving: deceased Cats and empty Clowders nobody touched in years
//! are written into a file the keeper keeps and then deleted here. The
//! file comes home through an ordinary import.

use std::collections::{BTreeMap, BTreeSet};

use chrono::NaiveDate;

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::keys;

/// Marks the device id of entries written into an archive file, so an
/// import can tell an archive coming home from an ordinary sync.
pub const ARCHIVE_DEVICE_PREFIX: &str = "archive-";

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ArchiveCandidate {
    pub id: String,
    pub name: String,
    pub is_cat: bool,
    pub last_change: NaiveDate,
    pub photo_bytes: u64,
}

impl Catalog {
    /// Deceased Cats and empty Clowders with no change for
    /// `inactive_days`, oldest change first.
    pub fn archive_candidates(
        &self,
        today: NaiveDate,
        inactive_days: i64,
    ) -> Result<Vec<ArchiveCandidate>> {
        let mut newest: BTreeMap<String, NaiveDate> = BTreeMap::new();
        for e in self.entries_since(&BTreeMap::new(), true)? {
            let id = self.resolve_entity(&e.entity)?;
            let Some(day) = e.date.get(..10).and_then(|d| d.parse::<NaiveDate>().ok()) else {
                continue;
            };
            let slot = newest.entry(id).or_insert(day);
            if day > *slot {
                *slot = day;
            }
        }
        let mut result = Vec::new();
        let mut add = |id: &str, name: &str, is_cat: bool| -> Result<()> {
            let Some(last) = newest.get(&self.resolve_entity(id)?).copied() else {
                return Ok(());
            };
            if (today - last).num_days() < inactive_days {
                return Ok(());
            }
            let mut bytes = 0u64;
            for hash in self.images(id)? {
                bytes += self.image_bytes(&hash).map(|b| b.len() as u64).unwrap_or(0);
            }
            result.push(ArchiveCandidate {
                id: id.to_string(),
                name: name.to_string(),
                is_cat,
                last_change: last,
                photo_bytes: bytes,
            });
            Ok(())
        };
        for cat in self.cats(None)? {
            let deceased = self.current(&cat.id, &keys::user_field("deceased"))?;
            if deceased.as_deref().is_none_or(str::is_empty) {
                continue;
            }
            add(&cat.id, &cat.name, true)?;
        }
        for clowder in self.clowders()? {
            if !self.cats(Some(&clowder.id))?.is_empty() {
                continue;
            }
            add(&clowder.id, &clowder.name, false)?;
        }
        result.sort_by_key(|c| c.last_change);
        Ok(result)
    }

    /// Writes the entities' whole history, Field definitions and photos
    /// into a bundle at `path`, re-stamped under an archive device so a
    /// later import knows what it is.
    pub fn write_archive(&self, path: &std::path::Path, ids: &[String]) -> Result<()> {
        let mut wanted = BTreeSet::new();
        for id in ids {
            wanted.insert(self.resolve_entity(id)?);
        }
        let defs: BTreeSet<String> = self.field_def_ids()?.into_iter().collect();
        let mut random = [0u8; 4];
        let _ = getrandom::fill(&mut random);
        let device = format!("{ARCHIVE_DEVICE_PREFIX}{}", hex::encode(random));
        let mut entries = Vec::new();
        for e in self.entries_since(&BTreeMap::new(), true)? {
            if wanted.contains(&self.resolve_entity(&e.entity)?) || defs.contains(&e.entity) {
                entries.push(Entry {
                    seq: -1,
                    device: device.clone(),
                    dseq: entries.len() as i64 + 1,
                    sig: None,
                    ..e
                });
            }
        }
        self.write_entries_bundle(path, &entries)
    }

    /// Deletes the archived entities the ordinary way, so every synced
    /// device follows.
    pub fn delete_archived(&mut self, ids: &[String]) -> Result<()> {
        for id in ids {
            let canonical = self.resolve_entity(id)?;
            if self.current(&canonical, keys::TYPE)?.as_deref() == Some(keys::KIND_CLOWDER) {
                self.delete_clowder(&canonical)?;
            } else {
                self.delete_cat(&canonical)?;
            }
        }
        Ok(())
    }

    /// After an import: the entities an archive file brought that are
    /// deleted here, which the keeper may want back.
    pub fn restorable_entities(&self, applied: &[Entry]) -> Result<Vec<String>> {
        let mut ids = BTreeSet::new();
        for e in applied {
            if !e.device.starts_with(ARCHIVE_DEVICE_PREFIX) {
                continue;
            }
            let id = self.resolve_entity(&e.entity)?;
            if self.current(&id, keys::DELETED)?.as_deref() == Some("true") {
                ids.insert(id);
            }
        }
        Ok(ids.into_iter().collect())
    }

    /// Brings deleted entities back.
    pub fn restore_deleted(&mut self, ids: &[String]) -> Result<()> {
        for id in ids {
            self.append(id, keys::DELETED, None)?;
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::TimeZone;

    #[test]
    fn old_deceased_cats_and_empty_homes_are_archived_and_come_home() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.set_clock(Box::new(|| {
            chrono::Utc.with_ymd_and_hms(2020, 1, 1, 10, 0, 0).unwrap()
        }));
        store.create_clowder("clowder:h", "Old Home").unwrap();
        store.create_clowder("clowder:full", "Busy").unwrap();
        store.create_cat("cat:gone", "Gone", None, "cat").unwrap();
        store
            .append("cat:gone", "f:deceased", Some("2020-01-01"))
            .unwrap();
        store
            .create_cat("cat:alive", "Alive", Some("clowder:full"), "cat")
            .unwrap();
        store.set_clock(Box::new(|| {
            chrono::Utc.with_ymd_and_hms(2026, 1, 1, 10, 0, 0).unwrap()
        }));
        store.create_cat("cat:fresh", "Fresh", None, "cat").unwrap();
        store
            .append("cat:fresh", "f:deceased", Some("2025-12-31"))
            .unwrap();
        let today = NaiveDate::from_ymd_opt(2026, 3, 1).unwrap();
        let found = store.archive_candidates(today, 365 * 2).unwrap();
        let mut ids: Vec<&str> = found.iter().map(|c| c.id.as_str()).collect();
        ids.sort();
        assert_eq!(ids, vec!["cat:gone", "clowder:h"], "old and untouched only");
        let gone = found.iter().find(|c| c.id == "cat:gone").unwrap();
        assert!(gone.is_cat);
        assert_eq!(
            gone.last_change,
            NaiveDate::from_ymd_opt(2020, 1, 1).unwrap()
        );
        // Written out, then deleted here.
        let path = dir.path().join("archive.catsync");
        let chosen: Vec<String> = ids.iter().map(|s| s.to_string()).collect();
        store.write_archive(&path, &chosen).unwrap();
        store.delete_archived(&chosen).unwrap();
        assert!(store.is_deleted("cat:gone").unwrap());
        assert!(store.is_deleted("clowder:h").unwrap());
        assert!(store.archive_candidates(today, 365 * 2).unwrap().is_empty());
        // The file brings them back through an ordinary import.
        let mut other = Catalog::open(&dir.path().join("other")).unwrap();
        other.set_author("Bob").unwrap();
        let result = other.import_bundle(&path).unwrap();
        assert!(result.entries_in > 0);
        assert_eq!(
            other.current("cat:gone", keys::NAME).unwrap().as_deref(),
            Some("Gone")
        );
        assert!(
            result
                .applied
                .iter()
                .all(|e| e.device.starts_with(ARCHIVE_DEVICE_PREFIX))
        );
        assert!(
            other
                .restorable_entities(&result.applied)
                .unwrap()
                .is_empty(),
            "not deleted there"
        );
        // At home the archive meets the deletion: restorable, then restored.
        let back = store.import_bundle(&path).unwrap();
        let restorable = store.restorable_entities(&back.applied).unwrap();
        assert_eq!(
            restorable,
            vec!["cat:gone".to_string(), "clowder:h".to_string()]
        );
        store.restore_deleted(&restorable).unwrap();
        assert!(!store.is_deleted("cat:gone").unwrap());
    }
}
