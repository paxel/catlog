//! The cheers: a short crowd for a day of chores done or a ladder
//! climbed, a different one each time. The sounds ship with the app.

/// Plays a sound.
pub trait Sounder {
    fn play(&mut self, wav: &'static [u8]);
}

pub static PARTY: &[u8] = include_bytes!("../../../../assets/sounds/party.wav");
pub static CHEER1: &[u8] = include_bytes!("../../../../assets/sounds/cheer1.wav");
pub static CHEER2: &[u8] = include_bytes!("../../../../assets/sounds/cheer2.wav");
pub static CHEER3: &[u8] = include_bytes!("../../../../assets/sounds/cheer3.wav");
pub static CHEER4: &[u8] = include_bytes!("../../../../assets/sounds/cheer4.wav");

pub const CHEERS: [(&str, &[u8]); 5] = [
    ("party", PARTY),
    ("cheer1", CHEER1),
    ("cheer2", CHEER2),
    ("cheer3", CHEER3),
    ("cheer4", CHEER4),
];

/// A cheer other than the last one.
pub fn pick_cheer(previous: Option<&str>) -> (&'static str, &'static [u8]) {
    let choices: Vec<(&str, &[u8])> = CHEERS
        .iter()
        .copied()
        .filter(|(name, _)| Some(*name) != previous)
        .collect();
    let mut b = [0u8; 1];
    let _ = getrandom::fill(&mut b);
    choices[b[0] as usize % choices.len()]
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
    fn a_cheer_is_never_the_same_twice_in_a_row() {
        for _ in 0..20 {
            let (name, bytes) = pick_cheer(Some("party"));
            assert_ne!(name, "party");
            assert!(bytes.starts_with(b"RIFF"));
        }
        assert!(pick_cheer(None).1.len() > 1000);
    }
}
