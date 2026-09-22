//! The Vet view: every Vet Run and appointment across the cats, open
//! ones first, each finishable from its row; the selected cat's patient
//! sheet beside them, one click from the vet report.

use std::collections::BTreeSet;

use catlog_core::Catalog;
use catlog_core::appointments::Appointment;
use catlog_core::keys;
use catlog_core::units::UnitSystem;
use chrono::NaiveDate;
use egui::{Sense, Ui};
use egui_extras::{Column as TableColumn, TableBuilder};

use crate::agenda::AppointmentAction;
use crate::documents_page::{DocKind, patient_facts};
use crate::icons;
use crate::l10n::L10n;
use crate::labels::{clock, format_day};
use crate::pages::PageAction;
use crate::textures::FaceCache;
use crate::theme::PALETTE;

/// One run or appointment as the table shows it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Row {
    /// The first appointment of the group; the others are its run.
    pub first: Appointment,
    pub group: Vec<Appointment>,
    pub cats: Vec<(String, String)>,
}

/// The view's own state: the row picked and the sort.
#[derive(Debug, Default)]
pub struct VetView {
    /// The rows as built for the store's last write and the sort.
    rows: crate::memo::Memo<(bool, String), Vec<Row>>,
    /// The appointment id of the picked row.
    pub picked: Option<String>,
    /// Newest first when true; open rows always lead.
    pub descending: bool,
    order: Vec<String>,
}

/// The rows: every appointment of every cat, a run once, open ones
/// first and within each half by date.
pub fn rows(store: &Catalog, t: &L10n, descending: bool) -> Vec<Row> {
    let mut seen: BTreeSet<String> = BTreeSet::new();
    let mut out = Vec::new();
    for cat in store.cats(None).unwrap_or_default() {
        for a in store.appointments_of(&cat.id, true).unwrap_or_default() {
            let key = a.group.clone().unwrap_or_else(|| a.id.clone());
            if !seen.insert(key) {
                continue;
            }
            let mut group = store.group_of(&a).unwrap_or_default();
            if group.is_empty() {
                group = vec![a.clone()];
            }
            let cats = group
                .iter()
                .map(|m| {
                    let name = store
                        .current(&m.entity, keys::NAME)
                        .ok()
                        .flatten()
                        .unwrap_or_else(|| t.unnamed().to_string());
                    (m.entity.clone(), name)
                })
                .collect();
            out.push(Row {
                first: a,
                group,
                cats,
            });
        }
    }
    out.sort_by(|x, y| {
        let open = y.first.done.cmp(&x.first.done).reverse();
        open.then_with(|| {
            let order = x.first.start().cmp(&y.first.start());
            if descending { order.reverse() } else { order }
        })
    });
    out
}

impl VetView {
    /// The rows as last shown, by appointment id, top to bottom.
    pub fn order(&self) -> &[String] {
        &self.order
    }

    /// Draws the table and the patient sheet; says what the keeper did.
    #[allow(clippy::too_many_arguments)]
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        today: NaiveDate,
        units: UnitSystem,
        last_cat: Option<&str>,
    ) -> Option<PageAction> {
        let mut action = None;
        let rows = self
            .rows
            .get(store, (self.descending, t.locale().to_string()), || {
                rows(store, t, self.descending)
            })
            .clone();
        self.order = rows.iter().map(|r| r.first.id.clone()).collect();
        let picked_cat = self
            .picked
            .as_ref()
            .and_then(|id| rows.iter().find(|r| r.first.id == *id))
            .map(|r| r.first.entity.clone())
            .or_else(|| last_cat.map(String::from));
        egui::Panel::right("vet-patient")
            .resizable(true)
            .min_size(260.0)
            .default_size(360.0)
            .show(ui, |ui| {
                ui.set_min_width(ui.available_width());
                if let Some(a) =
                    self.patient_sheet(ui, store, t, faces, today, units, picked_cat.as_deref())
                {
                    action = Some(a);
                }
            });
        egui::CentralPanel::default().show(ui, |ui| {
            if rows.is_empty() {
                ui.label(t.vet_empty());
                return;
            }
            let mut sort_click = false;
            let mut picked: Option<String> = None;
            TableBuilder::new(ui)
                .id_salt("vet-table")
                .striped(true)
                .resizable(true)
                .sense(Sense::click())
                .cell_layout(egui::Layout::left_to_right(egui::Align::Center))
                .min_scrolled_height(0.0)
                .column(TableColumn::auto().at_least(120.0).resizable(true))
                .column(TableColumn::auto().at_least(120.0).resizable(true))
                .column(TableColumn::auto().at_least(100.0).resizable(true))
                .column(TableColumn::auto().at_least(70.0))
                .column(TableColumn::remainder())
                .header(28.0, |mut header| {
                    header.col(|ui| {
                        let label = egui::RichText::new(t.column_when()).strong();
                        if ui.add(egui::Button::selectable(true, label)).clicked() {
                            sort_click = true;
                        }
                        let icon = if self.descending {
                            icons::ARROW_DOWNWARD
                        } else {
                            icons::ARROW_UPWARD
                        };
                        icons::glyph(ui, icon, 14.0, PALETTE.orange);
                    });
                    for label in [
                        t.appointment_title_label(),
                        t.cats(),
                        t.column_status(),
                        t.notes_label(),
                    ] {
                        header.col(|ui| {
                            ui.add(
                                egui::Label::new(egui::RichText::new(label).strong())
                                    .selectable(false),
                            );
                        });
                    }
                })
                .body(|body| {
                    body.rows(34.0, rows.len(), |mut row| {
                        let r = &rows[row.index()];
                        let a = &r.first;
                        row.set_selected(self.picked.as_deref() == Some(a.id.as_str()));
                        row.col(|ui| {
                            let mut when = format_day(t.locale(), a.date);
                            if let Some(time) = a.time {
                                when.push(' ');
                                when.push_str(&clock(time));
                            }
                            ui.add(egui::Label::new(when).selectable(false));
                        });
                        row.col(|ui| {
                            ui.add(egui::Label::new(&a.title).selectable(false));
                        });
                        row.col(|ui| {
                            let names: Vec<&str> = r.cats.iter().map(|(_, n)| n.as_str()).collect();
                            ui.add(
                                egui::Label::new(names.join(", "))
                                    .selectable(false)
                                    .truncate(),
                            );
                        });
                        row.col(|ui| {
                            if a.done {
                                icons::label(ui, icons::CHECK_CIRCLE, t.done_label());
                            } else if icons::button(ui, icons::CHECK, t.finish_label()).clicked() {
                                action = Some(PageAction::Appointment(AppointmentAction::Finish(
                                    a.clone(),
                                )));
                            }
                        });
                        // The menu holds what the Finish button does not.
                        let mut menu = |ui: &mut egui::Ui| {
                            if ui.button(t.edit_label_appointment()).clicked() {
                                action = Some(PageAction::Appointment(AppointmentAction::Edit(
                                    a.clone(),
                                )));
                                ui.close();
                            }
                            let delete = if r.group.len() > 1 {
                                t.delete_appointment_group(r.group.len() as i64)
                            } else {
                                t.delete_appointment().to_string()
                            };
                            if ui.button(delete).clicked() {
                                action = Some(PageAction::Appointment(AppointmentAction::Delete(
                                    a.clone(),
                                    r.group.len() > 1,
                                )));
                                ui.close();
                            }
                        };
                        row.col(|ui| {
                            ui.horizontal(|ui| {
                                ui.add(egui::Label::new(&a.notes).selectable(false).truncate());
                                crate::icons::more(ui, &mut menu);
                            });
                        });
                        let response = row.response();
                        if response.clicked() {
                            picked = Some(a.id.clone());
                        }
                        response.context_menu(&mut menu);
                    });
                });
            if sort_click {
                self.descending = !self.descending;
            }
            if let Some(id) = picked {
                self.picked = Some(id);
            }
        });
        action
    }

    /// The patient: face, name, the summary the report opens with, and
    /// the way to the report.
    #[allow(clippy::too_many_arguments)]
    fn patient_sheet(
        &self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        today: NaiveDate,
        units: UnitSystem,
        cat: Option<&str>,
    ) -> Option<PageAction> {
        let mut action = None;
        ui.heading(t.vet_report_summary());
        let Some(cat) = cat else {
            ui.label(t.vet_pick_run());
            return None;
        };
        let name = store
            .current(cat, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string());
        ui.horizontal(|ui| {
            match store
                .profile_image(cat)
                .ok()
                .flatten()
                .and_then(|hash| faces.face(ui.ctx(), store, &hash))
            {
                Some(texture) => {
                    ui.add(
                        egui::Image::from_texture(&texture)
                            .fit_to_exact_size(egui::Vec2::splat(56.0))
                            .corner_radius(28.0),
                    );
                }
                None => {
                    icons::glyph(ui, icons::PETS_OUTLINED, 56.0, PALETTE.grey);
                }
            }
            if ui
                .link(egui::RichText::new(&name).strong().size(18.0))
                .clicked()
            {
                action = Some(PageAction::OpenCat(cat.to_string()));
            }
        });
        egui::Grid::new(("patient", cat))
            .num_columns(2)
            .spacing([12.0, 4.0])
            .show(ui, |ui| {
                for (label, value) in patient_facts(store, t, cat, today, units) {
                    ui.label(egui::RichText::new(label).weak());
                    ui.add(egui::Label::new(value).truncate());
                    ui.end_row();
                }
            });
        ui.add_space(8.0);
        if icons::button(ui, icons::MEDICAL_INFORMATION_OUTLINED, t.vet_report_menu()).clicked() {
            action = Some(PageAction::Document(DocKind::VetReport, cat.to_string()));
        }
        action
    }
}
