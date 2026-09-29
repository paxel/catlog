//! Signed entries (1.2.0): every Catalog signs what it writes with an
//! Ed25519 key made once per Catalog and bound to its device id. A
//! partner who has met the key refuses entries claiming that device
//! without a valid signature. Keys travel with the data; the first key
//! seen for a device is trusted on first use, an in-person session
//! makes it verified. Entries from before the key pass as unsigned.

use base64::Engine;
use base64::engine::general_purpose::STANDARD as BASE64;
use ed25519_dalek::{Signature, Signer, SigningKey as DalekKey, Verifier, VerifyingKey};
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use std::collections::BTreeMap;

/// This Catalog's own key.
pub struct SigningKey {
    seed: [u8; 32],
    key: DalekKey,
}

impl SigningKey {
    pub fn from_seed(seed: [u8; 32]) -> SigningKey {
        SigningKey {
            seed,
            key: DalekKey::from_bytes(&seed),
        }
    }

    pub fn generate() -> crate::Result<SigningKey> {
        let mut seed = [0u8; 32];
        getrandom::fill(&mut seed)
            .map_err(|e| crate::Error::Invalid(format!("no randomness for a key: {e}")))?;
        Ok(Self::from_seed(seed))
    }

    pub fn seed_hex(&self) -> String {
        hex::encode(self.seed)
    }

    pub fn public_key(&self) -> [u8; 32] {
        self.key.verifying_key().to_bytes()
    }

    /// The key's fingerprint: SHA-256 of the public key, hex.
    pub fn fingerprint(&self) -> String {
        key_fingerprint(&self.public_key())
    }

    /// What the UI shows next to a name: `7f3a-c21e`.
    pub fn code(&self) -> String {
        key_code(&self.public_key())
    }

    pub fn sign(&self, message: &[u8]) -> String {
        BASE64.encode(self.key.sign(message).to_bytes())
    }
}

pub fn key_fingerprint(public_key: &[u8]) -> String {
    hex::encode(Sha256::digest(public_key))
}

/// The short form of a fingerprint, for people: eight hex digits with a
/// dash.
pub fn key_code(public_key: &[u8]) -> String {
    let f = key_fingerprint(public_key);
    format!("{}-{}", &f[..4], &f[4..8])
}

/// A device id for a new Catalog, derived from its key: the first 16
/// bytes of the fingerprint as hex.
pub fn device_id_from_key(public_key: &[u8]) -> String {
    key_fingerprint(public_key)[..32].to_string()
}

/// Whether `signature` (base64) signs `message` under `public_key`. Any
/// malformed input is simply invalid.
pub fn verify_signature(public_key: &[u8], message: &[u8], signature: Option<&str>) -> bool {
    let Some(signature) = signature else {
        return false;
    };
    let Ok(key) = <[u8; 32]>::try_from(public_key) else {
        return false;
    };
    let Ok(key) = VerifyingKey::from_bytes(&key) else {
        return false;
    };
    let Ok(sig) = BASE64.decode(signature) else {
        return false;
    };
    let Ok(sig) = Signature::from_slice(&sig) else {
        return false;
    };
    key.verify(message, &sig).is_ok()
}

/// The bytes an entry's signature covers: a fixed-order JSON list, as
/// the phones build it. Dates go in as the store writes them.
#[allow(clippy::too_many_arguments)]
pub fn entry_bytes(
    device: &str,
    dseq: i64,
    entity: &str,
    field: &str,
    value: Option<&str>,
    date: &str,
    author: &str,
    recorded: &str,
    reminder: bool,
) -> Vec<u8> {
    let list = serde_json::json!([
        device, dseq, entity, field, value, date, author, recorded, reminder
    ]);
    serde_json::to_vec(&list).unwrap_or_default()
}

/// How far a pinned key is trusted: seen in a file, or met in person.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum KeyTrust {
    Tofu,
    Verified,
}

/// A key as it travels: which device it speaks for, the public key, and
/// from which of the device's entries on the signing began. The record
/// signs itself.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct KeyRecord {
    pub device: String,
    #[serde(rename = "key")]
    pub public_key_base64: String,
    pub since: i64,
    #[serde(rename = "sig")]
    pub signature: String,
}

impl KeyRecord {
    fn bytes(device: &str, public_key_base64: &str, since: i64) -> Vec<u8> {
        serde_json::to_vec(&serde_json::json!([device, public_key_base64, since]))
            .unwrap_or_default()
    }

    /// A record for `device`, signed by `key`.
    pub fn make(key: &SigningKey, device: &str, since: i64) -> KeyRecord {
        let public_key_base64 = BASE64.encode(key.public_key());
        let signature = key.sign(&Self::bytes(device, &public_key_base64, since));
        KeyRecord {
            device: device.to_string(),
            public_key_base64,
            since,
            signature,
        }
    }

    pub fn public_key(&self) -> Vec<u8> {
        BASE64.decode(&self.public_key_base64).unwrap_or_default()
    }

    /// True when the record was signed by the key it carries.
    pub fn self_signed(&self) -> bool {
        verify_signature(
            &self.public_key(),
            &Self::bytes(&self.device, &self.public_key_base64, self.since),
            Some(&self.signature),
        )
    }

    pub fn fingerprint(&self) -> String {
        key_fingerprint(&self.public_key())
    }

    pub fn code(&self) -> String {
        key_code(&self.public_key())
    }
}

/// Parses a key list as bundles and folder files carry it; anything
/// malformed is simply no keys.
pub fn parse_keys(json: &str) -> Vec<KeyRecord> {
    let Ok(values) = serde_json::from_str::<Vec<serde_json::Value>>(json) else {
        return Vec::new();
    };
    values
        .into_iter()
        .filter_map(|v| serde_json::from_value(v).ok())
        .collect()
}

/// A key this Catalog holds for a partner's device, with how far it is
/// trusted.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct PinnedKey {
    #[serde(flatten)]
    pub record: KeyRecord,
    #[serde(default = "tofu")]
    pub trust: KeyTrust,
}

fn tofu() -> KeyTrust {
    KeyTrust::Tofu
}

/// What an import found out about the people behind the entries: what
/// it refused and why, which keys it met, which it would not take.
#[derive(Debug, Default, Clone, PartialEq, Eq)]
pub struct ImportReport {
    /// Entries dropped for a missing or wrong signature, by (author,
    /// device): the count of rows.
    pub refused: BTreeMap<(String, String), usize>,
    /// Keys pinned by this import: the first time these devices spoke.
    pub new_keys: Vec<PinnedKey>,
    /// A new key calling itself by a name this Catalog already knows
    /// under another key: (name, device of the new key).
    pub impostors: Vec<(String, String)>,
    /// Devices that offered a key other than the one pinned here.
    pub changed_keys: Vec<String>,
}

impl ImportReport {
    pub fn refused_count(&self) -> usize {
        self.refused.values().sum()
    }

    pub fn is_empty(&self) -> bool {
        self.refused.is_empty()
            && self.new_keys.is_empty()
            && self.impostors.is_empty()
            && self.changed_keys.is_empty()
    }

    /// The report as the fixture corpus records it.
    pub fn to_json(&self) -> serde_json::Value {
        let refused: BTreeMap<String, usize> = self
            .refused
            .iter()
            .map(|((author, device), n)| (format!("{author}@{device}"), *n))
            .collect();
        let mut new_keys: Vec<String> = self
            .new_keys
            .iter()
            .map(|k| k.record.device.clone())
            .collect();
        new_keys.sort();
        let mut impostors: Vec<Vec<String>> = self
            .impostors
            .iter()
            .map(|(name, device)| vec![name.clone(), device.clone()])
            .collect();
        impostors.sort();
        let mut changed = self.changed_keys.clone();
        changed.sort();
        serde_json::json!({
            "refused": refused,
            "newKeys": new_keys,
            "impostors": impostors,
            "changedKeys": changed,
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_key_signs_and_verifies_and_derives_the_device_id() {
        let key = SigningKey::from_seed([7u8; 32]);
        assert_eq!(key.seed_hex(), "07".repeat(32));
        let msg = entry_bytes(
            "d",
            1,
            "cat:x",
            "name",
            Some("Miezi"),
            "t",
            "Ada",
            "t",
            false,
        );
        assert_eq!(
            String::from_utf8(msg.clone()).unwrap(),
            r#"["d",1,"cat:x","name","Miezi","t","Ada","t",false]"#
        );
        let sig = key.sign(&msg);
        assert!(verify_signature(&key.public_key(), &msg, Some(&sig)));
        assert!(!verify_signature(&key.public_key(), b"other", Some(&sig)));
        assert!(!verify_signature(&key.public_key(), &msg, None));
        assert!(!verify_signature(
            &key.public_key(),
            &msg,
            Some("not base64!")
        ));
        assert!(!verify_signature(
            &key.public_key(),
            &msg,
            Some(&BASE64.encode([0u8; 64]))
        ));
        assert!(!verify_signature(
            &key.public_key(),
            &msg,
            Some(&BASE64.encode([0u8; 3]))
        ));
        assert!(!verify_signature(&[1u8; 5], &msg, Some(&sig)));
        assert_eq!(device_id_from_key(&key.public_key()).len(), 32);
        assert_eq!(key.fingerprint().len(), 64);
        assert_eq!(key.code().len(), 9);
        assert!(SigningKey::generate().unwrap().code() != key.code());
    }

    #[test]
    fn key_records_sign_themselves_and_survive_the_wire() {
        let key = SigningKey::from_seed([9u8; 32]);
        let record = KeyRecord::make(&key, "dev", 3);
        assert!(record.self_signed());
        assert_eq!(record.code(), key.code());
        assert_eq!(record.fingerprint(), key.fingerprint());
        let json = serde_json::to_string(&record).unwrap();
        assert!(json.starts_with(r#"{"device":"dev","key":""#));
        let back = parse_keys(&format!("[{json}]"));
        assert_eq!(back, vec![record.clone()]);
        let mut forged = record.clone();
        forged.since = 1;
        assert!(!forged.self_signed());
        assert!(parse_keys("garbage").is_empty());
        assert!(parse_keys(r#"[{"device":1}]"#).is_empty());
        let pinned: PinnedKey = serde_json::from_str(&json).unwrap();
        assert_eq!(pinned.trust, KeyTrust::Tofu);
        let verified = PinnedKey {
            record,
            trust: KeyTrust::Verified,
        };
        let text = serde_json::to_string(&verified).unwrap();
        assert!(text.contains(r#""trust":"verified""#));
        assert_eq!(serde_json::from_str::<PinnedKey>(&text).unwrap(), verified);
    }

    #[test]
    fn a_report_counts_and_serializes_sorted() {
        let mut report = ImportReport::default();
        assert!(report.is_empty());
        *report
            .refused
            .entry(("anna".into(), "d".into()))
            .or_insert(0) += 2;
        report.changed_keys.push("z".into());
        report.changed_keys.push("a".into());
        report.impostors.push(("bob".into(), "x".into()));
        assert_eq!(report.refused_count(), 2);
        assert!(!report.is_empty());
        let json = report.to_json();
        assert_eq!(json["refused"]["anna@d"], 2);
        assert_eq!(json["changedKeys"], serde_json::json!(["a", "z"]));
        assert_eq!(json["impostors"], serde_json::json!([["bob", "x"]]));
        assert_eq!(json["newKeys"], serde_json::json!([]));
    }
}
