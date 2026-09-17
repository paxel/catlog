//! Tips shown once per page, the way the phone's spotlights are, and
//! the help text every page has.

use catlog_core::Catalog;

use crate::home::Selection;
use crate::l10n::L10n;

/// One tip: its id and its text.
pub struct Tip {
    pub id: &'static str,
    pub text: fn(&L10n) -> &'static str,
}

/// The tips per page, in the phone's order.
pub fn tips_for(selection: &Selection) -> (&'static str, Vec<Tip>) {
    match selection {
        Selection::None | Selection::Clowder(_) => (
            "home",
            vec![
                Tip {
                    id: "home-catalog",
                    text: |t| t.spot_home_catalog(),
                },
                Tip {
                    id: "home-strays",
                    text: |t| t.spot_home_strays(),
                },
                Tip {
                    id: "home-sync",
                    text: |t| t.spot_home_sync(),
                },
                Tip {
                    id: "home-menu",
                    text: |t| t.spot_home_menu(),
                },
                Tip {
                    id: "home-agenda",
                    text: |t| t.spot_home_agenda(),
                },
            ],
        ),
        Selection::Agenda => (
            "agenda",
            vec![
                Tip {
                    id: "agenda-add",
                    text: |t| t.spot_agenda_add(),
                },
                Tip {
                    id: "agenda-today",
                    text: |t| t.spot_agenda_today(),
                },
            ],
        ),
        Selection::Map => (
            "map",
            vec![
                Tip {
                    id: "map-search",
                    text: |t| t.spot_map_search(),
                },
                Tip {
                    id: "map-layers",
                    text: |t| t.spot_map_layers(),
                },
            ],
        ),
        Selection::Cat(_) => (
            "cat",
            vec![
                Tip {
                    id: "cat-edit",
                    text: |t| t.spot_cat_edit(),
                },
                Tip {
                    id: "cat-menu",
                    text: |t| t.spot_cat_menu(),
                },
                Tip {
                    id: "cat-reminder",
                    text: |t| t.spot_add_reminder_cat(),
                },
                Tip {
                    id: "cat-chores",
                    text: |t| t.spot_cat_chores(),
                },
                Tip {
                    id: "cat-report",
                    text: |t| t.spot_timeline_report(),
                },
                Tip {
                    id: "cat-poster",
                    text: |t| t.spot_card_poster(),
                },
            ],
        ),
        Selection::Document => (
            "card",
            vec![Tip {
                id: "card-chips",
                text: |t| t.spot_card_chips(),
            }],
        ),
        Selection::Backups => (
            "settings",
            vec![Tip {
                id: "settings-backups",
                text: |t| t.spot_backups(),
            }],
        ),
        Selection::Strays => (
            "strays",
            vec![Tip {
                id: "strays-flier",
                text: |t| t.spot_strays_flier(),
            }],
        ),
        _ => ("", Vec::new()),
    }
}

/// The setting a page's seen tips live under.
fn key(screen: &str) -> String {
    format!("spot:{screen}")
}

/// The next tip the keeper has not seen on this page.
pub fn due_tip(store: &Catalog, selection: &Selection) -> Option<(&'static str, Tip)> {
    let (screen, tips) = tips_for(selection);
    if screen.is_empty() {
        return None;
    }
    let seen = store.local_setting(&key(screen)).unwrap_or_default();
    let seen: Vec<&str> = seen.split(',').collect();
    tips.into_iter()
        .find(|t| !seen.contains(&t.id))
        .map(|t| (screen, t))
}

/// Marks one tip seen.
pub fn mark_seen(store: &Catalog, screen: &str, id: &str) {
    let mut seen: Vec<String> = store
        .local_setting(&key(screen))
        .unwrap_or_default()
        .split(',')
        .filter(|s| !s.is_empty())
        .map(String::from)
        .collect();
    if !seen.iter().any(|s| s == id) {
        seen.push(id.to_string());
    }
    let _ = store.set_local_setting(&key(screen), &seen.join(","));
}

/// Marks every tip seen, for a keeper who knows their way around.
pub fn mark_all_seen(store: &Catalog) {
    for screen in ["home", "agenda", "map", "cat", "card", "settings", "strays"] {
        let (_, tips) = tips_for(&selection_for(screen));
        let ids: Vec<&str> = tips.iter().map(|t| t.id).collect();
        let _ = store.set_local_setting(&key(screen), &ids.join(","));
    }
}

/// Forgets what was seen: the tips show again.
pub fn reset(store: &Catalog) {
    for screen in ["home", "agenda", "map", "cat", "card", "settings", "strays"] {
        let _ = store.remove_local_setting(&key(screen));
    }
}

fn selection_for(screen: &str) -> Selection {
    match screen {
        "agenda" => Selection::Agenda,
        "map" => Selection::Map,
        "cat" => Selection::Cat(String::new()),
        "card" => Selection::Document,
        "settings" => Selection::Backups,
        "strays" => Selection::Strays,
        _ => Selection::None,
    }
}

/// The help text for a page.
pub fn help_for(t: &L10n, selection: &Selection) -> &'static str {
    match selection {
        Selection::None => t.help_home(),
        Selection::Strays => t.help_strays(),
        Selection::Clowder(_) => t.help_clowder(),
        Selection::Cat(_) => t.help_cat(),
        Selection::Map => t.help_map(),
        Selection::Sync => t.help_remote(),
        Selection::Conflicts => t.help_conflicts(),
        Selection::Agenda => t.help_agenda(),
        Selection::Duplicates => t.help_duplicates(),
        Selection::Moments => t.help_go_back(),
        Selection::Archive => t.help_archive(),
        Selection::Backups => t.help_backups(),
        Selection::Restore => t.help_restore(),
        Selection::Moderation => t.help_moderation(),
        Selection::Document => t.help_card(),
        Selection::Capture => t.help_flier(),
        Selection::Settings => t.help_settings(),
        Selection::Achievements => t.help_achievements(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn tips_show_once_per_page_and_come_back_after_a_reset() {
        let dir = tempfile::tempdir().unwrap();
        let store = Catalog::open(dir.path()).unwrap();
        let t = L10n::new("en");
        let cat = Selection::Cat("cat:a".into());
        let (screen, first) = due_tip(&store, &cat).unwrap();
        assert_eq!((screen, first.id), ("cat", "cat-edit"));
        assert!(!(first.text)(&t).is_empty());
        mark_seen(&store, screen, first.id);
        let (_, second) = due_tip(&store, &cat).unwrap();
        assert_eq!(second.id, "cat-menu");
        mark_all_seen(&store);
        assert!(due_tip(&store, &cat).is_none());
        assert!(due_tip(&store, &Selection::None).is_none());
        assert!(due_tip(&store, &Selection::Sync).is_none(), "no tips there");
        reset(&store);
        assert_eq!(due_tip(&store, &cat).unwrap().1.id, "cat-edit");
        assert_eq!(due_tip(&store, &Selection::Map).unwrap().1.id, "map-search");
        for s in [
            Selection::None,
            Selection::Sync,
            Selection::Capture,
            Selection::Achievements,
        ] {
            assert!(!help_for(&t, &s).is_empty());
        }
    }
}
