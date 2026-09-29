//! The crash guard: a panic is written to a report file before the app
//! goes down; the next start shows the friendly screen, offers a restart
//! and a mail with the report, and keeps the report until it is sent.

use std::path::{Path, PathBuf};

pub const CRASH_MAIL: &str = "taum@tuta.io";
pub const MAIL_BODY_LIMIT: usize = 1800;

fn crash_file(dir: &Path) -> PathBuf {
    dir.join("last_crash.txt")
}

/// The report's first lines: version, system, locale, time.
pub fn report_header(at: chrono::DateTime<chrono::Utc>) -> String {
    format!(
        "cat(a)log {}\n{} {}\nlocale {}\n{}",
        catlog_core::VERSION,
        std::env::consts::OS,
        std::env::consts::ARCH,
        sys_locale::get_locale().unwrap_or_else(|| "unknown".into()),
        at.to_rfc3339()
    )
}

/// Writes a report for a panic.
pub fn record(dir: &Path, message: &str, backtrace: &str) {
    let text = format!(
        "{}\n\n{message}\n\n{backtrace}",
        report_header(chrono::Utc::now())
    );
    let _ = std::fs::create_dir_all(dir);
    let _ = std::fs::write(crash_file(dir), text);
}

/// Installs the hook that records every panic under `dir`.
pub fn install(dir: &Path) {
    let dir = dir.to_path_buf();
    let previous = std::panic::take_hook();
    std::panic::set_hook(Box::new(move |info| {
        let backtrace = std::backtrace::Backtrace::force_capture().to_string();
        record(&dir, &info.to_string(), &backtrace);
        previous(info);
    }));
}

/// The last report, when one waits to be sent.
pub fn last_crash(dir: &Path) -> Option<String> {
    std::fs::read_to_string(crash_file(dir)).ok()
}

pub fn clear(dir: &Path) {
    let _ = std::fs::remove_file(crash_file(dir));
}

/// The report cut to what a mail carries: the head, then the frames
/// from this app, then the rest, within the limit.
pub fn mail_body(report: &str, limit: usize) -> String {
    let mut head = Vec::new();
    let mut own = Vec::new();
    let mut other = Vec::new();
    for line in report.lines() {
        let trimmed = line.trim_start();
        let frame = trimmed
            .split_once(':')
            .is_some_and(|(n, _)| !n.is_empty() && n.chars().all(|c| c.is_ascii_digit()));
        if !frame && !trimmed.starts_with("at ") {
            head.push(line);
        } else if line.contains("catlog") {
            own.push(line);
        } else {
            other.push(line);
        }
    }
    let text: String = head
        .into_iter()
        .chain(own)
        .chain(other)
        .collect::<Vec<_>>()
        .join("\n");
    text.chars().take(limit).collect()
}

/// The mailto link that carries the report.
pub fn mail_url(report: &str) -> String {
    let body = mail_body(report, MAIL_BODY_LIMIT);
    format!(
        "mailto:{CRASH_MAIL}?subject={}&body={}",
        encode("cat(a)log crash report"),
        encode(&body)
    )
}

fn encode(text: &str) -> String {
    let mut out = String::new();
    for b in text.bytes() {
        match b {
            b'A'..=b'Z' | b'a'..=b'z' | b'0'..=b'9' | b'-' | b'_' | b'.' | b'~' => {
                out.push(b as char)
            }
            _ => out.push_str(&format!("%{b:02X}")),
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_report_is_written_read_mailed_and_cleared() {
        let dir = tempfile::tempdir().unwrap();
        assert!(last_crash(dir.path()).is_none());
        record(
            dir.path(),
            "panicked at 'boom'",
            "   0: catlog_gui::app::show\n   1: std::rt::lang_start\n   2: catlog_core::x",
        );
        let report = last_crash(dir.path()).unwrap();
        let version = env!("CARGO_PKG_VERSION");
        assert!(report.starts_with(&format!("cat(a)log {version}")));
        assert!(report.contains("boom"));
        let body = mail_body(&report, 10_000);
        let catlog_first = body.find("catlog_gui::app::show").unwrap();
        let std_later = body.find("std::rt::lang_start").unwrap();
        assert!(catlog_first < std_later, "own frames come first");
        assert_eq!(mail_body(&report, 20).chars().count(), 20);
        let url = mail_url(&report);
        assert!(url.starts_with(&format!(
            "mailto:taum@tuta.io?subject=cat%28a%29log%20crash%20report&body=cat%28a%29log%20{version}"
        )));
        clear(dir.path());
        assert!(last_crash(dir.path()).is_none());
        assert!(report_header(chrono::Utc::now()).contains("locale"));
    }
}
