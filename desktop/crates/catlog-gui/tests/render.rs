//! Render tests: ignored by default, they write a PNG into the workspace
//! `target/` directory for the maintainer to look at. They need a GPU or a
//! software Vulkan such as lavapipe.
//!
//! ```sh
//! cargo test -p catlog-gui --test render -- --ignored
//! ```

use catlog_gui::{App, SettingsFile};
use egui_kittest::Harness;
use std::path::PathBuf;

fn out(name: &str) -> PathBuf {
    let dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../target");
    std::fs::create_dir_all(&dir).expect("target dir");
    dir.join(format!("{name}.png"))
}

fn render(name: &str, intro_seen: bool) {
    let dir = tempfile::tempdir().expect("temp dir");
    let mut file = SettingsFile::load(dir.path());
    file.settings.locale = Some("en".into());
    file.settings.intro_seen = intro_seen;
    file.settings.author = Some("Ada".into());
    let mut harness = Harness::builder()
        .with_size(egui::vec2(1440.0, 900.0))
        .wgpu()
        .build_ui_state(
            |ui, app: &mut App| {
                App::install_theme(ui.ctx());
                app.show(ui);
            },
            App::new(file),
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
