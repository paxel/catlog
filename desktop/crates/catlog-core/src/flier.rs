//! A missing-cat poster read into a Cat and its owner's Clowder: the
//! lines text recognition found, paired label and value by their
//! height, matched against the shipped Flier Templates, assigned to
//! Fields, and finally saved as ADR 0007 says.

use std::collections::BTreeMap;

use regex::Regex;

use crate::Result;
use crate::catalog::Catalog;
use crate::entities::PositionKind;
use crate::fields::{FieldDef, FieldType};
use crate::keys;
use crate::partial_date::PartialDate;
use crate::registry::{REGISTRY_PRESETS, id_from_lookup_url};

/// The templates that ship with the app.
pub static TEMPLATES_JSON: &str = include_str!("../../../../assets/fliers/templates.json");

/// Where a line goes: a target the wizard owns, or a Field slug.
pub mod target {
    pub const NAME: &str = "name";
    pub const REGISTRY_NUMBER: &str = "registryNumber";
    pub const MISSING_SINCE: &str = "missingSince";
    pub const LOST_PLACE: &str = "lostPlace";
    pub const CONTACT: &str = "contact";
    pub const REMARKS: &str = "remarks";
    pub const DROP: &str = "drop";
}

/// One line as recognised: its text and its box in pixels.
#[derive(Debug, Clone, PartialEq)]
pub struct FlierLine {
    pub text: String,
    pub left: f32,
    pub top: f32,
    pub width: f32,
    pub height: f32,
}

impl FlierLine {
    pub fn new(text: &str, left: f32, top: f32, width: f32, height: f32) -> FlierLine {
        FlierLine {
            text: text.to_string(),
            left,
            top,
            width,
            height,
        }
    }
    fn right(&self) -> f32 {
        self.left + self.width
    }
    fn bottom(&self) -> f32 {
        self.top + self.height
    }
}

/// A label with the value beside it, or a lone line.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FlierPair {
    pub label: Option<String>,
    pub value: String,
}

impl FlierPair {
    pub fn lone(value: &str) -> FlierPair {
        FlierPair {
            label: None,
            value: value.to_string(),
        }
    }
    pub fn labelled(label: &str, value: &str) -> FlierPair {
        FlierPair {
            label: Some(label.to_string()),
            value: value.to_string(),
        }
    }
}

/// Pairs each short line with the nearest line at its height to the
/// right; body text stays lone.
pub fn pair_lines(lines: &[FlierLine]) -> Vec<FlierPair> {
    let mut sorted: Vec<(usize, &FlierLine)> = lines.iter().enumerate().collect();
    sorted.sort_by(|a, b| {
        a.1.top
            .partial_cmp(&b.1.top)
            .unwrap_or(std::cmp::Ordering::Equal)
    });
    let mut used = vec![false; lines.len()];
    let mut pairs = Vec::new();
    for (i, line) in &sorted {
        if used[*i] {
            continue;
        }
        used[*i] = true;
        let mut partner: Option<usize> = None;
        let mut gap = f32::INFINITY;
        if line.text.split_whitespace().count() <= 5 {
            for (j, other) in &sorted {
                if used[*j] || other.left < line.right() - line.height / 2.0 {
                    continue;
                }
                let overlap = line.bottom().min(other.bottom()) - line.top.max(other.top);
                if overlap < line.height.min(other.height) / 2.0 {
                    continue;
                }
                let distance = other.left - line.right();
                if distance < gap {
                    gap = distance;
                    partner = Some(*j);
                }
            }
        }
        match partner {
            None => pairs.push(FlierPair::lone(&line.text)),
            Some(j) => {
                used[j] = true;
                pairs.push(FlierPair::labelled(&line.text, &lines[j].text));
            }
        }
    }
    pairs
}

fn fold(s: &str) -> String {
    s.trim()
        .to_lowercase()
        .split_whitespace()
        .collect::<Vec<_>>()
        .join(" ")
}

fn contains_word(haystack: &str, needle: &str) -> bool {
    let pattern = format!(r"(^|[^\p{{L}}]){}($|[^\p{{L}}])", regex::escape(needle));
    Regex::new(&pattern)
        .map(|re| re.is_match(haystack))
        .unwrap_or(false)
}

/// One registry's poster layout.
#[derive(Debug, Clone)]
pub struct FlierTemplate {
    pub name: String,
    pub registry: String,
    /// Target or Field slug to the labels that mean it.
    pub labels: BTreeMap<String, Vec<String>>,
    pub name_pattern: Option<Regex>,
    pub contact: Vec<String>,
}

impl FlierTemplate {
    /// The target a label means, when the template knows the label.
    pub fn target_of(&self, label: &str) -> Option<&str> {
        let wanted = fold(label);
        self.labels
            .iter()
            .find(|(_, synonyms)| synonyms.iter().any(|s| fold(s) == wanted))
            .map(|(target, _)| target.as_str())
    }

    /// True for the registry's own hotline, mail and site.
    pub fn is_contact(&self, text: &str) -> bool {
        let folded = fold(text);
        self.contact.iter().any(|c| folded.contains(&fold(c)))
    }
}

/// The shipped templates and the value synonyms.
#[derive(Debug, Clone, Default)]
pub struct FlierTemplateSet {
    pub templates: Vec<FlierTemplate>,
    /// Field slug to option to the words that mean it.
    pub values: BTreeMap<String, BTreeMap<String, Vec<String>>>,
}

impl FlierTemplateSet {
    pub fn from_json(source: &str) -> Result<FlierTemplateSet> {
        let json: serde_json::Value = serde_json::from_str(source)?;
        let strings = |v: Option<&serde_json::Value>| -> Vec<String> {
            v.and_then(|v| v.as_array())
                .map(|a| {
                    a.iter()
                        .filter_map(|s| s.as_str().map(String::from))
                        .collect()
                })
                .unwrap_or_default()
        };
        let mut templates = Vec::new();
        for t in json["templates"].as_array().into_iter().flatten() {
            let mut labels = BTreeMap::new();
            if let Some(map) = t["labels"].as_object() {
                for (k, v) in map {
                    labels.insert(k.clone(), strings(Some(v)));
                }
            }
            let name_pattern = t["namePattern"]
                .as_str()
                .and_then(|p| Regex::new(&format!("(?i){p}")).ok());
            templates.push(FlierTemplate {
                name: t["name"].as_str().unwrap_or_default().to_string(),
                registry: t["registry"].as_str().unwrap_or_default().to_string(),
                labels,
                name_pattern,
                contact: strings(t.get("contact")),
            });
        }
        let mut values = BTreeMap::new();
        if let Some(map) = json["values"].as_object() {
            for (slug, options) in map {
                let mut by_option = BTreeMap::new();
                if let Some(options) = options.as_object() {
                    for (option, words) in options {
                        by_option.insert(option.clone(), strings(Some(words)));
                    }
                }
                values.insert(slug.clone(), by_option);
            }
        }
        Ok(FlierTemplateSet { templates, values })
    }

    /// The templates that ship with the app.
    pub fn shipped() -> FlierTemplateSet {
        Self::from_json(TEMPLATES_JSON).unwrap_or_default()
    }

    /// A poster's word for a value as the Field stores it: "Kater" is
    /// `male`, the longest matching synonym decides.
    pub fn normalize(&self, slug: &str, raw: &str) -> String {
        let Some(options) = self.values.get(slug) else {
            return raw.to_string();
        };
        let folded = fold(raw);
        let mut best: Option<&str> = None;
        let mut best_len = 0;
        for (option, synonyms) in options {
            for synonym in synonyms {
                let s = fold(synonym);
                if s.len() <= best_len {
                    continue;
                }
                if folded == s || contains_word(&folded, &s) {
                    best = Some(option);
                    best_len = s.len();
                }
            }
        }
        best.map(String::from).unwrap_or_else(|| raw.to_string())
    }

    pub fn knows(&self, slug: &str, raw: &str) -> bool {
        self.values.contains_key(slug) && self.normalize(slug, raw) != raw
    }

    /// The template whose labels the pairs match best; none when fewer
    /// than two labels are known.
    pub fn matching(&self, pairs: &[FlierPair]) -> Option<&FlierTemplate> {
        let mut best = None;
        let mut best_score = 1;
        for template in &self.templates {
            let mut score = 0;
            for pair in pairs {
                let Some(label) = &pair.label else {
                    continue;
                };
                for part in label.split(',') {
                    if template.target_of(part.trim()).is_some() {
                        score += 1;
                    }
                }
            }
            if score > best_score {
                best_score = score;
                best = Some(template);
            }
        }
        best
    }
}

/// One line with where it goes.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FlierEntry {
    pub label: Option<String>,
    pub value: String,
    pub target: String,
}

impl FlierEntry {
    fn new(label: Option<&str>, value: &str, target: &str) -> FlierEntry {
        FlierEntry {
            label: label.map(String::from),
            value: value.to_string(),
            target: target.to_string(),
        }
    }
    /// "Label: value" or the value.
    pub fn line(&self) -> String {
        match &self.label {
            Some(l) => format!("{l}: {}", self.value),
            None => self.value.clone(),
        }
    }
}

/// A poster read: the template that matched and every line placed.
#[derive(Debug, Clone, Default)]
pub struct FlierReading {
    pub template: Option<String>,
    pub registry: Option<String>,
    pub entries: Vec<FlierEntry>,
}

impl FlierReading {
    pub fn of<'a>(&'a self, target: &'a str) -> impl Iterator<Item = &'a FlierEntry> {
        self.entries.iter().filter(move |e| e.target == target)
    }

    pub fn first(&self, target: &str) -> Option<&str> {
        self.entries
            .iter()
            .find(|e| e.target == target)
            .map(|e| e.value.as_str())
    }

    /// What no Field took, as remarks.
    pub fn remarks(&self) -> String {
        self.entries
            .iter()
            .filter(|e| e.target == target::REMARKS || e.target == target::CONTACT)
            .map(FlierEntry::line)
            .collect::<Vec<_>>()
            .join("\n")
    }
}

/// Reads pairs against the templates.
pub fn read_flier(pairs: &[FlierPair], templates: &FlierTemplateSet) -> FlierReading {
    let Some(template) = templates.matching(pairs) else {
        return FlierReading {
            template: None,
            registry: None,
            entries: pairs
                .iter()
                .map(|p| FlierEntry::new(p.label.as_deref(), &p.value, target::REMARKS))
                .collect(),
        };
    };
    let mut entries = Vec::new();
    for pair in pairs {
        let Some(label) = &pair.label else {
            entries.extend(lone_line(&pair.value, template, templates));
            continue;
        };
        let parts: Vec<&str> = label.split(',').map(str::trim).collect();
        let targets: Vec<Option<&str>> = parts.iter().map(|l| template.target_of(l)).collect();
        if targets.iter().all(Option::is_none) {
            let t = if template.is_contact(&pair.value) {
                target::CONTACT
            } else {
                target::REMARKS
            };
            entries.push(FlierEntry::new(Some(label), &pair.value, t));
            continue;
        }
        if parts.len() == 1 {
            let t = targets[0].expect("one known target");
            entries.push(FlierEntry::new(
                Some(label),
                &templates.normalize(t, &pair.value),
                t,
            ));
            continue;
        }
        entries.extend(composite(&parts, &targets, &pair.value, templates));
    }
    FlierReading {
        template: Some(template.name.clone()),
        registry: Some(template.registry.clone()),
        entries,
    }
}

fn composite(
    parts: &[&str],
    targets: &[Option<&str>],
    value: &str,
    templates: &FlierTemplateSet,
) -> Vec<FlierEntry> {
    let values: Vec<&str> = value.split(',').map(str::trim).collect();
    let mut entries = Vec::new();
    if values.len() == parts.len() {
        for (i, part) in parts.iter().enumerate() {
            match targets[i] {
                Some(t) => entries.push(FlierEntry::new(
                    Some(part),
                    &templates.normalize(t, values[i]),
                    t,
                )),
                None => entries.push(FlierEntry::new(Some(part), values[i], target::REMARKS)),
            }
        }
        return entries;
    }
    let known: Vec<&str> = targets.iter().flatten().copied().collect();
    for part in values {
        let target = known.iter().find(|t| templates.knows(t, part)).copied();
        match target {
            Some(t) => {
                let index = targets.iter().position(|x| *x == Some(t)).unwrap_or(0);
                entries.push(FlierEntry::new(
                    Some(parts[index]),
                    &templates.normalize(t, part),
                    t,
                ));
            }
            None => entries.push(FlierEntry::new(
                Some(&parts.join(", ")),
                part,
                target::REMARKS,
            )),
        }
    }
    entries
}

fn lone_line(
    text: &str,
    template: &FlierTemplate,
    templates: &FlierTemplateSet,
) -> Vec<FlierEntry> {
    if let Some(re) = &template.name_pattern
        && let Some(m) = re.captures(text)
        && m.len() >= 3
    {
        let prefix = m.get(1).map(|g| g.as_str()).unwrap_or_default();
        let name = m.get(2).map(|g| g.as_str().trim()).unwrap_or_default();
        let mut out = vec![FlierEntry::new(Some(prefix), name, target::NAME)];
        if templates.knows("gender", prefix) {
            out.push(FlierEntry::new(
                Some(prefix),
                &templates.normalize("gender", prefix),
                "gender",
            ));
        }
        if templates.knows("species", prefix) {
            out.push(FlierEntry::new(
                Some(prefix),
                &templates.normalize("species", prefix),
                "species",
            ));
        }
        return out;
    }
    let t = if template.is_contact(text) {
        target::CONTACT
    } else {
        target::REMARKS
    };
    vec![FlierEntry::new(None, text, t)]
}

/// A date as a poster spells it.
pub fn parse_flier_date(text: &str) -> Option<PartialDate> {
    PartialDate::find(text)
}

/// A fifteen-digit chip number, spaced or dashed, anywhere in `text`.
pub fn suggest_chip_id(text: &str) -> Option<String> {
    let re = Regex::new(r"(?:^|[^\d])((?:\d[ -]?){14}\d)(?:[^\d]|$)").ok()?;
    let m = re.captures(text)?;
    let digits: String = m
        .get(1)?
        .as_str()
        .chars()
        .filter(|c| c.is_ascii_digit())
        .collect();
    (digits.len() == 15).then_some(digits)
}

/// A phone number, the chip number left out first.
pub fn suggest_phone(text: &str) -> Option<String> {
    let without_chip = match suggest_chip_id(text) {
        None => text.to_string(),
        Some(_) => {
            let re = Regex::new(r"(?:\d[ -]?){14}\d").ok()?;
            re.replace(text, "").into_owned()
        }
    };
    let re = Regex::new(r"(\+?\d[\d /()-]{6,}\d)").ok()?;
    re.captures(&without_chip)
        .and_then(|m| m.get(1))
        .map(|g| g.as_str().trim().to_string())
}

pub fn suggest_email(text: &str) -> Option<String> {
    let re = Regex::new(r"(?i)[\w.+-]+@[\w-]+\.[\w.-]+").ok()?;
    re.find(text).map(|m| m.as_str().to_string())
}

/// A registry number read off a link on the poster.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FlierRegistryHit {
    pub service_name: String,
    pub template: String,
    pub value: String,
    pub take: bool,
}

/// The numbers the links carry, one per number, known services first.
pub fn registry_hits_in(urls: &[String], defs: &[FieldDef]) -> Vec<FlierRegistryHit> {
    let mut hits: Vec<FlierRegistryHit> = Vec::new();
    let mut services: Vec<(String, String)> = defs
        .iter()
        .filter_map(|d| {
            d.lookup_url
                .as_ref()
                .filter(|u| !u.is_empty())
                .map(|u| (d.name.clone(), u.clone()))
        })
        .collect();
    for preset in REGISTRY_PRESETS {
        services.push((preset.name.to_string(), preset.template.to_string()));
    }
    for url in urls {
        for (name, template) in &services {
            let Some(value) = id_from_lookup_url(template, url) else {
                continue;
            };
            if !hits
                .iter()
                .any(|h| h.service_name == *name && h.value == value)
            {
                hits.push(FlierRegistryHit {
                    service_name: name.clone(),
                    template: template.clone(),
                    value,
                    take: true,
                });
            }
            break;
        }
    }
    hits
}

/// The registry number of a reading as a hit, when a Field of that
/// registry exists or a preset knows it.
pub fn registry_hit_for(
    registry: &str,
    value: &str,
    defs: &[FieldDef],
) -> Option<FlierRegistryHit> {
    let value = value.trim();
    if value.is_empty() {
        return None;
    }
    let by_def = defs
        .iter()
        .filter(|d| d.field_type == FieldType::Id && d.name.eq_ignore_ascii_case(registry))
        .find_map(|d| d.lookup_url.clone().map(|u| (d.name.clone(), u)));
    let (name, template) = by_def.or_else(|| {
        REGISTRY_PRESETS
            .iter()
            .find(|p| p.name.eq_ignore_ascii_case(registry))
            .map(|p| (p.name.to_string(), p.template.to_string()))
    })?;
    Some(FlierRegistryHit {
        service_name: name,
        template,
        value: value.to_string(),
        take: true,
    })
}

/// What the capture page saves: the Cat and its owner's Clowder.
#[derive(Debug, Clone, Default, PartialEq)]
pub struct FlierDraft {
    pub name: String,
    pub species: String,
    pub missing_since: Option<chrono::NaiveDate>,
    pub chip_id: String,
    pub owner: String,
    pub phone: String,
    pub email: String,
    pub address: String,
    /// The owner's address on the map, when it was found.
    pub address_position: Option<(f64, f64)>,
    /// Where the poster hung: the Flier Position.
    pub flier_position: Option<(f64, f64)>,
    pub remarks: String,
    /// Field slug to value for the Cat.
    pub cat_fields: BTreeMap<String, String>,
    /// Field slug to value for the Clowder.
    pub clowder_fields: BTreeMap<String, String>,
    pub registry_hits: Vec<FlierRegistryHit>,
    /// The poster's picture, stored on the Cat.
    pub photo: Option<Vec<u8>>,
    /// The face cut out of it, the Profile Image.
    pub portrait: Option<Vec<u8>>,
}

/// What a capture made.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FlierOutcome {
    pub cat: String,
    pub clowder: String,
}

impl Catalog {
    /// Saves a flier as ADR 0007 says: an owner Clowder with Status
    /// `owner`, the Cat that lived there until the missing-since day and
    /// is a Stray since, the Flier Position, the numbers, the photos.
    pub fn capture_flier(
        &mut self,
        draft: &FlierDraft,
        cat_id: &str,
        clowder_id: &str,
        owner_of: &str,
    ) -> Result<FlierOutcome> {
        let since = draft.missing_since.map(|d| format!("{d}T12:00:00.000000Z"));
        let when = since.as_deref();
        let name = draft.name.trim();
        let owner = draft.owner.trim();
        let clowder_name = if owner.is_empty() {
            owner_of.to_string()
        } else {
            owner.to_string()
        };
        self.create_clowder(clowder_id, &clowder_name)?;
        self.append_at(
            clowder_id,
            &keys::user_field("status"),
            Some("owner"),
            when,
            false,
        )?;
        for (slug, value) in [
            ("address", draft.address.trim()),
            ("responsible", owner),
            ("phone", draft.phone.trim()),
            ("email", draft.email.trim()),
        ] {
            if !value.is_empty() {
                self.append_at(
                    clowder_id,
                    &keys::user_field(slug),
                    Some(value),
                    when,
                    false,
                )?;
            }
        }
        if let Some((lat, lon)) = draft.address_position {
            self.record_position(clowder_id, lat, lon, PositionKind::Sighting, when)?;
        }
        let remarks = draft.remarks.trim();
        if !remarks.is_empty() {
            self.append_at(
                clowder_id,
                &keys::user_field("remarks"),
                Some(remarks),
                when,
                false,
            )?;
        }
        for (slug, value) in &draft.clowder_fields {
            if !value.trim().is_empty() {
                self.append_at(
                    clowder_id,
                    &keys::user_field(slug),
                    Some(value.trim()),
                    when,
                    false,
                )?;
            }
        }
        let species = if draft.species.is_empty() {
            "cat"
        } else {
            &draft.species
        };
        self.create_cat(cat_id, name, None, species)?;
        // It lived with its owner until the flier's day; since then a Stray:
        // both rows carry that day, the leaving recorded last wins.
        self.append_at(cat_id, keys::CLOWDER, Some(clowder_id), when, false)?;
        self.append_at(cat_id, keys::CLOWDER, None, when, false)?;
        if let Some((lat, lon)) = draft.flier_position {
            self.record_position(cat_id, lat, lon, PositionKind::Flier, None)?;
        }
        let chip = draft.chip_id.trim();
        if !chip.is_empty() {
            self.append(cat_id, &keys::user_field("chipid"), Some(chip))?;
        }
        for (slug, value) in &draft.cat_fields {
            if !value.trim().is_empty() {
                self.append(cat_id, &keys::user_field(slug), Some(value.trim()))?;
                if slug == "breed" {
                    let _ = self.learn_breed(cat_id, Some(value.trim()));
                }
            }
        }
        for hit in draft.registry_hits.iter().filter(|h| h.take) {
            self.store_registry_hit(cat_id, hit)?;
        }
        if !remarks.is_empty() {
            self.append(cat_id, &keys::user_field("remarks"), Some(remarks))?;
        }
        if let Some(photo) = &draft.photo {
            let _ = self.add_photo(cat_id, photo);
        }
        if let Some(portrait) = &draft.portrait
            && let Ok(hash) = self.add_photo(cat_id, portrait)
        {
            self.set_profile_image(cat_id, &hash)?;
        }
        Ok(FlierOutcome {
            cat: cat_id.to_string(),
            clowder: clowder_id.to_string(),
        })
    }

    /// Writes a registry number into the ID Field of that service,
    /// defining the Field when the Catalog has none.
    pub fn store_registry_hit(&mut self, cat: &str, hit: &FlierRegistryHit) -> Result<()> {
        let existing = self.field_defs(None)?.into_iter().find(|d| {
            d.field_type == FieldType::Id && d.lookup_url.as_deref() == Some(hit.template.as_str())
        });
        let def = match existing {
            Some(d) => d,
            None => {
                let slug = crate::fields::slugify(&hit.service_name);
                self.define_id_field(&slug, &hit.service_name, &hit.template)?
            }
        };
        self.append(cat, &def.key(), Some(hit.value.trim()))
    }

    /// A new ID Field for a registry, scope Cat, looked up by its link.
    fn define_id_field(&mut self, slug: &str, name: &str, template: &str) -> Result<FieldDef> {
        let id = format!("fielddef:{slug}");
        if let Some(def) = self.field_def(slug)? {
            return Ok(def);
        }
        self.append(&id, keys::TYPE, Some(keys::KIND_FIELD_DEF))?;
        self.append(&id, keys::NAME, Some(name))?;
        self.append(&id, keys::FIELD_TYPE, Some("id"))?;
        self.append(&id, keys::FIELD_SCOPE, Some("cat"))?;
        self.append(&id, keys::FIELD_LOOKUP_URL, Some(template))?;
        self.field_def(slug)?
            .ok_or_else(|| crate::error::Error::Invalid("field not defined".into()))
    }
}

/// Text recognition over a picture.
pub trait Ocr: Send + Sync {
    /// The lines found, with their boxes in pixels; an error when the
    /// engine is not available.
    fn recognize(&self, image: &[u8]) -> std::result::Result<Vec<FlierLine>, String>;
}

/// Fetches the recognition models by URL.
pub trait ModelSource: Send + Sync {
    fn fetch(&self, url: &str) -> std::result::Result<Vec<u8>, String>;
}

/// The models over HTTPS.
pub struct HttpModels;

impl ModelSource for HttpModels {
    fn fetch(&self, url: &str) -> std::result::Result<Vec<u8>, String> {
        let agent = ureq::Agent::config_builder()
            .user_agent(crate::tiles::TILE_USER_AGENT)
            .build()
            .new_agent();
        agent
            .get(url)
            .call()
            .map_err(|e| e.to_string())?
            .body_mut()
            .with_config()
            .limit(200 << 20)
            .read_to_vec()
            .map_err(|e| e.to_string())
    }
}

pub const DETECTION_MODEL_URL: &str =
    "https://ocrs-models.s3-accelerate.amazonaws.com/text-detection.onnx";
pub const RECOGNITION_MODEL_URL: &str =
    "https://ocrs-models.s3-accelerate.amazonaws.com/text-recognition.onnx";

/// The `ocrs` engine, its two models fetched once into `cache_dir`.
pub struct OcrsEngine {
    cache_dir: std::path::PathBuf,
    source: Box<dyn ModelSource>,
    engine: std::sync::Mutex<Option<std::sync::Arc<ocrs::OcrEngine>>>,
}

impl OcrsEngine {
    pub fn new(cache_dir: &std::path::Path, source: Box<dyn ModelSource>) -> OcrsEngine {
        OcrsEngine {
            cache_dir: cache_dir.to_path_buf(),
            source,
            engine: std::sync::Mutex::new(None),
        }
    }

    fn model(&self, url: &str, name: &str) -> std::result::Result<rten::Model, String> {
        let file = self.cache_dir.join(name);
        if !file.is_file() {
            let bytes = self.source.fetch(url)?;
            std::fs::create_dir_all(&self.cache_dir).map_err(|e| e.to_string())?;
            std::fs::write(&file, bytes).map_err(|e| e.to_string())?;
        }
        rten::Model::load_file(&file).map_err(|e| e.to_string())
    }

    fn engine(&self) -> std::result::Result<std::sync::Arc<ocrs::OcrEngine>, String> {
        let mut slot = self.engine.lock().map_err(|e| e.to_string())?;
        if let Some(engine) = slot.as_ref() {
            return Ok(engine.clone());
        }
        let engine = ocrs::OcrEngine::new(ocrs::OcrEngineParams {
            detection_model: Some(self.model(DETECTION_MODEL_URL, "text-detection.onnx")?),
            recognition_model: Some(self.model(RECOGNITION_MODEL_URL, "text-recognition.onnx")?),
            ..Default::default()
        })
        .map_err(|e| e.to_string())?;
        let engine = std::sync::Arc::new(engine);
        *slot = Some(engine.clone());
        Ok(engine)
    }
}

impl Ocr for OcrsEngine {
    fn recognize(&self, image: &[u8]) -> std::result::Result<Vec<FlierLine>, String> {
        let engine = self.engine()?;
        let decoded = image::load_from_memory(image)
            .map_err(|e| e.to_string())?
            .to_rgb8();
        let source = ocrs::ImageSource::from_bytes(decoded.as_raw(), decoded.dimensions())
            .map_err(|e| e.to_string())?;
        let input = engine.prepare_input(source).map_err(|e| e.to_string())?;
        let words = engine.detect_words(&input).map_err(|e| e.to_string())?;
        let lines = engine.find_text_lines(&input, &words);
        let texts = engine
            .recognize_text(&input, &lines)
            .map_err(|e| e.to_string())?;
        let mut out = Vec::new();
        for line in texts.into_iter().flatten() {
            use ocrs::TextItem;
            let text = line.to_string();
            if text.trim().is_empty() {
                continue;
            }
            let rect = line.bounding_rect();
            out.push(FlierLine::new(
                text.trim(),
                rect.left() as f32,
                rect.top() as f32,
                rect.width() as f32,
                rect.height() as f32,
            ));
        }
        Ok(out)
    }
}

pub mod fixtures {
    //! Posters as the phone's tests know them.
    use super::FlierLine;

    /// Hugo's poster as the phone's text recognition saw it: the fixture
    /// the phone's tests use, kept here for the desk's.
    pub fn hugo_lines() -> Vec<FlierLine> {
        let labels = [
            "Suchdienstnummer",
            "Tierart, Geschlecht, Kastriert",
            "Rasse",
            "Farbe",
            "Geburtsdatum",
            "Kennzeichnung",
            "Verlustdatum",
            "Verlustort",
        ];
        let values = [
            "S2983764",
            "Katze, männich, kastriert",
            "Europäische Langhaarkatze",
            "braun",
            "26.05.2024",
            "Das Tier ist gechipt.",
            "05.06.2025",
            "04207 Leipzig, Colberger Weg. Deutschland",
        ];
        let mut lines = vec![FlierLine::new("GESUCHT!", 450.0, 250.0, 900.0, 150.0)];
        for (i, l) in labels.iter().enumerate() {
            lines.push(FlierLine::new(
                l,
                130.0,
                990.0 + 55.0 * i as f32,
                380.0,
                30.0,
            ));
        }
        lines.push(FlierLine::new("Kater HUGO", 560.0, 890.0, 300.0, 60.0));
        for (i, v) in values.iter().enumerate() {
            lines.push(FlierLine::new(
                v,
                540.0,
                993.0 + 55.0 * i as f32,
                600.0,
                30.0,
            ));
        }
        lines.push(FlierLine::new(
        "TASSO-Tipp: Katzen werden oft versehentlich eingesperrt. Werfen Sie deshalb bitte auch einen Blick in",
        130.0, 1330.0, 1200.0, 30.0,
    ));
        lines.push(FlierLine::new(
            "Ihre Garagen, Kellerräume und Gartenhäuser.",
            130.0,
            1360.0,
            500.0,
            30.0,
        ));
        lines.push(FlierLine::new(
            "24-Stunden-Notruf-Nummer:",
            300.0,
            1690.0,
            300.0,
            30.0,
        ));
        lines.push(FlierLine::new(
            "06190/ 93 73 00",
            300.0,
            1730.0,
            400.0,
            50.0,
        ));
        lines.push(FlierLine::new(
            "Fax: 0 61 90/93 74 00 info@tasso.net www.tasso.net",
            400.0,
            1920.0,
            700.0,
            30.0,
        ));
        lines
    }
}

#[cfg(test)]
mod tests {
    use super::fixtures::hugo_lines;
    use super::*;

    fn rudi_pairs() -> Vec<FlierPair> {
        vec![
            FlierPair::lone("GESUCHT!"),
            FlierPair::labelled("Suchdienstnummer", "S3098756"),
            FlierPair::labelled("Rasse", "Europäisch Kurzhaar"),
            FlierPair::labelled("Farbe", "rot"),
            FlierPair::labelled("Geburtsdatum", "5/2025"),
            FlierPair::labelled("Geschlecht, kastriert", "männlich, kastriert"),
            FlierPair::lone("Kater RUDI"),
            FlierPair::labelled("Kennzeichnung", "Das Tier trägt einen Transponder."),
            FlierPair::labelled("Verlustdatum", "10.08.2026"),
            FlierPair::labelled("Verlustort", "04229 Leipzig, Deutschland"),
            FlierPair::lone("Haben Sie dieses Tier gesehen?"),
            FlierPair::lone("+49 6190 937300"),
            FlierPair::lone("www.tasso.net/tier-gefunden"),
        ]
    }

    #[test]
    fn labels_pair_with_the_value_at_their_height_and_body_text_stays_lone() {
        let pairs = pair_lines(&hugo_lines());
        assert!(pairs.contains(&FlierPair::labelled("Suchdienstnummer", "S2983764")));
        assert!(pairs.contains(&FlierPair::labelled(
            "Verlustort",
            "04207 Leipzig, Colberger Weg. Deutschland"
        )));
        assert_eq!(pairs.iter().filter(|p| p.label.is_some()).count(), 8);
        assert!(pairs.contains(&FlierPair::lone("Kater HUGO")));
        assert!(pairs.contains(&FlierPair::lone("GESUCHT!")));
        assert!(!pairs.iter().any(|p| {
            p.label
                .as_deref()
                .is_some_and(|l| l.starts_with("TASSO-Tipp"))
        }));
        let below = pair_lines(&[
            FlierLine::new("Name", 100.0, 100.0, 300.0, 30.0),
            FlierLine::new("Minka", 100.0, 140.0, 300.0, 30.0),
        ]);
        assert_eq!(
            below,
            vec![FlierPair::lone("Name"), FlierPair::lone("Minka")]
        );
    }

    #[test]
    fn hugo_is_read_as_a_tasso_poster_every_row_on_its_field() {
        let templates = FlierTemplateSet::shipped();
        assert_eq!(templates.templates.len(), 1);
        assert_eq!(templates.templates[0].registry, "Tasso");
        let reading = read_flier(&pair_lines(&hugo_lines()), &templates);
        assert_eq!(reading.template.as_deref(), Some("TASSO"));
        assert_eq!(reading.first(target::REGISTRY_NUMBER), Some("S2983764"));
        assert_eq!(reading.first(target::NAME), Some("HUGO"));
        assert_eq!(reading.first("species"), Some("cat"));
        assert!(reading.of("gender").all(|e| e.value == "male"));
        assert_eq!(reading.first("neutered"), Some("yes"));
        assert_eq!(reading.first("breed"), Some("Europäische Langhaarkatze"));
        assert_eq!(reading.first("color"), Some("braun"));
        assert_eq!(reading.first("birthdate"), Some("26.05.2024"));
        assert_eq!(reading.first("chipid"), Some("Das Tier ist gechipt."));
        assert_eq!(reading.first(target::MISSING_SINCE), Some("05.06.2025"));
        assert_eq!(
            reading.first(target::LOST_PLACE),
            Some("04207 Leipzig, Colberger Weg. Deutschland")
        );
        let contact: Vec<&str> = reading
            .of(target::CONTACT)
            .map(|e| e.value.as_str())
            .collect();
        assert!(contact.contains(&"06190/ 93 73 00"));
        assert!(contact.contains(&"Fax: 0 61 90/93 74 00 info@tasso.net www.tasso.net"));
        let remarks = reading.remarks();
        assert!(
            remarks.contains("GESUCHT!")
                && remarks.contains("TASSO-Tipp")
                && remarks.contains("06190/ 93 73 00")
        );
        assert!(!remarks.contains("S2983764") && !remarks.contains("braun"));
        // An unknown layout: everything is remarks.
        let unknown = read_flier(
            &[
                FlierPair::lone("Lost cat"),
                FlierPair::labelled("Tel", "123"),
            ],
            &templates,
        );
        assert!(unknown.template.is_none());
        assert!(unknown.entries.iter().all(|e| e.target == target::REMARKS));
    }

    #[test]
    fn rudi_splits_a_composite_row_and_keeps_a_month() {
        let templates = FlierTemplateSet::shipped();
        let reading = read_flier(&rudi_pairs(), &templates);
        assert_eq!(reading.template.as_deref(), Some("TASSO"));
        assert_eq!(reading.first("gender"), Some("male"));
        assert_eq!(reading.first("neutered"), Some("yes"));
        assert_eq!(reading.first(target::NAME), Some("RUDI"));
        assert_eq!(reading.first("birthdate"), Some("5/2025"));
        assert_eq!(parse_flier_date("5/2025"), PartialDate::parse("2025-05"));
        assert_eq!(
            parse_flier_date("Verlust am 10.08.2026 in Leipzig"),
            PartialDate::parse("2026-08-10")
        );
        assert_eq!(parse_flier_date("seit 2024"), PartialDate::parse("2024"));
        assert_eq!(parse_flier_date("no date"), None);
        let contact: Vec<&str> = reading
            .of(target::CONTACT)
            .map(|e| e.value.as_str())
            .collect();
        assert!(
            contact.contains(&"+49 6190 937300")
                && contact.contains(&"www.tasso.net/tier-gefunden")
        );
        // A composite label whose value does not split evenly.
        let odd = read_flier(
            &[
                FlierPair::labelled("Suchdienstnummer", "S1"),
                FlierPair::labelled("Rasse", "x"),
                FlierPair::labelled("Geschlecht, kastriert", "kastriert"),
            ],
            &templates,
        );
        assert_eq!(odd.first("neutered"), Some("yes"));
        assert_eq!(templates.normalize("gender", "Kater"), "male");
        assert_eq!(
            templates.normalize("gender", "unknown word"),
            "unknown word"
        );
        assert_eq!(templates.normalize("nothing", "x"), "x");
    }

    #[test]
    fn chip_phone_mail_and_registry_links_are_suggested() {
        let text = "MISSING: Minka\nChip 276 0981 0234 567-8\nCall 089 1234567 — reward!";
        assert_eq!(suggest_chip_id(text).as_deref(), Some("276098102345678"));
        assert_eq!(suggest_phone(text).as_deref(), Some("089 1234567"));
        assert_eq!(suggest_chip_id("no ids here"), None);
        assert_eq!(suggest_phone("Chip 276 0981 0234 567-8"), None);
        assert_eq!(suggest_email(text), None);
        assert_eq!(
            suggest_email("mail me: Owner@Example.org now").as_deref(),
            Some("Owner@Example.org")
        );
        let hits = registry_hits_in(
            &[
                "https://www.tasso.net/Tierregister/Suchmeldungen?lang=de-DE&snr=S3101849&lp=0"
                    .into(),
                "https://example.org".into(),
            ],
            &[],
        );
        assert_eq!(hits.len(), 1);
        assert_eq!(hits[0].service_name, "Tasso");
        assert_eq!(hits[0].value, "S3101849");
        assert!(hits[0].take);
        assert!(registry_hit_for("Tasso", "S1", &[]).is_some());
        assert!(registry_hit_for("Nobody", "S1", &[]).is_none());
        assert!(registry_hit_for("Tasso", " ", &[]).is_none());
    }

    #[test]
    fn a_flier_becomes_an_owner_clowder_and_a_missing_stray() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        let img = image::DynamicImage::new_rgb8(20, 20);
        let mut jpeg = Vec::new();
        img.write_to(
            &mut std::io::Cursor::new(&mut jpeg),
            image::ImageFormat::Jpeg,
        )
        .unwrap();
        let draft = FlierDraft {
            name: "Minka".into(),
            species: "cat".into(),
            missing_since: Some(chrono::NaiveDate::from_ymd_opt(2026, 3, 1).unwrap()),
            chip_id: "276098102345678".into(),
            owner: String::new(),
            phone: "089 1234567".into(),
            email: "o@example.org".into(),
            address: "Somewhere 1".into(),
            address_position: Some((48.2, 11.6)),
            flier_position: Some((48.1, 11.5)),
            remarks: "reward!".into(),
            cat_fields: [("breed".to_string(), "Maine Coon".to_string())]
                .into_iter()
                .collect(),
            clowder_fields: BTreeMap::new(),
            registry_hits: vec![FlierRegistryHit {
                service_name: "Tasso".into(),
                template: "https://www.tasso.net/Tierregister/Suchmeldungen?snr={value}".into(),
                value: "S3101849".into(),
                take: true,
            }],
            photo: Some(jpeg.clone()),
            portrait: Some(jpeg),
        };
        let made = store
            .capture_flier(&draft, "cat:m", "clowder:o", "Owner of Minka")
            .unwrap();
        assert_eq!(
            store.current("cat:m", keys::NAME).unwrap().as_deref(),
            Some("Minka")
        );
        assert_eq!(
            store
                .strays()
                .unwrap()
                .iter()
                .map(|c| c.id.as_str())
                .collect::<Vec<_>>(),
            vec!["cat:m"]
        );
        assert_eq!(
            store.current("clowder:o", keys::NAME).unwrap().as_deref(),
            Some("Owner of Minka")
        );
        assert_eq!(
            store.current("clowder:o", "f:status").unwrap().as_deref(),
            Some("owner")
        );
        assert_eq!(
            store.current("clowder:o", "f:phone").unwrap().as_deref(),
            Some("089 1234567")
        );
        assert_eq!(
            store.former_clowder("cat:m").unwrap().as_deref(),
            Some("clowder:o")
        );
        assert_eq!(store.flier_positions("cat:m").unwrap(), vec![(48.1, 11.5)]);
        assert_eq!(store.sighting_position_of("cat:m").unwrap(), None);
        assert_eq!(store.position_of("clowder:o").unwrap(), Some((48.2, 11.6)));
        assert_eq!(
            store.current("cat:m", "f:chipid").unwrap().as_deref(),
            Some("276098102345678")
        );
        assert_eq!(
            store.current("cat:m", "f:breed").unwrap().as_deref(),
            Some("Maine Coon")
        );
        assert_eq!(
            store.current("cat:m", "f:remarks").unwrap().as_deref(),
            Some("reward!")
        );
        assert_eq!(
            store.images("cat:m").unwrap().len(),
            1,
            "the same picture twice is one photo"
        );
        assert!(store.profile_image("cat:m").unwrap().is_some());
        let tasso = store
            .field_def("tasso")
            .unwrap()
            .expect("a Tasso ID field was defined");
        assert_eq!(tasso.field_type, FieldType::Id);
        assert_eq!(
            store.current("cat:m", &tasso.key()).unwrap().as_deref(),
            Some("S3101849")
        );
        assert_eq!(made.clowder, "clowder:o");
        // A second capture reuses the Field.
        let again = FlierDraft {
            name: "Tom".into(),
            ..draft.clone()
        };
        store
            .capture_flier(&again, "cat:t", "clowder:p", "Owner of Tom")
            .unwrap();
        assert_eq!(
            store
                .field_defs(None)
                .unwrap()
                .iter()
                .filter(|d| d.slug == "tasso")
                .count(),
            1
        );
        assert_eq!(
            store.current("cat:t", "f:tasso").unwrap().as_deref(),
            Some("S3101849")
        );
    }

    struct Offline;

    impl ModelSource for Offline {
        fn fetch(&self, _url: &str) -> std::result::Result<Vec<u8>, String> {
            Err("offline".into())
        }
    }

    #[test]
    fn without_the_models_recognition_says_so() {
        let dir = tempfile::tempdir().unwrap();
        let engine = OcrsEngine::new(&dir.path().join("ocr"), Box::new(Offline));
        assert_eq!(engine.recognize(b"junk"), Err("offline".into()));
    }
}
