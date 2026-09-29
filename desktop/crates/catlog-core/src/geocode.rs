//! Address, city and country search through OSM Nominatim: besides map
//! tiles the app's only outbound call, made only when the keeper
//! submits a search. No reverse geocoding anywhere.

/// One place found for a search. `bounds` is the place's own extent
/// (south, north, west, east) when the service reports it.
#[derive(Debug, Clone, PartialEq)]
pub struct GeoHit {
    pub name: String,
    pub lat: f64,
    pub lon: f64,
    pub bounds: Option<(f64, f64, f64, f64)>,
}

/// Where places are looked up: the service, or a stand-in in tests.
pub trait Geocoder: Send + Sync {
    fn search(&self, query: &str) -> Result<Vec<GeoHit>, String>;
}

pub struct Nominatim;

impl Geocoder for Nominatim {
    fn search(&self, query: &str) -> Result<Vec<GeoHit>, String> {
        let agent = ureq::Agent::config_builder()
            .user_agent(crate::tiles::TILE_USER_AGENT)
            .timeout_global(Some(std::time::Duration::from_secs(10)))
            .build()
            .new_agent();
        let url = format!(
            "https://nominatim.openstreetmap.org/search?q={}&format=jsonv2&limit=8&addressdetails=1",
            crate::registry::encode_component(query)
        );
        let text = agent
            .get(&url)
            .call()
            .map_err(|e| e.to_string())?
            .into_body()
            .read_to_string()
            .map_err(|e| e.to_string())?;
        parse_hits(&text)
    }
}

/// The hits in a Nominatim `jsonv2` answer.
pub fn parse_hits(json: &str) -> Result<Vec<GeoHit>, String> {
    let value: serde_json::Value = serde_json::from_str(json).map_err(|e| e.to_string())?;
    let list = value.as_array().ok_or("not a list")?;
    Ok(list
        .iter()
        .filter_map(|hit| {
            let lat: f64 = hit.get("lat")?.as_str()?.parse().ok()?;
            let lon: f64 = hit.get("lon")?.as_str()?.parse().ok()?;
            let name = hit.get("display_name")?.as_str()?.to_string();
            let bounds = hit.get("boundingbox").and_then(|b| {
                let b = b.as_array()?;
                let f = |i: usize| b.get(i)?.as_str()?.parse::<f64>().ok();
                Some((f(0)?, f(1)?, f(2)?, f(3)?))
            });
            Some(GeoHit {
                name,
                lat,
                lon,
                bounds,
            })
        })
        .collect())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn nominatim_answers_parse_into_hits() {
        let json = r#"[{"lat":"51.34","lon":"12.37","display_name":"Leipzig, Sachsen","boundingbox":["51.2","51.4","12.2","12.5"]},{"lat":"x"},{"lat":"1","lon":"2","display_name":"Somewhere"}]"#;
        let hits = parse_hits(json).unwrap();
        assert_eq!(hits.len(), 2);
        assert_eq!(hits[0].name, "Leipzig, Sachsen");
        assert_eq!(hits[0].bounds, Some((51.2, 51.4, 12.2, 12.5)));
        assert_eq!(hits[1].bounds, None);
        assert!(parse_hits("{}").is_err());
        assert!(parse_hits("junk").is_err());
    }
}
