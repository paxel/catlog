//! The documents of a Cat: the Card, the missing poster and the report
//! for the vet, each with the choices the phone offers, saved as PDF,
//! opened for printing, the Card also as an image.

use std::collections::BTreeSet;

use catlog_core::documents::{
    CardCode, CardContent, CodeKind, POSTER_QR_LIMIT, PosterCode, PosterContent, PosterPhoto,
    ReportContent, ReportCurve, ReportRow, ReportSummary, report_colour,
};
use catlog_core::fields::{FieldDef, FieldScope, FieldType, IdDisplay};
use catlog_core::fonts::FontSet;
use catlog_core::partial_date::PartialDate;
use catlog_core::registry::lookup_url;
use catlog_core::share::encode_share_data;
use catlog_core::{Catalog, keys};
use chrono::NaiveDate;
use egui::Ui;

use crate::l10n::L10n;
use crate::labels::{field_def_name, field_value_display, format_day, value_label};

/// Which document, and for whom.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DocKind {
    Card,
    Poster,
    VetReport,
}

/// What the keeper asked for on a document page this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum DocAction {
    None,
    SavePdf,
    Print,
    SaveImage,
}

/// The choices, kept while the page is open.
#[derive(Debug, Default)]
pub struct DocumentPage {
    pub kind: Option<DocKind>,
    pub cat: String,
    // Card.
    pub card_keys: BTreeSet<String>,
    // Poster.
    pub since: String,
    pub ticked: BTreeSet<String>,
    pub qr: bool,
    pub extra: String,
    pub photos: Vec<String>,
    // Report.
    pub fields: BTreeSet<String>,
    pub from: String,
    pub to: String,
    pub summary: bool,
    initialised: bool,
}

pub const PHOTO_KEY: &str = "$photo";

/// The Cat's Fields with a value, and its Clowder's, as poster rows.
fn poster_rows(store: &Catalog, cat: &str) -> Vec<(String, FieldDef, String)> {
    let mut rows = Vec::new();
    for def in store.field_defs(Some(FieldScope::Cat)).unwrap_or_default() {
        if let Ok(Some(v)) = store.current(cat, &def.key())
            && !v.is_empty()
        {
            rows.push((cat.to_string(), def, v));
        }
    }
    if let Ok(Some(home)) = store.current(cat, keys::CLOWDER) {
        for def in store
            .field_defs(Some(FieldScope::Clowder))
            .unwrap_or_default()
        {
            if let Ok(Some(v)) = store.current(&home, &def.key())
                && !v.is_empty()
            {
                rows.push((home.clone(), def, v));
            }
        }
    }
    rows
}

fn row_id(entity: &str, def: &FieldDef) -> String {
    format!("{entity}|{}", def.key())
}

fn default_on(def: &FieldDef) -> bool {
    def.field_type == FieldType::Id || ["looks", "address", "phone"].contains(&def.slug.as_str())
}

/// Fields with a history on this Cat: what a report can carry.
fn reportable_fields(store: &Catalog, cat: &str) -> Vec<FieldDef> {
    store
        .field_defs(Some(FieldScope::Cat))
        .unwrap_or_default()
        .into_iter()
        .filter(|d| {
            store
                .field_history(cat, &d.key(), false)
                .map(|h| h.iter().any(|e| !e.reminder))
                .unwrap_or(false)
        })
        .collect()
}

/// The keys the Card shows, as chosen on this device: the photo, the
/// Clowder and every Cat Field but locations until the keeper picks.
pub fn card_keys(store: &Catalog) -> BTreeSet<String> {
    match store.local_setting("cardFields") {
        Some(saved) => saved
            .lines()
            .filter(|k| !k.is_empty())
            .map(String::from)
            .collect(),
        None => {
            let mut keys: BTreeSet<String> = [PHOTO_KEY.to_string(), keys::CLOWDER.to_string()]
                .into_iter()
                .collect();
            for def in store.field_defs(Some(FieldScope::Cat)).unwrap_or_default() {
                if def.field_type != FieldType::Location {
                    keys.insert(def.key());
                }
            }
            keys
        }
    }
}

/// The patient summary the vet report opens with, as the Vet view
/// shows it: species, breed, gender, neutered, birth date and age, the
/// chip, the home with its owner and contact. Only what is known.
pub fn patient_facts(
    store: &Catalog,
    t: &L10n,
    cat: &str,
    today: NaiveDate,
    units: catlog_core::units::UnitSystem,
) -> Vec<(String, String)> {
    let value = |slug: &str| -> Option<String> {
        let key = keys::user_field(slug);
        store
            .current(cat, &key)
            .ok()
            .flatten()
            .map(|v| value_label(t, store, &key, Some(&v), units))
    };
    let home = store.current(cat, keys::CLOWDER).ok().flatten();
    let home_value = |slug: &str| -> Option<String> {
        home.as_ref()
            .and_then(|h| store.current(h, &keys::user_field(slug)).ok().flatten())
    };
    let born = store
        .current(cat, &keys::user_field("birthdate"))
        .ok()
        .flatten();
    let rows: Vec<(String, Option<String>)> = vec![
        (t.starter_species().to_string(), value("species")),
        (t.starter_breed().to_string(), value("breed")),
        (t.starter_gender().to_string(), value("gender")),
        (t.starter_neutered().to_string(), value("neutered")),
        (t.starter_birthdate().to_string(), value("birthdate")),
        (
            t.age_label().to_string(),
            age_text(t, born.as_deref(), today),
        ),
        (t.starter_chip_id().to_string(), value("chipid")),
        (
            t.clowder_label().to_string(),
            home.as_ref().map(|h| DocumentPage::name_of(store, t, h)),
        ),
        (t.vet_report_owner().to_string(), home_value("responsible")),
        (t.starter_phone().to_string(), home_value("phone")),
        (t.starter_address().to_string(), home_value("address")),
    ];
    rows.into_iter()
        .filter_map(|(l, v)| v.map(|v| (l, v)))
        .collect()
}

/// "2 years 3 months" from a birth date.
pub fn age_text(t: &L10n, birth: Option<&str>, today: NaiveDate) -> Option<String> {
    let born = PartialDate::parse(birth?)?.earliest()?;
    let mut months = (today.year() - born.year()) * 12 + today.month() as i32 - born.month() as i32;
    if today.day() < born.day() {
        months -= 1;
    }
    if months < 0 {
        return None;
    }
    let (years, rest) = (months / 12, months % 12);
    let mut parts = Vec::new();
    if years > 0 {
        parts.push(format!("{years} {}", t.unit_years()));
    }
    if rest > 0 || years == 0 {
        parts.push(format!("{rest} {}", t.unit_months()));
    }
    Some(parts.join(" "))
}

use chrono::Datelike;

impl DocumentPage {
    /// Opens a document page for `cat`.
    pub fn open(&mut self, store: &Catalog, kind: DocKind, cat: &str, today: NaiveDate) {
        self.kind = Some(kind);
        self.cat = cat.to_string();
        self.initialised = true;
        match kind {
            DocKind::Card => {
                self.card_keys = card_keys(store);
            }
            DocKind::Poster => {
                self.since = today.to_string();
                self.qr = true;
                self.extra.clear();
                self.ticked = poster_rows(store, cat)
                    .iter()
                    .filter(|(_, def, _)| default_on(def))
                    .map(|(e, def, _)| row_id(e, def))
                    .collect();
                self.photos = store
                    .profile_image(cat)
                    .ok()
                    .flatten()
                    .into_iter()
                    .collect();
            }
            DocKind::VetReport => {
                let fields = reportable_fields(store, cat);
                self.fields = fields.iter().map(|d| d.key()).collect();
                self.summary = true;
                self.to = today.to_string();
                let first = fields
                    .iter()
                    .flat_map(|d| {
                        store
                            .field_history(cat, &d.key(), false)
                            .unwrap_or_default()
                    })
                    .filter_map(|e| e.date.get(..10).and_then(|d| d.parse::<NaiveDate>().ok()))
                    .min();
                self.from = first.unwrap_or(today).to_string();
            }
        }
    }

    pub fn close(&mut self) {
        self.kind = None;
    }

    pub fn name_of(store: &Catalog, t: &L10n, id: &str) -> String {
        store
            .current(id, keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string())
    }

    /// The Card as chosen.
    pub fn card_content(
        &self,
        store: &Catalog,
        t: &L10n,
        units: catlog_core::units::UnitSystem,
    ) -> CardContent {
        let cat = &self.cat;
        let mut facts = Vec::new();
        if self.card_keys.contains(keys::CLOWDER) {
            let home = store.current(cat, keys::CLOWDER).ok().flatten();
            facts.push((
                t.clowder_label().to_string(),
                match home {
                    Some(h) => Self::name_of(store, t, &h),
                    None => t.stray_no_clowder().to_string(),
                },
            ));
        }
        let mut codes = Vec::new();
        for def in store.field_defs(Some(FieldScope::Cat)).unwrap_or_default() {
            if !self.card_keys.contains(&def.key()) {
                continue;
            }
            let Ok(Some(value)) = store.current(cat, &def.key()) else {
                continue;
            };
            if value.is_empty() {
                continue;
            }
            if def.field_type == FieldType::Cat {
                let name = store
                    .resolve_entity(&value)
                    .ok()
                    .and_then(|id| store.current(&id, keys::NAME).ok().flatten());
                if let Some(name) = name.filter(|n| !n.is_empty()) {
                    facts.push((field_def_name(t, &def), name));
                }
                continue;
            }
            facts.push((
                field_def_name(t, &def),
                field_value_display(t, Some(&def), Some(&value), units),
            ));
            if def.field_type == FieldType::Id {
                let caption = format!("{}: {value}", field_def_name(t, &def));
                match def.id_display {
                    IdDisplay::Qr => codes.push(CardCode {
                        kind: CodeKind::Qr,
                        data: lookup_url(&def, &value).unwrap_or_else(|| value.clone()),
                        caption,
                    }),
                    IdDisplay::Barcode => codes.push(CardCode {
                        kind: CodeKind::Code128,
                        data: value.clone(),
                        caption,
                    }),
                    IdDisplay::Plain => {}
                }
            }
        }
        let photo = if self.card_keys.contains(PHOTO_KEY) {
            store
                .profile_image(cat)
                .ok()
                .flatten()
                .and_then(|h| store.image_bytes(&h))
        } else {
            None
        };
        CardContent {
            name: Self::name_of(store, t, cat),
            photo,
            facts,
            codes,
        }
    }

    /// The share the poster's QR carries, when it fits one code.
    pub fn poster_payload(&self, store: &Catalog) -> Option<String> {
        let rows = poster_rows(store, &self.cat);
        let fields: BTreeSet<String> = rows
            .iter()
            .filter(|(e, def, _)| self.ticked.contains(&row_id(e, def)))
            .map(|(_, def, _)| def.key())
            .collect();
        let mut random = [0u8; 4];
        let _ = getrandom::fill(&mut random);
        let bytes = store
            .cat_share_bytes(
                &self.cat,
                &fields,
                false,
                &format!("share-{}", hex::encode(random)),
            )
            .ok()?;
        let payload = encode_share_data(&bytes);
        (payload.len() <= POSTER_QR_LIMIT).then_some(payload)
    }

    /// The poster as chosen.
    pub fn poster_content(
        &self,
        store: &Catalog,
        t: &L10n,
        units: catlog_core::units::UnitSystem,
    ) -> PosterContent {
        let cat = &self.cat;
        let rows = poster_rows(store, cat);
        let since = self
            .since
            .trim()
            .parse::<NaiveDate>()
            .map(|d| format_day(t.locale(), d))
            .unwrap_or_else(|_| self.since.clone());
        let mut lines = vec![format!("{}: {since}", t.missing_since_label())];
        let mut phone = None;
        let mut looks = None;
        let mut codes = Vec::new();
        if self.qr
            && let Some(payload) = self.poster_payload(store)
        {
            codes.push(PosterCode {
                data: payload,
                caption: t.poster_qr().to_string(),
            });
        }
        for (entity, def, value) in rows
            .iter()
            .filter(|(e, def, _)| self.ticked.contains(&row_id(e, def)))
        {
            let label = field_def_name(t, def);
            let shown = value_label(t, store, &def.key(), Some(value), units);
            match def.slug.as_str() {
                "phone" => phone = Some(value.clone()),
                "looks" => looks = Some(shown),
                _ => lines.push(format!("{label}: {shown}")),
            }
            if def.field_type == FieldType::Id {
                codes.push(PosterCode {
                    data: lookup_url(def, value).unwrap_or_else(|| value.clone()),
                    caption: format!("{label}: {value}"),
                });
            } else if def.field_type == FieldType::Location
                && let Some((lat, lon)) = catlog_core::entities::parse_position(Some(value))
            {
                codes.push(PosterCode {
                    data: format!("geo:{lat},{lon}"),
                    caption: label,
                });
            }
            let _ = entity;
        }
        let photos = self
            .photos
            .iter()
            .take(2)
            .filter_map(|h| store.image_bytes(h))
            .map(PosterPhoto::whole)
            .collect();
        PosterContent {
            headline: t.poster_headline().to_string(),
            name: Self::name_of(store, t, cat),
            photos,
            lines,
            phone,
            looks,
            extra: Some(self.extra.trim().to_string()).filter(|e| !e.is_empty()),
            standing: t.poster_standing().to_string(),
            codes,
        }
    }

    /// The report as chosen.
    pub fn report_content(
        &self,
        store: &Catalog,
        t: &L10n,
        units: catlog_core::units::UnitSystem,
        today: NaiveDate,
        fonts_complete: bool,
    ) -> ReportContent {
        let cat = &self.cat;
        let fields: Vec<FieldDef> = reportable_fields(store, cat)
            .into_iter()
            .filter(|d| self.fields.contains(&d.key()))
            .collect();
        let colour_of = |key: &str| {
            fields
                .iter()
                .position(|d| d.key() == key)
                .map(report_colour)
                .unwrap_or(0x9e9e9e)
        };
        let from = self.from.trim().parse::<NaiveDate>().unwrap_or(today);
        let to = self.to.trim().parse::<NaiveDate>().unwrap_or(today);
        let mut entries: Vec<(NaiveDate, FieldDef, catlog_core::Entry)> = Vec::new();
        for def in &fields {
            for e in store
                .field_history(cat, &def.key(), false)
                .unwrap_or_default()
            {
                if e.reminder {
                    continue;
                }
                let Some(day) = e.date.get(..10).and_then(|d| d.parse::<NaiveDate>().ok()) else {
                    continue;
                };
                if day >= from && day <= to {
                    entries.push((day, def.clone(), e));
                }
            }
        }
        entries.sort_by(|a, b| a.2.date.cmp(&b.2.date));
        let mut rows = Vec::new();
        let mut last_day: Option<NaiveDate> = None;
        for (day, def, e) in &entries {
            rows.push(ReportRow {
                day: if last_day == Some(*day) {
                    String::new()
                } else {
                    format_day(t.locale(), *day)
                },
                colour: colour_of(&def.key()),
                label: field_def_name(t, def),
                value: field_value_display(t, Some(def), e.value.as_deref(), units),
            });
            last_day = Some(*day);
        }
        let mut curves = Vec::new();
        for def in &fields {
            if !matches!(def.field_type, FieldType::Number | FieldType::UnitValue) {
                continue;
            }
            let points: Vec<catlog_core::GraphPoint> = store
                .history_points(cat, &def.key())
                .unwrap_or_default()
                .into_iter()
                .filter(|p| {
                    let day = chrono::DateTime::from_timestamp_millis(p.at).map(|d| d.date_naive());
                    day.is_some_and(|d| d >= from && d <= to)
                })
                .collect();
            if points.len() < 2 {
                continue;
            }
            let (first, last) = (points[0].at, points[points.len() - 1].at);
            curves.push(ReportCurve {
                title: format!("{} · {}", field_def_name(t, def), t.vet_report_curves()),
                colour: colour_of(&def.key()),
                points,
                from: first,
                to: last,
                axis: (format_day(t.locale(), from), format_day(t.locale(), to)),
            });
        }
        let summary = self.summary.then(|| ReportSummary {
            title: t.vet_report_summary().to_string(),
            photo: store
                .profile_image(cat)
                .ok()
                .flatten()
                .and_then(|h| store.image_bytes(&h)),
            facts: patient_facts(store, t, cat, today, units),
        });
        ReportContent {
            name: Self::name_of(store, t, cat),
            timeline_title: t.timeline().to_string(),
            legend_title: t.vet_report_legend().to_string(),
            legend: fields
                .iter()
                .map(|d| (field_def_name(t, d), colour_of(&d.key())))
                .collect(),
            summary,
            rows,
            curves,
            note: (!fonts_complete).then(|| t.fonts_incomplete().to_string()),
        }
    }

    /// The file name a document is saved under.
    pub fn file_name(&self, store: &Catalog, t: &L10n) -> String {
        let name = Self::name_of(store, t, &self.cat);
        match self.kind {
            Some(DocKind::Card) => format!("{name}-card.pdf"),
            Some(DocKind::Poster) => format!("{name} {}.pdf", t.poster_headline()),
            _ => format!("{name}-vet-report.pdf"),
        }
    }

    /// The page: the choices on the left, the verbs on top.
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        fonts_complete: bool,
    ) -> DocAction {
        let mut action = DocAction::None;
        let Some(kind) = self.kind else {
            return action;
        };
        let name = Self::name_of(store, t, &self.cat);
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.heading(match kind {
                DocKind::Card => t.card_title(&name),
                DocKind::Poster => format!("{} — {name}", t.poster_headline()),
                DocKind::VetReport => format!("{} — {name}", t.vet_report_title()),
            });
            ui.horizontal(|ui| {
                if ui.button(t.save_pdf()).clicked() {
                    action = DocAction::SavePdf;
                }
                if ui.button(t.print()).clicked() {
                    action = DocAction::Print;
                }
                if kind == DocKind::Card && ui.button(t.save_image()).clicked() {
                    action = DocAction::SaveImage;
                }
            });
            ui.label(egui::RichText::new(t.print_hint()).weak());
            if !fonts_complete {
                ui.colored_label(ui.visuals().error_fg_color, t.fonts_incomplete());
            }
            ui.add_space(8.0);
            match kind {
                DocKind::Card => {
                    let chips = ui.strong(t.card_content());
                    crate::tips::anchor(ui, "card-chips", &chips);
                    let mut toggle = |ui: &mut Ui, key: &str, label: &str| {
                        let mut on = self.card_keys.contains(key);
                        if ui.checkbox(&mut on, label).changed() {
                            if on {
                                self.card_keys.insert(key.to_string());
                            } else {
                                self.card_keys.remove(key);
                            }
                            let joined: Vec<&str> =
                                self.card_keys.iter().map(String::as_str).collect();
                            let _ = store.set_local_setting("cardFields", &joined.join("\n"));
                        }
                    };
                    toggle(ui, PHOTO_KEY, t.photos());
                    toggle(ui, keys::CLOWDER, t.clowder_label());
                    for def in store.field_defs(Some(FieldScope::Cat)).unwrap_or_default() {
                        if store
                            .current(&self.cat, &def.key())
                            .ok()
                            .flatten()
                            .is_some_and(|v| !v.is_empty())
                        {
                            toggle(ui, &def.key(), &field_def_name(t, &def));
                        }
                    }
                }
                DocKind::Poster => {
                    ui.horizontal(|ui| {
                        ui.label(t.missing_since_label());
                        ui.add(
                            egui::TextEdit::singleline(&mut self.since)
                                .desired_width(100.0)
                                .hint_text(t.date_hint()),
                        );
                    });
                    ui.strong(t.poster_photos());
                    for hash in store.images(&self.cat).unwrap_or_default() {
                        let mut on = self.photos.contains(&hash);
                        let label = format!(
                            "{} {}",
                            t.photos(),
                            self.photos
                                .iter()
                                .position(|h| *h == hash)
                                .map(|i| (i + 1).to_string())
                                .unwrap_or_default()
                        );
                        if ui.checkbox(&mut on, label.trim()).changed() {
                            if on && self.photos.len() < 2 {
                                self.photos.push(hash.clone());
                            } else {
                                self.photos.retain(|h| *h != hash);
                            }
                        }
                    }
                    ui.add_space(6.0);
                    for (entity, def, value) in poster_rows(store, &self.cat) {
                        let id = row_id(&entity, &def);
                        let mut on = self.ticked.contains(&id);
                        let label = format!(
                            "{}: {}",
                            field_def_name(t, &def),
                            value_label(t, store, &def.key(), Some(&value), self_units())
                        );
                        if ui.checkbox(&mut on, label).changed() {
                            if on {
                                self.ticked.insert(id);
                            } else {
                                self.ticked.remove(&id);
                            }
                        }
                    }
                    let fits = self.poster_payload(store).is_some();
                    let mut qr = self.qr && fits;
                    if ui
                        .add_enabled(fits, egui::Checkbox::new(&mut qr, t.poster_qr()))
                        .changed()
                    {
                        self.qr = qr;
                    }
                    if !fits {
                        ui.label(egui::RichText::new(t.poster_qr_too_big()).weak());
                    }
                    ui.horizontal(|ui| {
                        ui.label(t.poster_free_text());
                        ui.add(egui::TextEdit::singleline(&mut self.extra).desired_width(300.0));
                    });
                }
                DocKind::VetReport => {
                    ui.horizontal(|ui| {
                        ui.label(t.vet_report_from());
                        ui.add(
                            egui::TextEdit::singleline(&mut self.from)
                                .desired_width(100.0)
                                .hint_text(t.date_hint()),
                        );
                        ui.label(t.vet_report_to());
                        ui.add(
                            egui::TextEdit::singleline(&mut self.to)
                                .desired_width(100.0)
                                .hint_text(t.date_hint()),
                        );
                    });
                    ui.checkbox(&mut self.summary, t.vet_report_summary());
                    ui.strong(t.vet_report_fields());
                    for def in reportable_fields(store, &self.cat) {
                        let key = def.key();
                        let mut on = self.fields.contains(&key);
                        if ui.checkbox(&mut on, field_def_name(t, &def)).changed() {
                            if on {
                                self.fields.insert(key);
                            } else {
                                self.fields.remove(&key);
                            }
                        }
                    }
                }
            }
        });
        action
    }
}

fn self_units() -> catlog_core::units::UnitSystem {
    catlog_core::units::UnitSystem::Metric
}

/// Draws `text` at (x, y) into `img`; returns the y below the line.
fn draw_text(
    img: &mut image::RgbaImage,
    font: &ab_glyph::FontRef,
    size: f32,
    x: f32,
    y: f32,
    text: &str,
    gray: u8,
) -> f32 {
    use ab_glyph::{Font as _, ScaleFont as _};
    let (width, height) = (img.width(), img.height());
    let scaled = font.as_scaled(ab_glyph::PxScale::from(size));
    let mut cursor = x;
    let baseline = y + scaled.ascent();
    for c in text.chars() {
        let id = scaled.glyph_id(c);
        let glyph = id.with_scale_and_position(size, ab_glyph::point(cursor, baseline));
        if let Some(outline) = font.outline_glyph(glyph) {
            let bounds = outline.px_bounds();
            outline.draw(|gx, gy, cov| {
                let px = bounds.min.x as i32 + gx as i32;
                let py = bounds.min.y as i32 + gy as i32;
                if px >= 0 && py >= 0 && (px as u32) < width && (py as u32) < height {
                    let p = img.get_pixel_mut(px as u32, py as u32);
                    let v = (255.0 - (255.0 - gray as f32) * cov) as u8;
                    p[0] = p[0].min(v);
                    p[1] = p[1].min(v);
                    p[2] = p[2].min(v);
                }
            });
        }
        cursor += scaled.h_advance(id);
    }
    y + scaled.height()
}

/// The Card drawn to pixels, for sharing as a picture.
pub fn card_png(card: &CardContent, fonts: &FontSet) -> Option<Vec<u8>> {
    let regular = ab_glyph::FontRef::try_from_slice(fonts.regular.data()).ok()?;
    let bold = ab_glyph::FontRef::try_from_slice(fonts.bold.data()).ok()?;
    let (width, height) = (800u32, 1100u32);
    let mut img = image::RgbaImage::from_pixel(width, height, image::Rgba([255, 255, 255, 255]));
    let mut y = 40.0;
    if let Some(photo) = &card.photo
        && let Ok(decoded) = image::load_from_memory(photo)
    {
        let thumb = decoded
            .resize(width - 80, 400, image::imageops::FilterType::Triangle)
            .to_rgba8();
        let x = (width - thumb.width()) / 2;
        image::imageops::overlay(&mut img, &thumb, x as i64, y as i64);
        y += thumb.height() as f32 + 24.0;
    }
    y = draw_text(&mut img, &bold, 56.0, 40.0, y, &card.name, 0) + 16.0;
    for (label, value) in &card.facts {
        draw_text(&mut img, &regular, 24.0, 40.0, y, label, 110);
        y = draw_text(&mut img, &regular, 24.0, 300.0, y, value, 0) + 6.0;
    }
    for code in &card.codes {
        y += 16.0;
        if code.kind == CodeKind::Qr
            && let Ok(qr) = qrcode::QrCode::new(code.data.as_bytes())
        {
            let n = qr.width();
            let colors = qr.to_colors();
            let cell = 160.0 / (n as f32 + 4.0);
            for row in 0..n {
                for col in 0..n {
                    if colors[row * n + col] == qrcode::Color::Dark {
                        let x0 = 40.0 + (col as f32 + 2.0) * cell;
                        let y0 = y + (row as f32 + 2.0) * cell;
                        for py in y0 as u32..(y0 + cell + 0.5) as u32 {
                            for px in x0 as u32..(x0 + cell + 0.5) as u32 {
                                if px < width && py < height {
                                    img.put_pixel(px, py, image::Rgba([0, 0, 0, 255]));
                                }
                            }
                        }
                    }
                }
            }
            y += 160.0;
        }
        y = draw_text(&mut img, &regular, 18.0, 40.0, y, &code.caption, 110) + 4.0;
    }
    let mut out = Vec::new();
    image::DynamicImage::ImageRgba8(img)
        .write_to(&mut std::io::Cursor::new(&mut out), image::ImageFormat::Png)
        .ok()?;
    Some(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn ages_read_in_years_and_months() {
        let t = L10n::new("en");
        let today = NaiveDate::from_ymd_opt(2026, 3, 10).unwrap();
        assert_eq!(
            age_text(&t, Some("2024-01-15"), today).as_deref(),
            Some("2 years 1 months")
        );
        assert_eq!(
            age_text(&t, Some("2026-01-20"), today).as_deref(),
            Some("1 months")
        );
        assert_eq!(age_text(&t, Some("2027-01-20"), today), None);
        assert_eq!(
            age_text(&t, Some("2024"), today).as_deref(),
            Some("2 years 2 months")
        );
        assert_eq!(age_text(&t, None, today), None);
        assert_eq!(age_text(&t, Some("junk"), today), None);
    }

    #[test]
    fn the_card_becomes_a_picture() {
        let fonts = FontSet::bundled().unwrap();
        let img = image::DynamicImage::new_rgb8(40, 30);
        let mut jpeg = Vec::new();
        img.write_to(
            &mut std::io::Cursor::new(&mut jpeg),
            image::ImageFormat::Jpeg,
        )
        .unwrap();
        let card = CardContent {
            name: "Miezi".into(),
            photo: Some(jpeg),
            facts: vec![("Gender".into(), "female".into())],
            codes: vec![CardCode {
                kind: CodeKind::Qr,
                data: "x".into(),
                caption: "Chip".into(),
            }],
        };
        let png = card_png(&card, &fonts).unwrap();
        let decoded = image::load_from_memory(&png).unwrap();
        assert_eq!((decoded.width(), decoded.height()), (800, 1100));
        let dark = decoded.to_luma8().pixels().filter(|p| p[0] < 128).count();
        assert!(dark > 1000, "text, photo and code leave ink");
    }
}
