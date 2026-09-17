//! Snapshot tests: the six views and one cat card, drawn over the fresh
//! fixture and compared pixel by pixel with the PNGs under
//! `tests/snapshots/`, so a change in look is deliberate. Ignored by
//! default like the render tests: they need a GPU or a software Vulkan
//! such as lavapipe; CI runs them.
//!
//! ```sh
//! cargo test -p catlog-gui --test snapshots -- --ignored
//! UPDATE_SNAPSHOTS=1 cargo test -p catlog-gui --test snapshots -- --ignored
//! ```

use std::sync::Arc;

use catlog_core::tiles::{TileCache, TileId, TileSource};
use catlog_gui::{App, Selection, SettingsFile, View};
use egui_kittest::{Harness, SnapshotOptions};

/// Tiles that never come from the network: one flat grey square each.
struct GreyTiles;

impl TileSource for GreyTiles {
    fn fetch(&self, _tile: TileId) -> Result<Vec<u8>, String> {
        let img = image::DynamicImage::new_rgb8(256, 256);
        let mut out = Vec::new();
        img.write_to(&mut std::io::Cursor::new(&mut out), image::ImageFormat::Png)
            .map_err(|e| e.to_string())?;
        Ok(out)
    }
}

struct NoGeocoder;

impl catlog_core::geocode::Geocoder for NoGeocoder {
    fn search(&self, _query: &str) -> Result<Vec<catlog_core::geocode::GeoHit>, String> {
        Ok(Vec::new())
    }
}

/// Draws the app over the fresh fixture after `prepare` set it up, and
/// compares it with the snapshot called `name`. The clock stands still
/// and motion is off, so every run draws the same picture; a little
/// slack absorbs how one GPU rasterises against another.
fn snapshot(name: &str, prepare: impl FnOnce(&mut App)) {
    let dir = tempfile::tempdir().expect("temp dir");
    let mut file = SettingsFile::load(dir.path());
    file.settings.locale = Some("en".into());
    file.settings.intro_seen = true;
    file.settings.author = Some("Ada".into());
    file.settings.eye_candy = false;
    file.settings.tips_seen = vec!["all".into()];
    let tiles = TileCache::open(&dir.path().join("tiles"), Box::new(GreyTiles)).expect("tiles");
    let mut app = App::open_with(
        file,
        &dir.path().join("data"),
        Arc::new(tiles),
        Arc::new(NoGeocoder),
    )
    .expect("app");
    let fixture =
        std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../fixtures/fresh/folder");
    app.store_mut()
        .import_folder(&fixture, None)
        .expect("fixture");
    let at = chrono::NaiveDate::from_ymd_opt(2026, 3, 10)
        .expect("a day")
        .and_hms_opt(9, 0, 0)
        .expect("a time");
    app.now = Box::new(move || at);
    prepare(&mut app);
    let mut harness = Harness::builder()
        .with_size(egui::vec2(1440.0, 900.0))
        .wgpu()
        .build_ui_state(
            |ui, app: &mut App| {
                App::install_theme(ui.ctx());
                app.show(ui);
            },
            app,
        );
    harness.run();
    let options = SnapshotOptions::default()
        .threshold(1.5)
        .failed_pixel_count_threshold(400);
    harness.snapshot_options(name, &options);
}

#[test]
#[ignore = "compares PNGs; needs a GPU or lavapipe, CI has one"]
fn home() {
    snapshot("home", |_| {});
}

#[test]
#[ignore = "compares PNGs; needs a GPU or lavapipe, CI has one"]
fn cats() {
    snapshot("cats", |app| app.open_view(View::Cats));
}

#[test]
#[ignore = "compares PNGs; needs a GPU or lavapipe, CI has one"]
fn clowders() {
    snapshot("clowders", |app| app.open_view(View::Clowders));
}

#[test]
#[ignore = "compares PNGs; needs a GPU or lavapipe, CI has one"]
fn map() {
    snapshot("map", |app| app.open_view(View::Map));
}

#[test]
#[ignore = "compares PNGs; needs a GPU or lavapipe, CI has one"]
fn agenda() {
    snapshot("agenda", |app| app.open_view(View::Agenda));
}

#[test]
#[ignore = "compares PNGs; needs a GPU or lavapipe, CI has one"]
fn vet() {
    snapshot("vet", |app| app.open_view(View::Vet));
}

#[test]
#[ignore = "compares PNGs; needs a GPU or lavapipe, CI has one"]
fn card() {
    snapshot("card", |app| {
        app.open_view(View::Cats);
        app.select(Selection::Cat(
            "cat:00000000-0000-4000-8000-000000000001".into(),
        ));
    });
}
