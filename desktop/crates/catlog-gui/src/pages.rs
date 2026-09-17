//! The detail pane's pages in read mode: a Clowder with its Cats,
//! chores, Appointments and Fields; a Cat with its photos, chores,
//! Fields, family and timeline; the Strays. Every hold on the phone is
//! a right-click here.

use catlog_core::fields::{FieldDef, FieldScope, FieldType, IdDisplay};
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, EntityView, Entry, keys};
use egui::{Ui, Vec2};

use crate::agenda::{AppointmentAction, appointment_card};
use crate::chores::{ChoreAction, chore_row};
use crate::documents_page::DocKind;
use crate::l10n::L10n;
use crate::labels::{field_def_name, field_label, field_value_display, format_day, value_label};
use crate::textures::FaceCache;

/// What the keeper did on a page this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PageAction {
    None,
    OpenCat(String),
    OpenClowder(String),
    ToggleHidden(String),
    /// Edit this Field's value on this entity.
    Edit(String, String),
    /// Open this Field's history on this entity.
    History(String, String),
    /// Define a new Field for this scope.
    NewField(FieldScope),
    /// Move this Cat.
    Move(String),
    /// Record where this Cat was seen, picked on the map.
    Sighting(String),
    /// Show this entity on the map.
    ShowOnMap(String),
    /// Add photos from files to this Cat.
    AddPhoto(String),
    /// View this Cat's photo full size.
    ViewPhoto(String, String),
    /// Make this photo the Cat's Profile Image.
    SetProfile(String, String),
    /// Crop a new photo out of this one.
    CropPhoto(String, String),
    /// Ring the Cat in a copy of this photo.
    MarkPhoto(String, String),
    /// Delete this photo, after one confirmation.
    DeletePhoto(String, String),
    Chore(ChoreAction),
    NewAppointment(String),
    Appointment(AppointmentAction),
    /// Merge this Cat or Clowder into another.
    MergeInto(String),
    /// Open a document page for this Cat.
    Document(DocKind, String),
    /// A new Cat, in this Clowder or as a Stray.
    NewCat(Option<String>),
}

/// The pages' own state: the unit system values are read in.
pub struct Pages {
    pub units: UnitSystem,
    /// The day the pages count from.
    pub today: chrono::NaiveDate,
}

impl Default for Pages {
    fn default() -> Self {
        Pages {
            units: UnitSystem::Metric,
            today: chrono::Local::now().date_naive(),
        }
    }
}

impl Pages {
    pub fn new(units: UnitSystem) -> Pages {
        Pages {
            units,
            today: chrono::Local::now().date_naive(),
        }
    }

    /// The name shown for an entity, or the word for an unnamed one.
    fn name_of(store: &Catalog, t: &L10n, id: &str) -> String {
        store
            .current(id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string())
    }

    /// The Clowder page.
    pub fn show_clowder(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        id: &str,
    ) -> PageAction {
        let mut action = PageAction::None;
        let pet_mode = store.is_pet_mode().unwrap_or(false);
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.horizontal(|ui| {
                ui.heading(Self::name_of(store, t, id));
                if ui.button(t.new_cat()).clicked() {
                    action = PageAction::NewCat(Some(id.to_string()));
                }
                ui.menu_button(t.actions_menu(), |ui| {
                    if ui.button(t.merge_this_into(t.kind_clowder())).clicked() {
                        action = PageAction::MergeInto(id.to_string());
                        ui.close();
                    }
                });
            });
            if let Ok(Some(cover)) = store.profile_image(id)
                && let Some(texture) = faces.face(ui.ctx(), store, &cover)
            {
                ui.add(
                    egui::Image::from_texture(&texture).fit_to_exact_size(Vec2::new(480.0, 160.0)),
                );
            }
            let cats = store.cats(Some(id)).unwrap_or_default();
            ui.add_space(8.0);
            ui.strong(format!(
                "{} ({})",
                if pet_mode { t.cats_neutral() } else { t.cats() },
                cats.len()
            ));
            for cat in &cats {
                if let Some(a) = self.cat_row(ui, store, t, faces, cat) {
                    action = a;
                }
            }
            if let Some(a) = self.show_chores(ui, store, t, id) {
                action = a;
            }
            if let Some(a) = self.show_appointments(ui, store, t, id) {
                action = a;
            }
            let fields = self.show_fields(ui, store, t, id, FieldScope::Clowder);
            if fields != PageAction::None {
                action = fields;
            }
            self.show_timeline(ui, store, t, id);
        });
        action
    }

    /// The Cat page.
    pub fn show_cat(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        id: &str,
    ) -> PageAction {
        let mut action = PageAction::None;
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.horizontal(|ui| {
                ui.heading(Self::name_of(store, t, id));
                ui.menu_button(t.actions_menu(), |ui| {
                    if ui.button(t.move_to()).clicked() {
                        action = PageAction::Move(id.to_string());
                        ui.close();
                    }
                    if ui.button(t.seen_here_now()).clicked() {
                        action = PageAction::Sighting(id.to_string());
                        ui.close();
                    }
                    if ui.button(t.show_on_map()).clicked() {
                        action = PageAction::ShowOnMap(id.to_string());
                        ui.close();
                    }
                    if ui.button(t.merge_this_into(t.kind_cat())).clicked() {
                        action = PageAction::MergeInto(id.to_string());
                        ui.close();
                    }
                    ui.separator();
                    if ui.button(t.card()).clicked() {
                        action = PageAction::Document(DocKind::Card, id.to_string());
                        ui.close();
                    }
                    if ui.button(t.vet_report_menu()).clicked() {
                        action = PageAction::Document(DocKind::VetReport, id.to_string());
                        ui.close();
                    }
                    if ui.button(t.poster_menu()).clicked() {
                        action = PageAction::Document(DocKind::Poster, id.to_string());
                        ui.close();
                    }
                    let hidden = store.is_hidden(id).unwrap_or(false);
                    if ui
                        .button(if hidden {
                            t.unhide_label()
                        } else {
                            t.hide_label()
                        })
                        .clicked()
                    {
                        action = PageAction::ToggleHidden(id.to_string());
                        ui.close();
                    }
                });
            });
            if let Ok(Some(when)) = store.current(id, "f:deceased") {
                ui.label(egui::RichText::new(format!("{} · {when}", t.starter_deceased())).weak());
            }
            // Where it lives, as a way back to the place.
            ui.horizontal(|ui| {
                ui.label(t.clowder_label());
                match store.current(id, keys::CLOWDER).ok().flatten() {
                    Some(clowder) => {
                        if ui.link(Self::name_of(store, t, &clowder)).clicked() {
                            action = PageAction::OpenClowder(clowder);
                        }
                    }
                    None => {
                        ui.label(t.stray_no_clowder());
                    }
                }
            });
            // Photos lead on a Cat's page.
            let images = store.images(id).unwrap_or_default();
            let profile = store.profile_image(id).ok().flatten();
            ui.add_space(8.0);
            ui.horizontal(|ui| {
                ui.strong(format!("{} ({})", t.photos(), images.len()));
                if ui.button(t.add_photo()).clicked() {
                    action = PageAction::AddPhoto(id.to_string());
                }
            });
            ui.horizontal_wrapped(|ui| {
                for (i, hash) in images.iter().enumerate() {
                    let Some(texture) = faces.face(ui.ctx(), store, hash) else {
                        continue;
                    };
                    let image = egui::Image::from_texture(&texture)
                        .fit_to_exact_size(Vec2::splat(96.0))
                        .sense(egui::Sense::click());
                    let response = ui.add(image);
                    let label = format!("{} {}", t.photos(), i + 1);
                    response.widget_info(|| {
                        egui::WidgetInfo::labeled(egui::WidgetType::Button, true, &label)
                    });
                    let is_profile = profile.as_deref() == Some(hash.as_str());
                    if is_profile {
                        ui.painter().rect_stroke(
                            response.rect,
                            4.0,
                            egui::Stroke::new(2.0, ui.visuals().selection.bg_fill),
                            egui::StrokeKind::Outside,
                        );
                    }
                    if response.clicked() {
                        action = PageAction::ViewPhoto(id.to_string(), hash.clone());
                    }
                    response.context_menu(|ui| {
                        let profile_label = if is_profile {
                            t.this_is_profile_image()
                        } else {
                            t.set_as_profile_image()
                        };
                        if ui
                            .add_enabled(!is_profile, egui::Button::new(profile_label))
                            .clicked()
                        {
                            action = PageAction::SetProfile(id.to_string(), hash.clone());
                            ui.close();
                        }
                        if ui.button(t.crop_photo()).clicked() {
                            action = PageAction::CropPhoto(id.to_string(), hash.clone());
                            ui.close();
                        }
                        if ui.button(t.mark_photo()).clicked() {
                            action = PageAction::MarkPhoto(id.to_string(), hash.clone());
                            ui.close();
                        }
                        if ui.button(t.delete_photo()).clicked() {
                            action = PageAction::DeletePhoto(id.to_string(), hash.clone());
                            ui.close();
                        }
                    });
                }
            });
            if let Some(a) = self.show_chores(ui, store, t, id) {
                action = a;
            }
            if let Some(a) = self.show_appointments(ui, store, t, id) {
                action = a;
            }
            let fields = self.show_fields(ui, store, t, id, FieldScope::Cat);
            if fields != PageAction::None {
                action = fields;
            }
            if let Some(a) = self.show_family(ui, store, t, id) {
                action = a;
            }
            self.show_timeline(ui, store, t, id);
        });
        action
    }

    /// The Strays page: every Cat with no home right now.
    pub fn show_strays(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
    ) -> PageAction {
        let mut action = PageAction::None;
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.horizontal(|ui| {
                ui.heading(t.strays());
                if ui.button(t.new_cat()).clicked() {
                    action = PageAction::NewCat(None);
                }
            });
            let strays = store.strays().unwrap_or_default();
            if strays.is_empty() {
                ui.label(t.no_strays_right_now());
            }
            for cat in &strays {
                if let Some(a) = self.cat_row(ui, store, t, faces, cat) {
                    action = a;
                }
            }
        });
        action
    }

    /// One Cat as a row: face and name, a tap opens, a right-click holds
    /// the menu.
    fn cat_row(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
        cat: &EntityView,
    ) -> Option<PageAction> {
        let mut action = None;
        ui.horizontal(|ui| {
            if let Ok(Some(hash)) = store.profile_image(&cat.id)
                && let Some(texture) = faces.face(ui.ctx(), store, &hash)
            {
                ui.add(
                    egui::Image::from_texture(&texture)
                        .fit_to_exact_size(Vec2::splat(32.0))
                        .corner_radius(16.0),
                );
            }
            let hidden = store.is_hidden(&cat.id).unwrap_or(false);
            let text = if hidden {
                egui::RichText::new(&cat.name).weak()
            } else {
                egui::RichText::new(&cat.name)
            };
            let response = ui.selectable_label(false, text);
            if response.clicked() {
                action = Some(PageAction::OpenCat(cat.id.clone()));
            }
            response.context_menu(|ui| {
                if ui.button(t.open()).clicked() {
                    action = Some(PageAction::OpenCat(cat.id.clone()));
                    ui.close();
                }
                let hide = if hidden {
                    t.unhide_label()
                } else {
                    t.hide_label()
                };
                if ui.button(hide).clicked() {
                    action = Some(PageAction::ToggleHidden(cat.id.clone()));
                    ui.close();
                }
            });
        });
        action
    }

    /// The Fields offered for the entity, label and value, one row each.
    /// A double-click on a value edits it, a right-click holds the menu
    /// with the editor and the history; an ID shows as its code and, with
    /// a registry, as a link.
    fn show_fields(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        id: &str,
        scope: FieldScope,
    ) -> PageAction {
        let mut action = PageAction::None;
        let defs: Vec<FieldDef> = store.field_defs(Some(scope)).unwrap_or_default();
        let current = store.current_fields(id).unwrap_or_default();
        ui.add_space(8.0);
        ui.strong(t.fields());
        egui::Grid::new(("fields", id))
            .num_columns(2)
            .spacing([16.0, 4.0])
            .show(ui, |ui| {
                for def in &defs {
                    let value = current.get(&def.key()).cloned().flatten();
                    let withheld = store.is_withheld(id, &def.key()).unwrap_or(false);
                    ui.label(field_def_name(t, def));
                    let response = if withheld {
                        ui.label(egui::RichText::new(t.withheld_by_partner()).weak())
                    } else if def.field_type == FieldType::Id && value.is_some() {
                        self.show_id_value(ui, t, def, value.as_deref().unwrap_or_default())
                    } else {
                        // A cat reference reads as the cat's name, as in the history.
                        let shown = if def.field_type == FieldType::Cat {
                            value_label(t, store, &def.key(), value.as_deref(), self.units)
                        } else {
                            field_value_display(t, Some(def), value.as_deref(), self.units)
                        };
                        let private = store.is_field_private(id, &def.key()).unwrap_or(false);
                        let text = if private {
                            format!("{shown} · {}", t.private_label())
                        } else {
                            shown
                        };
                        ui.selectable_label(false, text)
                    };
                    if response.double_clicked() {
                        action = PageAction::Edit(id.to_string(), def.slug.clone());
                    }
                    response.context_menu(|ui| {
                        if ui.button(t.edit_value()).clicked() {
                            action = PageAction::Edit(id.to_string(), def.slug.clone());
                            ui.close();
                        }
                        if ui.button(t.show_history()).clicked() {
                            action = PageAction::History(id.to_string(), def.slug.clone());
                            ui.close();
                        }
                    });
                    ui.end_row();
                }
            });
        if ui.button(t.new_field()).clicked() {
            action = PageAction::NewField(scope);
        }
        action
    }

    /// An ID value: plain, or as its QR or barcode, and as a link when
    /// the Field points at a registry.
    fn show_id_value(
        &mut self,
        ui: &mut Ui,
        t: &L10n,
        def: &FieldDef,
        value: &str,
    ) -> egui::Response {
        let _ = t;
        ui.vertical(|ui| {
            let response = match catlog_core::registry::lookup_url(def, value) {
                Some(url) => ui.hyperlink_to(value, url),
                None => ui.selectable_label(false, value),
            };
            match def.id_display {
                IdDisplay::Plain => {}
                IdDisplay::Qr => {
                    crate::codes::qr(ui, value, 96.0);
                }
                IdDisplay::Barcode => {
                    if crate::codes::barcode(ui, value, 240.0, 48.0).is_none() {
                        crate::codes::qr(ui, value, 96.0);
                    }
                }
            }
            response
        })
        .inner
    }

    fn show_chores(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        id: &str,
    ) -> Option<PageAction> {
        let mut action = None;
        let chores = store.chores_of(id, false).unwrap_or_default();
        ui.add_space(8.0);
        ui.horizontal(|ui| {
            ui.strong(t.chores_section());
            if ui.button(t.new_chore()).clicked() {
                action = Some(PageAction::Chore(ChoreAction::New(id.to_string())));
            }
        });
        for chore in &chores {
            let a = chore_row(ui, store, t, chore, self.today);
            if a != ChoreAction::None {
                action = Some(PageAction::Chore(a));
            }
        }
        action
    }

    fn show_appointments(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        id: &str,
    ) -> Option<PageAction> {
        let mut action = None;
        let appointments = store.appointments_of(id, false).unwrap_or_default();
        ui.add_space(8.0);
        ui.horizontal(|ui| {
            ui.strong(t.planned_section());
            if ui.button(t.add_appointment()).clicked() {
                action = Some(PageAction::NewAppointment(id.to_string()));
            }
        });
        for a in &appointments {
            let group = store.group_of(a).unwrap_or_else(|_| vec![a.clone()]);
            if let Some(act) = appointment_card(ui, store, t, &group, group.len() > 1) {
                action = Some(PageAction::Appointment(act));
            }
        }
        action
    }

    fn show_family(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        id: &str,
    ) -> Option<PageAction> {
        let family = store.family(id).ok()?;
        let rows: Vec<(String, Vec<String>)> = [
            (
                t.starter_mother().to_string(),
                family.mother.into_iter().collect(),
            ),
            (
                t.starter_father().to_string(),
                family.father.into_iter().collect(),
            ),
            (t.littermates_label().to_string(), family.littermates),
            (t.siblings_label().to_string(), family.siblings),
            (t.kittens_label().to_string(), family.kittens),
        ]
        .into_iter()
        .filter(|(_, ids)| !ids.is_empty())
        .collect();
        if rows.is_empty() {
            return None;
        }
        let mut action = None;
        ui.add_space(8.0);
        ui.strong(t.family_section());
        for (label, ids) in rows {
            ui.horizontal(|ui| {
                ui.label(label);
                for cat in ids {
                    if ui.link(Self::name_of(store, t, &cat)).clicked() {
                        action = Some(PageAction::OpenCat(cat));
                    }
                }
            });
        }
        action
    }

    /// Every change ever made, newest first, behind a fold that is
    /// closed by default and remembered per device.
    fn show_timeline(&mut self, ui: &mut Ui, store: &Catalog, t: &L10n, id: &str) {
        ui.add_space(8.0);
        let key = "fold:timeline";
        let open = store.local_setting(key).as_deref() == Some("open");
        let header = egui::CollapsingHeader::new(t.timeline())
            .id_salt(("timeline", id))
            .default_open(open);
        let response = header.show(ui, |ui| {
            let entries: Vec<Entry> = store.timeline(id, false).unwrap_or_default();
            for e in entries.iter().take(200) {
                let label = field_label(t, store, &e.field);
                let value = value_label(t, store, &e.field, e.value.as_deref(), self.units);
                ui.label(format!("{label}: {value}"));
                let day = chrono::DateTime::parse_from_rfc3339(&e.date)
                    .map(|d| format_day(t.locale(), d.date_naive()))
                    .unwrap_or_else(|_| e.date.clone());
                ui.label(
                    egui::RichText::new(format!("{} · {day}", e.author))
                        .weak()
                        .small(),
                );
            }
        });
        let now_open = response.fully_open();
        if now_open != open {
            let _ = store.set_local_setting(key, if now_open { "open" } else { "closed" });
        }
    }
}
