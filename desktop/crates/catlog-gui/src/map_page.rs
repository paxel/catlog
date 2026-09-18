//! The map page: every Cat and place with a position as a pin, the
//! trail of the pin last tapped, the 500 m circles of chosen missing
//! cats, the viewport remembered per device.

use catlog_core::geocode::{GeoHit, Geocoder};
use std::collections::HashSet;
use std::sync::Arc;

use catlog_core::entities::{POSITION_KEY, PositionKind, parse_position, parse_position_kind};
use catlog_core::geo::STRAY_AREA_RADIUS_METERS;
use catlog_core::{Catalog, keys};
use egui::{Ui, Vec2};

use crate::l10n::L10n;
use crate::map::{Circle, MapAction, MapView, Pin, Viewport};

pub const VIEWPORT_KEY: &str = "mapViewport";

/// What the keeper did on the map page.
#[derive(Debug, Clone, PartialEq)]
pub enum MapPageAction {
    None,
    OpenCat(String),
    OpenClowder(String),
    /// Record a sighting of this Cat at this position.
    Sighting(String, f64, f64),
}

pub struct MapPage {
    pub map: MapView,
    /// The pin whose trail is drawn.
    pub trail_of: Option<String>,
    /// Missing cats whose possible stray area is overlaid.
    pub stray_areas: HashSet<String>,
    pub areas_open: bool,
    /// The Cat a right-click offered to record a sighting for.
    pub sighting_at: Option<(f64, f64)>,
    loaded_viewport: bool,
    /// What the keeper typed to jump somewhere: a cat, a clowder, the
    /// person responsible for one, or a place through the geocoder.
    pub query: String,
    /// What the last search found, or why it found nothing.
    pub search_note: Option<String>,
    geocoder: Option<Arc<dyn Geocoder>>,
}

impl MapPage {
    pub fn new(map: MapView) -> MapPage {
        MapPage {
            query: String::new(),
            search_note: None,
            geocoder: None,
            map,
            trail_of: None,
            stray_areas: HashSet::new(),
            areas_open: false,
            sighting_at: None,
            loaded_viewport: false,
        }
    }

    /// Jumps to an entity's position.
    /// Where places are looked up.
    pub fn with_geocoder(mut self, geocoder: Arc<dyn Geocoder>) -> MapPage {
        self.geocoder = Some(geocoder);
        self
    }

    /// Jumps to what the query names: a cat or clowder by name, a
    /// clowder by the person responsible, else a place the geocoder
    /// knows. The note says what was found or why nothing was.
    pub fn search(&mut self, store: &Catalog, t: &L10n) {
        let query = self.query.trim().to_lowercase();
        if query.is_empty() {
            return;
        }
        let records = store
            .cats(None)
            .unwrap_or_default()
            .into_iter()
            .chain(store.clowders().unwrap_or_default());
        for record in records {
            let person = store
                .current(&record.id, &keys::user_field("responsible"))
                .ok()
                .flatten()
                .unwrap_or_default();
            let named = record.name.to_lowercase().contains(&query)
                || person.to_lowercase().contains(&query);
            if named && store.position_of(&record.id).ok().flatten().is_some() {
                self.focus(store, &record.id);
                self.search_note = Some(record.name);
                return;
            }
        }
        let Some(geocoder) = &self.geocoder else {
            self.search_note = Some(t.search_no_results().to_string());
            return;
        };
        match geocoder.search(&self.query) {
            Ok(hits) => match hits.first() {
                Some(hit) => {
                    self.jump_to(hit);
                    self.search_note = Some(hit.name.clone());
                }
                None => self.search_note = Some(t.search_no_results().to_string()),
            },
            Err(e) => self.search_note = Some(e),
        }
    }

    /// Street zoom for a point, the place's own extent for an area.
    fn jump_to(&mut self, hit: &GeoHit) {
        let zoom = match hit.bounds {
            Some((south, north, west, east)) => {
                let spread = (north - south).max(east - west);
                if spread < 0.01 {
                    16
                } else if spread < 0.1 {
                    13
                } else if spread < 1.0 {
                    10
                } else {
                    7
                }
            }
            None => 15,
        };
        self.map.viewport = Viewport {
            lat: hit.lat,
            lon: hit.lon,
            zoom,
        };
        self.trail_of = None;
        self.loaded_viewport = true;
    }

    pub fn focus(&mut self, store: &Catalog, id: &str) {
        if let Ok(Some((lat, lon))) = store.position_of(id) {
            self.map.viewport = Viewport { lat, lon, zoom: 15 };
            self.trail_of = Some(id.to_string());
            self.loaded_viewport = true;
        }
    }

    /// Cats that could be roaming: any with flier positions or a home
    /// they ran from.
    pub fn missing_cats(store: &Catalog) -> Vec<catlog_core::EntityView> {
        store
            .cats(None)
            .unwrap_or_default()
            .into_iter()
            .filter(|c| {
                !store.flier_positions(&c.id).unwrap_or_default().is_empty()
                    || store.stray_home_position(&c.id).ok().flatten().is_some()
            })
            .collect()
    }

    pub fn pins(
        store: &Catalog,
        trail_of: Option<&str>,
        stray_areas: &HashSet<String>,
    ) -> Vec<Pin> {
        let mut pins = Vec::new();
        for c in store.clowders().unwrap_or_default() {
            if let Ok(Some((lat, lon))) = store.position_of(&c.id) {
                pins.push(Pin {
                    id: c.id.clone(),
                    lat,
                    lon,
                    label: c.name,
                    highlighted: trail_of == Some(c.id.as_str()),
                    place: true,
                });
            }
        }
        for cat in store.cats(None).unwrap_or_default() {
            if store.is_hidden(&cat.id).unwrap_or(false) {
                continue;
            }
            if let Ok(Some((lat, lon))) = store.sighting_position_of(&cat.id) {
                pins.push(Pin {
                    id: cat.id.clone(),
                    lat,
                    lon,
                    label: cat.name.clone(),
                    highlighted: trail_of == Some(cat.id.as_str()),
                    place: false,
                });
            }
            // A missing cat's flier positions carry its name too, so a
            // flier-only cat stays reachable.
            if stray_areas.contains(&cat.id) {
                for (lat, lon) in store.flier_positions(&cat.id).unwrap_or_default() {
                    pins.push(Pin {
                        id: cat.id.clone(),
                        lat,
                        lon,
                        label: cat.name.clone(),
                        highlighted: false,
                        place: false,
                    });
                }
            }
        }
        pins
    }

    fn circles(store: &Catalog, stray_areas: &HashSet<String>) -> Vec<Circle> {
        let mut circles = Vec::new();
        for cat in stray_areas {
            let mut spots = store.flier_positions(cat).unwrap_or_default();
            if let Ok(Some(home)) = store.stray_home_position(cat) {
                spots.push(home);
            }
            for (lat, lon) in spots {
                circles.push(Circle {
                    lat,
                    lon,
                    radius_meters: STRAY_AREA_RADIUS_METERS,
                });
            }
        }
        circles
    }

    /// Every position the pin's entity ever held, oldest first.
    fn trail(store: &Catalog, id: &str) -> Vec<(f64, f64)> {
        let mut points: Vec<(f64, f64)> = store
            .field_history(id, POSITION_KEY, false)
            .unwrap_or_default()
            .into_iter()
            .rev()
            .filter(|e| {
                let value = e.value.clone().unwrap_or_default();
                id.starts_with("clowder:") || parse_position_kind(&value) == PositionKind::Sighting
            })
            .filter_map(|e| parse_position(e.value.as_deref()))
            .collect();
        points.dedup();
        points
    }

    pub fn show(&mut self, ui: &mut Ui, store: &Catalog, t: &L10n) -> MapPageAction {
        let mut action = MapPageAction::None;
        if !self.loaded_viewport {
            self.loaded_viewport = true;
            match store
                .local_setting(VIEWPORT_KEY)
                .and_then(|raw| Viewport::parse(&raw))
            {
                Some(v) => self.map.viewport = v,
                None => {
                    // The first visit shows every pin; from then on the
                    // map reopens where it was left.
                    let points: Vec<(f64, f64)> = Self::pins(store, None, &self.stray_areas)
                        .iter()
                        .map(|p| (p.lat, p.lon))
                        .collect();
                    self.map.viewport = Viewport::around(&points);
                    let _ = store.set_local_setting(VIEWPORT_KEY, &self.map.viewport.encode());
                }
            }
        }
        ui.horizontal(|ui| {
            ui.heading(t.map());
            // The search box: Enter or the button jumps there.
            let edit = ui.add(
                egui::TextEdit::singleline(&mut self.query)
                    .desired_width(240.0)
                    .hint_text(t.map_search_hint()),
            );
            crate::tips::anchor(ui, "map-search", &edit);
            let entered = edit.lost_focus() && ui.input(|i| i.key_pressed(egui::Key::Enter));
            if ui.button(t.search()).clicked() || entered {
                self.search(store, t);
            }
            if let Some(note) = &self.search_note {
                ui.label(egui::RichText::new(note).weak());
            }
            let areas = ui.button(t.stray_area_label());
            crate::tips::anchor(ui, "map-layers", &areas);
            if areas.clicked() {
                self.areas_open = !self.areas_open;
            }
            if self.trail_of.is_some() && ui.button(t.trail_off()).clicked() {
                self.trail_of = None;
            }
        });
        if self.areas_open {
            let missing = Self::missing_cats(store);
            if missing.is_empty() {
                ui.label(t.no_missing_cats());
            }
            for cat in missing {
                let mut on = self.stray_areas.contains(&cat.id);
                if ui.checkbox(&mut on, &cat.name).changed() {
                    if on {
                        self.stray_areas.insert(cat.id.clone());
                    } else {
                        self.stray_areas.remove(&cat.id);
                    }
                }
            }
        }
        let pins = Self::pins(store, self.trail_of.as_deref(), &self.stray_areas);
        let circles = Self::circles(store, &self.stray_areas);
        let trail = self
            .trail_of
            .as_deref()
            .map(|id| Self::trail(store, id))
            .unwrap_or_default();
        let before = self.map.viewport;
        let size = Vec2::new(
            ui.available_width(),
            (ui.available_height() - 40.0).max(240.0),
        );
        match self.map.show(ui, size, &pins, &circles, &trail) {
            MapAction::None => {}
            MapAction::Pin(id) => {
                // A tap toggles the pin's trail; a second tap opens it.
                if self.trail_of.as_deref() == Some(id.as_str()) {
                    action = if id.starts_with("clowder:") {
                        MapPageAction::OpenClowder(id)
                    } else {
                        MapPageAction::OpenCat(id)
                    };
                } else {
                    self.trail_of = Some(id);
                }
            }
            MapAction::Click(_, _) => {}
            MapAction::SecondaryClick(lat, lon) => self.sighting_at = Some((lat, lon)),
        }
        if let Some((lat, lon)) = self.sighting_at {
            // A right-click on the map records a sighting of a Cat here.
            ui.horizontal(|ui| {
                ui.label(t.seen_here_now());
                let mut chosen: Option<String> = None;
                egui::ComboBox::from_id_salt("sighting-cat")
                    .selected_text(t.cats())
                    .show_ui(ui, |ui| {
                        for cat in store.cats(None).unwrap_or_default() {
                            if ui.selectable_label(false, &cat.name).clicked() {
                                chosen = Some(cat.id.clone());
                            }
                        }
                    });
                if let Some(id) = chosen {
                    action = MapPageAction::Sighting(id, lat, lon);
                    self.sighting_at = None;
                }
                if ui.button(t.cancel()).clicked() {
                    self.sighting_at = None;
                }
            });
        }
        if self.map.viewport != before {
            let _ = store.set_local_setting(VIEWPORT_KEY, &self.map.viewport.encode());
        }
        let _ = keys::NAME;
        action
    }
}
