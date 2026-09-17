//! Render tests: ignored by default, they write a PNG into the workspace
//! `target/` directory for the maintainer to look at. They need a GPU or a
//! software Vulkan such as lavapipe.
//!
//! ```sh
//! cargo test -p catlog-gui --test render -- --ignored
//! ```

use catlog_gui::App;
use egui_kittest::Harness;
use std::path::PathBuf;

fn out(name: &str) -> PathBuf {
    let dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../target");
    std::fs::create_dir_all(&dir).expect("target dir");
    dir.join(format!("{name}.png"))
}

#[test]
#[ignore = "writes a PNG for the maintainer; needs a GPU or lavapipe"]
fn render_shell() {
    let mut harness = Harness::builder()
        .with_size(egui::vec2(1440.0, 900.0))
        .wgpu()
        .build_ui_state(
            |ui, app: &mut App| {
                App::install_theme(ui.ctx());
                app.show(ui);
            },
            App,
        );
    harness.run();
    let image = harness.render().expect("wgpu render");
    image.save(out("render_shell")).expect("write png");
}
