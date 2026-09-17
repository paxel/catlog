//! Appointments on the desk: the editor for one Cat or a Vet Run over
//! several, and the finish step that asks how it went.

use catlog_core::appointments::{Appointment, AppointmentAlert};
use catlog_core::chores::Hhmm;
use catlog_core::fields::FieldScope;
use catlog_core::{Catalog, keys};
use chrono::NaiveDate;
use egui::Context;

use crate::l10n::L10n;
use crate::labels::field_def_name;

/// The appointment editor.
#[derive(Debug, Default)]
pub struct AppointmentDialog {
    pub open: bool,
    /// The Cat or Clowder it is planned for.
    pub entity: String,
    pub existing: Option<Appointment>,
    pub date: String,
    pub time: String,
    pub title: String,
    pub notes: String,
    pub alert: Option<AppointmentAlert>,
    /// The Field key written when finished.
    pub linked_field: Option<String>,
    pub linked_value: String,
    /// Other Cats on the run: id, name, ticked.
    pub candidates: Vec<(String, String, bool)>,
    /// Members already in the group being edited: they stay.
    pub members: Vec<String>,
    pub error: Option<String>,
    id: u64,
}

impl AppointmentDialog {
    /// Opens for a new appointment on `entity`, or over `existing`.
    pub fn ask(
        &mut self,
        store: &Catalog,
        entity: &str,
        existing: Option<Appointment>,
        today: NaiveDate,
    ) {
        self.entity = entity.to_string();
        self.open = true;
        self.error = None;
        self.id += 1;
        self.members.clear();
        match &existing {
            Some(a) => {
                self.date = a.date.to_string();
                self.time = a.time.map(|t| t.text()).unwrap_or_default();
                self.title = a.title.clone();
                self.notes = a.notes.clone();
                self.alert = Some(a.alert);
                self.linked_field = a.linked_field.clone();
                self.linked_value = a.linked_value.clone().unwrap_or_default();
                for m in store.group_of(a).unwrap_or_default() {
                    self.members.push(m.entity);
                }
            }
            None => {
                self.date = today.to_string();
                self.time.clear();
                self.title.clear();
                self.notes.clear();
                self.alert = Some(AppointmentAlert::DayBefore);
                self.linked_field = None;
                self.linked_value.clear();
            }
        }
        // Every other Cat can come along; members of the run are ticked.
        self.candidates = store
            .cats(None)
            .unwrap_or_default()
            .into_iter()
            .filter(|c| c.id != entity)
            .map(|c| {
                let on = self.members.contains(&c.id);
                (c.id, c.name, on)
            })
            .collect();
        self.existing = existing;
    }

    /// The appointment as typed, or what is wrong with it.
    pub fn draft(&self) -> Result<Appointment, String> {
        let title = self.title.trim().to_string();
        if title.is_empty() {
            return Err("title".into());
        }
        let date = self
            .date
            .trim()
            .parse::<NaiveDate>()
            .map_err(|_| "date".to_string())?;
        let time = match self.time.trim() {
            "" => None,
            raw => Some(Hhmm::parse(raw).ok_or_else(|| "time".to_string())?),
        };
        let base = self.existing.clone().unwrap_or(Appointment {
            id: String::new(),
            entity: self.entity.clone(),
            date,
            time: None,
            title: String::new(),
            notes: String::new(),
            linked_field: None,
            linked_value: None,
            alert: AppointmentAlert::DayBefore,
            done: false,
            group: None,
            extra: Default::default(),
        });
        Ok(Appointment {
            date,
            time,
            title,
            notes: self.notes.trim().to_string(),
            alert: self.alert.unwrap_or(AppointmentAlert::DayBefore),
            linked_field: self.linked_field.clone(),
            linked_value: self
                .linked_field
                .as_ref()
                .map(|_| self.linked_value.trim().to_string())
                .filter(|v| !v.is_empty()),
            ..base
        })
    }

    /// The Cats ticked to come along that are not on the run yet.
    pub fn newcomers(&self) -> Vec<String> {
        self.candidates
            .iter()
            .filter(|(id, _, on)| *on && !self.members.contains(id))
            .map(|(id, _, _)| id.clone())
            .collect()
    }

    /// Draws the dialog; the draft once Save was clicked.
    pub fn show(&mut self, ctx: &Context, store: &Catalog, t: &L10n) -> Option<Appointment> {
        if !self.open {
            return None;
        }
        let mut result = None;
        let mut close = false;
        let title = if self.existing.is_some() {
            t.edit_label_appointment()
        } else {
            t.new_appointment()
        };
        let defs = store.field_defs(Some(FieldScope::Cat)).unwrap_or_default();
        egui::Window::new(title)
            .id(egui::Id::new(("appointment-dialog", self.id)))
            .collapsible(false)
            .resizable(false)
            .anchor(egui::Align2::CENTER_CENTER, egui::vec2(0.0, 0.0))
            .show(ctx, |ui| {
                egui::Grid::new("appointment-grid")
                    .num_columns(2)
                    .show(ui, |ui| {
                        ui.label(t.appointment_title_label());
                        ui.add(egui::TextEdit::singleline(&mut self.title).desired_width(260.0));
                        ui.end_row();
                        ui.label(t.date_label());
                        ui.add(
                            egui::TextEdit::singleline(&mut self.date)
                                .desired_width(100.0)
                                .hint_text("YYYY-MM-DD"),
                        );
                        ui.end_row();
                        ui.label(t.time_label());
                        ui.horizontal(|ui| {
                            ui.add(
                                egui::TextEdit::singleline(&mut self.time)
                                    .desired_width(60.0)
                                    .hint_text("HH:MM"),
                            );
                            ui.label(egui::RichText::new(t.all_day_label()).weak());
                        });
                        ui.end_row();
                        ui.label(t.notes_label());
                        ui.add(
                            egui::TextEdit::multiline(&mut self.notes)
                                .desired_width(260.0)
                                .desired_rows(2),
                        );
                        ui.end_row();
                        ui.label(t.alert_label());
                        egui::ComboBox::from_id_salt("appointment-alert")
                            .selected_text(alert_words(
                                t,
                                self.alert.unwrap_or(AppointmentAlert::DayBefore),
                            ))
                            .show_ui(ui, |ui| {
                                for a in [
                                    AppointmentAlert::None,
                                    AppointmentAlert::DayBefore,
                                    AppointmentAlert::HourBefore,
                                ] {
                                    ui.selectable_value(
                                        &mut self.alert,
                                        Some(a),
                                        alert_words(t, a),
                                    );
                                }
                            });
                        ui.end_row();
                        ui.label(t.link_field_label());
                        ui.vertical(|ui| {
                            let chosen = self
                                .linked_field
                                .as_ref()
                                .and_then(|k| defs.iter().find(|d| d.key() == *k))
                                .map(|d| field_def_name(t, d))
                                .unwrap_or_else(|| t.no_linked_field().to_string());
                            egui::ComboBox::from_id_salt("appointment-field")
                                .selected_text(chosen)
                                .show_ui(ui, |ui| {
                                    ui.selectable_value(
                                        &mut self.linked_field,
                                        None,
                                        t.no_linked_field(),
                                    );
                                    for d in &defs {
                                        ui.selectable_value(
                                            &mut self.linked_field,
                                            Some(d.key()),
                                            field_def_name(t, d),
                                        );
                                    }
                                });
                            if self.linked_field.is_some() {
                                ui.add(
                                    egui::TextEdit::singleline(&mut self.linked_value)
                                        .desired_width(200.0),
                                );
                            }
                        });
                        ui.end_row();
                        if !self.candidates.is_empty() {
                            ui.label(t.cats_on_appointment());
                            ui.vertical(|ui| {
                                egui::ScrollArea::vertical()
                                    .max_height(120.0)
                                    .show(ui, |ui| {
                                        for (id, name, on) in &mut self.candidates {
                                            let fixed = self.members.contains(id);
                                            ui.add_enabled(
                                                !fixed,
                                                egui::Checkbox::new(on, name.as_str()),
                                            );
                                        }
                                    });
                            });
                            ui.end_row();
                        }
                    });
                if let Some(e) = &self.error {
                    ui.colored_label(ui.visuals().error_fg_color, e);
                }
                ui.horizontal(|ui| {
                    if ui.button(t.save()).clicked() {
                        match self.draft() {
                            Ok(a) => result = Some(a),
                            Err(field) => self.error = Some(field),
                        }
                    }
                    if ui.button(t.cancel()).clicked() {
                        close = true;
                    }
                });
            });
        if result.is_some() || close {
            self.open = false;
        }
        result
    }
}

pub fn alert_words(t: &L10n, a: AppointmentAlert) -> &'static str {
    match a {
        AppointmentAlert::None => t.alert_none(),
        AppointmentAlert::DayBefore => t.alert_day_before(),
        AppointmentAlert::HourBefore => t.alert_hour_before(),
    }
}

/// "How did it go?": the outcome notes, and for a run which Cats were
/// treated.
#[derive(Debug, Default)]
pub struct FinishDialog {
    pub open: bool,
    pub members: Vec<(Appointment, String, bool)>,
    pub notes: String,
    id: u64,
}

impl FinishDialog {
    pub fn ask(&mut self, store: &Catalog, appointment: &Appointment) {
        let group = store
            .group_of(appointment)
            .unwrap_or_else(|_| vec![appointment.clone()]);
        self.members = group
            .into_iter()
            .map(|a| {
                let name = store
                    .current(&a.entity, keys::NAME)
                    .ok()
                    .flatten()
                    .unwrap_or_default();
                (a, name, true)
            })
            .collect();
        self.notes = appointment.notes.clone();
        self.open = true;
        self.id += 1;
    }

    /// Draws the dialog; the treated members and the notes on Finish.
    pub fn show(&mut self, ctx: &Context, t: &L10n) -> Option<(Vec<Appointment>, String)> {
        if !self.open {
            return None;
        }
        let mut result = None;
        let mut close = false;
        egui::Window::new(t.outcome_title())
            .id(egui::Id::new(("finish-dialog", self.id)))
            .collapsible(false)
            .resizable(false)
            .anchor(egui::Align2::CENTER_CENTER, egui::vec2(0.0, 0.0))
            .show(ctx, |ui| {
                ui.label(t.notes_label());
                ui.add(
                    egui::TextEdit::multiline(&mut self.notes)
                        .desired_width(300.0)
                        .desired_rows(3),
                );
                if self.members.len() > 1 {
                    ui.label(t.finish_untick_hint());
                    for (_, name, on) in &mut self.members {
                        ui.checkbox(on, name.as_str());
                    }
                }
                ui.horizontal(|ui| {
                    if ui.button(t.finish_label()).clicked() {
                        let treated = self
                            .members
                            .iter()
                            .filter(|(_, _, on)| *on)
                            .map(|(a, _, _)| a.clone())
                            .collect();
                        result = Some((treated, self.notes.trim().to_string()));
                    }
                    if ui.button(t.cancel()).clicked() {
                        close = true;
                    }
                });
            });
        if result.is_some() || close {
            self.open = false;
        }
        result
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_dialog_reads_a_draft_and_knows_who_comes_along() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        store.create_cat("cat:b", "Tom", None, "cat").unwrap();
        let today = NaiveDate::from_ymd_opt(2026, 3, 10).unwrap();
        let mut d = AppointmentDialog::default();
        d.ask(&store, "cat:a", None, today);
        assert_eq!(d.candidates.len(), 1);
        assert_eq!(d.draft().unwrap_err(), "title");
        d.title = "Vet".into();
        d.date = "never".into();
        assert_eq!(d.draft().unwrap_err(), "date");
        d.date = "2026-03-12".into();
        d.time = "noon".into();
        assert_eq!(d.draft().unwrap_err(), "time");
        d.time = "14:30".into();
        d.linked_field = Some("f:vaccine".into());
        d.linked_value = " done ".into();
        let a = d.draft().unwrap();
        assert_eq!(a.entity, "cat:a");
        assert_eq!(
            a.time,
            Some(Hhmm {
                hour: 14,
                minute: 30
            })
        );
        assert_eq!(a.linked_value.as_deref(), Some("done"));
        assert!(d.newcomers().is_empty());
        d.candidates[0].2 = true;
        assert_eq!(d.newcomers(), vec!["cat:b".to_string()]);
        // Editing a run: its members are fixed.
        let saved = store
            .create_appointments(&a, &[("cat:a", "a1"), ("cat:b", "a2")], "g1")
            .unwrap();
        d.ask(&store, "cat:a", Some(saved[0].clone()), today);
        assert_eq!(d.members.len(), 2);
        assert!(d.candidates[0].2, "the member is ticked");
        assert!(d.newcomers().is_empty());
        assert_eq!(d.draft().unwrap().id, "a1");
        let mut f = FinishDialog::default();
        f.ask(&store, &saved[0]);
        assert_eq!(f.members.len(), 2);
        assert_eq!(f.members[1].1, "Tom");
    }
}
