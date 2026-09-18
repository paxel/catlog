//! The desk: every opened Cat as its index card, side by side and
//! dragged into place, found there again next time. A card shows what
//! the printed Card shows, from the same field selector; simple values
//! are edited on the card, complex ones in the editor popup.

use std::collections::{BTreeMap, BTreeSet};

use catlog_core::fields::{FieldDef, FieldScope, FieldType, IdDisplay};
use catlog_core::units::{UnitSystem, base_string, from_base, parse_entry, to_base};
use catlog_core::{Catalog, keys};
use egui::{Id, Key, Pos2, Rect, Ui, Vec2};

use crate::chores::ChoreAction;
use crate::documents_page::{DocKind, PHOTO_KEY, card_keys};
use crate::icons;
use crate::l10n::L10n;
use crate::labels::{field_def_name, field_value_display, format_number, value_label};
use crate::pages::PageAction;
use crate::textures::FaceCache;
use crate::theme::{PALETTE, ROUNDING};

/// The local setting naming the open cards, comma-separated.
pub const OPEN_KEY: &str = "cards:open";
/// A card's width on the desk.
pub const CARD_WIDTH: f32 = 320.0;

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

/// A value being typed or picked on a card.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Inline {
    pub cat: String,
    pub key: String,
    pub text: String,
    /// The picked option for choice and yes/no values.
    pub choice: Option<String>,
    focus_asked: bool,
    /// Store on the next frame without a click, as a picked value does.
    save_now: bool,
}

impl Inline {
    /// A choice already made, for a test or a shortcut: the next frame
    /// stores it as if it had been picked from the combo.
    pub fn picked(cat: &str, key: &str, value: &str) -> Inline {
        Inline {
            cat: cat.to_string(),
            key: key.to_string(),
            text: String::new(),
            choice: Some(value.to_string()),
            focus_asked: true,
            save_now: true,
        }
    }
}

/// The desk: the open cards, their places, the edit in progress.
#[derive(Debug, Default)]
pub struct Desk {
    pub open: Vec<String>,
    /// Places relative to the desk's top left corner.
    positions: BTreeMap<String, Pos2>,
    loaded: bool,
    pub inline: Option<Inline>,
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
        if self.inline.as_ref().is_some_and(|i| i.cat == id) {
            self.inline = None;
        }
        self.save_open(store);
    }

    /// Where a card lies, relative to the desk.
    pub fn position(&self, id: &str) -> Option<Pos2> {
        self.positions.get(id).copied()
    }

    /// Starts an inline edit of `key` on `cat`, or asks for the editor
    /// popup when the kind needs one.
    fn begin(
        &mut self,
        cat: &str,
        def: &FieldDef,
        raw: Option<&str>,
        units: UnitSystem,
        locale: &str,
    ) -> Option<PageAction> {
        let simple = matches!(
            def.field_type,
            FieldType::Text
                | FieldType::Number
                | FieldType::YesNo
                | FieldType::Choice
                | FieldType::UnitValue
        );
        if !simple {
            return Some(PageAction::Edit(cat.to_string(), def.slug.clone()));
        }
        let text = match (def.field_type, raw) {
            (_, None) => String::new(),
            (FieldType::Number, Some(v)) => v
                .replace(',', ".")
                .parse::<f64>()
                .map(|n| format_number(locale, n, 6))
                .unwrap_or_else(|_| v.to_string()),
            (FieldType::UnitValue, Some(v)) => v
                .parse::<f64>()
                .map(|base| format_number(locale, from_base(def.unit_dimension(), units, base), 2))
                .unwrap_or_else(|_| v.to_string()),
            (_, Some(v)) => v.to_string(),
        };
        self.inline = Some(Inline {
            cat: cat.to_string(),
            key: def.key(),
            text,
            choice: raw.map(String::from),
            focus_asked: false,
            save_now: false,
        });
        None
    }

    /// The value an inline edit stores, or none to clear it.
    fn composed(inline: &Inline, def: &FieldDef, units: UnitSystem) -> Option<String> {
        let typed = inline.text.trim();
        match def.field_type {
            FieldType::YesNo | FieldType::Choice => inline.choice.clone(),
            FieldType::Number => {
                if typed.is_empty() {
                    return None;
                }
                Some(match typed.replace(',', ".").parse::<f64>() {
                    Ok(n) => catlog_core::units::format_decimal(n, 6),
                    Err(_) => typed.to_string(),
                })
            }
            FieldType::UnitValue => {
                let entered = parse_entry(typed)?;
                Some(base_string(to_base(def.unit_dimension(), units, entered)))
            }
            _ => (!typed.is_empty()).then(|| typed.to_string()),
        }
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
        let mut saved: Option<(String, String, Option<String>)> = None;
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
                .default_size(Vec2::new(CARD_WIDTH + 26.0, 200.0))
                .current_pos(desk.min + rel.to_vec2() + slide);
            if raise.as_deref() == Some(id.as_str()) {
                ctx.move_to_top(egui::LayerId::new(egui::Order::Middle, area_id));
            }
            let out = area.show(&ctx, |ui| {
                ui.set_opacity(fade);
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
                    .inner_margin(12.0)
                    .show(ui, |ui| {
                        ui.set_width(CARD_WIDTH);
                        let a = self.card(ui, store, t, faces, units, &id, &defs, &chosen);
                        match a {
                            CardEvent::None | CardEvent::Cancel => {}
                            CardEvent::Close => closing = Some(id.clone()),
                            CardEvent::Action(a) => action = a,
                            CardEvent::Saved(key, value) => {
                                saved = Some((id.clone(), key, value));
                            }
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
        if let Some((cat, key, value)) = saved {
            // A starter value the app knows to be impossible is refused
            // with its reason; the field keeps what it had.
            let slug = key.strip_prefix("f:").unwrap_or(&key);
            let objection = store
                .starter_objection(
                    &cat,
                    slug,
                    value.as_deref(),
                    chrono::Local::now().date_naive(),
                )
                .ok()
                .flatten();
            if let Some(objection) = objection {
                action = CardAction::Notice(crate::labels::objection_words(t, &objection));
            } else if let Err(e) = store.append(&cat, &key, value.as_deref()) {
                action = CardAction::Notice(e.to_string());
            }
            self.inline = None;
        }
        if let Some(id) = closing {
            self.close(store, &id);
        }
        if let Some(cat) = opening {
            self.open(store, std::slice::from_ref(&cat));
            action = CardAction::Opened(cat);
        }
        action
    }

    /// One card's face, name, home, the chosen Fields, its codes and
    /// its menu.
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
        let name = store
            .current(id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string());
        let hidden = store.is_hidden(id).unwrap_or(false);
        ui.horizontal(|ui| {
            if chosen.contains(PHOTO_KEY) {
                match store
                    .profile_image(id)
                    .ok()
                    .flatten()
                    .and_then(|hash| faces.face(ui.ctx(), store, &hash))
                {
                    Some(texture) => {
                        ui.add(
                            egui::Image::from_texture(&texture)
                                .fit_to_exact_size(Vec2::splat(56.0))
                                .corner_radius(28.0),
                        );
                    }
                    None => {
                        icons::glyph(ui, icons::PETS_OUTLINED, 56.0, PALETTE.grey);
                    }
                }
            }
            ui.vertical(|ui| {
                let title = egui::RichText::new(&name).strong().size(20.0);
                ui.add(
                    egui::Label::new(if hidden { title.weak() } else { title }).selectable(false),
                );
                if chosen.contains(keys::CLOWDER) {
                    match store.current(id, keys::CLOWDER).ok().flatten() {
                        Some(home) => {
                            let home_name = store
                                .current(&home, keys::NAME)
                                .ok()
                                .flatten()
                                .unwrap_or_else(|| t.unnamed().to_string());
                            if ui.link(home_name).clicked() {
                                event = CardEvent::Action(CardAction::Page(
                                    PageAction::OpenClowder(home),
                                ));
                            }
                        }
                        None => {
                            ui.label(egui::RichText::new(t.stray_no_clowder()).weak());
                        }
                    }
                }
            });
            ui.with_layout(egui::Layout::right_to_left(egui::Align::Min), |ui| {
                let actions = ui.menu_button(t.actions_menu(), |ui| {
                    if let Some(e) = self.menu(ui, store, t, id, hidden, defs, chosen) {
                        event = e;
                    }
                });
                for tip in [
                    "cat-menu",
                    "cat-report",
                    "cat-poster",
                    "cat-reminder",
                    "cat-chores",
                ] {
                    crate::tips::anchor(ui, tip, &actions.response);
                }
            });
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
        let name = store
            .current(id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string());
        let hidden = store.is_hidden(id).unwrap_or(false);
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
            ui.vertical(|ui| {
                let title = egui::RichText::new(&name).strong().size(20.0);
                ui.add(
                    egui::Label::new(if hidden { title.weak() } else { title }).selectable(false),
                );
                let count = if pet_mode {
                    t.cats_count_neutral(cats.len() as i64)
                } else {
                    t.cats_count(cats.len() as i64)
                };
                ui.label(egui::RichText::new(count).weak());
            });
            ui.with_layout(egui::Layout::right_to_left(egui::Align::Min), |ui| {
                ui.menu_button(t.actions_menu(), |ui| {
                    let mut e = None;
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
                    if icons::button(ui, icons::CLOSE, t.card_close()).clicked() {
                        e = Some(CardEvent::Close);
                        ui.close();
                    }
                    if let Some(e) = e {
                        event = e;
                    }
                });
            });
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

    /// The Field rows of a card, each edited on a click and holding the
    /// editor and the history in its menu; `chosen` limits them.
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
        // The first value on a cat's card is where the edit tip points.
        let mut anchored = false;
        egui::Grid::new(("card-fields", id))
            .num_columns(2)
            .spacing([12.0, 4.0])
            .show(ui, |ui| {
                for def in defs {
                    if chosen.is_some_and(|c| !c.contains(&def.key())) {
                        continue;
                    }
                    let raw = store.current(id, &def.key()).ok().flatten();
                    let editing = self
                        .inline
                        .as_ref()
                        .is_some_and(|i| i.cat == id && i.key == def.key());
                    ui.label(egui::RichText::new(field_def_name(t, def)).weak());
                    if editing {
                        if let Some(e) = self.inline_widget(ui, t, def, units) {
                            event = Some(e);
                        }
                    } else {
                        let shown = if def.field_type == FieldType::Cat {
                            value_label(t, store, &def.key(), raw.as_deref(), units)
                        } else {
                            field_value_display(t, Some(def), raw.as_deref(), units)
                        };
                        let response = ui.add(
                            egui::Label::new(shown)
                                .sense(egui::Sense::click())
                                .truncate(),
                        );
                        if !anchored && id.starts_with("cat:") {
                            crate::tips::anchor(ui, "cat-edit", &response);
                            anchored = true;
                        }
                        // A click on a value edits it; the header drags the card.
                        if response.clicked()
                            && let Some(a) = self.begin(id, def, raw.as_deref(), units, t.locale())
                        {
                            event = Some(CardEvent::Action(CardAction::Page(a)));
                        }
                        response.context_menu(|ui| {
                            if ui.button(t.edit_value()).clicked() {
                                event = Some(CardEvent::Action(CardAction::Page(
                                    PageAction::Edit(id.to_string(), def.slug.clone()),
                                )));
                                ui.close();
                            }
                            if ui.button(t.show_history()).clicked() {
                                event = Some(CardEvent::Action(CardAction::Page(
                                    PageAction::History(id.to_string(), def.slug.clone()),
                                )));
                                ui.close();
                            }
                        });
                    }
                    ui.end_row();
                }
            });
        event
    }

    /// The text box or the combo for the value being edited.
    fn inline_widget(
        &mut self,
        ui: &mut Ui,
        t: &L10n,
        def: &FieldDef,
        units: UnitSystem,
    ) -> Option<CardEvent> {
        let inline = self.inline.as_mut()?;
        let mut event = None;
        match def.field_type {
            FieldType::YesNo | FieldType::Choice => {
                let options: Vec<(String, String)> = if def.field_type == FieldType::YesNo {
                    vec![
                        ("yes".to_string(), t.value_yes().to_string()),
                        ("no".to_string(), t.value_no().to_string()),
                    ]
                } else {
                    def.options
                        .iter()
                        .map(|o| (o.clone(), field_value_display(t, Some(def), Some(o), units)))
                        .collect()
                };
                let shown = options
                    .iter()
                    .find(|(o, _)| Some(o) == inline.choice.as_ref())
                    .map(|(_, l)| l.clone())
                    .unwrap_or_default();
                let mut picked: Option<String> = None;
                egui::ComboBox::from_id_salt(("inline-choice", &inline.key))
                    .selected_text(shown)
                    .show_ui(ui, |ui| {
                        for (value, label) in &options {
                            if ui
                                .selectable_label(inline.choice.as_ref() == Some(value), label)
                                .clicked()
                            {
                                picked = Some(value.clone());
                            }
                        }
                    });
                if let Some(value) = picked {
                    inline.choice = Some(value);
                    inline.save_now = true;
                }
                if inline.save_now {
                    let composed = Self::composed(inline, def, units);
                    event = Some(CardEvent::Saved(inline.key.clone(), composed));
                }
                if ui.input(|i| i.key_pressed(Key::Escape)) {
                    event = Some(CardEvent::Cancel);
                }
            }
            _ => {
                let edit = ui.add(
                    egui::TextEdit::singleline(&mut inline.text)
                        .desired_width(150.0)
                        .hint_text(if def.field_type == FieldType::UnitValue {
                            catlog_core::units::entry_unit(def.unit_dimension(), units)
                        } else {
                            ""
                        }),
                );
                if !inline.focus_asked {
                    edit.request_focus();
                    inline.focus_asked = true;
                }
                let escape = ui.input(|i| i.key_pressed(Key::Escape));
                let enter = ui.input(|i| i.key_pressed(Key::Enter));
                if escape {
                    event = Some(CardEvent::Cancel);
                } else if enter || (inline.focus_asked && edit.lost_focus()) {
                    let composed = Self::composed(inline, def, units);
                    event = Some(CardEvent::Saved(inline.key.clone(), composed));
                }
            }
        }
        if matches!(event, Some(CardEvent::Cancel)) {
            self.inline = None;
            return None;
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
        if icons::button(ui, icons::CLOSE, t.card_close()).clicked() {
            event = Some(CardEvent::Close);
            ui.close();
        }
        event
    }
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
    Cancel,
    Action(CardAction),
    /// An inline edit to store: the key and the value.
    Saved(String, Option<String>),
    /// A face on a Clowder's card: that cat's card, beside it.
    OpenCard(String),
}
