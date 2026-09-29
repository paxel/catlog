//! The Family view: every Cat in the Catalog as its face and its name,
//! oldest at the top and newest at the bottom, grouped by the month it
//! was born in, with a line drawn between a cat and its mother or
//! father. A litter — the same mother, the same birth day — stands
//! together, because the app derives a litter and never stores one.

use std::collections::BTreeMap;

use catlog_core::{Catalog, keys};
use chrono::{Datelike, NaiveDate};
use egui::{Pos2, Rect, Ui, Vec2};

use crate::l10n::L10n;
use crate::labels::format_partial_date;
use crate::textures::FaceCache;
use crate::theme::PALETTE;

/// One cat in the tree.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Kin {
    pub id: String,
    pub name: String,
    pub face: Option<String>,
    pub mother: Option<String>,
    pub father: Option<String>,
    pub born: Option<NaiveDate>,
    /// The mother and the birth day together: a litter's own mark.
    pub litter: Option<String>,
}

/// The cats of one month, or of the group for those whose birth day
/// nobody wrote down.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Month {
    /// None for the group with the question mark.
    pub month: Option<(i32, u32)>,
    pub cats: Vec<Kin>,
}

/// The whole tree, built once per write of the store.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct Tree {
    pub months: Vec<Month>,
}

/// What the view shows, built from the store: the months that hold
/// somebody, oldest first, and last the cats with kin but no birth day.
pub fn tree(store: &Catalog) -> Tree {
    let mut kin = Vec::new();
    for cat in store.cats(None).unwrap_or_default() {
        let value = |slug: &str| {
            store
                .current(&cat.id, &keys::user_field(slug))
                .ok()
                .flatten()
                .and_then(|id| store.resolve_entity(&id).ok())
        };
        let mother = value("mother");
        let father = value("father");
        let born = store
            .current(&cat.id, &keys::user_field("birthdate"))
            .ok()
            .flatten()
            .and_then(|raw| catlog_core::PartialDate::parse(&raw))
            .and_then(|date| date.earliest());
        kin.push(Kin {
            id: cat.id.clone(),
            name: cat.name.clone(),
            face: store.profile_image(&cat.id).ok().flatten(),
            litter: mother
                .as_ref()
                .zip(born)
                .map(|(mother, born)| format!("{mother}|{born}")),
            mother,
            father,
            born,
        });
    }
    // Only cats that are part of a family: the view is about kin, not a
    // second list of every cat.
    let related: std::collections::BTreeSet<String> = kin
        .iter()
        .flat_map(|k| {
            let mut out = Vec::new();
            if k.mother.is_some() || k.father.is_some() {
                out.push(k.id.clone());
            }
            out.extend(k.mother.clone());
            out.extend(k.father.clone());
            out
        })
        .collect();
    kin.retain(|k| related.contains(&k.id));
    let mut by_month: BTreeMap<Option<(i32, u32)>, Vec<Kin>> = BTreeMap::new();
    for k in kin {
        by_month
            .entry(k.born.map(|d| (d.year(), d.month())))
            .or_default()
            .push(k);
    }
    let mut months: Vec<Month> = by_month
        .into_iter()
        .map(|(month, mut cats)| {
            // Littermates side by side, then by name.
            cats.sort_by(|a, b| {
                a.litter
                    .cmp(&b.litter)
                    .then_with(|| a.born.cmp(&b.born))
                    .then_with(|| a.name.cmp(&b.name))
            });
            Month { month, cats }
        })
        .collect();
    // A month nobody was born in is not a row; the unknown ones come
    // last, whatever their names.
    months.retain(|m| !m.cats.is_empty());
    months.sort_by_key(|m| (m.month.is_none(), m.month));
    Tree { months }
}

const FACE: f32 = 56.0;
const CELL: Vec2 = Vec2::new(96.0, 92.0);

/// Draws the tree; the id of a cat whose face was clicked.
pub fn show_family(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    faces: &mut FaceCache,
    tree: &Tree,
) -> Option<String> {
    let mut opened = None;
    if tree.months.is_empty() {
        ui.label(t.family_empty());
        return None;
    }
    egui::ScrollArea::vertical()
        .id_salt("family")
        .show(ui, |ui| {
            let mut places: BTreeMap<String, Rect> = BTreeMap::new();
            for month in &tree.months {
                let heading = match month.month {
                    Some((year, month)) => format_partial_date(
                        t.locale(),
                        &catlog_core::PartialDate {
                            year,
                            month: Some(month),
                            day: None,
                        },
                    ),
                    None => format!("? {}", t.family_unknown_birth()),
                };
                ui.add_space(10.0);
                ui.label(egui::RichText::new(heading).strong());
                ui.separator();
                ui.horizontal_wrapped(|ui| {
                    for cat in &month.cats {
                        let (rect, response) = ui.allocate_exact_size(CELL, egui::Sense::click());
                        places.insert(cat.id.clone(), rect);
                        let face_rect = Rect::from_center_size(
                            Pos2::new(rect.center().x, rect.top() + FACE / 2.0 + 2.0),
                            Vec2::splat(FACE),
                        );
                        match cat
                            .face
                            .as_ref()
                            .and_then(|hash| faces.face(ui.ctx(), store, hash))
                        {
                            Some(texture) => {
                                egui::Image::from_texture(&texture)
                                    .fit_to_exact_size(Vec2::splat(FACE))
                                    .corner_radius(FACE / 2.0)
                                    .paint_at(ui, face_rect);
                            }
                            None => {
                                crate::icons::paint(
                                    ui,
                                    face_rect,
                                    crate::icons::PETS_OUTLINED,
                                    PALETTE.grey,
                                );
                            }
                        }
                        crate::textures::band_if_deceased(ui, store, &cat.id, face_rect);
                        ui.painter().text(
                            Pos2::new(rect.center().x, face_rect.bottom() + 4.0),
                            egui::Align2::CENTER_TOP,
                            &cat.name,
                            egui::FontId::proportional(12.0),
                            PALETTE.ink,
                        );
                        let name = cat.name.clone();
                        response.widget_info(|| {
                            egui::WidgetInfo::labeled(egui::WidgetType::Button, true, &name)
                        });
                        if response.clicked() {
                            opened = Some(cat.id.clone());
                        }
                    }
                });
            }
            // The lines last, so a face is never drawn over: from a
            // parent's chin to the child's crown.
            let painter = ui.painter();
            for month in &tree.months {
                for cat in &month.cats {
                    let Some(child) = places.get(&cat.id) else {
                        continue;
                    };
                    for parent in [&cat.mother, &cat.father].into_iter().flatten() {
                        let Some(from) = places.get(parent) else {
                            continue;
                        };
                        let start = Pos2::new(from.center().x, from.bottom() - 6.0);
                        let end = Pos2::new(child.center().x, child.top() + 2.0);
                        let middle = (start.y + end.y) / 2.0;
                        painter.add(egui::Shape::CubicBezier(
                            egui::epaint::CubicBezierShape::from_points_stroke(
                                [
                                    start,
                                    Pos2::new(start.x, middle),
                                    Pos2::new(end.x, middle),
                                    end,
                                ],
                                false,
                                egui::Color32::TRANSPARENT,
                                egui::Stroke::new(1.5, PALETTE.orange.gamma_multiply(0.7)),
                            ),
                        ));
                    }
                }
            }
        });
    opened
}

#[cfg(test)]
mod tests {
    use super::*;

    fn store() -> (tempfile::TempDir, Catalog) {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        for (id, name) in [
            ("cat:mum", "Mum"),
            ("cat:a", "Anna"),
            ("cat:b", "Bert"),
            ("cat:c", "Cleo"),
            ("cat:alone", "Alone"),
        ] {
            c.create_cat(id, name, None, "cat").unwrap();
        }
        c.append("cat:mum", "f:birthdate", Some("2020-01-05"))
            .unwrap();
        // A litter: the same mother, the same day.
        for id in ["cat:a", "cat:b"] {
            c.append(id, "f:mother", Some("cat:mum")).unwrap();
            c.append(id, "f:birthdate", Some("2023-04-10")).unwrap();
        }
        // Another kitten of hers, a month later, and one without a day.
        c.append("cat:c", "f:mother", Some("cat:mum")).unwrap();
        c.append("cat:c", "f:birthdate", Some("2023-05-02"))
            .unwrap();
        (dir, c)
    }

    #[test]
    fn the_tree_holds_the_months_that_have_somebody_oldest_first() {
        let (_dir, store) = store();
        let tree = tree(&store);
        let months: Vec<Option<(i32, u32)>> = tree.months.iter().map(|m| m.month).collect();
        assert_eq!(
            months,
            vec![Some((2020, 1)), Some((2023, 4)), Some((2023, 5))],
            "no empty months, oldest first"
        );
        let names: Vec<&str> = tree.months[1]
            .cats
            .iter()
            .map(|c| c.name.as_str())
            .collect();
        assert_eq!(names, vec!["Anna", "Bert"], "littermates together");
        // A cat with no kin at all is not in the tree.
        assert!(
            !tree
                .months
                .iter()
                .any(|m| m.cats.iter().any(|c| c.name == "Alone")),
            "the view is about kin"
        );
    }

    #[test]
    fn a_kitten_without_a_birth_day_comes_last_under_the_question_mark() {
        let (_dir, mut store) = store();
        store.create_cat("cat:x", "Nobody", None, "cat").unwrap();
        store.append("cat:x", "f:father", Some("cat:mum")).unwrap();
        let tree = tree(&store);
        let last = tree.months.last().expect("a group");
        assert_eq!(last.month, None, "the question mark comes last");
        assert!(last.cats.iter().any(|c| c.name == "Nobody"));
    }
}
