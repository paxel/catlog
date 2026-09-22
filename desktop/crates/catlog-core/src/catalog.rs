//! The Catalog: an append-only entry log over SQLite with a latest-wins
//! projection (ADR 0001). Photo bytes live outside the log in a
//! content-addressed directory next to the database.

use std::cell::RefCell;
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

/// What a Catalog costs on disk.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub struct StorageUsage {
    pub db_bytes: u64,
    pub photo_bytes: u64,
    pub photo_count: u64,
}

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

/// SQL column: whether the row is voided, for reads that keep hidden
/// rows and mark them.
const VOIDED_COLUMN: &str = "EXISTS (SELECT 1 FROM voids \
    WHERE voids.device = entries.device AND voids.dseq = entries.dseq) AS voided";

/// Collapses re-asserted copies (identical fact, different device/dseq)
/// so unmark-private and merge re-assertions never double diary rows.
fn dedupe(rows: Vec<Entry>) -> Vec<Entry> {
    let mut seen = HashSet::new();
    rows.into_iter()
        .filter(|e| {
            seen.insert(format!(
                "{} {} {:?} {} {} {}",
                e.entity, e.field, e.value, e.date, e.author, e.recorded
            ))
        })
        .collect()
}

/// Where a Catalog reads the wall clock for what it records.
pub type Clock = Box<dyn Fn() -> chrono::DateTime<chrono::Utc> + Send>;

pub struct Catalog {
    db: Connection,
    images: PathBuf,
    clock: Clock,
    /// What every read needs first, kept between writes: the merge map
    /// and the deleted set were a full scan of the log per value read,
    /// which made every list quadratic in the catalog's size.
    cache: RefCell<Cache>,
}

/// The read cache and the generation it belongs to. Every write to the
/// log or the voids bumps the generation and drops the maps; the desk
/// keeps its own views by the same number.
#[derive(Default)]
struct Cache {
    generation: u64,
    merge_targets: Option<HashMap<String, String>>,
    deleted: Option<HashSet<String>>,
}

/// The local setting that counts the history's shrinks (ADR 0010).
const HISTORY_GENERATION_KEY: &str = "historyGeneration";

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

    /// [`Catalog::open`] with the clock fixed from the first row on: the
    /// starter Fields are seeded under it, so tests can put a Catalog
    /// before or after another in time.
    pub fn open_with_clock(dir: &Path, clock: Clock) -> Result<Catalog> {
        std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
        let images = dir.join("images");
        std::fs::create_dir_all(&images).map_err(|e| Error::io(&images, e))?;
        let db = Connection::open(dir.join("catalog.db"))?;
        Self::init_with(db, images, clock)
    }

    fn init(db: Connection, images: PathBuf) -> Result<Catalog> {
        Self::init_with(db, images, Box::new(chrono::Utc::now))
    }

    fn init_with(db: Connection, images: PathBuf, clock: Clock) -> Result<Catalog> {
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
               ON entries (entity, field);
             CREATE INDEX IF NOT EXISTS idx_entries_field
               ON entries (field);",
        )?;
        let catalog = Catalog {
            db,
            images,
            clock,
            cache: RefCell::new(Cache {
                // Seeded from the clock so two stores opened in a row
                // never share a number: a view built for one is stale
                // for the other.
                generation: std::time::SystemTime::now()
                    .duration_since(std::time::UNIX_EPOCH)
                    .map(|d| d.as_nanos() as u64)
                    .unwrap_or(1),
                ..Cache::default()
            }),
        };
        catalog.ensure_device_id()?;
        catalog.rebuild_voids()?;
        catalog.ensure_signing_key()?;
        let mut catalog = catalog;
        catalog.seed_starter_fields()?;
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

    /// The clock's moment, for a comparison rather than a stamp.
    pub(crate) fn now_utc(&self) -> chrono::DateTime<chrono::Utc> {
        (self.clock)()
    }

    // ------------------------------------------------------------ settings

    pub(crate) fn db(&self) -> &Connection {
        &self.db
    }

    pub(crate) fn now_iso(&self) -> String {
        self.now()
    }

    pub(crate) fn select_raw(
        &self,
        sql: &str,
        args: &[&dyn rusqlite::ToSql],
    ) -> Result<Vec<Entry>> {
        self.select(sql, args)
    }

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
        // Hidden, favourite, columns: a view reads them, so a change
        // counts as a write it must see.
        self.touch();
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

    /// The title a device's person wears, `rank|chore`.
    pub fn person_title(&self, device: &str) -> Result<Option<String>> {
        self.current(&keys::person(device), keys::PERSON_TITLE)
    }

    /// Sets this device's own title, or takes it off.
    pub fn set_own_title(&mut self, title: Option<&str>) -> Result<()> {
        let me = self.device_id();
        self.append(&keys::person(&me), keys::PERSON_TITLE, title)
    }

    /// What this Catalog costs on disk: database bytes, photo bytes and
    /// the photo count.
    pub fn storage_usage(&self) -> StorageUsage {
        let db_bytes = ["catalog.db", "catalog.db-wal"]
            .iter()
            .filter_map(|n| std::fs::metadata(self.images.with_file_name(n)).ok())
            .map(|m| m.len())
            .sum();
        let mut photo_bytes = 0;
        let mut photo_count = 0;
        if let Ok(read) = std::fs::read_dir(&self.images) {
            for entry in read.flatten() {
                if let Ok(m) = entry.metadata()
                    && m.is_file()
                {
                    photo_bytes += m.len();
                    photo_count += 1;
                }
            }
        }
        StorageUsage {
            db_bytes,
            photo_bytes,
            photo_count,
        }
    }

    /// Device-local, never-synced key/value setting.
    pub fn local_setting(&self, key: &str) -> Option<String> {
        self.raw_setting(&format!("u:{key}")).ok().flatten()
    }

    pub fn set_local_setting(&self, key: &str, value: &str) -> Result<()> {
        self.raw_set(&format!("u:{key}"), value)
    }

    /// Every local setting whose key starts with `prefix`, as (rest of
    /// the key, value).
    pub fn local_settings_by_prefix(&self, prefix: &str) -> Result<Vec<(String, String)>> {
        let full = format!("u:{prefix}");
        let mut stmt = self
            .db
            .prepare("SELECT key, value FROM local_settings WHERE key LIKE ?1 ORDER BY key")?;
        let like = format!("{}%", full.replace('%', "\\%").replace('_', "\\_"));
        let rows = stmt.query_map([like], |r| {
            Ok((r.get::<_, String>(0)?, r.get::<_, String>(1)?))
        })?;
        let mut out = Vec::new();
        for row in rows {
            let (key, value) = row?;
            if let Some(rest) = key.strip_prefix(&full) {
                out.push((rest.to_string(), value));
            }
        }
        Ok(out)
    }

    pub fn remove_local_setting(&self, key: &str) -> Result<()> {
        self.db.execute(
            "DELETE FROM local_settings WHERE key = ?1",
            [format!("u:{key}")],
        )?;
        self.touch();
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
        self.touch();
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
        self.touch();
        Ok(())
    }

    /// A write happened: the read cache is stale and the generation
    /// moves on.
    fn touch(&self) {
        let mut cache = self.cache.borrow_mut();
        cache.generation += 1;
        cache.merge_targets = None;
        cache.deleted = None;
    }

    /// Counts the writes to this store since it was opened. A view that
    /// remembers the number it was built for knows whether to rebuild.
    pub fn generation(&self) -> u64 {
        self.cache.borrow().generation
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

    /// When each entity was last written to: the newest `recorded`
    /// stamp per entity, for a "last change" column.
    pub fn last_recorded(&self) -> Result<BTreeMap<String, String>> {
        let mut stmt = self
            .db
            .prepare("SELECT entity, MAX(recorded) FROM entries GROUP BY entity")?;
        let rows = stmt.query_map([], |r| Ok((r.get::<_, String>(0)?, r.get::<_, String>(1)?)))?;
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
    pub(crate) fn next_dseq(&self, device: &str) -> Result<i64> {
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
    pub(crate) fn insert_own(
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
        self.touch();
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

    /// Appends a row the store seeds itself, under the seed author.
    pub(crate) fn append_seed(&mut self, entity: &str, field: &str, value: &str) -> Result<()> {
        let now = self.now();
        let device = self.device_id();
        let next = self.next_dseq(&device)?;
        self.insert_own(
            &device,
            next,
            entity,
            field,
            Some(value),
            &now,
            crate::SEED_AUTHOR,
            &now,
            false,
        )
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

    /// Marks or unmarks one value private. Unmarking re-asserts the value
    /// under fresh numbers, because partners moved past the originals
    /// while they were withheld.
    pub fn set_field_private(&mut self, id: &str, field: &str, private: bool) -> Result<()> {
        if keys::is_structural(field) {
            return Err(Error::Invalid(format!(
                "{field} identifies the entity and is never private"
            )));
        }
        let entity = self.resolve_entity(id)?;
        let flag = if private { "yes" } else { "no" };
        self.append(&entity, &keys::private_field(field), Some(flag))?;
        self.append(&entity, &keys::withheld(field), Some(flag))?;
        if !private {
            self.reassert_field(&entity, field)?;
        }
        Ok(())
    }

    /// Re-asserts one field's history under fresh numbers of this
    /// device, so a value that was withheld while private reaches
    /// partners whose version vectors already moved past the originals.
    fn reassert_field(&mut self, canonical: &str, field: &str) -> Result<()> {
        let entities = self.group(canonical)?;
        let sql = format!(
            "SELECT * FROM entries WHERE entity IN ({}) AND field = ?{} {LIVE} ORDER BY device, dseq",
            placeholders(entities.len()),
            entities.len() + 1
        );
        let mut args: Vec<&dyn rusqlite::ToSql> =
            entities.iter().map(|s| s as &dyn rusqlite::ToSql).collect();
        let field_owned = field.to_string();
        args.push(&field_owned);
        let rows = self.select(&sql, &args)?;
        let device = self.device_id();
        let first = self.next_dseq(&device)?;
        for (next, e) in (first..).zip(rows) {
            self.insert_own(
                &device,
                next,
                &e.entity,
                &e.field,
                e.value.as_deref(),
                &e.date,
                &e.author,
                &e.recorded,
                false,
            )?;
        }
        Ok(())
    }

    /// True when the entity carries a Private marker.
    pub fn is_private(&self, id: &str) -> Result<bool> {
        let entity = self.resolve_entity(id)?;
        Ok(self.current(&entity, keys::PRIVATE)?.as_deref() == Some("yes"))
    }

    /// Every field this entity carries a value for, private or not.
    pub fn value_fields(&self, id: &str) -> Result<Vec<String>> {
        let entity = self.resolve_entity(id)?;
        let group = self.group(&entity)?;
        let sql = format!(
            "SELECT DISTINCT field FROM entries WHERE entity IN ({}) ORDER BY field",
            placeholders(group.len())
        );
        let mut stmt = self.db.prepare(&sql)?;
        let fields: Vec<String> = stmt
            .query_map(params_from_iter(group.iter()), |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        Ok(fields
            .into_iter()
            .filter(|f| !keys::is_structural(f))
            .collect())
    }

    /// Canonical ids of every entity that holds a value for `field`.
    pub fn entities_with_value_for(&self, field: &str) -> Result<Vec<String>> {
        let keys = self.keys_for(field)?;
        let sql = format!(
            "SELECT DISTINCT entity FROM entries WHERE field IN ({}) ORDER BY entity",
            placeholders(keys.len())
        );
        let mut stmt = self.db.prepare(&sql)?;
        let ids: Vec<String> = stmt
            .query_map(params_from_iter(keys.iter()), |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        let mut out: Vec<String> = Vec::new();
        for id in ids {
            let canonical = self.resolve_entity(&id)?;
            if !out.contains(&canonical) {
                out.push(canonical);
            }
        }
        Ok(out)
    }

    /// Marks or unmarks an entity (Cat, Clowder, field definition)
    /// Private: every value it has now, and every value it gets while
    /// the switch is on. Unmarking re-asserts the entity's whole history
    /// under fresh numbers, so partners past the withheld originals
    /// receive it.
    pub fn set_private(&mut self, id: &str, private: bool) -> Result<()> {
        let canonical = self.resolve_entity(id)?;
        let flag = if private { "yes" } else { "no" };
        self.append(&canonical, keys::PRIVATE, Some(flag))?;
        if self.current(&canonical, keys::TYPE)?.as_deref() == Some(keys::KIND_FIELD_DEF) {
            // A definition's mark covers that field everywhere: only the
            // public trace that says a value is there, on every entity
            // that has one.
            let field = self.canonical_key(&format!("f:{}", &canonical["fielddef:".len()..]))?;
            for entity in self.entities_with_value_for(&field)? {
                if self.current(&entity, &keys::withheld(&field))?.as_deref() == Some(flag) {
                    continue;
                }
                self.append(&entity, &keys::withheld(&field), Some(flag))?;
            }
        } else {
            for field in self.value_fields(&canonical)? {
                if self
                    .current(&canonical, &keys::private_field(&field))?
                    .as_deref()
                    == Some(flag)
                {
                    continue;
                }
                self.append(&canonical, &keys::private_field(&field), Some(flag))?;
                self.append(&canonical, &keys::withheld(&field), Some(flag))?;
            }
        }
        if !private {
            self.reassert_group(&canonical)?;
        }
        Ok(())
    }

    fn reassert_group(&mut self, canonical: &str) -> Result<()> {
        let entities = self.group(canonical)?;
        let mut sql = format!(
            "SELECT * FROM entries WHERE (entity IN ({})",
            placeholders(entities.len())
        );
        let mut args: Vec<String> = entities.clone();
        if let Some(slug) = canonical.strip_prefix("fielddef:") {
            let keys = self.keys_for(&format!("f:{slug}"))?;
            sql.push_str(&format!(" OR field IN ({})", placeholders(keys.len())));
            args.extend(keys);
        }
        sql.push_str(&format!(
            ") AND field != ?{} {LIVE} ORDER BY device, dseq",
            args.len() + 1
        ));
        args.push(keys::PRIVATE.to_string());
        let refs: Vec<&dyn rusqlite::ToSql> =
            args.iter().map(|s| s as &dyn rusqlite::ToSql).collect();
        let rows = self.select(&sql, &refs)?;
        let device = self.device_id();
        let first = self.next_dseq(&device)?;
        for (next, e) in (first..).zip(rows) {
            self.insert_own(
                &device,
                next,
                &e.entity,
                &e.field,
                e.value.as_deref(),
                &e.date,
                &e.author,
                &e.recorded,
                false,
            )?;
        }
        Ok(())
    }

    /// True when any withheld marker was ever received: the cheap gate
    /// before [`Catalog::is_withheld`] is asked per field.
    pub fn has_withheld(&self) -> Result<bool> {
        Ok(self
            .db
            .query_row(
                "SELECT 1 FROM entries WHERE field LIKE ?1 LIMIT 1",
                [format!("{}%", keys::WITHHELD_PREFIX)],
                |_| Ok(()),
            )
            .optional()?
            .is_some())
    }

    /// True when a partner knows a value exists here but was not given it.
    pub fn is_withheld(&self, id: &str, field: &str) -> Result<bool> {
        let key = self.canonical_key(field)?;
        let entity = self.resolve_entity(id)?;
        Ok(
            self.current(&entity, &keys::withheld(&key))?.as_deref() == Some("yes")
                && self.current(&entity, &key)?.is_none(),
        )
    }

    // ------------------------------------------- hidden (display filter)

    /// Hidden is a per-device display filter: hidden Cats, Clowders and
    /// field definitions keep syncing unchanged, they are only not shown.
    pub fn is_hidden(&self, id: &str) -> Result<bool> {
        let entity = self.resolve_entity(id)?;
        Ok(self.local_setting(&format!("hidden:{entity}")).as_deref() == Some("1"))
    }

    pub fn set_hidden(&self, id: &str, hidden: bool) -> Result<()> {
        let key = format!("hidden:{}", self.resolve_entity(id)?);
        if hidden {
            self.set_local_setting(&key, "1")
        } else {
            self.remove_local_setting(&key)
        }
    }

    /// Canonical ids currently hidden on this device.
    pub fn hidden_ids(&self) -> Result<Vec<String>> {
        let mut stmt = self.db.prepare(
            "SELECT key FROM local_settings WHERE key LIKE 'u:hidden:%' AND value = '1' ORDER BY key",
        )?;
        let keys: Vec<String> = stmt
            .query_map([], |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        Ok(keys
            .into_iter()
            .map(|k| k["u:hidden:".len()..].to_string())
            .collect())
    }

    // -------------------------------- moderation (ADR 0006, local only)

    /// The local ban list: banned material is received and discarded on
    /// every transport; sync bookkeeping still advances. Never synced.
    pub fn ban(
        &self,
        author: Option<&str>,
        device: Option<&str>,
        blob: Option<&str>,
    ) -> Result<()> {
        if let Some(a) = author {
            self.set_local_setting(&format!("ban:author:{a}"), "1")?;
        }
        if let Some(d) = device {
            self.set_local_setting(&format!("ban:device:{d}"), "1")?;
        }
        if let Some(b) = blob {
            self.set_local_setting(&format!("ban:blob:{b}"), "1")?;
        }
        Ok(())
    }

    pub fn unban(
        &self,
        author: Option<&str>,
        device: Option<&str>,
        blob: Option<&str>,
    ) -> Result<()> {
        if let Some(a) = author {
            self.remove_local_setting(&format!("ban:author:{a}"))?;
        }
        if let Some(d) = device {
            self.remove_local_setting(&format!("ban:device:{d}"))?;
        }
        if let Some(b) = blob {
            self.remove_local_setting(&format!("ban:blob:{b}"))?;
        }
        Ok(())
    }

    /// All ban entries as (kind, value); kind is author, device or blob.
    pub fn bans(&self) -> Result<Vec<(String, String)>> {
        let mut stmt = self
            .db
            .prepare("SELECT key FROM local_settings WHERE key LIKE 'u:ban:%' ORDER BY key")?;
        let keys: Vec<String> = stmt
            .query_map([], |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        Ok(keys
            .iter()
            .filter_map(|k| {
                let rest = k.strip_prefix("u:ban:")?;
                let (kind, value) = rest.split_once(':')?;
                Some((kind.to_string(), value.to_string()))
            })
            .collect())
    }

    /// Physically deletes every entry (and orphaned photo bytes) of one
    /// author, optionally narrowed to one device. The append-only
    /// exception (ADR 0006): for abusive or illegal material only.
    /// Returns the blob hashes that were removed, so callers can ban them.
    pub fn hard_delete_author(
        &mut self,
        author: &str,
        device: Option<&str>,
    ) -> Result<Vec<String>> {
        let (where_sql, args): (String, Vec<String>) = match device {
            Some(d) => (
                "author = ?1 AND device = ?2".into(),
                vec![author.into(), d.into()],
            ),
            None => ("author = ?1".into(), vec![author.into()]),
        };
        let like = format!("{}%", keys::IMAGE_PREFIX);
        let sql = format!(
            "SELECT DISTINCT field FROM entries WHERE {where_sql} AND field LIKE ?{}",
            args.len() + 1
        );
        let mut touched_args = args.clone();
        touched_args.push(like);
        let mut stmt = self.db.prepare(&sql)?;
        let touched: Vec<String> = stmt
            .query_map(params_from_iter(touched_args.iter()), |r| r.get(0))?
            .collect::<std::result::Result<_, _>>()?;
        drop(stmt);
        self.remove_entries(&where_sql, &args, &[])?;
        let mut removed = Vec::new();
        for field in touched {
            let hash = field[keys::IMAGE_PREFIX.len()..].to_string();
            if !self.image_referenced(&hash)? && self.image_bytes(&hash).is_some() {
                self.remove_blob(&hash)?;
                removed.push(hash);
            }
        }
        Ok(removed)
    }

    /// Physically removes the entries matching `where_sql` and keeps
    /// their numbers claimed, in one transaction (ADR 0008).
    pub(crate) fn remove_entries(
        &mut self,
        where_sql: &str,
        args: &[String],
        also: &[(&str, &[&dyn rusqlite::ToSql])],
    ) -> Result<()> {
        let removed: Vec<(String, i64)> = {
            let sql =
                format!("SELECT device, MAX(dseq) FROM entries WHERE {where_sql} GROUP BY device");
            let mut stmt = self.db.prepare(&sql)?;
            let rows = stmt.query_map(params_from_iter(args.iter()), |r| {
                Ok((r.get(0)?, r.get(1)?))
            })?;
            rows.collect::<std::result::Result<_, _>>()?
        };
        self.touch();
        let tx = self.db.transaction()?;
        tx.execute(
            &format!("DELETE FROM entries WHERE {where_sql}"),
            params_from_iter(args.iter()),
        )?;
        for (sql, sql_args) in also {
            tx.execute(sql, *sql_args)?;
        }
        for (device, max) in &removed {
            let key = format!("u:banvector:{device}");
            let current: i64 = tx
                .query_row(
                    "SELECT value FROM local_settings WHERE key = ?1",
                    [&key],
                    |r| r.get::<_, String>(0),
                )
                .optional()?
                .and_then(|v| v.parse().ok())
                .unwrap_or(0);
            if *max > current {
                tx.execute(
                    "INSERT OR REPLACE INTO local_settings (key, value) VALUES (?1, ?2)",
                    params![key, max.to_string()],
                )?;
            }
        }
        tx.commit()?;
        // The history shrank: what the folder holds of it is rewritten
        // from the start on the next publish (ADR 0010).
        self.set_local_setting(
            HISTORY_GENERATION_KEY,
            &(self.history_generation() + 1).to_string(),
        )?;
        self.rebuild_voids()
    }

    /// How many times rows were physically removed from this store —
    /// going back, hard delete, keep mine. The folder's manifest carries
    /// it, so a reader knows when the segments were rewritten (ADR 0010).
    pub fn history_generation(&self) -> i64 {
        self.local_setting(HISTORY_GENERATION_KEY)
            .and_then(|v| v.parse().ok())
            .unwrap_or(0)
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

    /// [`Catalog::apply_entries`] with the sender's version vector, which
    /// enables conflict detection: if the sender had not seen our current
    /// entry for a field it changed, the edits were concurrent, and the
    /// field is flagged when the values differ.
    pub fn apply_entries_from(
        &mut self,
        entries: Vec<Entry>,
        sender_vector: &HashMap<String, i64>,
        keys: Option<&[KeyRecord]>,
        verified_device: Option<&str>,
        report: &mut ImportReport,
    ) -> Result<Vec<Entry>> {
        let touched: Vec<(String, String)> = {
            let mut seen = HashSet::new();
            entries
                .iter()
                .filter(|e| seen.insert((e.entity.clone(), e.field.clone())))
                .map(|e| (e.entity.clone(), e.field.clone()))
                .collect()
        };
        // Snapshot the pre-import winner of every field this batch
        // touches; a plan must not pose as the pre-import winner.
        let mut pre: HashMap<(String, String), Entry> = HashMap::new();
        for (entity, field) in &touched {
            let rows = self.select(
                &format!(
                    "SELECT * FROM entries WHERE entity = ?1 AND field = ?2 AND reminder = 0 {LIVE} {LATEST} LIMIT 1"
                ),
                &[entity, field],
            )?;
            if let Some(row) = rows.into_iter().next() {
                pre.insert((entity.clone(), field.clone()), row);
            }
        }
        let imported = self.apply_entries_with(entries, keys, verified_device, report)?;
        let author = self
            .author()
            .unwrap_or_else(|| crate::SEED_AUTHOR.to_string());
        for e in &imported {
            if !keys::is_conflictable(&e.field) {
                continue;
            }
            let Some(before) = pre.get(&(e.entity.clone(), e.field.clone())) else {
                continue;
            };
            if e.value == before.value {
                continue;
            }
            let sender_saw_it =
                sender_vector.get(&before.device).copied().unwrap_or(0) >= before.dseq;
            if sender_saw_it {
                continue;
            }
            // Two devices grew a choice field's list at once: no fight to
            // settle, both lists merge.
            if e.field == keys::FIELD_OPTIONS || e.field.starts_with(keys::FIELD_OPTIONS_PREFIX) {
                self.merge_option_lists(
                    &e.entity,
                    &e.field,
                    before.value.as_deref(),
                    e.value.as_deref(),
                    &author,
                )?;
                continue;
            }
            if !self.has_conflict(&e.entity, &e.field)? {
                self.append_as(&e.entity, &keys::conflict(&e.field), Some("open"), &author)?;
            }
        }
        Ok(imported)
    }

    /// The union of two option lists as the new current value: ours in
    /// its order, then what theirs adds, `mixed` kept last. Written only
    /// when the union differs from what wins now.
    fn merge_option_lists(
        &mut self,
        entity: &str,
        field: &str,
        ours: Option<&str>,
        theirs: Option<&str>,
        author: &str,
    ) -> Result<()> {
        let split = |v: Option<&str>| -> Vec<String> {
            v.unwrap_or_default()
                .split('\n')
                .filter(|o| !o.is_empty())
                .map(String::from)
                .collect()
        };
        let mine = split(ours);
        let mut merged = mine.clone();
        for o in split(theirs) {
            if !mine.contains(&o) {
                merged.push(o);
            }
        }
        if let Some(i) = merged.iter().position(|o| o == "mixed") {
            merged.remove(i);
            merged.push("mixed".to_string());
        }
        let now = split(self.current(entity, field)?.as_deref());
        if merged == now {
            return Ok(());
        }
        self.append_as(entity, field, Some(&merged.join("\n")), author)
    }

    /// Appends a row under an explicit author: the conflict flags the
    /// import writes carry the keeper's name, or the seed author's.
    fn append_as(
        &mut self,
        entity: &str,
        field: &str,
        value: Option<&str>,
        author: &str,
    ) -> Result<()> {
        let now = self.now();
        let device = self.device_id();
        let next = self.next_dseq(&device)?;
        self.insert_own(
            &device, next, entity, field, value, &now, author, &now, false,
        )
    }

    /// Fields with unresolved concurrent edits, as (entity, field) pairs.
    pub fn conflicts(&self) -> Result<Vec<(String, String)>> {
        let mut stmt = self.db.prepare(
            "SELECT DISTINCT entity, field FROM entries WHERE field LIKE ?1 ORDER BY entity, field",
        )?;
        let rows: Vec<(String, String)> = stmt
            .query_map([format!("{}%", keys::CONFLICT_PREFIX)], |r| {
                Ok((r.get(0)?, r.get(1)?))
            })?
            .collect::<std::result::Result<_, _>>()?;
        let mut out = Vec::new();
        for (entity, field) in rows {
            let inner = field[keys::CONFLICT_PREFIX.len()..].to_string();
            if self.current(&entity, &field)?.as_deref() == Some("open")
                && keys::is_conflictable(&inner)
            {
                out.push((entity, inner));
            }
        }
        Ok(out)
    }

    pub fn has_conflict(&self, entity: &str, field: &str) -> Result<bool> {
        Ok(self.current(entity, &keys::conflict(field))?.as_deref() == Some("open"))
    }

    /// Clears a conflict flag. The resolution syncs like any entry.
    pub fn resolve_conflict(&mut self, entity: &str, field: &str) -> Result<()> {
        self.append(entity, &keys::conflict(field), Some("resolved"))
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
        if let Some(map) = &self.cache.borrow().merge_targets {
            return Ok(map.clone());
        }
        let mut map = HashMap::new();
        for e in self.select(
            &format!("SELECT * FROM entries WHERE field = ?1 {LATEST}"),
            &[&keys::MERGED_INTO],
        )? {
            if let Some(value) = e.value {
                map.entry(e.entity).or_insert(value);
            }
        }
        self.cache.borrow_mut().merge_targets = Some(map.clone());
        Ok(map)
    }

    /// The key an entity's deletion is kept under: Cats and Clowders
    /// unite their alias group, as every read of theirs does.
    fn deleted_key(targets: &HashMap<String, String>, entity: &str) -> String {
        if Self::union_kind(entity) {
            resolve(targets, entity)
        } else {
            entity.to_string()
        }
    }

    /// The entities whose newest live deletion marker says deleted, by
    /// [`Catalog::deleted_key`]; one query, kept until the next write.
    fn deleted_set(&self) -> Result<HashSet<String>> {
        if let Some(set) = &self.cache.borrow().deleted {
            return Ok(set.clone());
        }
        let targets = self.merge_targets()?;
        let mut decided = HashSet::new();
        let mut set = HashSet::new();
        for e in self.select(
            &format!("SELECT * FROM entries WHERE field = ?1 AND reminder = 0 {LIVE} {LATEST}"),
            &[&keys::DELETED],
        )? {
            let key = Self::deleted_key(&targets, &e.entity);
            if decided.insert(key.clone()) && e.value.as_deref() == Some("true") {
                set.insert(key);
            }
        }
        self.cache.borrow_mut().deleted = Some(set.clone());
        Ok(set)
    }

    /// The losers of every merge so far.
    pub(crate) fn merge_losers(&self) -> Result<HashSet<String>> {
        Ok(self.merge_targets()?.into_keys().collect())
    }

    /// Every entity that ever carried `field`.
    pub(crate) fn entities_with_field(&self, field: &str) -> Result<Vec<String>> {
        let mut stmt = self
            .db
            .prepare("SELECT DISTINCT entity FROM entries WHERE field = ?1 ORDER BY entity")?;
        let ids = stmt.query_map([field], |r| r.get(0))?;
        Ok(ids.collect::<std::result::Result<_, _>>()?)
    }

    /// Every live row, newest by append order first: what retires a plan.
    pub(crate) fn select_live_by_append(&self) -> Result<Vec<Entry>> {
        self.select(
            &format!(
                "SELECT * FROM entries WHERE 1 {LIVE} \
                 ORDER BY recorded DESC, author DESC, device DESC, dseq DESC"
            ),
            &[],
        )
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

    /// Every entry of an entity (merged-in losers included), newest
    /// effective date first. Corrected and removed rows stay out unless
    /// `include_voided`, which brings them marked.
    pub fn timeline(&self, entity: &str, include_voided: bool) -> Result<Vec<Entry>> {
        let entities = self.entities_for(entity)?;
        let sql = format!(
            "SELECT entries.*, {VOIDED_COLUMN} FROM entries WHERE entity IN ({}) {} {LATEST}",
            placeholders(entities.len()),
            if include_voided { "" } else { LIVE }
        );
        let args: Vec<&dyn rusqlite::ToSql> =
            entities.iter().map(|s| s as &dyn rusqlite::ToSql).collect();
        Ok(dedupe(self.select_marked(&sql, &args)?))
    }

    /// Every entry of one field of an entity, newest effective date first.
    pub fn field_history(
        &self,
        entity: &str,
        field: &str,
        include_voided: bool,
    ) -> Result<Vec<Entry>> {
        let entities = self.entities_for(entity)?;
        let keys = self.keys_for(field)?;
        let sql = format!(
            "SELECT entries.*, {VOIDED_COLUMN} FROM entries WHERE entity IN ({}) AND field IN ({}) {} {LATEST}",
            placeholders(entities.len()),
            placeholders(keys.len()),
            if include_voided { "" } else { LIVE }
        );
        let args: Vec<&dyn rusqlite::ToSql> = entities
            .iter()
            .map(|s| s as &dyn rusqlite::ToSql)
            .chain(keys.iter().map(|s| s as &dyn rusqlite::ToSql))
            .collect();
        Ok(dedupe(self.select_marked(&sql, &args)?))
    }

    fn select_marked(&self, sql: &str, args: &[&dyn rusqlite::ToSql]) -> Result<Vec<Entry>> {
        let mut stmt = self.db.prepare(sql)?;
        let rows = stmt.query_map(args, |r| {
            let mut e = Self::row(r)?;
            e.voided = r.get::<_, i64>("voided")? != 0;
            Ok(e)
        })?;
        Ok(rows.collect::<std::result::Result<_, _>>()?)
    }

    /// One row by its local handle, marked when voided.
    pub fn entry_by_seq(&self, seq: i64) -> Result<Option<Entry>> {
        Ok(self
            .select_marked(
                &format!("SELECT entries.*, {VOIDED_COLUMN} FROM entries WHERE seq = ?1"),
                &[&seq],
            )?
            .into_iter()
            .next())
    }

    /// One row by its wire identity, marked when voided.
    pub fn entry_by_id(&self, device: &str, dseq: i64) -> Result<Option<Entry>> {
        Ok(self
            .select_marked(
                &format!(
                    "SELECT entries.*, {VOIDED_COLUMN} FROM entries WHERE device = ?1 AND dseq = ?2"
                ),
                &[&device, &dseq],
            )?
            .into_iter()
            .next())
    }

    /// The marker that voids or restored `entry`: who did it, when, and
    /// what replaced it (its value). None when never touched.
    pub fn void_marker(&self, entry: &Entry) -> Result<Option<Entry>> {
        self.marker(&entry.device, entry.dseq)
    }

    fn marker(&self, device: &str, dseq: i64) -> Result<Option<Entry>> {
        Ok(self
            .select(
                &format!("SELECT * FROM entries WHERE field = ?1 {LATEST} LIMIT 1"),
                &[&keys::voided(device, dseq)],
            )?
            .into_iter()
            .next())
    }

    /// The entry `entry` was corrected into, if its marker names one
    /// that is still here.
    pub fn replacement_of(&self, entry: &Entry) -> Result<Option<Entry>> {
        let Some(marker) = self.void_marker(entry)? else {
            return Ok(None);
        };
        let Some(value) = marker.value.filter(|v| v != keys::VOID_REMOVED) else {
            return Ok(None);
        };
        match void_target(&format!("{}{value}", keys::VOID_PREFIX)) {
            Some((device, dseq)) => self.entry_by_id(&device, dseq),
            None => Ok(None),
        }
    }

    /// The entry `entry` replaced, if it is a correction whose marker is
    /// still live.
    pub fn corrected_by(&self, entry: &Entry) -> Result<Option<Entry>> {
        let rows = self.select(
            &format!("SELECT * FROM entries WHERE field LIKE ?1 AND value = ?2 {LATEST}"),
            &[&format!("{}%", keys::VOID_PREFIX), &entry.id()],
        )?;
        for r in rows {
            let Some((device, dseq)) = void_target(&r.field) else {
                continue;
            };
            if self.marker(&device, dseq)?.and_then(|m| m.value) != Some(entry.id()) {
                continue;
            }
            return self.entry_by_id(&device, dseq);
        }
        Ok(None)
    }

    fn correctable(&self, seq: i64) -> Result<Entry> {
        let entry = self
            .entry_by_seq(seq)?
            .ok_or_else(|| Error::Invalid(format!("No entry with seq {seq}")))?;
        if !keys::is_correctable(&entry.field) {
            return Err(Error::Invalid(format!(
                "Field {} cannot be corrected",
                entry.field
            )));
        }
        Ok(entry)
    }

    fn set_void(&mut self, entry: &Entry, value: Option<&str>) -> Result<()> {
        self.append(
            &entry.entity,
            &keys::voided(&entry.device, entry.dseq),
            value,
        )
    }

    /// Takes one entry back: a marker hides it from the current value,
    /// the history and the graph; the row stays and [`Catalog::restore_entry`]
    /// brings it back. Taking back a correction also restores what it
    /// had replaced.
    pub fn remove_entry(&mut self, seq: i64) -> Result<()> {
        let entry = self.correctable(seq)?;
        let original = self.corrected_by(&entry)?;
        self.set_void(&entry, Some(keys::VOID_REMOVED))?;
        if let Some(original) = original {
            self.set_void(&original, None)?;
        }
        Ok(())
    }

    /// Replaces one entry with `value` as of `date` (the entry's own
    /// date by default): the new entry is written, the old one hidden
    /// and its marker names the new one. Returns the new entry.
    pub fn correct_entry(
        &mut self,
        seq: i64,
        value: Option<&str>,
        date: Option<&str>,
    ) -> Result<Entry> {
        let entry = self.correctable(seq)?;
        let device = self.device_id();
        let next = self.next_dseq(&device)?;
        self.append_at(
            &entry.entity,
            &entry.field,
            value,
            Some(date.unwrap_or(&entry.date)),
            false,
        )?;
        let fresh = self
            .entry_by_id(&device, next)?
            .ok_or_else(|| Error::Invalid("the correction did not land".into()))?;
        self.set_void(&entry, Some(&fresh.id()))?;
        Ok(fresh)
    }

    /// Brings a removed or corrected entry back. A correction that had
    /// replaced it is taken back in turn.
    pub fn restore_entry(&mut self, seq: i64) -> Result<()> {
        let entry = self.correctable(seq)?;
        let replacement = self.replacement_of(&entry)?;
        self.set_void(&entry, None)?;
        if let Some(replacement) = replacement
            && !replacement.voided
        {
            self.set_void(&replacement, Some(keys::VOID_REMOVED))?;
        }
        Ok(())
    }

    pub fn is_deleted(&self, entity: &str) -> Result<bool> {
        let key = Self::deleted_key(&self.merge_targets()?, entity);
        Ok(self.deleted_set()?.contains(&key))
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
        // A photo nobody could decode within bounds is not stored.
        if crate::photo::image_too_large(bytes) {
            return Ok(());
        }
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

    pub(crate) fn remove_blob(&self, hash: &str) -> Result<()> {
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

    pub(crate) fn image_referenced(&self, hash: &str) -> Result<bool> {
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
    fn last_recorded_names_the_newest_stamp_per_entity() {
        let (_dir, mut c) = catalog();
        c.apply_entries(vec![
            entry("w", 1, "cat:a", "name", Some("A"), "2026-01-01T10:00:01Z"),
            entry(
                "w",
                2,
                "cat:a",
                "f:color",
                Some("red"),
                "2026-02-01T10:00:01Z",
            ),
            entry("w", 3, "cat:b", "name", Some("B"), "2026-01-15T10:00:01Z"),
        ])
        .unwrap();
        let last = c.last_recorded().unwrap();
        assert!(last["cat:a"].starts_with("2026-02-01T10:00:01"));
        assert!(last["cat:b"].starts_with("2026-01-15T10:00:01"));
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
        assert!(
            c.all_entries()
                .unwrap()
                .iter()
                .all(|e| e.author == crate::SEED_AUTHOR)
        );
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
        let seeded = c.all_entries().unwrap().len();
        c.create_clowder("clowder:h", "Home").unwrap();
        c.create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        c.move_cat("cat:a", None).unwrap();
        let rows = c.all_entries().unwrap();
        assert_eq!(rows.len(), seeded + 7);
        assert_eq!(rows[seeded].date, "2026-01-01T10:00:00.000000Z");
        assert_eq!(rows[seeded + 6].dseq, seeded as i64 + 7);
        assert!(
            rows[seeded..]
                .iter()
                .all(|e| e.device == "me" && e.author == "Ada")
        );
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
        assert_eq!(
            c.all_entries().unwrap().last().unwrap().dseq,
            seeded as i64 + 9
        );
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
        assert_eq!(b.authors_overview().unwrap().len(), 9);
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
    fn unmarking_a_private_value_reasserts_it_under_fresh_numbers() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.create_clowder("clowder:h", "Home").unwrap();
        c.append("clowder:h", "f:phone", Some("555")).unwrap();
        c.set_field_private("clowder:h", "f:phone", true).unwrap();
        assert!(c.is_field_private("clowder:h", "f:phone").unwrap());
        let before = c.all_entries().unwrap().len();
        c.set_field_private("clowder:h", "f:phone", false).unwrap();
        assert!(!c.is_field_private("clowder:h", "f:phone").unwrap());
        let after = c.all_entries().unwrap();
        assert_eq!(after.len(), before + 3);
        assert_eq!(after.last().unwrap().field, "f:phone");
        assert!(c.set_field_private("clowder:h", keys::NAME, true).is_err());
    }

    #[test]
    fn histories_keep_every_change_and_corrections_hide_rows() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.set_clock(fixed_clock());
        c.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        c.append_at(
            "cat:a",
            "f:color",
            Some("black"),
            Some("2026-01-01T00:00:00Z"),
            false,
        )
        .unwrap();
        c.append_at(
            "cat:a",
            "f:color",
            Some("white"),
            Some("2026-02-01T00:00:00Z"),
            false,
        )
        .unwrap();
        let history = c.field_history("cat:a", "f:color", false).unwrap();
        assert_eq!(history.len(), 2);
        assert_eq!(history[0].value.as_deref(), Some("white"));
        let white_seq = history[0].seq;
        let black_seq = history[1].seq;
        // A correction replaces the row and names the replacement.
        let fresh = c.correct_entry(white_seq, Some("grey"), None).unwrap();
        assert_eq!(
            c.current("cat:a", "f:color").unwrap().as_deref(),
            Some("grey")
        );
        assert_eq!(c.field_history("cat:a", "f:color", false).unwrap().len(), 2);
        let all = c.field_history("cat:a", "f:color", true).unwrap();
        assert_eq!(all.len(), 3);
        let white = c.entry_by_seq(white_seq).unwrap().unwrap();
        assert!(white.voided);
        assert_eq!(c.replacement_of(&white).unwrap().unwrap().id(), fresh.id());
        assert_eq!(c.corrected_by(&fresh).unwrap().unwrap().seq, white_seq);
        assert_eq!(
            c.void_marker(&white).unwrap().unwrap().value,
            Some(fresh.id())
        );
        // Restoring the original takes the correction back.
        c.restore_entry(white_seq).unwrap();
        assert_eq!(
            c.current("cat:a", "f:color").unwrap().as_deref(),
            Some("white")
        );
        assert!(c.entry_by_seq(fresh.seq).unwrap().unwrap().voided);
        // Removing a row falls back to the one before; removing a
        // correction restores what it replaced.
        c.remove_entry(white_seq).unwrap();
        assert_eq!(
            c.current("cat:a", "f:color").unwrap().as_deref(),
            Some("black")
        );
        c.restore_entry(white_seq).unwrap();
        let fresh = c
            .correct_entry(white_seq, Some("cream"), Some("2026-03-01T00:00:00Z"))
            .unwrap();
        c.remove_entry(fresh.seq).unwrap();
        assert_eq!(
            c.current("cat:a", "f:color").unwrap().as_deref(),
            Some("white")
        );
        assert!(
            c.corrected_by(&c.entry_by_seq(black_seq).unwrap().unwrap())
                .unwrap()
                .is_none()
        );
        assert!(
            c.replacement_of(&c.entry_by_seq(black_seq).unwrap().unwrap())
                .unwrap()
                .is_none()
        );
        assert!(c.remove_entry(9999).is_err());
        let type_row = c
            .timeline("cat:a", false)
            .unwrap()
            .into_iter()
            .find(|e| e.field == keys::TYPE)
            .unwrap();
        assert!(c.remove_entry(type_row.seq).is_err());
        assert!(
            c.timeline("cat:a", true).unwrap().len() > c.timeline("cat:a", false).unwrap().len()
        );
        assert!(c.entry_by_id("nobody", 1).unwrap().is_none());
    }

    #[test]
    fn an_entity_marked_private_withholds_every_value_and_reasserts_on_unmark() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.create_clowder("clowder:h", "Home").unwrap();
        c.append("clowder:h", "f:phone", Some("555")).unwrap();
        c.append("clowder:h", "f:address", Some("Katzenweg"))
            .unwrap();
        c.set_private("clowder:h", true).unwrap();
        assert!(c.is_private("clowder:h").unwrap());
        assert_eq!(
            c.value_fields("clowder:h").unwrap(),
            vec!["f:address", "f:phone"]
        );
        let public = c.entries_since(&BTreeMap::new(), false).unwrap();
        assert!(
            public
                .iter()
                .all(|e| e.field != "f:phone" && e.field != "f:address")
        );
        assert!(
            public
                .iter()
                .any(|e| e.field == keys::NAME && e.entity == "clowder:h")
        );
        // The entity mark is a shortcut for marking what it carries now;
        // a value added later is its own decision, as on the phones.
        c.append("clowder:h", "f:email", Some("a@b")).unwrap();
        assert!(!c.is_field_private("clowder:h", "f:email").unwrap());
        assert!(c.has_withheld().unwrap());
        assert!(
            !c.is_withheld("clowder:h", "f:phone").unwrap(),
            "we hold the value"
        );
        let before = c.all_entries().unwrap().len();
        c.set_private("clowder:h", false).unwrap();
        assert!(!c.is_private("clowder:h").unwrap());
        assert!(c.all_entries().unwrap().len() > before + 4);
        assert!(
            c.entries_since(&BTreeMap::new(), false)
                .unwrap()
                .iter()
                .any(|e| e.field == "f:phone")
        );
        // A Private field definition traces every entity's value.
        c.create_clowder("clowder:k", "Other").unwrap();
        c.append("clowder:k", "f:phone", Some("777")).unwrap();
        c.set_private("fielddef:phone", true).unwrap();
        assert!(c.is_field_private("clowder:k", "f:phone").unwrap());
        assert_eq!(
            c.current("clowder:k", &keys::withheld("f:phone"))
                .unwrap()
                .as_deref(),
            Some("yes")
        );
        assert_eq!(c.entities_with_value_for("f:phone").unwrap().len(), 2);
        c.set_private("fielddef:phone", false).unwrap();
        assert!(!c.is_field_private("clowder:k", "f:phone").unwrap());
        assert_eq!(
            c.current("clowder:k", &keys::withheld("f:phone"))
                .unwrap()
                .as_deref(),
            Some("no")
        );
    }

    #[test]
    fn a_withheld_value_arrives_later_and_hidden_stays_home() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.apply_entries(vec![
            entry(
                "w",
                1,
                "clowder:h",
                keys::TYPE,
                Some("clowder"),
                "2026-01-01T10:00:01Z",
            ),
            entry(
                "w",
                2,
                "clowder:h",
                &keys::withheld("f:phone"),
                Some("yes"),
                "2026-01-01T10:00:02Z",
            ),
        ])
        .unwrap();
        assert!(c.is_withheld("clowder:h", "f:phone").unwrap());
        c.apply_entries(vec![entry(
            "w",
            3,
            "clowder:h",
            "f:phone",
            Some("555"),
            "2026-01-01T10:00:03Z",
        )])
        .unwrap();
        assert!(!c.is_withheld("clowder:h", "f:phone").unwrap());
        c.set_hidden("clowder:h", true).unwrap();
        assert!(c.is_hidden("clowder:h").unwrap());
        assert_eq!(c.hidden_ids().unwrap(), vec!["clowder:h"]);
        assert!(
            c.entries_since(&BTreeMap::new(), true)
                .unwrap()
                .iter()
                .all(|e| !e.field.contains("hidden"))
        );
        c.set_hidden("clowder:h", false).unwrap();
        assert!(c.hidden_ids().unwrap().is_empty());
    }

    #[test]
    fn bans_and_hard_delete_are_local_and_keep_numbers_claimed() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        let hash = hex::encode(Sha256::digest(b"bad photo"));
        c.put_blob(&hash, b"bad photo").unwrap();
        c.apply_entries(vec![
            entry(
                "w",
                1,
                "cat:x",
                keys::TYPE,
                Some("cat"),
                "2026-01-01T10:00:01Z",
            ),
            entry(
                "w",
                2,
                "cat:x",
                &keys::image(&hash),
                Some("added"),
                "2026-01-01T10:00:02Z",
            ),
        ])
        .unwrap();
        c.ban(Some("Ada"), Some("w"), Some(&hash)).unwrap();
        assert_eq!(c.bans().unwrap().len(), 3);
        c.unban(Some("Ada"), None, None).unwrap();
        assert_eq!(
            c.bans().unwrap(),
            vec![
                ("blob".to_string(), hash.clone()),
                ("device".to_string(), "w".to_string())
            ]
        );
        // A banned photo is dropped on receive.
        c.remove_blob(&hash).unwrap();
        c.put_blob(&hash, b"bad photo").unwrap();
        assert!(c.image_bytes(&hash).is_none());
        c.unban(None, Some("w"), Some(&hash)).unwrap();
        c.put_blob(&hash, b"bad photo").unwrap();
        let removed = c.hard_delete_author("Ada", Some("w")).unwrap();
        assert_eq!(removed, vec![hash.clone()]);
        assert!(c.all_entries().unwrap().iter().all(|e| e.device != "w"));
        assert_eq!(c.version_vector().unwrap()["w"], 2, "numbers stay claimed");
        assert!(c.image_bytes(&hash).is_none());
        // The claim stops the rows coming back.
        let again = c
            .apply_entries(vec![entry(
                "w",
                1,
                "cat:x",
                keys::TYPE,
                Some("cat"),
                "2026-01-01T10:00:01Z",
            )])
            .unwrap();
        assert_eq!(
            again.len(),
            1,
            "a held row under a claimed number is still taken by number"
        );
        assert!(c.hard_delete_author("nobody", None).unwrap().is_empty());
    }

    #[test]
    fn concurrent_edits_raise_a_conflict_and_option_lists_merge() {
        let dir = tempfile::tempdir().unwrap();
        let mut a = Catalog::open_with_device(&dir.path().join("a"), "aa").unwrap();
        a.set_author("anna").unwrap();
        let mut b = Catalog::open_with_device(&dir.path().join("b"), "bb").unwrap();
        b.set_author("bob").unwrap();
        a.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        a.append("cat:m", "f:color", Some("black")).unwrap();
        let av = a
            .version_vector()
            .unwrap()
            .into_iter()
            .collect::<HashMap<_, _>>();
        b.apply_entries_from(
            a.entries_since(&BTreeMap::new(), false).unwrap(),
            &av,
            None,
            None,
            &mut ImportReport::default(),
        )
        .unwrap();
        // Both change the colour without seeing each other.
        a.append("cat:m", "f:color", Some("white")).unwrap();
        b.append("cat:m", "f:color", Some("grey")).unwrap();
        let bv = b
            .version_vector()
            .unwrap()
            .into_iter()
            .collect::<HashMap<_, _>>();
        let rows = b
            .entries_since(&a.version_vector().unwrap(), false)
            .unwrap();
        a.apply_entries_from(rows, &bv, None, None, &mut ImportReport::default())
            .unwrap();
        assert_eq!(
            a.conflicts().unwrap(),
            vec![("cat:m".to_string(), "f:color".to_string())]
        );
        assert!(a.has_conflict("cat:m", "f:color").unwrap());
        // The same value from both sides is no fight; a seen change neither.
        let av = a
            .version_vector()
            .unwrap()
            .into_iter()
            .collect::<HashMap<_, _>>();
        b.apply_entries_from(
            a.entries_since(&b.version_vector().unwrap(), false)
                .unwrap(),
            &av,
            None,
            None,
            &mut ImportReport::default(),
        )
        .unwrap();
        assert_eq!(b.conflicts().unwrap().len(), 1, "the flag travelled");
        a.resolve_conflict("cat:m", "f:color").unwrap();
        assert!(a.conflicts().unwrap().is_empty());
        // Two devices grew the breed list at once: both lists merge.
        a.set_field_options("fielddef:breed", &["Maine Coon", "mixed"])
            .unwrap();
        b.set_field_options("fielddef:breed", &["Ragdoll", "mixed"])
            .unwrap();
        let bv = b
            .version_vector()
            .unwrap()
            .into_iter()
            .collect::<HashMap<_, _>>();
        a.apply_entries_from(
            b.entries_since(&a.version_vector().unwrap(), false)
                .unwrap(),
            &bv,
            None,
            None,
            &mut ImportReport::default(),
        )
        .unwrap();
        assert_eq!(
            a.field_def("breed").unwrap().unwrap().options,
            vec!["Maine Coon", "Ragdoll", "mixed"]
        );
        assert!(a.conflicts().unwrap().is_empty());
    }

    #[test]
    fn the_author_must_not_be_empty() {
        let (_dir, c) = catalog();
        assert!(c.set_author("  ").is_err());
        c.set_author(" Ada ").unwrap();
        assert_eq!(c.author().as_deref(), Some("Ada"));
    }
}
