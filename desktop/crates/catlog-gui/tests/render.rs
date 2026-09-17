//! Render tests: ignored by default, they write a PNG into the workspace
//! `target/` directory for the maintainer to look at. They need a GPU or a
//! software Vulkan such as lavapipe.
//!
//! ```sh
//! cargo test -p catlog-gui --test render -- --ignored
//! ```

use catlog_gui::{App, Selection, SettingsFile};
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
    let mut app = App::open(file, &dir.path().join("data")).expect("app");
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
