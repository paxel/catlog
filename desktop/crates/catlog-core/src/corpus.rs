//! The reverse corpus: the same scenarios the Dart generator builds
//! (`packages/catalog_core/tool/fixtures/scenarios.dart`), built here
//! with the Rust core and written out as folder and bundle for the Dart
//! core to read. A Dart test imports every scenario and compares its
//! state with `rust-expected.json`, so the phones are proven to read
//! what the desk writes.

use std::path::Path;

use crate::Result;
use crate::catalog::{Catalog, Clock};

/// One scenario: a name and the writes that fill the writer's Catalog.
pub struct Scenario {
    pub name: &'static str,
    pub build: fn(&mut Catalog) -> Result<()>,
}

/// The writer's key seed in every scenario; its device id follows from it.
pub const WRITER_SEED: [u8; 32] = [0xa5; 32];

/// The writer's device id in every scenario, derived from [`WRITER_SEED`].
pub fn writer_device() -> String {
    crate::signing::device_id_from_key(
        &crate::signing::SigningKey::from_seed(WRITER_SEED).public_key(),
    )
}

/// A clock that starts at 2026-01-01 10:00 UTC and moves one second per
/// read, like the Dart generator's.
pub fn fixed_clock() -> Clock {
    let tick = std::sync::atomic::AtomicI64::new(0);
    Box::new(move || {
        let n = tick.fetch_add(1, std::sync::atomic::Ordering::SeqCst);
        chrono::DateTime::from_timestamp(1_767_261_600 + 1 + n, 0).unwrap_or_default()
    })
}

fn clowder_id(n: u32) -> String {
    format!("clowder:00000000-0000-4000-8000-{n:012}")
}

fn cat_id(n: u32) -> String {
    format!("cat:00000000-0000-4000-8000-{n:012}")
}

/// A stand-in photo: the store never decodes what it stores, so any
/// bytes travel like a JPEG would.
fn photo(w: u32, h: u32) -> Vec<u8> {
    format!("photo {w}x{h}").into_bytes()
}

fn fresh(w: &mut Catalog) -> Result<()> {
    let home = clowder_id(1);
    w.create_clowder(&home, "Foster Home")?;
    w.append(&home, "f:address", Some("Katzenweg 3, Leipzig"))?;
    w.append(&home, "f:status", Some("foster"))?;
    w.append(&home, "f:responsible", Some("Ada"))?;
    let barn = clowder_id(2);
    w.create_clowder(&barn, "Barn")?;
    w.append(&barn, "f:status", Some("barn"))?;
    let miezi = cat_id(1);
    w.create_cat(&miezi, "Miezi", Some(&home), "cat")?;
    w.append(&miezi, "f:gender", Some("female"))?;
    w.append(&miezi, "f:color", Some("tabby"))?;
    w.add_image(&miezi, &photo(40, 30))?;
    let second = w.add_image(&miezi, &photo(30, 40))?;
    w.set_profile_image(&miezi, &second)?;
    let tom = cat_id(2);
    w.create_cat(&tom, "Tom", Some(&barn), "cat")?;
    w.append(&tom, "f:gender", Some("male"))?;
    w.add_image(&tom, &photo(24, 24))?;
    w.create_cat(&cat_id(3), "Wanderer", None, "cat")?;
    Ok(())
}

/// Every scenario, in the order the Dart generator lists them.
pub fn scenarios() -> Vec<Scenario> {
    vec![Scenario {
        name: "fresh",
        build: fresh,
    }]
}

/// Writes every scenario under `root/<name>/`: `folder/`, `bundle.catsync`
/// and `rust-expected.json`, the writer's state as a partner sees it.
pub fn write_all(root: &Path) -> Result<()> {
    for scenario in scenarios() {
        let out = root.join(scenario.name);
        if out.exists() {
            std::fs::remove_dir_all(&out).map_err(|e| crate::Error::io(&out, e))?;
        }
        std::fs::create_dir_all(&out).map_err(|e| crate::Error::io(&out, e))?;
        let work = out.join("writer");
        let mut writer = Catalog::open_with_seed(&work, WRITER_SEED)?;
        writer.set_author("Rusty")?;
        writer.set_clock(fixed_clock());
        (scenario.build)(&mut writer)?;
        writer.sync_folder(&out.join("folder"), None, false)?;
        writer.write_bundle(&out.join("bundle.catsync"), false)?;
        let expected = serde_json::to_string_pretty(&writer.dump_as_partner()?)?;
        let path = out.join("rust-expected.json");
        std::fs::write(&path, format!("{expected}\n")).map_err(|e| crate::Error::io(&path, e))?;
        drop(writer);
        std::fs::remove_dir_all(&work).map_err(|e| crate::Error::io(&work, e))?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_scenario_round_trips_through_the_rust_core_itself() {
        let dir = tempfile::tempdir().unwrap();
        write_all(dir.path()).unwrap();
        write_all(dir.path()).unwrap();
        for scenario in scenarios() {
            let out = dir.path().join(scenario.name);
            let expected: serde_json::Value = serde_json::from_str(
                &std::fs::read_to_string(out.join("rust-expected.json")).unwrap(),
            )
            .unwrap();
            assert_eq!(
                expected["vector"][writer_device()],
                serde_json::json!(expected["entries"].as_array().unwrap().len())
            );
            let mut via_folder = Catalog::open(&dir.path().join("rf")).unwrap();
            let r = via_folder.import_folder(&out.join("folder"), None).unwrap();
            assert_eq!(r.report.new_keys[0].record.device, writer_device());
            // The reader pinned the writer's key; the writer's own view has none.
            let mut mine = via_folder.dump().unwrap();
            mine["keys"] = serde_json::json!([]);
            assert_eq!(mine, expected, "{} via folder", scenario.name);
            let mut via_bundle = Catalog::open(&dir.path().join("rb")).unwrap();
            via_bundle
                .import_bundle(&out.join("bundle.catsync"))
                .unwrap();
            let mut mine = via_bundle.dump().unwrap();
            mine["keys"] = serde_json::json!([]);
            assert_eq!(mine, expected, "{} via bundle", scenario.name);
        }
    }
}
