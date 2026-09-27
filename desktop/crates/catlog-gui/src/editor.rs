//! The editor for one Field value: type-aware input, the Private tick,
//! and an "as of" date so entries can be backdated. Saved as one entry;
//! a correction hides the entry it replaces.

use catlog_core::fields::{FieldDef, FieldType, breed_options};
use catlog_core::geocode::{GeoHit, Geocoder};
use catlog_core::units::{
    UnitSystem, base_string, entry_unit, format_decimal, from_base, parse_entry, to_base,
};
use catlog_core::{Catalog, PartialDate, keys, looks};
use chrono::{Datelike, NaiveDate, NaiveTime};
use egui::{Context, Key};

use crate::l10n::L10n;
use crate::labels::{
    field_def_name, field_value_display, format_day, format_number, format_partial_date,
};

/// What the editor was opened for.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum EditTarget {
    /// A new value on the entity.
    New,
    /// A correction of the entry with this seq.
    Correct(i64),
}

/// The outcome: what to store, as of when, whether it stays home.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FieldEdit {
    pub value: Option<String>,
    /// RFC 3339, UTC.
    pub date: String,
    pub private: bool,
}

pub struct FieldEditor {
    pub open: bool,
    pub def: FieldDef,
    pub entity: String,
    pub target: EditTarget,
    /// Typed text: the value for text-like Fields, the own value for a
    /// choice, the number for number and unit Fields.
    pub text: String,
    /// The picked option for choice, yes/no and cat Fields.
    pub choice: Option<String>,
    /// The chosen Looks per group.
    pub looks: std::collections::BTreeMap<String, Vec<String>>,
    pub private: bool,
    pub as_of_day: NaiveDate,
    pub as_of_text: String,
    pub as_of_time: String,
    pub units: UnitSystem,
    /// Set when the keeper asked for the map; the app opens the picker
    /// and writes the answer back into `text`.
    pub wants_picker: bool,
    /// The month the calendar shows, once the keeper has walked away
    /// from the month the value is in.
    month: Option<NaiveDate>,
    /// The address being looked for on a location Field.
    pub query: String,
    /// What the last search found, and what to say when it found nothing.
    hits: Vec<GeoHit>,
    note: Option<String>,
    /// Where places are looked up; none in a build without one.
    geocoder: Option<std::sync::Arc<dyn Geocoder>>,
    id: u64,
}

impl FieldEditor {
    /// A closed editor with nothing in it.
    pub fn closed() -> FieldEditor {
        FieldEditor {
            open: false,
            def: FieldDef {
                id: String::new(),
                slug: String::new(),
                name: String::new(),
                field_type: FieldType::Text,
                scope: catlog_core::fields::FieldScope::Both,
                options: vec![],
                id_display: catlog_core::fields::IdDisplay::Plain,
                lookup_url: None,
                dimension: None,
                extra_options: Default::default(),
            },
            entity: String::new(),
            target: EditTarget::New,
            text: String::new(),
            choice: None,
            looks: Default::default(),
            private: false,
            as_of_day: chrono::Local::now().date_naive(),
            as_of_text: String::new(),
            as_of_time: String::new(),
            units: UnitSystem::Metric,
            wants_picker: false,
            month: None,
            query: String::new(),
            hits: Vec::new(),
            note: None,
            geocoder: None,
            id: 0,
        }
    }

    /// The editor with a place to look addresses up, the one the map
    /// already uses.
    pub fn with_geocoder(mut self, geocoder: std::sync::Arc<dyn Geocoder>) -> FieldEditor {
        self.geocoder = Some(geocoder);
        self
    }

    /// Looks the typed address up and keeps what came back. An address
    /// leaves the machine only when the keeper asks for it, never while
    /// they type.
    fn search_place(&mut self, t: &L10n) {
        self.hits.clear();
        self.note = None;
        if self.query.trim().is_empty() {
            return;
        }
        let Some(geocoder) = &self.geocoder else {
            self.note = Some(t.search_no_results().to_string());
            return;
        };
        match geocoder.search(self.query.trim()) {
            Ok(hits) if hits.is_empty() => self.note = Some(t.search_no_results().to_string()),
            Ok(hits) => self.hits = hits,
            Err(e) => self.note = Some(e),
        }
    }

    /// Opens the editor on `entity`'s `def` with the current value, as
    /// of now, or as of `as_of` for a correction.
    #[allow(clippy::too_many_arguments)]
    pub fn ask(
        &mut self,
        store: &Catalog,
        def: &FieldDef,
        entity: &str,
        current: Option<&str>,
        target: EditTarget,
        as_of: Option<&str>,
        locale: &str,
    ) {
        self.open = true;
        self.id += 1;
        self.month = None;
        self.query.clear();
        self.hits.clear();
        self.note = None;
        self.def = def.clone();
        self.entity = entity.to_string();
        self.target = target;
        self.choice = current.map(String::from);
        self.looks = looks::parse_looks(current);
        self.text = match (def.field_type, current) {
            (_, None) => String::new(),
            (FieldType::Choice, Some(v)) if def.options.iter().any(|o| o == v) => String::new(),
            (FieldType::Number, Some(v)) => v
                .replace(',', ".")
                .parse::<f64>()
                .map(|n| format_number(locale, n, 6))
                .unwrap_or_else(|_| v.to_string()),
            (FieldType::UnitValue, Some(v)) => v
                .parse::<f64>()
                .map(|base| {
                    format_number(locale, from_base(def.unit_dimension(), self.units, base), 2)
                })
                .unwrap_or_else(|_| v.to_string()),
            (_, Some(v)) => v.to_string(),
        };
        self.private = store.is_field_private(entity, &def.key()).unwrap_or(false);
        let now = chrono::Local::now();
        let (day, time) = match as_of.and_then(|d| chrono::DateTime::parse_from_rfc3339(d).ok()) {
            Some(d) => {
                let local = d.with_timezone(&chrono::Local);
                (local.date_naive(), local.time())
            }
            None => (now.date_naive(), now.time()),
        };
        // Typed as ISO, unambiguous in every language; the label beside it
        // reads it back in the keeper's own order.
        let _ = locale;
        self.as_of_day = day;
        self.as_of_text = day.to_string();
        self.as_of_time = time.format("%H:%M").to_string();
    }

    /// The value to store, or none for "cleared".
    pub fn value(&self) -> Option<String> {
        let typed = self.text.trim();
        match self.def.field_type {
            FieldType::Choice => {
                if typed.is_empty() {
                    self.choice.clone()
                } else {
                    Some(typed.to_string())
                }
            }
            FieldType::YesNo | FieldType::Cat => self.choice.clone(),
            FieldType::Date => self.choice.clone(),
            FieldType::Number => {
                if typed.is_empty() {
                    return None;
                }
                Some(match typed.replace(',', ".").parse::<f64>() {
                    Ok(n) => format_decimal(n, 6),
                    Err(_) => typed.to_string(),
                })
            }
            FieldType::UnitValue => {
                let entered = parse_entry(typed)?;
                Some(base_string(to_base(
                    self.def.unit_dimension(),
                    self.units,
                    entered,
                )))
            }
            FieldType::Tags => looks::encode_looks(&self.looks),
            FieldType::Text | FieldType::Location | FieldType::Id => {
                (!typed.is_empty()).then(|| typed.to_string())
            }
        }
    }

    /// The moment the value is as of: the typed day at the typed time,
    /// never in the future.
    pub fn as_of(&self) -> String {
        let day = PartialDate::parse_loose(&self.as_of_text)
            .and_then(|d| d.earliest())
            .unwrap_or(self.as_of_day);
        let time = NaiveTime::parse_from_str(&self.as_of_time, "%H:%M").unwrap_or_default();
        let local = day
            .and_time(time)
            .and_local_timezone(chrono::Local)
            .single()
            .unwrap_or_else(chrono::Local::now);
        let clamped = local.min(chrono::Local::now());
        clamped
            .with_timezone(&chrono::Utc)
            .to_rfc3339_opts(chrono::SecondsFormat::Micros, true)
    }

    /// Draws the editor; the edit on save, none while open or cancelled.
    pub fn show(&mut self, ctx: &Context, store: &Catalog, t: &L10n) -> Option<FieldEdit> {
        if !self.open {
            return None;
        }
        let mut result = None;
        let mut close = false;
        let def = self.def.clone();
        let title = field_def_name(t, &def);
        let modal = egui::Modal::new(egui::Id::new(("field-editor", self.id))).show(ctx, |ui| {
            // A dialog asking one thing, not a spreadsheet: room around
            // the content, room between its parts, and the value, when
            // it counts from and whether it stays home kept apart.
            ui.set_min_width(400.0);
            ui.style_mut().spacing.item_spacing.y = 8.0;
            ui.add_space(4.0);
            ui.heading(title);
            ui.add_space(10.0);
            egui::ScrollArea::vertical()
                .max_height(420.0)
                .show(ui, |ui| {
                    egui::Frame::new()
                        .inner_margin(egui::Margin::symmetric(2, 4))
                        .show(ui, |ui| {
                            self.show_input(ui, store, t, &def);
                        });
                });
            ui.add_space(14.0);
            ui.separator();
            ui.add_space(6.0);
            crate::icons::check_box(ui, &mut self.private, t.private_label());
            ui.horizontal(|ui| {
                let typed = PartialDate::parse_loose(&self.as_of_text)
                    .and_then(|d| d.earliest())
                    .unwrap_or(self.as_of_day);
                let today = typed == chrono::Local::now().date_naive();
                ui.label(if today {
                    t.as_of_today().to_string()
                } else {
                    t.as_of_date(&format_day(t.locale(), typed))
                });
                ui.add(egui::TextEdit::singleline(&mut self.as_of_text).desired_width(100.0));
                ui.add(egui::TextEdit::singleline(&mut self.as_of_time).desired_width(50.0));
            });
            // The impossible is named and not saved: a birth after the
            // death, a pregnant tom, a female father.
            let objection = store
                .starter_objection(
                    &self.entity,
                    &def.slug,
                    self.value().as_deref(),
                    chrono::Local::now().date_naive(),
                )
                .ok()
                .flatten();
            if let Some(objection) = &objection {
                ui.colored_label(
                    ui.visuals().error_fg_color,
                    crate::labels::objection_words(t, objection),
                );
            }
            let escape = ui.input(|i| i.key_pressed(Key::Escape));
            ui.add_space(10.0);
            crate::views::settle(ui);
            ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                if ui
                    .add_enabled(objection.is_none(), egui::Button::new(t.save()))
                    .clicked()
                {
                    result = Some(FieldEdit {
                        value: self.value(),
                        date: self.as_of(),
                        private: self.private,
                    });
                }
                if ui.button(t.cancel()).clicked() || escape {
                    close = true;
                }
            });
        });
        if result.is_some() || close || modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
        result
    }

    /// A month at a time, days as buttons: a date is picked, not spelled.
    /// The month shown follows the value until the keeper walks away
    /// from it. Weekdays carry no letters — they have no words in the
    /// thirty-eight languages the app speaks; a day's full date is its
    /// tooltip instead.
    fn calendar(&mut self, ui: &mut egui::Ui, t: &L10n) {
        let picked = self
            .choice
            .as_deref()
            .and_then(PartialDate::parse)
            .and_then(|d| match (d.month, d.day) {
                (Some(m), Some(day)) => NaiveDate::from_ymd_opt(d.year, m, day),
                (Some(m), None) => NaiveDate::from_ymd_opt(d.year, m, 1),
                _ => NaiveDate::from_ymd_opt(d.year, 1, 1),
            });
        let month = self
            .month
            .or(picked)
            .unwrap_or_else(|| chrono::Local::now().date_naive());
        let first = NaiveDate::from_ymd_opt(month.year(), month.month(), 1).unwrap_or(month);
        ui.horizontal(|ui| {
            if crate::icons::icon_button(ui, crate::icons::CHEVRON_LEFT, t.month_before()).clicked()
            {
                self.month = Some(step_month(first, -1));
            }
            ui.label(
                egui::RichText::new(format_partial_date(
                    t.locale(),
                    &PartialDate {
                        year: first.year(),
                        month: Some(first.month()),
                        day: None,
                    },
                ))
                .strong(),
            );
            if crate::icons::icon_button(ui, crate::icons::CHEVRON_RIGHT, t.month_after()).clicked()
            {
                self.month = Some(step_month(first, 1));
            }
        });
        // Monday first, as the app's weeks run.
        let lead = first.weekday().num_days_from_monday() as usize;
        let days = days_in_month(first);
        egui::Grid::new(("calendar", self.id))
            .num_columns(7)
            .spacing([2.0, 2.0])
            .show(ui, |ui| {
                for cell in 0..lead {
                    let _ = cell;
                    ui.label("");
                }
                for day in 1..=days {
                    let Some(date) = NaiveDate::from_ymd_opt(first.year(), first.month(), day)
                    else {
                        continue;
                    };
                    let on = picked == Some(date);
                    if ui
                        .add(
                            egui::Button::selectable(on, day.to_string())
                                .min_size(egui::Vec2::splat(28.0)),
                        )
                        .on_hover_text(format_day(t.locale(), date))
                        .clicked()
                    {
                        self.choice = Some(date.format("%Y-%m-%d").to_string());
                        self.month = Some(date);
                    }
                    if (lead + day as usize).is_multiple_of(7) {
                        ui.end_row();
                    }
                }
            });
    }

    fn show_input(&mut self, ui: &mut egui::Ui, store: &Catalog, t: &L10n, def: &FieldDef) {
        match def.field_type {
            FieldType::YesNo | FieldType::Choice => {
                let species = (def.slug == "breed")
                    .then(|| store.current(&self.entity, "f:species").ok().flatten())
                    .flatten();
                let options: Vec<String> = if def.field_type == FieldType::YesNo {
                    vec!["yes".into(), "no".into()]
                } else if def.slug == "breed" {
                    breed_options(def, species.as_deref())
                } else {
                    def.options.clone()
                };
                for option in &options {
                    let label = field_value_display(t, Some(def), Some(option), self.units);
                    if ui
                        .radio(self.choice.as_deref() == Some(option.as_str()), label)
                        .clicked()
                    {
                        self.choice = Some(option.clone());
                        self.text.clear();
                    }
                }
                if def.field_type == FieldType::Choice {
                    ui.label(t.own_value());
                    let edit = ui.text_edit_singleline(&mut self.text);
                    if edit.changed() && !self.text.trim().is_empty() {
                        self.choice = None;
                    }
                }
            }
            FieldType::Date => {
                ui.label(t.value());
                let mut text = self.choice.clone().unwrap_or_default();
                if ui.text_edit_singleline(&mut text).changed() {
                    self.choice = PartialDate::parse_loose(&text)
                        .map(|d| d.iso())
                        .or_else(|| (!text.trim().is_empty()).then(|| text.trim().to_string()));
                    if text.trim().is_empty() {
                        self.choice = None;
                    }
                }
                ui.label(
                    egui::RichText::new("2021, 5/2021, 14.05.2021")
                        .weak()
                        .small(),
                );
                self.calendar(ui, t);
            }
            FieldType::Number => {
                ui.label(t.value());
                ui.text_edit_singleline(&mut self.text);
            }
            FieldType::UnitValue => {
                ui.horizontal(|ui| {
                    ui.label(t.value());
                    ui.text_edit_singleline(&mut self.text);
                    ui.label(entry_unit(def.unit_dimension(), self.units));
                });
            }
            FieldType::Location => {
                ui.label(t.value());
                ui.horizontal(|ui| {
                    ui.text_edit_singleline(&mut self.text);
                    if ui.button(t.pick_on_map()).clicked() {
                        self.wants_picker = true;
                    }
                });
                ui.label(egui::RichText::new("51.34, 12.37").weak().small());
                // An address instead of coordinates: looked up when the
                // keeper asks, by the same service the map searches with.
                ui.horizontal(|ui| {
                    let edit = ui.add(
                        egui::TextEdit::singleline(&mut self.query)
                            .desired_width(200.0)
                            .hint_text(t.search_place_hint()),
                    );
                    let entered =
                        edit.lost_focus() && ui.input(|i| i.key_pressed(egui::Key::Enter));
                    if ui.button(t.search()).clicked() || entered {
                        self.search_place(t);
                    }
                });
                if let Some(note) = self.note.clone() {
                    ui.label(egui::RichText::new(note).weak());
                }
                let mut picked: Option<(f64, f64)> = None;
                for hit in &self.hits {
                    if ui.button(&hit.name).clicked() {
                        picked = Some((hit.lat, hit.lon));
                    }
                }
                if let Some((lat, lon)) = picked {
                    self.text = format!("{lat},{lon}");
                    self.hits.clear();
                }
            }
            FieldType::Tags => {
                let species = store.current(&self.entity, "f:species").ok().flatten();
                for group in looks::looks_groups_for(species.as_deref()) {
                    ui.label(
                        egui::RichText::new(crate::labels::looks_group_label(t, group.id)).strong(),
                    );
                    let chosen = self.looks.entry(group.id.to_string()).or_default();
                    ui.horizontal_wrapped(|ui| {
                        for value in group.values {
                            let on = chosen.iter().any(|v| v == value);
                            let label = crate::labels::looks_value_label(t, value);
                            if ui.selectable_label(on, label).clicked() {
                                if on {
                                    chosen.retain(|v| v != value);
                                } else if group.single {
                                    *chosen = vec![value.to_string()];
                                } else {
                                    chosen.push(value.to_string());
                                }
                            }
                        }
                    });
                }
                self.looks.retain(|_, v| !v.is_empty());
            }
            FieldType::Text => {
                ui.label(t.value());
                // Free text is free: every text Field takes as many lines
                // as the keeper writes, not only Remarks.
                let rows = if def.slug == "remarks" { 4 } else { 2 };
                ui.add(egui::TextEdit::multiline(&mut self.text).desired_rows(rows));
            }
            FieldType::Id => {
                ui.label(t.value());
                ui.text_edit_singleline(&mut self.text);
                if def.slug == "chipid" {
                    ui.label(egui::RichText::new(t.chip_scan_hint()).weak().small());
                }
            }
            FieldType::Cat => {
                let me = store.resolve_entity(&self.entity).unwrap_or_default();
                // A mother is not male and a father not female: the cats
                // the app would refuse are not offered in the first place.
                // A cat of unknown gender stays on the list — an
                // incomplete record is no reason to refuse a real relation.
                let wrong = match def.slug.as_str() {
                    "mother" => Some("male"),
                    "father" => Some("female"),
                    _ => None,
                };
                for cat in store.cats(None).unwrap_or_default() {
                    if store.resolve_entity(&cat.id).unwrap_or_default() == me {
                        continue;
                    }
                    // The cat already written down stays on the list
                    // whatever its gender says now: hidden, it left no
                    // row ticked and no way to put another one in its
                    // place — only Cancel.
                    if let Some(wrong) = wrong
                        && self.choice.as_deref() != Some(cat.id.as_str())
                        && store
                            .current(&cat.id, &keys::user_field("gender"))
                            .ok()
                            .flatten()
                            .as_deref()
                            == Some(wrong)
                    {
                        continue;
                    }
                    if ui
                        .radio(self.choice.as_deref() == Some(cat.id.as_str()), &cat.name)
                        .clicked()
                    {
                        self.choice = Some(cat.id.clone());
                    }
                }
            }
        }
    }
}

/// The same day one month on or back, kept inside the month's length.
fn step_month(day: NaiveDate, by: i32) -> NaiveDate {
    let month0 = day.month0() as i32 + by;
    let (year, month0) = (day.year() + month0.div_euclid(12), month0.rem_euclid(12));
    NaiveDate::from_ymd_opt(year, month0 as u32 + 1, 1).unwrap_or(day)
}

/// How many days the month of `day` has.
fn days_in_month(day: NaiveDate) -> u32 {
    let next = step_month(day, 1);
    next.signed_duration_since(NaiveDate::from_ymd_opt(day.year(), day.month(), 1).unwrap_or(day))
        .num_days() as u32
}

/// Applies an edit to the store: a new entry or a correction, the
/// Private mark when it changed, and a breed the field learns.
pub fn apply_edit(
    store: &mut Catalog,
    editor: &FieldEditor,
    edit: &FieldEdit,
) -> catlog_core::Result<()> {
    let key = editor.def.key();
    match editor.target {
        EditTarget::New => {
            store.append_at(
                &editor.entity,
                &key,
                edit.value.as_deref(),
                Some(&edit.date),
                false,
            )?;
        }
        EditTarget::Correct(seq) => {
            store.correct_entry(seq, edit.value.as_deref(), Some(&edit.date))?;
        }
    }
    if edit.private != store.is_field_private(&editor.entity, &key)? {
        store.set_field_private(&editor.entity, &key, edit.private)?;
    }
    if editor.def.slug == "breed" {
        store.learn_breed(&editor.entity, edit.value.as_deref())?;
    }
    let _ = keys::NAME;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use catlog_core::fields::{FieldScope, IdDisplay};
    use egui_kittest::Harness;
    use egui_kittest::kittest::Queryable;

    fn store() -> (tempfile::TempDir, Catalog) {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        c.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        c.create_cat("cat:b", "Tom", None, "cat").unwrap();
        c.define_field(
            "Mood",
            FieldType::Choice,
            FieldScope::Cat,
            &["calm", "wild"],
            IdDisplay::Plain,
            None,
            None,
        )
        .unwrap();
        c.define_field(
            "Visits",
            FieldType::Number,
            FieldScope::Cat,
            &[],
            IdDisplay::Plain,
            None,
            None,
        )
        .unwrap();
        (dir, c)
    }

    fn def(store: &Catalog, slug: &str) -> FieldDef {
        store.field_def(slug).unwrap().unwrap()
    }

    #[test]
    fn values_resolve_per_type_like_the_phones() {
        let (_dir, store) = store();
        let t = L10n::new("de");
        let mut e = FieldEditor::closed();
        e.ask(
            &store,
            &def(&store, "mood"),
            "cat:a",
            Some("calm"),
            EditTarget::New,
            None,
            "de",
        );
        assert_eq!(e.choice.as_deref(), Some("calm"));
        assert!(e.text.is_empty(), "an option belongs to the radios");
        e.text = " sleepy ".into();
        assert_eq!(e.value().as_deref(), Some("sleepy"), "a typed value wins");
        e.ask(
            &store,
            &def(&store, "mood"),
            "cat:a",
            Some("own"),
            EditTarget::New,
            None,
            "de",
        );
        assert_eq!(e.text, "own");
        e.ask(
            &store,
            &def(&store, "visits"),
            "cat:a",
            Some("4.5"),
            EditTarget::New,
            None,
            "de",
        );
        assert_eq!(e.text, "4,5");
        assert_eq!(e.value().as_deref(), Some("4.5"));
        e.text = "x".into();
        assert_eq!(e.value().as_deref(), Some("x"));
        e.text = " ".into();
        assert_eq!(e.value(), None);
        e.ask(
            &store,
            &def(&store, "weight"),
            "cat:a",
            Some("4250"),
            EditTarget::New,
            None,
            "de",
        );
        assert_eq!(e.text, "4,25");
        e.text = "5,1".into();
        assert_eq!(e.value().as_deref(), Some("5100"));
        e.text = "junk".into();
        assert_eq!(e.value(), None);
        e.ask(
            &store,
            &def(&store, "neutered"),
            "cat:a",
            None,
            EditTarget::New,
            None,
            "de",
        );
        e.choice = Some("yes".into());
        assert_eq!(e.value().as_deref(), Some("yes"));
        e.ask(
            &store,
            &def(&store, "birthdate"),
            "cat:a",
            Some("2021-05"),
            EditTarget::New,
            None,
            "de",
        );
        assert_eq!(e.value().as_deref(), Some("2021-05"));
        e.ask(
            &store,
            &def(&store, "looks"),
            "cat:a",
            Some("size=medium; colours=black"),
            EditTarget::New,
            None,
            "de",
        );
        e.looks.get_mut("colours").unwrap().push("white".into());
        assert_eq!(
            e.value().as_deref(),
            Some("size=medium; colours=black,white")
        );
        e.looks.clear();
        assert_eq!(e.value(), None);
        e.ask(
            &store,
            &def(&store, "remarks"),
            "cat:a",
            None,
            EditTarget::New,
            None,
            "de",
        );
        e.text = "  shy  ".into();
        assert_eq!(e.value().as_deref(), Some("shy"));
        e.ask(
            &store,
            &def(&store, "mother"),
            "cat:a",
            None,
            EditTarget::New,
            None,
            "de",
        );
        e.choice = Some("cat:b".into());
        assert_eq!(e.value().as_deref(), Some("cat:b"));
        assert_eq!(field_def_name(&t, &e.def), t.starter_mother());
    }

    #[test]
    fn the_as_of_moment_follows_the_typed_day_and_never_the_future() {
        let (_dir, store) = store();
        let mut e = FieldEditor::closed();
        e.ask(
            &store,
            &def(&store, "color"),
            "cat:a",
            None,
            EditTarget::New,
            Some("2026-01-05T09:30:00Z"),
            "en",
        );
        assert_eq!(e.as_of_day, NaiveDate::from_ymd_opt(2026, 1, 5).unwrap());
        assert!(e.as_of().starts_with("2026-01-05T"));
        assert_eq!(e.as_of_text, "2026-01-05");
        e.as_of_text = "3.1.2026".into();
        e.as_of_time = "08:15".into();
        assert!(e.as_of().starts_with("2026-01-03T") || e.as_of().starts_with("2026-01-02T"));
        e.as_of_text = "1.1.2999".into();
        assert!(
            e.as_of() < chrono::Utc::now().to_rfc3339(),
            "never the future"
        );
        e.as_of_text = "junk".into();
        e.as_of_time = "junk".into();
        let fallback = e.as_of();
        assert!(
            fallback.starts_with("2026-01-05T") || fallback.starts_with("2026-01-04T"),
            "the typed day falls back to the opened one, midnight local: {fallback}"
        );
    }

    #[test]
    fn the_dialog_saves_edits_corrections_and_the_private_mark() {
        let (_dir, store) = store();
        let t = L10n::new("en");
        let mut e = FieldEditor::closed();
        e.ask(
            &store,
            &def(&store, "color"),
            "cat:a",
            None,
            EditTarget::New,
            None,
            "en",
        );
        e.text = "black".into();
        e.private = true;
        struct State {
            e: FieldEditor,
            store: Catalog,
            t: L10n,
            saved: Option<FieldEdit>,
        }
        let mut h = Harness::builder()
            .with_size(egui::vec2(900.0, 700.0))
            .build_ui_state(
                |ui, s: &mut State| {
                    if let Some(edit) = s.e.show(ui.ctx(), &s.store, &s.t) {
                        apply_edit(&mut s.store, &s.e, &edit).unwrap();
                        s.saved = Some(edit);
                    }
                },
                State {
                    e,
                    store,
                    t,
                    saved: None,
                },
            );
        h.run();
        h.get_by_label("Color");
        h.get_by_label("Save").click();
        h.run();
        let s = h.state();
        assert_eq!(s.saved.as_ref().unwrap().value.as_deref(), Some("black"));
        assert_eq!(
            s.store.current("cat:a", "f:color").unwrap().as_deref(),
            Some("black")
        );
        assert!(s.store.is_field_private("cat:a", "f:color").unwrap());
        // A correction replaces the row and takes the mark off again.
        let seq = s.store.field_history("cat:a", "f:color", false).unwrap()[0].seq;
        let (d, entity) = (def(&s.store, "color"), "cat:a");
        let mut e = FieldEditor::closed();
        e.ask(
            &s.store,
            &d,
            entity,
            Some("black"),
            EditTarget::Correct(seq),
            Some("2026-01-01T10:00:00Z"),
            "en",
        );
        e.text = "grey".into();
        e.private = false;
        h.state_mut().e = e;
        h.run();
        h.get_by_label("Save").click();
        h.run();
        let s = h.state();
        assert_eq!(
            s.store.current("cat:a", "f:color").unwrap().as_deref(),
            Some("grey")
        );
        assert!(!s.store.is_field_private("cat:a", "f:color").unwrap());
        assert_eq!(
            s.store
                .field_history("cat:a", "f:color", false)
                .unwrap()
                .len(),
            1
        );
        // Escape cancels.
        let d = def(&s.store, "mood");
        let mut e = FieldEditor::closed();
        e.ask(&s.store, &d, "cat:a", None, EditTarget::New, None, "en");
        h.state_mut().e = e;
        h.run();
        h.get_by_label("wild").click();
        h.run();
        assert_eq!(h.state().e.choice.as_deref(), Some("wild"));
        h.key_press(egui::Key::Escape);
        h.run();
        assert!(!h.state().e.open);
        // A breed typed for a dog is learned for dogs.
        let s = h.state_mut();
        s.store.create_cat("cat:rex", "Rex", None, "dog").unwrap();
        let breed = def(&s.store, "breed");
        let mut e = FieldEditor::closed();
        e.ask(
            &s.store,
            &breed,
            "cat:rex",
            None,
            EditTarget::New,
            None,
            "en",
        );
        e.text = "Mutt".into();
        let edit = FieldEdit {
            value: e.value(),
            date: e.as_of(),
            private: false,
        };
        apply_edit(&mut s.store, &e, &edit).unwrap();
        assert_eq!(
            s.store.field_def("breed").unwrap().unwrap().extra_options["dog"],
            vec!["Mutt"]
        );
    }
}
