//! Going back to an earlier Moment (ADR 0009). The log is append-only,
//! so a moment worth returning to is nothing more than the log's
//! high-water mark at that time: the entries after it are the change,
//! and removing them is the way back. What goes is written to a file
//! first, photos included, so going back never destroys anything.

use std::path::Path;

use crate::Result;
use crate::bundle::BundleResult;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::keys;

/// Why a moment was recorded.
pub mod cause {
    pub const IMPORT: &str = "import";
    pub const SYNC: &str = "sync";
    pub const MERGE: &str = "merge";
    pub const HARD_DELETE: &str = "hardDelete";
    pub const ARCHIVE: &str = "archive";
    pub const MANUAL: &str = "manual";
}

/// A moment the Catalog can be returned to.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Moment {
    pub id: i64,
    pub seq: i64,
    /// One of [`cause`].
    pub cause: String,
    /// What it was about: the file imported, the person synced with,
    /// the name typed for a moment marked by hand.
    pub label: Option<String>,
    pub at: String,
}

impl Catalog {
    /// The log's high-water mark right now.
    pub fn current_seq(&self) -> Result<i64> {
        Ok(self
            .db()
            .query_row("SELECT COALESCE(MAX(seq), 0) FROM entries", [], |r| {
                r.get(0)
            })?)
    }

    /// Records a moment. `seq` defaults to now; callers that only know
    /// afterwards whether anything happened pass the mark they took
    /// before. Returns the moment's id.
    pub fn add_moment(&self, cause: &str, label: Option<&str>, seq: Option<i64>) -> Result<i64> {
        let now = self.current_seq()?;
        let mark = match seq {
            Some(s) if s <= now => s,
            _ => now,
        };
        self.db().execute(
            "INSERT INTO moments (seq, cause, label, at) VALUES (?1, ?2, ?3, ?4)",
            rusqlite::params![mark, cause, label, self.now_iso()],
        )?;
        Ok(self.db().last_insert_rowid())
    }

    /// Every recorded moment, newest first.
    pub fn moments(&self) -> Result<Vec<Moment>> {
        let mut stmt = self
            .db()
            .prepare("SELECT id, seq, cause, label, at FROM moments ORDER BY seq DESC, id DESC")?;
        let rows = stmt.query_map([], |r| {
            Ok(Moment {
                id: r.get(0)?,
                seq: r.get(1)?,
                cause: r.get(2)?,
                label: r.get(3)?,
                at: r.get(4)?,
            })
        })?;
        Ok(rows.collect::<std::result::Result<_, _>>()?)
    }

    pub fn remove_moment(&self, id: i64) -> Result<()> {
        self.db()
            .execute("DELETE FROM moments WHERE id = ?1", [id])?;
        Ok(())
    }

    /// Everything written after `seq`, raw: private entries and markers
    /// included, nothing filtered.
    pub fn entries_after(&self, seq: i64) -> Result<Vec<Entry>> {
        self.select_raw("SELECT * FROM entries WHERE seq > ?1 ORDER BY seq", &[&seq])
    }

    /// What going back would remove, without removing it: the entities
    /// touched after the moment, by canonical id.
    pub fn changed_since(&self, moment: &Moment) -> Result<Vec<String>> {
        let mut ids: Vec<String> = Vec::new();
        for e in self.entries_after(moment.seq)? {
            let id = self.resolve_entity(&e.entity)?;
            if !ids.contains(&id) {
                ids.push(id);
            }
        }
        Ok(ids)
    }

    /// Physically removes everything written after `seq` and forgets the
    /// moments that lived up there. The second append-only exception
    /// (ADR 0009). The caller writes the removed entries out first.
    pub fn remove_entries_after(&mut self, seq: i64) -> Result<()> {
        let touched: Vec<String> = {
            let mut stmt = self
                .db()
                .prepare("SELECT DISTINCT field FROM entries WHERE seq > ?1 AND field LIKE ?2")?;
            let rows = stmt.query_map(
                rusqlite::params![seq, format!("{}%", keys::IMAGE_PREFIX)],
                |r| r.get::<_, String>(0),
            )?;
            rows.collect::<std::result::Result<_, _>>()?
        };
        self.remove_entries(
            "seq > ?1",
            &[seq.to_string()],
            &[("DELETE FROM moments WHERE seq > ?1", &[&seq])],
        )?;
        for field in touched {
            let hash = &field[keys::IMAGE_PREFIX.len()..];
            if !self.image_referenced(hash)? {
                self.remove_blob(hash)?;
            }
        }
        Ok(())
    }

    /// Writes everything `moment` would remove, photos included, without
    /// removing any of it.
    pub fn write_go_back_file(&self, moment: &Moment, path: &Path) -> Result<()> {
        let entries = self.entries_after(moment.seq)?;
        self.write_entries_bundle(path, &entries)
    }

    /// Removes everything after `moment`. Only ever after the go-back
    /// file has been written.
    pub fn apply_go_back(&mut self, moment: &Moment) -> Result<()> {
        self.remove_entries_after(moment.seq)
    }

    /// Returns the Catalog to `moment`: the removed entries go to
    /// `keep_at` first. If the file cannot be written, nothing is removed.
    pub fn revert_to(&mut self, moment: &Moment, keep_at: &Path) -> Result<()> {
        self.write_go_back_file(moment, keep_at)?;
        self.apply_go_back(moment)
    }

    /// Records the moment before a change that has already happened,
    /// given the mark taken before it. Nothing changed means no moment.
    pub fn moment_for(
        &self,
        before: i64,
        changed: bool,
        cause: &str,
        label: Option<&str>,
    ) -> Result<Option<Moment>> {
        if !changed {
            return Ok(None);
        }
        let id = self.add_moment(cause, label, Some(before))?;
        Ok(self.moments()?.into_iter().find(|m| m.id == id))
    }

    /// Imports a bundle and records the moment before it, when
    /// something arrived.
    pub fn import_with_moment(
        &mut self,
        path: &Path,
        cause: &str,
        label: Option<&str>,
    ) -> Result<(BundleResult, Option<Moment>)> {
        let before = self.current_seq()?;
        let result = self.import_bundle(path)?;
        let moment = self.moment_for(before, !result.applied.is_empty(), cause, label)?;
        Ok((result, moment))
    }

    /// Drops entries that arrived from elsewhere, a partner's change the
    /// keeper does not want here, and keeps their numbers claimed, so
    /// they are never offered again. Only a conflict flag they raised is
    /// cleared. Photos they brought go when nothing else shows them.
    pub fn discard_entries(&mut self, entries: &[Entry]) -> Result<()> {
        if entries.is_empty() {
            return Ok(());
        }
        let hashes: Vec<String> = entries
            .iter()
            .filter_map(|e| e.field.strip_prefix(keys::IMAGE_PREFIX).map(String::from))
            .collect();
        for slice in entries.chunks(400) {
            let where_sql = slice
                .iter()
                .enumerate()
                .map(|(i, _)| format!("(device = ?{} AND dseq = ?{})", 2 * i + 1, 2 * i + 2))
                .collect::<Vec<_>>()
                .join(" OR ");
            let args: Vec<String> = slice
                .iter()
                .flat_map(|e| [e.device.clone(), e.dseq.to_string()])
                .collect();
            self.remove_entries(&where_sql, &args, &[])?;
        }
        for e in entries {
            if keys::is_correctable(&e.field) && self.has_conflict(&e.entity, &e.field)? {
                self.resolve_conflict(&e.entity, &e.field)?;
            }
        }
        for hash in hashes {
            if !self.image_referenced(&hash)? {
                self.remove_blob(&hash)?;
            }
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn catalog(dir: &Path) -> Catalog {
        let c = Catalog::open_with_device(dir, "me").unwrap();
        c.set_author("Patrick").unwrap();
        c
    }

    fn mark(c: &Catalog) -> Moment {
        let id = c.add_moment(cause::MANUAL, Some("by hand"), None).unwrap();
        c.moments()
            .unwrap()
            .into_iter()
            .find(|m| m.id == id)
            .unwrap()
    }

    #[test]
    fn going_back_puts_every_field_back_and_writes_what_it_removes() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = catalog(&dir.path().join("mine"));
        c.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        c.append("cat:m", "f:color", Some("black")).unwrap();
        let point = mark(&c);
        assert_eq!(point.cause, cause::MANUAL);
        assert_eq!(point.label.as_deref(), Some("by hand"));
        c.append("cat:m", "f:color", Some("white")).unwrap();
        c.create_cat("cat:x", "Mausi", None, "cat").unwrap();
        let hash = c.add_image("cat:x", b"photo").unwrap();
        assert_eq!(c.changed_since(&point).unwrap(), vec!["cat:m", "cat:x"]);
        let keep = dir.path().join("undo.catsync");
        let counter = c.version_vector().unwrap()["me"];
        c.revert_to(&point, &keep).unwrap();
        assert_eq!(
            c.current("cat:m", "f:color").unwrap().as_deref(),
            Some("black")
        );
        assert_eq!(c.cats(None).unwrap().len(), 1);
        assert!(
            c.image_bytes(&hash).is_none(),
            "photos nothing refers to are gone"
        );
        assert!(keep.exists());
        // The numbers stay claimed: the next own row goes past them.
        c.append("cat:m", "f:remarks", Some("after")).unwrap();
        assert_eq!(c.all_entries().unwrap().last().unwrap().dseq, counter + 1);
        // The file brings everything back, photo and all, under the old numbers.
        let r = c.import_bundle(&keep).unwrap();
        assert!(r.entries_in > 0);
        assert_eq!(c.cats(None).unwrap().len(), 2);
        assert!(c.image_bytes(&hash).is_some());
        assert_eq!(
            c.current("cat:m", "f:color").unwrap().as_deref(),
            Some("white")
        );
        // A file that cannot be written removes nothing.
        let point = mark(&c);
        c.append("cat:m", "f:color", Some("grey")).unwrap();
        assert!(
            c.revert_to(&point, &dir.path().join("nowhere").join("x.catsync"))
                .is_err()
        );
        assert_eq!(
            c.current("cat:m", "f:color").unwrap().as_deref(),
            Some("grey")
        );
    }

    #[test]
    fn moments_are_listed_newest_first_and_clamped_to_the_log() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = catalog(dir.path());
        let first = c
            .add_moment(cause::IMPORT, Some("a.catsync"), None)
            .unwrap();
        c.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        let beyond = c.add_moment(cause::SYNC, None, Some(999_999)).unwrap();
        let moments = c.moments().unwrap();
        assert_eq!(moments[0].id, beyond);
        assert_eq!(moments[0].seq, c.current_seq().unwrap());
        assert_eq!(moments[1].id, first);
        c.remove_moment(first).unwrap();
        assert_eq!(c.moments().unwrap().len(), 1);
        assert!(c.moment_for(0, false, cause::SYNC, None).unwrap().is_none());
        let m = c
            .moment_for(0, true, cause::MERGE, Some("x"))
            .unwrap()
            .unwrap();
        assert_eq!((m.seq, m.cause.as_str()), (0, cause::MERGE));
        // Going back to a moment removes the moments above it; the one
        // returned to stays.
        let mut c = c;
        c.apply_go_back(&m).unwrap();
        assert_eq!(c.moments().unwrap().len(), 1);
        assert!(c.cats(None).unwrap().is_empty());
    }

    #[test]
    fn a_bundle_import_records_its_moment_only_when_something_arrived() {
        let dir = tempfile::tempdir().unwrap();
        let mut a = catalog(&dir.path().join("a"));
        a.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        let path = dir.path().join("a.catsync");
        a.write_bundle(&path, false).unwrap();
        let mut b = Catalog::open_with_device(&dir.path().join("b"), "bb").unwrap();
        b.set_author("Bea").unwrap();
        let (r, m) = b
            .import_with_moment(&path, cause::IMPORT, Some("a.catsync"))
            .unwrap();
        assert!(r.entries_in > 0);
        assert_eq!(m.unwrap().label.as_deref(), Some("a.catsync"));
        let (_, m) = b.import_with_moment(&path, cause::IMPORT, None).unwrap();
        assert!(m.is_none());
    }

    #[test]
    fn a_partners_change_can_be_kept_out_for_good() {
        let dir = tempfile::tempdir().unwrap();
        let mut a = catalog(&dir.path().join("a"));
        let mut b = Catalog::open_with_device(&dir.path().join("b"), "bb").unwrap();
        b.set_author("Bea").unwrap();
        a.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        b.apply_entries(
            a.entries_since(&std::collections::BTreeMap::new(), false)
                .unwrap(),
        )
        .unwrap();
        b.delete_cat("cat:m").unwrap();
        let photo = b.add_image("cat:m", b"photo").unwrap();
        a.put_blob(&photo, b"photo").unwrap();
        let applied = a
            .apply_entries(
                b.entries_since(&a.version_vector().unwrap(), false)
                    .unwrap(),
            )
            .unwrap();
        assert!(a.is_deleted("cat:m").unwrap());
        a.discard_entries(&applied).unwrap();
        assert!(!a.is_deleted("cat:m").unwrap());
        assert_eq!(a.cats(None).unwrap()[0].name, "Miezi");
        assert!(a.image_bytes(&photo).is_none());
        // The next sync brings nothing back: the numbers count as seen.
        let again = a
            .apply_entries(
                b.entries_since(&a.version_vector().unwrap(), false)
                    .unwrap(),
            )
            .unwrap();
        assert!(again.is_empty());
        a.discard_entries(&[]).unwrap();
    }
}
