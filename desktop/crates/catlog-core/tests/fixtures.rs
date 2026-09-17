//! The fixture corpus is the specification: every scenario under
//! `desktop/fixtures/` was written by the Dart core, and the Rust core
//! must reproduce its `expected.json` after importing the folder and,
//! separately, the bundle.

use std::path::{Path, PathBuf};

use catlog_core::Catalog;

fn fixtures() -> Vec<PathBuf> {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../fixtures");
    let mut dirs: Vec<PathBuf> = std::fs::read_dir(&root)
        .expect("fixtures directory")
        .filter_map(|e| e.ok().map(|e| e.path()))
        .filter(|p| p.join("expected.json").exists())
        .collect();
    dirs.sort();
    assert!(!dirs.is_empty(), "no scenarios under {}", root.display());
    dirs
}

/// `expected.json` with the two reports moved out, so the state compares
/// on its own.
struct Expected {
    state: serde_json::Value,
    report: serde_json::Value,
    bundle_report: serde_json::Value,
    sync: serde_json::Value,
    sync_later: Option<serde_json::Value>,
    bundle: serde_json::Value,
}

fn expected(dir: &Path) -> Expected {
    let text = std::fs::read_to_string(dir.join("expected.json")).expect("expected.json");
    let mut value: serde_json::Value = serde_json::from_str(&text).expect("valid expected.json");
    let object = value.as_object_mut().expect("an object");
    let report = object.remove("report").expect("report");
    let bundle_report = object.remove("bundleReport").expect("bundleReport");
    let sync = object.remove("sync").expect("sync");
    let sync_later = object.remove("syncLater");
    let bundle = object.remove("bundle").expect("bundle");
    Expected {
        state: value,
        report,
        bundle_report,
        sync,
        sync_later,
        bundle,
    }
}

fn assert_same(
    scenario: &str,
    transport: &str,
    actual: &serde_json::Value,
    expected: &serde_json::Value,
) {
    if actual != expected {
        let a = serde_json::to_string_pretty(actual).unwrap();
        let e = serde_json::to_string_pretty(expected).unwrap();
        let first = a
            .lines()
            .zip(e.lines())
            .position(|(x, y)| x != y)
            .unwrap_or(a.lines().count().min(e.lines().count()));
        let show = |s: &str| {
            s.lines()
                .skip(first.saturating_sub(3))
                .take(8)
                .collect::<Vec<_>>()
                .join("\n")
        };
        panic!(
            "{scenario} via {transport}: state differs from expected.json at line {}\n--- rust\n{}\n--- dart\n{}",
            first + 1,
            show(&a),
            show(&e)
        );
    }
}

#[test]
fn every_scenario_imports_from_its_folder() {
    for dir in fixtures() {
        let name = dir.file_name().unwrap().to_string_lossy().into_owned();
        let tmp = tempfile::tempdir().unwrap();
        let mut catalog = Catalog::open(tmp.path()).unwrap();
        let result = catalog.import_folder(&dir.join("folder"), None).unwrap();
        let expected = expected(&dir);
        assert_same(&name, "folder round", &result.to_json(), &expected.sync);
        assert_same(
            &name,
            "folder report",
            &result.report.to_json(),
            &expected.report,
        );
        // A second folder, for photos that arrive after the entries.
        if let Some(later) = &expected.sync_later {
            let result = catalog
                .import_folder(&dir.join("folder-later"), None)
                .unwrap();
            assert_same(&name, "later round", &result.to_json(), later);
        }
        assert_same(&name, "folder", &catalog.dump().unwrap(), &expected.state);
    }
}

#[test]
fn every_scenario_imports_from_its_bundle() {
    for dir in fixtures() {
        let name = dir.file_name().unwrap().to_string_lossy().into_owned();
        let tmp = tempfile::tempdir().unwrap();
        let mut catalog = Catalog::open(tmp.path()).unwrap();
        let result = catalog.import_bundle(&dir.join("bundle.catsync")).unwrap();
        let expected = expected(&dir);
        assert_same(&name, "bundle import", &result.to_json(), &expected.bundle);
        assert_same(
            &name,
            "bundle report",
            &result.report.to_json(),
            &expected.bundle_report,
        );
        // Where the transports legitimately differ, the bundle reader's
        // state is recorded on its own.
        let state = match std::fs::read_to_string(dir.join("expected-bundle.json")) {
            Ok(text) => serde_json::from_str(&text).expect("valid expected-bundle.json"),
            Err(_) => expected.state,
        };
        assert_same(&name, "bundle", &catalog.dump().unwrap(), &state);
    }
}
