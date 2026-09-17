//! The Catalog: an append-only entry log over SQLite with a latest-wins
//! projection (ADR 0001). Photo bytes live outside the log in a
//! content-addressed directory next to the database.

use std::collections::{BTreeMap, HashMap, HashSet};
use std::path::{Path, PathBuf};

use rusqlite::{Connection, OptionalExtension, params, params_from_iter};
use sha2::{Digest, Sha256};

use crate::Result;
use crate::entry::Entry;
use crate::error::Error;
use crate::keys;
use crate::signing::{
    ImportReport, KeyRecord, KeyTrust, PinnedKey, SigningKey, device_id_from_key, entry_bytes,
    verify_signature,
};

/// A Cat or Clowder as list rows want it: id plus current name.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct EntityView {
    pub id: String,
    pub name: String,
}

/// Deterministic latest-wins ordering (ADR 0001): effective date, then
/// recording time, then author, then origin device and its counter.
const LATEST: &str = "ORDER BY date DESC, recorded DESC, author DESC, device DESC, dseq DESC";

/// SQL: the row is not voided. Appended to every projection query.
const LIVE: &str = "AND NOT EXISTS (SELECT 1 FROM voids \
    WHERE voids.device = entries.device AND voids.dseq = entries.dseq)";

/// Where a Catalog reads the wall clock for what it records.
pub type Clock = Box<dyn Fn() -> chrono::DateTime<chrono::Utc> + Send>;

pub struct Catalog {
    db: Connection,
    images: PathBuf,
    clock: Clock,
}

impl Catalog {
    /// Opens the Catalog in `dir`, creating it when needed: `catalog.db`
    /// and an `images/` directory beside it.
    pub fn open(dir: &Path) -> Result<Catalog> {
        std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
        let images = dir.join("images");
        std::fs::create_dir_all(&images).map_err(|e| Error::io(&images, e))?;
        let db = Connection::open(dir.join("catalog.db"))?;
        Self::init(db, images)
    }

    /// A throwaway Catalog in memory, photos in a temporary directory
    /// that lives as long as the process (tests).
    pub fn in_memory(images: &Path) -> Result<Catalog> {
        std::fs::create_dir_all(images).map_err(|e| Error::io(images, e))?;
        Self::init(Connection::open_in_memory()?, images.to_path_buf())
    }

    fn init(db: Connection, images: PathBuf) -> Result<Catalog> {
        db.execute_batch(
            "PRAGMA journal_mode = WAL;
             CREATE TABLE IF NOT EXISTS entries (
               seq      INTEGER PRIMARY KEY AUTOINCREMENT,
               device   TEXT NOT NULL,
               dseq     INTEGER NOT NULL,
               entity   TEXT NOT NULL,
               field    TEXT NOT NULL,
               value    TEXT,
               date     TEXT NOT NULL,
               author   TEXT NOT NULL,
               recorded TEXT NOT NULL,
               reminder INTEGER NOT NULL DEFAULT 0,
               sig      TEXT
             );
             CREATE TABLE IF NOT EXISTS local_settings (
               key   TEXT PRIMARY KEY,
               value TEXT NOT NULL
             );
             CREATE TABLE IF NOT EXISTS moments (
               id    INTEGER PRIMARY KEY AUTOINCREMENT,
               seq   INTEGER NOT NULL,
               cause TEXT NOT NULL,
               label TEXT,
               at    TEXT NOT NULL
             );
             CREATE TABLE IF NOT EXISTS voids (
               device TEXT NOT NULL,
               dseq   INTEGER NOT NULL,
               PRIMARY KEY (device, dseq)
             );
             CREATE UNIQUE INDEX IF NOT EXISTS idx_entries_device_dseq
               ON entries (device, dseq);
             CREATE INDEX IF NOT EXISTS idx_entries_entity_field
               ON entries (entity, field);",
        )?;
        let catalog = Catalog {
            db,
            images,
            clock: Box::new(chrono::Utc::now),
        };
        catalog.ensure_device_id()?;
        catalog.rebuild_voids()?;
        catalog.ensure_signing_key()?;
        Ok(catalog)
    }

    /// Opens a Catalog whose signing key, and with it its device id, is
    /// fixed instead of random: the fixture corpus and tests need a
    /// reproducible log. An existing Catalog keeps what it has.
    pub fn open_with_seed(dir: &Path, seed: [u8; 32]) -> Result<Catalog> {
        let key = SigningKey::from_seed(seed);
        std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
        let db = Connection::open(dir.join("catalog.db"))?;
        db.execute_batch(
            "CREATE TABLE IF NOT EXISTS local_settings (key TEXT PRIMARY KEY, value TEXT NOT NULL)",
        )?;
        db.execute(
            "INSERT OR IGNORE INTO local_settings (key, value) VALUES ('device', ?1), ('signseed', ?2), ('signsince', '1')",
            params![device_id_from_key(&key.public_key()), key.seed_hex()],
        )?;
        drop(db);
        Self::open(dir)
    }

    /// Opens a Catalog whose device id is fixed instead of random: the
    /// fixture corpus and tests need a reproducible log. An existing
    /// Catalog keeps the id it has.
    pub fn open_with_device(dir: &Path, device: &str) -> Result<Catalog> {
        std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
        let db = Connection::open(dir.join("catalog.db"))?;
        db.execute_batch(
            "CREATE TABLE IF NOT EXISTS local_settings (key TEXT PRIMARY KEY, value TEXT NOT NULL)",
        )?;
        db.execute(
            "INSERT OR IGNORE INTO local_settings (key, value) VALUES ('device', ?1)",
            [device],
        )?;
        drop(db);
        Self::open(dir)
    }

    /// Swaps the wall clock the Catalog stamps its own rows with.
    pub fn set_clock(&mut self, clock: Clock) {
        self.clock = clock;
    }

    fn now(&self) -> String {
        (self.clock)().to_rfc3339_opts(chrono::SecondsFormat::Micros, true)
    }

    // ------------------------------------------------------------ settings

    fn raw_setting(&self, key: &str) -> Result<Option<String>> {
        Ok(self
            .db
            .query_row(
                "SELECT value FROM local_settings WHERE key = ?1",
                [key],
                |r| r.get(0),
            )
            .optional()?)
    }

    fn raw_set(&self, key: &str, value: &str) -> Result<()> {
        self.db.execute(
            "INSERT OR REPLACE INTO local_settings (key, value) VALUES (?1, ?2)",
            [key, value],
        )?;
        Ok(())
    }

    /// A new Catalog's device id is derived from its signing key, made
    /// here and now; a Catalog from before keeps its id and gets its key
    /// in [`Catalog::ensure_signing_key`].
    fn ensure_device_id(&self) -> Result<()> {
        if self.raw_setting("device")?.is_some() {
            return Ok(());
        }
        let key = SigningKey::generate()?;
        self.raw_set("device", &device_id_from_key(&key.public_key()))?;
        self.raw_set("signseed", &key.seed_hex())?;
        self.raw_set("signsince", "1")
    }

    /// A Catalog that existed before signing: its key starts with the
    /// next entry it writes, everything before passes as unsigned.
    fn ensure_signing_key(&self) -> Result<()> {
        if self.raw_setting("signseed")?.is_some() {
            return Ok(());
        }
        let key = SigningKey::generate()?;
        let since = self
            .version_vector()?
            .get(&self.device_id())
            .copied()
            .unwrap_or(0)
            + 1;
        self.raw_set("signseed", &key.seed_hex())?;
        self.raw_set("signsince", &since.to_string())
    }

    /// This Catalog's signing key.
    pub fn signing_key(&self) -> Result<SigningKey> {
        let hex = self
            .raw_setting("signseed")?
            .ok_or_else(|| Error::Invalid("no signing key".into()))?;
        let bytes = hex::decode(hex).map_err(|e| Error::Invalid(format!("signing key: {e}")))?;
        let seed: [u8; 32] = bytes
            .try_into()
            .map_err(|_| Error::Invalid("signing key has the wrong size".into()))?;
        Ok(SigningKey::from_seed(seed))
    }

    /// The first own dseq that carries a signature.
    pub fn signing_since(&self) -> i64 {
        self.raw_setting("signsince")
            .ok()
            .flatten()
            .and_then(|v| v.parse().ok())
            .unwrap_or(1)
    }

    /// The key as it travels to partners, signed by itself.
    pub fn own_key_record(&self) -> Result<KeyRecord> {
        Ok(KeyRecord::make(
            &self.signing_key()?,
            &self.device_id(),
            self.signing_since(),
        ))
    }

    /// The short key code people see next to this Catalog's author name.
    pub fn key_code(&self) -> Result<String> {
        Ok(self.signing_key()?.code())
    }

    // ------------------------------------------------------- partner keys

    /// The key pinned for a partner's device, if one was ever met.
    pub fn pinned_key(&self, device: &str) -> Option<PinnedKey> {
        let raw = self.local_setting(&format!("key:{device}"))?;
        serde_json::from_str(&raw).ok()
    }

    /// Every partner key this Catalog holds, by device.
    pub fn pinned_keys(&self) -> Result<Vec<PinnedKey>> {
        let mut stmt = self
            .db
            .prepare("SELECT value FROM local_settings WHERE key LIKE 'u:key:%' ORDER BY key")?;
        let raws: Vec<String> = stmt
            .query_map([], |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        Ok(raws
            .iter()
            .filter_map(|raw| serde_json::from_str(raw).ok())
            .collect())
    }

    fn pin(&self, record: &KeyRecord, trust: KeyTrust) -> Result<()> {
        let pinned = PinnedKey {
            record: record.clone(),
            trust,
        };
        self.set_local_setting(
            &format!("key:{}", record.device),
            &serde_json::to_string(&pinned)?,
        )
    }

    /// Forgets a partner's key: the next file from that device is
    /// trusted on first use again.
    pub fn unpin_key(&self, device: &str) -> Result<()> {
        self.remove_local_setting(&format!("key:{device}"))
    }

    /// The keys to send along with the entries: this Catalog's own and
    /// every one it holds.
    pub fn key_records(&self) -> Result<Vec<KeyRecord>> {
        let mut records = vec![self.own_key_record()?];
        records.extend(self.pinned_keys()?.into_iter().map(|k| k.record));
        Ok(records)
    }

    /// Takes in the keys a payload carried. The first key seen for a
    /// device is pinned on trust; only the key of `verified_device` is
    /// pinned as verified. A record that does not sign itself is ignored;
    /// a second, different key for a pinned device is refused and
    /// reported. `authors` are the names the same payload writes under
    /// each new device, for the impostor warning.
    pub fn learn_keys(
        &self,
        keys: &[KeyRecord],
        verified_device: Option<&str>,
        report: &mut ImportReport,
        authors: &HashMap<String, HashSet<String>>,
    ) -> Result<()> {
        let me = self.device_id();
        for record in keys {
            if record.device == me || !record.self_signed() {
                continue;
            }
            let verified = Some(record.device.as_str()) == verified_device;
            match self.pinned_key(&record.device) {
                None => {
                    let trust = if verified {
                        KeyTrust::Verified
                    } else {
                        KeyTrust::Tofu
                    };
                    self.pin(record, trust)?;
                    report.new_keys.push(PinnedKey {
                        record: record.clone(),
                        trust,
                    });
                    if let Some(names) = authors.get(&record.device) {
                        let mut names: Vec<&String> = names.iter().collect();
                        names.sort();
                        for name in names {
                            if self.name_known_elsewhere(name, &record.device)? {
                                report.impostors.push((name.clone(), record.device.clone()));
                            }
                        }
                    }
                }
                Some(existing) if existing.record.public_key() != record.public_key() => {
                    if !report.changed_keys.contains(&record.device) {
                        report.changed_keys.push(record.device.clone());
                    }
                }
                Some(existing) if verified && existing.trust == KeyTrust::Tofu => {
                    self.pin(&existing.record, KeyTrust::Verified)?;
                }
                Some(_) => {}
            }
        }
        Ok(())
    }

    /// Whether `name` is this Catalog's own author or writes under a
    /// device whose key is pinned, other than `device`.
    fn name_known_elsewhere(&self, name: &str, device: &str) -> Result<bool> {
        if name == crate::SEED_AUTHOR {
            return Ok(false);
        }
        if self.author().as_deref() == Some(name) {
            return Ok(true);
        }
        let me = self.device_id();
        for (author, dev, _) in self.authors_overview()? {
            if author != name || dev == device {
                continue;
            }
            if dev == me || self.pinned_key(&dev).is_some() {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// Authors and devices with their entry counts.
    pub fn authors_overview(&self) -> Result<Vec<(String, String, i64)>> {
        let mut stmt = self.db.prepare(
            "SELECT author, device, COUNT(*) FROM entries GROUP BY author, device ORDER BY author, device",
        )?;
        let rows = stmt.query_map([], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?)))?;
        Ok(rows.collect::<std::result::Result<_, _>>()?)
    }

    /// Whether `e` passes under `key`: signed and valid, or older than
    /// the key's first signed row.
    fn signed(e: &Entry, key: &KeyRecord) -> bool {
        if e.sig.is_none() {
            return e.dseq < key.since;
        }
        verify_signature(
            &key.public_key(),
            &entry_bytes(
                &e.device,
                e.dseq,
                &e.entity,
                &e.field,
                e.value.as_deref(),
                &e.date,
                &e.author,
                &e.recorded,
                e.reminder,
            ),
            e.sig.as_deref(),
        )
    }

    /// Whether a row in this Catalog verifies under the key its device
    /// holds here. None when no key is known for the device or the row
    /// is older than the key.
    pub fn verifies_entry(&self, e: &Entry) -> Result<Option<bool>> {
        let key = if e.device == self.device_id() {
            self.own_key_record()?
        } else {
            match self.pinned_key(&e.device) {
                Some(k) => k.record,
                None => return Ok(None),
            }
        };
        if e.sig.is_none() && e.dseq < key.since {
            return Ok(None);
        }
        Ok(Some(Self::signed(e, &key)))
    }

    /// This Catalog's stable device id (ADR 0002); created once.
    pub fn device_id(&self) -> String {
        self.raw_setting("device")
            .ok()
            .flatten()
            .unwrap_or_default()
    }

    /// Device-local, never-synced key/value setting.
    pub fn local_setting(&self, key: &str) -> Option<String> {
        self.raw_setting(&format!("u:{key}")).ok().flatten()
    }

    pub fn set_local_setting(&self, key: &str, value: &str) -> Result<()> {
        self.raw_set(&format!("u:{key}"), value)
    }

    pub fn remove_local_setting(&self, key: &str) -> Result<()> {
        self.db.execute(
            "DELETE FROM local_settings WHERE key = ?1",
            [format!("u:{key}")],
        )?;
        Ok(())
    }

    /// The device's Author name; none until setup stored one.
    pub fn author(&self) -> Option<String> {
        self.raw_setting("author").ok().flatten()
    }

    pub fn set_author(&self, name: &str) -> Result<()> {
        let name = name.trim();
        if name.is_empty() {
            return Err(Error::Invalid("Author name must not be empty".into()));
        }
        self.raw_set("author", name)
    }

    // --------------------------------------------------------------- voids

    fn rebuild_voids(&self) -> Result<()> {
        self.db.execute("DELETE FROM voids", [])?;
        let fields: Vec<String> = self
            .db
            .prepare("SELECT DISTINCT field FROM entries WHERE field LIKE ?1")?
            .query_map([format!("{}%", keys::VOID_PREFIX)], |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        for field in fields {
            self.note_void(&field)?;
        }
        Ok(())
    }

    /// Brings the void table in step with the latest marker under
    /// `field`, if it is one.
    fn note_void(&self, field: &str) -> Result<()> {
        let Some((device, dseq)) = void_target(field) else {
            return Ok(());
        };
        let value: Option<Option<String>> = self
            .db
            .query_row(
                &format!("SELECT value FROM entries WHERE field = ?1 {LATEST} LIMIT 1"),
                [field],
                |r| r.get(0),
            )
            .optional()?;
        if matches!(value, Some(Some(_))) {
            self.db.execute(
                "INSERT OR REPLACE INTO voids (device, dseq) VALUES (?1, ?2)",
                params![device, dseq],
            )?;
        } else {
            self.db.execute(
                "DELETE FROM voids WHERE device = ?1 AND dseq = ?2",
                params![device, dseq],
            )?;
        }
        Ok(())
    }

    // ----------------------------------------------------------------- log

    fn row(r: &rusqlite::Row) -> rusqlite::Result<Entry> {
        Ok(Entry {
            seq: r.get("seq")?,
            device: r.get("device")?,
            dseq: r.get("dseq")?,
            entity: r.get("entity")?,
            field: r.get("field")?,
            value: r.get("value")?,
            date: r.get("date")?,
            author: r.get("author")?,
            recorded: r.get("recorded")?,
            reminder: r.get::<_, i64>("reminder")? != 0,
            sig: r.get("sig")?,
            voided: false,
        })
    }

    fn select(&self, sql: &str, args: &[&dyn rusqlite::ToSql]) -> Result<Vec<Entry>> {
        let mut stmt = self.db.prepare(sql)?;
        let rows = stmt.query_map(args, Self::row)?;
        Ok(rows.collect::<std::result::Result<_, _>>()?)
    }

    /// Every entry, ordered (device, dseq): the store's full knowledge.
    pub fn all_entries(&self) -> Result<Vec<Entry>> {
        self.select("SELECT * FROM entries ORDER BY device, dseq", &[])
    }

    /// What this store has seen: max dseq per known device (ADR 0002),
    /// banned rows that were received-and-discarded included.
    pub fn version_vector(&self) -> Result<BTreeMap<String, i64>> {
        let mut vector = BTreeMap::new();
        let mut stmt = self
            .db
            .prepare("SELECT device, MAX(dseq) FROM entries GROUP BY device")?;
        for row in stmt.query_map([], |r| Ok((r.get::<_, String>(0)?, r.get::<_, i64>(1)?)))? {
            let (device, max) = row?;
            vector.insert(device, max);
        }
        for (device, max) in self.discarded_vector()? {
            let slot = vector.entry(device).or_insert(0);
            if max > *slot {
                *slot = max;
            }
        }
        Ok(vector)
    }

    fn discarded_vector(&self) -> Result<Vec<(String, i64)>> {
        let mut stmt = self
            .db
            .prepare("SELECT key, value FROM local_settings WHERE key LIKE 'u:banvector:%'")?;
        let rows = stmt.query_map([], |r| {
            let key: String = r.get(0)?;
            let value: String = r.get(1)?;
            Ok((
                key["u:banvector:".len()..].to_string(),
                value.parse::<i64>().unwrap_or(0),
            ))
        })?;
        Ok(rows.collect::<std::result::Result<_, _>>()?)
    }

    fn record_discarded(&self, device: &str, dseq: i64) -> Result<()> {
        let key = format!("banvector:{device}");
        let current = self
            .local_setting(&key)
            .and_then(|v| v.parse::<i64>().ok())
            .unwrap_or(0);
        if dseq > current {
            self.set_local_setting(&key, &dseq.to_string())?;
        }
        Ok(())
    }

    /// The next sequence number for `device`: one above the high-water
    /// mark, removed and discarded rows included (ADR 0008).
    fn next_dseq(&self, device: &str) -> Result<i64> {
        let highest: i64 = self.db.query_row(
            "SELECT COALESCE(MAX(dseq), 0) FROM entries WHERE device = ?1",
            [device],
            |r| r.get(0),
        )?;
        let removed = self
            .local_setting(&format!("banvector:{device}"))
            .and_then(|v| v.parse::<i64>().ok())
            .unwrap_or(0);
        Ok(highest.max(removed) + 1)
    }

    /// Writes one row under this Catalog's own device.
    #[allow(clippy::too_many_arguments)]
    fn insert_own(
        &self,
        device: &str,
        dseq: i64,
        entity: &str,
        field: &str,
        value: Option<&str>,
        date: &str,
        author: &str,
        recorded: &str,
        reminder: bool,
    ) -> Result<()> {
        let sig = self.signing_key()?.sign(&entry_bytes(
            device, dseq, entity, field, value, date, author, recorded, reminder,
        ));
        self.db.execute(
            "INSERT INTO entries (device, dseq, entity, field, value, date, author, recorded, reminder, sig) \
             VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10)",
            params![device, dseq, entity, field, value, date, author, recorded, reminder as i64, sig],
        )?;
        self.note_void(field)
    }

    /// Appends one immutable fact under the configured Author. `date` is
    /// the effective, backdatable date and defaults to now.
    pub fn append(&mut self, entity: &str, field: &str, value: Option<&str>) -> Result<()> {
        self.append_at(entity, field, value, None, false)
    }

    /// [`Catalog::append`] with an explicit effective date and the
    /// reminder flag (a plan, not a fact).
    pub fn append_at(
        &mut self,
        entity: &str,
        field: &str,
        value: Option<&str>,
        date: Option<&str>,
        reminder: bool,
    ) -> Result<()> {
        let author = self.author().ok_or(Error::NoAuthor)?;
        let now = self.now();
        let date = date.map(crate::entry::iso).unwrap_or_else(|| now.clone());
        let device = self.device_id();
        let next = self.next_dseq(&device)?;
        self.insert_own(
            &device, next, entity, field, value, &date, &author, &now, reminder,
        )?;
        // A value written while its field is private needs its public
        // trace right away, or a partner sees an empty slot instead of a
        // redacted one.
        if !keys::is_structural(field)
            && self.is_field_private(entity, field)?
            && self.current(entity, &keys::withheld(field))?.as_deref() != Some("yes")
        {
            self.append_at(
                entity,
                &keys::withheld(field),
                Some("yes"),
                Some(&date),
                false,
            )?;
        }
        Ok(())
    }

    /// Creates a Clowder under `id` (`clowder:<uuid>`).
    pub fn create_clowder(&mut self, id: &str, name: &str) -> Result<()> {
        self.append(id, keys::TYPE, Some(keys::KIND_CLOWDER))?;
        self.append(id, keys::NAME, Some(name))
    }

    /// Creates a Cat under `id` (`cat:<uuid>`), in a Clowder or as a Stray.
    pub fn create_cat(
        &mut self,
        id: &str,
        name: &str,
        clowder: Option<&str>,
        species: &str,
    ) -> Result<()> {
        self.append(id, keys::TYPE, Some(keys::KIND_CAT))?;
        self.append(id, keys::NAME, Some(name))?;
        self.append(id, &keys::user_field("species"), Some(species))?;
        if let Some(c) = clowder {
            self.append(id, keys::CLOWDER, Some(c))?;
        }
        Ok(())
    }

    /// Moves a Cat into a Clowder, or with none records it leaving: the
    /// Cat becomes a Stray.
    pub fn move_cat(&mut self, cat: &str, clowder: Option<&str>) -> Result<()> {
        self.append(cat, keys::CLOWDER, clowder)
    }

    /// Stores an already-compressed JPEG for an entity, content-addressed
    /// by SHA-256, and records it in the log. Returns the content hash.
    pub fn add_image(&mut self, entity: &str, jpeg: &[u8]) -> Result<String> {
        let hash = hex::encode(Sha256::digest(jpeg));
        self.put_blob(&hash, jpeg)?;
        self.append(entity, &keys::image(&hash), Some("added"))?;
        Ok(hash)
    }

    /// Marks `hash` as the entity's Profile Image.
    pub fn set_profile_image(&mut self, entity: &str, hash: &str) -> Result<()> {
        self.append(entity, keys::PROFILE_IMAGE, Some(hash))
    }

    /// Deletes one photo: a marker entry propagates the deletion, the
    /// bytes go once nothing references the hash anymore.
    pub fn delete_image(&mut self, entity: &str, hash: &str) -> Result<()> {
        self.append(entity, &keys::image(hash), Some("deleted"))?;
        if !self.image_referenced(hash)? {
            self.remove_blob(hash)?;
        }
        Ok(())
    }

    /// Whether any entry ever carried the reminder flag: while false,
    /// every outgoing payload is byte-identical to the pre-1.0.0 format.
    pub fn has_reminders(&self) -> Result<bool> {
        Ok(self
            .db
            .query_row(
                "SELECT 1 FROM entries WHERE reminder = 1 LIMIT 1",
                [],
                |_| Ok(()),
            )
            .optional()?
            .is_some())
    }

    /// Every entry a partner with `vector` is missing, ordered (device,
    /// dseq). Private values and their markers stay home unless
    /// `include_private`; the `$withheld` trace travels either way.
    pub fn entries_since(
        &self,
        vector: &BTreeMap<String, i64>,
        include_private: bool,
    ) -> Result<Vec<Entry>> {
        let mut private_of: HashMap<(String, String), bool> = HashMap::new();
        let mut result = Vec::new();
        for e in self.all_entries()? {
            let fresh = e.dseq > vector.get(&e.device).copied().unwrap_or(0);
            let private = match private_of.get(&(e.entity.clone(), e.field.clone())) {
                Some(p) => *p,
                None => {
                    let p = self.is_field_private(&e.entity, &e.field)?;
                    private_of.insert((e.entity.clone(), e.field.clone()), p);
                    p
                }
            };
            if include_private {
                if fresh || private {
                    result.push(e);
                }
                continue;
            }
            if !fresh {
                continue;
            }
            if e.field == keys::PRIVATE || e.field.starts_with(keys::PRIVATE_PREFIX) {
                continue;
            }
            if !private {
                result.push(e);
            }
        }
        Ok(result)
    }

    /// True when this entity's value for `field` stays home: the
    /// per-value marker decides, and a Private field definition covers
    /// that field on every entity.
    pub fn is_field_private(&self, id: &str, field: &str) -> Result<bool> {
        if keys::is_structural(field) {
            return Ok(false);
        }
        let key = self.canonical_key(field)?;
        let entity = self.resolve_entity(id)?;
        if self.current(&entity, keys::TYPE)?.as_deref() == Some(keys::KIND_FIELD_DEF) {
            return Ok(false);
        }
        if let Some(marker) = self.current(&entity, &keys::private_field(&key))? {
            return Ok(marker == "yes");
        }
        if let Some(slug) = key.strip_prefix("f:") {
            let def = self.resolve_entity(&format!("fielddef:{slug}"))?;
            if self.current(&def, keys::PRIVATE)?.as_deref() == Some("yes") {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// True when this store has seen a deletion marker for `hash`.
    pub(crate) fn known_deleted(&self, hash: &str) -> Result<bool> {
        Ok(self
            .db
            .query_row(
                "SELECT 1 FROM entries WHERE field = ?1 AND value = 'deleted' LIMIT 1",
                [keys::image(hash)],
                |_| Ok(()),
            )
            .optional()?
            .is_some())
    }

    /// The photos in use that travel: every added image of every Cat and
    /// Clowder, private ones only when asked for.
    pub(crate) fn live_images(&self, include_private: bool) -> Result<Vec<String>> {
        let mut seen = HashSet::new();
        let mut hashes = Vec::new();
        for view in self.cats(None)?.into_iter().chain(self.clowders()?) {
            for hash in self.images(&view.id)? {
                if !include_private && self.is_field_private(&view.id, &keys::image(&hash))? {
                    continue;
                }
                if seen.insert(hash.clone()) {
                    hashes.push(hash);
                }
            }
        }
        Ok(hashes)
    }

    /// Imports foreign entries idempotently: (device, dseq) already held
    /// are ignored. Returns the entries that were actually new.
    pub fn apply_entries(&mut self, entries: Vec<Entry>) -> Result<Vec<Entry>> {
        self.apply_entries_with(entries, None, None, &mut ImportReport::default())
    }

    /// [`Catalog::apply_entries`] with the key records the payload
    /// carried, learned first, and a report of what was refused. Every
    /// entry from a device whose key is pinned, this Catalog's own
    /// included, must carry a valid signature unless it is older than
    /// the key's `since`. Refused rows never move the version vector.
    pub fn apply_entries_with(
        &mut self,
        entries: Vec<Entry>,
        keys: Option<&[KeyRecord]>,
        verified_device: Option<&str>,
        report: &mut ImportReport,
    ) -> Result<Vec<Entry>> {
        if let Some(keys) = keys {
            let mut authors: HashMap<String, HashSet<String>> = HashMap::new();
            for e in &entries {
                authors
                    .entry(e.device.clone())
                    .or_default()
                    .insert(e.author.clone());
            }
            self.learn_keys(keys, verified_device, report, &authors)?;
        }
        let own = self.own_key_record()?;
        let mut pinned: HashMap<String, Option<KeyRecord>> = HashMap::new();
        for e in &entries {
            if !pinned.contains_key(&e.device) {
                let key = if e.device == own.device {
                    Some(own.clone())
                } else {
                    self.pinned_key(&e.device).map(|k| k.record)
                };
                pinned.insert(e.device.clone(), key);
            }
        }
        let tx = self.db.transaction()?;
        let devices: HashSet<&str> = entries.iter().map(|e| e.device.as_str()).collect();
        let mut held: HashMap<String, HashSet<i64>> = HashMap::new();
        for device in &devices {
            let mut stmt = tx.prepare("SELECT dseq FROM entries WHERE device = ?1")?;
            let dseqs: HashSet<i64> = stmt
                .query_map([device], |r| r.get(0))?
                .collect::<std::result::Result<_, _>>()?;
            held.insert(device.to_string(), dseqs);
        }
        let self_id: String = tx
            .query_row(
                "SELECT value FROM local_settings WHERE key = 'device'",
                [],
                |r| r.get(0),
            )
            .optional()?
            .unwrap_or_default();
        let own_max: i64 = tx.query_row(
            "SELECT COALESCE(MAX(dseq), 0) FROM entries WHERE device = ?1",
            [&self_id],
            |r| r.get(0),
        )?;
        let mut imported = Vec::new();
        let mut discarded = Vec::new();
        {
            let mut insert = tx.prepare(
                "INSERT OR IGNORE INTO entries \
                 (device, dseq, entity, field, value, date, author, recorded, reminder, sig) \
                 VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10)",
            )?;
            for e in entries.into_iter().map(Entry::normalized) {
                if held.get(&e.device).is_some_and(|d| d.contains(&e.dseq)) {
                    continue;
                }
                if e.device == self_id && e.dseq > own_max {
                    continue;
                }
                if e.entity.starts_with(keys::PERSON_PREFIX) && e.entity != keys::person(&e.device)
                {
                    continue;
                }
                if is_banned_in(&tx, &e)? {
                    discarded.push((e.device.clone(), e.dseq));
                    continue;
                }
                if let Some(Some(key)) = pinned.get(&e.device)
                    && !Self::signed(&e, key)
                {
                    *report
                        .refused
                        .entry((e.author.clone(), e.device.clone()))
                        .or_insert(0) += 1;
                    continue;
                }
                let n = insert.execute(params![
                    e.device,
                    e.dseq,
                    e.entity,
                    e.field,
                    e.value,
                    e.date,
                    e.author,
                    e.recorded,
                    e.reminder as i64,
                    e.sig,
                ])?;
                if n > 0 {
                    imported.push(e);
                }
            }
        }
        tx.commit()?;
        for (device, dseq) in discarded {
            self.record_discarded(&device, dseq)?;
        }
        for e in &imported {
            self.note_void(&e.field)?;
        }
        for e in &imported {
            if let Some(hash) = e.field.strip_prefix(keys::IMAGE_PREFIX)
                && e.value.as_deref() == Some("deleted")
                && !self.image_referenced(hash)?
            {
                self.remove_blob(hash)?;
            }
        }
        Ok(imported)
    }

    // -------------------------------------------------------- alias (merge)

    fn merge_targets(&self) -> Result<HashMap<String, String>> {
        let mut map = HashMap::new();
        for e in self.select(
            &format!("SELECT * FROM entries WHERE field = ?1 {LATEST}"),
            &[&keys::MERGED_INTO],
        )? {
            if let Some(value) = e.value {
                map.entry(e.entity).or_insert(value);
            }
        }
        Ok(map)
    }

    /// Canonical id: follows the merge chain (cycle-safe).
    pub fn resolve_entity(&self, id: &str) -> Result<String> {
        Ok(resolve(&self.merge_targets()?, id))
    }

    /// The alias group of an id: its canonical id plus every loser
    /// whose chain resolves to it.
    fn group(&self, id: &str) -> Result<Vec<String>> {
        let targets = self.merge_targets()?;
        if targets.is_empty() {
            return Ok(vec![id.to_string()]);
        }
        let canonical = resolve(&targets, id);
        let mut group = vec![canonical.clone()];
        let mut losers: Vec<&String> = targets
            .keys()
            .filter(|loser| resolve(&targets, loser) == canonical)
            .collect();
        losers.sort();
        group.extend(losers.into_iter().cloned());
        Ok(group)
    }

    /// All keys a field key answers for: itself plus the keys of field
    /// definitions merged into its definition.
    fn keys_for(&self, field: &str) -> Result<Vec<String>> {
        let Some(slug) = field.strip_prefix("f:") else {
            return Ok(vec![field.to_string()]);
        };
        Ok(self
            .group(&format!("fielddef:{slug}"))?
            .into_iter()
            .map(|id| format!("f:{}", &id["fielddef:".len()..]))
            .collect())
    }

    /// Display key for a raw stored field key: loser keys map to the
    /// survivor's key.
    pub fn canonical_key(&self, field: &str) -> Result<String> {
        let Some(slug) = field.strip_prefix("f:") else {
            return Ok(field.to_string());
        };
        let resolved = self.resolve_entity(&format!("fielddef:{slug}"))?;
        Ok(format!("f:{}", &resolved["fielddef:".len()..]))
    }

    fn union_kind(entity: &str) -> bool {
        entity.starts_with("cat:") || entity.starts_with("clowder:")
    }

    fn entities_for(&self, entity: &str) -> Result<Vec<String>> {
        if Self::union_kind(entity) {
            self.group(entity)
        } else {
            Ok(vec![entity.to_string()])
        }
    }

    // ---------------------------------------------------------- projection

    /// Current value of one field, or none if never set or last set to
    /// null. Cat/Clowder reads unite the alias group; Clowder membership
    /// values resolve to the survivor.
    pub fn current(&self, entity: &str, field: &str) -> Result<Option<String>> {
        let entities = self.entities_for(entity)?;
        let keys = self.keys_for(field)?;
        let sql = format!(
            "SELECT * FROM entries WHERE entity IN ({}) AND field IN ({}) \
             AND reminder = 0 {LIVE} {LATEST} LIMIT 1",
            placeholders(entities.len()),
            placeholders(keys.len())
        );
        let args: Vec<&dyn rusqlite::ToSql> = entities
            .iter()
            .map(|s| s as &dyn rusqlite::ToSql)
            .chain(keys.iter().map(|s| s as &dyn rusqlite::ToSql))
            .collect();
        let rows = self.select(&sql, &args)?;
        let Some(first) = rows.into_iter().next() else {
            return Ok(None);
        };
        match first.value {
            Some(value) if field == keys::CLOWDER => Ok(Some(self.resolve_entity(&value)?)),
            other => Ok(other),
        }
    }

    /// Current value of every field of an entity, loser field keys
    /// shown under the survivor's key.
    pub fn current_fields(&self, entity: &str) -> Result<BTreeMap<String, Option<String>>> {
        let entities = self.entities_for(entity)?;
        let sql = format!(
            "SELECT * FROM entries WHERE entity IN ({}) AND reminder = 0 {LIVE} {LATEST}",
            placeholders(entities.len())
        );
        let args: Vec<&dyn rusqlite::ToSql> =
            entities.iter().map(|s| s as &dyn rusqlite::ToSql).collect();
        let mut result = BTreeMap::new();
        for e in self.select(&sql, &args)? {
            result
                .entry(self.canonical_key(&e.field)?)
                .or_insert(e.value);
        }
        Ok(result)
    }

    pub fn is_deleted(&self, entity: &str) -> Result<bool> {
        Ok(self.current(entity, keys::DELETED)?.as_deref() == Some("true"))
    }

    /// Ids of all non-deleted, non-merged entities of a kind, oldest
    /// first.
    fn entities_of(&self, kind: &str) -> Result<Vec<String>> {
        let merged = self.merge_targets()?;
        let mut stmt = self.db.prepare(
            "SELECT DISTINCT entity FROM entries WHERE field = ?1 AND value = ?2 ORDER BY seq",
        )?;
        let ids: Vec<String> = stmt
            .query_map([keys::TYPE, kind], |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        let mut out = Vec::new();
        for id in ids {
            if !merged.contains_key(&id) && !self.is_deleted(&id)? {
                out.push(id);
            }
        }
        Ok(out)
    }

    fn view(&self, id: String) -> Result<EntityView> {
        let name = self
            .current(&id, keys::NAME)?
            .unwrap_or_else(|| "(unnamed)".to_string());
        Ok(EntityView { id, name })
    }

    /// All Clowders, creation order.
    pub fn clowders(&self) -> Result<Vec<EntityView>> {
        self.entities_of(keys::KIND_CLOWDER)?
            .into_iter()
            .map(|id| self.view(id))
            .collect()
    }

    /// Cats currently in `clowder`, or every Cat when none is given.
    pub fn cats(&self, clowder: Option<&str>) -> Result<Vec<EntityView>> {
        let target = match clowder {
            Some(c) => Some(self.resolve_entity(c)?),
            None => None,
        };
        let mut out = Vec::new();
        for id in self.entities_of(keys::KIND_CAT)? {
            if target.is_none() || self.current(&id, keys::CLOWDER)? == target {
                out.push(self.view(id)?);
            }
        }
        Ok(out)
    }

    /// Ids of every Field definition, creation order.
    pub fn field_def_ids(&self) -> Result<Vec<String>> {
        self.entities_of(keys::KIND_FIELD_DEF)
    }

    // -------------------------------------------------------------- images

    /// Content hashes of an entity's images (merged-in losers included),
    /// oldest first, deleted ones excluded.
    pub fn images(&self, entity: &str) -> Result<Vec<String>> {
        let entities = self.group(entity)?;
        let sql = format!(
            "SELECT DISTINCT field FROM entries WHERE entity IN ({}) AND field LIKE ?{} ORDER BY seq",
            placeholders(entities.len()),
            entities.len() + 1
        );
        let like = format!("{}%", keys::IMAGE_PREFIX);
        let mut stmt = self.db.prepare(&sql)?;
        let args = entities
            .iter()
            .map(|s| s.as_str())
            .chain(std::iter::once(like.as_str()));
        let fields: Vec<String> = stmt
            .query_map(params_from_iter(args), |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        let mut out = Vec::new();
        for field in fields {
            if self.current(entity, &field)?.as_deref() == Some("added") {
                out.push(field[keys::IMAGE_PREFIX.len()..].to_string());
            }
        }
        Ok(out)
    }

    /// The entity's Profile Image: the chosen one, defaulting to the
    /// first.
    pub fn profile_image(&self, entity: &str) -> Result<Option<String>> {
        let chosen = self.current(entity, keys::PROFILE_IMAGE)?;
        let all = self.images(entity)?;
        if let Some(c) = chosen
            && all.contains(&c)
        {
            return Ok(Some(c));
        }
        Ok(all.into_iter().next())
    }

    fn blob_path(&self, hash: &str) -> Option<PathBuf> {
        let hex64 =
            hash.len() == 64 && hash.bytes().all(|b| matches!(b, b'0'..=b'9' | b'a'..=b'f'));
        hex64.then(|| self.images.join(format!("{hash}.jpg")))
    }

    /// The stored bytes for a content hash, or none if unknown.
    pub fn image_bytes(&self, hash: &str) -> Option<Vec<u8>> {
        std::fs::read(self.blob_path(hash)?).ok()
    }

    /// Stores a photo received from a partner; verifies the content hash.
    pub fn put_blob(&self, hash: &str, bytes: &[u8]) -> Result<()> {
        if hex::encode(Sha256::digest(bytes)) != hash {
            return Err(Error::HashMismatch(hash.to_string()));
        }
        if self.local_setting(&format!("ban:blob:{hash}")).as_deref() == Some("1") {
            return Ok(());
        }
        let Some(path) = self.blob_path(hash) else {
            return Ok(());
        };
        if path.exists() {
            return Ok(());
        }
        let tmp = path.with_extension("jpg.tmp");
        std::fs::write(&tmp, bytes).map_err(|e| Error::io(&tmp, e))?;
        std::fs::rename(&tmp, &path).map_err(|e| Error::io(&path, e))?;
        Ok(())
    }

    fn remove_blob(&self, hash: &str) -> Result<()> {
        if let Some(path) = self.blob_path(hash)
            && path.exists()
        {
            std::fs::remove_file(&path).map_err(|e| Error::io(&path, e))?;
        }
        Ok(())
    }

    /// True when this Catalog has ever heard of the image, deleted or not.
    pub fn knows_image(&self, hash: &str) -> Result<bool> {
        Ok(self
            .db
            .query_row(
                "SELECT 1 FROM entries WHERE field = ?1 LIMIT 1",
                [keys::image(hash)],
                |_| Ok(()),
            )
            .optional()?
            .is_some())
    }

    fn image_referenced(&self, hash: &str) -> Result<bool> {
        let field = keys::image(hash);
        let mut stmt = self
            .db
            .prepare("SELECT DISTINCT entity FROM entries WHERE field = ?1")?;
        let entities: Vec<String> = stmt
            .query_map([&field], |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        for entity in entities {
            if self.current(&entity, &field)?.as_deref() == Some("added") {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// Content hashes referenced as added somewhere but missing locally.
    pub fn missing_blobs(&self) -> Result<Vec<String>> {
        let mut stmt = self
            .db
            .prepare("SELECT DISTINCT field FROM entries WHERE field LIKE ?1")?;
        let fields: Vec<String> = stmt
            .query_map([format!("{}%", keys::IMAGE_PREFIX)], |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        let mut missing = Vec::new();
        for field in fields {
            let hash = &field[keys::IMAGE_PREFIX.len()..];
            if self.image_referenced(hash)? && self.image_bytes(hash).is_none() {
                missing.push(hash.to_string());
            }
        }
        Ok(missing)
    }
}

fn is_banned_in(tx: &rusqlite::Transaction, e: &Entry) -> Result<bool> {
    let banned = |k: String| -> Result<bool> {
        Ok(tx
            .query_row(
                "SELECT value FROM local_settings WHERE key = ?1",
                [format!("u:{k}")],
                |r| r.get::<_, String>(0),
            )
            .optional()?
            .as_deref()
            == Some("1"))
    };
    Ok(banned(format!("ban:author:{}", e.author))?
        || banned(format!("ban:device:{}", e.device))?
        || match e.field.strip_prefix(keys::IMAGE_PREFIX) {
            Some(hash) => banned(format!("ban:blob:{hash}"))?,
            None => false,
        })
}

fn resolve(targets: &HashMap<String, String>, id: &str) -> String {
    let mut current = id.to_string();
    let mut seen = HashSet::new();
    while let Some(next) = targets.get(&current) {
        if !seen.insert(current.clone()) {
            break;
        }
        current = next.clone();
    }
    current
}

fn placeholders(n: usize) -> String {
    (0..n).map(|_| "?").collect::<Vec<_>>().join(", ")
}

/// The (device, dseq) a `$void:` key names, or none when malformed.
fn void_target(field: &str) -> Option<(String, i64)> {
    let body = field.strip_prefix(keys::VOID_PREFIX)?;
    let cut = body.rfind(':')?;
    if cut == 0 {
        return None;
    }
    let dseq = body[cut + 1..].parse().ok()?;
    Some((body[..cut].to_string(), dseq))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn catalog() -> (tempfile::TempDir, Catalog) {
        let dir = tempfile::tempdir().unwrap();
        let c = Catalog::open(dir.path()).unwrap();
        (dir, c)
    }

    fn entry(
        device: &str,
        dseq: i64,
        entity: &str,
        field: &str,
        value: Option<&str>,
        date: &str,
    ) -> Entry {
        Entry {
            seq: 0,
            device: device.into(),
            dseq,
            entity: entity.into(),
            field: field.into(),
            value: value.map(String::from),
            date: date.into(),
            author: "Ada".into(),
            recorded: date.into(),
            reminder: false,
            sig: None,
            voided: false,
        }
    }

    #[test]
    fn a_fresh_catalog_has_a_device_id_that_survives_reopening() {
        let dir = tempfile::tempdir().unwrap();
        let id = Catalog::open(dir.path()).unwrap().device_id();
        assert_eq!(id.len(), 32);
        assert_eq!(Catalog::open(dir.path()).unwrap().device_id(), id);
    }

    #[test]
    fn applying_entries_is_idempotent_and_projects_latest_wins() {
        let (_dir, mut c) = catalog();
        let rows = vec![
            entry(
                "w",
                1,
                "cat:a",
                keys::TYPE,
                Some("cat"),
                "2026-01-01T10:00:01Z",
            ),
            entry(
                "w",
                2,
                "cat:a",
                keys::NAME,
                Some("Miezi"),
                "2026-01-01T10:00:02Z",
            ),
            entry(
                "w",
                3,
                "cat:a",
                keys::NAME,
                Some("Mimi"),
                "2026-01-01T10:00:03Z",
            ),
        ];
        assert_eq!(c.apply_entries(rows.clone()).unwrap().len(), 3);
        assert_eq!(c.apply_entries(rows).unwrap().len(), 0);
        assert_eq!(
            c.current("cat:a", keys::NAME).unwrap().as_deref(),
            Some("Mimi")
        );
        assert_eq!(c.version_vector().unwrap()["w"], 3);
        assert_eq!(c.cats(None).unwrap()[0].name, "Mimi");
        let fields = c.current_fields("cat:a").unwrap();
        assert_eq!(fields.len(), 2);
    }

    #[test]
    fn a_backdated_entry_loses_to_the_newer_effective_date() {
        let (_dir, mut c) = catalog();
        c.apply_entries(vec![
            entry(
                "w",
                1,
                "cat:a",
                keys::NAME,
                Some("New"),
                "2026-02-01T10:00:00Z",
            ),
            entry(
                "w",
                2,
                "cat:a",
                keys::NAME,
                Some("Old"),
                "2026-01-01T10:00:00Z",
            ),
        ])
        .unwrap();
        assert_eq!(
            c.current("cat:a", keys::NAME).unwrap().as_deref(),
            Some("New")
        );
    }

    #[test]
    fn merged_losers_resolve_to_the_survivor_and_vanish_from_lists() {
        let (_dir, mut c) = catalog();
        c.apply_entries(vec![
            entry(
                "w",
                1,
                "clowder:a",
                keys::TYPE,
                Some("clowder"),
                "2026-01-01T10:00:01Z",
            ),
            entry(
                "w",
                2,
                "clowder:b",
                keys::TYPE,
                Some("clowder"),
                "2026-01-01T10:00:02Z",
            ),
            entry(
                "w",
                3,
                "clowder:b",
                keys::NAME,
                Some("Barn"),
                "2026-01-01T10:00:03Z",
            ),
            entry(
                "w",
                4,
                "cat:c",
                keys::TYPE,
                Some("cat"),
                "2026-01-01T10:00:04Z",
            ),
            entry(
                "w",
                5,
                "cat:c",
                keys::CLOWDER,
                Some("clowder:b"),
                "2026-01-01T10:00:05Z",
            ),
            entry(
                "w",
                6,
                "clowder:b",
                keys::MERGED_INTO,
                Some("clowder:a"),
                "2026-01-01T10:00:06Z",
            ),
        ])
        .unwrap();
        assert_eq!(c.resolve_entity("clowder:b").unwrap(), "clowder:a");
        assert_eq!(c.clowders().unwrap().len(), 1);
        assert_eq!(
            c.current("clowder:a", keys::NAME).unwrap().as_deref(),
            Some("Barn")
        );
        assert_eq!(
            c.current("cat:c", keys::CLOWDER).unwrap().as_deref(),
            Some("clowder:a")
        );
        assert_eq!(c.cats(Some("clowder:a")).unwrap().len(), 1);
        assert_eq!(c.canonical_key("f:x").unwrap(), "f:x");
    }

    #[test]
    fn a_void_marker_hides_a_row_until_it_is_restored() {
        let (_dir, mut c) = catalog();
        c.apply_entries(vec![
            entry(
                "w",
                1,
                "cat:a",
                "f:color",
                Some("black"),
                "2026-01-01T10:00:01Z",
            ),
            entry(
                "w",
                2,
                "cat:a",
                "f:color",
                Some("white"),
                "2026-01-01T10:00:02Z",
            ),
            entry(
                "w",
                3,
                "cat:a",
                &keys::voided("w", 2),
                Some("removed"),
                "2026-01-01T10:00:03Z",
            ),
        ])
        .unwrap();
        assert_eq!(
            c.current("cat:a", "f:color").unwrap().as_deref(),
            Some("black")
        );
        c.apply_entries(vec![entry(
            "w",
            4,
            "cat:a",
            &keys::voided("w", 2),
            None,
            "2026-01-01T10:00:04Z",
        )])
        .unwrap();
        assert_eq!(
            c.current("cat:a", "f:color").unwrap().as_deref(),
            Some("white")
        );
        assert_eq!(void_target("$void:w:2"), Some(("w".into(), 2)));
        assert_eq!(void_target("$void:junk"), None);
        assert_eq!(void_target("$void::2"), None);
    }

    #[test]
    fn blobs_are_verified_addressed_and_dropped_with_their_last_reference() {
        let (_dir, mut c) = catalog();
        let bytes = b"not really a jpeg";
        let hash = hex::encode(Sha256::digest(bytes));
        assert!(matches!(
            c.put_blob("00", bytes),
            Err(Error::HashMismatch(_))
        ));
        c.put_blob(&hash, bytes).unwrap();
        c.put_blob(&hash, bytes).unwrap();
        assert_eq!(c.image_bytes(&hash).as_deref(), Some(&bytes[..]));
        assert!(c.image_bytes("../etc/passwd").is_none());
        c.apply_entries(vec![
            entry(
                "w",
                1,
                "cat:a",
                keys::TYPE,
                Some("cat"),
                "2026-01-01T10:00:01Z",
            ),
            entry(
                "w",
                2,
                "cat:a",
                &keys::image(&hash),
                Some("added"),
                "2026-01-01T10:00:02Z",
            ),
        ])
        .unwrap();
        assert_eq!(c.images("cat:a").unwrap(), vec![hash.clone()]);
        assert_eq!(c.profile_image("cat:a").unwrap(), Some(hash.clone()));
        assert!(c.knows_image(&hash).unwrap());
        assert!(c.missing_blobs().unwrap().is_empty());
        c.apply_entries(vec![entry(
            "w",
            3,
            "cat:a",
            &keys::image(&hash),
            Some("deleted"),
            "2026-01-01T10:00:03Z",
        )])
        .unwrap();
        assert!(c.images("cat:a").unwrap().is_empty());
        assert!(c.image_bytes(&hash).is_none());
        assert_eq!(c.profile_image("cat:a").unwrap(), None);
    }

    #[test]
    fn missing_blobs_name_added_images_without_bytes() {
        let (_dir, mut c) = catalog();
        let hash = "a".repeat(64);
        c.apply_entries(vec![entry(
            "w",
            1,
            "cat:a",
            &keys::image(&hash),
            Some("added"),
            "2026-01-01T10:00:01Z",
        )])
        .unwrap();
        assert_eq!(c.missing_blobs().unwrap(), vec![hash]);
    }

    #[test]
    fn banned_authors_are_discarded_but_move_the_vector() {
        let (_dir, mut c) = catalog();
        c.set_local_setting("ban:author:Ada", "1").unwrap();
        let imported = c
            .apply_entries(vec![entry(
                "w",
                5,
                "cat:a",
                keys::NAME,
                Some("x"),
                "2026-01-01T10:00:01Z",
            )])
            .unwrap();
        assert!(imported.is_empty());
        assert_eq!(c.version_vector().unwrap()["w"], 5);
        c.remove_local_setting("ban:author:Ada").unwrap();
        assert!(c.local_setting("ban:author:Ada").is_none());
    }

    #[test]
    fn own_rows_beyond_the_counter_and_foreign_person_records_are_refused() {
        let (_dir, mut c) = catalog();
        let me = c.device_id();
        let refused = c
            .apply_entries(vec![
                entry(
                    &me,
                    7,
                    "cat:a",
                    keys::NAME,
                    Some("x"),
                    "2026-01-01T10:00:01Z",
                ),
                entry(
                    "w",
                    1,
                    "person:other",
                    "title",
                    Some("x"),
                    "2026-01-01T10:00:01Z",
                ),
            ])
            .unwrap();
        assert!(refused.is_empty());
        assert!(c.all_entries().unwrap().is_empty());
    }

    fn fixed_clock() -> Clock {
        let tick = std::sync::atomic::AtomicI64::new(0);
        Box::new(move || {
            let n = tick.fetch_add(1, std::sync::atomic::Ordering::SeqCst);
            chrono::DateTime::from_timestamp(1_767_261_600 + n, 0).unwrap()
        })
    }

    #[test]
    fn own_rows_are_numbered_stamped_and_projected() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        assert_eq!(c.device_id(), "me");
        assert!(matches!(
            c.append("cat:a", keys::NAME, Some("x")),
            Err(Error::NoAuthor)
        ));
        c.set_author("Ada").unwrap();
        c.set_clock(fixed_clock());
        c.create_clowder("clowder:h", "Home").unwrap();
        c.create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        c.move_cat("cat:a", None).unwrap();
        let rows = c.all_entries().unwrap();
        assert_eq!(rows.len(), 7);
        assert_eq!(rows[0].date, "2026-01-01T10:00:00.000000Z");
        assert_eq!(rows[6].dseq, 7);
        assert!(rows.iter().all(|e| e.device == "me" && e.author == "Ada"));
        assert!(c.cats(Some("clowder:h")).unwrap().is_empty());
        assert_eq!(c.cats(None).unwrap()[0].name, "Miezi");
        c.append_at(
            "cat:a",
            "f:vet",
            Some("shots"),
            Some("2026-03-01T00:00:00Z"),
            true,
        )
        .unwrap();
        assert!(c.has_reminders().unwrap());
        assert_eq!(c.current("cat:a", "f:vet").unwrap(), None);
        // Reopening keeps the id and the counter moves on from the log.
        drop(c);
        let mut c = Catalog::open_with_device(dir.path(), "other").unwrap();
        assert_eq!(c.device_id(), "me");
        c.append("cat:a", "f:color", Some("black")).unwrap();
        assert_eq!(c.all_entries().unwrap().last().unwrap().dseq, 9);
    }

    #[test]
    fn photos_added_here_are_stored_listed_and_deleted() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let one = c.add_image("cat:a", b"one").unwrap();
        let two = c.add_image("cat:a", b"two").unwrap();
        c.set_profile_image("cat:a", &two).unwrap();
        assert_eq!(c.images("cat:a").unwrap(), vec![one.clone(), two.clone()]);
        assert_eq!(
            c.profile_image("cat:a").unwrap().as_deref(),
            Some(two.as_str())
        );
        assert_eq!(c.live_images(false).unwrap().len(), 2);
        c.delete_image("cat:a", &two).unwrap();
        assert!(c.image_bytes(&two).is_none());
        assert!(c.known_deleted(&two).unwrap());
        assert!(!c.known_deleted(&one).unwrap());
        assert_eq!(
            c.profile_image("cat:a").unwrap().as_deref(),
            Some(one.as_str())
        );
    }

    #[test]
    fn private_values_stay_home_and_leave_their_trace() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.create_clowder("clowder:h", "Home").unwrap();
        c.append("clowder:h", &keys::private_field("f:phone"), Some("yes"))
            .unwrap();
        c.append("clowder:h", "f:phone", Some("555")).unwrap();
        assert!(c.is_field_private("clowder:h", "f:phone").unwrap());
        assert!(!c.is_field_private("clowder:h", keys::NAME).unwrap());
        assert_eq!(
            c.current("clowder:h", &keys::withheld("f:phone"))
                .unwrap()
                .as_deref(),
            Some("yes")
        );
        let public = c.entries_since(&BTreeMap::new(), false).unwrap();
        assert!(
            public
                .iter()
                .all(|e| e.field != "f:phone" && !e.field.starts_with("$private"))
        );
        assert!(public.iter().any(|e| e.field == keys::withheld("f:phone")));
        let all = c.entries_since(&BTreeMap::new(), true).unwrap();
        assert!(all.iter().any(|e| e.field == "f:phone"));
        let mut seen = BTreeMap::new();
        seen.insert("me".to_string(), 100);
        let late = c.entries_since(&seen, true).unwrap();
        assert!(late.iter().all(|e| e.field == "f:phone"));
        assert!(c.entries_since(&seen, false).unwrap().is_empty());
        // A Private field definition covers the field on every entity.
        c.append("fielddef:secret", keys::TYPE, Some(keys::KIND_FIELD_DEF))
            .unwrap();
        c.append("fielddef:secret", keys::PRIVATE, Some("yes"))
            .unwrap();
        assert!(c.is_field_private("clowder:h", "f:secret").unwrap());
        assert!(!c.is_field_private("fielddef:secret", keys::NAME).unwrap());
    }

    fn seeded(dir: &Path, seed: u8, author: &str) -> Catalog {
        let c = Catalog::open_with_seed(dir, [seed; 32]).unwrap();
        c.set_author(author).unwrap();
        c
    }

    fn send(from: &Catalog, to: &mut Catalog, verified: bool) -> ImportReport {
        let mut report = ImportReport::default();
        let rows = from
            .entries_since(&to.version_vector().unwrap(), false)
            .unwrap();
        let keys = from.key_records().unwrap();
        let verified_device = verified.then(|| from.device_id());
        to.apply_entries_with(rows, Some(&keys), verified_device.as_deref(), &mut report)
            .unwrap();
        report
    }

    #[test]
    fn a_new_catalog_derives_its_device_id_from_its_key_and_signs_every_row() {
        let dir = tempfile::tempdir().unwrap();
        let mut a = seeded(&dir.path().join("a"), 1, "anna");
        assert_eq!(
            a.device_id(),
            device_id_from_key(&a.signing_key().unwrap().public_key())
        );
        assert_eq!(a.signing_since(), 1);
        assert!(a.own_key_record().unwrap().self_signed());
        assert_eq!(a.key_code().unwrap().len(), 9);
        a.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        for e in a.all_entries().unwrap() {
            assert_eq!(a.verifies_entry(&e).unwrap(), Some(true), "{e:?}");
        }
        let mut forged = a.all_entries().unwrap().remove(1);
        forged.value = Some("Mauzi".into());
        assert_eq!(a.verifies_entry(&forged).unwrap(), Some(false));
        // A Catalog from before signing gets a key that starts after
        // its existing rows.
        let old = Catalog::open_with_device(&dir.path().join("old"), "old-phone").unwrap();
        assert_eq!(old.signing_since(), 1);
        assert_ne!(
            old.device_id(),
            device_id_from_key(&old.signing_key().unwrap().public_key())
        );
    }

    #[test]
    fn partner_keys_pin_on_first_use_and_forged_rows_are_refused() {
        let dir = tempfile::tempdir().unwrap();
        let mut a = seeded(&dir.path().join("a"), 1, "anna");
        let mut b = seeded(&dir.path().join("b"), 2, "bob");
        a.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        let report = send(&a, &mut b, false);
        assert_eq!(report.new_keys.len(), 1);
        assert_eq!(report.new_keys[0].trust, KeyTrust::Tofu);
        assert_eq!(
            b.pinned_key(&a.device_id()).unwrap().record.code(),
            a.key_code().unwrap()
        );
        assert_eq!(b.cats(None).unwrap()[0].name, "Miezi");
        assert_eq!(b.key_records().unwrap().len(), 2);
        // An in-person session makes the key verified.
        send(&a, &mut b, true);
        assert_eq!(
            b.pinned_key(&a.device_id()).unwrap().trust,
            KeyTrust::Verified
        );
        // A forged row under a new number is refused, the vector untouched.
        let vector = b.version_vector().unwrap()[&a.device_id()];
        let mut forged = a.all_entries().unwrap().last().unwrap().clone();
        forged.dseq += 5;
        forged.value = Some("Mauzi".into());
        let mut report = ImportReport::default();
        b.apply_entries_with(vec![forged.clone()], None, None, &mut report)
            .unwrap();
        assert_eq!(report.refused[&("anna".to_string(), a.device_id())], 1);
        assert_eq!(b.version_vector().unwrap()[&a.device_id()], vector);
        // An unsigned row above the key's since is refused too; below it
        // passes once the key says it started later.
        forged.sig = None;
        let mut report = ImportReport::default();
        b.apply_entries_with(vec![forged.clone()], None, None, &mut report)
            .unwrap();
        assert_eq!(report.refused_count(), 1);
        let late = KeyRecord::make(&a.signing_key().unwrap(), &a.device_id(), forged.dseq + 10);
        b.unpin_key(&a.device_id()).unwrap();
        b.learn_keys(&[late], None, &mut ImportReport::default(), &HashMap::new())
            .unwrap();
        let mut report = ImportReport::default();
        let applied = b
            .apply_entries_with(vec![forged], None, None, &mut report)
            .unwrap();
        assert_eq!((applied.len(), report.refused_count()), (1, 0));
        // The real rows still arrive, offered from the start: the row
        // applied as unsigned above sits past their numbers.
        a.append("cat:m", keys::NAME, Some("Minka")).unwrap();
        let rows = a.entries_since(&BTreeMap::new(), false).unwrap();
        b.apply_entries_with(rows, None, None, &mut ImportReport::default())
            .unwrap();
        assert_eq!(
            b.current("cat:m", keys::NAME).unwrap().as_deref(),
            Some("Minka")
        );
    }

    #[test]
    fn second_keys_are_refused_impostors_reported_and_keys_travel_on() {
        let dir = tempfile::tempdir().unwrap();
        let mut a = seeded(&dir.path().join("a"), 1, "anna");
        let mut b = seeded(&dir.path().join("b"), 2, "bob");
        a.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        send(&a, &mut b, false);
        let other = SigningKey::from_seed([9u8; 32]);
        let mut report = ImportReport::default();
        b.learn_keys(
            &[KeyRecord::make(&other, &a.device_id(), 1)],
            None,
            &mut report,
            &HashMap::new(),
        )
        .unwrap();
        assert_eq!(report.changed_keys, vec![a.device_id()]);
        assert_eq!(
            b.pinned_key(&a.device_id()).unwrap().record.code(),
            a.key_code().unwrap()
        );
        // A record that does not sign itself is ignored.
        let mut fake = KeyRecord::make(&other, "someone", 1);
        fake.signature = "x".into();
        b.learn_keys(&[fake], None, &mut ImportReport::default(), &HashMap::new())
            .unwrap();
        assert!(b.pinned_key("someone").is_none());
        // A third Catalog calling itself anna, and one calling itself bob.
        let mut c = seeded(&dir.path().join("c"), 3, "anna");
        c.create_cat("cat:z", "Mauzi", None, "cat").unwrap();
        assert_eq!(
            send(&c, &mut b, false).impostors,
            vec![("anna".to_string(), c.device_id())]
        );
        let mut d = seeded(&dir.path().join("d"), 4, "bob");
        d.create_cat("cat:y", "Mimi", None, "cat").unwrap();
        assert_eq!(
            send(&d, &mut b, false).impostors,
            vec![("bob".to_string(), d.device_id())]
        );
        let mut e = seeded(&dir.path().join("e"), 5, "erik");
        e.create_cat("cat:x", "Momo", None, "cat").unwrap();
        assert!(send(&e, &mut b, false).impostors.is_empty());
        // Keys travel on: a partner's partner gets the key too.
        let mut f = seeded(&dir.path().join("f"), 6, "fay");
        let report = send(&b, &mut f, false);
        let devices: Vec<String> = report
            .new_keys
            .iter()
            .map(|k| k.record.device.clone())
            .collect();
        assert!(devices.contains(&a.device_id()) && devices.contains(&b.device_id()));
        assert_eq!(b.authors_overview().unwrap().len(), 4);
        // A device without a key is taken as unsigned.
        let mut report = ImportReport::default();
        let plain = entry(
            "old-phone",
            1,
            "cat:o",
            keys::NAME,
            Some("Oldie"),
            "2026-01-01T00:00:00Z",
        );
        b.apply_entries_with(vec![plain.clone()], None, None, &mut report)
            .unwrap();
        assert!(report.is_empty());
        assert_eq!(b.verifies_entry(&plain).unwrap(), None);
    }

    #[test]
    fn the_author_must_not_be_empty() {
        let (_dir, c) = catalog();
        assert!(c.set_author("  ").is_err());
        c.set_author(" Ada ").unwrap();
        assert_eq!(c.author().as_deref(), Some("Ada"));
    }
}
