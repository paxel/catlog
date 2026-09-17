//! Fields: typed, user-defined attributes of Cats and Clowders. A
//! definition is itself entries under `fielddef:<slug>`; values live on
//! the entities under `f:<slug>`. The starters a fresh Catalog seeds
//! are the phones' starters, id for id.

use std::collections::BTreeMap;

use serde::{Deserialize, Serialize};

use crate::Result;
use crate::catalog::Catalog;
use crate::error::Error;
use crate::keys;
use crate::units::Dimension;

/// The type of a user-defined Field. `tags` is the Looks field.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum FieldType {
    #[serde(rename = "text")]
    Text,
    #[serde(rename = "yesNo")]
    YesNo,
    #[serde(rename = "date")]
    Date,
    #[serde(rename = "number")]
    Number,
    #[serde(rename = "choice")]
    Choice,
    #[serde(rename = "location")]
    Location,
    #[serde(rename = "cat")]
    Cat,
    #[serde(rename = "id")]
    Id,
    #[serde(rename = "unitValue")]
    UnitValue,
    #[serde(rename = "tags")]
    Tags,
}

impl FieldType {
    pub const ALL: [FieldType; 10] = [
        FieldType::Text,
        FieldType::YesNo,
        FieldType::Date,
        FieldType::Number,
        FieldType::Choice,
        FieldType::Location,
        FieldType::Cat,
        FieldType::Id,
        FieldType::UnitValue,
        FieldType::Tags,
    ];

    /// The stored name, as the phones write it.
    pub fn name(self) -> &'static str {
        match self {
            FieldType::Text => "text",
            FieldType::YesNo => "yesNo",
            FieldType::Date => "date",
            FieldType::Number => "number",
            FieldType::Choice => "choice",
            FieldType::Location => "location",
            FieldType::Cat => "cat",
            FieldType::Id => "id",
            FieldType::UnitValue => "unitValue",
            FieldType::Tags => "tags",
        }
    }

    pub fn parse(name: &str) -> Option<FieldType> {
        FieldType::ALL.into_iter().find(|t| t.name() == name)
    }
}

/// Where a Field is offered in the UI. Values are still stored uniformly.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum FieldScope {
    Cat,
    Clowder,
    Both,
}

impl FieldScope {
    pub fn name(self) -> &'static str {
        match self {
            FieldScope::Cat => "cat",
            FieldScope::Clowder => "clowder",
            FieldScope::Both => "both",
        }
    }

    pub fn parse(name: &str) -> Option<FieldScope> {
        [FieldScope::Cat, FieldScope::Clowder, FieldScope::Both]
            .into_iter()
            .find(|s| s.name() == name)
    }
}

/// How an ID Field renders on the Card.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum IdDisplay {
    Plain,
    Qr,
    Barcode,
}

impl IdDisplay {
    pub fn name(self) -> &'static str {
        match self {
            IdDisplay::Plain => "plain",
            IdDisplay::Qr => "qr",
            IdDisplay::Barcode => "barcode",
        }
    }

    pub fn parse(name: &str) -> Option<IdDisplay> {
        [IdDisplay::Plain, IdDisplay::Qr, IdDisplay::Barcode]
            .into_iter()
            .find(|d| d.name() == name)
    }
}

/// A global, typed Field definition, projected from entries.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FieldDef {
    /// Entity id: `fielddef:<slug>`.
    pub id: String,
    pub slug: String,
    pub name: String,
    pub field_type: FieldType,
    pub scope: FieldScope,
    /// For choice Fields.
    pub options: Vec<String>,
    /// For ID Fields.
    pub id_display: IdDisplay,
    /// Where an ID can be looked up, as a URL template with `{value}`.
    pub lookup_url: Option<String>,
    /// What a Unit Value measures.
    pub dimension: Option<Dimension>,
    /// Options keepers added for one species.
    pub extra_options: BTreeMap<String, Vec<String>>,
}

impl FieldDef {
    /// The key under which values of this Field live on Cats/Clowders.
    pub fn key(&self) -> String {
        keys::user_field(&self.slug)
    }

    /// The dimension a Unit Value is read in: weight when none was stored.
    pub fn unit_dimension(&self) -> Dimension {
        self.dimension.unwrap_or(Dimension::Weight)
    }
}

/// Canonical form for matching ID values: exact after trimming,
/// case-folding and dropping spaces and hyphens. Never fuzzy.
pub fn normalize_id(value: &str) -> String {
    value
        .trim()
        .to_lowercase()
        .chars()
        .filter(|c| !c.is_whitespace() && *c != '-')
        .collect()
}

/// Lowercase, alphanumeric-and-dash form of a Field name.
pub fn slugify(name: &str) -> String {
    let mut out = String::new();
    let mut dash = false;
    for c in name.trim().to_lowercase().chars() {
        if c.is_ascii_alphanumeric() {
            out.push(c);
            dash = false;
        } else if !dash {
            out.push('-');
            dash = true;
        }
    }
    out.trim_matches('-').to_string()
}

/// Canonical Clowder status values the app recognizes.
pub const CLOWDER_STATUS_KEYS: [&str; 6] = [
    "foster",
    "forever-home",
    "clinic",
    "shelter",
    "barn",
    "owner",
];

/// Species a Catalog offers when an animal is added.
pub const SPECIES_PRESETS: [&str; 9] = [
    "cat",
    "dog",
    "rabbit",
    "guinea pig",
    "hamster",
    "bird",
    "horse",
    "tortoise",
    "ferret",
];

/// The cat breeds a Catalog starts with.
pub const CAT_BREEDS: [&str; 40] = [
    "European Shorthair",
    "Maine Coon",
    "British Shorthair",
    "Norwegian Forest Cat",
    "Ragdoll",
    "Siamese",
    "Persian",
    "Bengal",
    "Sphynx",
    "Abyssinian",
    "American Shorthair",
    "Balinese",
    "Birman",
    "Bombay",
    "Burmese",
    "Burmilla",
    "British Longhair",
    "Chartreux",
    "Cornish Rex",
    "Devon Rex",
    "Egyptian Mau",
    "Exotic Shorthair",
    "Himalayan",
    "Korat",
    "Manx",
    "Munchkin",
    "Ocicat",
    "Oriental Shorthair",
    "Ragamuffin",
    "Russian Blue",
    "Savannah",
    "Scottish Fold",
    "Selkirk Rex",
    "Siberian",
    "Snowshoe",
    "Somali",
    "Tonkinese",
    "Turkish Angora",
    "Turkish Van",
    "mixed",
];

/// Built-in breed lists per species other than cat.
pub fn breeds_by_species(species: &str) -> &'static [&'static str] {
    match species {
        "dog" => &[
            "Labrador Retriever",
            "German Shepherd",
            "Golden Retriever",
            "French Bulldog",
            "Beagle",
            "Poodle",
            "Dachshund",
            "Border Collie",
            "Jack Russell Terrier",
            "Chihuahua",
            "mixed",
        ],
        "rabbit" => &[
            "Dwarf Lop",
            "Netherland Dwarf",
            "Lionhead",
            "Flemish Giant",
            "Rex",
            "mixed",
        ],
        "guinea pig" => &["Abyssinian", "American", "Peruvian", "Teddy", "mixed"],
        "horse" => &[
            "Haflinger",
            "Icelandic",
            "Arabian",
            "Thoroughbred",
            "Warmblood",
            "Shetland Pony",
            "mixed",
        ],
        _ => &[],
    }
}

/// The breed options for an animal of `species`: a cat gets the field's
/// own list; every other species its built-in list plus what keepers
/// added for it; an animal without a species gets free text only.
pub fn breed_options(breed: &FieldDef, species: Option<&str>) -> Vec<String> {
    let Some(species) = species.filter(|s| !s.is_empty()) else {
        return Vec::new();
    };
    if species == "cat" {
        return breed.options.clone();
    }
    let builtin = breeds_by_species(species);
    let mut out: Vec<String> = builtin.iter().map(|s| s.to_string()).collect();
    if let Some(extra) = breed.extra_options.get(species) {
        for o in extra {
            if !builtin.contains(&o.as_str()) {
                out.push(o.clone());
            }
        }
    }
    out
}

/// A starter Field seeded on first launch.
struct Starter {
    slug: &'static str,
    name: &'static str,
    field_type: FieldType,
    scope: FieldScope,
    options: &'static [&'static str],
}

const STARTERS: [Starter; 20] = [
    Starter {
        slug: "gender",
        name: "Gender",
        field_type: FieldType::Choice,
        scope: FieldScope::Cat,
        options: &["female", "male", "unknown"],
    },
    Starter {
        slug: "color",
        name: "Color",
        field_type: FieldType::Text,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "breed",
        name: "Breed",
        field_type: FieldType::Choice,
        scope: FieldScope::Cat,
        options: &CAT_BREEDS,
    },
    Starter {
        slug: "chipid",
        name: "Chip ID",
        field_type: FieldType::Id,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "neutered",
        name: "Neutered",
        field_type: FieldType::YesNo,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "pregnant",
        name: "Pregnant",
        field_type: FieldType::YesNo,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "birthdate",
        name: "Birth date",
        field_type: FieldType::Date,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "deceased",
        name: "Deceased",
        field_type: FieldType::Date,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "species",
        name: "Species",
        field_type: FieldType::Choice,
        scope: FieldScope::Cat,
        options: &SPECIES_PRESETS,
    },
    Starter {
        slug: "weight",
        name: "Weight",
        field_type: FieldType::UnitValue,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "looks",
        name: "Looks",
        field_type: FieldType::Tags,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "mother",
        name: "Mother",
        field_type: FieldType::Cat,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "father",
        name: "Father",
        field_type: FieldType::Cat,
        scope: FieldScope::Cat,
        options: &[],
    },
    Starter {
        slug: "status",
        name: "Status",
        field_type: FieldType::Choice,
        scope: FieldScope::Clowder,
        options: &CLOWDER_STATUS_KEYS,
    },
    Starter {
        slug: "address",
        name: "Address",
        field_type: FieldType::Text,
        scope: FieldScope::Clowder,
        options: &[],
    },
    Starter {
        slug: "responsible",
        name: "Responsible person",
        field_type: FieldType::Text,
        scope: FieldScope::Clowder,
        options: &[],
    },
    Starter {
        slug: "email",
        name: "Email",
        field_type: FieldType::Text,
        scope: FieldScope::Clowder,
        options: &[],
    },
    Starter {
        slug: "phone",
        name: "Phone",
        field_type: FieldType::Text,
        scope: FieldScope::Clowder,
        options: &[],
    },
    Starter {
        slug: "position",
        name: "Position",
        field_type: FieldType::Location,
        scope: FieldScope::Both,
        options: &[],
    },
    Starter {
        slug: "remarks",
        name: "Remarks",
        field_type: FieldType::Text,
        scope: FieldScope::Both,
        options: &[],
    },
];

/// The starter breeds this device has offered so far (local).
const BREEDS_OFFERED_KEY: &str = "breedsOffered";

fn split_options(value: Option<&str>) -> Vec<String> {
    value
        .unwrap_or_default()
        .split('\n')
        .filter(|o| !o.is_empty())
        .map(String::from)
        .collect()
}

/// A lookup link must be a web address.
pub fn is_web_lookup(template: &str) -> bool {
    template.starts_with("http://") || template.starts_with("https://")
}

impl Catalog {
    /// All global Field definitions, optionally only those offered for
    /// `scope`.
    pub fn field_defs(&self, scope: Option<FieldScope>) -> Result<Vec<FieldDef>> {
        let mut defs = Vec::new();
        for id in self.field_def_ids()? {
            let fields = self.current_fields(&id)?;
            let get = |k: &str| fields.get(k).cloned().flatten();
            let def = FieldDef {
                slug: id["fielddef:".len()..].to_string(),
                name: get(keys::NAME).unwrap_or_else(|| "(unnamed)".to_string()),
                field_type: get(keys::FIELD_TYPE)
                    .and_then(|t| FieldType::parse(&t))
                    .unwrap_or(FieldType::Text),
                scope: get(keys::FIELD_SCOPE)
                    .and_then(|s| FieldScope::parse(&s))
                    .unwrap_or(FieldScope::Both),
                options: split_options(get(keys::FIELD_OPTIONS).as_deref()),
                id_display: get(keys::FIELD_ID_DISPLAY)
                    .and_then(|d| IdDisplay::parse(&d))
                    .unwrap_or(IdDisplay::Plain),
                lookup_url: get(keys::FIELD_LOOKUP_URL),
                dimension: get(keys::FIELD_DIMENSION).and_then(|d| Dimension::parse(&d)),
                extra_options: fields
                    .iter()
                    .filter_map(|(k, v)| {
                        let species = k.strip_prefix(keys::FIELD_OPTIONS_PREFIX)?;
                        let value = v.as_deref()?;
                        Some((species.to_string(), split_options(Some(value))))
                    })
                    .collect(),
                id,
            };
            if scope.is_none() || scope == Some(def.scope) || def.scope == FieldScope::Both {
                defs.push(def);
            }
        }
        Ok(defs)
    }

    /// One definition by slug.
    pub fn field_def(&self, slug: &str) -> Result<Option<FieldDef>> {
        Ok(self.field_defs(None)?.into_iter().find(|d| d.slug == slug))
    }

    /// Creates a new global Field definition and returns its entity id.
    /// Fails when a Field with the same slug exists.
    #[allow(clippy::too_many_arguments)]
    pub fn define_field(
        &mut self,
        name: &str,
        field_type: FieldType,
        scope: FieldScope,
        options: &[&str],
        id_display: IdDisplay,
        lookup_url: Option<&str>,
        dimension: Option<Dimension>,
    ) -> Result<String> {
        let slug = slugify(name);
        if slug.is_empty() {
            return Err(Error::Invalid("Field name must not be empty".into()));
        }
        let id = format!("fielddef:{slug}");
        if self.current(&id, keys::TYPE)?.is_some() {
            return Err(Error::Invalid(format!(
                "A field named \"{name}\" already exists"
            )));
        }
        self.append(&id, keys::TYPE, Some(keys::KIND_FIELD_DEF))?;
        self.append(&id, keys::NAME, Some(name))?;
        self.append(&id, keys::FIELD_TYPE, Some(field_type.name()))?;
        self.append(&id, keys::FIELD_SCOPE, Some(scope.name()))?;
        if !options.is_empty() {
            self.append(&id, keys::FIELD_OPTIONS, Some(&options.join("\n")))?;
        }
        if field_type == FieldType::Id && id_display != IdDisplay::Plain {
            self.append(&id, keys::FIELD_ID_DISPLAY, Some(id_display.name()))?;
        }
        if field_type == FieldType::Id
            && let Some(url) = lookup_url.filter(|u| !u.is_empty())
        {
            self.append(&id, keys::FIELD_LOOKUP_URL, Some(url))?;
        }
        if field_type == FieldType::UnitValue {
            let d = dimension.unwrap_or(Dimension::Weight);
            self.append(&id, keys::FIELD_DIMENSION, Some(d.name()))?;
        }
        Ok(id)
    }

    fn check_field_def(&self, id: &str) -> Result<()> {
        if self.current(id, keys::TYPE)?.as_deref() != Some(keys::KIND_FIELD_DEF) {
            return Err(Error::Invalid(format!("Not a field definition: {id}")));
        }
        Ok(())
    }

    /// Points an ID Field at a service: a URL template with `{value}`,
    /// or none to detach it again.
    pub fn set_field_lookup_url(&mut self, id: &str, template: Option<&str>) -> Result<()> {
        self.check_field_def(id)?;
        let template = template.filter(|t| !t.is_empty());
        if let Some(t) = template
            && !is_web_lookup(t)
        {
            return Err(Error::Invalid(
                "A lookup link must start with http:// or https://".into(),
            ));
        }
        self.append(id, keys::FIELD_LOOKUP_URL, template)
    }

    /// Replaces a choice Field's option list.
    pub fn set_field_options(&mut self, id: &str, options: &[&str]) -> Result<()> {
        self.check_field_def(id)?;
        self.append(id, keys::FIELD_OPTIONS, Some(&options.join("\n")))
    }

    /// Renames a Field definition; the slug never changes.
    pub fn rename_field(&mut self, id: &str, name: &str) -> Result<()> {
        self.check_field_def(id)?;
        self.append(id, keys::NAME, Some(name))
    }

    /// Adds `option` to a choice Field's list for one species.
    pub fn add_field_option(&mut self, id: &str, species: &str, option: &str) -> Result<()> {
        let key = format!("{}{species}", keys::FIELD_OPTIONS_PREFIX);
        let mut existing = split_options(self.current(id, &key)?.as_deref());
        if existing.iter().any(|o| o == option) {
            return Ok(());
        }
        existing.push(option.to_string());
        self.append(id, &key, Some(&existing.join("\n")))
    }

    /// A breed typed for an animal that is not a cat is offered again
    /// for that species.
    pub fn learn_breed(&mut self, cat: &str, value: Option<&str>) -> Result<()> {
        let Some(value) = value.filter(|v| !v.is_empty()) else {
            return Ok(());
        };
        let species = self.current(cat, &keys::user_field("species"))?;
        let Some(species) = species.filter(|s| !s.is_empty() && s != "cat") else {
            return Ok(());
        };
        let Some(breed) = self.field_def("breed")? else {
            return Ok(());
        };
        if breed_options(&breed, Some(&species))
            .iter()
            .any(|o| o == value)
        {
            return Ok(());
        }
        self.add_field_option(&breed.id, &species, value)
    }

    /// Pet Mode: the Catalog holds pets rather than cats.
    pub fn is_pet_mode(&self) -> Result<bool> {
        Ok(self.current("catalog:mode", "mode")?.as_deref() == Some("pets"))
    }

    pub fn set_pet_mode(&mut self, pets: bool) -> Result<()> {
        self.append(
            "catalog:mode",
            "mode",
            Some(if pets { "pets" } else { "cats" }),
        )
    }

    /// Seeds the starter Fields a fresh Catalog carries, and the
    /// additions later versions made to the Species and Breed lists.
    pub(crate) fn seed_starter_fields(&mut self) -> Result<()> {
        for f in &STARTERS {
            let id = format!("fielddef:{}", f.slug);
            if self.current(&id, keys::TYPE)?.is_some() {
                if f.slug == "species"
                    && self.current(&id, keys::FIELD_TYPE)?.as_deref() == Some("text")
                {
                    self.append_seed(&id, keys::FIELD_TYPE, FieldType::Choice.name())?;
                    self.append_seed(&id, keys::FIELD_OPTIONS, &f.options.join("\n"))?;
                }
                if f.slug == "breed" {
                    let offered = split_options(self.local_setting(BREEDS_OFFERED_KEY).as_deref());
                    let mut have =
                        split_options(self.current(&id, keys::FIELD_OPTIONS)?.as_deref());
                    let missing: Vec<&str> = f
                        .options
                        .iter()
                        .copied()
                        .filter(|o| !have.iter().any(|h| h == o) && !offered.iter().any(|h| h == o))
                        .collect();
                    if !missing.is_empty() {
                        let mixed = have
                            .iter()
                            .position(|o| o == "mixed")
                            .map(|i| have.remove(i))
                            .is_some();
                        let mut merged = have;
                        merged.extend(
                            missing
                                .iter()
                                .filter(|o| **o != "mixed")
                                .map(|o| o.to_string()),
                        );
                        if mixed || missing.contains(&"mixed") {
                            merged.push("mixed".to_string());
                        }
                        self.append_seed(&id, keys::FIELD_OPTIONS, &merged.join("\n"))?;
                    }
                    self.set_local_setting(BREEDS_OFFERED_KEY, &f.options.join("\n"))?;
                }
                continue;
            }
            self.append_seed(&id, keys::TYPE, keys::KIND_FIELD_DEF)?;
            self.append_seed(&id, keys::NAME, f.name)?;
            self.append_seed(&id, keys::FIELD_TYPE, f.field_type.name())?;
            self.append_seed(&id, keys::FIELD_SCOPE, f.scope.name())?;
            if !f.options.is_empty() {
                self.append_seed(&id, keys::FIELD_OPTIONS, &f.options.join("\n"))?;
            }
            if f.slug == "breed" {
                self.set_local_setting(BREEDS_OFFERED_KEY, &f.options.join("\n"))?;
            }
            if f.field_type == FieldType::Id {
                self.append_seed(&id, keys::FIELD_ID_DISPLAY, IdDisplay::Barcode.name())?;
            }
            if f.field_type == FieldType::UnitValue {
                self.append_seed(&id, keys::FIELD_DIMENSION, Dimension::Weight.name())?;
            }
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn catalog() -> (tempfile::TempDir, Catalog) {
        let dir = tempfile::tempdir().unwrap();
        let c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        (dir, c)
    }

    #[test]
    fn names_slugs_and_ids_normalize_like_the_phones() {
        assert_eq!(slugify("  Chip ID! "), "chip-id");
        assert_eq!(slugify("Élan"), "lan");
        assert_eq!(slugify("---"), "");
        assert_eq!(normalize_id(" DE-123 456 "), "de123456");
        for t in FieldType::ALL {
            assert_eq!(FieldType::parse(t.name()), Some(t));
            assert_eq!(serde_json::to_value(t).unwrap(), t.name());
        }
        assert_eq!(FieldType::parse("blob"), None);
        assert_eq!(FieldScope::parse("both"), Some(FieldScope::Both));
        assert_eq!(FieldScope::parse("x"), None);
        assert_eq!(IdDisplay::parse("qr"), Some(IdDisplay::Qr));
        assert_eq!(IdDisplay::parse("x"), None);
        assert!(is_web_lookup("https://x") && !is_web_lookup("ftp://x"));
    }

    #[test]
    fn a_fresh_catalog_carries_the_starters() {
        let (_dir, c) = catalog();
        let defs = c.field_defs(None).unwrap();
        assert_eq!(defs.len(), 20);
        let chip = c.field_def("chipid").unwrap().unwrap();
        assert_eq!(chip.field_type, FieldType::Id);
        assert_eq!(chip.id_display, IdDisplay::Barcode);
        assert_eq!(chip.key(), "f:chipid");
        let weight = c.field_def("weight").unwrap().unwrap();
        assert_eq!(weight.dimension, Some(Dimension::Weight));
        assert_eq!(weight.unit_dimension(), Dimension::Weight);
        let breed = c.field_def("breed").unwrap().unwrap();
        assert_eq!(breed.options.len(), 40);
        assert_eq!(breed.options.last().unwrap(), "mixed");
        assert_eq!(c.field_defs(Some(FieldScope::Clowder)).unwrap().len(), 7);
        assert_eq!(c.field_defs(Some(FieldScope::Cat)).unwrap().len(), 15);
        assert!(
            c.all_entries()
                .unwrap()
                .iter()
                .all(|e| e.author == crate::SEED_AUTHOR)
        );
        assert!(!c.is_pet_mode().unwrap());
    }

    #[test]
    fn reopening_seeds_nothing_twice_but_appends_new_breeds() {
        let dir = tempfile::tempdir().unwrap();
        let count = {
            let mut c = Catalog::open(dir.path()).unwrap();
            c.set_author("Ada").unwrap();
            let breed = c.field_def("breed").unwrap().unwrap();
            // The keeper trims the list and adds one of their own; a
            // starter removed on purpose stays removed.
            c.set_field_options(&breed.id, &["Maine Coon", "Ragdoll", "House cat"])
                .unwrap();
            c.all_entries().unwrap().len()
        };
        let c = Catalog::open(dir.path()).unwrap();
        assert_eq!(c.all_entries().unwrap().len(), count);
        assert_eq!(
            c.field_def("breed").unwrap().unwrap().options,
            vec!["Maine Coon", "Ragdoll", "House cat"]
        );
        // A catalog from before the list grew gets the newcomers, "mixed" last.
        c.set_local_setting(BREEDS_OFFERED_KEY, "Maine Coon\nRagdoll")
            .unwrap();
        let mut c = c;
        c.seed_starter_fields().unwrap();
        let options = c.field_def("breed").unwrap().unwrap().options;
        assert_eq!(options.len(), 3 + 38);
        assert_eq!(options.last().unwrap(), "mixed");
        assert_eq!(options[2], "House cat");
    }

    #[test]
    fn species_grows_from_text_to_a_choice() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        c.append("fielddef:species", keys::FIELD_TYPE, Some("text"))
            .unwrap();
        c.seed_starter_fields().unwrap();
        let species = c.field_def("species").unwrap().unwrap();
        assert_eq!(species.field_type, FieldType::Choice);
        assert_eq!(species.options.len(), 9);
    }

    #[test]
    fn definitions_are_made_edited_and_read_back() {
        let (_dir, mut c) = catalog();
        let id = c
            .define_field(
                "Vet Registry",
                FieldType::Id,
                FieldScope::Cat,
                &[],
                IdDisplay::Qr,
                Some("https://vet.example/{value}"),
                None,
            )
            .unwrap();
        assert_eq!(id, "fielddef:vet-registry");
        let def = c.field_def("vet-registry").unwrap().unwrap();
        assert_eq!(
            (def.id_display, def.lookup_url.as_deref()),
            (IdDisplay::Qr, Some("https://vet.example/{value}"))
        );
        assert!(
            c.define_field(
                "Vet Registry",
                FieldType::Text,
                FieldScope::Cat,
                &[],
                IdDisplay::Plain,
                None,
                None
            )
            .is_err()
        );
        assert!(
            c.define_field(
                "!!",
                FieldType::Text,
                FieldScope::Cat,
                &[],
                IdDisplay::Plain,
                None,
                None
            )
            .is_err()
        );
        c.rename_field(&id, "Registry").unwrap();
        c.set_field_lookup_url(&id, None).unwrap();
        assert!(c.set_field_lookup_url(&id, Some("ftp://x")).is_err());
        assert!(c.set_field_lookup_url("cat:x", Some("https://x")).is_err());
        assert!(c.rename_field("cat:x", "y").is_err());
        assert!(c.set_field_options("cat:x", &["a"]).is_err());
        let def = c.field_def("vet-registry").unwrap().unwrap();
        assert_eq!((def.name.as_str(), def.lookup_url), ("Registry", None));
        let height = c
            .define_field(
                "Height",
                FieldType::UnitValue,
                FieldScope::Both,
                &[],
                IdDisplay::Plain,
                None,
                Some(Dimension::Length),
            )
            .unwrap();
        assert_eq!(
            c.field_def("height").unwrap().unwrap().dimension,
            Some(Dimension::Length)
        );
        let mood = c
            .define_field(
                "Mood",
                FieldType::Choice,
                FieldScope::Cat,
                &["calm", "wild"],
                IdDisplay::Plain,
                None,
                None,
            )
            .unwrap();
        c.set_field_options(&mood, &["calm", "wild", "sleepy"])
            .unwrap();
        assert_eq!(c.field_def("mood").unwrap().unwrap().options.len(), 3);
        assert!(
            c.field_defs(Some(FieldScope::Clowder))
                .unwrap()
                .iter()
                .any(|d| d.id == height)
        );
    }

    #[test]
    fn breeds_follow_the_species_and_learn_new_ones() {
        let (_dir, mut c) = catalog();
        c.create_cat("cat:rex", "Rex", None, "dog").unwrap();
        c.create_cat("cat:m", "Miezi", None, "cat").unwrap();
        c.learn_breed("cat:rex", Some("Beagle")).unwrap();
        c.learn_breed("cat:rex", Some("Mutt")).unwrap();
        c.learn_breed("cat:rex", Some("Mutt")).unwrap();
        c.learn_breed("cat:rex", None).unwrap();
        c.learn_breed("cat:m", Some("Housecat")).unwrap();
        let breed = c.field_def("breed").unwrap().unwrap();
        assert_eq!(
            breed.extra_options.get("dog").unwrap(),
            &vec!["Mutt".to_string()]
        );
        let dogs = breed_options(&breed, Some("dog"));
        assert!(dogs.contains(&"Beagle".to_string()) && dogs.last().unwrap() == "Mutt");
        assert_eq!(breed_options(&breed, Some("cat")).len(), 40);
        assert!(breed_options(&breed, None).is_empty());
        assert!(breed_options(&breed, Some("tortoise")).is_empty());
        c.set_pet_mode(true).unwrap();
        assert!(c.is_pet_mode().unwrap());
    }
}
