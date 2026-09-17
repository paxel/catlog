//! The phone app's ARB files are the single source of every string the
//! desktop shows. [`generate`] turns a directory of them into Rust
//! source: one table of raw ICU messages per locale and one typed
//! accessor per key, which formats through [`icu`] at run time.

pub mod icu;

use std::collections::BTreeMap;
use std::fmt::Write;
use std::path::Path;

/// One ARB file: its locale and its messages, with the placeholder
/// types the metadata declares.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Arb {
    pub locale: String,
    pub messages: BTreeMap<String, String>,
    /// Placeholder name to declared type (`String`, `int`, ...), in
    /// declaration order, per key.
    pub placeholders: BTreeMap<String, Vec<(String, String)>>,
}

/// Parses one ARB file's text.
pub fn parse_arb(text: &str) -> Result<Arb, String> {
    let json: serde_json::Value = serde_json::from_str(text).map_err(|e| e.to_string())?;
    let obj = json.as_object().ok_or("an ARB file is a JSON object")?;
    let locale = obj
        .get("@@locale")
        .and_then(|v| v.as_str())
        .ok_or("an ARB file names its @@locale")?
        .to_string();
    let mut messages = BTreeMap::new();
    let mut placeholders = BTreeMap::new();
    for (key, value) in obj {
        if key.starts_with("@@") {
            continue;
        }
        if let Some(name) = key.strip_prefix('@') {
            let mut list = Vec::new();
            if let Some(ph) = value.get("placeholders").and_then(|p| p.as_object()) {
                for (pname, meta) in ph {
                    let ty = meta
                        .get("type")
                        .and_then(|t| t.as_str())
                        .unwrap_or("Object")
                        .to_string();
                    list.push((pname.clone(), ty));
                }
            }
            placeholders.insert(name.to_string(), list);
            continue;
        }
        if let Some(s) = value.as_str() {
            messages.insert(key.clone(), s.to_string());
        }
    }
    Ok(Arb {
        locale,
        messages,
        placeholders,
    })
}

/// Reads every `<prefix>_<locale>.arb` in `dir`.
pub fn read_dir(dir: &Path) -> Result<Vec<Arb>, String> {
    let mut arbs = Vec::new();
    let entries = std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
    let mut paths: Vec<_> = entries
        .filter_map(|e| e.ok().map(|e| e.path()))
        .filter(|p| {
            p.extension().is_some_and(|x| x == "arb")
                && p.file_name()
                    .is_some_and(|n| n.to_string_lossy().contains('_'))
        })
        .collect();
    paths.sort();
    for path in paths {
        let text =
            std::fs::read_to_string(&path).map_err(|e| format!("{}: {e}", path.display()))?;
        arbs.push(parse_arb(&text).map_err(|e| format!("{}: {e}", path.display()))?);
    }
    Ok(arbs)
}

/// The placeholders a key takes, in order, with their Rust types: the
/// declared ones first, then any the English message names that the
/// metadata left out. A plural or select variable is a number.
fn params(template: &Arb, key: &str, message: &str) -> Vec<(String, &'static str)> {
    let mut out: Vec<(String, &'static str)> = Vec::new();
    let numeric = icu::variables(message)
        .into_iter()
        .filter(|(_, kind)| *kind == icu::VariableKind::Plural)
        .map(|(name, _)| name)
        .collect::<Vec<_>>();
    let rust_type = |name: &str, declared: &str| -> &'static str {
        if numeric.iter().any(|n| n == name)
            || declared == "int"
            || declared == "num"
            || declared == "double"
        {
            "i64"
        } else {
            "&str"
        }
    };
    if let Some(declared) = template.placeholders.get(key) {
        for (name, ty) in declared {
            out.push((name.clone(), rust_type(name, ty)));
        }
    }
    for (name, _) in icu::variables(message) {
        if !out.iter().any(|(n, _)| *n == name) {
            out.push((name.clone(), rust_type(&name, "Object")));
        }
    }
    out
}

const KEYWORDS: [&str; 52] = [
    "as", "break", "const", "continue", "crate", "else", "enum", "extern", "false", "fn", "for",
    "if", "impl", "in", "let", "loop", "match", "mod", "move", "mut", "pub", "ref", "return",
    "self", "Self", "static", "struct", "super", "trait", "true", "type", "unsafe", "use", "where",
    "while", "async", "await", "dyn", "abstract", "become", "box", "do", "final", "macro",
    "override", "priv", "typeof", "unsized", "virtual", "yield", "try", "gen",
];

/// `csvSavedTo` becomes `csv_saved_to`; a Rust keyword gets a trailing
/// underscore.
pub fn snake(key: &str) -> String {
    let mut out = String::new();
    for (i, c) in key.chars().enumerate() {
        if c.is_ascii_uppercase() {
            if i > 0 {
                out.push('_');
            }
            out.push(c.to_ascii_lowercase());
        } else {
            out.push(c);
        }
    }
    if KEYWORDS.contains(&out.as_str()) {
        out.push('_');
    }
    out
}

/// Generates the Rust source for the given ARB files. The locale named
/// `template` (English) defines the keys; a locale missing a key falls
/// back to the template's text.
pub fn generate(arbs: &[Arb], template: &str) -> Result<String, String> {
    let tpl = arbs
        .iter()
        .find(|a| a.locale == template)
        .ok_or_else(|| format!("no ARB for the template locale {template}"))?;
    let keys: Vec<&String> = tpl.messages.keys().collect();
    let mut out = String::new();
    let _ = writeln!(
        out,
        "// Generated by catlog-l10n from the phone app's ARB files. Do not edit."
    );
    let _ = writeln!(out, "/// Every locale the app speaks, template first.");
    let _ = write!(out, "pub const LOCALES: [&str; {}] = [", arbs.len());
    let mut ordered: Vec<&Arb> = arbs.iter().collect();
    ordered.sort_by_key(|a| (a.locale != template, a.locale.clone()));
    for a in &ordered {
        let _ = write!(out, "{:?}, ", a.locale);
    }
    let _ = writeln!(out, "];");
    let _ = writeln!(out, "const KEYS: usize = {};", keys.len());
    let _ = writeln!(out, "static MESSAGES: [[&str; KEYS]; {}] = [", arbs.len());
    for a in &ordered {
        let _ = write!(out, "    [");
        for key in &keys {
            let text = a.messages.get(*key).unwrap_or(&tpl.messages[*key]);
            let _ = write!(out, "{text:?}, ");
        }
        let _ = writeln!(out, "],");
    }
    let _ = writeln!(out, "];");
    let _ = writeln!(
        out,
        r#"
/// The strings of one locale, with a typed accessor per key.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct L10n {{
    index: usize,
}}

impl L10n {{
    /// The strings of `locale`, or the template's when it is unknown.
    pub fn new(locale: &str) -> L10n {{
        let index = LOCALES.iter().position(|l| *l == locale).unwrap_or(0);
        L10n {{ index }}
    }}

    pub fn locale(&self) -> &'static str {{
        LOCALES[self.index]
    }}

    fn raw(&self, key: usize) -> &'static str {{
        MESSAGES[self.index][key]
    }}

    /// The raw ICU message of a key by name, for tools; none for an
    /// unknown key.
    pub fn raw_by_name(&self, name: &str) -> Option<&'static str> {{
        KEY_NAMES.iter().position(|k| *k == name).map(|i| self.raw(i))
    }}
"#
    );
    for (i, key) in keys.iter().enumerate() {
        let message = &tpl.messages[*key];
        let params = params(tpl, key, message);
        let name = snake(key);
        if params.is_empty() {
            let _ = writeln!(
                out,
                "    pub fn {name}(&self) -> &'static str {{ self.raw({i}) }}"
            );
        } else {
            let sig: Vec<String> = params
                .iter()
                .map(|(n, t)| format!("{}: {t}", snake(n)))
                .collect();
            let args: Vec<String> = params
                .iter()
                .map(|(n, t)| {
                    if *t == "i64" {
                        format!("({n:?}, catlog_l10n::icu::Arg::Int({}))", snake(n))
                    } else {
                        format!("({n:?}, catlog_l10n::icu::Arg::Str({}))", snake(n))
                    }
                })
                .collect();
            let _ = writeln!(
                out,
                "    pub fn {name}(&self, {}) -> String {{ catlog_l10n::icu::format(self.locale(), self.raw({i}), &[{}]) }}",
                sig.join(", "),
                args.join(", ")
            );
        }
    }
    let _ = writeln!(out, "}}");
    let _ = write!(out, "static KEY_NAMES: [&str; KEYS] = [");
    for key in &keys {
        let _ = write!(out, "{key:?}, ");
    }
    let _ = writeln!(out, "];");
    Ok(out)
}

/// Reads `dir` and generates the source in one go.
pub fn generate_dir(dir: &Path, template: &str) -> Result<String, String> {
    generate(&read_dir(dir)?, template)
}

/// Reads several directories and merges them per locale: a later
/// directory adds keys to, or overrides keys of, an earlier one. The
/// desktop's few strings of its own lie over the phone app's files.
pub fn read_dirs(dirs: &[&Path]) -> Result<Vec<Arb>, String> {
    let mut merged: Vec<Arb> = Vec::new();
    for dir in dirs {
        for arb in read_dir(dir)? {
            match merged.iter_mut().find(|a| a.locale == arb.locale) {
                Some(existing) => {
                    existing.messages.extend(arb.messages);
                    existing.placeholders.extend(arb.placeholders);
                }
                None => merged.push(arb),
            }
        }
    }
    Ok(merged)
}

/// Reads `dirs` and generates the source in one go.
pub fn generate_dirs(dirs: &[&Path], template: &str) -> Result<String, String> {
    generate(&read_dirs(dirs)?, template)
}

#[cfg(test)]
mod tests {
    use super::*;

    const EN: &str = r#"{
  "@@locale": "en",
  "appTitle": "cat(a)log",
  "csvSavedTo": "CSV saved to {path}",
  "@csvSavedTo": {"placeholders": {"path": {"type": "String"}}},
  "changesCount": "{n, plural, one{1 change} other{{n} changes}}",
  "@changesCount": {"placeholders": {"n": {"type": "int"}}},
  "greet": "Hello {name}, you have {count}",
  "type": "Kind",
  "gender": "{g, select, female{she} male{he} other{they}}"
}"#;
    const DE: &str = r#"{
  "@@locale": "de",
  "appTitle": "cat(a)log",
  "csvSavedTo": "CSV gespeichert unter {path}",
  "changesCount": "{n, plural, one{1 Änderung} other{{n} Änderungen}}"
}"#;

    #[test]
    fn arb_files_parse_with_their_placeholders() {
        let en = parse_arb(EN).unwrap();
        assert_eq!(en.locale, "en");
        assert_eq!(en.messages.len(), 6);
        assert_eq!(
            en.placeholders["csvSavedTo"],
            vec![("path".to_string(), "String".to_string())]
        );
        assert!(parse_arb("[]").is_err());
        assert!(parse_arb(r#"{"a":"b"}"#).is_err());
        assert!(parse_arb("not json").is_err());
    }

    #[test]
    fn keys_become_snake_case_and_keywords_get_an_underscore() {
        assert_eq!(snake("csvSavedTo"), "csv_saved_to");
        assert_eq!(snake("type"), "type_");
        assert_eq!(snake("appTitle"), "app_title");
    }

    #[test]
    fn the_generated_source_has_a_table_and_typed_accessors() {
        let arbs = vec![parse_arb(DE).unwrap(), parse_arb(EN).unwrap()];
        let src = generate(&arbs, "en").unwrap();
        assert!(src.contains(r#"pub const LOCALES: [&str; 2] = ["en", "de", ];"#));
        assert!(src.contains("pub fn app_title(&self) -> &'static str { self.raw(0) }"));
        assert!(src.contains("pub fn csv_saved_to(&self, path: &str) -> String"));
        assert!(src.contains("pub fn changes_count(&self, n: i64) -> String"));
        assert!(src.contains("pub fn greet(&self, name: &str, count: &str) -> String"));
        assert!(src.contains("pub fn gender(&self, g: &str) -> String"));
        assert!(src.contains("pub fn type_(&self) -> &'static str"));
        // German falls back to English where it has no text of its own.
        assert!(src.contains(r#""Hello {name}, you have {count}", "#));
        assert!(src.matches("Hello {name}").count() == 2);
        assert!(generate(&arbs, "fr").is_err());
    }

    #[test]
    fn a_directory_of_arb_files_is_read_in_order() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("app_en.arb"), EN).unwrap();
        std::fs::write(dir.path().join("app_de.arb"), DE).unwrap();
        std::fs::write(dir.path().join("other.arb"), "junk").unwrap();
        std::fs::write(dir.path().join("app_en.dart"), "junk").unwrap();
        let arbs = read_dir(dir.path()).unwrap();
        assert_eq!(
            arbs.iter().map(|a| a.locale.as_str()).collect::<Vec<_>>(),
            vec!["de", "en"]
        );
        assert!(generate_dir(dir.path(), "en").is_ok());
        // An overlay directory adds and overrides keys per locale.
        let overlay = tempfile::tempdir().unwrap();
        std::fs::write(
            overlay.path().join("desktop_en.arb"),
            r#"{"@@locale": "en", "menuFile": "File", "appTitle": "cat(a)log desktop"}"#,
        )
        .unwrap();
        std::fs::write(
            overlay.path().join("desktop_fr.arb"),
            r#"{"@@locale": "fr", "menuFile": "Fichier"}"#,
        )
        .unwrap();
        let merged = read_dirs(&[dir.path(), overlay.path()]).unwrap();
        assert_eq!(merged.len(), 3);
        let en = merged.iter().find(|a| a.locale == "en").unwrap();
        assert_eq!(en.messages["menuFile"], "File");
        assert_eq!(en.messages["appTitle"], "cat(a)log desktop");
        let src = generate_dirs(&[dir.path(), overlay.path()], "en").unwrap();
        assert!(src.contains("pub fn menu_file(&self)"));
        std::fs::write(dir.path().join("app_xx.arb"), "junk").unwrap();
        assert!(read_dir(dir.path()).is_err());
        assert!(read_dir(&dir.path().join("missing")).is_err());
    }
}
