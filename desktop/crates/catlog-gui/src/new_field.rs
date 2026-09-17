//! The one field-creation dialog: name, type, where it is used, the
//! options of a choice, the display and lookup of an ID, the dimension
//! of a unit value.

use catlog_core::fields::{FieldScope, FieldType, IdDisplay};
use catlog_core::registry::{LOOKUP_PLACEHOLDER, REGISTRY_PRESETS};
use catlog_core::units::Dimension;
use catlog_core::{Catalog, Error};
use egui::{Context, Key};

use crate::l10n::L10n;
use crate::labels::dimension_name;

pub struct NewFieldDialog {
    pub open: bool,
    pub name: String,
    pub field_type: FieldType,
    pub dimension: Dimension,
    pub scope: FieldScope,
    pub options: String,
    pub id_display: IdDisplay,
    pub lookup: String,
    pub error: Option<String>,
    id: u64,
}

impl Default for NewFieldDialog {
    fn default() -> Self {
        NewFieldDialog {
            open: false,
            name: String::new(),
            field_type: FieldType::Text,
            dimension: Dimension::Weight,
            scope: FieldScope::Cat,
            options: String::new(),
            id_display: IdDisplay::Plain,
            lookup: String::new(),
            error: None,
            id: 0,
        }
    }
}

/// The types a keeper can create; Looks is the built-in tags field.
const TYPES: [FieldType; 9] = [
    FieldType::Text,
    FieldType::YesNo,
    FieldType::Date,
    FieldType::Number,
    FieldType::Choice,
    FieldType::Location,
    FieldType::Cat,
    FieldType::Id,
    FieldType::UnitValue,
];

fn type_name(t: &L10n, field_type: FieldType) -> String {
    match field_type {
        FieldType::UnitValue => t.type_unit_value().to_string(),
        other => other.name().to_string(),
    }
}

impl NewFieldDialog {
    pub fn ask(&mut self, scope: FieldScope) {
        *self = NewFieldDialog {
            open: true,
            scope,
            id: self.id + 1,
            ..NewFieldDialog::default()
        };
    }

    /// Draws the dialog; the new definition's id once created.
    pub fn show(&mut self, ctx: &Context, store: &mut Catalog, t: &L10n) -> Option<String> {
        if !self.open {
            return None;
        }
        let mut created = None;
        let mut close = false;
        let modal = egui::Modal::new(egui::Id::new(("new-field", self.id))).show(ctx, |ui| {
            ui.set_min_width(360.0);
            ui.heading(t.new_field());
            ui.label(t.name());
            ui.text_edit_singleline(&mut self.name);
            if let Some(e) = &self.error {
                ui.colored_label(ui.visuals().error_fg_color, e);
            }
            ui.horizontal(|ui| {
                ui.label(t.field_type());
                egui::ComboBox::from_id_salt("field-type")
                    .selected_text(type_name(t, self.field_type))
                    .show_ui(ui, |ui| {
                        for ft in TYPES {
                            ui.selectable_value(&mut self.field_type, ft, type_name(t, ft));
                        }
                    });
            });
            if self.field_type == FieldType::UnitValue {
                ui.horizontal(|ui| {
                    ui.label(t.dimension());
                    egui::ComboBox::from_id_salt("dimension")
                        .selected_text(dimension_name(t, self.dimension))
                        .show_ui(ui, |ui| {
                            for d in Dimension::ALL {
                                ui.selectable_value(&mut self.dimension, d, dimension_name(t, d));
                            }
                        });
                });
            }
            ui.horizontal(|ui| {
                ui.label(t.used_on());
                ui.radio_value(&mut self.scope, FieldScope::Cat, t.for_cats());
                ui.radio_value(&mut self.scope, FieldScope::Clowder, t.for_clowders());
                ui.radio_value(&mut self.scope, FieldScope::Both, t.for_both());
            });
            if self.field_type == FieldType::Choice {
                ui.label(t.options_one_per_line());
                ui.add(egui::TextEdit::multiline(&mut self.options).desired_rows(4));
            }
            if self.field_type == FieldType::Id {
                ui.horizontal(|ui| {
                    ui.label(t.display_format());
                    ui.radio_value(&mut self.id_display, IdDisplay::Plain, t.display_plain());
                    ui.radio_value(&mut self.id_display, IdDisplay::Qr, t.display_qr());
                    ui.radio_value(
                        &mut self.id_display,
                        IdDisplay::Barcode,
                        t.display_barcode(),
                    );
                });
                ui.label(t.lookup_url_label());
                ui.text_edit_singleline(&mut self.lookup);
                ui.label(
                    egui::RichText::new(t.lookup_url_help(LOOKUP_PLACEHOLDER))
                        .weak()
                        .small(),
                );
                ui.horizontal(|ui| {
                    for preset in REGISTRY_PRESETS {
                        if ui.button(preset.name).clicked() {
                            if self.name.trim().is_empty() {
                                self.name = preset.name.to_string();
                            }
                            self.lookup = preset.template.to_string();
                        }
                    }
                });
            }
            let escape = ui.input(|i| i.key_pressed(Key::Escape));
            ui.horizontal(|ui| {
                if ui.button(t.create()).clicked() {
                    let options: Vec<String> = self
                        .options
                        .lines()
                        .map(str::trim)
                        .filter(|o| !o.is_empty())
                        .map(String::from)
                        .collect();
                    let refs: Vec<&str> = options.iter().map(String::as_str).collect();
                    match store.define_field(
                        &self.name,
                        self.field_type,
                        self.scope,
                        &refs,
                        self.id_display,
                        Some(self.lookup.trim()),
                        Some(self.dimension),
                    ) {
                        Ok(id) => created = Some(id),
                        Err(Error::Invalid(message)) => self.error = Some(message),
                        Err(e) => self.error = Some(e.to_string()),
                    }
                }
                if ui.button(t.cancel()).clicked() || escape {
                    close = true;
                }
            });
        });
        if created.is_some() || close || modal.should_close() {
            self.open = false;
            ctx.request_repaint();
        }
        created
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use egui_kittest::Harness;
    use egui_kittest::kittest::Queryable;

    #[test]
    fn a_field_is_defined_from_the_dialog_and_a_taken_name_refused() {
        let dir = tempfile::tempdir().unwrap();
        let store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        struct State {
            d: NewFieldDialog,
            store: Catalog,
            t: L10n,
            created: Option<String>,
        }
        let mut d = NewFieldDialog::default();
        d.ask(FieldScope::Clowder);
        let mut h = Harness::builder()
            .with_size(egui::vec2(900.0, 700.0))
            .build_ui_state(
                |ui, s: &mut State| {
                    if let Some(id) = s.d.show(ui.ctx(), &mut s.store, &s.t) {
                        s.created = Some(id);
                    }
                },
                State {
                    d,
                    store,
                    t: L10n::new("en"),
                    created: None,
                },
            );
        h.run();
        h.get_by_label("New field");
        h.state_mut().d.name = "Gender".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert!(h.state().d.open);
        h.get_by_label_contains("already exists");
        h.state_mut().d.name = "Vet Registry".into();
        h.state_mut().d.field_type = FieldType::Id;
        h.run();
        h.get_by_label("Tasso").click_accesskit();
        h.run();
        assert!(h.state().d.lookup.contains("tasso"));
        assert_eq!(h.state().d.name, "Vet Registry", "a typed name stays");
        h.get_by_label("QR code").click_accesskit();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(h.state().created.as_deref(), Some("fielddef:vet-registry"));
        let def = h.state().store.field_def("vet-registry").unwrap().unwrap();
        assert_eq!(
            (def.id_display, def.scope),
            (IdDisplay::Qr, FieldScope::Clowder)
        );
        assert!(def.lookup_url.unwrap().contains("{value}"));
        // A choice with options, a unit value with a dimension.
        h.state_mut().d.ask(FieldScope::Cat);
        h.state_mut().d.name = "Mood".into();
        h.state_mut().d.field_type = FieldType::Choice;
        h.state_mut().d.options = "calm\n\n wild \n".into();
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(
            h.state().store.field_def("mood").unwrap().unwrap().options,
            vec!["calm", "wild"]
        );
        h.state_mut().d.ask(FieldScope::Both);
        h.state_mut().d.name = "Height".into();
        h.state_mut().d.field_type = FieldType::UnitValue;
        h.state_mut().d.dimension = Dimension::Length;
        h.run();
        h.get_by_label("Create").click();
        h.run();
        assert_eq!(
            h.state()
                .store
                .field_def("height")
                .unwrap()
                .unwrap()
                .dimension,
            Some(Dimension::Length)
        );
        h.state_mut().d.ask(FieldScope::Cat);
        h.run();
        h.get_by_label("Cancel").click();
        h.run();
        assert!(!h.state().d.open);
        assert_eq!(type_name(&L10n::new("en"), FieldType::Date), "date");
    }
}
