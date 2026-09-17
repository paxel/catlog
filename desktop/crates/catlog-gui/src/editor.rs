//! The editor for one Field value: type-aware input, the Private tick,
//! and an "as of" date so entries can be backdated. Saved as one entry;
//! a correction hides the entry it replaces.

use catlog_core::fields::{FieldDef, FieldType, breed_options};
use catlog_core::units::{
    UnitSystem, base_string, entry_unit, format_decimal, from_base, parse_entry, to_base,
};
use catlog_core::{Catalog, PartialDate, keys, looks};
use chrono::{NaiveDate, NaiveTime};
use egui::{Context, Key};

use crate::l10n::L10n;
use crate::labels::{field_def_name, field_value_display, format_day, format_number};

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
            id: 0,
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
        egui::Window::new(title)
            .id(egui::Id::new(("field-editor", self.id)))
            .collapsible(false)
            .resizable(false)
            .anchor(egui::Align2::CENTER_CENTER, egui::vec2(0.0, 0.0))
            .show(ctx, |ui| {
                ui.set_min_width(360.0);
                egui::ScrollArea::vertical()
                    .max_height(420.0)
                    .show(ui, |ui| {
                        self.show_input(ui, store, t, &def);
                    });
                ui.add_space(8.0);
                ui.checkbox(&mut self.private, t.private_label());
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
                let escape = ui.input(|i| i.key_pressed(Key::Escape));
                ui.horizontal(|ui| {
                    if ui.button(t.save()).clicked() {
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
        if result.is_some() || close {
            self.open = false;
        }
        result
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
                ui.text_edit_singleline(&mut self.text);
                ui.label(egui::RichText::new("51.34, 12.37").weak().small());
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
                if def.slug == "remarks" {
                    ui.add(egui::TextEdit::multiline(&mut self.text).desired_rows(4));
                } else {
                    ui.text_edit_singleline(&mut self.text);
                }
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
                for cat in store.cats(None).unwrap_or_default() {
                    if store.resolve_entity(&cat.id).unwrap_or_default() == me {
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
