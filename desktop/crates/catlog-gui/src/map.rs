//! The map: OpenStreetMap tiles under pins and circles, drawn straight
//! into the ui. Tiles arrive from the shared fetcher's threads;
//! the view repaints as they land. North stays up; a drag pans, the
//! wheel zooms.

use std::collections::HashMap;
use std::sync::Arc;

use catlog_core::geo::{lat_lon_of, meters_per_pixel, tile_xy};
use catlog_core::tiles::{TileFetcher, TileId};
use egui::{Color32, Context, Pos2, Rect, Sense, Stroke, TextureHandle, TextureOptions, Ui, Vec2};

/// Tiles are 256 pixels; the zoom stays between these.
pub const TILE_SIZE: f32 = 256.0;
pub const MIN_ZOOM: u32 = 2;
/// The deepest level the tiles are served at; a street corner needs it.
pub const MAX_ZOOM: u32 = 19;

/// How much wheel a zoom level costs. A level is a doubling, so a brush
/// of the wheel must not spend one: three ticks used to reach the whole
/// world from a city.
const WHEEL_PER_STEP: f32 = 40.0;

/// Where the map opens when nothing was remembered: Central Europe.
pub const DEFAULT_CENTER: (f64, f64) = (51.0, 10.0);
pub const DEFAULT_ZOOM: u32 = 6;

/// How many tile textures stay in graphics memory. One is 256 by 256
/// in RGBA, a quarter of a megabyte; this covers several screens of
/// panning and stops the memory from growing all session.
const MAX_TEXTURES: usize = 256;

/// How many zoom levels a turn of the wheel has now earned. What is
/// left over waits for the next turn; turning the other way drops it.
fn wheel_steps(turned: &mut f32, scroll: f32) -> i32 {
    if turned.signum() != scroll.signum() {
        *turned = 0.0;
    }
    *turned += scroll;
    let steps = (*turned / WHEEL_PER_STEP).trunc() as i32;
    *turned -= steps as f32 * WHEEL_PER_STEP;
    steps
}

/// The view a box drawn on the map asks for: its middle, and the
/// deepest zoom that still holds it. A box too small to have been meant
/// leaves the view as it was.
fn band_viewport(from: Viewport, rect: Rect, a: Pos2, b: Pos2) -> Viewport {
    let box_rect = Rect::from_two_pos(a, b);
    if box_rect.width() < 12.0 || box_rect.height() < 12.0 {
        return from;
    }
    let at = |p: Pos2| -> (f64, f64) {
        let (cx, cy) = tile_xy(from.lat, from.lon, from.zoom);
        let d = p - rect.center();
        lat_lon_of(
            cx + d.x as f64 / TILE_SIZE as f64,
            cy + d.y as f64 / TILE_SIZE as f64,
            from.zoom,
        )
    };
    let (one, two) = (at(box_rect.min), at(box_rect.max));
    let lat = (one.0 + two.0) / 2.0;
    let lon = (one.1 + two.1) / 2.0;
    // How many doublings the box is away from filling the view.
    let wider = (rect.width() / box_rect.width()).max(rect.height() / box_rect.height());
    let closer = wider.log2().floor().max(0.0) as u32;
    Viewport {
        lat,
        lon,
        zoom: (from.zoom + closer).min(MAX_ZOOM),
    }
}

/// A texture and when the view last drew it.
struct Kept {
    texture: Option<TextureHandle>,
    used: u64,
}

/// The tiles one view draws: textures it already made, and wishes it
/// hands to the shared [`TileFetcher`]. The bytes themselves live in
/// the disk cache, so two views never fetch the same tile twice.
pub struct TileLoader {
    fetcher: Arc<TileFetcher>,
    textures: HashMap<TileId, Kept>,
    tick: u64,
}

impl TileLoader {
    pub fn new(fetcher: Arc<TileFetcher>) -> TileLoader {
        TileLoader {
            fetcher,
            textures: HashMap::new(),
            tick: 0,
        }
    }

    /// The texture of a tile, or none while it is on its way or failed.
    /// A tile already on disk is decoded here; the rest are asked for
    /// and appear on a later frame.
    pub fn tile(&mut self, ctx: &Context, id: TileId) -> Option<TextureHandle> {
        self.tick += 1;
        if let Some(kept) = self.textures.get_mut(&id) {
            kept.used = self.tick;
            return kept.texture.clone();
        }
        if self.fetcher.failed(id) {
            return None;
        }
        if let Some(bytes) = self.fetcher.cache().cached(id) {
            return self.keep(ctx, id, &bytes);
        }
        self.fetcher.want(id);
        // A fetcher without threads filled the cache just now, so the
        // tile is on screen in this same frame.
        let bytes = self.fetcher.cache().cached(id)?;
        self.keep(ctx, id, &bytes)
    }

    /// Whether any tile this view wants is still on its way.
    pub fn busy(&self) -> bool {
        self.fetcher.busy()
    }

    /// Tiles that failed may be asked for again, after the network came
    /// back.
    pub fn retry_failed(&mut self) {
        self.fetcher.retry_failed();
    }

    fn keep(&mut self, ctx: &Context, id: TileId, bytes: &[u8]) -> Option<TextureHandle> {
        let texture = decode(ctx, id, bytes);
        self.textures.insert(
            id,
            Kept {
                texture: texture.clone(),
                used: self.tick,
            },
        );
        self.forget_oldest();
        texture
    }

    /// Drops the textures drawn longest ago, back to the cap.
    fn forget_oldest(&mut self) {
        if self.textures.len() <= MAX_TEXTURES {
            return;
        }
        let mut used: Vec<u64> = self.textures.values().map(|k| k.used).collect();
        used.sort_unstable();
        let cutoff = used[self.textures.len() - MAX_TEXTURES - 1];
        self.textures.retain(|_, kept| kept.used > cutoff);
    }
}

fn decode(ctx: &Context, id: TileId, bytes: &[u8]) -> Option<TextureHandle> {
    let img = image::load_from_memory(bytes).ok()?.to_rgba8();
    let size = [img.width() as usize, img.height() as usize];
    let image = egui::ColorImage::from_rgba_unmultiplied(size, img.as_raw());
    Some(ctx.load_texture(
        format!("tile-{}-{}-{}", id.z, id.x, id.y),
        image,
        TextureOptions::LINEAR,
    ))
}

/// A pin on the map.
#[derive(Debug, Clone, PartialEq)]
pub struct Pin {
    pub id: String,
    pub lat: f64,
    pub lon: f64,
    pub label: String,
    pub highlighted: bool,
    /// A Clowder's pin wears the accent colour.
    pub place: bool,
}

/// A 500 m circle around a position.
#[derive(Debug, Clone, PartialEq)]
pub struct Circle {
    pub lat: f64,
    pub lon: f64,
    pub radius_meters: f64,
}

/// What the keeper did on the map this frame.
#[derive(Debug, Clone, PartialEq)]
pub enum MapAction {
    None,
    /// A pin was clicked.
    Pin(String),
    /// The map was clicked away from any pin, at this position.
    Click(f64, f64),
    /// The map was right-clicked at this position.
    SecondaryClick(f64, f64),
}

/// The viewport: where the map looks and how close.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Viewport {
    pub lat: f64,
    pub lon: f64,
    pub zoom: u32,
}

impl Default for Viewport {
    fn default() -> Self {
        Viewport {
            lat: DEFAULT_CENTER.0,
            lon: DEFAULT_CENTER.1,
            zoom: DEFAULT_ZOOM,
        }
    }
}

impl Viewport {
    /// The stored form: `lat,lon,zoom`.
    pub fn encode(&self) -> String {
        format!("{},{},{}", self.lat, self.lon, self.zoom)
    }

    pub fn parse(raw: &str) -> Option<Viewport> {
        let mut parts = raw.split(',');
        let lat: f64 = parts.next()?.trim().parse().ok()?;
        let lon: f64 = parts.next()?.trim().parse().ok()?;
        let zoom: u32 = parts.next()?.trim().parse::<f64>().ok()?.round() as u32;
        Some(Viewport {
            lat,
            lon,
            zoom: zoom.clamp(MIN_ZOOM, MAX_ZOOM),
        })
    }

    /// A viewport that shows every given position, or the default.
    pub fn around(points: &[(f64, f64)]) -> Viewport {
        if points.is_empty() {
            return Viewport::default();
        }
        let lat = points.iter().map(|p| p.0).sum::<f64>() / points.len() as f64;
        let lon = points.iter().map(|p| p.1).sum::<f64>() / points.len() as f64;
        let spread = points
            .iter()
            .map(|p| (p.0 - lat).abs().max((p.1 - lon).abs()))
            .fold(0.0, f64::max);
        let zoom = if spread < 0.01 {
            15
        } else if spread < 0.05 {
            13
        } else if spread < 0.3 {
            11
        } else if spread < 1.0 {
            9
        } else {
            6
        };
        Viewport { lat, lon, zoom }
    }
}

/// The map view: a viewport, and what it draws.
pub struct MapView {
    pub viewport: Viewport,
    pub loader: TileLoader,
    /// Wheel gathered since the last zoom level it paid for.
    turned: f32,
    /// The box being drawn with Shift held: where it started and where
    /// the hand is now.
    band: Option<(Pos2, Pos2)>,
}

impl MapView {
    pub fn new(fetcher: Arc<TileFetcher>) -> MapView {
        MapView {
            viewport: Viewport::default(),
            loader: TileLoader::new(fetcher),
            turned: 0.0,
            band: None,
        }
    }

    /// The pixel of a position, given the map rect.
    fn project(&self, rect: Rect, lat: f64, lon: f64) -> Pos2 {
        let (cx, cy) = tile_xy(self.viewport.lat, self.viewport.lon, self.viewport.zoom);
        let (x, y) = tile_xy(lat, lon, self.viewport.zoom);
        rect.center()
            + Vec2::new(
                ((x - cx) * TILE_SIZE as f64) as f32,
                ((y - cy) * TILE_SIZE as f64) as f32,
            )
    }

    /// The position under a pixel, given the map rect.
    fn unproject(&self, rect: Rect, pos: Pos2) -> (f64, f64) {
        let (cx, cy) = tile_xy(self.viewport.lat, self.viewport.lon, self.viewport.zoom);
        let d = pos - rect.center();
        lat_lon_of(
            cx + d.x as f64 / TILE_SIZE as f64,
            cy + d.y as f64 / TILE_SIZE as f64,
            self.viewport.zoom,
        )
    }

    /// Draws the map `size` large with the given pins, circles and
    /// trail; says what the keeper did.
    pub fn show(
        &mut self,
        ui: &mut Ui,
        size: Vec2,
        pins: &[Pin],
        circles: &[Circle],
        trail: &[(f64, f64)],
    ) -> MapAction {
        let (rect, response) = ui.allocate_exact_size(size, Sense::click_and_drag());
        let ctx = ui.ctx().clone();
        let mut action = MapAction::None;
        // Shift and drag draws a box to zoom into; a plain drag pans.
        let shift = ui.input(|i| i.modifiers.shift);
        if response.drag_started() && shift {
            self.band = response.interact_pointer_pos().map(|p| (p, p));
        }
        if let Some((_, to)) = self.band.as_mut()
            && let Some(now) = response.interact_pointer_pos()
        {
            *to = now;
        }
        if response.drag_stopped()
            && let Some((a, b)) = self.band.take()
        {
            self.viewport = band_viewport(self.viewport, rect, a, b);
        }
        // Pan by drag, zoom by wheel, both around the pointer.
        if response.dragged() && self.band.is_none() {
            let d = response.drag_delta();
            let (cx, cy) = tile_xy(self.viewport.lat, self.viewport.lon, self.viewport.zoom);
            let (lat, lon) = lat_lon_of(
                cx - d.x as f64 / TILE_SIZE as f64,
                cy - d.y as f64 / TILE_SIZE as f64,
                self.viewport.zoom,
            );
            self.viewport.lat = lat.clamp(-85.0, 85.0);
            self.viewport.lon = lon;
        }
        let scroll = ui.input(|i| i.smooth_scroll_delta.y);
        if response.hovered() && scroll != 0.0 {
            let steps = wheel_steps(&mut self.turned, scroll);
            if steps != 0 {
                let z = self.viewport.zoom as i64 + steps as i64;
                self.viewport.zoom = (z.max(MIN_ZOOM as i64) as u32).min(MAX_ZOOM);
            }
        }
        let painter = ui.painter_at(rect);
        painter.rect_filled(rect, 0.0, Color32::from_gray(235));
        // The tiles under the view.
        let zoom = self.viewport.zoom;
        let n = 2u32.pow(zoom);
        let (cx, cy) = tile_xy(self.viewport.lat, self.viewport.lon, zoom);
        let cols = (rect.width() / TILE_SIZE / 2.0).ceil() as i64 + 1;
        let rows = (rect.height() / TILE_SIZE / 2.0).ceil() as i64 + 1;
        for dy in -rows..=rows {
            for dx in -cols..=cols {
                let tx = cx.floor() as i64 + dx;
                let ty = cy.floor() as i64 + dy;
                if ty < 0 || ty >= n as i64 {
                    continue;
                }
                let wrapped = tx.rem_euclid(n as i64) as u32;
                let id = TileId {
                    z: zoom,
                    x: wrapped,
                    y: ty as u32,
                };
                let min = rect.center()
                    + Vec2::new(
                        ((tx as f64 - cx) * TILE_SIZE as f64) as f32,
                        ((ty as f64 - cy) * TILE_SIZE as f64) as f32,
                    );
                let tile_rect = Rect::from_min_size(min, Vec2::splat(TILE_SIZE));
                if !tile_rect.intersects(rect) {
                    continue;
                }
                match self.loader.tile(&ctx, id) {
                    Some(texture) => {
                        painter.image(
                            texture.id(),
                            tile_rect,
                            Rect::from_min_max(Pos2::ZERO, Pos2::new(1.0, 1.0)),
                            Color32::WHITE,
                        );
                    }
                    None => {
                        painter.rect_stroke(
                            tile_rect,
                            0.0,
                            Stroke::new(0.5, Color32::from_gray(210)),
                            egui::StrokeKind::Inside,
                        );
                    }
                }
            }
        }
        if let Some((a, b)) = self.band {
            let box_rect = Rect::from_two_pos(a, b);
            painter.rect_filled(box_rect, 2.0, Color32::from_black_alpha(20));
            painter.rect_stroke(
                box_rect,
                2.0,
                Stroke::new(1.5, crate::theme::PALETTE.orange),
                egui::StrokeKind::Inside,
            );
        }
        // Circles, then the trail, then the pins, so pins stay clickable.
        for c in circles {
            let center = self.project(rect, c.lat, c.lon);
            let radius = (c.radius_meters / meters_per_pixel(c.lat, zoom)) as f32;
            painter.circle(
                center,
                radius,
                Color32::from_rgba_unmultiplied(255, 140, 0, 46),
                Stroke::new(2.0, Color32::from_rgb(230, 90, 40)),
            );
        }
        if trail.len() > 1 {
            let points: Vec<Pos2> = trail
                .iter()
                .map(|(lat, lon)| self.project(rect, *lat, *lon))
                .collect();
            painter.add(egui::Shape::line(
                points,
                Stroke::new(3.0, Color32::from_rgb(230, 60, 60)),
            ));
        }
        let pointer = response.interact_pointer_pos();
        let mut hit: Option<String> = None;
        for pin in pins {
            let at = self.project(rect, pin.lat, pin.lon);
            if !rect.contains(at) {
                continue;
            }
            let color = if pin.place {
                Color32::from_rgb(40, 100, 200)
            } else if pin.highlighted {
                Color32::from_rgb(230, 60, 60)
            } else {
                Color32::from_rgb(60, 60, 60)
            };
            painter.circle(at, 8.0, color, Stroke::new(2.0, Color32::WHITE));
            let galley = painter.layout_no_wrap(
                pin.label.clone(),
                egui::FontId::proportional(12.0),
                Color32::BLACK,
            );
            let label_rect = Rect::from_min_size(
                at + Vec2::new(10.0, -8.0),
                galley.size() + Vec2::new(6.0, 2.0),
            );
            painter.rect_filled(
                label_rect,
                3.0,
                Color32::from_rgba_unmultiplied(255, 255, 255, 220),
            );
            painter.galley(label_rect.min + Vec2::new(3.0, 1.0), galley, Color32::BLACK);
            if let Some(p) = pointer
                && (p.distance(at) <= 10.0 || label_rect.contains(p))
            {
                hit = Some(pin.id.clone());
            }
        }
        if response.clicked() {
            action = match hit {
                Some(id) => MapAction::Pin(id),
                None => {
                    let p = pointer.unwrap_or(rect.center());
                    let (lat, lon) = self.unproject(rect, p);
                    MapAction::Click(lat, lon)
                }
            };
        } else if response.secondary_clicked() {
            let p = pointer.unwrap_or(rect.center());
            let (lat, lon) = self.unproject(rect, p);
            action = MapAction::SecondaryClick(lat, lon);
        }
        // OSM asks for its credit on every map.
        let credit = "© OpenStreetMap contributors";
        let galley = painter.layout_no_wrap(
            credit.to_string(),
            egui::FontId::proportional(11.0),
            Color32::from_gray(60),
        );
        let credit_rect = Rect::from_min_size(
            rect.right_bottom() - galley.size() - Vec2::new(6.0, 2.0),
            galley.size() + Vec2::new(4.0, 2.0),
        );
        painter.rect_filled(
            credit_rect,
            0.0,
            Color32::from_rgba_unmultiplied(255, 255, 255, 200),
        );
        painter.galley(
            credit_rect.min + Vec2::new(2.0, 0.0),
            galley,
            Color32::from_gray(60),
        );
        if self.loader.busy() {
            ctx.request_repaint_after(std::time::Duration::from_millis(200));
        }
        action
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn viewports_round_trip_and_fit_their_points() {
        let v = Viewport {
            lat: 51.34,
            lon: 12.37,
            zoom: 12,
        };
        assert_eq!(Viewport::parse(&v.encode()), Some(v));
        assert_eq!(Viewport::parse("1,2,99").unwrap().zoom, MAX_ZOOM);
        assert_eq!(Viewport::parse("junk"), None);
        assert_eq!(Viewport::parse("1,2"), None);
        assert_eq!(Viewport::around(&[]), Viewport::default());
        assert_eq!(Viewport::around(&[(51.34, 12.37)]).zoom, 15);
        let two = Viewport::around(&[(51.0, 12.0), (52.0, 13.0)]);
        assert!((two.lat - 51.5).abs() < 1e-9 && two.zoom == 9);
        assert_eq!(Viewport::around(&[(51.0, 12.0), (51.02, 12.0)]).zoom, 13);
        assert_eq!(Viewport::around(&[(51.0, 12.0), (51.2, 12.0)]).zoom, 11);
        assert_eq!(Viewport::around(&[(51.0, 12.0), (55.0, 12.0)]).zoom, 6);
    }

    #[test]
    fn the_wheel_gathers_before_it_steps_a_zoom_level() {
        // A brush of the wheel is no zoom: it gathers and waits.
        let mut turned = 0.0;
        assert_eq!(wheel_steps(&mut turned, 8.0), 0);
        assert_eq!(turned, 8.0);
        // Enough of a turn steps one level and keeps the rest.
        assert_eq!(wheel_steps(&mut turned, 40.0), 1);
        assert!(turned.abs() < WHEEL_PER_STEP);
        // The other way round, and a hard flick steps more than one.
        turned = 0.0;
        assert_eq!(wheel_steps(&mut turned, -120.0), -3);
        // A turn the other way drops what was gathered.
        turned = 0.0;
        assert_eq!(wheel_steps(&mut turned, 30.0), 0);
        assert_eq!(wheel_steps(&mut turned, -30.0), 0);
        assert_eq!(turned, -30.0);
    }

    #[test]
    fn a_box_drawn_on_the_map_becomes_the_view() {
        let rect = Rect::from_min_size(Pos2::ZERO, Vec2::new(512.0, 512.0));
        let from = Viewport {
            lat: 51.34,
            lon: 12.37,
            zoom: 10,
        };
        // A box around the middle: the view centres on it and goes closer.
        let to = band_viewport(from, rect, Pos2::new(200.0, 200.0), Pos2::new(312.0, 312.0));
        assert!(to.zoom > from.zoom, "a small box means a closer look");
        assert!((to.lat - from.lat).abs() < 0.2 && (to.lon - from.lon).abs() < 0.2);
        // A box in one corner moves the view there.
        let corner = band_viewport(from, rect, Pos2::new(20.0, 20.0), Pos2::new(60.0, 60.0));
        assert!(corner.lat > from.lat && corner.lon < from.lon);
        // A box too small to mean anything leaves the view alone.
        assert_eq!(
            band_viewport(from, rect, Pos2::new(20.0, 20.0), Pos2::new(23.0, 22.0)),
            from
        );
    }

    #[test]
    fn the_zoom_reaches_what_the_tiles_have() {
        assert_eq!(MAX_ZOOM, 19);
    }
}
