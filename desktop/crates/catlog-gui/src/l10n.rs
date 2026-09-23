//! The strings, generated at build time from `lib/l10n/*.arb` by
//! `catlog-l10n`. One accessor per key; the ones with placeholders take
//! typed arguments and format through the ICU subset.

include!(concat!(env!("OUT_DIR"), "/l10n.rs"));

/// The name a language calls itself, next to its code in the menu.
pub fn native_name(locale: &str) -> &'static str {
    match locale {
        "ar" => "العربية",
        "bg" => "Български",
        "bs" => "Bosanski",
        "cs" => "Čeština",
        "da" => "Dansk",
        "de" => "Deutsch",
        "el" => "Ελληνικά",
        "en" => "English",
        "es" => "Español",
        "et" => "Eesti",
        "fa" => "فارسی",
        "fi" => "Suomi",
        "fr" => "Français",
        "ga" => "Gaeilge",
        "he" => "עברית",
        "hr" => "Hrvatski",
        "hu" => "Magyar",
        "is" => "Íslenska",
        "it" => "Italiano",
        "ja" => "日本語",
        "lt" => "Lietuvių",
        "lv" => "Latviešu",
        "mk" => "Македонски",
        "mt" => "Malti",
        "nl" => "Nederlands",
        "no" => "Norsk",
        "pl" => "Polski",
        "pt" => "Português",
        "ro" => "Română",
        "ru" => "Русский",
        "sk" => "Slovenčina",
        "sl" => "Slovenščina",
        "sq" => "Shqip",
        "sr" => "Српски",
        "sv" => "Svenska",
        "tr" => "Türkçe",
        "uk" => "Українська",
        "zh" => "中文",
        other => {
            let _ = other;
            "?"
        }
    }
}

/// The app's locale for a system locale such as `de_DE.UTF-8` or
/// `en-US`: the language part when the app speaks it, else English.
pub fn locale_for_system(system: Option<&str>) -> &'static str {
    let lang = system
        .unwrap_or("en")
        .split(['-', '_', '.'])
        .next()
        .unwrap_or("en")
        .to_lowercase();
    LOCALES.iter().copied().find(|l| *l == lang).unwrap_or("en")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_locale_has_a_name_and_the_strings_format() {
        assert_eq!(LOCALES[0], "en");
        assert_eq!(LOCALES.len(), 38);
        for l in LOCALES {
            assert_ne!(native_name(l), "?", "{l}");
            let t = L10n::new(l);
            assert_eq!(t.locale(), l);
            assert!(!t.clowders().is_empty());
        }
        assert_eq!(native_name("xx"), "?");
        let en = L10n::new("en");
        assert_eq!(en.app_title(), "cat(a)log");
        assert_eq!(en.field_history_of("Weight", "Miezi"), "Weight — Miezi");
        assert_eq!(en.changes_count(1), "1 change");
        assert_eq!(en.changes_count(2), "2 changes");
        let de = L10n::new("de");
        assert_ne!(de.clowders(), en.clowders());
        assert_eq!(L10n::new("xx"), en);
        assert_eq!(en.raw_by_name("appTitle"), Some("cat(a)log"));
        assert_eq!(en.raw_by_name("nope"), None);
        assert_eq!(locale_for_system(Some("de_DE.UTF-8")), "de");
        assert_eq!(locale_for_system(Some("pt-BR")), "pt");
        assert_eq!(locale_for_system(Some("xx")), "en");
        assert_eq!(locale_for_system(None), "en");
    }
}
