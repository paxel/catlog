//! A calendar file: one VEVENT per plan, all-day for reminders, timed
//! with an alarm for appointments, folded at 75 octets as the standard
//! asks. Byte-for-byte what the phone writes.

use chrono::{DateTime, NaiveDateTime, Utc};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct IcsEvent {
    pub uid: String,
    /// The day of an all-day event, or the local start of a timed one.
    pub start: NaiveDateTime,
    /// The local end of a timed event; none for all-day.
    pub end: Option<NaiveDateTime>,
    pub summary: String,
    pub description: String,
    /// A VALARM this many minutes before the start.
    pub alert_minutes_before: Option<u32>,
}

impl IcsEvent {
    pub fn all_day(&self) -> bool {
        self.end.is_none()
    }
}

/// The calendar file for `events`, stamped `stamp`.
pub fn write_ics(events: &[IcsEvent], stamp: DateTime<Utc>) -> String {
    let mut b = String::new();
    b.push_str("BEGIN:VCALENDAR\r\n");
    b.push_str("VERSION:2.0\r\n");
    b.push_str("PRODID:-//cat(a)log//reminders//EN\r\n");
    let dtstamp = format!("{}Z", stamp.naive_utc().format("%Y%m%dT%H%M%S"));
    for e in events {
        b.push_str("BEGIN:VEVENT\r\n");
        b.push_str(&fold(&format!("UID:{}\r\n", escape(&e.uid))));
        b.push_str(&format!("DTSTAMP:{dtstamp}\r\n"));
        match e.end {
            Some(end) => {
                b.push_str(&format!("DTSTART:{}\r\n", local(e.start)));
                b.push_str(&format!("DTEND:{}\r\n", local(end)));
            }
            None => {
                let day = e.start.date();
                let next = day + chrono::Days::new(1);
                b.push_str(&format!("DTSTART;VALUE=DATE:{}\r\n", day.format("%Y%m%d")));
                b.push_str(&format!("DTEND;VALUE=DATE:{}\r\n", next.format("%Y%m%d")));
            }
        }
        b.push_str(&fold(&format!("SUMMARY:{}\r\n", escape(&e.summary))));
        b.push_str(&fold(&format!(
            "DESCRIPTION:{}\r\n",
            escape(&e.description)
        )));
        if let Some(minutes) = e.alert_minutes_before {
            b.push_str("BEGIN:VALARM\r\n");
            b.push_str("ACTION:DISPLAY\r\n");
            b.push_str(&fold(&format!("DESCRIPTION:{}\r\n", escape(&e.summary))));
            b.push_str(&format!("TRIGGER:-PT{minutes}M\r\n"));
            b.push_str("END:VALARM\r\n");
        }
        b.push_str("END:VEVENT\r\n");
    }
    b.push_str("END:VCALENDAR\r\n");
    b
}

fn local(d: NaiveDateTime) -> String {
    d.format("%Y%m%dT%H%M%S").to_string()
}

fn escape(s: &str) -> String {
    s.replace('\\', "\\\\")
        .replace(';', "\\;")
        .replace(',', "\\,")
        .replace("\r\n", "\\n")
        .replace('\n', "\\n")
}

/// Folds one content line (ending in CRLF) at 75 octets: continuation
/// lines start with a space.
fn fold(line: &str) -> String {
    const MAX: usize = 73;
    let body = line.strip_suffix("\r\n").unwrap_or(line);
    let mut out = String::new();
    let mut piece = String::new();
    let mut octets = 0;
    let mut first = true;
    for c in body.chars() {
        let len = c.len_utf8();
        let budget = if first { MAX } else { MAX - 1 };
        if octets + len > budget {
            if !first {
                out.push(' ');
            }
            out.push_str(&piece);
            out.push_str("\r\n");
            piece.clear();
            octets = 0;
            first = false;
        }
        piece.push(c);
        octets += len;
    }
    if !piece.is_empty() || first {
        if !first {
            out.push(' ');
        }
        out.push_str(&piece);
        out.push_str("\r\n");
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::{NaiveDate, TimeZone};

    fn at(y: i32, m: u32, d: u32, h: u32, min: u32) -> NaiveDateTime {
        NaiveDate::from_ymd_opt(y, m, d)
            .unwrap()
            .and_hms_opt(h, min, 0)
            .unwrap()
    }

    #[test]
    fn an_all_day_event_per_plan_folded_within_75_octets() {
        let ics = write_ics(
            &[IcsEvent {
                uid: "catlog-cat-x-f-vaccine@catlog".into(),
                start: at(2029, 5, 4, 0, 0),
                end: None,
                summary: "Miezi — Impfung".into(),
                description: "Auffrischung, mit Umlauten öäü".into(),
                alert_minutes_before: None,
            }],
            Utc.with_ymd_and_hms(2026, 8, 25, 12, 0, 0).unwrap(),
        );
        assert!(ics.starts_with("BEGIN:VCALENDAR\r\nVERSION:2.0\r\n"));
        assert!(ics.contains("DTSTAMP:20260825T120000Z\r\n"));
        assert!(ics.contains("DTSTART;VALUE=DATE:20290504\r\n"));
        assert!(ics.contains("DTEND;VALUE=DATE:20290505\r\n"));
        assert!(ics.contains("SUMMARY:Miezi — Impfung\r\n"));
        assert!(ics.contains("DESCRIPTION:Auffrischung\\, mit Umlauten öäü\r\n"));
        assert!(ics.contains("UID:catlog-cat-x-f-vaccine@catlog\r\n"));
        assert!(!ics.contains("VALARM"));
        assert!(ics.ends_with("END:VEVENT\r\nEND:VCALENDAR\r\n"));
        for line in ics.split("\r\n") {
            assert!(line.len() <= 75, "{line}");
        }
    }

    #[test]
    fn a_timed_event_carries_its_alarm_and_long_lines_fold() {
        let long = "ä".repeat(80);
        let ics = write_ics(
            &[IcsEvent {
                uid: "catlog-appt-1@catlog".into(),
                start: at(2029, 5, 4, 14, 30),
                end: Some(at(2029, 5, 4, 15, 30)),
                summary: "Neutering — 3 cats".into(),
                description: format!("Hugo; Rudi, Minka\n{long}"),
                alert_minutes_before: Some(60),
            }],
            Utc.with_ymd_and_hms(2026, 8, 25, 12, 0, 0).unwrap(),
        );
        assert!(ics.contains("DTSTART:20290504T143000\r\n"));
        assert!(ics.contains("DTEND:20290504T153000\r\n"));
        assert!(!ics.contains("VALUE=DATE"));
        assert!(ics.contains("BEGIN:VALARM\r\nACTION:DISPLAY\r\nDESCRIPTION:Neutering — 3 cats\r\nTRIGGER:-PT60M\r\nEND:VALARM\r\n"));
        assert!(ics.contains(r"DESCRIPTION:Hugo\; Rudi\, Minka\n"));
        let folded: Vec<&str> = ics.split("\r\n").filter(|l| l.starts_with(' ')).collect();
        assert!(!folded.is_empty(), "the long description folds");
        for line in ics.split("\r\n") {
            assert!(line.len() <= 75, "{line}");
        }
        // Unfolding gives the text back.
        let unfolded = ics.replace("\r\n ", "");
        assert!(unfolded.contains(&long));
    }

    #[test]
    fn an_empty_calendar_is_still_a_calendar() {
        let ics = write_ics(&[], Utc.with_ymd_and_hms(2026, 1, 1, 0, 0, 0).unwrap());
        assert_eq!(
            ics,
            "BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:-//cat(a)log//reminders//EN\r\nEND:VCALENDAR\r\n"
        );
        assert_eq!(fold("X:\r\n"), "X:\r\n");
    }
}
