//! The cheers, each moment its own cat: a short meow for a tick, a purr
//! for a day of chores done, a chorus of meows for a ladder climbed, a
//! meow over a purr for an adoption. The recordings are CC0 and public
//! domain from Wikimedia Commons, see `assets/sounds/LICENSES.md`; the
//! sounds ship with the app.

/// Plays a sound.
pub trait Sounder {
    fn play(&mut self, wav: &'static [u8]);
}

pub static TICK: &[u8] = include_bytes!("../../../../assets/sounds/tick.wav");
pub static PURR: &[u8] = include_bytes!("../../../../assets/sounds/purr.wav");
pub static CHORUS: &[u8] = include_bytes!("../../../../assets/sounds/chorus.wav");
pub static PARTY: &[u8] = include_bytes!("../../../../assets/sounds/party.wav");

/// What is celebrated.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Cheer {
    Tick,
    DayDone,
    Ladder,
    Adoption,
}

/// The sound of a cheer.
pub fn cheer_sound(cheer: Cheer) -> &'static [u8] {
    match cheer {
        Cheer::Tick => TICK,
        Cheer::DayDone => PURR,
        Cheer::Ladder => CHORUS,
        Cheer::Adoption => PARTY,
    }
}

/// The speakers, through rodio, on a thread of their own.
pub struct Speakers;

impl Sounder for Speakers {
    fn play(&mut self, wav: &'static [u8]) {
        std::thread::spawn(move || {
            let Ok(sink) = rodio::DeviceSinkBuilder::open_default_sink() else {
                return;
            };
            if let Ok(player) = rodio::play(sink.mixer(), std::io::Cursor::new(wav)) {
                player.sleep_until_end();
            }
        });
    }
}

/// Keeps what was played.
#[derive(Debug, Default)]
pub struct RecordingSounder {
    pub played: std::sync::Arc<std::sync::Mutex<Vec<usize>>>,
}

impl Sounder for RecordingSounder {
    fn play(&mut self, wav: &'static [u8]) {
        if let Ok(mut played) = self.played.lock() {
            played.push(wav.len());
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_moment_has_its_own_short_wave() {
        let all = [Cheer::Tick, Cheer::DayDone, Cheer::Ladder, Cheer::Adoption];
        for cheer in all {
            let bytes = cheer_sound(cheer);
            assert!(bytes.starts_with(b"RIFF"), "{cheer:?}");
            assert!(
                bytes.len() > 10_000 && bytes.len() < 400_000,
                "{cheer:?}: short"
            );
        }
        assert!(cheer_sound(Cheer::Tick).len() < cheer_sound(Cheer::DayDone).len());
    }
}
