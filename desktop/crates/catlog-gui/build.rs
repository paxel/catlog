//! Generates the string tables from the phone app's ARB files, so the
//! desktop and the phones share every translation.

use std::path::Path;

fn main() {
    let manifest = Path::new(env!("CARGO_MANIFEST_DIR"));
    let phone = manifest.join("../../../lib/l10n");
    let desktop = manifest.join("../../l10n");
    println!("cargo:rerun-if-changed={}", phone.display());
    println!("cargo:rerun-if-changed={}", desktop.display());
    let source = match catlog_l10n::generate_dirs(&[&phone, &desktop], "en") {
        Ok(s) => s,
        Err(e) => {
            println!("cargo:warning=l10n: {e}");
            std::process::exit(1);
        }
    };
    let out = Path::new(&std::env::var("OUT_DIR").expect("OUT_DIR")).join("l10n.rs");
    std::fs::write(&out, source).expect("write l10n.rs");
}
