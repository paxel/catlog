//! Looks: what an animal looks like, as tags in groups, stored in the
//! starter `looks` field as one line such as
//! `size=medium; colours=black,white; fur=short`. Values are canonical
//! English keys; the UI translates them.

use std::collections::BTreeMap;

/// The groups in the order they are shown and stored.
pub const GROUP_ORDER: [&str; 12] = [
    "size", "colours", "eyes", "pattern", "fur", "tail", "ears", "marks", "crest", "beak", "ring",
    "features",
];

/// One group of Looks: its id, whether it takes one value at most, and
/// the values offered.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct LooksGroup {
    pub id: &'static str,
    pub single: bool,
    pub values: &'static [&'static str],
}

const fn group(id: &'static str, single: bool, values: &'static [&'static str]) -> LooksGroup {
    LooksGroup { id, single, values }
}

const SIZE: LooksGroup = group("size", true, &["small", "medium", "large"]);
const FUR_COLOURS: LooksGroup = group(
    "colours",
    false,
    &[
        "black",
        "white",
        "grey",
        "blue",
        "brown",
        "chocolate",
        "lilac",
        "ginger",
        "cream",
        "golden",
        "tan",
        "silver",
        "smoke",
    ],
);
const PLUMAGE: LooksGroup = group(
    "colours",
    false,
    &[
        "green", "blue", "yellow", "red", "orange", "white", "grey", "black", "brown",
    ],
);
const EYES: LooksGroup = group(
    "eyes",
    true,
    &["green", "amber", "blue", "copper", "odd-eyed"],
);
const FUR_MARKS: LooksGroup = group(
    "marks",
    false,
    &[
        "white bib",
        "white paws",
        "white tail tip",
        "blaze",
        "mask",
        "spots",
        "patches",
        "stripes",
        "scar",
        "collar",
    ],
);
const BIRD_MARKS: LooksGroup = group(
    "marks",
    false,
    &["spots", "stripes", "patches", "mask", "collar", "scar"],
);
const FUR: LooksGroup = group(
    "fur",
    true,
    &["short", "medium", "long", "hairless", "curly", "wiry"],
);
const TAIL: LooksGroup = group(
    "tail",
    true,
    &["long", "short", "bobtail", "none", "curled", "kinked"],
);
const EARS: LooksGroup = group(
    "ears",
    true,
    &[
        "upright", "floppy", "folded", "rounded", "curled", "cropped",
    ],
);
const CAT_PATTERN: LooksGroup = group(
    "pattern",
    true,
    &[
        "solid",
        "tabby",
        "spotted",
        "ticked",
        "tortoiseshell",
        "calico",
        "colourpoint",
        "van",
        "bicolour",
        "tuxedo",
    ],
);
const DOG_PATTERN: LooksGroup = group(
    "pattern",
    true,
    &[
        "solid",
        "brindle",
        "merle",
        "spotted",
        "patched",
        "tricolour",
        "sable",
    ],
);
const CREST: LooksGroup = group("crest", true, &["yes", "no"]);
const BEAK: LooksGroup = group(
    "beak",
    true,
    &["black", "grey", "yellow", "orange", "red", "pink"],
);
const RING: LooksGroup = group("ring", true, &["yes", "no"]);
/// What never grows back and what was done on purpose: the strongest
/// evidence two sightings are one animal. Every species has it, with
/// the body parts it has: ears and teeth for fur, wings for feathers, a
/// shell for a tortoise.
const FUR_FEATURES: LooksGroup = group(
    "features",
    false,
    &[
        "tipped ear",
        "notched ear",
        "ear tattoo",
        "missing ear",
        "missing eye",
        "cloudy eye",
        "missing front leg",
        "missing hind leg",
        "no teeth",
        "extra toes",
    ],
);
const BIRD_FEATURES: LooksGroup = group(
    "features",
    false,
    &[
        "missing eye",
        "cloudy eye",
        "missing leg",
        "missing toes",
        "injured wing",
        "clipped wings",
    ],
);
const TORTOISE_FEATURES: LooksGroup = group(
    "features",
    false,
    &[
        "missing eye",
        "cloudy eye",
        "missing front leg",
        "missing hind leg",
        "damaged shell",
    ],
);
/// An animal the app does not know may have any of them.
const ANY_FEATURES: LooksGroup = group(
    "features",
    false,
    &[
        "tipped ear",
        "notched ear",
        "ear tattoo",
        "missing ear",
        "missing eye",
        "cloudy eye",
        "missing front leg",
        "missing hind leg",
        "missing leg",
        "missing toes",
        "extra toes",
        "injured wing",
        "clipped wings",
        "damaged shell",
        "no teeth",
    ],
);
/// A tortoise's shell and skin, in the colours there are words for.
const SHELL_COLOURS: LooksGroup = group(
    "colours",
    false,
    &["black", "brown", "tan", "yellow", "orange", "green", "grey"],
);

/// The groups an animal of `species` is described with. Unknown
/// species get size, colours and every feature.
pub fn looks_groups_for(species: Option<&str>) -> Vec<LooksGroup> {
    let known = species.filter(|s| crate::fields::SPECIES_PRESETS.contains(s));
    match known {
        Some("bird") => vec![SIZE, PLUMAGE, BIRD_MARKS, CREST, BEAK, RING, BIRD_FEATURES],
        Some("tortoise") => vec![SIZE, SHELL_COLOURS, TORTOISE_FEATURES],
        Some(s @ ("cat" | "dog" | "rabbit" | "guinea pig" | "hamster" | "horse" | "ferret")) => {
            let mut groups = vec![SIZE, FUR_COLOURS];
            if s == "cat" || s == "dog" {
                groups.push(EYES);
            }
            if s == "cat" {
                groups.push(CAT_PATTERN);
            }
            if s == "dog" {
                groups.push(DOG_PATTERN);
            }
            groups.extend([FUR, TAIL, EARS, FUR_MARKS, FUR_FEATURES]);
            groups
        }
        _ => vec![SIZE, FUR_COLOURS, ANY_FEATURES],
    }
}

/// Groups that take one value at most.
pub fn group_is_single(group: &str) -> bool {
    matches!(
        group,
        "size" | "eyes" | "pattern" | "fur" | "tail" | "ears" | "crest" | "beak" | "ring"
    )
}

/// A stored Looks line as group to sorted values.
pub fn parse_looks(value: Option<&str>) -> BTreeMap<String, Vec<String>> {
    let mut result = BTreeMap::new();
    let Some(value) = value else {
        return result;
    };
    for part in value.split(';') {
        let Some((group, values)) = part.split_once('=') else {
            continue;
        };
        let group = group.trim();
        if group.is_empty() {
            continue;
        }
        let mut list: Vec<String> = values
            .split(',')
            .map(str::trim)
            .filter(|v| !v.is_empty())
            .map(String::from)
            .collect();
        list.sort();
        list.dedup();
        if !list.is_empty() {
            result.insert(group.to_string(), list);
        }
    }
    result
}

/// The stored line for a set of Looks; none when there is nothing.
pub fn encode_looks(looks: &BTreeMap<String, Vec<String>>) -> Option<String> {
    let mut groups: Vec<&str> = GROUP_ORDER
        .iter()
        .copied()
        .filter(|g| looks.get(*g).is_some_and(|v| !v.is_empty()))
        .collect();
    for g in looks.keys() {
        if !GROUP_ORDER.contains(&g.as_str()) && !looks[g].is_empty() {
            groups.push(g);
        }
    }
    if groups.is_empty() {
        return None;
    }
    Some(
        groups
            .iter()
            .map(|g| {
                let mut values = looks[*g].clone();
                values.sort();
                format!("{g}={}", values.join(","))
            })
            .collect::<Vec<_>>()
            .join("; "),
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn looks_lines_parse_and_encode_in_group_order() {
        let looks = parse_looks(Some("fur=short; size=medium; colours=white,black,; junk"));
        assert_eq!(looks["colours"], vec!["black", "white"]);
        assert_eq!(looks.len(), 3);
        assert_eq!(
            encode_looks(&looks).unwrap(),
            "size=medium; colours=black,white; fur=short"
        );
        assert!(parse_looks(None).is_empty());
        assert!(encode_looks(&BTreeMap::new()).is_none());
        let mut odd = BTreeMap::new();
        odd.insert("wings".to_string(), vec!["two".to_string()]);
        odd.insert("size".to_string(), vec![]);
        assert_eq!(encode_looks(&odd).unwrap(), "wings=two");
        assert!(group_is_single("size") && !group_is_single("marks"));
    }

    #[test]
    fn the_groups_follow_the_species() {
        let ids = |s: Option<&str>| looks_groups_for(s).iter().map(|g| g.id).collect::<Vec<_>>();
        assert_eq!(
            ids(Some("cat")),
            vec![
                "size", "colours", "eyes", "pattern", "fur", "tail", "ears", "marks", "features"
            ]
        );
        assert_eq!(ids(Some("dog"))[3], "pattern");
        assert_eq!(
            ids(Some("rabbit")),
            vec![
                "size", "colours", "fur", "tail", "ears", "marks", "features"
            ]
        );
        assert_eq!(
            ids(Some("bird")),
            vec![
                "size", "colours", "marks", "crest", "beak", "ring", "features"
            ]
        );
        for s in ["horse", "ferret"] {
            assert_eq!(ids(Some(s)), ids(Some("rabbit")), "{s}");
        }
        assert_eq!(ids(Some("tortoise")), vec!["size", "colours", "features"]);
        assert_eq!(ids(None), vec!["size", "colours", "features"]);
        assert_eq!(ids(Some("axolotl")), ids(None));
        assert!(
            looks_groups_for(Some("cat"))
                .iter()
                .all(|g| group_is_single(g.id) == g.single)
        );
    }

    #[test]
    fn the_features_name_only_body_parts_the_species_has() {
        let features = |s: Option<&str>| -> std::collections::BTreeSet<&str> {
            let groups = looks_groups_for(s);
            let g = groups.iter().find(|g| g.id == "features").unwrap();
            g.values.iter().copied().collect()
        };
        assert_eq!(
            features(Some("bird")),
            [
                "missing eye",
                "cloudy eye",
                "missing leg",
                "missing toes",
                "injured wing",
                "clipped wings"
            ]
            .into()
        );
        assert_eq!(
            features(Some("tortoise")),
            [
                "missing eye",
                "cloudy eye",
                "missing front leg",
                "missing hind leg",
                "damaged shell"
            ]
            .into()
        );
        assert!(features(Some("cat")).contains("no teeth"));
        assert!(!features(Some("cat")).contains("injured wing"));
        // An unknown animal may have any of them.
        let all: std::collections::BTreeSet<&str> = crate::fields::SPECIES_PRESETS
            .iter()
            .flat_map(|s| features(Some(s)))
            .collect();
        assert_eq!(features(None), all);
        assert_eq!(features(Some("axolotl")), all);
    }
}
