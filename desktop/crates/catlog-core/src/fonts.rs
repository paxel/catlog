//! The type every PDF is set in: Noto Sans travels with the app; the
//! scripts it does not cover come from Google Fonts once, when first
//! needed, and are kept in the data dir. Offline that first time, the
//! page is set in Noto Sans and says so.

use std::path::Path;

use crate::Result;
use crate::error::Error;
use crate::pdf::Font;

pub static NOTO_SANS_REGULAR: &[u8] = include_bytes!("../../../../fonts/NotoSans-Regular.ttf");
pub static NOTO_SANS_BOLD: &[u8] = include_bytes!("../../../../fonts/NotoSans-Bold.ttf");

/// Fetches a font file by URL.
pub trait FontSource: Send + Sync {
    fn fetch(&self, url: &str) -> std::result::Result<Vec<u8>, String>;
}

/// Google Fonts over HTTPS.
pub struct HttpFonts;

impl FontSource for HttpFonts {
    fn fetch(&self, url: &str) -> std::result::Result<Vec<u8>, String> {
        let agent = ureq::Agent::config_builder()
            .user_agent(crate::tiles::TILE_USER_AGENT)
            .build()
            .new_agent();
        let body = agent
            .get(url)
            .call()
            .map_err(|e| e.to_string())?
            .body_mut()
            .with_config()
            .limit(40 << 20)
            .read_to_vec()
            .map_err(|e| e.to_string())?;
        Ok(body)
    }
}

/// The regular and bold files of the script a language needs beyond
/// Noto Sans, as the phone fetches them.
pub fn script_faces(language: &str) -> Option<(&'static str, &'static str)> {
    Some(match language {
        "ar" | "fa" => (
            "https://fonts.gstatic.com/s/notosansarabic/v18/nwpxtLGrOAZMl5nJ_wfgRg3DrWFZWsnVBJ_sS6tlqHHFlhQ5l3sQWIHPqzCfyGyvu3CBFQLaig.ttf",
            "https://fonts.gstatic.com/s/notosansarabic/v18/nwpxtLGrOAZMl5nJ_wfgRg3DrWFZWsnVBJ_sS6tlqHHFlhQ5l3sQWIHPqzCfL2uvu3CBFQLaig.ttf",
        ),
        "he" => (
            "https://fonts.gstatic.com/s/notosanshebrew/v46/or3HQ7v33eiDljA1IufXTtVf7V6RvEEdhQlk0LlGxCyaeNKYZC0sqk3xXGiXd4qtoiJltutR2g.ttf",
            "https://fonts.gstatic.com/s/notosanshebrew/v46/or3HQ7v33eiDljA1IufXTtVf7V6RvEEdhQlk0LlGxCyaeNKYZC0sqk3xXGiXkI2toiJltutR2g.ttf",
        ),
        "ja" => (
            "https://fonts.gstatic.com/s/notosansjp/v53/-F6jfjtqLzI2JPCgQBnw7HFyzSD-AsregP8VFBEj75vY0rw-oME.ttf",
            "https://fonts.gstatic.com/s/notosansjp/v53/-F6jfjtqLzI2JPCgQBnw7HFyzSD-AsregP8VFPYk75vY0rw-oME.ttf",
        ),
        "zh" => (
            "https://fonts.gstatic.com/s/notosanssc/v37/k3kCo84MPvpLmixcA63oeAL7Iqp5IZJF9bmaG9_FnYxNbPzS5HE.ttf",
            "https://fonts.gstatic.com/s/notosanssc/v37/k3kCo84MPvpLmixcA63oeAL7Iqp5IZJF9bmaGzjCnYxNbPzS5HE.ttf",
        ),
        _ => return None,
    })
}

/// The fonts a document is set in.
#[derive(Debug, Clone)]
pub struct FontSet {
    pub regular: Font,
    pub bold: Font,
    /// The language's own script, when Noto Sans does not carry it.
    pub script: Option<(Font, Font)>,
    /// False when the script's fonts could not be had this time.
    pub complete: bool,
    /// Text of a right-to-left script is drawn reversed, in visual order.
    pub rtl: bool,
}

impl FontSet {
    /// Noto Sans only.
    pub fn bundled() -> Result<FontSet> {
        Ok(FontSet {
            regular: Font::parse(NOTO_SANS_REGULAR.to_vec(), "NotoSans-Regular")?,
            bold: Font::parse(NOTO_SANS_BOLD.to_vec(), "NotoSans-Bold")?,
            script: None,
            complete: true,
            rtl: false,
        })
    }

    /// The font for a run of `text`: the script font when it carries
    /// the first letter Noto Sans lacks, else Noto Sans.
    pub fn face(&self, text: &str, bold: bool) -> &Font {
        let base = if bold { &self.bold } else { &self.regular };
        match &self.script {
            Some((r, b))
                if text
                    .chars()
                    .any(|c| !base.has(c) && (if bold { b } else { r }).has(c)) =>
            {
                if bold {
                    b
                } else {
                    r
                }
            }
            _ => base,
        }
    }

    /// `text` in the order it is drawn: reversed for a right-to-left
    /// script, character by character. No joining, no shaping.
    pub fn visual(&self, text: &str) -> String {
        if self.rtl && text.chars().any(is_rtl) {
            text.chars().rev().collect()
        } else {
            text.to_string()
        }
    }
}

fn is_rtl(c: char) -> bool {
    matches!(c as u32, 0x0590..=0x08FF | 0xFB1D..=0xFDFF | 0xFE70..=0xFEFF)
}

/// The fonts for `language`: Noto Sans plus the script's faces from
/// the cache under `cache_dir`, fetched through `source` on first use.
pub fn fonts_for(language: &str, cache_dir: &Path, source: &dyn FontSource) -> Result<FontSet> {
    let mut set = FontSet::bundled()?;
    set.rtl = matches!(language, "ar" | "fa" | "he");
    let Some((regular_url, bold_url)) = script_faces(language) else {
        return Ok(set);
    };
    let cached = |url: &str, name: &str| -> std::result::Result<Font, String> {
        let file = cache_dir.join(format!("{name}.ttf"));
        let bytes = match std::fs::read(&file) {
            Ok(bytes) => bytes,
            Err(_) => {
                let bytes = source.fetch(url)?;
                std::fs::create_dir_all(cache_dir).map_err(|e| e.to_string())?;
                std::fs::write(&file, &bytes).map_err(|e| e.to_string())?;
                bytes
            }
        };
        Font::parse(bytes, name).map_err(|e| e.to_string())
    };
    let regular = cached(regular_url, &format!("script-{language}-regular"));
    let bold = cached(bold_url, &format!("script-{language}-bold"));
    match (regular, bold) {
        (Ok(r), Ok(b)) => {
            set.script = Some((r, b));
            set.complete = true;
        }
        _ => set.complete = false,
    }
    Ok(set)
}

impl From<Error> for String {
    fn from(e: Error) -> String {
        e.to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    struct Fake(bool);

    impl FontSource for Fake {
        fn fetch(&self, _url: &str) -> std::result::Result<Vec<u8>, String> {
            if self.0 {
                Ok(NOTO_SANS_BOLD.to_vec())
            } else {
                Err("offline".into())
            }
        }
    }

    #[test]
    fn scripts_come_from_the_cache_after_one_fetch_and_fall_back_offline() {
        let dir = tempfile::tempdir().unwrap();
        assert!(script_faces("de").is_none());
        assert!(script_faces("ja").is_some());
        let plain = fonts_for("de", dir.path(), &Fake(false)).unwrap();
        assert!(plain.complete && plain.script.is_none() && !plain.rtl);
        let offline = fonts_for("ja", dir.path(), &Fake(false)).unwrap();
        assert!(!offline.complete && offline.script.is_none());
        let fetched = fonts_for("ja", dir.path(), &Fake(true)).unwrap();
        assert!(fetched.complete && fetched.script.is_some());
        assert!(dir.path().join("script-ja-regular.ttf").is_file());
        // Now cached: no source needed.
        let cached = fonts_for("ja", dir.path(), &Fake(false)).unwrap();
        assert!(cached.complete);
        let hebrew = fonts_for("he", dir.path(), &Fake(true)).unwrap();
        assert!(hebrew.rtl);
        assert_eq!(hebrew.visual("שלום"), "םולש");
        assert_eq!(hebrew.visual("Miezi"), "Miezi");
        assert_eq!(plain.visual("Miezi"), "Miezi");
        // Face choice: the script font only for what Noto Sans lacks.
        let set = FontSet {
            script: Some((plain.bold.clone(), plain.bold.clone())),
            ..plain.clone()
        };
        assert_eq!(
            set.face("Miezi", false).ascent(10.0),
            plain.regular.ascent(10.0)
        );
        // A junk file in the cache is not a font.
        std::fs::write(dir.path().join("script-zh-regular.ttf"), b"junk").unwrap();
        let broken = fonts_for("zh", dir.path(), &Fake(true)).unwrap();
        assert!(!broken.complete);
    }
}
