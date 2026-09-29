//! The Home view: a dashboard with the counts, what is due today with a
//! tick and a finish, the last changes, and the Cat and Clowder looked
//! at last so the keeper picks up where they left off.

use catlog_core::agenda::{AgendaItem, ChoresAgenda};
use catlog_core::flier::target::MISSING_SINCE;
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, keys};
use chrono::{Datelike, NaiveDate, NaiveDateTime};
use egui::{Ui, Vec2};

use crate::agenda::{AppointmentAction, appointment_card};
use crate::chores::{ChoreAction, chore_row};
use crate::icons;
use crate::l10n::L10n;
use crate::labels::{format_day, weekday_full};
use crate::memo::Memo;
use crate::sections::section_card;
use crate::textures::FaceCache;
use crate::theme::PALETTE;

/// Local settings that remember the last viewed Cat and Clowder.
/// How many of the last viewed the dashboard lists.
pub const LAST_VIEWED: usize = 7;
/// The local setting holding them, newest first, comma-separated.
pub const LAST_VIEWED_KEY: &str = "last:viewed";
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

/// One line of the recent changes: when, who changed, what to, and the
/// face of whom.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Change {
    pub entity: String,
    pub name: String,
    /// The field and its new value.
    pub line: String,
    /// The moment it was recorded, in local time.
    pub at: NaiveDateTime,
    /// The profile picture of the cat, the cover of the clowder.
    pub face: Option<String>,
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
        let at = chrono::DateTime::parse_from_rfc3339(&e.recorded)
            .map(|d| d.with_timezone(&chrono::Local).naive_local())
            .unwrap_or_default();
        let line = crate::labels::change_line(
            t,
            store,
            &e.field,
            e.value.as_deref(),
            units,
            Some(at.date()),
        );
        out.push(Change {
            face: store.profile_image(&e.entity).ok().flatten(),
            entity: e.entity,
            name,
            line,
            at,
        });
    }
    out
}

/// The heading a day's changes stand under: today and yesterday by
/// their words, any other day by its weekday and date.
pub fn day_heading(t: &L10n, today: NaiveDate, day: NaiveDate) -> String {
    if day == today {
        t.today_section().to_string()
    } else if day.succ_opt() == Some(today) {
        t.yesterday().to_string()
    } else {
        format!(
            "{}, {}",
            weekday_full(t, day.weekday().number_from_monday()),
            format_day(t.locale(), day)
        )
    }
}

/// A Cat or Clowder as the "Last viewed" tile shows it: the face or the
/// cover, the name, and where it belongs or what it holds.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Mini {
    pub id: String,
    pub name: String,
    pub below: String,
    pub face: Option<String>,
}

fn mini(store: &Catalog, t: &L10n, id: &str) -> Mini {
    let name = store
        .current(id, keys::NAME)
        .ok()
        .flatten()
        .unwrap_or_else(|| t.unnamed().to_string());
    let below = if id.starts_with("cat:") {
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
    Mini {
        id: id.to_string(),
        name,
        below,
        // A clowder's cover is its profile image, as on the phone.
        face: store.profile_image(id).ok().flatten(),
    }
}

/// Remembers `id` as the last viewed Cat or Clowder: to the front of
/// the list, once, with the oldest dropped when the list is full.
pub fn remember(store: &Catalog, id: &str) {
    if !(id.starts_with("cat:") || id.starts_with("clowder:")) {
        return;
    }
    let mut seen = viewed_ids(store);
    seen.retain(|other| other != id);
    seen.insert(0, id.to_string());
    seen.truncate(LAST_VIEWED);
    let _ = store.set_local_setting(LAST_VIEWED_KEY, &seen.join(","));
}

/// The ids the list holds, oldest two settings folded in once so that a
/// catalog from before this version does not start empty.
fn viewed_ids(store: &Catalog) -> Vec<String> {
    match store.local_setting(LAST_VIEWED_KEY) {
        Some(saved) => saved
            .split(',')
            .filter(|s| !s.is_empty())
            .map(String::from)
            .collect(),
        None => [LAST_CAT, LAST_CLOWDER]
            .into_iter()
            .filter_map(|key| store.local_setting(key))
            .collect(),
    }
}

/// The Cats and Clowders last viewed, newest first, those that still
/// exist.
pub fn last_viewed(store: &Catalog) -> Vec<String> {
    viewed_ids(store)
        .into_iter()
        .filter(|id| {
            store.current(id, keys::NAME).ok().flatten().is_some()
                && !store.is_deleted(id).unwrap_or(false)
        })
        .take(LAST_VIEWED)
        .collect()
}

/// What the dashboard shows, as built for one write of the store.
#[derive(Debug, Clone, Default)]
pub struct DashboardData {
    pub counts: Counts,
    pub chores: ChoresAgenda,
    pub items: Vec<AgendaItem>,
    pub changes: Vec<Change>,
    pub last_viewed: Vec<Mini>,
}

/// The dashboard's data between frames.
pub type DashboardMemo = Memo<(NaiveDate, UnitSystem, String), DashboardData>;

/// Draws the dashboard and says what the keeper did: the counts as
/// tiles, then the sections as cards.
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
            last_viewed: last_viewed(store)
                .iter()
                .map(|id| mini(store, t, id))
                .collect(),
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
            section_card(left, t.dashboard_due(), |ui| {
                let chores = &data.chores;
                let due: Vec<_> = data
                    .items
                    .iter()
                    .filter_map(|item| match item {
                        AgendaItem::Appointments(group) if item.when().date() <= today => {
                            Some(group)
                        }
                        _ => None,
                    })
                    .collect();
                if chores.today.is_empty() && due.is_empty() {
                    ui.label(t.dashboard_nothing_due());
                }
                for c in &chores.today {
                    let a = chore_row(ui, store, t, faces, c, today);
                    if a != ChoreAction::None {
                        action = DashboardAction::Chore(a);
                    }
                }
                for group in due {
                    if let Some(a) = appointment_card(ui, store, t, faces, group, true) {
                        action = DashboardAction::Appointment(a);
                    }
                }
            });
            left.add_space(12.0);
            section_card(left, t.dashboard_recent(), |ui| {
                let changes = &data.changes;
                if changes.is_empty() {
                    ui.label(t.dashboard_no_changes());
                }
                // One heading per day that had a change; the time on
                // every line, the face of whom it was about.
                let mut day = None;
                for change in changes {
                    if day != Some(change.at.date()) {
                        day = Some(change.at.date());
                        if changes.first() != Some(change) {
                            ui.add_space(6.0);
                        }
                        ui.label(
                            egui::RichText::new(day_heading(t, today, change.at.date())).strong(),
                        );
                    }
                    ui.horizontal(|ui| {
                        ui.label(egui::RichText::new(change.at.format("%H:%M").to_string()).weak());
                        let drawn = match change
                            .face
                            .as_deref()
                            .and_then(|hash| faces.face(ui.ctx(), store, hash))
                        {
                            Some(texture) => ui.add(
                                egui::Image::from_texture(&texture)
                                    .fit_to_exact_size(Vec2::splat(20.0))
                                    .corner_radius(10.0),
                            ),
                            None => {
                                let icon = if change.entity.starts_with("cat:") {
                                    icons::PETS_OUTLINED
                                } else {
                                    icons::NIGHT_SHELTER_OUTLINED
                                };
                                icons::glyph(ui, icon, 20.0, PALETTE.grey)
                            }
                        };
                        if change.entity.starts_with("cat:") {
                            crate::textures::band_if_deceased(
                                ui,
                                store,
                                &change.entity,
                                drawn.rect,
                            );
                        }
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
            });
            let right = &mut cols[1];
            section_card(right, t.dashboard_last_viewed(), |ui| {
                if data.last_viewed.is_empty() {
                    ui.label(t.dashboard_nothing_viewed());
                }
                for m in &data.last_viewed {
                    if miniature(ui, store, faces, m).clicked() {
                        action = if m.id.starts_with("clowder:") {
                            DashboardAction::OpenClowder(m.id.clone())
                        } else {
                            DashboardAction::OpenCat(m.id.clone())
                        };
                    }
                }
            });
        });
    });
    action
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

/// A Cat or Clowder in miniature: its face or cover, its name and where
/// it belongs. The whole card is one button named after the record.
fn miniature(ui: &mut Ui, store: &Catalog, faces: &mut FaceCache, m: &Mini) -> egui::Response {
    let is_cat = m.id.starts_with("cat:");
    let frame = egui::Frame::new()
        .fill(PALETTE.cream)
        .corner_radius(crate::theme::ROUNDING)
        .inner_margin(10.0);
    let inner = frame
        .show(ui, |ui| {
            ui.set_width(ui.available_width());
            ui.horizontal(|ui| {
                let drawn = match m
                    .face
                    .as_deref()
                    .and_then(|hash| faces.face(ui.ctx(), store, hash))
                {
                    Some(texture) => ui.add(
                        egui::Image::from_texture(&texture)
                            .fit_to_exact_size(Vec2::splat(48.0))
                            .corner_radius(24.0),
                    ),
                    None => {
                        let icon = if is_cat {
                            icons::PETS_OUTLINED
                        } else {
                            icons::NIGHT_SHELTER_OUTLINED
                        };
                        icons::glyph(ui, icon, 48.0, PALETTE.grey)
                    }
                };
                if is_cat {
                    crate::textures::band_if_deceased(ui, store, &m.id, drawn.rect);
                }
                ui.vertical(|ui| {
                    ui.label(egui::RichText::new(&m.name).strong().size(16.0));
                    ui.label(egui::RichText::new(&m.below).weak());
                });
            });
        })
        .response;
    let response = inner.interact(egui::Sense::click());
    response.widget_info(|| egui::WidgetInfo::labeled(egui::WidgetType::Button, true, &m.name));
    response
}

#[cfg(test)]
mod tests {
    use super::*;

    fn store() -> (tempfile::TempDir, Catalog) {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        for (id, name) in [
            ("cat:a", "Miezi"),
            ("cat:b", "Tom"),
            ("cat:c", "Wanderer"),
            ("cat:d", "Pixel"),
            ("cat:e", "Schnurr"),
            ("cat:f", "Socke"),
            ("cat:g", "Sonne"),
            ("cat:h", "Mohrle"),
        ] {
            c.create_cat(id, name, None, "cat").unwrap();
        }
        c.create_clowder("clowder:h", "Barn").unwrap();
        (dir, c)
    }

    #[test]
    fn the_last_viewed_is_a_list_of_seven_newest_first() {
        let (_dir, store) = store();
        for id in ["cat:a", "clowder:h", "cat:b"] {
            remember(&store, id);
        }
        assert_eq!(last_viewed(&store), ["cat:b", "clowder:h", "cat:a"]);
        // Looking again moves it to the front instead of listing it twice.
        remember(&store, "cat:a");
        assert_eq!(last_viewed(&store), ["cat:a", "cat:b", "clowder:h"]);
        // The eighth pushes the oldest out.
        for id in ["cat:c", "cat:d", "cat:e", "cat:f", "cat:g"] {
            remember(&store, id);
        }
        assert_eq!(last_viewed(&store).len(), LAST_VIEWED);
        remember(&store, "cat:h");
        let seen = last_viewed(&store);
        assert_eq!(seen.len(), LAST_VIEWED);
        assert_eq!(seen[0], "cat:h");
        assert!(!seen.contains(&"clowder:h".to_string()), "the oldest went");
        // Anything that is not a Cat or a Clowder is not remembered.
        remember(&store, "fielddef:weight");
        assert_eq!(last_viewed(&store)[0], "cat:h");
    }

    #[test]
    fn the_two_settings_from_before_seed_the_list_once() {
        let (_dir, store) = store();
        store.set_local_setting(LAST_CAT, "cat:a").unwrap();
        store.set_local_setting(LAST_CLOWDER, "clowder:h").unwrap();
        assert_eq!(last_viewed(&store), ["cat:a", "clowder:h"]);
        remember(&store, "cat:b");
        assert_eq!(last_viewed(&store), ["cat:b", "cat:a", "clowder:h"]);
    }

    #[test]
    fn a_record_that_is_gone_is_not_offered() {
        let (_dir, mut store) = store();
        remember(&store, "cat:a");
        remember(&store, "cat:b");
        store.delete_cat("cat:a").unwrap();
        assert_eq!(last_viewed(&store), ["cat:b"]);
    }
}
