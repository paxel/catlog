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
}
