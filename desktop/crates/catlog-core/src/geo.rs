//! Geography: distances, where a Stray ran from, and the Web Mercator
//! maths that turns a position into a tile and a pixel.

use crate::Result;
use crate::catalog::Catalog;
use crate::keys;

/// 75% of lost cats are found within 500 m of home: the one radius used
/// for circles and candidate search. No knob.
pub const STRAY_AREA_RADIUS_METERS: f64 = 500.0;

/// Great-circle distance in meters.
pub fn haversine_meters(lat1: f64, lon1: f64, lat2: f64, lon2: f64) -> f64 {
    let r = 6_371_000.0;
    let d_lat = (lat2 - lat1).to_radians();
    let d_lon = (lon2 - lon1).to_radians();
    let h = (d_lat / 2.0).sin().powi(2)
        + lat1.to_radians().cos() * lat2.to_radians().cos() * (d_lon / 2.0).sin().powi(2);
    2.0 * r * h.sqrt().asin()
}

/// The tile a position lies on at `zoom`, with the fraction inside it.
pub fn tile_xy(lat: f64, lon: f64, zoom: u32) -> (f64, f64) {
    let n = 2f64.powi(zoom as i32);
    let lat = lat.clamp(-85.0511, 85.0511).to_radians();
    let x = (lon + 180.0) / 360.0 * n;
    let y = (1.0 - (lat.tan() + 1.0 / lat.cos()).ln() / std::f64::consts::PI) / 2.0 * n;
    (x, y)
}

/// The position at the top-left corner of tile (`x`, `y`) at `zoom`;
/// fractional tiles give any point.
pub fn lat_lon_of(x: f64, y: f64, zoom: u32) -> (f64, f64) {
    let n = 2f64.powi(zoom as i32);
    let lon = x / n * 360.0 - 180.0;
    let lat = (std::f64::consts::PI * (1.0 - 2.0 * y / n))
        .sinh()
        .atan()
        .to_degrees();
    (lat, lon)
}

/// How many meters one tile pixel covers at `lat` and `zoom`, for 256
/// pixel tiles.
pub fn meters_per_pixel(lat: f64, zoom: u32) -> f64 {
    156_543.033_92 * lat.to_radians().cos() / 2f64.powi(zoom as i32)
}

impl Catalog {
    /// Where a Stray ran from: the position of the Clowder it last lived
    /// in, or none when the cat has a home, never had one, or that home
    /// carries no position.
    pub fn stray_home_position(&self, cat: &str) -> Result<Option<(f64, f64)>> {
        if self.current(cat, keys::CLOWDER)?.is_some() {
            return Ok(None);
        }
        match self.former_clowder(cat)? {
            Some(home) => self.position_of(&home),
            None => Ok(None),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::entities::PositionKind;

    #[test]
    fn distances_and_tiles_match_the_reference_values() {
        // Leipzig to Berlin, about 150 km.
        let d = haversine_meters(51.34, 12.37, 52.52, 13.405);
        assert!((d - 149_000.0).abs() < 2_000.0, "{d}");
        assert_eq!(haversine_meters(0.0, 0.0, 0.0, 0.0), 0.0);
        let (x, y) = tile_xy(51.34, 12.37, 6);
        assert_eq!((x.floor() as i64, y.floor() as i64), (34, 21));
        let (lat, lon) = lat_lon_of(34.0, 21.0, 6);
        assert!(
            (lat - 52.48).abs() < 0.1 && (lon - 11.25).abs() < 0.01,
            "{lat} {lon}"
        );
        let (bx, by) = tile_xy(lat, lon, 6);
        assert!((bx - 34.0).abs() < 1e-9 && (by - 21.0).abs() < 1e-9);
        assert_eq!(tile_xy(0.0, 0.0, 0), (0.5, 0.5));
        let (px, _) = tile_xy(89.0, 0.0, 1);
        assert_eq!(px, 1.0);
        assert!((meters_per_pixel(0.0, 0) - 156_543.03).abs() < 0.1);
        assert!(meters_per_pixel(60.0, 10) < meters_per_pixel(0.0, 10));
    }

    #[test]
    fn a_stray_ran_from_the_home_it_last_lived_in() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        c.create_clowder("clowder:h", "Home").unwrap();
        c.record_position("clowder:h", 51.34, 12.37, PositionKind::Sighting, None)
            .unwrap();
        c.create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        assert_eq!(c.stray_home_position("cat:a").unwrap(), None, "at home");
        c.move_cat("cat:a", None).unwrap();
        assert_eq!(
            c.stray_home_position("cat:a").unwrap(),
            Some((51.34, 12.37))
        );
        c.create_cat("cat:b", "Nobody", None, "cat").unwrap();
        assert_eq!(
            c.stray_home_position("cat:b").unwrap(),
            None,
            "never had a home"
        );
        c.create_clowder("clowder:n", "No position").unwrap();
        c.create_cat("cat:c", "Tom", Some("clowder:n"), "cat")
            .unwrap();
        c.move_cat("cat:c", None).unwrap();
        assert_eq!(c.stray_home_position("cat:c").unwrap(), None);
    }
}
