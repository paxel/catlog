//! The Clowders view: every home as a row with its favourite star, its
//! cats' count, its status and address, sortable; Enter or a
//! double-click lays the Clowder's card on the desk.

use catlog_core::Catalog;
use catlog_core::keys;
use catlog_core::units::UnitSystem;
use chrono::NaiveDate;
use egui::{Key, Sense, Ui};
use egui_extras::{Column as TableColumn, TableBuilder};

use crate::home::{ClowderRow, clowder_rows};
use crate::icons;
use crate::l10n::L10n;
use crate::labels::{field_label, field_value_display, format_day};
use crate::theme::PALETTE;

/// The sortable columns.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Column {
    Name,
    Cats,
    Status,
    Address,
    LastChange,
}

impl Column {
    pub const ALL: [Column; 5] = [
        Column::Name,
        Column::Cats,
        Column::Status,
        Column::Address,
        Column::LastChange,
    ];

    fn label(self, t: &L10n, store: &Catalog, pet_mode: bool) -> String {
        match self {
            Column::Name => t.label_name().to_string(),
            Column::Cats => if pet_mode { t.cats_neutral() } else { t.cats() }.to_string(),
            Column::Status => field_label(t, store, &keys::user_field("status")),
            Column::Address => field_label(t, store, &keys::user_field("address")),
            Column::LastChange => t.column_last_change().to_string(),
        }
    }
}

/// One Clowder as the table shows it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Row {
    pub row: ClowderRow,
    pub status: String,
    pub address: String,
    /// The newest `recorded` stamp, sortable as text.
    pub last: String,
}

/// What the keeper did in the table this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum TableAction {
    None,
    /// Enter: the Clowder's card.
    Open(String),
    /// Lay these Clowders on the desk, or take them off again.
    SetOpen(Vec<String>, bool),
    /// What the keeper asked for the marked rows.
    Marked(crate::marked::MarkedAction),
    NewClowder,
    /// The Cats view with its Strays filter on.
    Strays,
    ToggleFavourite(String),
    ToggleHidden(String),
}

/// The table's own state.
#[derive(Debug, Default)]
pub struct ClowdersTable {
    pub sort: Option<(Column, bool)>,
    /// The row the keyboard stands on and a click selects.
    pub cursor: Option<String>,
    /// The marked rows, in no order; `order` says how they lie.
    pub selected: std::collections::BTreeSet<String>,
    /// Where a shift-click measures from.
    anchor: Option<String>,
    order: Vec<String>,
    scroll_to: Option<usize>,
    /// The rows and the strays count as built for the store's last
    /// write and these inputs; the sort runs on them every frame.
    rows: crate::memo::Memo<(bool, UnitSystem, String), (Vec<Row>, usize)>,
}

/// The rows, favourites first as the pane had them.
pub fn rows(store: &Catalog, t: &L10n, units: UnitSystem, show_hidden: bool) -> Vec<Row> {
    let last = store.last_recorded().unwrap_or_default();
    let status_def = store.field_def("status").ok().flatten();
    clowder_rows(store, show_hidden)
        .unwrap_or_default()
        .into_iter()
        .map(|row| {
            let id = row.view.id.clone();
            let status = store
                .current(&id, &keys::user_field("status"))
                .ok()
                .flatten()
                .map(|v| field_value_display(t, status_def.as_ref(), Some(&v), units))
                .unwrap_or_default();
            let address = store
                .current(&id, &keys::user_field("address"))
                .ok()
                .flatten()
                .unwrap_or_default();
            Row {
                status,
                address,
                last: last.get(&id).cloned().unwrap_or_default(),
                row,
            }
        })
        .collect()
}

impl ClowdersTable {
    /// The rows as last shown, top to bottom.
    pub fn order(&self) -> &[String] {
        &self.order
    }

    fn sorted(&self, mut rows: Vec<Row>) -> Vec<Row> {
        if let Some((column, descending)) = self.sort {
            rows.sort_by(|a, b| {
                let order = match column {
                    Column::Name => a
                        .row
                        .view
                        .name
                        .to_lowercase()
                        .cmp(&b.row.view.name.to_lowercase()),
                    Column::Cats => a.row.cat_count.cmp(&b.row.cat_count),
                    Column::Status => a.status.to_lowercase().cmp(&b.status.to_lowercase()),
                    Column::Address => a.address.to_lowercase().cmp(&b.address.to_lowercase()),
                    Column::LastChange => a.last.cmp(&b.last),
                };
                if descending { order.reverse() } else { order }
            });
        }
        rows
    }

    /// Draws the toolbar and the table; says what the keeper did.
    #[allow(clippy::too_many_arguments)]
    /// The marked Clowders in the table's order, then any the filters
    /// have since hidden.
    pub fn selected_in_order(&self) -> Vec<String> {
        let mut out: Vec<String> = self
            .order
            .iter()
            .filter(|id| self.selected.contains(*id))
            .cloned()
            .collect();
        for id in &self.selected {
            if !out.contains(id) {
                out.push(id.clone());
            }
        }
        out
    }

    /// A click marks one row; Ctrl adds or removes one; Shift takes the
    /// run from where the last click was.
    fn select(&mut self, id: &str, modifiers: egui::Modifiers) {
        self.cursor = Some(id.to_string());
        if modifiers.shift
            && let Some(anchor) = self.anchor.clone()
            && let (Some(from), Some(to)) = (
                self.order.iter().position(|x| *x == anchor),
                self.order.iter().position(|x| x == id),
            )
        {
            let (from, to) = if from <= to { (from, to) } else { (to, from) };
            if !modifiers.command {
                self.selected.clear();
            }
            self.selected.extend(self.order[from..=to].iter().cloned());
            return;
        }
        self.anchor = Some(id.to_string());
        if modifiers.command {
            if !self.selected.remove(id) {
                self.selected.insert(id.to_string());
            }
        } else {
            self.selected.clear();
            self.selected.insert(id.to_string());
        }
    }

    #[allow(clippy::too_many_arguments)]
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut crate::textures::FaceCache,
        units: UnitSystem,
        show_hidden: bool,
        open: &std::collections::BTreeSet<String>,
    ) -> TableAction {
        let mut action = TableAction::None;
        // A resizable pane shrinks to its content; the table claims the
        // whole width so the width the keeper chose holds.
        ui.set_min_width(ui.available_width());
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        let (built, strays) = self
            .rows
            .get(store, (show_hidden, units, t.locale().to_string()), || {
                (
                    rows(store, t, units, show_hidden),
                    store.strays().map(|s| s.len()).unwrap_or(0),
                )
            })
            .clone();
        ui.horizontal(|ui| {
            let new_label = if pet_mode {
                t.new_clowder_neutral()
            } else {
                t.new_clowder()
            };
            if icons::button(ui, icons::ADD_HOME_OUTLINED, new_label).clicked() {
                action = TableAction::NewClowder;
            }
            if icons::button(ui, icons::PETS, t.strays_count(strays as i64)).clicked() {
                action = TableAction::Strays;
            }
        });
        ui.add_space(4.0);
        let rows = self.sorted(built);
        self.order = rows.iter().map(|r| r.row.view.id.clone()).collect();
        if rows.is_empty() {
            ui.add_space(8.0);
            ui.label(if pet_mode {
                t.no_clowders_yet_neutral()
            } else {
                t.no_clowders_yet()
            });
            return action;
        }
        // The keyboard walks the rows while nothing is being typed.
        if ui.ctx().memory(|m| m.focused()).is_none() {
            let (down, up, enter) = ui.input(|i| {
                (
                    i.key_pressed(Key::ArrowDown),
                    i.key_pressed(Key::ArrowUp),
                    i.key_pressed(Key::Enter),
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
                self.cursor = Some(self.order[next].clone());
                self.scroll_to = Some(next);
            } else if enter && let Some(id) = self.cursor.clone() {
                action = TableAction::Open(id);
            }
        }
        let hidden = self
            .selected
            .iter()
            .all(|id| store.is_hidden(id).unwrap_or(false));
        let marked = crate::marked::marked_bar(
            ui,
            t,
            self.selected.len(),
            false,
            hidden && !self.selected.is_empty(),
            pet_mode,
        );
        if marked != crate::marked::MarkedAction::None {
            action = TableAction::Marked(marked);
        }
        let modifiers = ui.input(|i| i.modifiers);
        let mut table = TableBuilder::new(ui)
            .id_salt("clowders-table")
            .striped(true)
            .resizable(true)
            .sense(Sense::click())
            .cell_layout(egui::Layout::left_to_right(egui::Align::Center))
            .min_scrolled_height(0.0)
            // The tick that lays it on the desk, then the star.
            .column(TableColumn::exact(28.0))
            .column(TableColumn::exact(28.0));
        if let Some(row) = self.scroll_to.take() {
            table = table.scroll_to_row(row, None);
        }
        for _ in Column::ALL {
            table = table.column(TableColumn::auto().at_least(60.0).resizable(true));
        }
        table = table.column(TableColumn::remainder());
        let mut sort_click: Option<Column> = None;
        let mut clicked: Option<(String, egui::Modifiers)> = None;
        let mut set_open: Option<(String, bool)> = None;
        table
            .header(28.0, |mut header| {
                header.col(|_| {});
                header.col(|ui| {
                    icons::glyph(ui, icons::STAR, 16.0, PALETTE.grey);
                });
                for column in Column::ALL {
                    header.col(|ui| {
                        let sorted = self.sort.filter(|(c, _)| *c == column);
                        let label = column.label(t, store, pet_mode);
                        let response = ui.add(egui::Button::selectable(
                            sorted.is_some(),
                            egui::RichText::new(label).strong(),
                        ));
                        if let Some((_, descending)) = sorted {
                            let icon = if descending {
                                icons::ARROW_DOWNWARD
                            } else {
                                icons::ARROW_UPWARD
                            };
                            icons::glyph(ui, icon, 14.0, PALETTE.orange);
                        }
                        if response.clicked() {
                            sort_click = Some(column);
                        }
                    });
                }
                header.col(|_| {});
            })
            .body(|body| {
                body.rows(34.0, rows.len(), |mut row| {
                    let r = &rows[row.index()];
                    let id = r.row.view.id.clone();
                    row.col(|ui| {
                        let mut on = open.contains(&id);
                        let response =
                            crate::icons::check_box(ui, &mut on, "").on_hover_text(t.on_the_desk());
                        let words = t.on_the_desk().to_string();
                        response.widget_info(|| {
                            egui::WidgetInfo::selected(egui::WidgetType::Checkbox, true, on, &words)
                        });
                        if response.changed() {
                            set_open = Some((id.clone(), on));
                        }
                    });
                    row.col(|ui| {
                        let (icon, tip, color) = if r.row.favourite {
                            (icons::STAR, t.favourite_remove(), PALETTE.orange)
                        } else {
                            (icons::STAR_BORDER, t.favourite_add(), PALETTE.grey)
                        };
                        let star = icons::glyph(ui, icon, 18.0, color)
                            .interact(Sense::click())
                            .on_hover_text(tip);
                        star.widget_info(|| {
                            egui::WidgetInfo::labeled(egui::WidgetType::Button, true, tip)
                        });
                        if star.clicked() {
                            action = TableAction::ToggleFavourite(id.clone());
                        }
                    });
                    let text = |s: &str| {
                        if r.row.hidden {
                            egui::RichText::new(s).weak()
                        } else {
                            egui::RichText::new(s)
                        }
                    };
                    row.col(|ui| {
                        // The cover leads the name where a place has one.
                        if let Some(texture) = store
                            .profile_image(&id)
                            .ok()
                            .flatten()
                            .and_then(|hash| faces.face(ui.ctx(), store, &hash))
                        {
                            ui.add(
                                egui::Image::from_texture(&texture)
                                    .fit_to_exact_size(egui::Vec2::splat(24.0))
                                    .corner_radius(4.0),
                            );
                        }
                        ui.add(egui::Label::new(text(&r.row.view.name)).selectable(false));
                    });
                    row.col(|ui| {
                        for (cat, hash) in &r.row.faces {
                            if let Some(texture) = faces.face(ui.ctx(), store, hash) {
                                let drawn = ui.add(
                                    egui::Image::from_texture(&texture)
                                        .fit_to_exact_size(egui::Vec2::splat(22.0))
                                        .corner_radius(11.0),
                                );
                                crate::textures::band_if_deceased(ui, store, cat, drawn.rect);
                            }
                        }
                        ui.add(
                            egui::Label::new(text(&r.row.cat_count.to_string())).selectable(false),
                        );
                    });
                    row.col(|ui| {
                        ui.add(egui::Label::new(text(&r.status)).selectable(false));
                    });
                    row.col(|ui| {
                        ui.add(
                            egui::Label::new(text(&r.address))
                                .selectable(false)
                                .truncate(),
                        );
                    });
                    row.col(|ui| {
                        let day = r
                            .last
                            .get(..10)
                            .and_then(|d| d.parse::<NaiveDate>().ok())
                            .map(|d| format_day(t.locale(), d))
                            .unwrap_or_default();
                        ui.add(egui::Label::new(text(&day)).selectable(false));
                    });
                    // The menu holds what the tick and the star do not:
                    // hiding.
                    let mut menu = |ui: &mut egui::Ui| {
                        let hide = if r.row.hidden {
                            t.unhide_label()
                        } else {
                            t.hide_label()
                        };
                        if ui.button(hide).clicked() {
                            action = TableAction::ToggleHidden(id.clone());
                            ui.close();
                        }
                    };
                    row.col(|ui| {
                        crate::icons::more(ui, &mut menu);
                    });
                    row.set_selected(
                        self.selected.contains(&id) || self.cursor.as_deref() == Some(id.as_str()),
                    );
                    let response = row.response();
                    response.context_menu(&mut menu);
                    if response.clicked() {
                        clicked = Some((id.clone(), modifiers));
                    }
                });
            });
        if let Some(column) = sort_click {
            self.sort = match self.sort {
                Some((c, false)) if c == column => Some((column, true)),
                Some((c, true)) if c == column => None,
                _ => Some((column, false)),
            };
        }
        if let Some((id, modifiers)) = clicked {
            self.select(&id, modifiers);
        }
        if let Some((id, on)) = set_open {
            // A tick on a marked row speaks for every marked row.
            let ids = if self.selected.contains(&id) {
                self.selected_in_order()
            } else {
                vec![id]
            };
            action = TableAction::SetOpen(ids, on);
        }
        action
    }
}
