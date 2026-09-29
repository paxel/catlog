//! Writes the reverse corpus for the Dart core to read:
//!
//! ```sh
//! cargo run -p catlog-core --example reverse_corpus -- target/reverse
//! cd ../packages/catalog_core && CATLOG_REVERSE_DIR=../../desktop/target/reverse dart test test/reverse_corpus_test.dart
//! ```

fn main() {
    let Some(dir) = std::env::args().nth(1) else {
        eprintln!("usage: reverse_corpus <output dir>");
        std::process::exit(2);
    };
    if let Err(e) = catlog_core::corpus::write_all(std::path::Path::new(&dir)) {
        eprintln!("reverse corpus: {e}");
        std::process::exit(1);
    }
    for s in catlog_core::corpus::scenarios() {
        println!("{}", s.name);
    }
}
