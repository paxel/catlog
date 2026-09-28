//! The sounds: every moment the desk makes one at has its own choice,
//! kept on this machine: none, one of the shipped cat sounds, or a file
//! of the keeper's own. The shipped ones, each moment its own cat: a
//! short call for a tick, a purr for a day of chores done, a chorus of
//! calls for a ladder climbed, a meow over a purr for an adoption. The
//! purr and the party meow are CC0 and public domain from Wikimedia
//! Commons; the three calls and the chorus made of them are one cat's,
//! called Socke, recorded by its keeper, as are the call and the purr
//! of one called Sonne. See `assets/sounds/LICENSES.md`; they all ship
//! with the app.

use std::path::{Path, PathBuf};

use catlog_core::Catalog;

use crate::l10n::L10n;
use crate::settings::AppSettings;

/// Plays a sound.
pub trait Sounder {
    fn play(&mut self, sound: Vec<u8>);
}

pub static PURR: &[u8] = include_bytes!("../../../../assets/sounds/purr.wav");
pub static CHORUS: &[u8] = include_bytes!("../../../../assets/sounds/chorus.wav");
pub static PARTY: &[u8] = include_bytes!("../../../../assets/sounds/party.wav");
pub static MEEP: &[u8] = include_bytes!("../../../../assets/sounds/socke1.wav");
pub static MRRP: &[u8] = include_bytes!("../../../../assets/sounds/socke2.wav");
pub static MRRR: &[u8] = include_bytes!("../../../../assets/sounds/socke3.wav");
pub static SONNE_MIAU: &[u8] = include_bytes!("../../../../assets/sounds/sonne_miau.wav");
pub static SONNE_PURR: &[u8] = include_bytes!("../../../../assets/sounds/sonne_purr.wav");

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
            Cheer::Tick => Preset::Meep,
            Cheer::DayDone => Preset::Purr,
            Cheer::Ladder => Preset::Chorus,
            Cheer::Adoption => Preset::Party,
        }
    }
}

/// The shipped sounds.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Preset {
    Purr,
    Chorus,
    Party,
    Meep,
    Mrrp,
    Mrrr,
    SonneMiau,
    SonnePurr,
}

impl Preset {
    pub const ALL: [Preset; 8] = [
        Preset::Purr,
        Preset::Chorus,
        Preset::Party,
        Preset::Meep,
        Preset::Mrrp,
        Preset::Mrrr,
        Preset::SonneMiau,
        Preset::SonnePurr,
    ];

    /// The value kept in the setting; the phone's spelling.
    pub fn name(self) -> &'static str {
        match self {
            Preset::Purr => "purr",
            Preset::Chorus => "chorus",
            Preset::Party => "party",
            Preset::Meep => "meep",
            Preset::Mrrp => "mrrp",
            Preset::Mrrr => "mrrr",
            Preset::SonneMiau => "sonneMiau",
            Preset::SonnePurr => "sonnePurr",
        }
    }

    fn from_name(name: &str) -> Option<Preset> {
        Preset::ALL.into_iter().find(|p| p.name() == name)
    }

    pub fn label(self, t: &L10n) -> &'static str {
        match self {
            Preset::Purr => t.sound_purr(),
            Preset::Chorus => t.sound_chorus(),
            Preset::Party => t.sound_party(),
            Preset::Meep => t.sound_meep(),
            Preset::Mrrp => t.sound_mrrp(),
            Preset::Mrrr => t.sound_mrrr(),
            Preset::SonneMiau => t.sound_sonne_miau(),
            Preset::SonnePurr => t.sound_sonne_purr(),
        }
    }

    pub fn bytes(self) -> &'static [u8] {
        match self {
            Preset::Purr => PURR,
            Preset::Chorus => CHORUS,
            Preset::Party => PARTY,
            Preset::Meep => MEEP,
            Preset::Mrrp => MRRP,
            Preset::Mrrr => MRRR,
            Preset::SonneMiau => SONNE_MIAU,
            Preset::SonnePurr => SONNE_PURR,
        }
    }
}

/// The sound a moment ships with.
pub fn cheer_sound(cheer: Cheer) -> &'static [u8] {
    cheer.default_preset().bytes()
}

/// A chore's reminder arrives as a notification the system draws, so
/// all this machine decides is whether the desk speaks with it: Socke's
/// Mrrr, or nothing but the popup. The phone's key and its default.
pub const REMINDER_SOUND: &str = "reminderCatSound";

/// The reminder sound this machine uses; the cat unless switched off.
/// The answer belongs to the device, and is read from the catalog it
/// was given in until it is given again.
pub fn reminder_cat_sound(app: &AppSettings, store: &Catalog) -> bool {
    app.reminder_cat_sound
        .unwrap_or_else(|| store.local_setting(REMINDER_SOUND).as_deref() != Some("off"))
}

pub fn set_reminder_cat_sound(app: &mut AppSettings, on: bool) {
    app.reminder_cat_sound = Some(on);
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
/// silenced every cheer; a machine that had it off stays silent. The
/// confetti switch is not that switch: it takes the confetti away and
/// leaves the sounds alone.
pub fn sound_for(app: &AppSettings, store: &Catalog, cheer: Cheer) -> SoundChoice {
    let chosen = app
        .sounds
        .get(cheer.key())
        .cloned()
        .or_else(|| store.local_setting(cheer.key()));
    let Some(raw) = chosen else {
        let legacy_off = store.local_setting("celebrationSound").as_deref() == Some("off");
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

pub fn set_sound(app: &mut AppSettings, cheer: Cheer, choice: &SoundChoice) {
    let raw = match choice {
        SoundChoice::None => "none".to_string(),
        SoundChoice::Preset(p) => p.name().to_string(),
        SoundChoice::Own(path) => format!("file:{}", path.display()),
    };
    app.sounds.insert(cheer.key().to_string(), raw);
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
    fn every_moment_and_every_preset_has_its_own_short_wave() {
        for cheer in Cheer::ALL {
            let bytes = cheer_sound(cheer);
            assert!(bytes.starts_with(b"RIFF"), "{cheer:?}");
            assert!(
                bytes.len() > 5_000 && bytes.len() < 400_000,
                "{cheer:?}: short"
            );
        }
        assert!(cheer_sound(Cheer::Tick).len() < cheer_sound(Cheer::DayDone).len());
        for preset in Preset::ALL {
            let bytes = preset.bytes();
            assert!(bytes.starts_with(b"RIFF"), "{preset:?}");
            assert!(
                bytes.len() > 5_000 && bytes.len() < 400_000,
                "{preset:?}: short"
            );
            // Every preset answers to its own name and nobody else's.
            assert_eq!(Preset::from_name(preset.name()), Some(preset));
        }
    }

    #[test]
    fn a_moment_keeps_its_choice_and_the_old_switch_is_honoured() {
        let dir = tempfile::tempdir().unwrap();
        let store = Catalog::open(dir.path()).unwrap();
        let mut app = AppSettings::default();
        assert_eq!(
            sound_for(&app, &store, Cheer::Tick),
            SoundChoice::Preset(Preset::Meep)
        );
        set_sound(&mut app, Cheer::Tick, &SoundChoice::None);
        assert_eq!(sound_for(&app, &store, Cheer::Tick), SoundChoice::None);
        assert!(sound_for(&app, &store, Cheer::Tick).bytes().is_none());
        set_sound(
            &mut app,
            Cheer::DayDone,
            &SoundChoice::Preset(Preset::Party),
        );
        assert_eq!(
            sound_for(&app, &store, Cheer::DayDone)
                .bytes()
                .unwrap()
                .len(),
            PARTY.len()
        );
        // The choice is the device's: another Catalog hears the same.
        let other = Catalog::open(&dir.path().join("other")).unwrap();
        assert_eq!(sound_for(&app, &other, Cheer::Tick), SoundChoice::None);
        // An own file is copied beside the data and read from there.
        let source = dir.path().join("mine.wav");
        std::fs::write(&source, MEEP).unwrap();
        let kept = keep_own(dir.path().join("data").as_path(), Cheer::Ladder, &source).unwrap();
        assert_eq!(kept, dir.path().join("data/sounds/ladder.wav"));
        set_sound(&mut app, Cheer::Ladder, &SoundChoice::Own(kept.clone()));
        assert_eq!(
            sound_for(&app, &store, Cheer::Ladder),
            SoundChoice::Own(kept)
        );
        assert_eq!(
            sound_for(&app, &store, Cheer::Ladder)
                .bytes()
                .unwrap()
                .len(),
            MEEP.len()
        );
        // A value the app does not know falls back to the moment's own.
        app.sounds
            .insert(Cheer::Adoption.key().to_string(), "trumpet".to_string());
        assert_eq!(
            sound_for(&app, &store, Cheer::Adoption),
            SoundChoice::Preset(Preset::Party)
        );
        // A choice made before the sounds belonged to the device is
        // read where it was made.
        let kept_in_catalog = Catalog::open(&dir.path().join("kept")).unwrap();
        let _ = kept_in_catalog.set_local_setting(Cheer::Tick.key(), "purr");
        assert_eq!(
            sound_for(&AppSettings::default(), &kept_in_catalog, Cheer::Tick),
            SoundChoice::Preset(Preset::Purr)
        );
        // The switch from before the choices: off keeps every unset moment silent.
        let old = Catalog::open(&dir.path().join("old")).unwrap();
        let mut old_app = AppSettings::default();
        let _ = old.set_local_setting("celebrationSound", "off");
        for cheer in Cheer::ALL {
            assert_eq!(
                sound_for(&old_app, &old, cheer),
                SoundChoice::None,
                "{cheer:?}"
            );
        }
        set_sound(
            &mut old_app,
            Cheer::Tick,
            &SoundChoice::Preset(Preset::Purr),
        );
        assert_eq!(
            sound_for(&old_app, &old, Cheer::Tick),
            SoundChoice::Preset(Preset::Purr)
        );
        assert_eq!(sound_for(&old_app, &old, Cheer::Ladder), SoundChoice::None);
        // The confetti switch is a switch for confetti: the sounds stay.
        let quiet = Catalog::open(&dir.path().join("quiet")).unwrap();
        let _ = quiet.set_local_setting(crate::settings_page::CELEBRATIONS, "off");
        for cheer in Cheer::ALL {
            assert_eq!(
                sound_for(&AppSettings::default(), &quiet, cheer),
                SoundChoice::Preset(cheer.default_preset()),
                "{cheer:?}"
            );
        }
    }
}
