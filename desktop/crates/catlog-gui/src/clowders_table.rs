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
    /// Enter or a double-click: the Clowder's card.
    Open(String),
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
    order: Vec<String>,
    scroll_to: Option<usize>,
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
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut crate::textures::FaceCache,
        units: UnitSystem,
        show_hidden: bool,
    ) -> TableAction {
        let mut action = TableAction::None;
        // A resizable pane shrinks to its content; the table claims the
        // whole width so the width the keeper chose holds.
        ui.set_min_width(ui.available_width());
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        let strays = store.strays().map(|s| s.len()).unwrap_or(0);
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
        let rows = self.sorted(rows(store, t, units, show_hidden));
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
        let mut table = TableBuilder::new(ui)
            .id_salt("clowders-table")
            .striped(true)
            .resizable(true)
            .sense(Sense::click())
            .cell_layout(egui::Layout::left_to_right(egui::Align::Center))
            .min_scrolled_height(0.0)
            .column(TableColumn::exact(28.0));
        if let Some(row) = self.scroll_to.take() {
            table = table.scroll_to_row(row, None);
        }
        for _ in Column::ALL {
            table = table.column(TableColumn::auto().at_least(60.0).resizable(true));
        }
        table = table.column(TableColumn::remainder());
        let mut sort_click: Option<Column> = None;
        let mut clicked: Option<String> = None;
        table
            .header(28.0, |mut header| {
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
                    row.set_selected(self.cursor.as_deref() == Some(id.as_str()));
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
                        ui.add(egui::Label::new(text(&r.row.view.name)).selectable(false));
                    });
                    row.col(|ui| {
                        for hash in &r.row.faces {
                            if let Some(texture) = faces.face(ui.ctx(), store, hash) {
                                ui.add(
                                    egui::Image::from_texture(&texture)
                                        .fit_to_exact_size(egui::Vec2::splat(22.0))
                                        .corner_radius(11.0),
                                );
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
                    row.col(|_| {});
                    let response = row.response();
                    if response.double_clicked() {
                        action = TableAction::Open(id.clone());
                    } else if response.clicked() {
                        clicked = Some(id.clone());
                    }
                    response.context_menu(|ui| {
                        if ui.button(t.open()).clicked() {
                            action = TableAction::Open(id.clone());
                            ui.close();
                        }
                        let fav = if r.row.favourite {
                            t.favourite_remove()
                        } else {
                            t.favourite_add()
                        };
                        if ui.button(fav).clicked() {
                            action = TableAction::ToggleFavourite(id.clone());
                            ui.close();
                        }
                        let hide = if r.row.hidden {
                            t.unhide_label()
                        } else {
                            t.hide_label()
                        };
                        if ui.button(hide).clicked() {
                            action = TableAction::ToggleHidden(id.clone());
                            ui.close();
                        }
                    });
                });
            });
        if let Some(column) = sort_click {
            self.sort = match self.sort {
                Some((c, false)) if c == column => Some((column, true)),
                Some((c, true)) if c == column => None,
                _ => Some((column, false)),
            };
        }
        if let Some(id) = clicked {
            self.cursor = Some(id);
        }
        action
    }
}
