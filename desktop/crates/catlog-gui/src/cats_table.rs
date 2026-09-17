//! The Cats view: every Cat as a row in a desktop table with faces,
//! sortable and resizable columns the keeper chooses per Catalog, a
//! search box, Strays and Missing filters, arrows and Enter, and
//! multi-select with Ctrl and Shift for the cards.

use std::collections::{BTreeMap, BTreeSet};

use catlog_core::Catalog;
use catlog_core::fields::{FieldDef, FieldScope, FieldType};
use catlog_core::flier::target::MISSING_SINCE;
use catlog_core::keys;
use catlog_core::units::UnitSystem;
use chrono::NaiveDate;
use egui::{Key, Sense, Ui, Vec2};
use egui_extras::{Column as TableColumn, TableBuilder};

use crate::documents_page::age_text;
use crate::icons;
use crate::l10n::L10n;
use crate::labels::{field_label, field_value_display, format_day};
use crate::textures::FaceCache;
use crate::theme::PALETTE;

/// The local setting that holds the chosen columns, comma-separated.
pub const COLUMNS_KEY: &str = "cats:columns";

/// One column of the table: a fixed one or any Field of the Catalog.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Column {
    Face,
    Name,
    Clowder,
    Status,
    Age,
    LastChange,
    /// A Field by its slug; Species and Gender are these too.
    Field(String),
}

impl Column {
    pub fn id(&self) -> String {
        match self {
            Column::Face => "face".into(),
            Column::Name => "name".into(),
            Column::Clowder => "clowder".into(),
            Column::Status => "status".into(),
            Column::Age => "age".into(),
            Column::LastChange => "last".into(),
            Column::Field(slug) => format!("f:{slug}"),
        }
    }

    pub fn parse(id: &str) -> Option<Column> {
        Some(match id {
            "face" => Column::Face,
            "name" => Column::Name,
            "clowder" => Column::Clowder,
            "status" => Column::Status,
            "age" => Column::Age,
            "last" => Column::LastChange,
            _ => Column::Field(id.strip_prefix("f:")?.to_string()),
        })
    }

    pub fn label(&self, t: &L10n, store: &Catalog) -> String {
        match self {
            Column::Face => t.column_face().to_string(),
            Column::Name => t.label_name().to_string(),
            Column::Clowder => t.clowder_label().to_string(),
            Column::Status => t.column_status().to_string(),
            Column::Age => t.age_label().to_string(),
            Column::LastChange => t.column_last_change().to_string(),
            Column::Field(slug) => field_label(t, store, &keys::user_field(slug)),
        }
    }
}

/// The columns a fresh Catalog shows.
pub fn default_columns() -> Vec<Column> {
    vec![
        Column::Face,
        Column::Name,
        Column::Clowder,
        Column::Status,
        Column::Field("species".into()),
        Column::Field("gender".into()),
        Column::Age,
        Column::LastChange,
    ]
}

/// The columns chosen for this Catalog, or the default set.
pub fn load_columns(store: &Catalog) -> Vec<Column> {
    let Some(saved) = store.local_setting(COLUMNS_KEY) else {
        return default_columns();
    };
    let columns: Vec<Column> = saved.split(',').filter_map(Column::parse).collect();
    if columns.is_empty() {
        default_columns()
    } else {
        columns
    }
}

pub fn save_columns(store: &Catalog, columns: &[Column]) {
    let ids: Vec<String> = columns.iter().map(Column::id).collect();
    let _ = store.set_local_setting(COLUMNS_KEY, &ids.join(","));
}

/// Every column the chooser offers: the fixed ones, then each Cat Field.
pub fn all_columns(store: &Catalog) -> Vec<Column> {
    let mut all = vec![
        Column::Face,
        Column::Name,
        Column::Clowder,
        Column::Status,
        Column::Age,
        Column::LastChange,
    ];
    for def in store.field_defs(None).unwrap_or_default() {
        if def.scope != FieldScope::Clowder {
            all.push(Column::Field(def.slug));
        }
    }
    all
}

/// What a cell sorts by.
#[derive(Debug, Clone, PartialEq)]
pub enum SortKey {
    Text(String),
    Number(f64),
}

#[derive(Debug, Clone, PartialEq)]
pub struct Cell {
    pub text: String,
    pub key: SortKey,
}

/// One Cat as the table shows it, worked out before drawing.
#[derive(Debug, Clone, PartialEq)]
pub struct Row {
    pub id: String,
    pub name: String,
    pub hidden: bool,
    pub face: Option<String>,
    pub stray: bool,
    pub missing: bool,
    /// The chip value, searched even when its column is off.
    pub chip: String,
    pub cells: Vec<Cell>,
}

fn text_cell(text: String) -> Cell {
    Cell {
        key: SortKey::Text(text.to_lowercase()),
        text,
    }
}

fn number_key(raw: Option<&str>) -> Option<SortKey> {
    let raw = raw?;
    let number: String = raw
        .chars()
        .take_while(|c| c.is_ascii_digit() || *c == '.' || *c == '-')
        .collect();
    number.parse::<f64>().ok().map(SortKey::Number)
}

/// The rows for `columns`, in creation order; sorting and filtering
/// come after.
pub fn rows(
    store: &Catalog,
    t: &L10n,
    today: NaiveDate,
    units: UnitSystem,
    columns: &[Column],
    show_hidden: bool,
) -> Vec<Row> {
    let defs: BTreeMap<String, FieldDef> = store
        .field_defs(None)
        .unwrap_or_default()
        .into_iter()
        .map(|d| (d.slug.clone(), d))
        .collect();
    let last = store.last_recorded().unwrap_or_default();
    let clowder_names: BTreeMap<String, String> = store
        .clowders()
        .unwrap_or_default()
        .into_iter()
        .map(|c| (c.id, c.name))
        .collect();
    let mut out = Vec::new();
    for cat in store.cats(None).unwrap_or_default() {
        let hidden = store.is_hidden(&cat.id).unwrap_or(false);
        if hidden && !show_hidden {
            continue;
        }
        let value = |key: &str| store.current(&cat.id, key).ok().flatten();
        let clowder = value(keys::CLOWDER);
        let deceased = value(&keys::user_field("deceased")).is_some();
        let missing = value(MISSING_SINCE).is_some();
        let stray = clowder.is_none();
        let cells = columns
            .iter()
            .map(|column| match column {
                Column::Face => text_cell(String::new()),
                Column::Name => text_cell(cat.name.clone()),
                Column::Clowder => text_cell(
                    clowder
                        .as_ref()
                        .and_then(|c| clowder_names.get(c).cloned())
                        .unwrap_or_default(),
                ),
                Column::Status => text_cell(
                    if deceased {
                        t.starter_deceased()
                    } else if missing {
                        t.filter_missing()
                    } else if stray {
                        t.stray()
                    } else {
                        t.status_home()
                    }
                    .to_string(),
                ),
                Column::Age => {
                    let birth = value(&keys::user_field("birthdate"));
                    let text = age_text(t, birth.as_deref(), today).unwrap_or_default();
                    // Older cats sort first when the column is descending.
                    let key = birth
                        .as_deref()
                        .and_then(|b| b.get(..4)?.parse::<f64>().ok())
                        .map(|year| SortKey::Number(-year))
                        .unwrap_or(SortKey::Number(1.0));
                    Cell { text, key }
                }
                Column::LastChange => {
                    let stamp = last.get(&cat.id).cloned().unwrap_or_default();
                    let text = stamp
                        .get(..10)
                        .and_then(|d| d.parse::<NaiveDate>().ok())
                        .map(|d| format_day(t.locale(), d))
                        .unwrap_or_default();
                    Cell {
                        text,
                        key: SortKey::Text(stamp),
                    }
                }
                Column::Field(slug) => {
                    let def = defs.get(slug);
                    let raw = value(&keys::user_field(slug));
                    let text = match raw.as_deref() {
                        Some(_) => field_value_display(t, def, raw.as_deref(), units),
                        None => String::new(),
                    };
                    let numeric = matches!(
                        def.map(|d| d.field_type),
                        Some(FieldType::Number | FieldType::UnitValue)
                    );
                    let key = if numeric {
                        number_key(raw.as_deref()).unwrap_or(SortKey::Number(f64::MAX))
                    } else {
                        SortKey::Text(text.to_lowercase())
                    };
                    Cell { text, key }
                }
            })
            .collect();
        out.push(Row {
            face: store.profile_image(&cat.id).ok().flatten(),
            hidden,
            stray,
            missing,
            chip: value(&keys::user_field("chipid")).unwrap_or_default(),
            cells,
            id: cat.id,
            name: cat.name,
        });
    }
    out
}

/// What the keeper did in the table this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum TableAction {
    None,
    /// Enter or a double-click: the Cat's page or card.
    Open(String),
    NewCat,
    CaptureFlier,
    ToggleHidden(String),
}

/// The table's own state: what is chosen, sorted, searched and selected.
#[derive(Debug, Default)]
pub struct CatsTable {
    /// The column sorted by and whether it is descending.
    pub sort: Option<(Column, bool)>,
    pub query: String,
    pub strays_only: bool,
    pub missing_only: bool,
    /// The selected Cats, in no order; `order` says how they lie.
    pub selected: BTreeSet<String>,
    /// The row the keyboard stands on.
    pub cursor: Option<String>,
    /// The row a Shift range counts from.
    pub anchor: Option<String>,
    /// The rows as last shown, top to bottom.
    order: Vec<String>,
    /// The columns as last shown, for the sort.
    columns_shown: Vec<Column>,
    scroll_to: Option<usize>,
}

impl CatsTable {
    /// The rows as last shown, top to bottom.
    pub fn order(&self) -> &[String] {
        &self.order
    }

    /// The selected Cats in the table's order.
    pub fn selected_in_order(&self) -> Vec<String> {
        self.order
            .iter()
            .filter(|id| self.selected.contains(*id))
            .cloned()
            .collect()
    }

    fn filtered(&self, all: Vec<Row>) -> Vec<Row> {
        let query = self.query.trim().to_lowercase();
        let mut rows: Vec<Row> = all
            .into_iter()
            .filter(|r| !self.strays_only || r.stray)
            .filter(|r| !self.missing_only || r.missing)
            .filter(|r| {
                query.is_empty()
                    || r.name.to_lowercase().contains(&query)
                    || r.chip.to_lowercase().contains(&query)
                    || r.cells
                        .iter()
                        .any(|c| c.text.to_lowercase().contains(&query))
            })
            .collect();
        if let Some((column, descending)) = &self.sort
            && let Some(at) = self.columns_at(column)
        {
            rows.sort_by(|a, b| {
                let order = match (&a.cells[at].key, &b.cells[at].key) {
                    (SortKey::Number(x), SortKey::Number(y)) => x.total_cmp(y),
                    (SortKey::Text(x), SortKey::Text(y)) => x.cmp(y),
                    (SortKey::Number(_), _) => std::cmp::Ordering::Less,
                    (_, SortKey::Number(_)) => std::cmp::Ordering::Greater,
                };
                if *descending { order.reverse() } else { order }
            });
        }
        rows
    }

    fn columns_at(&self, column: &Column) -> Option<usize> {
        self.columns_shown.iter().position(|c| c == column)
    }

    /// Selects `id` the way a click with `modifiers` does: alone, added
    /// with Ctrl, as a range from the cursor with Shift.
    fn select(&mut self, id: &str, modifiers: egui::Modifiers) {
        self.cursor = Some(id.to_string());
        if modifiers.shift
            && let Some(anchor) = self.anchor.clone()
            && let (Some(a), Some(b)) = (
                self.order.iter().position(|x| *x == anchor),
                self.order.iter().position(|x| x == id),
            )
        {
            let (from, to) = (a.min(b), a.max(b));
            if !modifiers.command {
                self.selected.clear();
            }
            self.selected.extend(self.order[from..=to].iter().cloned());
            return;
        }
        if modifiers.command {
            if !self.selected.remove(id) {
                self.selected.insert(id.to_string());
            }
        } else {
            self.selected.clear();
            self.selected.insert(id.to_string());
        }
        self.anchor = Some(id.to_string());
    }

    /// Draws the toolbar and the table; says what the keeper did.
    #[allow(clippy::too_many_arguments)]
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        today: NaiveDate,
        units: UnitSystem,
        show_hidden: bool,
    ) -> TableAction {
        let mut action = TableAction::None;
        // A resizable pane shrinks to its content; the table claims the
        // whole width so the width the keeper chose holds.
        ui.set_min_width(ui.available_width());
        let mut columns = load_columns(store);
        self.columns_shown = columns.clone();
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        // The toolbar: search, filters, columns, the ways to a new cat.
        ui.horizontal(|ui| {
            ui.add(
                egui::TextEdit::singleline(&mut self.query)
                    .desired_width(220.0)
                    .hint_text(if pet_mode {
                        t.search_cats_neutral()
                    } else {
                        t.search_cats()
                    }),
            );
            if icons::selectable(ui, self.strays_only, icons::PETS, t.strays()).clicked() {
                self.strays_only = !self.strays_only;
            }
            if icons::selectable(
                ui,
                self.missing_only,
                icons::CAMPAIGN_OUTLINED,
                t.filter_missing(),
            )
            .clicked()
            {
                self.missing_only = !self.missing_only;
            }
            ui.menu_button(t.columns_button(), |ui| {
                let mut changed = false;
                for column in all_columns(store) {
                    let mut on = columns.contains(&column);
                    if ui.checkbox(&mut on, column.label(t, store)).changed() {
                        if on {
                            columns.push(column);
                        } else {
                            columns.retain(|c| *c != column);
                        }
                        changed = true;
                    }
                }
                if changed {
                    save_columns(store, &columns);
                }
            });
            ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                if icons::button(ui, icons::ASSIGNMENT_OUTLINED, t.capture_flier()).clicked() {
                    action = TableAction::CaptureFlier;
                }
                if icons::button(ui, icons::ADD, t.new_cat()).clicked() {
                    action = TableAction::NewCat;
                }
            });
        });
        ui.add_space(4.0);
        let rows = self.filtered(rows(store, t, today, units, &columns, show_hidden));
        self.order = rows.iter().map(|r| r.id.clone()).collect();
        // The keyboard walks the rows while nothing is being typed.
        if ui.ctx().memory(|m| m.focused()).is_none() && !rows.is_empty() {
            let (down, up, enter, shift) = ui.input(|i| {
                (
                    i.key_pressed(Key::ArrowDown),
                    i.key_pressed(Key::ArrowUp),
                    i.key_pressed(Key::Enter),
                    i.modifiers.shift,
                )
            });
            let at = self
                .cursor
                .as_ref()
                .and_then(|c| self.order.iter().position(|x| x == c));
            if down || up {
                let next = match (at, down) {
                    (None, _) => 0,
                    (Some(i), true) => (i + 1).min(self.order.len() - 1),
                    (Some(i), false) => i.saturating_sub(1),
                };
                let id = self.order[next].clone();
                let modifiers = egui::Modifiers {
                    shift,
                    ..Default::default()
                };
                self.select(&id, modifiers);
                self.scroll_to = Some(next);
            } else if enter && let Some(id) = self.cursor.clone() {
                action = TableAction::Open(id);
            }
        }
        let modifiers = ui.input(|i| i.modifiers);
        let mut table = TableBuilder::new(ui)
            .id_salt("cats-table")
            .striped(true)
            .resizable(true)
            .sense(Sense::click())
            .cell_layout(egui::Layout::left_to_right(egui::Align::Center))
            .min_scrolled_height(0.0);
        if let Some(row) = self.scroll_to.take() {
            table = table.scroll_to_row(row, None);
        }
        for column in &columns {
            table = table.column(match column {
                Column::Face => TableColumn::exact(40.0),
                _ => TableColumn::auto().at_least(60.0).resizable(true),
            });
        }
        table = table.column(TableColumn::remainder());
        let mut sort_click: Option<Column> = None;
        let mut clicked: Option<(String, egui::Modifiers)> = None;
        table
            .header(28.0, |mut header| {
                for column in &columns {
                    header.col(|ui| {
                        if *column == Column::Face {
                            icons::glyph(ui, icons::PETS_OUTLINED, 18.0, PALETTE.grey);
                            return;
                        }
                        let sorted = self.sort.as_ref().filter(|(c, _)| c == column);
                        let label = column.label(t, store);
                        let response = ui.add(egui::Button::selectable(
                            sorted.is_some(),
                            egui::RichText::new(&label).strong(),
                        ));
                        if let Some((_, descending)) = sorted {
                            let icon = if *descending {
                                icons::ARROW_DOWNWARD
                            } else {
                                icons::ARROW_UPWARD
                            };
                            icons::glyph(ui, icon, 14.0, PALETTE.orange);
                        }
                        if response.clicked() && *column != Column::Face {
                            sort_click = Some(column.clone());
                        }
                    });
                }
                header.col(|_| {});
            })
            .body(|body| {
                body.rows(34.0, rows.len(), |mut row| {
                    let r = &rows[row.index()];
                    row.set_selected(self.selected.contains(&r.id));
                    for (column, cell) in columns.iter().zip(&r.cells) {
                        row.col(|ui| match column {
                            Column::Face => {
                                if let Some(texture) = r
                                    .face
                                    .as_ref()
                                    .and_then(|hash| faces.face(ui.ctx(), store, hash))
                                {
                                    ui.add(
                                        egui::Image::from_texture(&texture)
                                            .fit_to_exact_size(Vec2::splat(28.0))
                                            .corner_radius(14.0),
                                    );
                                } else {
                                    icons::glyph(ui, icons::PETS_OUTLINED, 22.0, PALETTE.grey);
                                }
                            }
                            _ => {
                                let text = if r.hidden {
                                    egui::RichText::new(&cell.text).weak()
                                } else {
                                    egui::RichText::new(&cell.text)
                                };
                                ui.add(egui::Label::new(text).selectable(false).truncate());
                            }
                        });
                    }
                    row.col(|_| {});
                    let response = row.response();
                    if response.double_clicked() {
                        action = TableAction::Open(r.id.clone());
                    } else if response.clicked() {
                        clicked = Some((r.id.clone(), modifiers));
                    }
                    response.context_menu(|ui| {
                        if ui.button(t.open()).clicked() {
                            action = TableAction::Open(r.id.clone());
                            ui.close();
                        }
                        let hide = if r.hidden {
                            t.unhide_label()
                        } else {
                            t.hide_label()
                        };
                        if ui.button(hide).clicked() {
                            action = TableAction::ToggleHidden(r.id.clone());
                            ui.close();
                        }
                    });
                });
            });
        if let Some(column) = sort_click {
            self.sort = match &self.sort {
                Some((c, false)) if *c == column => Some((column, true)),
                Some((c, true)) if *c == column => None,
                _ => Some((column, false)),
            };
        }
        if let Some((id, modifiers)) = clicked {
            self.select(&id, modifiers);
        }
        action
    }
}
