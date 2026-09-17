//! Render tests: ignored by default, they write a PNG into the workspace
//! `target/` directory for the maintainer to look at. They need a GPU or a
//! software Vulkan such as lavapipe.
//!
//! ```sh
//! cargo test -p catlog-gui --test render -- --ignored
//! ```

use catlog_core::tiles::{TileCache, TileId, TileSource};
use catlog_gui::{App, Modal, Selection, SettingsFile, View};
use std::sync::Arc;

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
use egui_kittest::Harness;
use std::path::PathBuf;

fn out(name: &str) -> PathBuf {
    let dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../target");
    std::fs::create_dir_all(&dir).expect("target dir");
    dir.join(format!("{name}.png"))
}

fn render(name: &str, intro_seen: bool) {
    render_with(name, intro_seen, None, |_| {});
}

/// Renders the app, seeded from a fixture scenario when one is named,
/// after `prepare` set it up.
fn render_with(
    name: &str,
    intro_seen: bool,
    scenario: Option<&str>,
    prepare: impl FnOnce(&mut App),
) {
    let dir = tempfile::tempdir().expect("temp dir");
    let mut file = SettingsFile::load(dir.path());
    file.settings.locale = Some("en".into());
    file.settings.intro_seen = intro_seen;
    file.settings.author = Some("Ada".into());
    let tiles = TileCache::open(&dir.path().join("tiles"), Box::new(GreyTiles)).expect("tiles");
    let mut app = App::open_with(
        file,
        &dir.path().join("data"),
        Arc::new(tiles),
        Arc::new(NoGeocoder),
    )
    .expect("app");
    if let Some(scenario) = scenario {
        let fixture = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join(format!("../../fixtures/{scenario}/folder"));
        app.store_mut()
            .import_folder(&fixture, None)
            .expect("fixture");
    }
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
    let image = harness.render().expect("wgpu render");
    image.save(out(name)).expect("write png");
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_shell() {
    render("render_shell", true);
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_intro() {
    render("render_intro", false);
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_cat_page() {
    render_with("render_cat_page", true, Some("fields-all"), |app| {
        app.select(Selection::Cat(
            "cat:00000000-0000-4000-8000-000000000001".into(),
        ));
    });
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_history_page() {
    render_with(
        "render_history_page",
        true,
        Some("history-reverts"),
        |app| {
            app.select(Selection::Cat(
                "cat:00000000-0000-4000-8000-000000000001".into(),
            ));
            app.open_history("cat:00000000-0000-4000-8000-000000000001", "weight");
        },
    );
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_map() {
    render_with("render_map", true, Some("moves"), |app| {
        app.open_view(View::Map);
    });
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_sync_page() {
    render_with("render_sync_page", true, Some("fresh"), |app| {
        app.open_modal(Modal::Sync);
    });
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_cats_table() {
    render_with("render_cats_table", true, Some("fresh"), |app| {
        app.open_view(View::Cats);
        app.select(Selection::Cat(
            "cat:00000000-0000-4000-8000-000000000002".into(),
        ));
    });
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_cards() {
    render_with("render_cards", true, Some("fields-all"), |app| {
        app.open_view(View::Cats);
        app.select(Selection::Cat(
            "cat:00000000-0000-4000-8000-000000000001".into(),
        ));
        app.select(Selection::Cat(
            "cat:00000000-0000-4000-8000-000000000002".into(),
        ));
    });
}
