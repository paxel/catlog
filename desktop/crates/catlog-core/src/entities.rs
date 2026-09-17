//! Cats and Clowders as things that move, meet, merge and leave: Moves
//! and Strays, positions on the map, family relations derived from
//! Mother and birth date, deletion, and Merge of two records of the
//! same real thing.

use crate::Result;
use crate::catalog::{Catalog, EntityView};
use crate::entry::Entry;
use crate::error::Error;
use crate::keys;

/// One arrival or departure in a Clowder's combined timeline.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ClowderEvent {
    /// The underlying membership entry on the Cat.
    pub entry: Entry,
    pub cat: String,
    /// True: the cat arrived here. False: it left.
    pub arrived: bool,
    /// Where from (on arrival) or where to (on departure); none = Stray.
    pub counterpart: Option<String>,
}

/// What a position entry records: a live sighting, or where a
/// missing-cat flier hangs. Flier positions never render as sighting
/// pins.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PositionKind {
    Sighting,
    Flier,
}

/// One live plan: the newest, by append order, entry of an (entity,
/// field) pair is reminder-flagged with a value.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ActiveReminder {
    pub entity: String,
    pub field: String,
    pub value: String,
    pub entry: Entry,
}

/// Family relations, all derived from the Mother reference plus birth
/// date: littermates share mother and birth date, siblings share only
/// the mother, kittens name this cat as mother or father.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct Family {
    pub mother: Option<String>,
    pub father: Option<String>,
    pub littermates: Vec<String>,
    pub siblings: Vec<String>,
    pub kittens: Vec<String>,
}

/// The key of the built-in Position starter field ("lat,lon").
pub const POSITION_KEY: &str = "f:position";

/// The kind marker of a position value; plain "lat,lon" is a sighting.
/// Flier positions are stored as "lat,lon@flier".
pub fn parse_position_kind(value: &str) -> PositionKind {
    if value.ends_with("@flier") {
        PositionKind::Flier
    } else {
        PositionKind::Sighting
    }
}

/// Parses a "lat,lon" value (with or without a "@kind" suffix); none
/// for absent or malformed input.
pub fn parse_position(value: Option<&str>) -> Option<(f64, f64)> {
    let value = value?;
    let value = value.split('@').next().unwrap_or(value);
    let (lat, lon) = value.split_once(',')?;
    let lat: f64 = lat.trim().parse().ok()?;
    let lon: f64 = lon.trim().parse().ok()?;
    if !(-90.0..=90.0).contains(&lat) || !(-180.0..=180.0).contains(&lon) {
        return None;
    }
    Some((lat, lon))
}

/// A number the way Dart prints a double: no trailing ".0" is kept
/// (`51.34`), a whole number keeps one (`51.0`).
fn dart_double(v: f64) -> String {
    if v.fract() == 0.0 && v.abs() < 1e15 {
        format!("{v:.1}")
    } else {
        format!("{v}")
    }
}

impl Catalog {
    /// The Clowder a Stray last lived in: the home it ran from. None for
    /// a Cat that never had one.
    pub fn former_clowder(&self, cat: &str) -> Result<Option<String>> {
        for e in self.field_history(cat, keys::CLOWDER, false)? {
            if let Some(v) = e.value {
                return Ok(Some(self.resolve_entity(&v)?));
            }
        }
        Ok(None)
    }

    /// Cats currently in no Clowder.
    pub fn strays(&self) -> Result<Vec<EntityView>> {
        let mut out = Vec::new();
        for view in self.cats(None)? {
            if self.current(&view.id, keys::CLOWDER)?.is_none() {
                out.push(view);
            }
        }
        Ok(out)
    }

    /// A Cat arriving in or leaving a Clowder, derived from the Cats'
    /// membership histories, newest first.
    pub fn clowder_occupancy(&self, clowder: &str) -> Result<Vec<ClowderEvent>> {
        let target = self.resolve_entity(clowder)?;
        let mut events = Vec::new();
        let merged = self.merge_losers()?;
        for cat in self.entities_with_field(keys::CLOWDER)? {
            if merged.contains(&cat) {
                continue;
            }
            let history = self.field_history(&cat, keys::CLOWDER, false)?;
            let mut prev: Option<String> = None;
            for e in history.into_iter().rev() {
                let value = match &e.value {
                    Some(v) => Some(self.resolve_entity(v)?),
                    None => None,
                };
                if value.as_deref() == Some(&target) && prev.as_deref() != Some(&target) {
                    events.push(ClowderEvent {
                        entry: e,
                        cat: cat.clone(),
                        arrived: true,
                        counterpart: prev.clone(),
                    });
                } else if prev.as_deref() == Some(&target) && value.as_deref() != Some(&target) {
                    events.push(ClowderEvent {
                        entry: e,
                        cat: cat.clone(),
                        arrived: false,
                        counterpart: value.clone(),
                    });
                }
                prev = value;
            }
        }
        events.sort_by(|a, b| b.entry.date.cmp(&a.entry.date));
        Ok(events)
    }

    /// An entity's current position, parsed from the Position field.
    pub fn position_of(&self, entity: &str) -> Result<Option<(f64, f64)>> {
        Ok(parse_position(
            self.current(entity, POSITION_KEY)?.as_deref(),
        ))
    }

    /// The latest sighting position: flier positions never become
    /// sighting pins.
    pub fn sighting_position_of(&self, entity: &str) -> Result<Option<(f64, f64)>> {
        for e in self.field_history(entity, POSITION_KEY, false)? {
            let value = e.value.unwrap_or_default();
            if parse_position_kind(&value) != PositionKind::Sighting {
                continue;
            }
            if let Some(pos) = parse_position(Some(&value)) {
                return Ok(Some(pos));
            }
        }
        Ok(None)
    }

    /// All flier positions ever recorded on the entity, newest first.
    pub fn flier_positions(&self, entity: &str) -> Result<Vec<(f64, f64)>> {
        let mut out = Vec::new();
        for e in self.field_history(entity, POSITION_KEY, false)? {
            let value = e.value.unwrap_or_default();
            if parse_position_kind(&value) == PositionKind::Flier
                && let Some(pos) = parse_position(Some(&value))
            {
                out.push(pos);
            }
        }
        Ok(out)
    }

    /// Records a position; sightings are stored plain, fliers carry
    /// their marker.
    pub fn record_position(
        &mut self,
        entity: &str,
        lat: f64,
        lon: f64,
        kind: PositionKind,
        date: Option<&str>,
    ) -> Result<()> {
        let value = match kind {
            PositionKind::Sighting => format!("{},{}", dart_double(lat), dart_double(lon)),
            PositionKind::Flier => format!("{},{}@flier", dart_double(lat), dart_double(lon)),
        };
        self.append_at(entity, POSITION_KEY, Some(&value), date, false)
    }

    /// Cats whose current name or Remarks contain `query`, case-insensitive.
    pub fn search_cats(&self, query: &str) -> Result<Vec<EntityView>> {
        let q = query.trim().to_lowercase();
        if q.is_empty() {
            return Ok(Vec::new());
        }
        let mut out = Vec::new();
        for view in self.cats(None)? {
            let remarks = self
                .current(&view.id, &keys::user_field("remarks"))?
                .unwrap_or_default();
            if view.name.to_lowercase().contains(&q) || remarks.to_lowercase().contains(&q) {
                out.push(view);
            }
        }
        Ok(out)
    }

    /// Family relations of a Cat.
    pub fn family(&self, cat: &str) -> Result<Family> {
        let id = self.resolve_entity(cat)?;
        let reference = |entity: &str, field: &str| -> Result<Option<String>> {
            match self.current(entity, field)? {
                Some(v) => Ok(Some(self.resolve_entity(&v)?)),
                None => Ok(None),
            }
        };
        let mut family = Family {
            mother: reference(&id, "f:mother")?,
            father: reference(&id, "f:father")?,
            ..Default::default()
        };
        let birth = self.current(&id, "f:birthdate")?;
        for c in self.cats(None)? {
            let cid = self.resolve_entity(&c.id)?;
            if cid == id {
                continue;
            }
            let m = reference(&cid, "f:mother")?;
            if m.as_deref() == Some(&id) || reference(&cid, "f:father")?.as_deref() == Some(&id) {
                family.kittens.push(cid);
                continue;
            }
            if family.mother.is_some() && m == family.mother {
                if birth.is_some() && self.current(&cid, "f:birthdate")? == birth {
                    family.littermates.push(cid);
                } else {
                    family.siblings.push(cid);
                }
            }
        }
        Ok(family)
    }

    /// Deletes a Cat: hidden from every list, its photos' bytes dropped.
    pub fn delete_cat(&mut self, cat: &str) -> Result<()> {
        for hash in self.images(cat)? {
            self.delete_image(cat, &hash)?;
        }
        self.append(cat, keys::DELETED, Some("true"))
    }

    /// Undoes a deletion: the entity is visible again, and its photos
    /// come back for every blob still present.
    pub fn restore_entity(&mut self, id: &str) -> Result<()> {
        let entity = self.resolve_entity(id)?;
        self.append(&entity, keys::DELETED, None)?;
        for (field, value) in self.current_fields(&entity)? {
            let Some(hash) = field.strip_prefix(keys::IMAGE_PREFIX) else {
                continue;
            };
            if value.as_deref() != Some("deleted") {
                continue;
            }
            if self.image_bytes(hash).is_some() {
                self.append(&entity, &field, Some("added"))?;
            }
        }
        Ok(())
    }

    /// Deletes a Clowder. Its Cats are not deleted with it: they fall
    /// out as Strays.
    pub fn delete_clowder(&mut self, clowder: &str) -> Result<()> {
        for cat in self.cats(Some(clowder))? {
            self.move_cat(&cat.id, None)?;
        }
        self.append(clowder, keys::DELETED, Some("true"))
    }

    /// The live plans: for every (entity, field) pair whose newest entry
    /// by append order is reminder-flagged with a value, one reminder,
    /// earliest due first.
    pub fn active_reminders(&self) -> Result<Vec<ActiveReminder>> {
        let rows = self.select_live_by_append()?;
        let mut newest: std::collections::HashMap<(String, String), Entry> =
            std::collections::HashMap::new();
        for e in rows {
            if !(e.entity.starts_with("cat:") || e.entity.starts_with("clowder:")) {
                continue;
            }
            let key = (
                self.resolve_entity(&e.entity)?,
                self.canonical_key(&e.field)?,
            );
            newest.entry(key).or_insert(e);
        }
        let mut result = Vec::new();
        for ((entity, field), e) in newest {
            if e.reminder
                && let Some(value) = e.value.clone()
                && !self.is_deleted(&entity)?
            {
                result.push(ActiveReminder {
                    entity,
                    field,
                    value,
                    entry: e,
                });
            }
        }
        result.sort_by(|a, b| a.entry.date.cmp(&b.entry.date));
        Ok(result)
    }

    /// Merges two Cats: `loser` folds into `survivor`, irreversibly. The
    /// survivor re-asserts its current values so they win the combined
    /// projection; loser values fill only gaps.
    pub fn merge_cat(&mut self, loser: &str, survivor: &str) -> Result<()> {
        self.merge(loser, survivor, "cat:", true)
    }

    /// Merges two Clowders; membership pointing at the loser resolves to
    /// the survivor.
    pub fn merge_clowder(&mut self, loser: &str, survivor: &str) -> Result<()> {
        self.merge(loser, survivor, "clowder:", true)
    }

    /// Merges two Field definitions; values recorded under either key
    /// read as the survivor's field from now on.
    pub fn merge_field(&mut self, loser: &str, survivor: &str) -> Result<()> {
        if self.current(loser, keys::FIELD_TYPE)?.is_none()
            || self.current(survivor, keys::FIELD_TYPE)?.is_none()
        {
            return Err(Error::Invalid(format!(
                "Not field definitions: {loser}, {survivor}"
            )));
        }
        self.merge(loser, survivor, "fielddef:", false)
    }

    fn merge(&mut self, loser: &str, survivor: &str, prefix: &str, reassert: bool) -> Result<()> {
        if !loser.starts_with(prefix) || !survivor.starts_with(prefix) {
            return Err(Error::Invalid(format!(
                "Merge partners must both be {prefix}entities"
            )));
        }
        if loser == survivor {
            return Err(Error::Invalid("Cannot merge an entity into itself".into()));
        }
        if self.resolve_entity(survivor)? == loser || self.merge_losers()?.contains(loser) {
            return Err(Error::Invalid(
                "Merge would create a cycle or re-merge a loser".into(),
            ));
        }
        if reassert {
            let survivor_fields = self.current_fields(survivor)?;
            let loser_fields = self.current_fields(loser)?;
            let survivor_canonical = self.resolve_entity(survivor)?;
            let pair_plans: Vec<ActiveReminder> = self
                .active_reminders()?
                .into_iter()
                .filter(|r| r.entity == survivor_canonical || r.entity == loser)
                .collect();
            let mut reasserted = std::collections::HashSet::new();
            for (key, value) in &survivor_fields {
                if key == keys::TYPE || key == keys::DELETED || key.starts_with(keys::IMAGE_PREFIX)
                {
                    continue;
                }
                let Some(theirs) = loser_fields.get(key) else {
                    continue;
                };
                if theirs == value {
                    continue;
                }
                self.append(survivor, key, value.as_deref())?;
                reasserted.insert(key.clone());
            }
            for r in pair_plans {
                if !reasserted.contains(&r.field) {
                    continue;
                }
                self.append_at(
                    survivor,
                    &r.field,
                    Some(&r.value),
                    Some(&r.entry.date),
                    true,
                )?;
            }
        }
        self.append(loser, keys::MERGED_INTO, Some(survivor))
    }

    /// Takes entries from another Catalog as this device's own: the
    /// same facts, authors and dates, under fresh numbers of this device.
    pub fn adopt_entries(&mut self, entries: &[Entry]) -> Result<()> {
        let device = self.device_id();
        let first = self.next_dseq(&device)?;
        for (next, e) in (first..).zip(entries) {
            self.insert_own(
                &device,
                next,
                &e.entity,
                &e.field,
                e.value.as_deref(),
                &crate::entry::iso(&e.date),
                &e.author,
                &crate::entry::iso(&e.recorded),
                e.reminder,
            )?;
        }
        Ok(())
    }
}

/// What a Transfer did, for the message afterwards.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct TransferResult {
    /// The entities that arrived, by their canonical id.
    pub moved: Vec<String>,
    pub photos: usize,
}

/// Takes Cats, or Clowders with the Cats living in them, out of one
/// Catalog and into another. Not a Move: it crosses Catalogs and
/// re-stamps the entries under the destination's device, so the two
/// Catalogs can never re-merge through a shared sync partner. In the
/// Catalog it left, the entity is deleted the ordinary way.
pub fn transfer_entities(
    from: &mut Catalog,
    to: &mut Catalog,
    ids: &[&str],
) -> Result<TransferResult> {
    let mut wanted: Vec<String> = Vec::new();
    for id in ids {
        let canonical = from.resolve_entity(id)?;
        if !wanted.contains(&canonical) {
            wanted.push(canonical.clone());
        }
        if from.current(&canonical, keys::TYPE)?.as_deref() == Some(keys::KIND_CLOWDER) {
            for cat in from.cats(Some(&canonical))? {
                let c = from.resolve_entity(&cat.id)?;
                if !wanted.contains(&c) {
                    wanted.push(c);
                }
            }
        }
    }
    if wanted.is_empty() {
        return Ok(TransferResult {
            moved: Vec::new(),
            photos: 0,
        });
    }
    // Field definitions come along only where the destination has none
    // of its own.
    let known: std::collections::HashSet<String> =
        to.field_defs(None)?.into_iter().map(|d| d.id).collect();
    let defs: std::collections::HashSet<String> = from
        .field_defs(None)?
        .into_iter()
        .map(|d| d.id)
        .filter(|id| !known.contains(id))
        .collect();
    let mut entries = Vec::new();
    for e in from.entries_since(&std::collections::BTreeMap::new(), true)? {
        if wanted.contains(&from.resolve_entity(&e.entity)?) || defs.contains(&e.entity) {
            entries.push(e);
        }
    }
    // Photos first: a failure here leaves bytes nothing refers to.
    let mut photos = 0;
    for id in &wanted {
        for hash in from.images(id)? {
            let Some(bytes) = from.image_bytes(&hash) else {
                continue;
            };
            if to.image_bytes(&hash).is_some() {
                continue;
            }
            to.put_blob(&hash, &bytes)?;
            photos += 1;
        }
    }
    to.adopt_entries(&entries)?;
    // A cat whose clowder did not come along has no home over there.
    for id in &wanted {
        if to.current(id, keys::TYPE)?.as_deref() != Some(keys::KIND_CAT) {
            continue;
        }
        let Some(clowder) = to.current(id, keys::CLOWDER)?.filter(|c| !c.is_empty()) else {
            continue;
        };
        if wanted.contains(&to.resolve_entity(&clowder)?) {
            continue;
        }
        to.move_cat(id, None)?;
    }
    for id in &wanted {
        if from.current(id, keys::TYPE)?.as_deref() == Some(keys::KIND_CLOWDER) {
            from.delete_clowder(id)?;
        } else {
            from.delete_cat(id)?;
        }
    }
    Ok(TransferResult {
        moved: wanted,
        photos,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    fn catalog(name: &str, dir: &std::path::Path) -> Catalog {
        let c = Catalog::open_with_device(&dir.join(name), name).unwrap();
        c.set_author("Ada").unwrap();
        c
    }

    #[test]
    fn positions_parse_and_print_like_the_phones() {
        assert_eq!(parse_position(Some("51.34, 12.37")), Some((51.34, 12.37)));
        assert_eq!(
            parse_position(Some("51.34,12.37@flier")),
            Some((51.34, 12.37))
        );
        assert_eq!(parse_position(Some("91,0")), None);
        assert_eq!(parse_position(Some("x")), None);
        assert_eq!(parse_position(Some("1,2,3")), None);
        assert_eq!(parse_position(None), None);
        assert_eq!(parse_position_kind("1,2@flier"), PositionKind::Flier);
        assert_eq!(parse_position_kind("1,2"), PositionKind::Sighting);
        assert_eq!(dart_double(51.0), "51.0");
        assert_eq!(dart_double(51.34), "51.34");
    }

    #[test]
    fn moves_strays_positions_and_occupancy() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = catalog("me", dir.path());
        c.create_clowder("clowder:h", "Home").unwrap();
        c.create_clowder("clowder:f", "Forever").unwrap();
        c.create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        assert_eq!(
            c.former_clowder("cat:a").unwrap().as_deref(),
            Some("clowder:h")
        );
        c.move_cat("cat:a", None).unwrap();
        assert_eq!(c.strays().unwrap().len(), 1);
        assert_eq!(
            c.former_clowder("cat:a").unwrap().as_deref(),
            Some("clowder:h")
        );
        c.record_position("cat:a", 51.34, 12.37, PositionKind::Sighting, None)
            .unwrap();
        c.record_position("cat:a", 51.0, 12.0, PositionKind::Flier, None)
            .unwrap();
        assert_eq!(c.position_of("cat:a").unwrap(), Some((51.0, 12.0)));
        assert_eq!(
            c.sighting_position_of("cat:a").unwrap(),
            Some((51.34, 12.37))
        );
        assert_eq!(c.flier_positions("cat:a").unwrap(), vec![(51.0, 12.0)]);
        c.move_cat("cat:a", Some("clowder:f")).unwrap();
        assert!(c.strays().unwrap().is_empty());
        let events = c.clowder_occupancy("clowder:h").unwrap();
        assert_eq!(events.len(), 2);
        assert!(!events[0].arrived && events[0].counterpart.is_none());
        assert!(events[1].arrived && events[1].counterpart.is_none());
        let forever = c.clowder_occupancy("clowder:f").unwrap();
        assert_eq!(
            (
                forever.len(),
                forever[0].arrived,
                forever[0].counterpart.as_deref()
            ),
            (1, true, None)
        );
        c.create_cat("cat:z", "Zorro", None, "cat").unwrap();
        assert_eq!(c.former_clowder("cat:z").unwrap(), None);
        assert_eq!(c.sighting_position_of("cat:z").unwrap(), None);
        c.append("cat:z", "f:remarks", Some("Very SHY")).unwrap();
        assert_eq!(c.search_cats("shy").unwrap().len(), 1);
        assert_eq!(c.search_cats("mie").unwrap().len(), 1);
        assert!(c.search_cats("  ").unwrap().is_empty());
    }

    #[test]
    fn family_is_derived_from_mother_and_birth_date() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = catalog("me", dir.path());
        for (id, name) in [
            ("cat:mom", "Mom"),
            ("cat:dad", "Dad"),
            ("cat:a", "A"),
            ("cat:b", "B"),
            ("cat:c", "C"),
            ("cat:x", "X"),
        ] {
            c.create_cat(id, name, None, "cat").unwrap();
        }
        for id in ["cat:a", "cat:b", "cat:c"] {
            c.append(id, "f:mother", Some("cat:mom")).unwrap();
        }
        c.append("cat:a", "f:father", Some("cat:dad")).unwrap();
        c.append("cat:a", "f:birthdate", Some("2024-05-01"))
            .unwrap();
        c.append("cat:b", "f:birthdate", Some("2024-05-01"))
            .unwrap();
        c.append("cat:c", "f:birthdate", Some("2023-01-01"))
            .unwrap();
        let f = c.family("cat:a").unwrap();
        assert_eq!(
            (f.mother.as_deref(), f.father.as_deref()),
            (Some("cat:mom"), Some("cat:dad"))
        );
        assert_eq!(f.littermates, vec!["cat:b"]);
        assert_eq!(f.siblings, vec!["cat:c"]);
        assert!(f.kittens.is_empty());
        let mom = c.family("cat:mom").unwrap();
        assert_eq!(mom.kittens.len(), 3);
        assert_eq!(c.family("cat:dad").unwrap().kittens, vec!["cat:a"]);
        assert_eq!(c.family("cat:x").unwrap(), Family::default());
    }

    #[test]
    fn deleting_and_restoring_entities() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = catalog("me", dir.path());
        c.create_clowder("clowder:h", "Home").unwrap();
        c.create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        let hash = c.add_image("cat:a", b"photo").unwrap();
        c.delete_cat("cat:a").unwrap();
        assert!(c.cats(None).unwrap().is_empty());
        assert!(c.is_deleted("cat:a").unwrap());
        assert!(c.image_bytes(&hash).is_none());
        c.restore_entity("cat:a").unwrap();
        assert_eq!(c.cats(None).unwrap().len(), 1);
        assert!(
            c.images("cat:a").unwrap().is_empty(),
            "the bytes are gone for good"
        );
        // With the bytes back, a restore brings the photo back too.
        c.put_blob(&hash, b"photo").unwrap();
        c.delete_cat("cat:a").unwrap();
        c.put_blob(&hash, b"photo").unwrap();
        c.restore_entity("cat:a").unwrap();
        assert_eq!(c.images("cat:a").unwrap(), vec![hash]);
        c.delete_clowder("clowder:h").unwrap();
        assert!(c.clowders().unwrap().is_empty());
        assert_eq!(c.strays().unwrap().len(), 1);
    }

    #[test]
    fn merges_keep_the_survivor_values_and_fold_the_loser() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = catalog("me", dir.path());
        c.set_clock(crate::corpus::fixed_clock());
        c.create_clowder("clowder:h", "Home").unwrap();
        c.create_clowder("clowder:h2", "Home again").unwrap();
        c.create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        c.create_cat("cat:b", "Mietzi", Some("clowder:h2"), "cat")
            .unwrap();
        c.append("cat:a", "f:color", Some("black")).unwrap();
        c.append("cat:b", "f:color", Some("white")).unwrap();
        c.append("cat:b", "f:remarks", Some("loser only")).unwrap();
        c.append_at(
            "cat:a",
            "f:color",
            Some("vet check"),
            Some("2027-01-01T00:00:00Z"),
            true,
        )
        .unwrap();
        c.merge_cat("cat:b", "cat:a").unwrap();
        assert_eq!(c.cats(None).unwrap().len(), 1);
        assert_eq!(
            c.current("cat:a", "f:color").unwrap().as_deref(),
            Some("black")
        );
        assert_eq!(
            c.current("cat:b", "f:remarks").unwrap().as_deref(),
            Some("loser only")
        );
        assert_eq!(c.resolve_entity("cat:b").unwrap(), "cat:a");
        let plans = c.active_reminders().unwrap();
        assert_eq!(plans.len(), 1);
        assert_eq!(
            (plans[0].entity.as_str(), plans[0].value.as_str()),
            ("cat:a", "vet check")
        );
        assert!(
            c.merge_cat("cat:b", "cat:a").is_err(),
            "a loser cannot merge twice"
        );
        assert!(c.merge_cat("cat:a", "cat:b").is_err(), "no cycles");
        assert!(c.merge_cat("cat:a", "cat:a").is_err());
        assert!(c.merge_cat("cat:a", "clowder:h").is_err());
        c.merge_clowder("clowder:h2", "clowder:h").unwrap();
        assert_eq!(c.clowders().unwrap().len(), 1);
        assert_eq!(
            c.current("cat:a", keys::CLOWDER).unwrap().as_deref(),
            Some("clowder:h")
        );
        // Field definitions merge too: values under the loser key read
        // under the survivor's.
        c.define_field(
            "Colour",
            crate::fields::FieldType::Text,
            crate::fields::FieldScope::Cat,
            &[],
            crate::fields::IdDisplay::Plain,
            None,
            None,
        )
        .unwrap();
        c.append("cat:a", "f:colour", Some("under the loser key"))
            .unwrap();
        c.merge_field("fielddef:colour", "fielddef:color").unwrap();
        assert!(c.merge_field("fielddef:nope", "fielddef:color").is_err());
        assert_eq!(c.canonical_key("f:colour").unwrap(), "f:color");
        assert_eq!(c.field_history("cat:a", "f:color", false).unwrap().len(), 6);
        // A deleted entity's plan is no plan.
        c.delete_cat("cat:a").unwrap();
        assert!(c.active_reminders().unwrap().is_empty());
    }

    #[test]
    fn a_transfer_restamps_rows_and_deletes_at_the_source() {
        let dir = tempfile::tempdir().unwrap();
        let mut from = catalog("from", dir.path());
        let mut to = catalog("to", dir.path());
        from.create_clowder("clowder:h", "Home").unwrap();
        from.create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        from.create_cat("cat:b", "Tom", Some("clowder:h"), "cat")
            .unwrap();
        from.create_cat("cat:c", "Alone", None, "cat").unwrap();
        from.define_field(
            "Mood",
            crate::fields::FieldType::Text,
            crate::fields::FieldScope::Cat,
            &[],
            crate::fields::IdDisplay::Plain,
            None,
            None,
        )
        .unwrap();
        from.append("cat:a", "f:mood", Some("calm")).unwrap();
        let hash = from.add_image("cat:a", b"photo").unwrap();
        // The cat alone moves without its clowder and arrives a Stray.
        let r = transfer_entities(&mut from, &mut to, &["cat:c"]).unwrap();
        assert_eq!((r.moved.len(), r.photos), (1, 0));
        assert_eq!(to.strays().unwrap()[0].name, "Alone");
        assert!(from.is_deleted("cat:c").unwrap());
        // The clowder takes its cats, the mood definition comes along
        // once, photos travel, every row is the destination's own.
        let r = transfer_entities(&mut from, &mut to, &["clowder:h"]).unwrap();
        assert_eq!((r.moved.len(), r.photos), (3, 1));
        assert_eq!(to.cats(Some("clowder:h")).unwrap().len(), 2);
        assert_eq!(
            to.current("cat:a", "f:mood").unwrap().as_deref(),
            Some("calm")
        );
        assert_eq!(to.image_bytes(&hash).as_deref(), Some(&b"photo"[..]));
        assert!(to.field_def("mood").unwrap().is_some());
        assert!(to.all_entries().unwrap().iter().all(|e| e.device == "to"));
        assert!(from.clowders().unwrap().is_empty() && from.cats(None).unwrap().is_empty());
        assert_eq!(
            transfer_entities(&mut from, &mut to, &[])
                .unwrap()
                .moved
                .len(),
            0
        );
    }
}
