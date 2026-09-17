use chrono::{DateTime, SecondsFormat, Utc};
use serde::{Deserialize, Serialize};

/// One immutable fact in the append-only log, as it travels on the
/// wire. `seq` is a local handle and stays out of the JSON; identity on
/// the wire is (device, dseq).
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct Entry {
    #[serde(skip)]
    pub seq: i64,
    pub device: String,
    pub dseq: i64,
    pub entity: String,
    pub field: String,
    pub value: Option<String>,
    /// Effective date stated by the keeper, ISO 8601 UTC.
    pub date: String,
    pub author: String,
    /// Wall clock at recording time, ISO 8601 UTC.
    pub recorded: String,
    #[serde(default, skip_serializing_if = "std::ops::Not::not")]
    pub reminder: bool,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub sig: Option<String>,
    #[serde(skip)]
    pub voided: bool,
}

impl Entry {
    /// Identity on the wire, as a `$void:` marker names it.
    pub fn id(&self) -> String {
        format!("{}:{}", self.device, self.dseq)
    }

    /// The entry with its timestamps in the store's fixed form.
    pub(crate) fn normalized(mut self) -> Self {
        self.date = iso(&self.date);
        self.recorded = iso(&self.recorded);
        self
    }

    /// The entry as the phones write it: timestamps in Dart's form.
    pub fn wire(&self) -> Entry {
        let mut e = self.clone();
        e.date = dart_iso(&e.date);
        e.recorded = dart_iso(&e.recorded);
        e
    }
}

/// A timestamp as the store keeps it: UTC with six fraction digits, so
/// string order is time order. Anything unparsable is kept as it came.
pub fn iso(value: &str) -> String {
    match DateTime::parse_from_rfc3339(value) {
        Ok(t) => t
            .with_timezone(&Utc)
            .to_rfc3339_opts(SecondsFormat::Micros, true),
        Err(_) => value.to_string(),
    }
}

/// A timestamp as Dart's `toIso8601String` writes it on the wire: three
/// fraction digits when the microseconds are zero, six otherwise.
pub fn dart_iso(value: &str) -> String {
    match DateTime::parse_from_rfc3339(value) {
        Ok(t) => {
            let t = t.with_timezone(&Utc);
            if t.timestamp_subsec_micros() % 1000 == 0 {
                t.to_rfc3339_opts(SecondsFormat::Millis, true)
            } else {
                t.to_rfc3339_opts(SecondsFormat::Micros, true)
            }
        }
        Err(_) => value.to_string(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn timestamps_are_stored_with_six_digits_and_written_like_dart() {
        assert_eq!(
            iso("2026-01-01T10:00:01.000Z"),
            "2026-01-01T10:00:01.000000Z"
        );
        assert_eq!(
            iso("2026-01-01T11:00:01+01:00"),
            "2026-01-01T10:00:01.000000Z"
        );
        assert_eq!(
            dart_iso("2026-01-01T10:00:01.000000Z"),
            "2026-01-01T10:00:01.000Z"
        );
        assert_eq!(
            dart_iso("2026-01-01T10:00:01.000500Z"),
            "2026-01-01T10:00:01.000500Z"
        );
        assert_eq!(iso("garbage"), "garbage");
        assert_eq!(dart_iso("garbage"), "garbage");
    }

    #[test]
    fn the_wire_form_matches_the_phones() {
        let line = r#"{"device":"d","dseq":1,"entity":"cat:x","field":"name","value":"Miezi","date":"2026-01-01T10:00:01.000Z","author":"Ada","recorded":"2026-01-01T10:00:01.000Z","sig":"s"}"#;
        let e: Entry = serde_json::from_str(line).unwrap();
        assert_eq!(e.id(), "d:1");
        assert!(!e.reminder);
        assert_eq!(serde_json::to_string(&e.normalized().wire()).unwrap(), line);
        let plan = r#"{"device":"d","dseq":2,"entity":"cat:x","field":"f:vet","value":null,"date":"2026-01-01T10:00:01.000Z","author":"Ada","recorded":"2026-01-01T10:00:01.000Z","reminder":true}"#;
        let p: Entry = serde_json::from_str(plan).unwrap();
        assert!(p.reminder && p.value.is_none() && p.sig.is_none());
        assert_eq!(serde_json::to_string(&p).unwrap(), plan);
    }
}
