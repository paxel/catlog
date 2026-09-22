//! The Home view: a dashboard with the counts, what is due today with a
//! tick and a finish, the last changes, and the Cat and Clowder looked
//! at last so the keeper picks up where they left off.

use catlog_core::agenda::{AgendaItem, ChoresAgenda};
use catlog_core::flier::target::MISSING_SINCE;
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, keys};
use chrono::NaiveDate;
use egui::{Ui, Vec2};

use crate::agenda::{AppointmentAction, appointment_card};
use crate::chores::{ChoreAction, chore_row};
use crate::icons;
use crate::l10n::L10n;
use crate::labels::{field_label, format_day, value_label};
use crate::memo::Memo;
use crate::textures::FaceCache;
use crate::theme::PALETTE;

/// Local settings that remember the last viewed Cat and Clowder.
pub const LAST_CAT: &str = "last:cat";
pub const LAST_CLOWDER: &str = "last:clowder";

/// How many recent changes the dashboard lists.
pub const RECENT_SHOWN: usize = 8;

/// What the keeper did on the dashboard this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum DashboardAction {
    None,
    OpenCats,
    OpenClowders,
    OpenStrays,
    OpenMissing,
    OpenCat(String),
    OpenClowder(String),
    Chore(ChoreAction),
    Appointment(AppointmentAction),
}

/// The counts on the tiles.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct Counts {
    pub cats: usize,
    pub clowders: usize,
    pub strays: usize,
    pub missing: usize,
}

pub fn counts(store: &Catalog) -> Counts {
    let cats = store.cats(None).unwrap_or_default();
    let missing = cats
        .iter()
        .filter(|c| store.current(&c.id, MISSING_SINCE).ok().flatten().is_some())
        .count();
    Counts {
        cats: cats.len(),
        clowders: store.clowders().map(|c| c.len()).unwrap_or(0),
        strays: store.strays().map(|s| s.len()).unwrap_or(0),
        missing,
    }
}

/// One line of the recent changes: when, who changed, what to.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Change {
    pub entity: String,
    pub name: String,
    pub line: String,
}

/// The last changes to Cats and Clowders, newest first.
pub fn recent_changes(store: &Catalog, t: &L10n, units: UnitSystem) -> Vec<Change> {
    let mut entries = store.all_entries().unwrap_or_default();
    entries.retain(|e| {
        (e.entity.starts_with("cat:") || e.entity.starts_with("clowder:"))
            && !e.field.starts_with('$')
    });
    entries.sort_by(|a, b| b.recorded.cmp(&a.recorded));
    let mut out = Vec::new();
    for e in entries {
        if out.len() >= RECENT_SHOWN {
            break;
        }
        let Some(name) = store.current(&e.entity, keys::NAME).ok().flatten() else {
            continue;
        };
        let day = e
            .recorded
            .get(..10)
            .and_then(|d| d.parse::<NaiveDate>().ok())
            .map(|d| format_day(t.locale(), d))
            .unwrap_or_default();
        let line = format!(
            "{day} · {}: {}",
            field_label(t, store, &e.field),
            value_label(t, store, &e.field, e.value.as_deref(), units)
        );
        out.push(Change {
            entity: e.entity,
            name,
            line,
        });
    }
    out
}

/// Remembers `id` as the last viewed Cat or Clowder.
pub fn remember(store: &Catalog, id: &str) {
    let key = if id.starts_with("clowder:") {
        LAST_CLOWDER
    } else if id.starts_with("cat:") {
        LAST_CAT
    } else {
        return;
    };
    let _ = store.set_local_setting(key, id);
}

/// The last viewed Cat and Clowder, when they still exist.
pub fn last_viewed(store: &Catalog) -> (Option<String>, Option<String>) {
    let alive = |key: &str| {
        store
            .local_setting(key)
            .filter(|id| store.current(id, keys::NAME).ok().flatten().is_some())
    };
    (alive(LAST_CAT), alive(LAST_CLOWDER))
}

/// What the dashboard shows, as built for one write of the store.
#[derive(Debug, Clone, Default)]
pub struct DashboardData {
    pub counts: Counts,
    pub chores: ChoresAgenda,
    pub items: Vec<AgendaItem>,
    pub changes: Vec<Change>,
}

/// The dashboard's data between frames.
pub type DashboardMemo = Memo<(NaiveDate, UnitSystem, String), DashboardData>;

/// Draws the dashboard and says what the keeper did.
pub fn show_dashboard(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    faces: &mut FaceCache,
    memo: &mut DashboardMemo,
    today: NaiveDate,
    units: UnitSystem,
) -> DashboardAction {
    let mut action = DashboardAction::None;
    let pet_mode = store.is_pet_mode().unwrap_or(false);
    let data = memo.get(store, (today, units, t.locale().to_string()), || {
        DashboardData {
            counts: counts(store),
            chores: store.chores_agenda(today).unwrap_or_default(),
            items: store.agenda_items().unwrap_or_default(),
            changes: recent_changes(store, t, units),
        }
    });
    egui::ScrollArea::vertical().show(ui, |ui| {
        let n = data.counts;
        ui.horizontal(|ui| {
            let cats = if pet_mode {
                t.cats_count_neutral(n.cats as i64)
            } else {
                t.cats_count(n.cats as i64)
            };
            if tile(ui, icons::PETS_OUTLINED, &cats).clicked() {
                action = DashboardAction::OpenCats;
            }
            if tile(
                ui,
                icons::NIGHT_SHELTER_OUTLINED,
                &t.clowders_count(n.clowders as i64),
            )
            .clicked()
            {
                action = DashboardAction::OpenClowders;
            }
            let strays = tile(ui, icons::PETS, &t.strays_count(n.strays as i64));
            crate::tips::anchor(ui, "home-strays", &strays);
            if strays.clicked() {
                action = DashboardAction::OpenStrays;
            }
            if tile(
                ui,
                icons::CAMPAIGN_OUTLINED,
                &t.missing_count(n.missing as i64),
            )
            .clicked()
            {
                action = DashboardAction::OpenMissing;
            }
        });
        ui.add_space(12.0);
        ui.columns(2, |cols| {
            let left = &mut cols[0];
            section(left, t.dashboard_due());
            let chores = &data.chores;
            let due: Vec<_> = data
                .items
                .iter()
                .filter_map(|item| match item {
                    AgendaItem::Appointments(group) if item.when().date() <= today => Some(group),
                    _ => None,
                })
                .collect();
            if chores.today.is_empty() && due.is_empty() {
                left.label(t.dashboard_nothing_due());
            }
            for c in &chores.today {
                let a = chore_row(left, store, t, c, today);
                if a != ChoreAction::None {
                    action = DashboardAction::Chore(a);
                }
            }
            for group in due {
                if let Some(a) = appointment_card(left, store, t, group, true) {
                    action = DashboardAction::Appointment(a);
                }
            }
            left.add_space(12.0);
            section(left, t.dashboard_recent());
            let changes = &data.changes;
            if changes.is_empty() {
                left.label(t.dashboard_no_changes());
            }
            for change in changes {
                left.horizontal(|ui| {
                    if ui.link(&change.name).clicked() {
                        action = if change.entity.starts_with("clowder:") {
                            DashboardAction::OpenClowder(change.entity.clone())
                        } else {
                            DashboardAction::OpenCat(change.entity.clone())
                        };
                    }
                    ui.label(&change.line);
                });
            }
            let right = &mut cols[1];
            section(right, t.dashboard_last_viewed());
            let (cat, clowder) = last_viewed(store);
            if cat.is_none() && clowder.is_none() {
                right.label(t.dashboard_nothing_viewed());
            }
            if let Some(id) = cat
                && miniature(right, store, t, faces, &id).clicked()
            {
                action = DashboardAction::OpenCat(id);
            }
            if let Some(id) = clowder
                && miniature(right, store, t, faces, &id).clicked()
            {
                action = DashboardAction::OpenClowder(id);
            }
        });
    });
    action
}

fn section(ui: &mut Ui, title: &str) {
    ui.label(egui::RichText::new(title).strong().size(16.0));
    ui.add_space(4.0);
}

/// A count as a big pill with its icon.
fn tile(ui: &mut Ui, icon: &str, text: &str) -> egui::Response {
    let id = egui::Id::new(("tile", icon)).with(ui.next_auto_id());
    let rich = egui::RichText::new(text).size(18.0);
    let response = egui::Button::new((
        egui::Atom::custom(id, Vec2::splat(22.0)),
        egui::WidgetText::from(rich),
    ))
    .min_size(Vec2::new(160.0, 56.0))
    .atom_ui(ui);
    if let Some(rect) = response.rect(id) {
        let color = ui.style().interact(&response.response).fg_stroke.color;
        icons::paint(ui, rect, icon, color);
    }
    response.response
}

/// A Cat or Clowder in miniature: its face, its name and where it
/// belongs. The whole card is one button named after the record.
fn miniature(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    faces: &mut FaceCache,
    id: &str,
) -> egui::Response {
    let name = store
        .current(id, keys::NAME)
        .ok()
        .flatten()
        .unwrap_or_else(|| t.unnamed().to_string());
    let is_cat = id.starts_with("cat:");
    let below = if is_cat {
        store
            .current(id, keys::CLOWDER)
            .ok()
            .flatten()
            .and_then(|c| store.current(&c, keys::NAME).ok().flatten())
            .unwrap_or_else(|| t.strays().to_string())
    } else {
        let count = store.cats(Some(id)).map(|c| c.len()).unwrap_or(0);
        t.cats_count(count as i64)
    };
    let face = if is_cat {
        store.profile_image(id).ok().flatten()
    } else {
        store
            .cats(Some(id))
            .unwrap_or_default()
            .iter()
            .find_map(|c| store.profile_image(&c.id).ok().flatten())
    };
    let frame = egui::Frame::new()
        .fill(PALETTE.paper)
        .stroke(egui::Stroke::new(1.0, PALETTE.tan))
        .corner_radius(crate::theme::ROUNDING)
        .inner_margin(10.0);
    let inner = frame
        .show(ui, |ui| {
            ui.set_width(260.0);
            ui.horizontal(|ui| {
                match face.and_then(|hash| faces.face(ui.ctx(), store, &hash)) {
                    Some(texture) => {
                        ui.add(
                            egui::Image::from_texture(&texture)
                                .fit_to_exact_size(Vec2::splat(48.0))
                                .corner_radius(24.0),
                        );
                    }
                    None => {
                        let icon = if is_cat {
                            icons::PETS_OUTLINED
                        } else {
                            icons::NIGHT_SHELTER_OUTLINED
                        };
                        icons::glyph(ui, icon, 48.0, PALETTE.grey);
                    }
                }
                ui.vertical(|ui| {
                    ui.label(egui::RichText::new(&name).strong().size(16.0));
                    ui.label(egui::RichText::new(below).weak());
                });
            });
        })
        .response;
    let response = inner.interact(egui::Sense::click());
    response.widget_info(|| egui::WidgetInfo::labeled(egui::WidgetType::Button, true, &name));
    response
}
