//! Unit Values: a number kept in the app's base unit, shown in the
//! device's unit. Storage never changes with the device; only display
//! and entry do.

use serde::{Deserialize, Serialize};

/// What a Unit Value measures, with its base unit.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Dimension {
    Weight,
    Length,
    Volume,
    Temperature,
}

impl Dimension {
    pub const ALL: [Dimension; 4] = [
        Dimension::Weight,
        Dimension::Length,
        Dimension::Volume,
        Dimension::Temperature,
    ];

    /// The stored name, as the phones write it.
    pub fn name(self) -> &'static str {
        match self {
            Dimension::Weight => "weight",
            Dimension::Length => "length",
            Dimension::Volume => "volume",
            Dimension::Temperature => "temperature",
        }
    }

    pub fn parse(name: &str) -> Option<Dimension> {
        Dimension::ALL.into_iter().find(|d| d.name() == name)
    }

    pub fn base_unit(self) -> &'static str {
        match self {
            Dimension::Weight => "g",
            Dimension::Length => "cm",
            Dimension::Volume => "ml",
            Dimension::Temperature => "°C",
        }
    }
}

/// The device's side: metric or imperial.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum UnitSystem {
    #[default]
    Metric,
    Imperial,
}

/// The local setting the unit choice lives under: `metric`, `imperial`
/// or nothing for the region's.
pub const UNITS_SETTING: &str = "units";

impl UnitSystem {
    /// The system for a setting and a region: the setting when it says,
    /// else imperial in the three countries that still measure so.
    pub fn for_setting(setting: Option<&str>, country: Option<&str>) -> UnitSystem {
        match setting {
            Some("metric") => UnitSystem::Metric,
            Some("imperial") => UnitSystem::Imperial,
            _ => {
                if matches!(country, Some("US" | "LR" | "MM")) {
                    UnitSystem::Imperial
                } else {
                    UnitSystem::Metric
                }
            }
        }
    }
}

const G_PER_LB: f64 = 453.59237;
const CM_PER_IN: f64 = 2.54;
const ML_PER_FL_OZ: f64 = 29.5735295625;

/// The unit a keeper types in for `d` on an `s` device.
pub fn entry_unit(d: Dimension, s: UnitSystem) -> &'static str {
    match (d, s) {
        (Dimension::Weight, UnitSystem::Metric) => "kg",
        (Dimension::Weight, UnitSystem::Imperial) => "lb",
        (Dimension::Length, UnitSystem::Metric) => "cm",
        (Dimension::Length, UnitSystem::Imperial) => "in",
        (Dimension::Volume, UnitSystem::Metric) => "ml",
        (Dimension::Volume, UnitSystem::Imperial) => "fl oz",
        (Dimension::Temperature, UnitSystem::Metric) => "°C",
        (Dimension::Temperature, UnitSystem::Imperial) => "°F",
    }
}

/// A typed value in [`entry_unit`] as the stored base amount.
pub fn to_base(d: Dimension, s: UnitSystem, entry: f64) -> f64 {
    match (d, s) {
        (Dimension::Weight, UnitSystem::Metric) => entry * 1000.0,
        (Dimension::Weight, UnitSystem::Imperial) => entry * G_PER_LB,
        (Dimension::Length, UnitSystem::Metric) => entry,
        (Dimension::Length, UnitSystem::Imperial) => entry * CM_PER_IN,
        (Dimension::Volume, UnitSystem::Metric) => entry,
        (Dimension::Volume, UnitSystem::Imperial) => entry * ML_PER_FL_OZ,
        (Dimension::Temperature, UnitSystem::Metric) => entry,
        (Dimension::Temperature, UnitSystem::Imperial) => (entry - 32.0) * 5.0 / 9.0,
    }
}

/// The stored base amount in [`entry_unit`].
pub fn from_base(d: Dimension, s: UnitSystem, base: f64) -> f64 {
    match (d, s) {
        (Dimension::Weight, UnitSystem::Metric) => base / 1000.0,
        (Dimension::Weight, UnitSystem::Imperial) => base / G_PER_LB,
        (Dimension::Length, UnitSystem::Metric) => base,
        (Dimension::Length, UnitSystem::Imperial) => base / CM_PER_IN,
        (Dimension::Volume, UnitSystem::Metric) => base,
        (Dimension::Volume, UnitSystem::Imperial) => base / ML_PER_FL_OZ,
        (Dimension::Temperature, UnitSystem::Metric) => base,
        (Dimension::Temperature, UnitSystem::Imperial) => base * 9.0 / 5.0 + 32.0,
    }
}

/// The stored form of a base amount: at most one decimal, no trailing
/// zeros: "4250", "4263.6".
pub fn base_string(base: f64) -> String {
    let rounded = (base * 10.0).round() / 10.0;
    if rounded == rounded.round() {
        format!("{}", rounded.round() as i64)
    } else {
        format!("{rounded:.1}")
    }
}

/// A typed number, comma or point; none when it is not one.
pub fn parse_entry(text: &str) -> Option<f64> {
    text.trim().replace(',', ".").parse().ok()
}

/// How to show a stored amount: the number, its unit, and how many
/// decimals read well. Only weight steps up a unit (g to kg).
pub fn display_parts(d: Dimension, s: UnitSystem, base: f64) -> (f64, &'static str, usize) {
    match (d, s) {
        (Dimension::Weight, UnitSystem::Metric) => {
            if base >= 1000.0 {
                (base / 1000.0, "kg", 2)
            } else {
                (base, "g", 0)
            }
        }
        (Dimension::Weight, UnitSystem::Imperial) => (base / G_PER_LB, "lb", 1),
        (Dimension::Length, UnitSystem::Metric) => (base, "cm", 1),
        (Dimension::Length, UnitSystem::Imperial) => (base / CM_PER_IN, "in", 1),
        (Dimension::Volume, UnitSystem::Metric) => (base, "ml", 0),
        (Dimension::Volume, UnitSystem::Imperial) => (base / ML_PER_FL_OZ, "fl oz", 1),
        (Dimension::Temperature, UnitSystem::Metric) => (base, "°C", 1),
        (Dimension::Temperature, UnitSystem::Imperial) => (base * 9.0 / 5.0 + 32.0, "°F", 1),
    }
}

/// A number with at most `decimals` decimals and no trailing zeros,
/// point as separator. "-0" never shows.
pub fn format_decimal(value: f64, decimals: usize) -> String {
    let mut text = format!("{value:.decimals$}");
    if decimals > 0 && text.contains('.') {
        text = text.trim_end_matches('0').trim_end_matches('.').to_string();
    }
    if text == "-0" { "0".to_string() } else { text }
}

/// Plain display with a point as decimal separator.
pub fn format_base(d: Dimension, s: UnitSystem, stored: Option<&str>) -> String {
    let Some(base) = stored.and_then(|v| v.parse::<f64>().ok()) else {
        return stored.unwrap_or_default().to_string();
    };
    let (amount, unit, decimals) = display_parts(d, s, base);
    format!("{} {unit}", format_decimal(amount, decimals))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn dimensions_round_trip_their_names_and_base_units() {
        for d in Dimension::ALL {
            assert_eq!(Dimension::parse(d.name()), Some(d));
            assert_eq!(serde_json::to_value(d).unwrap(), d.name());
        }
        assert_eq!(Dimension::parse("mass"), None);
        assert_eq!(Dimension::Weight.base_unit(), "g");
        assert_eq!(Dimension::Temperature.base_unit(), "°C");
        assert_eq!(entry_unit(Dimension::Volume, UnitSystem::Imperial), "fl oz");
    }

    #[test]
    fn entries_convert_to_base_and_back() {
        for d in Dimension::ALL {
            for s in [UnitSystem::Metric, UnitSystem::Imperial] {
                let base = to_base(d, s, 4.25);
                assert!((from_base(d, s, base) - 4.25).abs() < 1e-9, "{d:?} {s:?}");
            }
        }
        assert_eq!(to_base(Dimension::Weight, UnitSystem::Metric, 4.25), 4250.0);
        assert_eq!(base_string(4250.0), "4250");
        assert_eq!(base_string(4263.64), "4263.6");
        assert_eq!(parse_entry(" 4,25 "), Some(4.25));
        assert_eq!(parse_entry("four"), None);
    }

    #[test]
    fn display_reads_well_in_either_system() {
        assert_eq!(
            format_base(Dimension::Weight, UnitSystem::Metric, Some("4250")),
            "4.25 kg"
        );
        assert_eq!(
            format_base(Dimension::Weight, UnitSystem::Metric, Some("980")),
            "980 g"
        );
        assert_eq!(
            format_base(Dimension::Weight, UnitSystem::Imperial, Some("4263.6")),
            "9.4 lb"
        );
        assert_eq!(
            format_base(Dimension::Length, UnitSystem::Metric, Some("120")),
            "120 cm"
        );
        assert_eq!(
            format_base(Dimension::Length, UnitSystem::Imperial, Some("254")),
            "100 in"
        );
        assert_eq!(
            format_base(Dimension::Volume, UnitSystem::Metric, Some("250")),
            "250 ml"
        );
        assert_eq!(
            format_base(Dimension::Volume, UnitSystem::Imperial, Some("29.6")),
            "1 fl oz"
        );
        assert_eq!(
            format_base(Dimension::Temperature, UnitSystem::Metric, Some("38.5")),
            "38.5 °C"
        );
        assert_eq!(
            format_base(Dimension::Temperature, UnitSystem::Imperial, Some("0")),
            "32 °F"
        );
        assert_eq!(
            format_base(Dimension::Weight, UnitSystem::Metric, Some("heavy")),
            "heavy"
        );
        assert_eq!(format_base(Dimension::Weight, UnitSystem::Metric, None), "");
        assert_eq!(format_decimal(-0.01, 1), "0");
        assert_eq!(format_decimal(4.10, 2), "4.1");
    }

    #[test]
    fn the_unit_system_follows_the_setting_then_the_region() {
        assert_eq!(
            UnitSystem::for_setting(Some("metric"), Some("US")),
            UnitSystem::Metric
        );
        assert_eq!(
            UnitSystem::for_setting(Some("imperial"), Some("DE")),
            UnitSystem::Imperial
        );
        assert_eq!(
            UnitSystem::for_setting(None, Some("US")),
            UnitSystem::Imperial
        );
        assert_eq!(
            UnitSystem::for_setting(Some("auto"), Some("LR")),
            UnitSystem::Imperial
        );
        assert_eq!(
            UnitSystem::for_setting(None, Some("DE")),
            UnitSystem::Metric
        );
        assert_eq!(UnitSystem::for_setting(None, None), UnitSystem::Metric);
    }
}
