//! Pet registries differ per country and none offers an open interface.
//! cat(a)log knows them only as ID Fields carrying a lookup template: a
//! URL with `{value}` where the number goes. The app never calls them.

use crate::fields::{FieldDef, is_web_lookup};

pub const LOOKUP_PLACEHOLDER: &str = "{value}";

/// A ready-made registry offered when an ID Field is created.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct RegistryPreset {
    pub name: &'static str,
    pub template: &'static str,
}

/// The registries with a documented, parameter-addressable report page.
pub const REGISTRY_PRESETS: [RegistryPreset; 1] = [RegistryPreset {
    name: "Tasso",
    template: "https://www.tasso.net/Tierregister/Suchmeldungen?snr={value}",
}];

/// `value` the way a URL component carries it.
pub fn encode_component(value: &str) -> String {
    let mut out = String::new();
    for b in value.trim().bytes() {
        match b {
            b'A'..=b'Z'
            | b'a'..=b'z'
            | b'0'..=b'9'
            | b'-'
            | b'_'
            | b'.'
            | b'!'
            | b'~'
            | b'*'
            | b'\''
            | b'('
            | b')' => out.push(b as char),
            _ => out.push_str(&format!("%{b:02X}")),
        }
    }
    out
}

/// `template` with the placeholder replaced by the encoded `value`.
pub fn build_lookup_url(template: &str, value: &str) -> String {
    template.replace(LOOKUP_PLACEHOLDER, &encode_component(value))
}

/// The URL for looking `value` up in the service of `def`, or none when
/// the Field has no template or the value is empty.
pub fn lookup_url(def: &FieldDef, value: &str) -> Option<String> {
    let template = def.lookup_url.as_deref()?;
    if value.trim().is_empty() || !is_web_lookup(template) {
        return None;
    }
    Some(build_lookup_url(template, value))
}

/// A URL taken apart: host, path segments, query pairs.
type UrlParts = (String, Vec<String>, Vec<(String, String)>);

fn split_url(url: &str) -> Option<UrlParts> {
    let rest = url.split_once("://")?.1;
    let (host_path, query) = match rest.split_once('?') {
        Some((hp, q)) => (hp, Some(q)),
        None => (rest, None),
    };
    let (host, path) = match host_path.split_once('/') {
        Some((h, p)) => (h, p),
        None => (host_path, ""),
    };
    let segments: Vec<String> = path
        .split('/')
        .filter(|s| !s.is_empty())
        .map(String::from)
        .collect();
    let params: Vec<(String, String)> = query
        .unwrap_or("")
        .split('&')
        .filter(|p| !p.is_empty())
        .map(|p| match p.split_once('=') {
            Some((k, v)) => (k.to_string(), v.to_string()),
            None => (p.to_string(), String::new()),
        })
        .collect();
    Some((host.to_lowercase(), segments, params))
}

/// The identifier `url` carries for `template`, or none when the link
/// belongs to another service. Extra query parameters are ignored.
pub fn id_from_lookup_url(template: &str, url: &str) -> Option<String> {
    let (want_host, want_path, want_params) = split_url(template)?;
    let (have_host, have_path, have_params) = split_url(url)?;
    if want_host != have_host {
        return None;
    }
    for (key, value) in &want_params {
        if value != LOOKUP_PLACEHOLDER {
            continue;
        }
        if want_path != have_path {
            return None;
        }
        let found = have_params
            .iter()
            .find(|(k, _)| k == key)
            .map(|(_, v)| v.clone())?;
        return (!found.is_empty()).then_some(found);
    }
    if want_path.len() != have_path.len() {
        return None;
    }
    let mut found: Option<String> = None;
    for (w, h) in want_path.iter().zip(&have_path) {
        if w == LOOKUP_PLACEHOLDER {
            found = Some(h.clone());
        } else if w != h {
            return None;
        }
    }
    found.filter(|f| !f.is_empty())
}

/// The preset `url` belongs to, with the identifier it carries.
pub fn recognize_lookup_url(url: &str) -> Option<(RegistryPreset, String)> {
    REGISTRY_PRESETS
        .iter()
        .find_map(|p| id_from_lookup_url(p.template, url).map(|v| (*p, v)))
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::fields::{FieldScope, FieldType, IdDisplay};

    fn def(template: Option<&str>) -> FieldDef {
        FieldDef {
            id: "fielddef:chipid".into(),
            slug: "chipid".into(),
            name: "Chip ID".into(),
            field_type: FieldType::Id,
            scope: FieldScope::Cat,
            options: vec![],
            id_display: IdDisplay::Barcode,
            lookup_url: template.map(String::from),
            dimension: None,
            extra_options: Default::default(),
        }
    }

    #[test]
    fn lookup_links_carry_the_encoded_value() {
        let tasso = def(Some(REGISTRY_PRESETS[0].template));
        assert_eq!(
            lookup_url(&tasso, " 276 098 ").unwrap(),
            "https://www.tasso.net/Tierregister/Suchmeldungen?snr=276%20098"
        );
        assert!(lookup_url(&tasso, "  ").is_none());
        assert!(lookup_url(&def(None), "1").is_none());
        assert!(lookup_url(&def(Some("ftp://x/{value}")), "1").is_none());
        assert_eq!(
            encode_component("a-b_c.d~e!f*g'h(i)j"),
            "a-b_c.d~e!f*g'h(i)j"
        );
        assert_eq!(encode_component("ä/?"), "%C3%A4%2F%3F");
    }

    #[test]
    fn a_scanned_link_gives_its_identifier_back() {
        let t = REGISTRY_PRESETS[0].template;
        assert_eq!(
            id_from_lookup_url(
                t,
                "https://www.tasso.net/Tierregister/Suchmeldungen?lang=de&snr=123&lp=1"
            )
            .as_deref(),
            Some("123")
        );
        assert!(
            id_from_lookup_url(t, "https://www.TASSO.net/Tierregister/Suchmeldungen?snr=")
                .is_none()
        );
        assert!(id_from_lookup_url(t, "https://www.tasso.net/Other?snr=1").is_none());
        assert!(
            id_from_lookup_url(t, "https://other.net/Tierregister/Suchmeldungen?snr=1").is_none()
        );
        assert!(id_from_lookup_url(t, "junk").is_none());
        let path = "https://reg.example/id/{value}/report";
        assert_eq!(
            id_from_lookup_url(path, "https://reg.example/id/42/report").as_deref(),
            Some("42")
        );
        assert!(id_from_lookup_url(path, "https://reg.example/id/42").is_none());
        assert!(id_from_lookup_url(path, "https://reg.example/no/42/report").is_none());
        assert!(id_from_lookup_url("https://reg.example/a/b", "https://reg.example/a/b").is_none());
        let (preset, value) =
            recognize_lookup_url("https://www.tasso.net/Tierregister/Suchmeldungen?snr=9").unwrap();
        assert_eq!((preset.name, value.as_str()), ("Tasso", "9"));
        assert!(recognize_lookup_url("https://nowhere.example/").is_none());
    }
}
