//! Capture a flier: an image of a missing-cat poster is read, its lines
//! land on Fields, the keeper corrects the assignment, and a Missing
//! Cat with its owner's Clowder and the Flier Position is made.

use std::collections::BTreeMap;

use catlog_core::fields::{FieldDef, FieldScope, FieldType};
use catlog_core::flier::{
    FlierDraft, FlierEntry, FlierLine, FlierReading, FlierRegistryHit, FlierTemplateSet,
    pair_lines, parse_flier_date, read_flier, registry_hit_for, registry_hits_in, suggest_chip_id,
    suggest_email, suggest_phone, target,
};
use catlog_core::{Catalog, keys};
use chrono::NaiveDate;
use egui::Ui;

use crate::l10n::L10n;
use crate::labels::field_def_name;

/// What the keeper asked for on the capture page this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CaptureAction {
    None,
    OpenImage,
    LocateAddress,
    Save,
}

/// The page's state: the picture, what was read, and the draft.
#[derive(Debug, Default)]
pub struct CapturePage {
    pub open: bool,
    pub image: Option<Vec<u8>>,
    pub lines: Vec<FlierLine>,
    pub reading: Option<FlierReading>,
    pub error: Option<String>,
    pub draft: FlierDraft,
    pub missing_since: String,
    pub hidden: Vec<usize>,
    pub address_hit: Option<String>,
    templates: Option<FlierTemplateSet>,
}

impl CapturePage {
    pub fn start(&mut self, today: NaiveDate) {
        *self = CapturePage {
            open: true,
            missing_since: today.to_string(),
            templates: Some(FlierTemplateSet::shipped()),
            ..Default::default()
        };
    }

    /// Takes the lines text recognition found and fills the draft.
    pub fn read(&mut self, store: &Catalog, t: &L10n, lines: Vec<FlierLine>) {
        let templates = self
            .templates
            .get_or_insert_with(FlierTemplateSet::shipped)
            .clone();
        let reading = read_flier(&pair_lines(&lines), &templates);
        self.lines = lines;
        self.hidden.clear();
        self.reading = Some(reading);
        self.apply_reading(store, t);
    }

    /// Fills the draft from the reading and the keeper's assignments.
    pub fn apply_reading(&mut self, store: &Catalog, t: &L10n) {
        let Some(reading) = &self.reading else {
            return;
        };
        let defs = store.field_defs(None).unwrap_or_default();
        let mut remarks: Vec<String> = Vec::new();
        let mut draft = FlierDraft {
            missing_since: self.draft.missing_since,
            photo: self.draft.photo.clone(),
            portrait: self.draft.portrait.clone(),
            address_position: self.draft.address_position,
            flier_position: self.draft.flier_position,
            ..Default::default()
        };
        draft.name = reading.first(target::NAME).unwrap_or_default().to_string();
        draft.address = reading
            .first(target::LOST_PLACE)
            .unwrap_or_default()
            .to_string();
        if let Some(since) = reading.first(target::MISSING_SINCE)
            && let Some(date) = parse_flier_date(since).and_then(|d| d.earliest())
            && date <= chrono::Local::now().date_naive()
        {
            draft.missing_since = Some(date);
            self.missing_since = date.to_string();
        }
        for (i, entry) in reading.entries.iter().enumerate() {
            if self.hidden.contains(&i) {
                continue;
            }
            let line = entry.line();
            match entry.target.as_str() {
                target::DROP => {}
                target::NAME | target::LOST_PLACE => {}
                target::MISSING_SINCE => {
                    if parse_flier_date(&entry.value).is_none() {
                        remarks.push(line);
                    }
                }
                target::REGISTRY_NUMBER => {
                    let hit = reading
                        .registry
                        .as_deref()
                        .and_then(|r| registry_hit_for(r, &entry.value, &defs));
                    match hit {
                        Some(hit) => {
                            if !draft.registry_hits.iter().any(|h| h.value == hit.value) {
                                draft.registry_hits.push(hit);
                            }
                        }
                        None => remarks.push(line),
                    }
                }
                target::REMARKS | target::CONTACT => remarks.push(line),
                "chipid" => match suggest_chip_id(&entry.value) {
                    Some(chip) => draft.chip_id = chip,
                    None => remarks.push(line),
                },
                slug => {
                    let def = defs.iter().find(|d| d.slug == slug);
                    let value = match def.map(|d| d.field_type) {
                        Some(FieldType::Date) => parse_flier_date(&entry.value).map(|d| d.iso()),
                        Some(_) => Some(entry.value.clone()),
                        None => None,
                    };
                    match (def, value) {
                        (Some(def), Some(value)) if def.scope == FieldScope::Clowder => {
                            match slug {
                                "address" => draft.address = value,
                                "phone" => draft.phone = value,
                                "email" => draft.email = value,
                                "responsible" => draft.owner = value,
                                _ => {
                                    draft
                                        .clowder_fields
                                        .entry(slug.to_string())
                                        .or_insert(value);
                                }
                            }
                        }
                        (Some(_), Some(value)) => {
                            draft.cat_fields.entry(slug.to_string()).or_insert(value);
                        }
                        _ => remarks.push(line),
                    }
                }
            }
        }
        // Links on the poster: registry numbers; the text: the contact.
        let text: String = self
            .lines
            .iter()
            .map(|l| l.text.as_str())
            .collect::<Vec<_>>()
            .join("\n");
        let urls: Vec<String> = text
            .split_whitespace()
            .filter(|w| {
                w.starts_with("http://") || w.starts_with("https://") || w.starts_with("www.")
            })
            .map(|w| {
                if w.starts_with("www.") {
                    format!("https://{w}")
                } else {
                    w.to_string()
                }
            })
            .collect();
        for hit in registry_hits_in(&urls, &defs) {
            if !draft.registry_hits.iter().any(|h| h.value == hit.value) {
                draft.registry_hits.push(hit);
            }
        }
        if draft.chip_id.is_empty()
            && let Some(chip) = suggest_chip_id(&text)
        {
            draft.chip_id = chip;
        }
        if draft.phone.is_empty()
            && reading.template.is_none()
            && let Some(phone) = suggest_phone(&text)
        {
            draft.phone = phone;
        }
        if draft.email.is_empty()
            && let Some(mail) = suggest_email(&text)
        {
            draft.email = mail;
        }
        draft.remarks = remarks.join("\n");
        if draft.name.is_empty() {
            draft.name = self.draft.name.clone();
        }
        // Keep what the keeper typed by hand.
        let hand = &self.draft;
        if !hand.owner.is_empty() {
            draft.owner = hand.owner.clone();
        }
        let _ = t;
        self.draft = draft;
    }

    /// Puts a line aside: it goes nowhere.
    pub fn hide(&mut self, index: usize) {
        if !self.hidden.contains(&index) {
            self.hidden.push(index);
        }
    }

    pub fn undo_hide(&mut self) {
        self.hidden.pop();
    }

    /// Changes where a line goes.
    pub fn assign(&mut self, index: usize, to: &str) {
        if let Some(reading) = &mut self.reading
            && let Some(entry) = reading.entries.get_mut(index)
        {
            entry.target = to.to_string();
        }
    }

    /// The targets a line can be sent to.
    fn targets(t: &L10n, defs: &[FieldDef]) -> Vec<(String, String)> {
        let mut out = vec![
            (target::DROP.to_string(), t.target_drop().to_string()),
            (target::REMARKS.to_string(), t.starter_remarks().to_string()),
            (target::NAME.to_string(), t.name().to_string()),
            (
                target::MISSING_SINCE.to_string(),
                t.missing_since_label().to_string(),
            ),
            (
                target::LOST_PLACE.to_string(),
                t.target_lost_place().to_string(),
            ),
            (
                target::REGISTRY_NUMBER.to_string(),
                t.target_registry_number().to_string(),
            ),
            (target::CONTACT.to_string(), t.target_contact().to_string()),
        ];
        for def in defs {
            if def.field_type != FieldType::Cat && def.slug != "remarks" {
                out.push((def.slug.clone(), field_def_name(t, def)));
            }
        }
        out
    }

    /// The page.
    pub fn show(&mut self, ui: &mut Ui, store: &Catalog, t: &L10n, busy: bool) -> CaptureAction {
        let mut action = CaptureAction::None;
        let defs = store.field_defs(None).unwrap_or_default();
        let targets = Self::targets(t, &defs);
        let mut reassigned: Option<(usize, String)> = None;
        let mut hide: Option<usize> = None;
        let mut undo = false;
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.horizontal(|ui| {
                ui.heading(t.capture_flier());
                if ui
                    .add_enabled(!busy, egui::Button::new(t.open_image()))
                    .clicked()
                {
                    action = CaptureAction::OpenImage;
                }
                if busy {
                    ui.spinner();
                    ui.label(t.recognizing());
                }
            });
            if let Some(e) = &self.error {
                ui.colored_label(ui.visuals().error_fg_color, e);
            }
            if let Some(reading) = &self.reading {
                ui.add_space(6.0);
                ui.strong(t.step_flier_text());
                ui.label(match &reading.template {
                    Some(name) => t.flier_recognized(name),
                    None => t.flier_layout_unknown().to_string(),
                });
                for (i, entry) in reading.entries.iter().enumerate() {
                    if self.hidden.contains(&i) {
                        continue;
                    }
                    ui.horizontal(|ui| {
                        ui.label(entry.line());
                        let current = targets
                            .iter()
                            .find(|(id, _)| *id == entry.target)
                            .map(|(_, label)| label.clone())
                            .unwrap_or_else(|| entry.target.clone());
                        egui::ComboBox::from_id_salt(("flier-target", i))
                            .selected_text(current)
                            .show_ui(ui, |ui| {
                                for (id, label) in &targets {
                                    if ui.selectable_label(*id == entry.target, label).clicked() {
                                        reassigned = Some((i, id.clone()));
                                    }
                                }
                            });
                        if ui.small_button("×").clicked() {
                            hide = Some(i);
                        }
                    });
                }
                if !self.hidden.is_empty() {
                    ui.horizontal(|ui| {
                        ui.label(t.flier_hidden(self.hidden.len() as i64));
                        if ui.button(t.undo()).clicked() {
                            undo = true;
                        }
                    });
                }
            }
            ui.add_space(8.0);
            ui.strong(t.step_cat());
            egui::Grid::new("flier-cat").num_columns(2).show(ui, |ui| {
                ui.label(t.name());
                ui.add(egui::TextEdit::singleline(&mut self.draft.name).desired_width(260.0));
                ui.end_row();
                ui.label(t.missing_since_label());
                if ui
                    .add(
                        egui::TextEdit::singleline(&mut self.missing_since)
                            .desired_width(100.0)
                            .hint_text(t.date_hint()),
                    )
                    .changed()
                {
                    self.draft.missing_since = self.missing_since.trim().parse::<NaiveDate>().ok();
                }
                ui.end_row();
                ui.label(t.starter_chip_id());
                ui.add(egui::TextEdit::singleline(&mut self.draft.chip_id).desired_width(200.0));
                ui.end_row();
                for (slug, value) in self.draft.cat_fields.iter_mut() {
                    let label = defs
                        .iter()
                        .find(|d| d.slug == *slug)
                        .map(|d| field_def_name(t, d))
                        .unwrap_or_else(|| slug.clone());
                    ui.label(label);
                    ui.add(egui::TextEdit::singleline(value).desired_width(260.0));
                    ui.end_row();
                }
            });
            ui.add_space(8.0);
            ui.strong(t.step_owner());
            ui.label(egui::RichText::new(t.step_owner_hint()).weak());
            egui::Grid::new("flier-owner")
                .num_columns(2)
                .show(ui, |ui| {
                    ui.label(t.starter_responsible());
                    ui.add(egui::TextEdit::singleline(&mut self.draft.owner).desired_width(260.0));
                    ui.end_row();
                    ui.label(t.starter_phone());
                    ui.add(egui::TextEdit::singleline(&mut self.draft.phone).desired_width(200.0));
                    ui.end_row();
                    ui.label(t.starter_email());
                    ui.add(egui::TextEdit::singleline(&mut self.draft.email).desired_width(260.0));
                    ui.end_row();
                    ui.label(t.starter_address());
                    ui.horizontal(|ui| {
                        ui.add(
                            egui::TextEdit::singleline(&mut self.draft.address)
                                .desired_width(260.0),
                        );
                        if ui.button(t.locate_address()).clicked() {
                            action = CaptureAction::LocateAddress;
                        }
                        if let Some(place) = &self.address_hit {
                            ui.label(
                                egui::RichText::new(format!("{}: {place}", t.address_located()))
                                    .weak(),
                            );
                        }
                    });
                    ui.end_row();
                    for (slug, value) in self.draft.clowder_fields.iter_mut() {
                        let label = defs
                            .iter()
                            .find(|d| d.slug == *slug)
                            .map(|d| field_def_name(t, d))
                            .unwrap_or_else(|| slug.clone());
                        ui.label(label);
                        ui.add(egui::TextEdit::singleline(value).desired_width(260.0));
                        ui.end_row();
                    }
                });
            ui.add_space(8.0);
            ui.strong(t.step_registry());
            ui.label(egui::RichText::new(t.step_registry_hint()).weak());
            if self.draft.registry_hits.is_empty() {
                ui.label(t.no_registry_links());
            }
            for hit in &mut self.draft.registry_hits {
                ui.checkbox(
                    &mut hit.take,
                    format!("{}: {}", hit.service_name, hit.value),
                );
            }
            ui.add_space(8.0);
            ui.label(t.starter_remarks());
            ui.add(
                egui::TextEdit::multiline(&mut self.draft.remarks)
                    .desired_width(400.0)
                    .desired_rows(3),
            );
            ui.add_space(8.0);
            let ready = !self.draft.name.trim().is_empty() && !busy;
            if ui.add_enabled(ready, egui::Button::new(t.save())).clicked() {
                action = CaptureAction::Save;
            }
        });
        if let Some((i, to)) = reassigned {
            self.assign(i, &to);
            self.apply_reading(store, t);
        }
        if let Some(i) = hide {
            self.hide(i);
            self.apply_reading(store, t);
        }
        if undo {
            self.undo_hide();
            self.apply_reading(store, t);
        }
        let _ = keys::NAME;
        action
    }

    /// The Clowder name a nameless owner gets.
    pub fn owner_of(&self, t: &L10n) -> String {
        t.owner_of_cat(self.draft.name.trim())
    }

    /// Hits the keeper unticked are left out.
    pub fn taken_hits(&self) -> Vec<FlierRegistryHit> {
        self.draft
            .registry_hits
            .iter()
            .filter(|h| h.take)
            .cloned()
            .collect()
    }

    /// Cat Fields the reading filled, by slug.
    pub fn cat_fields(&self) -> &BTreeMap<String, String> {
        &self.draft.cat_fields
    }
}

/// The entries of a reading as the page lists them.
pub fn entry_lines(entries: &[FlierEntry]) -> Vec<String> {
    entries.iter().map(FlierEntry::line).collect()
}
