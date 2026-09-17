//! The pages that keep a Catalog in order: its Moments and the way back,
//! archiving, backups and their restore, and the authors with their
//! bans.

use std::collections::BTreeSet;
use std::path::{Path, PathBuf};

use catlog_core::backup::BackupSet;
use catlog_core::moments::{Moment, cause};
use catlog_core::signing::KeyTrust;
use catlog_core::{Catalog, keys};
use chrono::NaiveDate;
use egui::Ui;

use crate::l10n::L10n;
use crate::labels::format_day;

/// What the keeper asked for on one of these pages this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum HouseAction {
    None,
    NameMoment,
    GoBack(Moment),
    Archive(Vec<String>),
    BackupNow,
    PickBackupFolder,
    RemoveBackupFolder,
    Restore(Vec<usize>),
    PickRestoreFiles,
    /// Delete everything by this author under this device.
    HardDelete(String, String),
    /// Remove a ban: kind and value.
    Unban(String, String),
    RemoveTrust(String),
}

/// The pages' own state.
#[derive(Debug, Default)]
pub struct Housekeeping {
    pub show_all_moments: bool,
    pub archive_chosen: BTreeSet<String>,
    /// Backup files picked by hand, listed beside the folder's.
    pub restore_files: Vec<PathBuf>,
    pub restore_chosen: BTreeSet<usize>,
    /// Also ban the author whose data is deleted.
    pub also_ban: bool,
}

const RECENT_MOMENTS: usize = 10;

/// "Before syncing · 2026-03-10 14:02", or the name given by hand.
pub fn moment_title(t: &L10n, m: &Moment) -> String {
    match m.cause.as_str() {
        cause::IMPORT => t.moment_import().to_string(),
        cause::SYNC => t.moment_sync().to_string(),
        cause::MERGE => t.moment_merge().to_string(),
        cause::HARD_DELETE => t.moment_hard_delete().to_string(),
        cause::ARCHIVE => t.moment_archive().to_string(),
        _ => m
            .label
            .clone()
            .filter(|l| !l.is_empty())
            .unwrap_or_else(|| t.moment_manual().to_string()),
    }
}

pub fn moment_detail(t: &L10n, m: &Moment) -> String {
    let when =
        m.at.get(..10)
            .and_then(|d| d.parse::<NaiveDate>().ok())
            .map(|d| {
                format!(
                    "{} {}",
                    format_day(t.locale(), d),
                    m.at.get(11..16).unwrap_or("")
                )
            })
            .unwrap_or_else(|| m.at.clone());
    let label = if m.cause == cause::MANUAL {
        None
    } else {
        m.label.clone()
    };
    match label.filter(|l| !l.is_empty()) {
        Some(label) => format!("{label} · {when}"),
        None => when,
    }
}

pub fn show_moments(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    state: &mut Housekeeping,
) -> HouseAction {
    let mut action = HouseAction::None;
    egui::ScrollArea::vertical().show(ui, |ui| {
        ui.horizontal(|ui| {
            ui.heading(t.go_back_title());
            if ui.button(t.name_this_moment()).clicked() {
                action = HouseAction::NameMoment;
            }
        });
        let all = store.moments().unwrap_or_default();
        let shown = if state.show_all_moments {
            all.len()
        } else {
            all.len().min(RECENT_MOMENTS)
        };
        for m in &all[..shown] {
            ui.horizontal(|ui| {
                ui.label(format!("{} · {}", moment_title(t, m), moment_detail(t, m)));
                if ui.button(t.go_back_to_here()).clicked() {
                    action = HouseAction::GoBack(m.clone());
                }
            });
        }
        if shown < all.len() && ui.button(t.show_older_moments()).clicked() {
            state.show_all_moments = true;
        }
    });
    action
}

fn size_words(bytes: u64) -> String {
    if bytes >= 1_000_000 {
        format!("{:.1} MB", bytes as f64 / 1_000_000.0)
    } else {
        format!("{} kB", bytes / 1000)
    }
}

pub fn show_archive(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    state: &mut Housekeeping,
    today: NaiveDate,
) -> HouseAction {
    let mut action = HouseAction::None;
    egui::ScrollArea::vertical().show(ui, |ui| {
        ui.heading(t.archive_title());
        ui.label(t.archive_explainer());
        let candidates = store.archive_candidates(today, 365 * 2).unwrap_or_default();
        if candidates.is_empty() {
            ui.label(t.nothing_to_archive());
            return;
        }
        for c in &candidates {
            let mut on = state.archive_chosen.contains(&c.id);
            if ui.checkbox(&mut on, &c.name).changed() {
                if on {
                    state.archive_chosen.insert(c.id.clone());
                } else {
                    state.archive_chosen.remove(&c.id);
                }
            }
            ui.label(
                egui::RichText::new(t.archive_candidate_line(
                    &format_day(t.locale(), c.last_change),
                    &size_words(c.photo_bytes),
                ))
                .weak(),
            );
        }
        let chosen: Vec<String> = candidates
            .iter()
            .filter(|c| state.archive_chosen.contains(&c.id))
            .map(|c| c.id.clone())
            .collect();
        if ui
            .add_enabled(
                !chosen.is_empty(),
                egui::Button::new(t.archive_selected(chosen.len() as i64)),
            )
            .clicked()
        {
            action = HouseAction::Archive(chosen);
        }
    });
    action
}

pub fn show_backups(ui: &mut Ui, store: &Catalog, t: &L10n, dir: &Path) -> HouseAction {
    let mut action = HouseAction::None;
    ui.heading(t.backups_title());
    ui.label(t.backups_desktop_files());
    ui.label(egui::RichText::new(dir.to_string_lossy().into_owned()).weak());
    let (at, error) = store.last_backup();
    match at
        .as_deref()
        .and_then(|a| a.get(..10))
        .and_then(|d| d.parse::<NaiveDate>().ok())
    {
        Some(day) => ui.label(t.backups_last(&format_day(t.locale(), day))),
        None => ui.label(t.backups_never()),
    };
    if let Some(e) = error {
        ui.colored_label(ui.visuals().error_fg_color, t.last_backup_failed(&e));
    }
    if ui.button(t.backups_now()).clicked() {
        action = HouseAction::BackupNow;
    }
    ui.add_space(8.0);
    ui.label(egui::RichText::new(t.backups_folder_hint()).weak());
    match store
        .local_setting(catlog_core::backup::BACKUP_FOLDER_KEY)
        .filter(|f| !f.is_empty())
    {
        Some(folder) => {
            ui.label(t.backups_folder_is(&folder));
            if ui.button(t.backups_folder_remove()).clicked() {
                action = HouseAction::RemoveBackupFolder;
            }
        }
        None => {
            if ui.button(t.backups_folder_pick()).clicked() {
                action = HouseAction::PickBackupFolder;
            }
        }
    }
    action
}

pub fn show_restore(
    ui: &mut Ui,
    t: &L10n,
    sets: &[BackupSet],
    state: &mut Housekeeping,
) -> HouseAction {
    let mut action = HouseAction::None;
    ui.heading(t.restore_title());
    ui.label(if sets.is_empty() {
        t.restore_none()
    } else {
        t.restore_intro()
    });
    for (i, set) in sets.iter().enumerate() {
        let mut on = state.restore_chosen.contains(&i);
        if ui.checkbox(&mut on, &set.name).changed() {
            if on {
                state.restore_chosen.insert(i);
            } else {
                state.restore_chosen.remove(&i);
            }
        }
        let newest = chrono::DateTime::from_timestamp(set.newest, 0)
            .map(|d| format_day(t.locale(), d.date_naive()))
            .unwrap_or_default();
        ui.label(egui::RichText::new(t.restore_file_line(set.files.len() as i64, &newest)).weak());
    }
    ui.horizontal(|ui| {
        let chosen: Vec<usize> = state
            .restore_chosen
            .iter()
            .copied()
            .filter(|i| *i < sets.len())
            .collect();
        if ui
            .add_enabled(!chosen.is_empty(), egui::Button::new(t.restore_action()))
            .clicked()
        {
            action = HouseAction::Restore(chosen);
        }
        if ui.button(t.restore_pick_files()).clicked() {
            action = HouseAction::PickRestoreFiles;
        }
    });
    action
}

/// "key 1a2b-3c4d" plus how the key is known.
fn key_words(store: &Catalog, t: &L10n, device: &str) -> String {
    if device == store.device_id() {
        return t.your_key().to_string();
    }
    match store.pinned_key(device) {
        Some(k) => {
            let how = match k.trust {
                KeyTrust::Verified => t.key_verified(),
                KeyTrust::Tofu => t.key_from_file(),
            };
            format!("{} · {how}", t.key_line(&k.record.code()))
        }
        None => t.key_unsigned().to_string(),
    }
}

pub fn key_code(store: &Catalog, device: &str) -> String {
    store
        .pinned_key(device)
        .map(|k| k.record.code())
        .unwrap_or_else(|| device.chars().take(8).collect())
}

pub fn show_moderation(
    ui: &mut Ui,
    store: &Catalog,
    t: &L10n,
    state: &mut Housekeeping,
) -> HouseAction {
    let mut action = HouseAction::None;
    egui::ScrollArea::vertical().show(ui, |ui| {
        ui.heading(t.moderation_title());
        ui.label(t.moderation_subtitle());
        ui.add_space(6.0);
        ui.strong(t.authors_section());
        let me = store.device_id();
        for (author, device, count) in store.authors_overview().unwrap_or_default() {
            ui.horizontal(|ui| {
                ui.label(format!(
                    "{author} · {} · {}",
                    key_words(store, t, &device),
                    t.changes_count(count)
                ));
                if device != me && ui.button(t.hard_delete_action()).clicked() {
                    action = HouseAction::HardDelete(author.clone(), device.clone());
                }
            });
        }
        ui.checkbox(&mut state.also_ban, t.also_ban());
        let trusted = store.local_settings_by_prefix("trust:").unwrap_or_default();
        if !trusted.is_empty() {
            ui.add_space(6.0);
            ui.strong(t.trusted_devices_section());
            for (device, value) in trusted {
                ui.horizontal(|ui| {
                    let parts: Vec<&str> = value.split('|').collect();
                    let label = if parts.len() > 2 {
                        format!("{} · {}", parts[1], parts[2])
                    } else {
                        device.clone()
                    };
                    ui.label(label);
                    if ui.button(t.remove_trust()).clicked() {
                        action = HouseAction::RemoveTrust(device.clone());
                    }
                });
            }
        }
        let bans = store.bans().unwrap_or_default();
        if !bans.is_empty() {
            ui.add_space(6.0);
            ui.strong(t.bans_section());
            for (kind, value) in bans {
                ui.horizontal(|ui| {
                    let shown = match kind.as_str() {
                        "device" => store
                            .local_setting(&format!("bannedAs:{value}"))
                            .map(|a| format!("{a} · {}", t.key_line(&key_code(store, &value))))
                            .unwrap_or_else(|| t.key_line(&key_code(store, &value))),
                        "blob" => value.chars().take(8).collect(),
                        _ => value.clone(),
                    };
                    ui.label(shown);
                    if ui.button(t.unban_action()).clicked() {
                        action = HouseAction::Unban(kind.clone(), value.clone());
                    }
                });
            }
        }
    });
    let _ = keys::NAME;
    action
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn moments_read_by_cause_and_sizes_by_magnitude() {
        let t = L10n::new("en");
        let m = Moment {
            id: 1,
            seq: 3,
            cause: cause::SYNC.into(),
            label: Some("Bob".into()),
            at: "2026-03-10T14:02:00.000000Z".into(),
        };
        assert_eq!(moment_title(&t, &m), "Before syncing");
        assert_eq!(moment_detail(&t, &m), "Bob · 3/10/2026 14:02");
        let named = Moment {
            cause: cause::MANUAL.into(),
            label: Some("Before the fair".into()),
            ..m.clone()
        };
        assert_eq!(moment_title(&t, &named), "Before the fair");
        assert_eq!(moment_detail(&t, &named), "3/10/2026 14:02");
        let unnamed = Moment {
            label: None,
            ..named
        };
        assert_eq!(moment_title(&t, &unnamed), "Marked by you");
        let odd = Moment {
            at: "sometime".into(),
            ..m
        };
        assert_eq!(moment_detail(&t, &odd), "Bob · sometime");
        assert_eq!(size_words(1234), "1 kB");
        assert_eq!(size_words(2_500_000), "2.5 MB");
    }
}
