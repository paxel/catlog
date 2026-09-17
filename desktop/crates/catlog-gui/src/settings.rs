//! Settings that belong to the app rather than to one Catalog: the
//! keeper's name, the language, the window as it was left, the intro
//! and tips already seen. One JSON file in the app's data directory.

use std::path::{Path, PathBuf};

use serde::{Deserialize, Serialize};

/// The app's own settings, shared by every Catalog on this device.
#[derive(Debug, Clone, Default, PartialEq, Serialize, Deserialize)]
#[serde(default)]
pub struct AppSettings {
    /// The Author name every change is recorded under.
    pub author: Option<String>,
    /// The chosen language; none follows the system.
    pub locale: Option<String>,
    /// The window's size as it was left, in points.
    pub window: Option<[f32; 2]>,
    /// The list pane's width as it was left.
    pub pane_width: Option<f32>,
    pub intro_seen: bool,
    /// Tips the keeper has seen, by id; `all` means every one.
    pub tips_seen: Vec<String>,
}

/// Where the settings live and are written back to.
pub struct SettingsFile {
    path: PathBuf,
    pub settings: AppSettings,
}

impl SettingsFile {
    /// Loads the settings from `dir/settings.json`; a missing or
    /// unreadable file means fresh settings.
    pub fn load(dir: &Path) -> SettingsFile {
        let path = dir.join("settings.json");
        let settings = std::fs::read_to_string(&path)
            .ok()
            .and_then(|t| serde_json::from_str(&t).ok())
            .unwrap_or_default();
        SettingsFile { path, settings }
    }

    /// Writes the settings; a failure is reported, not fatal.
    pub fn save(&self) -> Result<(), String> {
        if let Some(parent) = self.path.parent() {
            std::fs::create_dir_all(parent).map_err(|e| format!("{}: {e}", parent.display()))?;
        }
        let text = serde_json::to_string_pretty(&self.settings).map_err(|e| e.to_string())?;
        std::fs::write(&self.path, text).map_err(|e| format!("{}: {e}", self.path.display()))
    }

    pub fn path(&self) -> &Path {
        &self.path
    }
}

/// The app's data directory: the platform's data home under the app id,
/// in a `v2` sub-layout the Flutter desktop build never touches.
pub fn data_dir() -> PathBuf {
    directories::ProjectDirs::from("io.github", "paxel", "catlog")
        .map(|d| d.data_dir().join("v2"))
        .unwrap_or_else(|| PathBuf::from(".").join("catlog-data"))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn settings_round_trip_through_their_file() {
        let dir = tempfile::tempdir().unwrap();
        let mut file = SettingsFile::load(dir.path());
        assert_eq!(file.settings, AppSettings::default());
        file.settings.author = Some("Ada".into());
        file.settings.locale = Some("de".into());
        file.settings.window = Some([1200.0, 800.0]);
        file.settings.pane_width = Some(320.0);
        file.settings.intro_seen = true;
        file.settings.tips_seen.push("all".into());
        file.save().unwrap();
        assert!(file.path().exists());
        let again = SettingsFile::load(dir.path());
        assert_eq!(again.settings, file.settings);
        // Junk in the file means fresh settings, never a crash.
        std::fs::write(dir.path().join("settings.json"), "junk").unwrap();
        assert_eq!(
            SettingsFile::load(dir.path()).settings,
            AppSettings::default()
        );
        // A directory that cannot be made reports its failure.
        let blocked = SettingsFile::load(&dir.path().join("settings.json").join("x"));
        assert!(blocked.save().is_err());
        assert!(data_dir().ends_with("v2"));
    }
}
