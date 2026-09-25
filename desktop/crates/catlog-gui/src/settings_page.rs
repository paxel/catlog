//! The Settings page: the keeper, the language, the units, the cheers
//! and the tips; the Catalog's own settings below it; and the
//! Achievements page.

use catlog_core::achievements::{
    FULL_CENTURY, FULL_DECADE, FULL_MONTH, FULL_YEAR, LadderState, MASTER_PREFIX, rank_for,
    unlocked_coats,
};
use catlog_core::catalogs::CatalogManager;
use catlog_core::units::UNITS_SETTING;
use catlog_core::{Catalog, keys};
use egui::Ui;

use crate::l10n::{self, L10n};
use crate::labels::{format_day, title_words};
use crate::sounds::{Cheer, Preset, SoundChoice, sound_for};

/// What the keeper asked for on the Settings page this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum SettingsAction {
    None,
    Author(String),
    Locale(&'static str),
    Units(Option<&'static str>),
    ResetTips,
    RenameCatalog,
    DeleteCatalog,
    OpenBackups,
    OpenAchievements,
    /// The Eye candy switch: motion on or off.
    EyeCandy(bool),
    /// A moment's sound picked: kept and heard.
    Sound(Cheer, SoundChoice),
    /// Own sound… for a moment: the file dialog, then kept and heard.
    PickSound(Cheer),
}

#[derive(Debug, Default)]
pub struct SettingsPage {
    pub author: String,
    pending_mode: Option<bool>,
    pending_title: Option<Option<String>>,
}

pub const CELEBRATIONS: &str = "celebrations";
pub const PET_MODE_ENTITY: &str = "catalog:mode";
pub const PET_MODE_FIELD: &str = "mode";

/// The rank's word.
pub fn rank_name(t: &L10n, rank: &str) -> &'static str {
    match rank {
        "servant" => t.rank_servant(),
        "butler" => t.rank_butler(),
        "steward" => t.rank_steward(),
        "chancellor" => t.rank_chancellor(),
        _ => t.rank_minister(),
    }
}

/// "A full month", or "Butler (Feed)".
pub fn ladder_name(t: &L10n, s: &LadderState) -> String {
    match s.id.as_str() {
        FULL_MONTH => t.achievement_month().to_string(),
        FULL_YEAR => t.achievement_year().to_string(),
        FULL_DECADE => t.achievement_decade().to_string(),
        FULL_CENTURY => t.achievement_century().to_string(),
        _ => t.title_with_chore(
            rank_name(t, rank_for(s.tier).unwrap_or("servant")),
            s.title.as_deref().unwrap_or_default(),
        ),
    }
}

fn coat_name(t: &L10n, coat: &str) -> String {
    match coat {
        "calico" => t.coat_calico().to_string(),
        "snowLeopard" => t.coat_snow_leopard().to_string(),
        "siamese" => t.coat_siamese().to_string(),
        "lynx" => t.coat_lynx().to_string(),
        "tortoiseshell" => t.coat_tortoiseshell().to_string(),
        other => other.to_string(),
    }
}

impl SettingsPage {
    pub fn open(&mut self, author: Option<&str>) {
        self.author = author.unwrap_or_default().to_string();
    }

    #[allow(clippy::too_many_arguments)]
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        manager: &CatalogManager,
        t: &L10n,
        locale: &str,
        key_code: &str,
        ladders: &[LadderState],
        eye_candy: bool,
    ) -> SettingsAction {
        let mut action = SettingsAction::None;
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.heading(t.settings());
            egui::Grid::new("settings").num_columns(2).show(ui, |ui| {
                ui.label(t.name());
                let edit =
                    ui.add(egui::TextEdit::singleline(&mut self.author).desired_width(240.0));
                if edit.lost_focus() && !self.author.trim().is_empty() {
                    action = SettingsAction::Author(self.author.trim().to_string());
                }
                ui.end_row();
                ui.label(t.language());
                egui::ComboBox::from_id_salt("settings-locale")
                    .selected_text(format!("{} ({locale})", l10n::native_name(locale)))
                    .show_ui(ui, |ui| {
                        for l in l10n::LOCALES {
                            if ui
                                .selectable_label(
                                    *l == *locale,
                                    format!("{} ({l})", l10n::native_name(l)),
                                )
                                .clicked()
                            {
                                action = SettingsAction::Locale(l);
                            }
                        }
                    });
                ui.end_row();
                ui.label(t.units_label());
                let chosen = store.local_setting(UNITS_SETTING);
                let current = match chosen.as_deref() {
                    Some("metric") => t.units_metric(),
                    Some("imperial") => t.units_imperial(),
                    _ => t.units_auto(),
                };
                egui::ComboBox::from_id_salt("settings-units")
                    .selected_text(current)
                    .show_ui(ui, |ui| {
                        if ui
                            .selectable_label(chosen.is_none(), t.units_auto())
                            .clicked()
                        {
                            action = SettingsAction::Units(None);
                        }
                        if ui
                            .selectable_label(chosen.as_deref() == Some("metric"), t.units_metric())
                            .clicked()
                        {
                            action = SettingsAction::Units(Some("metric"));
                        }
                        if ui
                            .selectable_label(
                                chosen.as_deref() == Some("imperial"),
                                t.units_imperial(),
                            )
                            .clicked()
                        {
                            action = SettingsAction::Units(Some("imperial"));
                        }
                    });
                ui.end_row();
            });
            let mut celebrations = store.local_setting(CELEBRATIONS).as_deref() != Some("off");
            if ui
                .checkbox(&mut celebrations, t.celebrations_toggle())
                .changed()
            {
                let _ =
                    store.set_local_setting(CELEBRATIONS, if celebrations { "on" } else { "off" });
            }
            ui.label(egui::RichText::new(t.celebrations_subtitle()).weak());
            // Every moment with a sound has its own combo: the pick is
            // heard as it is made, none is a choice, and so is a file.
            ui.add_space(8.0);
            ui.strong(t.sounds_section());
            egui::Grid::new("sounds").num_columns(2).show(ui, |ui| {
                for cheer in Cheer::ALL {
                    ui.label(cheer.label(t));
                    let current = sound_for(store, cheer);
                    egui::ComboBox::from_id_salt(("sound", cheer.key()))
                        .selected_text(current.label(t))
                        .show_ui(ui, |ui| {
                            if ui
                                .selectable_label(current == SoundChoice::None, t.alert_none())
                                .clicked()
                            {
                                action = SettingsAction::Sound(cheer, SoundChoice::None);
                            }
                            for preset in Preset::ALL {
                                let choice = SoundChoice::Preset(preset);
                                if ui
                                    .selectable_label(current == choice, preset.label(t))
                                    .clicked()
                                {
                                    action = SettingsAction::Sound(cheer, choice);
                                }
                            }
                            let own = matches!(current, SoundChoice::Own(_));
                            if ui.selectable_label(own, t.sound_own()).clicked() {
                                action = SettingsAction::PickSound(cheer);
                            }
                        });
                    ui.end_row();
                }
            });
            // A reminder arrives as a notification the system draws, so
            // the desk decides only whether it speaks with it.
            let mut cat = crate::sounds::reminder_cat_sound(store);
            if ui.checkbox(&mut cat, t.reminder_sound()).changed() {
                crate::sounds::set_reminder_cat_sound(store, cat);
            }
            ui.label(egui::RichText::new(t.reminder_sound_subtitle()).weak());
            ui.add_space(8.0);
            let mut candy = eye_candy;
            if ui.checkbox(&mut candy, t.eye_candy_toggle()).changed() {
                action = SettingsAction::EyeCandy(candy);
            }
            ui.horizontal(|ui| {
                if ui.button(t.show_tips_again()).clicked() {
                    action = SettingsAction::ResetTips;
                }
                if ui.button(t.achievements_title()).clicked() {
                    action = SettingsAction::OpenAchievements;
                }
                let backups = ui.button(t.backups_title());
                crate::tips::anchor(ui, "settings-backups", &backups);
                if backups.clicked() {
                    action = SettingsAction::OpenBackups;
                }
            });
            ui.add_space(12.0);
            ui.heading(t.catalog_settings());
            egui::Grid::new("catalog-settings")
                .num_columns(2)
                .show(ui, |ui| {
                    ui.label(t.name());
                    ui.horizontal(|ui| {
                        ui.label(&manager.active().name);
                        if ui.button(t.rename_catalog()).clicked() {
                            action = SettingsAction::RenameCatalog;
                        }
                    });
                    ui.end_row();
                    ui.label(t.catalog_holds());
                    let pets = store
                        .current(PET_MODE_ENTITY, PET_MODE_FIELD)
                        .ok()
                        .flatten()
                        .as_deref()
                        == Some("pets");
                    ui.horizontal(|ui| {
                        let mut choice = pets;
                        if ui.radio_value(&mut choice, false, t.mode_cats()).clicked()
                            || ui.radio_value(&mut choice, true, t.mode_pets()).clicked()
                        {
                            // Written below, where the store is mutable.
                            self.pending_mode = Some(choice);
                        }
                    });
                    ui.end_row();
                    ui.label(t.your_title());
                    let mine = store.person_title(&store.device_id()).ok().flatten();
                    let shown = mine
                        .as_deref()
                        .map(|v| title_words(t, v))
                        .unwrap_or_else(|| t.title_none().to_string());
                    egui::ComboBox::from_id_salt("settings-title")
                        .selected_text(shown)
                        .show_ui(ui, |ui| {
                            if ui
                                .selectable_label(mine.is_none(), t.title_none())
                                .clicked()
                            {
                                self.pending_title = Some(None);
                            }
                            for s in ladders
                                .iter()
                                .filter(|s| s.reached() && s.id.starts_with(MASTER_PREFIX))
                            {
                                let value = format!(
                                    "{}|{}",
                                    rank_for(s.tier).unwrap_or("servant"),
                                    s.title.clone().unwrap_or_default()
                                );
                                if ui
                                    .selectable_label(
                                        mine.as_deref() == Some(value.as_str()),
                                        ladder_name(t, s),
                                    )
                                    .clicked()
                                {
                                    self.pending_title = Some(Some(value));
                                }
                            }
                        });
                    ui.end_row();
                    ui.label(t.your_key());
                    ui.label(t.key_line(key_code));
                    ui.end_row();
                    let usage = store.storage_usage();
                    ui.label(t.storage_line(
                        &size_words(usage.db_bytes),
                        &size_words(usage.photo_bytes),
                        usage.photo_count as i64,
                    ));
                    ui.end_row();
                });
            if ui.button(t.delete_catalog()).clicked() {
                action = SettingsAction::DeleteCatalog;
            }
        });
        action
    }
}

/// Choices the page cannot write itself: the store is borrowed shared
/// while drawing.
#[derive(Debug, Default)]
pub struct Pending {
    pub mode: Option<bool>,
    pub title: Option<Option<String>>,
}

impl SettingsPage {
    pub fn take_pending(&mut self) -> Pending {
        Pending {
            mode: self.pending_mode.take(),
            title: self.pending_title.take(),
        }
    }
}

fn size_words(bytes: u64) -> String {
    if bytes >= 1_000_000 {
        format!("{:.1} MB", bytes as f64 / 1_000_000.0)
    } else {
        format!("{} kB", bytes / 1000)
    }
}

/// The Achievements page: what was reached, and the coats.
/// The achievements window: what was earned. A right-click or the ⋮
/// on one offers Delete, for a chore's typo or a ladder nobody wants;
/// it stays gone until the ladder climbs past that tier.
pub fn show_achievements(
    ui: &mut Ui,
    manager: &mut CatalogManager,
    t: &L10n,
    ladders: &[LadderState],
) {
    ui.heading(t.achievements_title());
    let recorded = manager.achievements().to_vec();
    let reached: Vec<&LadderState> = ladders
        .iter()
        .filter(|s| {
            s.reached()
                && recorded
                    .iter()
                    .find(|a| a.id == s.id)
                    .is_none_or(|a| a.shows(s.tier))
        })
        .collect();
    let months = ladders
        .iter()
        .find(|s| s.id == FULL_MONTH)
        .map(|s| s.times)
        .unwrap_or(0);
    let coats = unlocked_coats(months as usize);
    if reached.is_empty() && coats.is_empty() {
        ui.label(t.achievements_empty());
        return;
    }
    let mut dismiss: Option<String> = None;
    for s in reached {
        let first = recorded
            .iter()
            .find(|a| a.id == s.id)
            .and_then(|a| a.first.get(..10))
            .and_then(|d| d.parse::<chrono::NaiveDate>().ok())
            .map(|d| format_day(t.locale(), d))
            .unwrap_or_default();
        let mut menu = |ui: &mut Ui| {
            if ui.button(t.delete()).clicked() {
                dismiss = Some(s.id.clone());
                ui.close();
            }
        };
        ui.horizontal(|ui| {
            let name = ui.label(ladder_name(t, s));
            name.context_menu(&mut menu);
            crate::icons::more(ui, &mut menu);
        });
        let detail = if s.id.starts_with(MASTER_PREFIX) {
            t.achievement_done(s.times, &first)
        } else {
            t.achievement_reached(s.times, &first)
        };
        ui.label(egui::RichText::new(detail).weak());
    }
    if let Some(id) = dismiss {
        let _ = manager.dismiss_achievement(&id);
    }
    for coat in coats {
        ui.label(t.coat_unlocked(&coat_name(t, coat)));
        ui.label(egui::RichText::new(t.coat_unlocked_how()).weak());
    }
    let _ = keys::NAME;
}

impl SettingsPage {
    /// Applies the choices that need the store mutable.
    pub fn apply_pending(&mut self, store: &mut Catalog) -> catlog_core::Result<()> {
        let pending = self.take_pending();
        if let Some(pets) = pending.mode {
            store.append(
                PET_MODE_ENTITY,
                PET_MODE_FIELD,
                Some(if pets { "pets" } else { "cats" }),
            )?;
        }
        if let Some(title) = pending.title {
            store.set_own_title(title.as_deref())?;
        }
        Ok(())
    }
}
