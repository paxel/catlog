//! The desk: every opened Cat as its index card, side by side and
//! dragged into place, found there again next time. A card shows what
//! the printed Card shows, from the same field selector; the pen on a
//! row opens the editor, which is the one place a value is changed.

use std::collections::{BTreeMap, BTreeSet};

use catlog_core::fields::{FieldDef, FieldScope, FieldType, IdDisplay};
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, keys};
use egui::{Id, Pos2, Rect, Ui, Vec2};

use crate::chores::ChoreAction;
use crate::documents_page::{DocKind, PHOTO_KEY, card_keys};
use crate::icons;
use crate::l10n::L10n;
use crate::labels::{field_def_name, field_value_display, value_label};
use crate::pages::PageAction;
use crate::textures::FaceCache;
use crate::theme::{PALETTE, ROUNDING};

/// The local setting naming which kind of card the desk shows.
pub const FILTER_KEY: &str = "cards:filter";
/// The local setting naming the open cards, comma-separated.
pub const OPEN_KEY: &str = "cards:open";
/// The local setting naming the Fields a Clowder's card shows. A Cat's
/// card follows the printed Card's selector; a Clowder has no printed
/// Card, so it keeps its own.
pub const CLOWDER_FIELDS_KEY: &str = "clowderCardFields";
/// A card's width on the desk.
pub const CARD_WIDTH: f32 = 320.0;

/// The strip the dock floats in, kept clear when cards are laid out.
const DOCK_STRIP: f32 = 96.0;

/// A Field row's two columns: the name, then the value with the pen and
/// the ⋮ beside it. Both are measured so that a row fills the card.
const NAME_WIDTH: f32 = 104.0;
/// How close the little map on a location row stands: a street, not a
/// house, so one tile holds it whatever the place.
const PLACE_ZOOM: u32 = 15;
const VALUE_WIDTH: f32 = CARD_WIDTH - NAME_WIDTH - 12.0 - 56.0;

fn pos_key(id: &str) -> String {
    format!("card:{id}")
}

fn height_key(id: &str) -> String {
    format!("card:h:{id}")
}

/// What the keeper did on the desk this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CardAction {
    None,
    Page(PageAction),
    /// The whole page in a modal: photos, chores, plans, family.
    OpenPage(String),
    /// Everything that ever happened to this one, in a modal.
    OpenTimeline(String),
    /// Every Cat living in this Clowder, laid on the desk and tiled.
    OpenAllIn(String),
    /// Something went wrong storing a value.
    Notice(String),
    /// A cat's card opened from a Clowder's card.
    Opened(String),
}

/// The desk: the open cards and their places.
#[derive(Default)]
pub struct Desk {
    /// The tiles a location row draws its picture from, shared with the
    /// map's own loader through the fetcher beneath it.
    tiles: Option<crate::map::TileLoader>,
    pub open: Vec<String>,
    /// Places relative to the desk's top left corner.
    positions: BTreeMap<String, Pos2>,
    loaded: bool,
    /// The card just opened, brought to the front once.
    raise: Option<String>,
    /// The desk as last drawn, so new cards land where there is room.
    desk_size: Vec2,
    /// Counts the openings, so a card laid down again fades in again.
    opened: u32,
    /// Which kind of card is in sight; the others stay open, unseen.
    filter: Option<bool>,
    /// The height one tiled card may take, while the cards lie tiled.
    cell: Option<f32>,
    /// Set by Stack: lay the cards' layers in the cascade's order on the
    /// next frame, the first card at the back.
    restack: bool,
    /// A card's own height, when a hand has dragged it.
    heights: BTreeMap<String, f32>,
}

impl Desk {
    /// A desk that can draw the little map on a location row.
    pub fn with_tiles(fetcher: std::sync::Arc<catlog_core::tiles::TileFetcher>) -> Desk {
        Desk {
            tiles: Some(crate::map::TileLoader::new(fetcher)),
            ..Desk::default()
        }
    }

    /// Forgets what was loaded, for another Catalog. The tiles stay:
    /// they belong to the machine, not to the Catalog.
    pub fn reset(&mut self) {
        let tiles = self.tiles.take();
        *self = Desk::default();
        self.tiles = tiles;
    }

    /// Reads the open set and the places once per Catalog.
    pub fn load(&mut self, store: &Catalog) {
        if self.loaded {
            return;
        }
        self.loaded = true;
        self.filter = match store.local_setting(FILTER_KEY).as_deref() {
            Some("cat") => Some(true),
            Some("clowder") => Some(false),
            _ => None,
        };
        self.open = store
            .local_setting(OPEN_KEY)
            .unwrap_or_default()
            .split(',')
            .filter(|s| !s.is_empty())
            .map(String::from)
            .collect();
        for id in &self.open {
            if let Some(saved) = store.local_setting(&height_key(id))
                && let Ok(height) = saved.parse::<f32>()
            {
                self.heights.insert(id.clone(), height);
            }
            if let Some(saved) = store.local_setting(&pos_key(id))
                && let Some((x, y)) = saved.split_once(',')
                && let (Ok(x), Ok(y)) = (x.parse::<f32>(), y.parse::<f32>())
            {
                self.positions.insert(id.clone(), Pos2::new(x, y));
            }
        }
    }

    fn save_open(&self, store: &Catalog) {
        let _ = store.set_local_setting(OPEN_KEY, &self.open.join(","));
    }

    /// Lays `ids` on the desk, the new ones beside the last card.
    pub fn open(&mut self, store: &Catalog, ids: &[String]) {
        self.load(store);
        for id in ids {
            if !self.open.contains(id) {
                let place = self.free_place();
                self.positions.entry(id.clone()).or_insert(place);
                self.open.push(id.clone());
                let pos = self.positions[id];
                let _ = store.set_local_setting(&pos_key(id), &format!("{},{}", pos.x, pos.y));
            }
            self.raise = Some(id.clone());
            self.opened += 1;
        }
        self.save_open(store);
    }

    /// The next place with room: right of the last card, else a new row.
    fn free_place(&self) -> Pos2 {
        let step = CARD_WIDTH + 42.0;
        // Before the desk was ever drawn its width is unknown: side by side.
        let width = if self.desk_size.x < CARD_WIDTH {
            f32::INFINITY
        } else {
            self.desk_size.x
        };
        let per_row = ((width - 16.0) / step).floor().clamp(1.0, 64.0) as usize;
        let n = self.open.len();
        let (col, row) = (n % per_row, n / per_row);
        Pos2::new(16.0 + col as f32 * step, 16.0 + row as f32 * 48.0)
    }

    pub fn close(&mut self, store: &Catalog, id: &str) {
        self.load(store);
        self.open.retain(|o| o != id);
        self.save_open(store);
    }

    /// The desk as last drawn, for a test that asks whether a card
    /// landed where it can be seen.
    pub fn size(&self) -> Vec2 {
        self.desk_size
    }

    /// Where a card lies, relative to the desk.
    pub fn position(&self, id: &str) -> Option<Pos2> {
        self.positions.get(id).copied()
    }

    /// Draws every open card into `desk`, the pane's rect; says what the
    /// keeper did.
    #[allow(clippy::too_many_arguments)]
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &mut Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        units: UnitSystem,
        desk: Rect,
    ) -> CardAction {
        self.load(store);
        self.desk_size = desk.size();
        let mut action = CardAction::None;
        let ctx = ui.ctx().clone();
        let defs: Vec<FieldDef> = store.field_defs(Some(FieldScope::Cat)).unwrap_or_default();
        let chosen = card_keys(store);
        let raise = self.raise.take();
        let restack = std::mem::take(&mut self.restack);
        let mut closing: Option<String> = None;
        let mut opening: Option<String> = None;
        let mut moved: Vec<(String, Pos2, bool)> = Vec::new();
        let mut dragged: Option<(String, f32)> = None;
        let mut settled: Option<String> = None;
        for id in self.open.clone() {
            if self
                .filter
                .is_some_and(|cats| cats != id.starts_with("cat:"))
            {
                continue;
            }
            let rel = self
                .positions
                .get(&id)
                .copied()
                .unwrap_or(Pos2::new(16.0, 16.0));
            let area_id = Id::new(("card", id.as_str()));
            // The card keeps its place relative to the desk; a drag moves
            // it and the end of the drag is what gets remembered. The
            // first frame constrains by the default size, so it is told.
            // A card just laid down fades in and slides the last bit up.
            let fade = crate::motion::fade_in(&ctx, ("card", id.as_str(), self.opened));
            let slide = Vec2::new(0.0, (1.0 - fade) * 16.0);
            let area = egui::Area::new(area_id)
                .movable(true)
                .constrain_to(desk)
                // The body's scroller reads the room the area offers, so
                // the area is told it may be as tall as a card may grow.
                .default_size(Vec2::new(
                    CARD_WIDTH + 26.0,
                    self.body_height(&id, desk.height()) + 48.0,
                ))
                .current_pos(desk.min + rel.to_vec2() + slide);
            if restack || raise.as_deref() == Some(id.as_str()) {
                // In the open set's order, so the last card laid down in
                // the cascade ends up in front of the ones above it.
                ctx.move_to_top(egui::LayerId::new(egui::Order::Middle, area_id));
            }
            let out = area.show(&ctx, |ui| {
                ui.set_opacity(fade);
                egui::Frame::new()
                    .fill(PALETTE.paper)
                    // Darker than the title bar, or the card's top edge
                    // would vanish into it.
                    .stroke(egui::Stroke::new(1.0, PALETTE.grey))
                    .corner_radius(ROUNDING + 4)
                    .shadow(egui::epaint::Shadow {
                        offset: [0, 4],
                        blur: 12,
                        spread: 0,
                        color: egui::Color32::from_black_alpha(28),
                    })
                    .inner_margin(0.0)
                    .show(ui, |ui| {
                        ui.set_width(CARD_WIDTH + 24.0);
                        let mut a = self.title_bar(ui, store, t, &id, &defs, &chosen);
                        // A card never grows past the desk: what does not
                        // fit under the cap scrolls inside the card, so a
                        // record with ten long values is still a card a
                        // hand can move.
                        // A scrollbar that takes width would make the rows
                        // end before the title bar does; this one floats
                        // over them, so the card stays one shape. It is
                        // always as visible as it gets: a bar that fades
                        // in and out asks for a repaint forever.
                        ui.style_mut().spacing.scroll = egui::style::ScrollStyle {
                            floating: true,
                            floating_allocated_width: 0.0,
                            dormant_background_opacity: 0.0,
                            dormant_handle_opacity: 0.0,
                            ..egui::style::ScrollStyle::floating()
                        };
                        egui::ScrollArea::vertical()
                            .id_salt(("card-body", id.as_str()))
                            // Whether the bar is there must not change the
                            // layout, or the card flickers between two
                            // sizes and asks for a repaint forever.
                            .scroll_bar_visibility(
                                egui::scroll_area::ScrollBarVisibility::AlwaysVisible,
                            )
                            .max_height(self.body_height(&id, desk.height()))
                            .auto_shrink([false, true])
                            .show(ui, |ui| {
                                egui::Frame::new().inner_margin(12.0).show(ui, |ui| {
                                    ui.set_width(CARD_WIDTH);
                                    let b =
                                        self.card(ui, store, t, faces, units, &id, &defs, &chosen);
                                    if b != CardEvent::None {
                                        a = b;
                                    }
                                });
                            });
                        // The bottom edge is a handle: a card that was
                        // made small can be made big again.
                        let (handle, drag) = ui.allocate_exact_size(
                            Vec2::new(CARD_WIDTH + 24.0, 8.0),
                            egui::Sense::drag(),
                        );
                        if ui.is_rect_visible(handle) {
                            let grip =
                                egui::Rect::from_center_size(handle.center(), Vec2::new(36.0, 3.0));
                            ui.painter().rect_filled(grip, 1.5, PALETTE.tan);
                        }
                        let drag = drag
                            .on_hover_cursor(egui::CursorIcon::ResizeVertical)
                            .on_hover_text(t.card_height());
                        let words = t.card_height().to_string();
                        drag.widget_info(|| {
                            egui::WidgetInfo::labeled(egui::WidgetType::Other, true, &words)
                        });
                        if drag.dragged() {
                            dragged = Some((id.clone(), drag.drag_delta().y));
                        }
                        if drag.drag_stopped() {
                            settled = Some(id.clone());
                        }
                        match a {
                            CardEvent::None => {}
                            CardEvent::Close => closing = Some(id.clone()),
                            CardEvent::Action(a) => action = a,
                            CardEvent::OpenCard(cat) => opening = Some(cat),
                        }
                    });
            });
            if out.response.dragged() || out.response.drag_stopped() {
                let now = out.response.rect.min - desk.min;
                let now = Pos2::new(now.x.round().max(0.0), now.y.round().max(0.0));
                moved.push((id.clone(), now, out.response.drag_stopped()));
            }
        }
        if let Some((id, by)) = dragged {
            let cap = body_cap(desk.height());
            let now = self.body_height(&id, desk.height()) + by;
            self.heights.insert(id, now.clamp(80.0, cap));
        }
        if let Some(id) = settled
            && let Some(height) = self.heights.get(&id)
        {
            let _ = store.set_local_setting(&height_key(&id), &format!("{height}"));
        }
        for (id, pos, done) in moved {
            self.positions.insert(id.clone(), pos);
            if done {
                let _ = store.set_local_setting(&pos_key(&id), &format!("{},{}", pos.x, pos.y));
            }
        }
        if let Some(id) = closing {
            self.close(store, &id);
        }
        if let Some(cat) = opening {
            self.open(store, std::slice::from_ref(&cat));
            action = CardAction::Opened(cat);
        }
        if !self.open.is_empty() {
            self.dock(&ctx, store, t, faces, desk);
        }
        action
    }

    /// How tall a card's body may be: the desk's cap, or the tile's
    /// cell while the cards lie tiled.
    fn body_height(&self, id: &str, desk_height: f32) -> f32 {
        let cap = body_cap(desk_height);
        match (self.cell, self.heights.get(id)) {
            // While the cards lie tiled, the cell decides.
            (Some(cell), _) => cap.min((cell - 56.0).max(80.0)),
            (None, Some(own)) => own.min(cap),
            (None, None) => cap,
        }
    }

    /// The layer a card is drawn on.
    fn layer(id: &str) -> egui::LayerId {
        egui::LayerId::new(egui::Order::Middle, Id::new(("card", id)))
    }

    /// The card on top of the pile, as egui last stacked them.
    pub fn front(&self, ctx: &egui::Context) -> Option<String> {
        let top = ctx.memory(|m| m.areas().top_layer_id(egui::Order::Middle))?;
        self.open.iter().find(|id| Self::layer(id) == top).cloned()
    }

    /// Lays a card down, never past the desk's edge: egui clamps a card
    /// that hangs over it, and a clamped card cannot be dragged at all.
    /// On a desk too small for the grid, cards share a place rather
    /// than leave the room.
    fn place(&mut self, store: &Catalog, id: &str, pos: Pos2) {
        let seen = 120.0;
        let max = Pos2::new(
            (self.desk_size.x - seen).max(0.0),
            (self.desk_size.y - DOCK_STRIP - 48.0).max(0.0),
        );
        let pos = Pos2::new(pos.x.clamp(0.0, max.x), pos.y.clamp(0.0, max.y));
        self.positions.insert(id.to_string(), pos);
        let _ = store.set_local_setting(&pos_key(id), &format!("{},{}", pos.x, pos.y));
    }

    /// Tile: a grid from the top left in opening order, every card in
    /// sight and none overlapping. The rows share the height that is
    /// left once the dock has its strip, so the bodies scroll rather
    /// than run off the desk.
    pub fn tile(&mut self, store: &Catalog) {
        // Whatever a card holds, it fits its cell from now on and
        // scrolls inside it, so no card is laid out of reach.
        let gap = 16.0;
        let step = CARD_WIDTH + 24.0 + gap;
        let width = self.desk_size.x.max(step);
        let columns = (((width - gap) / step).floor() as usize).clamp(1, 16);
        let rows = self.open.len().div_ceil(columns).max(1);
        let usable = (self.desk_size.y - DOCK_STRIP).max(160.0);
        let row_height = ((usable - gap) / rows as f32 - gap).max(120.0);
        self.cell = Some(row_height);
        for (i, id) in self.open.clone().iter().enumerate() {
            let (column, row) = (i % columns, i / columns);
            let x = gap + column as f32 * step;
            let y = gap + row as f32 * (row_height + gap);
            self.place(store, id, Pos2::new(x, y));
        }
    }

    /// Stack: a cascade from the top left, each card a step down and
    /// right of the one before, the last opened on top.
    pub fn stack(&mut self, ctx: &egui::Context, store: &Catalog) {
        // A stacked card is as tall as it likes again.
        self.cell = None;
        for (i, id) in self.open.clone().iter().enumerate() {
            let step = 16.0 + i as f32 * 24.0;
            self.place(store, id, Pos2::new(step, step));
            ctx.memory_mut(|m| m.areas_mut().move_to_top(Self::layer(id)));
        }
        // The order is set again while the cards are drawn: a card that
        // was not on top of the pile before keeps egui's old order
        // otherwise, and the pile reads neither front to back nor back
        // to front.
        self.restack = true;
    }

    /// Close all: the desk is bare; the table is where they come back from.
    pub fn close_all(&mut self, store: &Catalog) {
        self.open.clear();
        self.save_open(store);
    }

    /// The dock: a float at the bottom of the desk with Tile, Stack and
    /// Close all, then one face per open card; a click on a face brings
    /// that card to the front. The front card wears a dot.
    fn dock(
        &mut self,
        ctx: &egui::Context,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        desk: Rect,
    ) {
        let front = self.front(ctx);
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        let screen = ctx.content_rect();
        let offset = Vec2::new(
            desk.center().x - screen.center().x,
            desk.max.y - screen.max.y - 12.0,
        );
        let mut tile = false;
        let mut filter: Option<Option<bool>> = None;
        let mut stack = false;
        let mut close_all = false;
        let mut raise: Option<String> = None;
        egui::Area::new(Id::new("desk-dock"))
            .order(egui::Order::Foreground)
            .anchor(egui::Align2::CENTER_BOTTOM, offset)
            .interactable(true)
            .show(ctx, |ui| {
                egui::Frame::new()
                    .fill(PALETTE.paper)
                    .stroke(egui::Stroke::new(1.0, PALETTE.tan))
                    .corner_radius(ROUNDING + 4)
                    .shadow(egui::epaint::Shadow {
                        offset: [0, 4],
                        blur: 12,
                        spread: 0,
                        color: egui::Color32::from_black_alpha(28),
                    })
                    .inner_margin(egui::Margin::symmetric(10, 6))
                    .show(ui, |ui| {
                        ui.horizontal(|ui| {
                            if icons::button(ui, icons::GRID_VIEW, t.desk_tile()).clicked() {
                                tile = true;
                            }
                            if icons::button(ui, icons::LAYERS_OUTLINED, t.desk_stack()).clicked() {
                                stack = true;
                            }
                            if icons::button(ui, icons::CLEAR, t.desk_close_all()).clicked() {
                                close_all = true;
                            }
                            ui.separator();
                            // What the desk shows, without closing the rest.
                            for (cats, icon, kind) in [
                                (
                                    true,
                                    icons::PETS_OUTLINED,
                                    if pet_mode {
                                        t.kind_cat_neutral()
                                    } else {
                                        t.kind_cat()
                                    },
                                ),
                                (
                                    false,
                                    icons::NIGHT_SHELTER_OUTLINED,
                                    if pet_mode {
                                        t.kind_clowder_neutral()
                                    } else {
                                        t.kind_clowder()
                                    },
                                ),
                            ] {
                                let words = t.only_kind(kind);
                                let on = self.filter == Some(cats);
                                let (rect, response) =
                                    ui.allocate_exact_size(Vec2::splat(28.0), egui::Sense::click());
                                if on {
                                    ui.painter().rect_filled(rect, ROUNDING, PALETTE.tan);
                                }
                                icons::paint(
                                    ui,
                                    rect,
                                    icon,
                                    if on { PALETTE.orange } else { PALETTE.grey },
                                );
                                let response = response.on_hover_text(&words);
                                response.widget_info(|| {
                                    egui::WidgetInfo::selected(
                                        egui::WidgetType::Button,
                                        true,
                                        on,
                                        &words,
                                    )
                                });
                                if response.clicked() {
                                    filter = Some(if on { None } else { Some(cats) });
                                }
                            }
                            ui.separator();
                            for id in &self.open {
                                let name = store
                                    .current(id, keys::NAME)
                                    .ok()
                                    .flatten()
                                    .unwrap_or_else(|| t.unnamed().to_string());
                                let is_cat = id.starts_with("cat:");
                                ui.vertical(|ui| {
                                    let face = store
                                        .profile_image(id)
                                        .ok()
                                        .flatten()
                                        .and_then(|hash| faces.face(ui.ctx(), store, &hash));
                                    let response = match face {
                                        Some(texture) => ui.add(
                                            egui::Image::from_texture(&texture)
                                                .fit_to_exact_size(Vec2::splat(36.0))
                                                .corner_radius(18.0)
                                                .sense(egui::Sense::click()),
                                        ),
                                        None => {
                                            let icon = if is_cat {
                                                icons::PETS_OUTLINED
                                            } else {
                                                icons::NIGHT_SHELTER_OUTLINED
                                            };
                                            let (rect, response) = ui.allocate_exact_size(
                                                Vec2::splat(36.0),
                                                egui::Sense::click(),
                                            );
                                            icons::paint(ui, rect, icon, PALETTE.grey);
                                            response
                                        }
                                    };
                                    if is_cat {
                                        crate::textures::band_if_deceased(
                                            ui,
                                            store,
                                            id,
                                            response.rect,
                                        );
                                    }
                                    let response = response.on_hover_text(&name);
                                    let words = name.clone();
                                    response.widget_info(|| {
                                        egui::WidgetInfo::labeled(
                                            egui::WidgetType::Button,
                                            true,
                                            &words,
                                        )
                                    });
                                    if response.clicked() {
                                        raise = Some(id.clone());
                                    }
                                    // The dot under the card on top.
                                    let (dot, _) = ui.allocate_exact_size(
                                        Vec2::new(36.0, 6.0),
                                        egui::Sense::hover(),
                                    );
                                    if front.as_deref() == Some(id.as_str()) {
                                        ui.painter().circle_filled(
                                            dot.center(),
                                            2.5,
                                            PALETTE.orange,
                                        );
                                    }
                                });
                            }
                        });
                    });
            });
        if tile {
            self.tile(store);
        }
        if stack {
            self.stack(ctx, store);
        }
        if let Some(now) = filter {
            self.filter = now;
            let _ = store.set_local_setting(
                FILTER_KEY,
                match now {
                    Some(true) => "cat",
                    Some(false) => "clowder",
                    None => "",
                },
            );
        }
        if close_all {
            self.close_all(store);
        }
        if let Some(id) = raise {
            ctx.memory_mut(|m| m.areas_mut().move_to_top(Self::layer(&id)));
        }
    }

    /// The bar a window has: the name, × to close, ⋮ with the card's
    /// menu. The whole card drags, the bar is where a hand expects to.
    fn title_bar(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        id: &str,
        defs: &[FieldDef],
        chosen: &BTreeSet<String>,
    ) -> CardEvent {
        let mut event = CardEvent::None;
        let name = store
            .current(id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string());
        let hidden = store.is_hidden(id).unwrap_or(false);
        let r = ROUNDING + 4;
        egui::Frame::new()
            .fill(PALETTE.tan)
            .corner_radius(egui::CornerRadius {
                nw: r,
                ne: r,
                sw: 0,
                se: 0,
            })
            .inner_margin(egui::Margin::symmetric(12, 6))
            .show(ui, |ui| {
                ui.set_width(CARD_WIDTH);
                ui.horizontal(|ui| {
                    let title = egui::RichText::new(&name).strong().size(16.0);
                    ui.add(
                        egui::Label::new(if hidden { title.weak() } else { title })
                            .selectable(false),
                    );
                    // The name is a value like any other; its pen is where
                    // the name is, not in a menu.
                    let pet_mode = store.is_pet_mode().unwrap_or(false);
                    let rename = match (id.starts_with("clowder:"), pet_mode) {
                        (true, false) => t.rename_clowder(),
                        (true, true) => t.rename_clowder_neutral(),
                        (false, false) => t.rename_cat(),
                        (false, true) => t.rename_cat_neutral(),
                    };
                    if icons::icon_button(ui, icons::EDIT_OUTLINED, rename).clicked() {
                        event =
                            CardEvent::Action(CardAction::Page(PageAction::Rename(id.to_string())));
                    }
                    ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                        if icons::icon_button(ui, icons::CLOSE, t.card_close()).clicked() {
                            event = CardEvent::Close;
                        }
                        let actions = icons::more_labeled(ui, t.actions_menu(), |ui| {
                            let e = if id.starts_with("clowder:") {
                                self.clowder_menu(ui, store, t, id, hidden)
                            } else {
                                self.menu(ui, store, t, id, hidden, defs, chosen)
                            };
                            if let Some(e) = e {
                                event = e;
                            }
                        });
                        if !id.starts_with("clowder:") {
                            for tip in [
                                "cat-menu",
                                "cat-report",
                                "cat-poster",
                                "cat-reminder",
                                "cat-chores",
                            ] {
                                crate::tips::anchor(ui, tip, &actions);
                            }
                        }
                    });
                });
            });
        event
    }

    /// One card's face, home, the chosen Fields, its codes; the name and
    /// the menu are the title bar's.
    #[allow(clippy::too_many_arguments)]
    fn card(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        units: UnitSystem,
        id: &str,
        defs: &[FieldDef],
        chosen: &BTreeSet<String>,
    ) -> CardEvent {
        if id.starts_with("clowder:") {
            return self.clowder_card(ui, store, t, faces, units, id);
        }
        let mut event = CardEvent::None;
        ui.horizontal(|ui| {
            if chosen.contains(PHOTO_KEY) {
                match store
                    .profile_image(id)
                    .ok()
                    .flatten()
                    .and_then(|hash| faces.face(ui.ctx(), store, &hash))
                {
                    Some(texture) => {
                        let drawn = ui.add(
                            egui::Image::from_texture(&texture)
                                .fit_to_exact_size(Vec2::splat(56.0))
                                .corner_radius(28.0),
                        );
                        crate::textures::band_if_deceased(ui, store, id, drawn.rect);
                    }
                    None => {
                        icons::glyph(ui, icons::PETS_OUTLINED, 56.0, PALETTE.grey);
                    }
                }
            }
            if chosen.contains(keys::CLOWDER) {
                match store.current(id, keys::CLOWDER).ok().flatten() {
                    Some(home) => {
                        let home_name = store
                            .current(&home, keys::NAME)
                            .ok()
                            .flatten()
                            .unwrap_or_else(|| t.unnamed().to_string());
                        if ui.link(home_name).clicked() {
                            event =
                                CardEvent::Action(CardAction::Page(PageAction::OpenClowder(home)));
                        }
                    }
                    None => {
                        ui.label(egui::RichText::new(t.stray_no_clowder()).weak());
                    }
                }
            }
        });
        ui.add_space(6.0);
        ui.separator();
        if let Some(e) = self.field_rows(ui, store, t, units, id, defs, Some(chosen)) {
            event = e;
        }
        // ID codes, as the printed Card shows them.
        for def in defs {
            if def.field_type != FieldType::Id || !chosen.contains(&def.key()) {
                continue;
            }
            let Some(value) = store.current(id, &def.key()).ok().flatten() else {
                continue;
            };
            ui.add_space(6.0);
            match def.id_display {
                IdDisplay::Plain => {}
                IdDisplay::Qr => {
                    let data = catlog_core::registry::lookup_url(def, &value).unwrap_or(value);
                    crate::codes::qr(ui, &data, 96.0);
                }
                IdDisplay::Barcode => {
                    if crate::codes::barcode(ui, &value, CARD_WIDTH - 24.0, 40.0).is_none() {
                        crate::codes::qr(ui, &value, 96.0);
                    }
                }
            }
        }
        event
    }

    /// A Clowder's card: its name and count, its Fields, its cats as
    /// faces that open their cards, and its menu.
    fn clowder_card(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        units: UnitSystem,
        id: &str,
    ) -> CardEvent {
        let mut event = CardEvent::None;
        let cats = store.cats(Some(id)).unwrap_or_default();
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        let cover = store.profile_image(id).ok().flatten();
        ui.horizontal(|ui| {
            match cover
                .as_ref()
                .and_then(|hash| faces.face(ui.ctx(), store, hash))
            {
                Some(texture) => {
                    ui.add(
                        egui::Image::from_texture(&texture)
                            .fit_to_exact_size(Vec2::splat(48.0))
                            .corner_radius(8.0),
                    );
                }
                None => {
                    icons::glyph(ui, icons::NIGHT_SHELTER_OUTLINED, 40.0, PALETTE.grey);
                }
            }
            let count = if pet_mode {
                t.cats_count_neutral(cats.len() as i64)
            } else {
                t.cats_count(cats.len() as i64)
            };
            ui.label(egui::RichText::new(count).weak());
        });
        ui.add_space(6.0);
        ui.separator();
        // The cats, each a face or a name that opens its card beside this one.
        ui.horizontal_wrapped(|ui| {
            for cat in &cats {
                let face = store
                    .profile_image(&cat.id)
                    .ok()
                    .flatten()
                    .and_then(|hash| faces.face(ui.ctx(), store, &hash));
                let response = match face {
                    Some(texture) => {
                        let r = ui
                            .add(
                                egui::Image::from_texture(&texture)
                                    .fit_to_exact_size(Vec2::splat(40.0))
                                    .corner_radius(20.0)
                                    .sense(egui::Sense::click()),
                            )
                            .on_hover_text(&cat.name);
                        crate::textures::band_if_deceased(ui, store, &cat.id, r.rect);
                        r.widget_info(|| {
                            egui::WidgetInfo::labeled(egui::WidgetType::Button, true, &cat.name)
                        });
                        r
                    }
                    None => icons::button(ui, icons::PETS_OUTLINED, &cat.name),
                };
                if response.clicked() {
                    event = CardEvent::OpenCard(cat.id.clone());
                }
            }
        });
        ui.add_space(6.0);
        let defs: Vec<FieldDef> = store
            .field_defs(Some(FieldScope::Clowder))
            .unwrap_or_default();
        let chosen = clowder_keys(store, &defs);
        if let Some(e) = self.field_rows(ui, store, t, units, id, &defs, Some(&chosen)) {
            event = e;
        }
        event
    }

    /// A Clowder card's menu: a cat in, the cover, the page, the map,
    /// merging, hiding.
    fn clowder_menu(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        id: &str,
        hidden: bool,
    ) -> Option<CardEvent> {
        let mut e = None;
        let cover = store.profile_image(id).ok().flatten();
        page(
            ui,
            &mut e,
            icons::ADD,
            t.new_cat(),
            PageAction::NewCat(Some(id.to_string())),
        );
        page(
            ui,
            &mut e,
            icons::ADD_A_PHOTO,
            t.cover_pick(),
            PageAction::SetCover(id.to_string()),
        );
        if cover.is_some() {
            page(
                ui,
                &mut e,
                icons::HIDE_IMAGE_OUTLINED,
                t.cover_remove(),
                PageAction::RemoveCover(id.to_string()),
            );
        }
        if icons::button(ui, icons::DESCRIPTION_OUTLINED, t.card_page()).clicked() {
            e = Some(CardEvent::Action(CardAction::OpenPage(id.to_string())));
            ui.close();
        }
        if icons::button(ui, icons::HISTORY, t.timeline()).clicked() {
            e = Some(CardEvent::Action(CardAction::OpenTimeline(id.to_string())));
            ui.close();
        }
        if icons::button(ui, icons::PETS_OUTLINED, t.open_all_pets()).clicked() {
            e = Some(CardEvent::Action(CardAction::OpenAllIn(id.to_string())));
            ui.close();
        }
        ui.separator();
        let defs: Vec<FieldDef> = store
            .field_defs(Some(FieldScope::Clowder))
            .unwrap_or_default();
        ui.menu_button(t.card_fields(), |ui| {
            let mut keys_now = clowder_keys(store, &defs);
            let mut changed = false;
            for def in &defs {
                let key = def.key();
                let mut on = keys_now.contains(&key);
                if crate::icons::check_box(ui, &mut on, field_def_name(t, def)).changed() {
                    toggle(&mut keys_now, &key, on);
                    changed = true;
                }
            }
            if changed {
                let text: Vec<&str> = keys_now.iter().map(String::as_str).collect();
                let _ = store.set_local_setting(CLOWDER_FIELDS_KEY, &text.join("\n"));
            }
        });
        ui.separator();
        page(
            ui,
            &mut e,
            icons::MAP_OUTLINED,
            t.show_on_map(),
            PageAction::ShowOnMap(id.to_string()),
        );
        page(
            ui,
            &mut e,
            icons::MERGE,
            &t.merge_this_into(t.kind_clowder()),
            PageAction::MergeInto(id.to_string()),
        );
        ui.separator();
        page(
            ui,
            &mut e,
            if hidden {
                icons::VISIBILITY_OUTLINED
            } else {
                icons::VISIBILITY_OFF_OUTLINED
            },
            if hidden {
                t.unhide_label()
            } else {
                t.hide_label()
            },
            PageAction::ToggleHidden(id.to_string()),
        );
        e
    }

    /// The Field rows of a card: what the record actually holds, the
    /// value over as many lines as it needs, a pen that opens the
    /// editor and the history behind the ⋮. A Field nobody filled in is
    /// no row; the button under them reaches those. `chosen` limits
    /// them.
    #[allow(clippy::too_many_arguments)]
    fn field_rows(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        units: UnitSystem,
        id: &str,
        defs: &[FieldDef],
        chosen: Option<&BTreeSet<String>>,
    ) -> Option<CardEvent> {
        let mut event = None;
        // The first pen on a cat's card is where the edit tip points.
        let mut anchored = false;
        let tiles = &mut self.tiles;
        // How many rows there will be, so the last one draws no line.
        let row_count = defs
            .iter()
            .filter(|def| {
                chosen.is_none_or(|c| c.contains(&def.key()))
                    && (store.current(id, &def.key()).ok().flatten().is_some()
                        || store.is_withheld(id, &def.key()).unwrap_or(false))
            })
            .count();
        let mut rows = 0usize;
        let edit = |slug: &str| {
            Some(CardEvent::Action(CardAction::Page(PageAction::Edit(
                id.to_string(),
                slug.to_string(),
            ))))
        };
        egui::Grid::new(("card-fields", id))
            .num_columns(2)
            // Measured columns, not the longest value's, so a row is as
            // wide as the card.
            .min_col_width(NAME_WIDTH)
            .spacing([12.0, 10.0])
            // Alternating colours on a handful of values read as noise;
            // a hairline under each row says the same thing quietly.
            .striped(false)
            .show(ui, |ui| {
                for def in defs {
                    if chosen.is_some_and(|c| !c.contains(&def.key())) {
                        continue;
                    }
                    // A value a partner kept back is a row with a lock, not
                    // a Field to fill in: filling it would overwrite what
                    // they may yet send.
                    let withheld = store.is_withheld(id, &def.key()).unwrap_or(false);
                    let raw = store.current(id, &def.key()).ok().flatten();
                    let Some(raw) = raw else {
                        if withheld {
                            ui.label(egui::RichText::new(field_def_name(t, def)).weak());
                            icons::label(
                                ui,
                                icons::LOCK_OUTLINE,
                                egui::RichText::new(t.withheld_by_partner()).weak(),
                            );
                            ui.end_row();
                        }
                        continue;
                    };
                    ui.label(egui::RichText::new(field_def_name(t, def)).weak());
                    // A cat reference reads as its name, a place as where
                    // it is — "on the map" says nothing a keeper wants.
                    let shown = if matches!(def.field_type, FieldType::Cat | FieldType::Location) {
                        value_label(t, store, &def.key(), Some(raw.as_str()), units)
                    } else {
                        field_value_display(t, Some(def), Some(raw.as_str()), units)
                    };
                    let row = ui
                        .horizontal_top(|ui| {
                            // The value takes the row but for the two buttons,
                            // and wraps rather than being cut off.
                            ui.allocate_ui_with_layout(
                                egui::vec2(VALUE_WIDTH, 0.0),
                                egui::Layout::top_down(egui::Align::LEFT),
                                |ui| {
                                    // Held to its width, short value or long,
                                    // so the pen and the ⋮ line up down the
                                    // card and the stripe reaches the edge.
                                    ui.set_min_width(VALUE_WIDTH);
                                    ui.add(egui::Label::new(shown).wrap());
                                    trend(ui, store, t, id, def);
                                    if def.field_type == FieldType::Location {
                                        place(ui, t, tiles, &raw);
                                    }
                                },
                            );
                            let pen = icons::icon_button(ui, icons::EDIT_OUTLINED, t.edit_value());
                            if !anchored && id.starts_with("cat:") {
                                crate::tips::anchor(ui, "cat-edit", &pen);
                                anchored = true;
                            }
                            if pen.clicked() {
                                event = edit(&def.slug);
                            }
                            // The menu holds what the pen does not: the history.
                            icons::more_labeled(ui, t.value_actions(), |ui| {
                                if ui.button(t.show_history()).clicked() {
                                    event = Some(CardEvent::Action(CardAction::Page(
                                        PageAction::History(id.to_string(), def.slug.clone()),
                                    )));
                                    ui.close();
                                }
                            });
                        })
                        .response
                        .rect;
                    // A hairline under the row, all the way across the
                    // card, in place of the alternating colours.
                    if rows + 1 < row_count {
                        let left = row.left() - NAME_WIDTH - 12.0;
                        ui.painter().hline(
                            left..=row.right(),
                            row.bottom() + 5.0,
                            egui::Stroke::new(1.0, PALETTE.tan),
                        );
                    }
                    ui.end_row();
                    rows += 1;
                }
            });
        // The Fields this one has nothing in, each a click from a value.
        let empty: Vec<&FieldDef> = defs
            .iter()
            .filter(|def| {
                chosen.is_none_or(|c| c.contains(&def.key()))
                    && store.current(id, &def.key()).ok().flatten().is_none()
                    && !store.is_withheld(id, &def.key()).unwrap_or(false)
            })
            .collect();
        if !empty.is_empty() {
            ui.add_space(4.0);
            let mut picked: Option<String> = None;
            ui.menu_button(t.card_add_value(), |ui| {
                for def in &empty {
                    if ui.button(field_def_name(t, def)).clicked() {
                        picked = Some(def.slug.clone());
                        ui.close();
                    }
                }
            });
            if let Some(slug) = picked {
                event = edit(&slug);
            }
        }
        event
    }

    /// The card's menu: the page, photos, chores and plans, the fields
    /// on the card, the moves, the documents, hiding, closing.
    #[allow(clippy::too_many_arguments)]
    fn menu(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        id: &str,
        hidden: bool,
        defs: &[FieldDef],
        chosen: &BTreeSet<String>,
    ) -> Option<CardEvent> {
        let mut event = None;
        page(
            ui,
            &mut event,
            icons::ADD_A_PHOTO,
            t.add_photo(),
            PageAction::AddPhoto(id.to_string()),
        );
        page(
            ui,
            &mut event,
            icons::CHECKLIST,
            t.new_chore(),
            PageAction::Chore(ChoreAction::New(id.to_string())),
        );
        page(
            ui,
            &mut event,
            icons::EVENT,
            t.add_appointment(),
            PageAction::NewAppointment(id.to_string()),
        );
        if icons::button(ui, icons::DESCRIPTION_OUTLINED, t.card_page()).clicked() {
            event = Some(CardEvent::Action(CardAction::OpenPage(id.to_string())));
            ui.close();
        }
        if icons::button(ui, icons::HISTORY, t.timeline()).clicked() {
            event = Some(CardEvent::Action(CardAction::OpenTimeline(id.to_string())));
            ui.close();
        }
        page(
            ui,
            &mut event,
            icons::IMAGE_OUTLINED,
            t.copy_image(),
            PageAction::CopyCard(id.to_string()),
        );
        ui.separator();
        ui.menu_button(t.card_fields(), |ui| {
            let mut keys_now = chosen.clone();
            let mut changed = false;
            let mut on = keys_now.contains(PHOTO_KEY);
            if crate::icons::check_box(ui, &mut on, t.photos()).changed() {
                toggle(&mut keys_now, PHOTO_KEY, on);
                changed = true;
            }
            let mut on = keys_now.contains(keys::CLOWDER);
            if crate::icons::check_box(ui, &mut on, t.clowder_label()).changed() {
                toggle(&mut keys_now, keys::CLOWDER, on);
                changed = true;
            }
            for def in defs {
                let key = def.key();
                let mut on = keys_now.contains(&key);
                if crate::icons::check_box(ui, &mut on, field_def_name(t, def)).changed() {
                    toggle(&mut keys_now, &key, on);
                    changed = true;
                }
            }
            if changed {
                let text: Vec<&str> = keys_now.iter().map(String::as_str).collect();
                let _ = store.set_local_setting("cardFields", &text.join("\n"));
            }
        });
        ui.separator();
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        page(
            ui,
            &mut event,
            icons::DRIVE_FILE_MOVE_OUTLINE,
            if pet_mode {
                t.move_to_home_neutral()
            } else {
                t.move_to_home()
            },
            PageAction::Move(id.to_string()),
        );
        page(
            ui,
            &mut event,
            icons::MAP_OUTLINED,
            t.show_on_map(),
            PageAction::ShowOnMap(id.to_string()),
        );
        page(
            ui,
            &mut event,
            icons::MERGE,
            &t.merge_this_into(t.kind_cat()),
            PageAction::MergeInto(id.to_string()),
        );
        ui.separator();
        page(
            ui,
            &mut event,
            icons::BADGE_OUTLINED,
            t.card(),
            PageAction::Document(DocKind::Card, id.to_string()),
        );
        page(
            ui,
            &mut event,
            icons::MEDICAL_INFORMATION_OUTLINED,
            t.vet_report_menu(),
            PageAction::Document(DocKind::VetReport, id.to_string()),
        );
        page(
            ui,
            &mut event,
            icons::CAMPAIGN_OUTLINED,
            t.poster_menu(),
            PageAction::Document(DocKind::Poster, id.to_string()),
        );
        ui.separator();
        page(
            ui,
            &mut event,
            if hidden {
                icons::VISIBILITY_OUTLINED
            } else {
                icons::VISIBILITY_OFF_OUTLINED
            },
            if hidden {
                t.unhide_label()
            } else {
                t.hide_label()
            },
            PageAction::ToggleHidden(id.to_string()),
        );
        event
    }
}

/// A number's course under its value: the readings on their line, as
/// small as a row allows. A Field measured once has no course and gets
/// no line.
fn trend(ui: &mut Ui, store: &Catalog, t: &L10n, id: &str, def: &FieldDef) {
    if !matches!(def.field_type, FieldType::Number | FieldType::UnitValue) {
        return;
    }
    let points = store.history_points(id, &def.key()).unwrap_or_default();
    if points.len() < 2 {
        return;
    }
    let (rect, response) =
        ui.allocate_exact_size(Vec2::new(VALUE_WIDTH, 24.0), egui::Sense::hover());
    let words = t.card_trend_of(&field_def_name(t, def));
    let response = response.on_hover_text(&words);
    response.widget_info(|| egui::WidgetInfo::labeled(egui::WidgetType::Label, true, &words));
    if !ui.is_rect_visible(rect) {
        return;
    }
    let (from, to) = (points[0].at, points[points.len() - 1].at);
    let (mut lo, mut hi) = points.iter().fold((f64::MAX, f64::MIN), |(lo, hi), p| {
        (lo.min(p.value), hi.max(p.value))
    });
    if hi <= lo {
        hi = lo + 1.0;
        lo -= 1.0;
    }
    let span = (to - from).max(1) as f64;
    let line: Vec<Pos2> = points
        .iter()
        .map(|p| {
            let x = rect.left() + ((p.at - from) as f64 / span) as f32 * rect.width();
            let y = rect.bottom() - ((p.value - lo) / (hi - lo)) as f32 * rect.height();
            Pos2::new(x, y)
        })
        .collect();
    let painter = ui.painter();
    painter.add(egui::Shape::line(
        line.clone(),
        egui::Stroke::new(1.5, PALETTE.orange),
    ));
    if let Some(last) = line.last() {
        painter.circle_filled(*last, 2.0, PALETTE.orange);
    }
}

/// A place under its coordinates: the map tile it sits in, cut to a
/// square around it with a pin, and the code a phone reads to go there.
fn place(ui: &mut Ui, t: &L10n, tiles: &mut Option<crate::map::TileLoader>, raw: &str) {
    let Some((lat, lon)) = catlog_core::entities::parse_position(Some(raw)) else {
        return;
    };
    let side = 72.0;
    ui.add_space(4.0);
    let response = ui
        .horizontal(|ui| {
            let (rect, _) = ui.allocate_exact_size(Vec2::splat(side), egui::Sense::hover());
            if ui.is_rect_visible(rect) {
                draw_place(ui, rect, tiles, lat, lon);
            }
            crate::codes::qr(ui, &format!("geo:{lat},{lon}"), side);
        })
        .response;
    let words = t.card_place_picture().to_string();
    let response = response.on_hover_text(&words);
    response.widget_info(|| egui::WidgetInfo::labeled(egui::WidgetType::Image, true, &words));
}

/// The tile the place sits in, drawn so that the place is the middle,
/// with a pin on it. Without the tile only the pin and a frame.
fn draw_place(
    ui: &mut Ui,
    rect: Rect,
    tiles: &mut Option<crate::map::TileLoader>,
    lat: f64,
    lon: f64,
) {
    let zoom = PLACE_ZOOM;
    let (x, y) = catlog_core::geo::tile_xy(lat, lon, zoom);
    let texture = tiles
        .as_mut()
        .and_then(|loader| {
            loader.tile(
                &ui.ctx().clone(),
                catlog_core::tiles::TileId {
                    z: zoom,
                    x: x.floor() as u32,
                    y: y.floor() as u32,
                },
            )
        })
        .clone();
    let painter = ui.painter_at(rect);
    match texture {
        Some(texture) => {
            // The part of the tile around the place, as a fraction of it.
            let half = rect.width() / (2.0 * crate::map::TILE_SIZE);
            let (fx, fy) = ((x.fract()) as f32, (y.fract()) as f32);
            let uv = Rect::from_min_max(
                Pos2::new((fx - half).clamp(0.0, 1.0), (fy - half).clamp(0.0, 1.0)),
                Pos2::new((fx + half).clamp(0.0, 1.0), (fy + half).clamp(0.0, 1.0)),
            );
            painter.image(texture.id(), rect, uv, egui::Color32::WHITE);
        }
        None => {
            painter.rect_filled(rect, 4.0, PALETTE.cream);
        }
    }
    painter.rect_stroke(
        rect,
        4.0,
        egui::Stroke::new(1.0, PALETTE.grey),
        egui::StrokeKind::Inside,
    );
    painter.circle_filled(rect.center(), 4.0, PALETTE.orange);
    painter.circle_stroke(
        rect.center(),
        4.0,
        egui::Stroke::new(1.0, egui::Color32::WHITE),
    );
}

/// The Fields a Clowder's card shows: what was chosen, or all of them.
fn clowder_keys(store: &Catalog, defs: &[FieldDef]) -> BTreeSet<String> {
    match store.local_setting(CLOWDER_FIELDS_KEY) {
        Some(saved) => saved
            .lines()
            .filter(|k| !k.is_empty())
            .map(String::from)
            .collect(),
        None => defs.iter().map(FieldDef::key).collect(),
    }
}

/// How tall a card's body may grow before it scrolls: the desk, less
/// the dock's strip, the title bar and a margin at each end. A card
/// taller than the desk cannot be dragged at all — egui pins it.
fn body_cap(desk_height: f32) -> f32 {
    (desk_height - DOCK_STRIP - 80.0).max(120.0)
}

/// A menu entry that asks the app for a page action.
fn page(ui: &mut Ui, event: &mut Option<CardEvent>, icon: &str, label: &str, action: PageAction) {
    if icons::button(ui, icon, label).clicked() {
        *event = Some(CardEvent::Action(CardAction::Page(action)));
        ui.close();
    }
}

fn toggle(keys: &mut BTreeSet<String>, key: &str, on: bool) {
    if on {
        keys.insert(key.to_string());
    } else {
        keys.remove(key);
    }
}

/// What one card reported while drawing.
#[derive(Debug, Clone, PartialEq, Eq)]
enum CardEvent {
    None,
    Close,
    Action(CardAction),
    /// A face on a Clowder's card: that cat's card, beside it.
    OpenCard(String),
}
