//! What an import brought, sorted for the "What arrived" summary: new
//! Cats and Clowders, updated ones with what changed, ones a partner
//! deleted, conflicts raised, and the smaller things on the side.

use std::collections::{BTreeMap, BTreeSet};

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::keys;
use crate::signing::ImportReport;

/// One Field's change on an entity.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FieldChange {
    pub field: String,
    pub before: Option<String>,
    pub after: Option<String>,
}

impl FieldChange {
    pub fn is_photo(&self) -> bool {
        self.field.starts_with(keys::IMAGE_PREFIX)
    }
}

/// A Cat or Clowder the import touched.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct EntityArrival {
    pub id: String,
    pub is_new: bool,
    pub changes: Vec<FieldChange>,
    /// `adopted`, `deceased`, `escaped`.
    pub tags: BTreeSet<String>,
    pub entries: Vec<Entry>,
}

impl EntityArrival {
    pub fn is_cat(&self) -> bool {
        self.id.starts_with("cat:")
    }
}

/// The smaller things: Fields and merges, mode, photos.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum MetaChange {
    FieldAdded(String),
    FieldChanged(String),
    FieldMerged(String, String),
    Merged(String, String),
    Mode,
    Photos(usize),
}

pub const TAG_ADOPTED: &str = "adopted";
pub const TAG_DECEASED: &str = "deceased";
pub const TAG_ESCAPED: &str = "escaped";

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct ImportReview {
    pub new_ones: Vec<EntityArrival>,
    pub updated: Vec<EntityArrival>,
    /// Cats and homes you have that a partner deleted.
    pub deleted: Vec<EntityArrival>,
    pub conflicts: Vec<(String, String)>,
    pub meta: Vec<MetaChange>,
    pub report: ImportReport,
}

impl ImportReview {
    pub fn is_empty(&self) -> bool {
        self.new_ones.is_empty()
            && self.updated.is_empty()
            && self.deleted.is_empty()
            && self.conflicts.is_empty()
            && self.meta.is_empty()
            && !needs_attention(&self.report)
    }

    fn tagged(&self, tag: &str) -> Vec<String> {
        self.updated
            .iter()
            .filter(|a| a.tags.contains(tag))
            .map(|a| a.id.clone())
            .collect()
    }

    pub fn adopted(&self) -> Vec<String> {
        self.tagged(TAG_ADOPTED)
    }

    pub fn deceased(&self) -> Vec<String> {
        self.tagged(TAG_DECEASED)
    }

    pub fn escaped(&self) -> Vec<String> {
        self.tagged(TAG_ESCAPED)
    }
}

/// True when the report carries something a keeper should read.
pub fn needs_attention(report: &ImportReport) -> bool {
    !report.refused.is_empty() || !report.impostors.is_empty() || !report.changed_keys.is_empty()
}

fn is_marker(field: &str) -> bool {
    field == keys::TYPE
        || field == keys::DELETED
        || field == keys::MERGED_INTO
        || field == keys::PRIVATE
        || field == keys::PROFILE_IMAGE
        || field.starts_with(keys::PRIVATE_PREFIX)
        || field.starts_with(keys::WITHHELD_PREFIX)
        || field.starts_with(keys::CONFLICT_PREFIX)
}

/// The Catalog's own settings entity, whose `mode` says cats or pets.
fn is_catalog_setting(entity: &str) -> bool {
    entity.starts_with("catalog:")
}

/// Sorts what `applied` brought into the summary's sections.
pub fn review_import(
    store: &Catalog,
    applied: &[Entry],
    report: ImportReport,
) -> Result<ImportReview> {
    let arrived: BTreeSet<(String, i64)> =
        applied.iter().map(|e| (e.device.clone(), e.dseq)).collect();
    let is_arrived = |e: &Entry| arrived.contains(&(e.device.clone(), e.dseq));
    let mut by_entity: BTreeMap<String, Vec<Entry>> = BTreeMap::new();
    for e in applied {
        by_entity
            .entry(store.resolve_entity(&e.entity)?)
            .or_default()
            .push(e.clone());
    }
    let mut review = ImportReview {
        report,
        ..Default::default()
    };
    let mut photos = 0usize;

    let new_here = |entity: &str| -> Result<bool> {
        Ok(!store
            .field_history(entity, keys::TYPE, false)?
            .iter()
            .any(|e| !is_arrived(e)))
    };
    let before = |entity: &str, field: &str| -> Result<Option<String>> {
        Ok(store
            .field_history(entity, field, false)?
            .into_iter()
            .find(|e| !e.reminder && !is_arrived(e))
            .and_then(|e| e.value))
    };
    let effective = |entity: &str, entries: &[Entry], is_new: bool| -> Result<Vec<FieldChange>> {
        let fields: BTreeSet<&str> = entries.iter().map(|e| e.field.as_str()).collect();
        let mut changes = Vec::new();
        for field in fields {
            if is_marker(field) {
                continue;
            }
            let after = store.current(entity, field)?;
            let was = if is_new { None } else { before(entity, field)? };
            if !is_new && was == after {
                continue;
            }
            changes.push(FieldChange {
                field: field.to_string(),
                before: was,
                after,
            });
        }
        Ok(changes)
    };

    for (entity, entries) in &by_entity {
        if is_catalog_setting(entity) {
            if effective(entity, entries, false)?
                .iter()
                .any(|c| c.field == "mode")
            {
                review.meta.push(MetaChange::Mode);
            }
            continue;
        }
        let kind = store.current(entity, keys::TYPE)?;
        let is_new = new_here(entity)?;
        let merged_into = entries
            .iter()
            .rfind(|e| e.field == keys::MERGED_INTO && e.value.is_some())
            .and_then(|e| e.value.clone());
        if entity.starts_with(&format!("{}:", keys::KIND_FIELD_DEF))
            || kind.as_deref() == Some(keys::KIND_FIELD_DEF)
        {
            if let Some(target) = merged_into {
                review
                    .meta
                    .push(MetaChange::FieldMerged(entity.clone(), target));
            } else if is_new {
                review.meta.push(MetaChange::FieldAdded(entity.clone()));
            } else if !effective(entity, entries, false)?.is_empty() {
                review.meta.push(MetaChange::FieldChanged(entity.clone()));
            }
            continue;
        }
        if kind.as_deref() != Some(keys::KIND_CAT) && kind.as_deref() != Some(keys::KIND_CLOWDER) {
            continue;
        }
        if store.is_hidden(entity)? {
            continue;
        }
        if let Some(target) = merged_into {
            review.meta.push(MetaChange::Merged(entity.clone(), target));
        }
        if !is_new
            && entries.iter().any(|e| e.field == keys::DELETED)
            && store.current(entity, keys::DELETED)?.as_deref() == Some("true")
            && before(entity, keys::DELETED)?.as_deref() != Some("true")
        {
            review.deleted.push(EntityArrival {
                id: entity.clone(),
                is_new: false,
                changes: Vec::new(),
                tags: BTreeSet::new(),
                entries: entries.clone(),
            });
            continue;
        }
        let changes = effective(entity, entries, is_new)?;
        let mut tags = BTreeSet::new();
        for c in &changes {
            if c.is_photo() {
                if c.after.as_deref() != Some("deleted") {
                    photos += 1;
                }
            } else if c.field == keys::CLOWDER && !is_new {
                match &c.after {
                    None => {
                        tags.insert(TAG_ESCAPED.to_string());
                    }
                    Some(home) => {
                        let home = store.resolve_entity(home)?;
                        if store.current(&home, "f:status")?.as_deref() == Some("forever-home") {
                            tags.insert(TAG_ADOPTED.to_string());
                        }
                    }
                }
            } else if c.field == "f:deceased" && c.after.is_some() && !is_new {
                tags.insert(TAG_DECEASED.to_string());
            }
        }
        let fields: BTreeSet<&str> = entries.iter().map(|e| e.field.as_str()).collect();
        for field in fields {
            let real = field.strip_prefix(keys::CONFLICT_PREFIX).unwrap_or(field);
            let pair = (entity.clone(), real.to_string());
            if store.has_conflict(entity, real)? && !review.conflicts.contains(&pair) {
                review.conflicts.push(pair);
            }
        }
        if is_new {
            review.new_ones.push(EntityArrival {
                id: entity.clone(),
                is_new: true,
                changes,
                tags: BTreeSet::new(),
                entries: entries.clone(),
            });
        } else if !changes.is_empty() {
            review.updated.push(EntityArrival {
                id: entity.clone(),
                is_new: false,
                changes,
                tags,
                entries: entries.clone(),
            });
        }
    }
    if photos > 0 {
        review.meta.push(MetaChange::Photos(photos));
    }
    let name = |a: &EntityArrival| -> String {
        store
            .current(&a.id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_default()
            .to_lowercase()
    };
    review.new_ones.sort_by_key(name);
    review.updated.sort_by_key(name);
    review.deleted.sort_by_key(name);
    Ok(review)
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::path::Path;

    fn fixture(name: &str) -> std::path::PathBuf {
        Path::new(env!("CARGO_MANIFEST_DIR")).join(format!("../../fixtures/{name}/folder"))
    }

    fn imported(dir: &Path, scenario: &str) -> (Catalog, ImportReview) {
        let mut store = Catalog::open(dir).unwrap();
        store.set_author("Reader").unwrap();
        let round = store.import_folder(&fixture(scenario), None).unwrap();
        let review = review_import(&store, &round.applied, round.report).unwrap();
        (store, review)
    }

    #[test]
    fn a_fresh_folder_brings_new_cats_and_homes_and_photos() {
        let dir = tempfile::tempdir().unwrap();
        let (store, review) = imported(dir.path(), "fresh");
        assert!(!review.is_empty());
        assert_eq!(review.new_ones.len(), 5, "three cats, two clowders");
        assert!(review.new_ones.iter().all(|a| a.is_new));
        assert!(review.updated.is_empty());
        assert!(review.deleted.is_empty());
        assert!(review.conflicts.is_empty());
        assert!(review.meta.contains(&MetaChange::Photos(3)));
        let names: Vec<String> = review
            .new_ones
            .iter()
            .map(|a| store.current(&a.id, keys::NAME).unwrap().unwrap())
            .collect();
        let mut sorted = names.clone();
        sorted.sort_by_key(|n| n.to_lowercase());
        assert_eq!(names, sorted, "sorted by name");
        assert!(review.new_ones.iter().any(|a| a.is_cat()));
        assert!(!needs_attention(&review.report));
        // Nothing applied means nothing to say.
        let empty = review_import(&store, &[], ImportReport::default()).unwrap();
        assert!(empty.is_empty());
    }

    #[test]
    fn a_second_round_is_an_update_with_tags_and_a_conflict_is_listed() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Reader").unwrap();
        // The moves scenario in two halves: first the folder, then the
        // reader's own change, then a partner who moved and lost cats.
        let round = store.import_folder(&fixture("moves"), None).unwrap();
        let review = review_import(&store, &round.applied, round.report).unwrap();
        assert!(!review.new_ones.is_empty());
        let (_, conflicts) = imported(&dir.path().join("c"), "conflict");
        assert!(
            !conflicts.conflicts.is_empty(),
            "the conflict scenario raises one"
        );
        // A merge shows on the side.
        let (_, merge) = imported(&dir.path().join("m"), "merge");
        assert!(
            merge
                .meta
                .iter()
                .any(|m| matches!(m, MetaChange::Merged(..)))
        );
        // Fields defined by the partner are meta too.
        let (_, fields) = imported(&dir.path().join("f"), "fields-all");
        assert!(
            fields
                .meta
                .iter()
                .any(|m| matches!(m, MetaChange::FieldAdded(_)))
        );
    }

    #[test]
    fn updates_carry_before_and_after_and_the_tags() {
        let dir = tempfile::tempdir().unwrap();
        let shared = dir.path().join("shared");
        let mut a = Catalog::open(&dir.path().join("a")).unwrap();
        a.set_author("Ada").unwrap();
        let mut b = Catalog::open(&dir.path().join("b")).unwrap();
        b.set_author("Bob").unwrap();
        a.create_clowder("clowder:h", "Forever").unwrap();
        a.append("clowder:h", "f:status", Some("forever-home"))
            .unwrap();
        a.create_cat("cat:x", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        a.create_cat("cat:y", "Tom", None, "cat").unwrap();
        a.create_cat("cat:z", "Gone", None, "cat").unwrap();
        a.sync_folder(&shared, None, false).unwrap();
        b.sync_folder(&shared, None, false).unwrap();
        // Ada: a stray adopted, a cat deceased, a cat deleted, a remark.
        a.append("cat:y", keys::CLOWDER, Some("clowder:h")).unwrap();
        a.append("cat:x", "f:deceased", Some("2026-01-02")).unwrap();
        a.append("cat:x", "f:remarks", Some("missed")).unwrap();
        a.append("cat:z", keys::DELETED, Some("true")).unwrap();
        a.sync_folder(&shared, None, false).unwrap();
        let round = b.sync_folder(&shared, None, false).unwrap();
        let review = review_import(&b, &round.applied, round.report).unwrap();
        assert!(review.new_ones.is_empty());
        assert_eq!(review.adopted(), vec!["cat:y".to_string()]);
        assert_eq!(review.deceased(), vec!["cat:x".to_string()]);
        assert!(review.escaped().is_empty());
        assert_eq!(review.deleted.len(), 1);
        assert_eq!(review.deleted[0].id, "cat:z");
        let miezi = review.updated.iter().find(|a| a.id == "cat:x").unwrap();
        let remark = miezi
            .changes
            .iter()
            .find(|c| c.field == "f:remarks")
            .unwrap();
        assert_eq!(remark.before, None);
        assert_eq!(remark.after.as_deref(), Some("missed"));
        // Escaped: back to the street.
        a.append("cat:y", keys::CLOWDER, None).unwrap();
        a.sync_folder(&shared, None, false).unwrap();
        let round = b.sync_folder(&shared, None, false).unwrap();
        let review = review_import(&b, &round.applied, round.report).unwrap();
        assert_eq!(review.escaped(), vec!["cat:y".to_string()]);
    }
}
