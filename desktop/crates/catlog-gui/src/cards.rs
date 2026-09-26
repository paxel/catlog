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

/// The local setting naming the open cards, comma-separated.
pub const OPEN_KEY: &str = "cards:open";
/// A card's width on the desk.
pub const CARD_WIDTH: f32 = 320.0;

/// The strip the dock floats in, kept clear when cards are laid out.
const DOCK_STRIP: f32 = 96.0;

/// A Field row's two columns: the name, then the value with the pen and
/// the ⋮ beside it. Both are measured so that a row fills the card.
const NAME_WIDTH: f32 = 104.0;
const VALUE_WIDTH: f32 = CARD_WIDTH - NAME_WIDTH - 12.0 - 56.0;

fn pos_key(id: &str) -> String {
    format!("card:{id}")
}

/// What the keeper did on the desk this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CardAction {
    None,
    Page(PageAction),
    /// The whole page in a modal: photos, chores, plans, family, history.
    OpenPage(String),
    /// Something went wrong storing a value.
    Notice(String),
    /// A cat's card opened from a Clowder's card.
    Opened(String),
}

/// The desk: the open cards and their places.
#[derive(Debug, Default)]
pub struct Desk {
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
}

impl Desk {
    /// Forgets what was loaded, for another Catalog.
    pub fn reset(&mut self) {
        *self = Desk::default();
    }

    /// Reads the open set and the places once per Catalog.
    pub fn load(&mut self, store: &Catalog) {
        if self.loaded {
            return;
        }
        self.loaded = true;
        self.open = store
            .local_setting(OPEN_KEY)
            .unwrap_or_default()
            .split(',')
            .filter(|s| !s.is_empty())
            .map(String::from)
            .collect();
        for id in &self.open {
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
        let mut closing: Option<String> = None;
        let mut opening: Option<String> = None;
        let mut moved: Vec<(String, Pos2, bool)> = Vec::new();
        for id in self.open.clone() {
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
                .default_size(Vec2::new(CARD_WIDTH + 26.0, body_cap(desk.height()) + 48.0))
                .current_pos(desk.min + rel.to_vec2() + slide);
            if raise.as_deref() == Some(id.as_str()) {
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
                        egui::ScrollArea::vertical()
                            .id_salt(("card-body", id.as_str()))
                            .max_height(body_cap(desk.height()))
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
        let gap = 16.0;
        let step = CARD_WIDTH + 24.0 + gap;
        let width = self.desk_size.x.max(step);
        let columns = (((width - gap) / step).floor() as usize).clamp(1, 16);
        let rows = self.open.len().div_ceil(columns).max(1);
        let usable = (self.desk_size.y - DOCK_STRIP).max(160.0);
        let row_height = ((usable - gap) / rows as f32 - gap).max(120.0);
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
        for (i, id) in self.open.clone().iter().enumerate() {
            let step = 16.0 + i as f32 * 24.0;
            self.place(store, id, Pos2::new(step, step));
            ctx.memory_mut(|m| m.areas_mut().move_to_top(Self::layer(id)));
        }
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
        let screen = ctx.content_rect();
        let offset = Vec2::new(
            desk.center().x - screen.center().x,
            desk.max.y - screen.max.y - 12.0,
        );
        let mut tile = false;
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
        if let Some(e) = self.field_rows(ui, store, t, units, id, &defs, None) {
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
        let edit = |slug: &str| {
            Some(CardEvent::Action(CardAction::Page(PageAction::Edit(
                id.to_string(),
                slug.to_string(),
            ))))
        };
        egui::Grid::new(("card-fields", id))
            .num_columns(2)
            // Measured columns, not the longest value's: a row is then as
            // wide as the card, and its stripe reaches the edge.
            .min_col_width(NAME_WIDTH)
            .spacing([12.0, 4.0])
            .show(ui, |ui| {
                for def in defs {
                    if chosen.is_some_and(|c| !c.contains(&def.key())) {
                        continue;
                    }
                    let Some(raw) = store.current(id, &def.key()).ok().flatten() else {
                        continue;
                    };
                    ui.label(egui::RichText::new(field_def_name(t, def)).weak());
                    let shown = if def.field_type == FieldType::Cat {
                        value_label(t, store, &def.key(), Some(raw.as_str()), units)
                    } else {
                        field_value_display(t, Some(def), Some(raw.as_str()), units)
                    };
                    ui.horizontal_top(|ui| {
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
                    });
                    ui.end_row();
                }
            });
        // The Fields this one has nothing in, each a click from a value.
        let empty: Vec<&FieldDef> = defs
            .iter()
            .filter(|def| {
                chosen.is_none_or(|c| c.contains(&def.key()))
                    && store.current(id, &def.key()).ok().flatten().is_none()
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
            if ui.checkbox(&mut on, t.photos()).changed() {
                toggle(&mut keys_now, PHOTO_KEY, on);
                changed = true;
            }
            let mut on = keys_now.contains(keys::CLOWDER);
            if ui.checkbox(&mut on, t.clowder_label()).changed() {
                toggle(&mut keys_now, keys::CLOWDER, on);
                changed = true;
            }
            for def in defs {
                let key = def.key();
                let mut on = keys_now.contains(&key);
                if ui.checkbox(&mut on, field_def_name(t, def)).changed() {
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
        page(
            ui,
            &mut event,
            icons::DRIVE_FILE_MOVE_OUTLINE,
            t.move_to(),
            PageAction::Move(id.to_string()),
        );
        page(
            ui,
            &mut event,
            icons::MY_LOCATION,
            t.seen_here_now(),
            PageAction::Sighting(id.to_string()),
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
