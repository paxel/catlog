//! Open Location Code ("Plus Code") encoder: the printable, offline
//! answer to "where" on a Card. A 10-digit code covers about 14 m by
//! 14 m.

const ALPHABET: &[u8; 20] = b"23456789CFGHJMPQRVWX";
const RESOLUTIONS: [f64; 5] = [20.0, 1.0, 0.05, 0.0025, 0.000125];

pub fn encode_plus_code(latitude: f64, longitude: f64) -> String {
    let lat = latitude.clamp(-90.0, 90.0) + 90.0;
    let mut lon = longitude;
    while lon < -180.0 {
        lon += 360.0;
    }
    while lon >= 180.0 {
        lon -= 360.0;
    }
    lon += 180.0;
    let mut out = String::new();
    for (i, res) in RESOLUTIONS.iter().enumerate() {
        // The epsilon keeps exact grid points from flooring one cell low.
        let a = ((lat / res) + 1e-9).floor() as i64 % 20;
        let b = ((lon / res) + 1e-9).floor() as i64 % 20;
        out.push(ALPHABET[a as usize] as char);
        out.push(ALPHABET[b as usize] as char);
        if i == 3 {
            out.push('+');
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn known_places_encode_like_the_reference() {
        assert_eq!(encode_plus_code(51.34, 12.37), "9F3J89RC+22");
        assert_eq!(encode_plus_code(0.0, 0.0), "6FG22222+22");
        assert_eq!(encode_plus_code(-90.0, -180.0), "22222222+22");
        assert_eq!(
            encode_plus_code(51.34, 372.37),
            encode_plus_code(51.34, 12.37)
        );
        assert_eq!(
            encode_plus_code(51.34, -347.63),
            encode_plus_code(51.34, 12.37)
        );
        assert_eq!(encode_plus_code(95.0, 0.0).len(), 11);
    }
}
