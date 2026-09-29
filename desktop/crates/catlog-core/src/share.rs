//! A Cat as one share: the entries a poster's QR code or a share file
//! carries, chosen Field by Field, private values left home. The
//! format is the phone's: a zip with `entries.jsonl` and the photos.

use std::collections::BTreeSet;
use std::io::Write;

use base64::Engine;

use crate::Result;
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::error::Error;
use crate::keys;

const URL_MARKER: &str = "catlog-share:u:";
const DATA_MARKER: &str = "catlog-share:d:";

/// A decoded share code: a link, or the share's own bytes.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ShareQr {
    Url(String),
    Data(Vec<u8>),
}

/// The QR text for share bytes.
pub fn encode_share_data(share: &[u8]) -> String {
    format!(
        "{DATA_MARKER}{}",
        base64::engine::general_purpose::URL_SAFE.encode(share)
    )
}

/// The QR text for a link.
pub fn encode_share_url(url: &str) -> String {
    format!(
        "{URL_MARKER}{}",
        base64::engine::general_purpose::URL_SAFE.encode(url.as_bytes())
    )
}

/// Decodes a scanned share code; none when it is not a cat(a)log share.
pub fn decode_share_qr(raw: &str) -> Option<ShareQr> {
    let engine = base64::engine::general_purpose::URL_SAFE;
    if let Some(rest) = raw.strip_prefix(URL_MARKER) {
        let url = String::from_utf8(engine.decode(rest).ok()?).ok()?;
        if !(url.starts_with("http://") || url.starts_with("https://")) {
            return None;
        }
        return Some(ShareQr::Url(url));
    }
    if let Some(rest) = raw.strip_prefix(DATA_MARKER) {
        return Some(ShareQr::Data(engine.decode(rest).ok()?));
    }
    None
}

/// The rows of a share as they are emitted, numbered as they come.
struct Rows {
    out: Vec<Entry>,
    device: String,
    now: String,
}

impl Rows {
    /// Emits a value, under the date and author of the entry it won
    /// with, or under now and "share".
    fn emit(&mut self, entity: &str, field: &str, value: Option<&str>, won: Option<&Entry>) {
        self.out.push(Entry {
            seq: -1,
            device: self.device.clone(),
            dseq: self.out.len() as i64 + 1,
            entity: entity.to_string(),
            field: field.to_string(),
            value: value.map(String::from),
            date: won
                .map(|e| e.date.clone())
                .unwrap_or_else(|| self.now.clone()),
            author: won
                .map(|e| e.author.clone())
                .unwrap_or_else(|| "share".into()),
            recorded: won
                .map(|e| e.recorded.clone())
                .unwrap_or_else(|| self.now.clone()),
            reminder: false,
            sig: None,
            voided: false,
        });
    }
}

impl Catalog {
    /// The entry whose value stands for the pair, so date and author
    /// travel with the value.
    fn winner(&self, entity: &str, field: &str) -> Result<Option<Entry>> {
        let current = self.current(entity, field)?;
        Ok(self
            .field_history(entity, field, false)?
            .into_iter()
            .find(|e| e.value == current))
    }

    fn emit_current(&self, rows: &mut Rows, entity: &str, field: &str) -> Result<()> {
        match self.winner(entity, field)? {
            Some(e) => {
                let value = e.value.clone();
                rows.emit(entity, field, value.as_deref(), Some(&e));
            }
            None => {
                if let Some(value) = self.current(entity, field)? {
                    rows.emit(entity, field, Some(&value), None);
                }
            }
        }
        Ok(())
    }

    /// The share of one Cat: its type and name, its Clowder, the chosen
    /// Fields with their definitions, and with `include_photos` its
    /// photos; every value under the date and author it won with.
    /// `device` names the rows; the phone draws a random `share-…`.
    pub fn cat_share_bytes(
        &self,
        cat: &str,
        fields: &BTreeSet<String>,
        include_photos: bool,
        device: &str,
    ) -> Result<Vec<u8>> {
        let cat = self.resolve_entity(cat)?;
        let clowder = match self.current(&cat, keys::CLOWDER)? {
            Some(c) => Some(self.resolve_entity(&c)?),
            None => None,
        };
        let mut rows = Rows {
            out: Vec::new(),
            device: device.to_string(),
            now: self.now_iso(),
        };
        let defs = self.field_defs(None)?;
        // In the Fields' own order, as the phone walks them.
        let shareable: Vec<String> = defs
            .iter()
            .filter(|d| fields.contains(&d.key()) && !self.is_private(&d.id).unwrap_or(true))
            .map(|d| d.key())
            .collect();
        for def in defs.iter().filter(|d| shareable.contains(&d.key())) {
            self.emit_current(&mut rows, &def.id, keys::TYPE)?;
            for prop in [
                keys::NAME,
                keys::FIELD_TYPE,
                keys::FIELD_SCOPE,
                keys::FIELD_OPTIONS,
                keys::FIELD_ID_DISPLAY,
                keys::FIELD_LOOKUP_URL,
            ] {
                if self.current(&def.id, prop)?.is_some() {
                    self.emit_current(&mut rows, &def.id, prop)?;
                }
            }
        }
        self.emit_current(&mut rows, &cat, keys::TYPE)?;
        self.emit_current(&mut rows, &cat, keys::NAME)?;
        if let Some(home) = &clowder {
            // The Clowder under the date and author its membership won with.
            let won = self.winner(&cat, keys::CLOWDER)?;
            rows.emit(&cat, keys::CLOWDER, Some(home), won.as_ref());
        }
        for key in &shareable {
            if self.current(&cat, key)?.is_some() && !self.is_field_private(&cat, key)? {
                self.emit_current(&mut rows, &cat, key)?;
            }
        }
        let images = if include_photos {
            self.images(&cat)?
        } else {
            Vec::new()
        };
        for hash in &images {
            let field = keys::image(hash);
            if self.is_field_private(&cat, &field)? {
                continue;
            }
            self.emit_current(&mut rows, &cat, &field)?;
        }
        if include_photos && self.profile_image(&cat)?.is_some() {
            self.emit_current(&mut rows, &cat, keys::PROFILE_IMAGE)?;
        }
        if let Some(home) = &clowder {
            self.emit_current(&mut rows, home, keys::TYPE)?;
            self.emit_current(&mut rows, home, keys::NAME)?;
            for key in &shareable {
                if self.current(home, key)?.is_some() && !self.is_field_private(home, key)? {
                    self.emit_current(&mut rows, home, key)?;
                }
            }
        }
        let mut jsonl = String::new();
        for (i, e) in rows.out.iter().enumerate() {
            if i > 0 {
                jsonl.push('\n');
            }
            jsonl.push_str(&serde_json::to_string(&e.wire())?);
        }
        let mut buffer = std::io::Cursor::new(Vec::new());
        {
            let mut zip = zip::ZipWriter::new(&mut buffer);
            let options = zip::write::SimpleFileOptions::default()
                .compression_method(zip::CompressionMethod::Deflated)
                .last_modified_time(zip::DateTime::default());
            zip.start_file("entries.jsonl", options)?;
            zip.write_all(jsonl.as_bytes())
                .map_err(|e| Error::Invalid(format!("share: {e}")))?;
            let stored = zip::write::SimpleFileOptions::default()
                .compression_method(zip::CompressionMethod::Stored)
                .last_modified_time(zip::DateTime::default());
            for hash in &images {
                if let Some(bytes) = self.image_bytes(hash) {
                    zip.start_file(format!("blobs/{hash}.jpg"), stored)?;
                    zip.write_all(&bytes)
                        .map_err(|e| Error::Invalid(format!("share: {e}")))?;
                }
            }
            zip.finish()?;
        }
        Ok(buffer.into_inner())
    }
}

/// The `entries.jsonl` inside a share, as JSON values.
pub fn share_entries(share: &[u8]) -> Result<Vec<serde_json::Value>> {
    let mut archive = zip::ZipArchive::new(std::io::Cursor::new(share))?;
    let mut file = archive.by_name("entries.jsonl")?;
    let mut text = String::new();
    std::io::Read::read_to_string(&mut file, &mut text)
        .map_err(|e| Error::Invalid(format!("share: {e}")))?;
    text.lines()
        .filter(|l| !l.trim().is_empty())
        .map(|l| serde_json::from_str(l).map_err(Error::from))
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::TimeZone;
    use std::path::Path;

    #[test]
    fn the_share_of_the_fresh_cat_is_what_the_phone_writes() {
        let dir = tempfile::tempdir().unwrap();
        // The reader's own starter rows date before the writer's, so the
        // writer's win, as they do on the phone that made the fixture.
        let mut store = Catalog::open_with_clock(
            dir.path(),
            Box::new(|| chrono::Utc.with_ymd_and_hms(2025, 12, 31, 0, 0, 0).unwrap()),
        )
        .unwrap();
        store.set_author("Reader").unwrap();
        let fixture = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../fixtures/fresh");
        store.import_folder(&fixture.join("folder"), None).unwrap();
        let fields: BTreeSet<String> = ["f:gender", "f:color", "f:address", "f:status"]
            .into_iter()
            .map(String::from)
            .collect();
        let miezi = "cat:00000000-0000-4000-8000-000000000001";
        let bytes = store
            .cat_share_bytes(miezi, &fields, false, "share-fixed")
            .unwrap();
        let mine = share_entries(&bytes).unwrap();
        let expected: Vec<serde_json::Value> = std::fs::read_to_string(fixture.join("share.jsonl"))
            .unwrap()
            .lines()
            .filter(|l| !l.is_empty())
            .map(|l| serde_json::from_str(l).unwrap())
            .collect();
        assert_eq!(mine.len(), expected.len());
        for (a, b) in mine.iter().zip(&expected) {
            assert_eq!(a, b);
        }
        // The QR text decodes back to the bytes; junk is not a share.
        let text = encode_share_data(&bytes);
        assert!(text.starts_with("catlog-share:d:"));
        assert_eq!(decode_share_qr(&text), Some(ShareQr::Data(bytes.clone())));
        assert_eq!(
            decode_share_qr(&encode_share_url("https://example.org/x")),
            Some(ShareQr::Url("https://example.org/x".into()))
        );
        assert_eq!(decode_share_qr(&encode_share_url("ftp://x")), None);
        assert_eq!(decode_share_qr("hello"), None);
        assert_eq!(decode_share_qr("catlog-share:d:%%%"), None);
        // With photos the zip carries them and the profile choice.
        let with = store
            .cat_share_bytes(miezi, &fields, true, "share-x")
            .unwrap();
        let entries = share_entries(&with).unwrap();
        assert!(entries.iter().any(|e| e["field"] == "$profile"));
        let mut archive = zip::ZipArchive::new(std::io::Cursor::new(with)).unwrap();
        let names: Vec<String> = (0..archive.len())
            .map(|i| archive.by_index(i).unwrap().name().to_string())
            .collect();
        assert_eq!(names.iter().filter(|n| n.starts_with("blobs/")).count(), 2);
        // A private Field stays home.
        store.set_private("fielddef:gender", true).unwrap();
        let without = store
            .cat_share_bytes(miezi, &fields, false, "share-y")
            .unwrap();
        assert!(
            !share_entries(&without)
                .unwrap()
                .iter()
                .any(|e| e["field"] == "f:gender")
        );
    }
}
