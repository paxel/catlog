//! Offline name proposals, the phone's own lists: a big global one of
//! classics, ancient and mythic names and funny ones, a small bonus list
//! per language, and one neutral list for Pet mode. Never a name already
//! in the Catalog: no second Luna.

use catlog_core::Catalog;

const GLOBAL: &str = include_str!("../../../../assets/names/global.txt");
const PETS: &str = include_str!("../../../../assets/names/pets.txt");
const BY_LANGUAGE: &[(&str, &str)] = &[
    ("ar", include_str!("../../../../assets/names/ar.txt")),
    ("bg", include_str!("../../../../assets/names/bg.txt")),
    ("bs", include_str!("../../../../assets/names/bs.txt")),
    ("cs", include_str!("../../../../assets/names/cs.txt")),
    ("da", include_str!("../../../../assets/names/da.txt")),
    ("de", include_str!("../../../../assets/names/de.txt")),
    ("el", include_str!("../../../../assets/names/el.txt")),
    ("es", include_str!("../../../../assets/names/es.txt")),
    ("et", include_str!("../../../../assets/names/et.txt")),
    ("fa", include_str!("../../../../assets/names/fa.txt")),
    ("fi", include_str!("../../../../assets/names/fi.txt")),
    ("fr", include_str!("../../../../assets/names/fr.txt")),
    ("ga", include_str!("../../../../assets/names/ga.txt")),
    ("he", include_str!("../../../../assets/names/he.txt")),
    ("hr", include_str!("../../../../assets/names/hr.txt")),
    ("hu", include_str!("../../../../assets/names/hu.txt")),
    ("is", include_str!("../../../../assets/names/is.txt")),
    ("it", include_str!("../../../../assets/names/it.txt")),
    ("ja", include_str!("../../../../assets/names/ja.txt")),
    ("lt", include_str!("../../../../assets/names/lt.txt")),
    ("lv", include_str!("../../../../assets/names/lv.txt")),
    ("mk", include_str!("../../../../assets/names/mk.txt")),
    ("mt", include_str!("../../../../assets/names/mt.txt")),
    ("nl", include_str!("../../../../assets/names/nl.txt")),
    ("no", include_str!("../../../../assets/names/no.txt")),
    ("pl", include_str!("../../../../assets/names/pl.txt")),
    ("pt", include_str!("../../../../assets/names/pt.txt")),
    ("ro", include_str!("../../../../assets/names/ro.txt")),
    ("ru", include_str!("../../../../assets/names/ru.txt")),
    ("sk", include_str!("../../../../assets/names/sk.txt")),
    ("sl", include_str!("../../../../assets/names/sl.txt")),
    ("sq", include_str!("../../../../assets/names/sq.txt")),
    ("sr", include_str!("../../../../assets/names/sr.txt")),
    ("sv", include_str!("../../../../assets/names/sv.txt")),
    ("tr", include_str!("../../../../assets/names/tr.txt")),
    ("uk", include_str!("../../../../assets/names/uk.txt")),
    ("zh", include_str!("../../../../assets/names/zh.txt")),
];

fn lines(text: &str) -> impl Iterator<Item = &str> {
    text.lines().map(str::trim).filter(|l| !l.is_empty())
}

/// The names on offer for `locale`, before the Catalog's own are taken
/// out: the neutral list in Pet mode, else the global list with the
/// language's bonus.
pub fn pool(locale: &str, pet_mode: bool) -> Vec<&'static str> {
    if pet_mode {
        return lines(PETS).collect();
    }
    let lang = locale.split(['-', '_']).next().unwrap_or(locale);
    let bonus = BY_LANGUAGE
        .iter()
        .find(|(l, _)| *l == lang)
        .map(|(_, text)| lines(text).collect::<Vec<_>>())
        .unwrap_or_default();
    lines(GLOBAL).chain(bonus).collect()
}

/// One name not yet in the Catalog, picked by `roll`: the same roll
/// gives the same name, the next roll another.
pub fn propose(store: &Catalog, locale: &str, roll: u64) -> Option<String> {
    let pet_mode = store.is_pet_mode().unwrap_or(false);
    let used: Vec<String> = store
        .cats(None)
        .unwrap_or_default()
        .into_iter()
        .map(|c| c.name.trim().to_lowercase())
        .collect();
    let free: Vec<&str> = pool(locale, pet_mode)
        .into_iter()
        .filter(|n| !used.contains(&n.to_lowercase()))
        .collect();
    if free.is_empty() {
        return None;
    }
    // A small hash of the roll spreads consecutive rolls over the list.
    let mut x = roll
        .wrapping_mul(0x9E37_79B9_7F4A_7C15)
        .wrapping_add(0x2545_F491_4F6C_DD1D);
    x ^= x >> 29;
    x = x.wrapping_mul(0xBF58_476D_1CE4_E5B9);
    x ^= x >> 32;
    Some(free[(x % free.len() as u64) as usize].to_string())
}

/// A roll from the clock, for a fresh proposal each time the dice is thrown.
pub fn roll_now() -> u64 {
    std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .map(|d| d.as_nanos() as u64)
        .unwrap_or(0)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn proposals_skip_the_names_in_use_and_follow_the_language_and_the_mode() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        let first = pool("de", false)[0];
        store.create_cat("cat:a", first, None, "cat").unwrap();
        for roll in 0..200 {
            let name = propose(&store, "de", roll).unwrap();
            assert_ne!(
                name.to_lowercase(),
                first.to_lowercase(),
                "no second {first}"
            );
            assert!(pool("de", false).contains(&name.as_str()));
        }
        let a = propose(&store, "de", 1).unwrap();
        let b = propose(&store, "de", 2).unwrap();
        assert_eq!(
            a,
            propose(&store, "de", 1).unwrap(),
            "the same roll, the same name"
        );
        assert!(
            (0..50).any(|r| propose(&store, "de", r).unwrap() != b),
            "rolls vary"
        );
        // The language's bonus list is part of the pool; Pet mode has its own.
        let de_bonus = lines(BY_LANGUAGE.iter().find(|(l, _)| *l == "de").unwrap().1)
            .next()
            .unwrap();
        assert!(pool("de", false).contains(&de_bonus));
        assert!(!pool("en", false).contains(&de_bonus) || lines(GLOBAL).any(|n| n == de_bonus));
        assert_eq!(pool("de", true).len(), lines(PETS).count());
        // Everything taken: nothing to propose.
        let mut tiny = Catalog::open(&dir.path().join("tiny")).unwrap();
        tiny.set_author("Ada").unwrap();
        tiny.set_local_setting("x", "1").unwrap();
        let mut n = 0;
        for name in pool("xx", true) {
            n += 1;
            tiny.create_cat(&format!("cat:{n}"), name, None, "cat")
                .unwrap();
        }
        let pets: Vec<&str> = pool("xx", true);
        assert!(
            pets.iter()
                .all(|p| tiny.cats(None).unwrap().iter().any(|c| c.name == *p))
        );
    }
}
