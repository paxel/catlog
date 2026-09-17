//! Display-time words for stored values (ADR 0005): seeded names and
//! canonical values stay English in the data; the desk shows the
//! chosen language. Documents and codes speak in the app's words
//! wherever a raw value would otherwise show.

use catlog_core::chores::{Chore, ChoreRepeat, ChoreSchedule, ChoreUnit, Hhmm, parse_day};
use catlog_core::fields::{CAT_BREEDS, FieldDef, FieldType, SPECIES_PRESETS};
use catlog_core::units::{Dimension, UnitSystem, display_parts, format_decimal};
use catlog_core::{Appointment, Catalog, PartialDate, keys, looks};
use chrono::{Datelike, NaiveDate};

use crate::l10n::L10n;

/// The starter Fields' seeded English names, by slug.
fn canonical_name(slug: &str) -> Option<&'static str> {
    Some(match slug {
        "gender" => "Gender",
        "color" => "Color",
        "breed" => "Breed",
        "chipid" => "Chip ID",
        "neutered" => "Neutered",
        "pregnant" => "Pregnant",
        "birthdate" => "Birth date",
        "deceased" => "Deceased",
        "species" => "Species",
        "weight" => "Weight",
        "looks" => "Looks",
        "mother" => "Mother",
        "father" => "Father",
        "status" => "Status",
        "address" => "Address",
        "responsible" => "Responsible person",
        "email" => "Email",
        "phone" => "Phone",
        "position" => "Position",
        "remarks" => "Remarks",
        _ => return None,
    })
}

fn translated_name(t: &L10n, slug: &str) -> Option<String> {
    Some(
        match slug {
            "gender" => t.starter_gender(),
            "color" => t.starter_color(),
            "breed" => t.starter_breed(),
            "chipid" => t.starter_chip_id(),
            "neutered" => t.starter_neutered(),
            "pregnant" => t.starter_pregnant(),
            "birthdate" => t.starter_birthdate(),
            "deceased" => t.starter_deceased(),
            "species" => t.starter_species(),
            "mother" => t.starter_mother(),
            "father" => t.starter_father(),
            "status" => t.starter_status(),
            "address" => t.starter_address(),
            "responsible" => t.starter_responsible(),
            "email" => t.starter_email(),
            "phone" => t.starter_phone(),
            "position" => t.starter_position(),
            "remarks" => t.starter_remarks(),
            "weight" => t.starter_weight(),
            "looks" => t.starter_looks(),
            _ => return None,
        }
        .to_string(),
    )
}

/// A Field's name as the keeper reads it: the translation of a starter
/// unless the keeper renamed it, then the typed name everywhere.
pub fn field_def_name(t: &L10n, def: &FieldDef) -> String {
    if canonical_name(&def.slug) == Some(def.name.as_str())
        && let Some(name) = translated_name(t, &def.slug)
    {
        return name;
    }
    def.name.clone()
}

/// Whether a locale writes the decimal mark as a comma.
fn decimal_comma(locale: &str) -> bool {
    !matches!(locale, "en" | "ja" | "zh" | "he" | "ga" | "mt" | "th")
}

/// A number with at most `decimals` decimals in the locale's way.
pub fn format_number(locale: &str, n: f64, decimals: usize) -> String {
    let text = format_decimal(n, decimals);
    if decimal_comma(locale) {
        text.replace('.', ",")
    } else {
        text
    }
}

/// A day in the locale's order: `5/14/2021`, `14.5.2021`, `14/05/2021`,
/// `2021-05-14`.
pub fn format_day(locale: &str, d: NaiveDate) -> String {
    let (y, m, day) = (d.year(), d.month(), d.day());
    match locale {
        "en" => format!("{m}/{day}/{y}"),
        "de" | "da" | "fi" | "no" | "cs" | "sk" | "pl" | "ru" | "uk" | "tr" | "bg" | "hr"
        | "sr" | "sl" | "bs" | "mk" | "sq" | "ro" | "et" | "is" | "lv" | "lt" | "hu" => {
            format!("{day}.{m}.{y}")
        }
        "sv" | "ja" | "zh" | "ar" | "fa" => format!("{y}-{m:02}-{day:02}"),
        "nl" => format!("{day}-{m}-{y}"),
        _ => format!("{day:02}/{m:02}/{y}"),
    }
}

/// A partial date at its own precision: a day as a day, a month as
/// `5/2021` or `05.2021`, a year as `2021`.
pub fn format_partial_date(locale: &str, date: &PartialDate) -> String {
    match (date.month, date.day) {
        (Some(m), Some(d)) => match NaiveDate::from_ymd_opt(date.year, m, d) {
            Some(day) => format_day(locale, day),
            None => date.iso(),
        },
        (Some(m), None) => match locale {
            "en" => format!("{m}/{}", date.year),
            "sv" | "ja" | "zh" | "ar" | "fa" => format!("{}-{m:02}", date.year),
            _ => format!("{m:02}.{}", date.year),
        },
        _ => date.year.to_string(),
    }
}

/// `08:00` for a time of day.
pub fn clock(at: Hhmm) -> String {
    at.text()
}

pub fn status_display(t: &L10n, value: &str) -> Option<String> {
    Some(
        match value {
            "foster" => t.status_foster(),
            "forever-home" => t.status_forever_home(),
            "clinic" => t.status_clinic(),
            "shelter" => t.status_shelter(),
            "barn" => t.status_barn(),
            "owner" => t.status_owner(),
            _ => return None,
        }
        .to_string(),
    )
}

pub fn species_display(t: &L10n, value: &str) -> String {
    match value {
        "cat" => t.value_cat(),
        "dog" => t.value_dog(),
        "rabbit" => t.value_rabbit(),
        "guinea pig" => t.value_guinea_pig(),
        "hamster" => t.value_hamster(),
        "bird" => t.value_bird(),
        "horse" => t.value_horse(),
        "tortoise" => t.value_tortoise(),
        "ferret" => t.value_ferret(),
        other => other,
    }
    .to_string()
}

pub fn dimension_name(t: &L10n, d: Dimension) -> String {
    match d {
        Dimension::Weight => t.dimension_weight(),
        Dimension::Length => t.dimension_length(),
        Dimension::Volume => t.dimension_volume(),
        Dimension::Temperature => t.dimension_temperature(),
    }
    .to_string()
}

/// The translated name of a starter cat breed; anything else as typed.
pub fn breed_display(t: &L10n, value: &str) -> String {
    if value == "mixed" {
        return t.value_mixed().to_string();
    }
    if !CAT_BREEDS.contains(&value) {
        return value.to_string();
    }
    // The ARB keys follow the breed names: `breedMaineCoon` for Maine Coon.
    let key = format!(
        "breed{}",
        value
            .split(' ')
            .map(|w| {
                let mut c = w.chars();
                match c.next() {
                    Some(f) => f.to_uppercase().collect::<String>() + c.as_str(),
                    None => String::new(),
                }
            })
            .collect::<String>()
    );
    t.raw_by_name(&key)
        .map(String::from)
        .unwrap_or_else(|| value.to_string())
}

/// A stored Looks line as one readable line: `Size: Medium · Colours:
/// Black, White`, in the chosen language.
pub fn looks_display(t: &L10n, value: &str) -> String {
    let parsed = looks::parse_looks(Some(value));
    let parts: Vec<String> = looks::GROUP_ORDER
        .iter()
        .filter_map(|g| {
            let values = parsed.get(*g)?;
            let words: Vec<String> = values.iter().map(|v| looks_value_label(t, v)).collect();
            Some(format!("{}: {}", looks_group_label(t, g), words.join(", ")))
        })
        .collect();
    if parts.is_empty() {
        value.to_string()
    } else {
        parts.join(" · ")
    }
}

pub fn looks_group_label(t: &L10n, group: &str) -> String {
    let key = format!("looksGroup{}", capitalize(group));
    t.raw_by_name(&key)
        .map(String::from)
        .unwrap_or_else(|| group.to_string())
}

pub fn looks_value_label(t: &L10n, value: &str) -> String {
    match value {
        "yes" => return t.value_yes().to_string(),
        "no" => return t.value_no().to_string(),
        _ => {}
    }
    let key = format!(
        "looksValue{}",
        value.split([' ', '-']).map(capitalize).collect::<String>()
    );
    t.raw_by_name(&key)
        .map(String::from)
        .unwrap_or_else(|| value.to_string())
}

fn capitalize(word: &str) -> String {
    let mut c = word.chars();
    match c.next() {
        Some(f) => f.to_uppercase().collect::<String>() + c.as_str(),
        None => String::new(),
    }
}

/// A stored value as the keeper reads it, for a Field's type and slug.
pub fn field_value_display(
    t: &L10n,
    def: Option<&FieldDef>,
    value: Option<&str>,
    units: UnitSystem,
) -> String {
    let Some(value) = value else {
        return "—".to_string();
    };
    let locale = t.locale();
    match def.map(|d| d.field_type) {
        Some(FieldType::Location) => return t.on_map_label().to_string(),
        Some(FieldType::Date) => {
            if let Some(date) = PartialDate::parse(value) {
                return format_partial_date(locale, &date);
            }
        }
        Some(FieldType::Number) => {
            if let Ok(n) = value.replace(',', ".").parse::<f64>() {
                return format_number(locale, n, 6);
            }
        }
        Some(FieldType::UnitValue) => {
            if let Some(d) = def
                && let Ok(base) = value.parse::<f64>()
            {
                let (amount, unit, decimals) = display_parts(d.unit_dimension(), units, base);
                return format!("{} {unit}", format_number(locale, amount, decimals));
            }
            return value.to_string();
        }
        Some(FieldType::Tags) => return looks_display(t, value),
        _ => {}
    }
    let slug = def.map(|d| d.slug.as_str()).unwrap_or("");
    if slug == "breed" {
        return breed_display(t, value);
    }
    match value {
        "yes" => return t.value_yes().to_string(),
        "no" => return t.value_no().to_string(),
        "female" if slug == "gender" => return t.value_female().to_string(),
        "male" if slug == "gender" => return t.value_male().to_string(),
        "unknown" if slug == "gender" => return t.value_unknown().to_string(),
        _ => {}
    }
    if slug == "species" {
        return species_display(t, value);
    }
    if slug == "status" {
        return status_display(t, value).unwrap_or_else(|| value.to_string());
    }
    value.to_string()
}

/// The label of a raw field key: user Fields through their definitions,
/// reserved keys by their words.
pub fn field_label(t: &L10n, store: &Catalog, key: &str) -> String {
    if key == keys::NAME {
        return t.label_name().to_string();
    }
    if key == keys::PRIVATE {
        return t.private_label().to_string();
    }
    if let Some(inner) = key.strip_prefix(keys::PRIVATE_PREFIX) {
        return t.private_marker(&field_label(t, store, inner));
    }
    if let Some(inner) = key.strip_prefix(keys::WITHHELD_PREFIX) {
        return t.private_marker(&field_label(t, store, inner));
    }
    if key.starts_with(keys::APPOINTMENT_PREFIX) {
        return t.appointment_label().to_string();
    }
    if let Some(rest) = key.strip_prefix(keys::CHORE_PREFIX) {
        return if rest.contains('@') {
            t.chore_tick_label().to_string()
        } else {
            t.chore_label().to_string()
        };
    }
    if key == "title" {
        return t.title_label().to_string();
    }
    if key == keys::DELETED {
        return t.deleted_label().to_string();
    }
    if key == keys::CLOWDER {
        return t.clowder_label().to_string();
    }
    if key == keys::PROFILE_IMAGE {
        return t.label_profile_image().to_string();
    }
    if key.starts_with(keys::IMAGE_PREFIX) {
        return t.label_photo().to_string();
    }
    let canonical = store.canonical_key(key).unwrap_or_else(|_| key.to_string());
    if let Ok(defs) = store.field_defs(None)
        && let Some(def) = defs.iter().find(|d| d.key() == canonical)
    {
        return field_def_name(t, def);
    }
    key.to_string()
}

/// A JSON document as indented "key: value" lines; none when `raw` is
/// not a JSON object.
pub fn document_words(raw: &str) -> Option<String> {
    if !raw.trim_start().starts_with('{') {
        return None;
    }
    let parsed: serde_json::Value = serde_json::from_str(raw).ok()?;
    let map = parsed.as_object()?;
    let mut lines = Vec::new();
    fn walk(
        map: &serde_json::Map<String, serde_json::Value>,
        depth: usize,
        lines: &mut Vec<String>,
    ) {
        let pad = "  ".repeat(depth);
        for (k, v) in map {
            match v {
                serde_json::Value::Object(inner) => {
                    lines.push(format!("{pad}{k}:"));
                    walk(inner, depth + 1, lines);
                }
                serde_json::Value::Array(items) => {
                    let words: Vec<String> = items
                        .iter()
                        .map(|i| match i {
                            serde_json::Value::String(s) => s.clone(),
                            other => other.to_string(),
                        })
                        .collect();
                    lines.push(format!("{pad}{k}: {}", words.join(", ")));
                }
                serde_json::Value::String(s) => lines.push(format!("{pad}{k}: {s}")),
                other => lines.push(format!("{pad}{k}: {other}")),
            }
        }
    }
    walk(map, 0, &mut lines);
    Some(lines.join("\n"))
}

/// "every 2 weeks", "daily", "Mon, Wed, Fri".
pub fn schedule_words(t: &L10n, s: &ChoreSchedule) -> String {
    match s.repeat {
        ChoreRepeat::Daily => t.chore_repeat_daily().to_string(),
        ChoreRepeat::EveryDays => match s.unit {
            ChoreUnit::Days => t.chore_every_days(s.every as i64),
            ChoreUnit::Weeks => t.chore_every_weeks(s.every as i64),
            ChoreUnit::Months => t.chore_every_months(s.every as i64),
            ChoreUnit::Years => t.chore_every_years(s.every as i64),
        },
        ChoreRepeat::Weekdays => s
            .weekdays
            .iter()
            .map(|d| weekday_short(t, *d))
            .collect::<Vec<_>>()
            .join(", "),
    }
}

/// The short name of a weekday, Monday = 1, in the chosen language.
pub fn weekday_short(t: &L10n, day: u32) -> String {
    let key = match day {
        1 => "weekdayMon",
        2 => "weekdayTue",
        3 => "weekdayWed",
        4 => "weekdayThu",
        5 => "weekdayFri",
        6 => "weekdaySat",
        _ => "weekdaySun",
    };
    t.raw_by_name(key).map(String::from).unwrap_or_else(|| {
        ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][(day.clamp(1, 7) - 1) as usize]
            .to_string()
    })
}

/// "Feed · every 2 days · 08:00 · reminder 08:00 · Paused".
pub fn chore_words(t: &L10n, c: &Chore) -> String {
    let mut parts = vec![c.title.clone(), schedule_words(t, &c.schedule)];
    if let Some(at) = c.time {
        parts.push(clock(at));
    }
    if c.remind
        && let Some(at) = c.remind_at
    {
        parts.push(t.chore_remind_at(&clock(at)));
    }
    if c.paused {
        parts.push(t.chore_paused().to_string());
    }
    if c.ended {
        parts.push(t.chore_ended().to_string());
    }
    parts.join(" · ")
}

/// "done on 9/11/2026" for a tick's stored day.
pub fn tick_words(t: &L10n, day_value: &str) -> String {
    match parse_day(Some(day_value)) {
        Some(day) => t.done_on(&format_day(t.locale(), day)),
        None => day_value.to_string(),
    }
}

/// "Butler (Feed)" for a `rank|chore` title value.
pub fn title_words(t: &L10n, value: &str) -> String {
    let Some((rank, chore)) = value.split_once('|') else {
        return value.to_string();
    };
    let rank_name = match rank {
        "servant" => t.rank_servant(),
        "butler" => t.rank_butler(),
        "steward" => t.rank_steward(),
        "chancellor" => t.rank_chancellor(),
        "minister" => t.rank_minister(),
        _ => return value.to_string(),
    };
    t.title_with_chore(rank_name, chore)
}

/// The words for `value` under `key`, or none when the key is not one
/// of the documents and codes this file knows.
pub fn stored_value_words(t: &L10n, key: &str, value: &str) -> Option<String> {
    if let Some(rest) = key.strip_prefix(keys::CHORE_PREFIX) {
        if rest.contains('@') {
            return Some(tick_words(t, value));
        }
        return Some(match Chore::from_json(rest, "", Some(value)) {
            Some(chore) => chore_words(t, &chore),
            None => document_words(value).unwrap_or_else(|| value.to_string()),
        });
    }
    if key == "title" {
        return Some(title_words(t, value));
    }
    if key == keys::PRIVATE || key.starts_with(keys::PRIVATE_PREFIX) {
        return Some(
            if value == "yes" {
                t.private_label()
            } else {
                t.value_no()
            }
            .to_string(),
        );
    }
    if key.starts_with(keys::WITHHELD_PREFIX) {
        return Some(t.withheld_by_partner().to_string());
    }
    if key == keys::DELETED {
        return Some(
            if value == "true" {
                t.value_yes()
            } else {
                t.value_no()
            }
            .to_string(),
        );
    }
    None
}

/// A raw entry value as the keeper reads it, for its field key.
pub fn value_label(
    t: &L10n,
    store: &Catalog,
    key: &str,
    value: Option<&str>,
    units: UnitSystem,
) -> String {
    let Some(value) = value else {
        return "—".to_string();
    };
    if key == keys::CLOWDER {
        return store
            .current(value, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| value.to_string());
    }
    if let Some(id) = key.strip_prefix(keys::APPOINTMENT_PREFIX) {
        let Some(a) = Appointment::from_json(id, "", Some(value)) else {
            return value.to_string();
        };
        let when = a.time.map(|t| format!(" {}", clock(t))).unwrap_or_default();
        let done = if a.done { " ✓" } else { "" };
        return format!("{}{when}{done}", a.title);
    }
    if key.starts_with(keys::IMAGE_PREFIX) {
        return value.to_string();
    }
    if key == keys::PROFILE_IMAGE {
        return "·".to_string();
    }
    if let Some(words) = stored_value_words(t, key, value) {
        return words;
    }
    if let Some(lines) = document_words(value) {
        return lines;
    }
    let canonical = store.canonical_key(key).unwrap_or_else(|_| key.to_string());
    let defs = store.field_defs(None).unwrap_or_default();
    let def = defs.iter().find(|d| d.key() == canonical);
    if def.map(|d| d.field_type) == Some(FieldType::Cat) {
        let id = store
            .resolve_entity(value)
            .unwrap_or_else(|_| value.to_string());
        return store
            .current(&id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| value.to_string());
    }
    if (def.map(|d| d.field_type) == Some(FieldType::Location)
        || key == catlog_core::entities::POSITION_KEY)
        && let Some((lat, lon)) = catlog_core::entities::parse_position(Some(value))
    {
        return format!(
            "{lat:.5}, {lon:.5} · {}",
            catlog_core::plus_code::encode_plus_code(lat, lon)
        );
    }
    field_value_display(t, def, Some(value), units)
}

/// Whether a species preset is one the app knows.
pub fn is_species_preset(value: &str) -> bool {
    SPECIES_PRESETS.contains(&value)
}

#[cfg(test)]
mod tests {
    use super::*;
    use catlog_core::fields::{FieldScope, IdDisplay};

    fn def(slug: &str, name: &str, field_type: FieldType) -> FieldDef {
        FieldDef {
            id: format!("fielddef:{slug}"),
            slug: slug.into(),
            name: name.into(),
            field_type,
            scope: FieldScope::Both,
            options: vec![],
            id_display: IdDisplay::Plain,
            lookup_url: None,
            dimension: Some(Dimension::Weight),
            extra_options: Default::default(),
        }
    }

    #[test]
    fn starter_names_translate_unless_renamed() {
        let en = L10n::new("en");
        let de = L10n::new("de");
        assert_eq!(
            field_def_name(&de, &def("gender", "Gender", FieldType::Choice)),
            de.starter_gender()
        );
        assert_ne!(
            field_def_name(&de, &def("gender", "Gender", FieldType::Choice)),
            "Gender"
        );
        assert_eq!(
            field_def_name(&de, &def("gender", "Sex", FieldType::Choice)),
            "Sex"
        );
        assert_eq!(
            field_def_name(&en, &def("mood", "Mood", FieldType::Text)),
            "Mood"
        );
    }

    #[test]
    fn values_read_in_the_keepers_language_and_units() {
        let en = L10n::new("en");
        let de = L10n::new("de");
        let metric = UnitSystem::Metric;
        assert_eq!(field_value_display(&en, None, None, metric), "—");
        assert_eq!(
            field_value_display(
                &en,
                Some(&def("neutered", "Neutered", FieldType::YesNo)),
                Some("yes"),
                metric
            ),
            en.value_yes()
        );
        assert_eq!(
            field_value_display(
                &de,
                Some(&def("neutered", "Neutered", FieldType::YesNo)),
                Some("no"),
                metric
            ),
            de.value_no()
        );
        let gender = def("gender", "Gender", FieldType::Choice);
        assert_eq!(
            field_value_display(&de, Some(&gender), Some("female"), metric),
            de.value_female()
        );
        assert_eq!(
            field_value_display(
                &de,
                Some(&def("mood", "Mood", FieldType::Choice)),
                Some("female"),
                metric
            ),
            "female"
        );
        assert_eq!(
            field_value_display(
                &en,
                Some(&def("position", "Position", FieldType::Location)),
                Some("1,2"),
                metric
            ),
            en.on_map_label()
        );
        let date = def("birthdate", "Birth date", FieldType::Date);
        assert_eq!(
            field_value_display(&en, Some(&date), Some("2021-05-14"), metric),
            "5/14/2021"
        );
        assert_eq!(
            field_value_display(&de, Some(&date), Some("2021-05-14"), metric),
            "14.5.2021"
        );
        assert_eq!(
            field_value_display(&de, Some(&date), Some("2021-05"), metric),
            "05.2021"
        );
        assert_eq!(
            field_value_display(&en, Some(&date), Some("2021-05"), metric),
            "5/2021"
        );
        assert_eq!(
            field_value_display(&en, Some(&date), Some("2021"), metric),
            "2021"
        );
        assert_eq!(
            field_value_display(&en, Some(&date), Some("junk"), metric),
            "junk"
        );
        let number = def("visits", "Visits", FieldType::Number);
        assert_eq!(
            field_value_display(&de, Some(&number), Some("4.25"), metric),
            "4,25"
        );
        assert_eq!(
            field_value_display(&en, Some(&number), Some("4,25"), metric),
            "4.25"
        );
        assert_eq!(
            field_value_display(&en, Some(&number), Some("x"), metric),
            "x"
        );
        let weight = def("weight", "Weight", FieldType::UnitValue);
        assert_eq!(
            field_value_display(&en, Some(&weight), Some("4250"), metric),
            "4.25 kg"
        );
        assert_eq!(
            field_value_display(&de, Some(&weight), Some("4250"), UnitSystem::Imperial),
            "9,4 lb"
        );
        assert_eq!(
            field_value_display(&en, Some(&weight), Some("heavy"), metric),
            "heavy"
        );
        let looks = def("looks", "Looks", FieldType::Tags);
        let shown = field_value_display(
            &en,
            Some(&looks),
            Some("size=medium; colours=black,white"),
            metric,
        );
        assert!(
            shown.starts_with(&format!(
                "{}: {}",
                en.looks_group_size(),
                en.looks_value_medium()
            )),
            "{shown}"
        );
        assert!(shown.contains(" · "));
        assert_eq!(
            field_value_display(&en, Some(&looks), Some("nonsense"), metric),
            "nonsense"
        );
        let breed = def("breed", "Breed", FieldType::Choice);
        assert_eq!(
            field_value_display(&de, Some(&breed), Some("Maine Coon"), metric),
            de.breed_maine_coon()
        );
        assert_eq!(
            field_value_display(&de, Some(&breed), Some("mixed"), metric),
            de.value_mixed()
        );
        assert_eq!(
            field_value_display(&de, Some(&breed), Some("Housecat"), metric),
            "Housecat"
        );
        let species = def("species", "Species", FieldType::Choice);
        assert_eq!(
            field_value_display(&de, Some(&species), Some("dog"), metric),
            de.value_dog()
        );
        assert_eq!(
            field_value_display(&de, Some(&species), Some("axolotl"), metric),
            "axolotl"
        );
        let status = def("status", "Status", FieldType::Choice);
        assert_eq!(
            field_value_display(&de, Some(&status), Some("barn"), metric),
            de.status_barn()
        );
        assert_eq!(
            field_value_display(&de, Some(&status), Some("camp"), metric),
            "camp"
        );
        assert!(is_species_preset("dog") && !is_species_preset("axolotl"));
        assert_eq!(
            dimension_name(&en, Dimension::Length),
            en.dimension_length()
        );
        assert_eq!(
            format_day("nl", NaiveDate::from_ymd_opt(2021, 5, 14).unwrap()),
            "14-5-2021"
        );
        assert_eq!(
            format_day("sv", NaiveDate::from_ymd_opt(2021, 5, 4).unwrap()),
            "2021-05-04"
        );
        assert_eq!(
            format_day("fr", NaiveDate::from_ymd_opt(2021, 5, 4).unwrap()),
            "04/05/2021"
        );
        assert_eq!(
            format_partial_date("sv", &PartialDate::parse("2021-05").unwrap()),
            "2021-05"
        );
    }

    #[test]
    fn documents_and_codes_speak_in_words() {
        let en = L10n::new("en");
        let chore = Chore {
            id: "c".into(),
            entity: "cat:a".into(),
            title: "Feed".into(),
            schedule: ChoreSchedule::every(2, ChoreUnit::Days),
            time: Some(Hhmm { hour: 8, minute: 0 }),
            start: NaiveDate::from_ymd_opt(2026, 1, 1).unwrap(),
            paused: true,
            ended: true,
            remind: true,
            remind_at: Some(Hhmm {
                hour: 7,
                minute: 30,
            }),
            extra: Default::default(),
        };
        let words = chore_words(&en, &chore);
        assert!(words.starts_with("Feed · "));
        assert!(
            words.contains("08:00")
                && words.contains(en.chore_paused())
                && words.contains(en.chore_ended())
        );
        assert_eq!(
            schedule_words(&en, &ChoreSchedule::daily()),
            en.chore_repeat_daily()
        );
        assert_eq!(
            schedule_words(&en, &ChoreSchedule::every(3, ChoreUnit::Weeks)),
            en.chore_every_weeks(3)
        );
        assert_eq!(
            schedule_words(&en, &ChoreSchedule::every(1, ChoreUnit::Months)),
            en.chore_every_months(1)
        );
        assert_eq!(
            schedule_words(&en, &ChoreSchedule::every(1, ChoreUnit::Years)),
            en.chore_every_years(1)
        );
        assert_eq!(
            schedule_words(&en, &ChoreSchedule::weekdays(vec![1, 3, 5])),
            format!(
                "{}, {}, {}",
                weekday_short(&en, 1),
                weekday_short(&en, 3),
                weekday_short(&en, 5)
            )
        );
        assert_eq!(tick_words(&en, "2026-09-11"), en.done_on("9/11/2026"));
        assert_eq!(tick_words(&en, "x"), "x");
        assert_eq!(
            title_words(&en, "butler|Feed"),
            en.title_with_chore(en.rank_butler(), "Feed")
        );
        assert_eq!(title_words(&en, "king|Feed"), "king|Feed");
        assert_eq!(title_words(&en, "plain"), "plain");
        assert_eq!(
            document_words(r#"{"a":{"b":1},"c":["x","y"],"d":"e","f":true}"#).unwrap(),
            "a:\n  b: 1\nc: x, y\nd: e\nf: true"
        );
        assert_eq!(document_words("[1]"), None);
        assert_eq!(document_words("{broken"), None);
        assert_eq!(
            stored_value_words(&en, "$chore:c@2026-01-01", "2026-01-02"),
            Some(en.done_on("1/2/2026"))
        );
        assert_eq!(
            stored_value_words(&en, "$chore:c", &chore.to_json().to_string()),
            Some(chore_words(&en, &chore))
        );
        // A bare object is a chore without a title, as on the phones.
        assert_eq!(
            stored_value_words(&en, "$chore:c", "{\"odd\":1}"),
            Some(format!(" · {}", en.chore_repeat_daily()))
        );
        assert_eq!(
            stored_value_words(&en, "$chore:c", "junk"),
            Some("junk".to_string())
        );
        assert_eq!(
            stored_value_words(&en, "title", "butler|Feed"),
            Some(title_words(&en, "butler|Feed"))
        );
        assert_eq!(
            stored_value_words(&en, "$private:f:x", "yes"),
            Some(en.private_label().to_string())
        );
        assert_eq!(
            stored_value_words(&en, "$private", "no"),
            Some(en.value_no().to_string())
        );
        assert_eq!(
            stored_value_words(&en, "$withheld:f:x", "yes"),
            Some(en.withheld_by_partner().to_string())
        );
        assert_eq!(
            stored_value_words(&en, "$deleted", "true"),
            Some(en.value_yes().to_string())
        );
        assert_eq!(
            stored_value_words(&en, "$deleted", "x"),
            Some(en.value_no().to_string())
        );
        assert_eq!(stored_value_words(&en, "f:x", "y"), None);
    }

    #[test]
    fn labels_and_values_resolve_through_the_store() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_clowder("clowder:h", "Home").unwrap();
        store
            .create_cat("cat:a", "Miezi", Some("clowder:h"), "cat")
            .unwrap();
        store.create_cat("cat:m", "Mom", None, "cat").unwrap();
        store.append("cat:a", "f:mother", Some("cat:m")).unwrap();
        store
            .append("cat:a", "f:position", Some("51.34,12.37"))
            .unwrap();
        store
            .define_field(
                "Mood",
                FieldType::Text,
                FieldScope::Cat,
                &[],
                IdDisplay::Plain,
                None,
                None,
            )
            .unwrap();
        let en = L10n::new("en");
        let m = UnitSystem::Metric;
        assert_eq!(field_label(&en, &store, keys::NAME), en.label_name());
        assert_eq!(
            field_label(&en, &store, "$private:f:mood"),
            en.private_marker("Mood")
        );
        assert_eq!(
            field_label(&en, &store, "$withheld:f:mood"),
            en.private_marker("Mood")
        );
        assert_eq!(field_label(&en, &store, keys::PRIVATE), en.private_label());
        assert_eq!(field_label(&en, &store, "$appt:x"), en.appointment_label());
        assert_eq!(field_label(&en, &store, "$chore:x"), en.chore_label());
        assert_eq!(
            field_label(&en, &store, "$chore:x@2026-01-01"),
            en.chore_tick_label()
        );
        assert_eq!(field_label(&en, &store, "title"), en.title_label());
        assert_eq!(field_label(&en, &store, keys::DELETED), en.deleted_label());
        assert_eq!(field_label(&en, &store, keys::CLOWDER), en.clowder_label());
        assert_eq!(
            field_label(&en, &store, keys::PROFILE_IMAGE),
            en.label_profile_image()
        );
        assert_eq!(field_label(&en, &store, "$image:abc"), en.label_photo());
        assert_eq!(field_label(&en, &store, "f:gender"), en.starter_gender());
        assert_eq!(field_label(&en, &store, "f:mood"), "Mood");
        assert_eq!(field_label(&en, &store, "f:nope"), "f:nope");
        assert_eq!(value_label(&en, &store, "f:mood", None, m), "—");
        assert_eq!(
            value_label(&en, &store, keys::CLOWDER, Some("clowder:h"), m),
            "Home"
        );
        assert_eq!(
            value_label(&en, &store, keys::CLOWDER, Some("clowder:nope"), m),
            "clowder:nope"
        );
        assert_eq!(
            value_label(&en, &store, "f:mother", Some("cat:m"), m),
            "Mom"
        );
        assert_eq!(
            value_label(&en, &store, "f:mother", Some("cat:nope"), m),
            "cat:nope"
        );
        assert_eq!(
            value_label(&en, &store, "f:position", Some("51.34,12.37"), m),
            "51.34000, 12.37000 · 9F3J89RC+22"
        );
        assert_eq!(
            value_label(&en, &store, "f:position", Some("junk"), m),
            en.on_map_label()
        );
        assert_eq!(
            value_label(&en, &store, "$image:abc", Some("added"), m),
            "added"
        );
        assert_eq!(
            value_label(&en, &store, keys::PROFILE_IMAGE, Some("abc"), m),
            "·"
        );
        assert_eq!(
            value_label(
                &en,
                &store,
                "$appt:x",
                Some(r#"{"date":"2026-03-10","time":"09:30","title":"Shots","done":true}"#),
                m
            ),
            "Shots 09:30 ✓"
        );
        assert_eq!(value_label(&en, &store, "$appt:x", Some("junk"), m), "junk");
        assert_eq!(
            value_label(&en, &store, "f:mood", Some("{\"k\":\"v\"}"), m),
            "k: v"
        );
        assert_eq!(
            value_label(&en, &store, "f:gender", Some("female"), m),
            en.value_female()
        );
    }
}
