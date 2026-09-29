//! Records that may be one: duplicate Cats, Clowders and Fields by name
//! and ID, and match candidates for a Missing Cat by Chip ID, by
//! position and by Looks. The rules are the phone's.

use std::collections::{BTreeMap, HashSet};

use crate::Result;
use crate::catalog::{Catalog, EntityView};
use crate::entities::{POSITION_KEY, PositionKind, parse_position, parse_position_kind};
use crate::fields::{FieldDef, FieldType, SPECIES_PRESETS, normalize_id};
use crate::geo::haversine_meters;
use crate::keys;
use crate::looks::{GROUP_ORDER, group_is_single, parse_looks};

/// How sure a duplicate is.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum DuplicateTier {
    Exact,
    Fuzzy,
}

/// What kind of record a pair is.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DuplicateKind {
    Cats,
    Clowders,
    Fields,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct DuplicateCandidate {
    pub a: String,
    pub b: String,
    pub kind: DuplicateKind,
    pub tier: DuplicateTier,
    /// The keys that agree: `name`, an ID Field, `f:birthdate`…
    pub matched: Vec<String>,
    pub score: i32,
}

/// Levenshtein distance over chars.
pub fn edit_distance(a: &str, b: &str) -> usize {
    if a == b {
        return 0;
    }
    let a: Vec<char> = a.chars().collect();
    let b: Vec<char> = b.chars().collect();
    let mut prev: Vec<usize> = (0..=b.len()).collect();
    let mut curr = vec![0; b.len() + 1];
    for i in 1..=a.len() {
        curr[0] = i;
        for j in 1..=b.len() {
            let cost = usize::from(a[i - 1] != b[j - 1]);
            curr[j] = (curr[j - 1] + 1).min(prev[j] + 1).min(prev[j - 1] + cost);
        }
        prev.copy_from_slice(&curr);
    }
    prev[b.len()]
}

fn norm(s: &str) -> String {
    s.trim().to_lowercase()
}

impl Catalog {
    /// Pairs that may be one record, surest first: same name or same ID
    /// exactly, then names an edit or two apart with something else in
    /// common. Fields count when their names agree.
    pub fn duplicate_candidates(&self) -> Result<Vec<DuplicateCandidate>> {
        let mut result = Vec::new();
        let defs = self.field_defs(None)?;
        let id_defs: Vec<&FieldDef> = defs
            .iter()
            .filter(|d| d.field_type == FieldType::Id)
            .collect();
        self.scan_pairs(
            &self.cats(None)?,
            DuplicateKind::Cats,
            &id_defs,
            &mut result,
        )?;
        self.scan_pairs(
            &self.clowders()?,
            DuplicateKind::Clowders,
            &id_defs,
            &mut result,
        )?;
        let fields: Vec<EntityView> = defs
            .iter()
            .map(|d| EntityView {
                id: d.id.clone(),
                name: d.name.clone(),
            })
            .collect();
        self.scan_pairs(&fields, DuplicateKind::Fields, &[], &mut result)?;
        result.sort_by(|x, y| x.tier.cmp(&y.tier).then_with(|| y.score.cmp(&x.score)));
        Ok(result)
    }

    fn scan_pairs(
        &self,
        entities: &[EntityView],
        kind: DuplicateKind,
        id_defs: &[&FieldDef],
        result: &mut Vec<DuplicateCandidate>,
    ) -> Result<()> {
        for i in 0..entities.len() {
            for j in i + 1..entities.len() {
                let (a, b) = (&entities[i], &entities[j]);
                let mut matched = Vec::new();
                let mut exact = false;
                let (na, nb) = (norm(&a.name), norm(&b.name));
                if na == nb && !na.is_empty() {
                    matched.push(keys::NAME.to_string());
                    exact = true;
                }
                let mut score = 0;
                if kind == DuplicateKind::Cats {
                    for def in id_defs {
                        let key = def.key();
                        if let (Some(va), Some(vb)) =
                            (self.current(&a.id, &key)?, self.current(&b.id, &key)?)
                            && normalize_id(&va) == normalize_id(&vb)
                        {
                            matched.push(key);
                            exact = true;
                        }
                    }
                    for slug in ["birthdate", "gender", "breed", "color"] {
                        let key = keys::user_field(slug);
                        let va = self.current(&a.id, &key)?;
                        let vb = self.current(&b.id, &key)?;
                        if let Some(va) = va
                            && !va.is_empty()
                            && Some(va) == vb
                        {
                            matched.push(key);
                            score += if slug == "birthdate" { 2 } else { 1 };
                        }
                    }
                }
                if exact {
                    result.push(DuplicateCandidate {
                        a: a.id.clone(),
                        b: b.id.clone(),
                        kind,
                        tier: DuplicateTier::Exact,
                        matched,
                        score,
                    });
                    continue;
                }
                let distance = edit_distance(&na, &nb);
                if na.chars().count() > 2 && distance <= 2 && (distance <= 1 || score >= 1) {
                    let mut all = vec![keys::NAME.to_string()];
                    all.extend(matched);
                    result.push(DuplicateCandidate {
                        a: a.id.clone(),
                        b: b.id.clone(),
                        kind,
                        tier: DuplicateTier::Fuzzy,
                        matched: all,
                        score,
                    });
                }
            }
        }
        Ok(())
    }
}

/// Why two Cats may be one.
#[derive(Debug, Clone, PartialEq)]
pub enum MatchReason {
    /// The same ID in this Field.
    IdExact(FieldDef),
    /// Seen within the stray area of a flier, a former home or each other.
    Geo,
    /// Their Looks agree in these groups.
    Looks(Vec<String>),
}

#[derive(Debug, Clone, PartialEq)]
pub struct MatchCandidate {
    pub a: String,
    pub b: String,
    pub reason: MatchReason,
    pub distance_meters: Option<f64>,
}

/// The stray area around a flier or a home.
pub const STRAY_AREA_RADIUS_METERS: f64 = 500.0;
/// Agreements a Looks pair needs to be offered.
pub const LOOKS_CANDIDATE_MINIMUM: i32 = 2;

fn pair_key(a: &str, b: &str) -> String {
    if a < b {
        format!("{a}|{b}")
    } else {
        format!("{b}|{a}")
    }
}

/// A shared feature weighs like two ordinary agreements.
pub fn looks_group_weight(group: &str) -> i32 {
    if group == "features" { 2 } else { 1 }
}

/// Looks by group, as [`parse_looks`] reads them.
pub type Looks = BTreeMap<String, Vec<String>>;

/// How two animals compare: a contradiction when they cannot be one,
/// else the groups that agree, features first.
pub fn compare_looks(
    species: (Option<&str>, Option<&str>),
    gender: (Option<&str>, Option<&str>),
    looks: (&Looks, &Looks),
) -> Option<Vec<String>> {
    fn known(s: Option<&str>) -> Option<&str> {
        s.filter(|s| SPECIES_PRESETS.contains(s))
    }
    if let (Some(sa), Some(sb)) = (known(species.0), known(species.1))
        && sa != sb
    {
        return None;
    }
    let mut agreeing: Vec<String> = Vec::new();
    fn g(g: Option<&str>) -> Option<&str> {
        g.filter(|g| !g.is_empty() && *g != "unknown")
    }
    if let (Some(ga), Some(gb)) = (g(gender.0), g(gender.1)) {
        if ga != gb {
            return None;
        }
        agreeing.push("gender".into());
    }
    let mut order = vec!["features"];
    order.extend(GROUP_ORDER.iter().copied().filter(|g| *g != "features"));
    for group in order {
        let (Some(a), Some(b)) = (looks.0.get(group), looks.1.get(group)) else {
            continue;
        };
        let shared = a.iter().any(|v| b.contains(v));
        if group_is_single(group) {
            if a.first() != b.first() {
                return None;
            }
        } else if group == "features" {
            if !shared {
                continue;
            }
        } else if !shared {
            return None;
        }
        if group == "features" {
            agreeing.insert(0, group.to_string());
        } else {
            agreeing.push(group.to_string());
        }
    }
    Some(agreeing)
}

fn agreements(groups: &[String]) -> i32 {
    groups.iter().map(|g| looks_group_weight(g)).sum()
}

impl Catalog {
    fn looks_signature(&self, cat: &str) -> Result<String> {
        Ok([
            self.current(cat, &keys::user_field("species"))?,
            self.current(cat, &keys::user_field("gender"))?,
            self.current(cat, &keys::user_field("looks"))?,
        ]
        .into_iter()
        .map(|v| v.unwrap_or_default())
        .collect::<Vec<_>>()
        .join(""))
    }

    fn pair_signature(&self, a: &str, b: &str) -> Result<String> {
        let (first, second) = if a < b { (a, b) } else { (b, a) };
        Ok(format!(
            "{}\n{}",
            self.looks_signature(first)?,
            self.looks_signature(second)?
        ))
    }

    /// Remembers that these two are not the same, until either changes.
    pub fn reject_looks_match(&self, a: &str, b: &str) -> Result<()> {
        self.set_local_setting(
            &format!("rejectedMatch:{}", pair_key(a, b)),
            &self.pair_signature(a, b)?,
        )
    }

    /// True while the pair was rejected and neither side changed since.
    pub fn is_looks_rejected(&self, a: &str, b: &str) -> Result<bool> {
        Ok(
            self.local_setting(&format!("rejectedMatch:{}", pair_key(a, b)))
                == Some(self.pair_signature(a, b)?),
        )
    }

    /// Cats that may be one: the same ID first, then strays seen within
    /// the stray area, then Looks that agree, best first.
    pub fn match_candidates(&self) -> Result<Vec<MatchCandidate>> {
        let mut seen: HashSet<String> = HashSet::new();
        let mut result = Vec::new();
        let cats = self.cats(None)?;
        for def in self.field_defs(None)? {
            if def.field_type != FieldType::Id {
                continue;
            }
            let mut by_value: BTreeMap<String, Vec<String>> = BTreeMap::new();
            for cat in &cats {
                if let Some(value) = self.current(&cat.id, &def.key())?
                    && !value.is_empty()
                {
                    by_value
                        .entry(normalize_id(&value))
                        .or_default()
                        .push(cat.id.clone());
                }
            }
            for ids in by_value.values() {
                for i in 0..ids.len() {
                    for j in i + 1..ids.len() {
                        if seen.insert(pair_key(&ids[i], &ids[j])) {
                            result.push(MatchCandidate {
                                a: ids[i].clone(),
                                b: ids[j].clone(),
                                reason: MatchReason::IdExact(def.clone()),
                                distance_meters: None,
                            });
                        }
                    }
                }
            }
        }
        struct Geo {
            stray: bool,
            sightings: Vec<(f64, f64)>,
            fliers: Vec<(f64, f64)>,
            home_of: Option<String>,
            home: Vec<(f64, f64)>,
        }
        let mut geo: Vec<Geo> = Vec::new();
        for cat in &cats {
            let stray = self.current(&cat.id, keys::CLOWDER)?.is_none();
            let sightings = self
                .field_history(&cat.id, POSITION_KEY, false)?
                .into_iter()
                .filter(|e| {
                    parse_position_kind(e.value.as_deref().unwrap_or("")) == PositionKind::Sighting
                })
                .filter_map(|e| parse_position(e.value.as_deref()))
                .collect();
            geo.push(Geo {
                stray,
                sightings,
                fliers: self.flier_positions(&cat.id)?,
                home_of: if stray {
                    self.former_clowder(&cat.id)?
                } else {
                    None
                },
                home: self.stray_home_position(&cat.id)?.into_iter().collect(),
            });
        }
        let mut by_geo = Vec::new();
        for i in 0..cats.len() {
            for j in i + 1..cats.len() {
                let (a, b) = (&cats[i].id, &cats[j].id);
                if seen.contains(&pair_key(a, b)) {
                    continue;
                }
                let (ga, gb) = (&geo[i], &geo[j]);
                let mut best: Option<f64> = None;
                let mut check = |xs: &[(f64, f64)], ys: &[(f64, f64)]| {
                    for x in xs {
                        for y in ys {
                            let d = haversine_meters(x.0, x.1, y.0, y.1);
                            if d <= STRAY_AREA_RADIUS_METERS && best.is_none_or(|b| d < b) {
                                best = Some(d);
                            }
                        }
                    }
                };
                if gb.stray {
                    check(&ga.fliers, &gb.sightings);
                }
                if ga.stray {
                    check(&gb.fliers, &ga.sightings);
                }
                if ga.home_of.is_none() || ga.home_of != gb.home_of {
                    if gb.stray {
                        check(&ga.home, &gb.sightings);
                    }
                    if ga.stray {
                        check(&gb.home, &ga.sightings);
                    }
                }
                if ga.stray && gb.stray {
                    check(&ga.sightings, &gb.sightings);
                }
                if let Some(d) = best {
                    seen.insert(pair_key(a, b));
                    by_geo.push(MatchCandidate {
                        a: a.clone(),
                        b: b.clone(),
                        reason: MatchReason::Geo,
                        distance_meters: Some(d),
                    });
                }
            }
        }
        by_geo.sort_by(|x, y| {
            x.distance_meters
                .partial_cmp(&y.distance_meters)
                .unwrap_or(std::cmp::Ordering::Equal)
        });
        result.extend(by_geo);
        // Looks: at least one a stray, no contradiction, enough agreeing.
        struct Look {
            species: Option<String>,
            gender: Option<String>,
            looks: Looks,
            stray: bool,
            position: Option<(f64, f64)>,
        }
        let mut looks: Vec<Look> = Vec::new();
        for cat in &cats {
            looks.push(Look {
                species: self.current(&cat.id, &keys::user_field("species"))?,
                gender: self.current(&cat.id, &keys::user_field("gender"))?,
                looks: parse_looks(
                    self.current(&cat.id, &keys::user_field("looks"))?
                        .as_deref(),
                ),
                stray: self.current(&cat.id, keys::CLOWDER)?.is_none(),
                position: self.position_of(&cat.id)?,
            });
        }
        let mut by_looks: Vec<(i32, MatchCandidate)> = Vec::new();
        for i in 0..cats.len() {
            for j in i + 1..cats.len() {
                let (a, b) = (&cats[i].id, &cats[j].id);
                let (la, lb) = (&looks[i], &looks[j]);
                if (!la.stray && !lb.stray) || la.looks.is_empty() || lb.looks.is_empty() {
                    continue;
                }
                let Some(agreeing) = compare_looks(
                    (la.species.as_deref(), lb.species.as_deref()),
                    (la.gender.as_deref(), lb.gender.as_deref()),
                    (&la.looks, &lb.looks),
                ) else {
                    continue;
                };
                let weight = agreements(&agreeing);
                if weight < LOOKS_CANDIDATE_MINIMUM
                    || seen.contains(&pair_key(a, b))
                    || self.is_looks_rejected(a, b)?
                {
                    continue;
                }
                let distance = match (la.position, lb.position) {
                    (Some(p), Some(q)) => Some(haversine_meters(p.0, p.1, q.0, q.1)),
                    _ => None,
                };
                by_looks.push((
                    weight,
                    MatchCandidate {
                        a: a.clone(),
                        b: b.clone(),
                        reason: MatchReason::Looks(agreeing),
                        distance_meters: distance,
                    },
                ));
            }
        }
        by_looks.sort_by(|x, y| {
            y.0.cmp(&x.0)
                .then_with(|| match (x.1.distance_meters, y.1.distance_meters) {
                    (None, None) => std::cmp::Ordering::Equal,
                    (None, _) => std::cmp::Ordering::Greater,
                    (_, None) => std::cmp::Ordering::Less,
                    (Some(p), Some(q)) => p.partial_cmp(&q).unwrap_or(std::cmp::Ordering::Equal),
                })
        });
        result.extend(by_looks.into_iter().map(|(_, m)| m));
        Ok(result)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::entities::PositionKind;

    fn store(dir: &std::path::Path) -> Catalog {
        let s = Catalog::open(dir).unwrap();
        s.set_author("Ada").unwrap();
        s
    }

    #[test]
    fn edit_distance_counts_chars() {
        assert_eq!(edit_distance("miezi", "miezi"), 0);
        assert_eq!(edit_distance("miezi", "mietzi"), 1);
        assert_eq!(edit_distance("kitty", "kätty"), 1);
        assert_eq!(edit_distance("", "abc"), 3);
    }

    #[test]
    fn duplicates_by_name_id_and_near_names_sorted_surest_first() {
        let dir = tempfile::tempdir().unwrap();
        let mut s = store(dir.path());
        s.create_clowder("clowder:h", "Home").unwrap();
        s.create_clowder("clowder:h2", "home ").unwrap();
        s.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        s.create_cat("cat:b", "Mietzi", None, "cat").unwrap();
        s.create_cat("cat:c", "Tom", None, "cat").unwrap();
        s.create_cat("cat:d", "Tim", None, "cat").unwrap();
        s.create_cat("cat:e", "Zorro", None, "cat").unwrap();
        s.append("cat:c", "f:chipid", Some("276 0981 2345"))
            .unwrap();
        s.append("cat:e", "f:chipid", Some("27609812345")).unwrap();
        s.append("cat:a", "f:birthdate", Some("2020-01-01"))
            .unwrap();
        s.append("cat:b", "f:birthdate", Some("2020-01-01"))
            .unwrap();
        s.append("cat:c", "f:gender", Some("male")).unwrap();
        s.append("cat:d", "f:gender", Some("male")).unwrap();
        let found = s.duplicate_candidates().unwrap();
        let pairs: Vec<(String, String, DuplicateTier)> = found
            .iter()
            .map(|c| (c.a.clone(), c.b.clone(), c.tier))
            .collect();
        assert!(
            pairs.contains(&("cat:c".into(), "cat:e".into(), DuplicateTier::Exact)),
            "same chip"
        );
        assert!(
            pairs.contains(&(
                "clowder:h".into(),
                "clowder:h2".into(),
                DuplicateTier::Exact
            )),
            "same home name"
        );
        assert!(
            pairs.contains(&("cat:a".into(), "cat:b".into(), DuplicateTier::Fuzzy)),
            "one edit apart"
        );
        assert!(
            pairs.contains(&("cat:c".into(), "cat:d".into(), DuplicateTier::Fuzzy)),
            "Tom and Tim: one edit apart"
        );
        assert!(
            !pairs.iter().any(|p| p.0 == "cat:d" && p.1 == "cat:e"),
            "Tim and Zorro are nothing alike"
        );
        let exact_first = found
            .iter()
            .position(|c| c.tier == DuplicateTier::Fuzzy)
            .unwrap_or(found.len());
        assert!(
            found[..exact_first]
                .iter()
                .all(|c| c.tier == DuplicateTier::Exact)
        );
        let chip = found
            .iter()
            .find(|c| c.a == "cat:c" && c.b == "cat:e")
            .unwrap();
        assert_eq!(chip.matched, vec!["f:chipid".to_string()]);
        let near = found
            .iter()
            .find(|c| c.a == "cat:a" && c.b == "cat:b")
            .unwrap();
        assert_eq!(
            near.matched,
            vec!["name".to_string(), "f:birthdate".to_string()]
        );
        assert_eq!(near.score, 2);
        // Fields with the same name are duplicates too.
        let dup = s
            .duplicate_candidates()
            .unwrap()
            .iter()
            .filter(|c| c.kind == DuplicateKind::Fields)
            .count();
        assert_eq!(dup, 0);
    }

    #[test]
    fn match_candidates_by_id_position_and_looks_with_rejection() {
        let dir = tempfile::tempdir().unwrap();
        let mut s = store(dir.path());
        s.create_clowder("clowder:h", "Home").unwrap();
        s.append("clowder:h", POSITION_KEY, Some("51.3400,12.3700"))
            .unwrap();
        // Lost from Home: a former home with a position, then seen close by.
        s.create_cat("cat:lost", "Lost", Some("clowder:h"), "cat")
            .unwrap();
        s.move_cat("cat:lost", None).unwrap();
        s.create_cat("cat:seen", "Stray", None, "cat").unwrap();
        s.record_position("cat:seen", 51.3410, 12.3710, PositionKind::Sighting, None)
            .unwrap();
        // Two cats with one chip.
        s.create_cat("cat:x", "X", None, "cat").unwrap();
        s.create_cat("cat:y", "Y", None, "cat").unwrap();
        s.append("cat:x", "f:chipid", Some("111")).unwrap();
        s.append("cat:y", "f:chipid", Some("1 1 1")).unwrap();
        // Looks: a stray and a housecat that look alike.
        s.create_cat("cat:p", "P", None, "cat").unwrap();
        s.create_cat("cat:q", "Q", Some("clowder:h"), "cat")
            .unwrap();
        for id in ["cat:p", "cat:q"] {
            s.append(id, "f:species", Some("cat")).unwrap();
            s.append(id, "f:gender", Some("female")).unwrap();
            s.append(
                id,
                "f:looks",
                Some("size=small;colours=black,white;features=extra-toes"),
            )
            .unwrap();
        }
        let found = s.match_candidates().unwrap();
        assert!(matches!(&found[0].reason, MatchReason::IdExact(d) if d.slug == "chipid"));
        assert_eq!(
            (found[0].a.as_str(), found[0].b.as_str()),
            ("cat:x", "cat:y")
        );
        let geo = found
            .iter()
            .find(|m| m.reason == MatchReason::Geo)
            .expect("seen near the former home");
        assert_eq!((geo.a.as_str(), geo.b.as_str()), ("cat:lost", "cat:seen"));
        assert!(geo.distance_meters.unwrap() < STRAY_AREA_RADIUS_METERS);
        let looks = found
            .iter()
            .find(|m| matches!(m.reason, MatchReason::Looks(_)))
            .expect("looks agree");
        assert_eq!((looks.a.as_str(), looks.b.as_str()), ("cat:p", "cat:q"));
        if let MatchReason::Looks(groups) = &looks.reason {
            assert_eq!(groups[0], "features");
            assert!(groups.contains(&"gender".to_string()));
        }
        // Rejected until one of them changes.
        s.reject_looks_match("cat:q", "cat:p").unwrap();
        assert!(s.is_looks_rejected("cat:p", "cat:q").unwrap());
        assert!(
            !s.match_candidates()
                .unwrap()
                .iter()
                .any(|m| matches!(m.reason, MatchReason::Looks(_)))
        );
        s.append(
            "cat:p",
            "f:looks",
            Some("size=small;colours=black;features=extra-toes"),
        )
        .unwrap();
        assert!(!s.is_looks_rejected("cat:p", "cat:q").unwrap());
        assert!(
            s.match_candidates()
                .unwrap()
                .iter()
                .any(|m| matches!(m.reason, MatchReason::Looks(_)))
        );
        // Contradictions and thin agreement are no candidates.
        let none = compare_looks(
            (Some("cat"), Some("dog")),
            (None, None),
            (&BTreeMap::new(), &BTreeMap::new()),
        );
        assert_eq!(none, None);
        let none = compare_looks(
            (None, None),
            (Some("male"), Some("female")),
            (&BTreeMap::new(), &BTreeMap::new()),
        );
        assert_eq!(none, None);
        let a = parse_looks(Some("size=small;colours=black"));
        let b = parse_looks(Some("size=large;colours=black"));
        assert_eq!(
            compare_looks((None, None), (None, None), (&a, &b)),
            None,
            "a single group differs"
        );
        let b = parse_looks(Some("colours=white"));
        assert_eq!(
            compare_looks((None, None), (None, None), (&a, &b)),
            None,
            "no colour in common"
        );
        let b = parse_looks(Some("size=small;colours=black,grey"));
        assert_eq!(
            compare_looks(
                (None, Some("cat")),
                (Some("unknown"), Some("female")),
                (&a, &b)
            ),
            Some(vec!["size".to_string(), "colours".to_string()])
        );
        assert_eq!(looks_group_weight("features"), 2);
    }
}
