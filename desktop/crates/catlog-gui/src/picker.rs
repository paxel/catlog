//! The position picker: a map, a click drops the pin, a search box finds
//! a place, OK hands back "lat,lon". Nobody types coordinates.

use std::sync::Arc;

use catlog_core::geocode::{GeoHit, Geocoder};
use catlog_core::tiles::TileCache;
use egui::{Context, Key, Vec2};

use crate::l10n::L10n;
use crate::map::{MapAction, MapView, Pin, Viewport};

pub struct PositionPicker {
    pub open: bool,
    pub map: MapView,
    pub picked: Option<(f64, f64)>,
    pub query: String,
    pub hits: Vec<GeoHit>,
    pub error: Option<String>,
    geocoder: Arc<dyn Geocoder>,
    id: u64,
}

impl PositionPicker {
    pub fn new(cache: Arc<TileCache>, geocoder: Arc<dyn Geocoder>) -> PositionPicker {
        PositionPicker {
            open: false,
            map: MapView::new(cache),
            picked: None,
            query: String::new(),
            hits: Vec::new(),
            error: None,
            geocoder,
            id: 0,
        }
    }

    /// Opens the picker at `initial` ("lat,lon"), or where the map was.
    pub fn ask(&mut self, initial: Option<&str>, viewport: Viewport) {
        self.open = true;
        self.id += 1;
        self.picked = catlog_core::entities::parse_position(initial);
        self.query.clear();
        self.hits.clear();
        self.error = None;
        self.map.viewport = match self.picked {
            Some((lat, lon)) => Viewport { lat, lon, zoom: 15 },
            None => viewport,
        };
    }

    /// Looks the query up and jumps to the first hit.
    pub fn search(&mut self) {
        let query = self.query.trim().to_string();
        if query.is_empty() {
            return;
        }
        match self.geocoder.search(&query) {
            Ok(hits) => {
                self.error = None;
                if let Some(first) = hits.first() {
                    self.jump_to(first);
                }
                self.hits = hits;
            }
            Err(e) => self.error = Some(e),
        }
    }

    fn jump_to(&mut self, hit: &GeoHit) {
        // Street zoom, or the place's own extent: a centered hit shown
        // at country zoom is useless for dropping a pin.
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
    }

    /// Draws the picker; the picked position as "lat,lon" on OK.
    pub fn show(&mut self, ctx: &Context, t: &L10n) -> Option<String> {
        if !self.open {
            return None;
        }
        let mut result = None;
        let mut close = false;
        let modal = egui::Modal::new(egui::Id::new(("position-picker", self.id))).show(ctx, |ui| {
            ui.heading(t.pick_on_map());
            ui.horizontal(|ui| {
                let edit = ui.add(
                    egui::TextEdit::singleline(&mut self.query)
                        .desired_width(320.0)
                        .hint_text(t.search_place_hint()),
                );
                let submitted = edit.lost_focus() && ui.input(|i| i.key_pressed(Key::Enter));
                if ui.button(t.search()).clicked() || submitted {
                    self.search();
                }
            });
            if let Some(e) = &self.error {
                ui.colored_label(ui.visuals().error_fg_color, e);
            }
            let mut jump: Option<GeoHit> = None;
            for hit in self.hits.iter().take(5) {
                if ui.link(&hit.name).clicked() {
                    jump = Some(hit.clone());
                }
            }
            if let Some(hit) = jump {
                self.jump_to(&hit);
            }
            let pins: Vec<Pin> = self
                .picked
                .map(|(lat, lon)| Pin {
                    id: "picked".into(),
                    lat,
                    lon,
                    label: String::new(),
                    highlighted: true,
                    place: false,
                })
                .into_iter()
                .collect();
            if let MapAction::Click(lat, lon) =
                self.map.show(ui, Vec2::new(640.0, 420.0), &pins, &[], &[])
            {
                self.picked = Some((lat, lon));
            }
            let escape = ui.input(|i| i.key_pressed(Key::Escape));
            ui.horizontal(|ui| {
                let ready = self.picked.is_some();
                if ui.add_enabled(ready, egui::Button::new(t.ok())).clicked()
                    && let Some((lat, lon)) = self.picked
                {
                    result = Some(format!("{lat},{lon}"));
                }
                if ui.button(t.cancel()).clicked() || escape {
                    close = true;
                }
            });
        });
        if result.is_some() || close || modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
        result
    }
}
