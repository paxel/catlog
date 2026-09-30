//! Everything on one spot of the map shares one pin: homes, cats and
//! fliers within 20 m of each other. The home takes the front, the
//! rest stands behind it in a list.

use crate::geo::haversine_meters;

/// The kinds of thing a pin stands for, in the order they take the
/// front of a shared spot.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum PinKind {
    Home,
    Cat,
    Flier,
    Field,
}

/// One thing at one place on the map.
#[derive(Debug, Clone, PartialEq)]
pub struct MapPin {
    pub kind: PinKind,
    pub id: String,
    pub name: String,
    pub lat: f64,
    pub lon: f64,
}

/// Things within this distance of each other count as one spot.
pub const SPOT_METERS: f64 = 20.0;

/// What stands on one spot: one pin on the map, the front thing's
/// name on it, the rest behind it.
#[derive(Debug, Clone, PartialEq)]
pub struct PinSpot {
    /// Front first: homes, then cats, then fliers; within a kind in the
    /// order the pins came.
    pub pins: Vec<MapPin>,
}

impl PinSpot {
    pub fn front(&self) -> &MapPin {
        &self.pins[0]
    }

    pub fn lat(&self) -> f64 {
        self.front().lat
    }

    pub fn lon(&self) -> f64 {
        self.front().lon
    }

    pub fn merged(&self) -> bool {
        self.pins.len() > 1
    }

    /// "Eckesloft +2" for a shared spot, the name alone for a single one.
    pub fn label(&self) -> String {
        if self.merged() {
            format!("{} +{}", self.front().name, self.pins.len() - 1)
        } else {
            self.front().name.clone()
        }
    }
}

/// Groups pins that lie within `meters` of each other. A pin joins the
/// first spot whose first pin is that close, so a spot never drifts
/// along a chain of neighbours.
pub fn group_pins(pins: Vec<MapPin>, meters: f64) -> Vec<PinSpot> {
    let mut spots: Vec<Vec<MapPin>> = Vec::new();
    for pin in pins {
        let near = spots.iter_mut().find(|spot| {
            let anchor = &spot[0];
            haversine_meters(anchor.lat, anchor.lon, pin.lat, pin.lon) <= meters
        });
        match near {
            Some(spot) => spot.push(pin),
            None => spots.push(vec![pin]),
        }
    }
    spots
        .into_iter()
        .map(|mut pins| {
            pins.sort_by_key(|p| p.kind);
            PinSpot { pins }
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn pin(kind: PinKind, name: &str, lat: f64, lon: f64) -> MapPin {
        MapPin {
            kind,
            id: format!("{kind:?}:{name}"),
            name: name.to_string(),
            lat,
            lon,
        }
    }

    #[test]
    fn things_within_twenty_metres_share_a_spot_and_the_home_leads() {
        let spots = group_pins(
            vec![
                pin(PinKind::Cat, "Hahn", 49.4264, 6.8376),
                pin(PinKind::Cat, "Schneeweißchen", 49.42644, 6.8376),
                pin(PinKind::Home, "Barn", 49.429, 6.8376),
                pin(PinKind::Flier, "Luna", 49.42642, 6.8376),
                pin(PinKind::Home, "Yard", 49.42641, 6.8376),
            ],
            SPOT_METERS,
        );
        assert_eq!(spots.len(), 2);
        let names: Vec<&str> = spots[0].pins.iter().map(|p| p.name.as_str()).collect();
        assert_eq!(names, ["Yard", "Hahn", "Schneeweißchen", "Luna"]);
        assert_eq!(spots[0].label(), "Yard +3");
        assert_eq!(spots[0].lat(), 49.42641);
        assert_eq!(spots[1].label(), "Barn");
        assert!(!spots[1].merged());
    }

    #[test]
    fn a_spot_never_drifts_along_a_chain() {
        let spots = group_pins(
            vec![
                pin(PinKind::Cat, "A", 52.52, 13.40),
                pin(PinKind::Cat, "B", 52.520135, 13.40),
                pin(PinKind::Cat, "C", 52.52027, 13.40),
            ],
            SPOT_METERS,
        );
        let labels: Vec<String> = spots.iter().map(PinSpot::label).collect();
        assert_eq!(labels, ["A +1", "C"]);
    }
}
