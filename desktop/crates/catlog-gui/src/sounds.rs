//! The sounds: every moment the desk makes one at has its own choice,
//! kept on this machine: none, one of the shipped cat sounds, or a file
//! of the keeper's own. The shipped ones, each moment its own cat: a
//! short meow for a tick, a purr for a day of chores done, a chorus of
//! meows for a ladder climbed, a meow over a purr for an adoption. The
//! recordings are CC0 and public domain from Wikimedia Commons, see
//! `assets/sounds/LICENSES.md`; they ship with the app.

use std::path::{Path, PathBuf};

use catlog_core::Catalog;

use crate::l10n::L10n;

/// Plays a sound.
pub trait Sounder {
    fn play(&mut self, sound: Vec<u8>);
}

pub static TICK: &[u8] = include_bytes!("../../../../assets/sounds/tick.wav");
pub static PURR: &[u8] = include_bytes!("../../../../assets/sounds/purr.wav");
pub static CHORUS: &[u8] = include_bytes!("../../../../assets/sounds/chorus.wav");
pub static PARTY: &[u8] = include_bytes!("../../../../assets/sounds/party.wav");

/// The moments a sound belongs to.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Cheer {
    Tick,
    DayDone,
    Ladder,
    Adoption,
}

impl Cheer {
    pub const ALL: [Cheer; 4] = [Cheer::Tick, Cheer::DayDone, Cheer::Ladder, Cheer::Adoption];

    /// The local setting the choice is kept under; the phone's key.
    pub fn key(self) -> &'static str {
        match self {
            Cheer::Tick => "sound:tick",
            Cheer::DayDone => "sound:dayDone",
            Cheer::Ladder => "sound:ladder",
            Cheer::Adoption => "sound:adoption",
        }
    }

    /// The moment's name on the Settings page.
    pub fn label(self, t: &L10n) -> &'static str {
        match self {
            Cheer::Tick => t.chore_tick_label(),
            Cheer::DayDone => t.all_done_today(),
            Cheer::Ladder => t.achievements_title(),
            Cheer::Adoption => t.toast_kind_adoptions(),
        }
    }

    /// The sound a moment ships with.
    pub fn default_preset(self) -> Preset {
        match self {
            Cheer::Tick => Preset::Meow,
            Cheer::DayDone => Preset::Purr,
            Cheer::Ladder => Preset::Chorus,
            Cheer::Adoption => Preset::Party,
        }
    }
}

/// The shipped sounds.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Preset {
    Meow,
    Purr,
    Chorus,
    Party,
}

impl Preset {
    pub const ALL: [Preset; 4] = [Preset::Meow, Preset::Purr, Preset::Chorus, Preset::Party];

    /// The value kept in the setting; the phone's spelling.
    pub fn name(self) -> &'static str {
        match self {
            Preset::Meow => "meow",
            Preset::Purr => "purr",
            Preset::Chorus => "chorus",
            Preset::Party => "party",
        }
    }

    fn from_name(name: &str) -> Option<Preset> {
        Preset::ALL.into_iter().find(|p| p.name() == name)
    }

    pub fn label(self, t: &L10n) -> &'static str {
        match self {
            Preset::Meow => t.sound_meow(),
            Preset::Purr => t.sound_purr(),
            Preset::Chorus => t.sound_chorus(),
            Preset::Party => t.sound_party(),
        }
    }

    pub fn bytes(self) -> &'static [u8] {
        match self {
            Preset::Meow => TICK,
            Preset::Purr => PURR,
            Preset::Chorus => CHORUS,
            Preset::Party => PARTY,
        }
    }
}

/// The sound a moment ships with.
pub fn cheer_sound(cheer: Cheer) -> &'static [u8] {
    cheer.default_preset().bytes()
}

/// What plays at a moment.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum SoundChoice {
    None,
    Preset(Preset),
    Own(PathBuf),
}

impl SoundChoice {
    /// The choice's name: None, the preset, or the own file's name.
    pub fn label(&self, t: &L10n) -> String {
        match self {
            SoundChoice::None => t.alert_none().to_string(),
            SoundChoice::Preset(p) => p.label(t).to_string(),
            SoundChoice::Own(path) => path
                .file_name()
                .map(|n| n.to_string_lossy().into_owned())
                .unwrap_or_default(),
        }
    }

    /// The bytes to play, read now for an own file; none for none or a
    /// file that is gone.
    pub fn bytes(&self) -> Option<Vec<u8>> {
        match self {
            SoundChoice::None => None,
            SoundChoice::Preset(p) => Some(p.bytes().to_vec()),
            SoundChoice::Own(path) => std::fs::read(path).ok(),
        }
    }
}

/// The choice for a moment. Before the choices existed one switch
/// silenced every cheer; a machine that had it off stays silent.
pub fn sound_for(store: &Catalog, cheer: Cheer) -> SoundChoice {
    let Some(raw) = store.local_setting(cheer.key()) else {
        let legacy_off = ["celebrationSound", "celebrations"]
            .iter()
            .any(|k| store.local_setting(k).as_deref() == Some("off"));
        return if legacy_off {
            SoundChoice::None
        } else {
            SoundChoice::Preset(cheer.default_preset())
        };
    };
    if raw == "none" {
        return SoundChoice::None;
    }
    if let Some(path) = raw.strip_prefix("file:") {
        return SoundChoice::Own(PathBuf::from(path));
    }
    SoundChoice::Preset(Preset::from_name(&raw).unwrap_or(cheer.default_preset()))
}

pub fn set_sound(store: &Catalog, cheer: Cheer, choice: &SoundChoice) {
    let raw = match choice {
        SoundChoice::None => "none".to_string(),
        SoundChoice::Preset(p) => p.name().to_string(),
        SoundChoice::Own(path) => format!("file:{}", path.display()),
    };
    let _ = store.set_local_setting(cheer.key(), &raw);
}

/// The file kinds the player can read.
pub const SOUND_FILES: &[&str] = &["wav", "mp3", "flac", "ogg"];

/// Keeps a copy of a picked file under `dir`, so the choice outlives
/// the file it came from.
pub fn keep_own(dir: &Path, cheer: Cheer, source: &Path) -> std::io::Result<PathBuf> {
    let sounds = dir.join("sounds");
    std::fs::create_dir_all(&sounds)?;
    let name = match source.extension() {
        Some(ext) => format!(
            "{}.{}",
            cheer.key().trim_start_matches("sound:"),
            ext.to_string_lossy()
        ),
        None => cheer.key().trim_start_matches("sound:").to_string(),
    };
    let target = sounds.join(name);
    std::fs::copy(source, &target)?;
    Ok(target)
}

/// The speakers, through rodio, on a thread of their own.
pub struct Speakers;

impl Sounder for Speakers {
    fn play(&mut self, sound: Vec<u8>) {
        std::thread::spawn(move || {
            let Ok(sink) = rodio::DeviceSinkBuilder::open_default_sink() else {
                return;
            };
            if let Ok(player) = rodio::play(sink.mixer(), std::io::Cursor::new(sound)) {
                player.sleep_until_end();
            }
        });
    }
}

/// Keeps what was played, by length.
#[derive(Debug, Default)]
pub struct RecordingSounder {
    pub played: std::sync::Arc<std::sync::Mutex<Vec<usize>>>,
}

impl Sounder for RecordingSounder {
    fn play(&mut self, sound: Vec<u8>) {
        if let Ok(mut played) = self.played.lock() {
            played.push(sound.len());
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_moment_has_its_own_short_wave() {
        for cheer in Cheer::ALL {
            let bytes = cheer_sound(cheer);
            assert!(bytes.starts_with(b"RIFF"), "{cheer:?}");
            assert!(
                bytes.len() > 10_000 && bytes.len() < 400_000,
                "{cheer:?}: short"
            );
        }
        assert!(cheer_sound(Cheer::Tick).len() < cheer_sound(Cheer::DayDone).len());
    }

    #[test]
    fn a_moment_keeps_its_choice_and_the_old_switch_is_honoured() {
        let dir = tempfile::tempdir().unwrap();
        let store = Catalog::open(dir.path()).unwrap();
        assert_eq!(
            sound_for(&store, Cheer::Tick),
            SoundChoice::Preset(Preset::Meow)
        );
        set_sound(&store, Cheer::Tick, &SoundChoice::None);
        assert_eq!(sound_for(&store, Cheer::Tick), SoundChoice::None);
        assert!(sound_for(&store, Cheer::Tick).bytes().is_none());
        set_sound(&store, Cheer::DayDone, &SoundChoice::Preset(Preset::Party));
        assert_eq!(
            sound_for(&store, Cheer::DayDone).bytes().unwrap().len(),
            PARTY.len()
        );
        // An own file is copied beside the data and read from there.
        let source = dir.path().join("mine.wav");
        std::fs::write(&source, TICK).unwrap();
        let kept = keep_own(dir.path().join("data").as_path(), Cheer::Ladder, &source).unwrap();
        assert_eq!(kept, dir.path().join("data/sounds/ladder.wav"));
        set_sound(&store, Cheer::Ladder, &SoundChoice::Own(kept.clone()));
        assert_eq!(sound_for(&store, Cheer::Ladder), SoundChoice::Own(kept));
        assert_eq!(
            sound_for(&store, Cheer::Ladder).bytes().unwrap().len(),
            TICK.len()
        );
        // A value the app does not know falls back to the moment's own.
        let _ = store.set_local_setting(Cheer::Adoption.key(), "trumpet");
        assert_eq!(
            sound_for(&store, Cheer::Adoption),
            SoundChoice::Preset(Preset::Party)
        );
        // The switch from before the choices: off keeps every unset moment silent.
        let old = Catalog::open(&dir.path().join("old")).unwrap();
        let _ = old.set_local_setting("celebrationSound", "off");
        for cheer in Cheer::ALL {
            assert_eq!(sound_for(&old, cheer), SoundChoice::None, "{cheer:?}");
        }
        set_sound(&old, Cheer::Tick, &SoundChoice::Preset(Preset::Purr));
        assert_eq!(
            sound_for(&old, Cheer::Tick),
            SoundChoice::Preset(Preset::Purr)
        );
        assert_eq!(sound_for(&old, Cheer::Ladder), SoundChoice::None);
    }
}
