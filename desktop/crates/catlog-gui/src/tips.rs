//! Tips shown once per page, the way the phone's spotlights are, and
//! the help text every page has.

use catlog_core::Catalog;

use crate::home::Selection;
use crate::l10n::L10n;
use crate::views::{Modal, View};

/// One tip: its id and its text.
pub struct Tip {
    pub id: &'static str,
    pub text: fn(&L10n) -> &'static str,
}

/// The screen the phone's tips are keyed by: a modal first, then what
/// lies on the desk, then the view.
fn screen_of(view: View, modal: Option<Modal>, selection: &Selection) -> &'static str {
    match (modal, view, selection) {
        (Some(Modal::Document), _, _) => "card",
        (Some(Modal::Backups), _, _) => "settings",
        (Some(_), _, _) | (None, View::Vet, _) => "",
        (None, View::Map, _) => "map",
        (None, View::Agenda, _) => "agenda",
        (None, View::Cats | View::Clowders, Selection::Cat(_)) => "cat",
        (None, View::Cats | View::Clowders, Selection::Strays) => "strays",
        (None, View::Home | View::Cats | View::Clowders, _) => "home",
    }
}

/// The tips per page, in the phone's order.
pub fn tips_for(
    view: View,
    modal: Option<Modal>,
    selection: &Selection,
) -> (&'static str, Vec<Tip>) {
    match screen_of(view, modal, selection) {
        "home" => (
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
        "agenda" => (
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
        "map" => (
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
        "cat" => (
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
        "card" => (
            "card",
            vec![Tip {
                id: "card-chips",
                text: |t| t.spot_card_chips(),
            }],
        ),
        "settings" => (
            "settings",
            vec![Tip {
                id: "settings-backups",
                text: |t| t.spot_backups(),
            }],
        ),
        "strays" => (
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
pub fn due_tip(
    store: &Catalog,
    view: View,
    modal: Option<Modal>,
    selection: &Selection,
) -> Option<(&'static str, Tip)> {
    let (screen, tips) = tips_for(view, modal, selection);
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
        let (view, modal, selection) = screen_for(screen);
        let (_, tips) = tips_for(view, modal, &selection);
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

fn screen_for(screen: &str) -> (View, Option<Modal>, Selection) {
    match screen {
        "agenda" => (View::Agenda, None, Selection::None),
        "map" => (View::Map, None, Selection::None),
        "cat" => (View::Cats, None, Selection::Cat(String::new())),
        "card" => (View::Home, Some(Modal::Document), Selection::None),
        "settings" => (View::Home, Some(Modal::Backups), Selection::None),
        "strays" => (View::Clowders, None, Selection::Strays),
        _ => (View::Home, None, Selection::None),
    }
}

/// The help text for what is shown: the modal, else the desk, else
/// the view.
pub fn help_for(t: &L10n, view: View, modal: Option<Modal>, selection: &Selection) -> &'static str {
    match modal {
        Some(Modal::Sync) => return t.help_remote(),
        Some(Modal::Conflicts) => return t.help_conflicts(),
        Some(Modal::Duplicates) => return t.help_duplicates(),
        Some(Modal::Moments) => return t.help_go_back(),
        Some(Modal::Archive) => return t.help_archive(),
        Some(Modal::Backups) => return t.help_backups(),
        Some(Modal::Restore) => return t.help_restore(),
        Some(Modal::Moderation) => return t.help_moderation(),
        Some(Modal::Document) => return t.help_card(),
        Some(Modal::Capture) => return t.help_flier(),
        Some(Modal::Settings) => return t.help_settings(),
        Some(Modal::Achievements) => return t.help_achievements(),
        Some(Modal::Help) | Some(Modal::About) | None => {}
    }
    match (view, selection) {
        (View::Map, _) => t.help_map(),
        (View::Agenda | View::Vet, _) => t.help_agenda(),
        (View::Cats | View::Clowders, Selection::Strays) => t.help_strays(),
        (View::Cats | View::Clowders, Selection::Clowder(_)) => t.help_clowder(),
        (View::Cats | View::Clowders, Selection::Cat(_)) => t.help_cat(),
        (View::Home, _) | (View::Cats | View::Clowders, Selection::None) => t.help_home(),
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
        let due = |store: &Catalog, s: &Selection| due_tip(store, View::Cats, None, s);
        let (screen, first) = due(&store, &cat).unwrap();
        assert_eq!((screen, first.id), ("cat", "cat-edit"));
        assert!(!(first.text)(&t).is_empty());
        mark_seen(&store, screen, first.id);
        let (_, second) = due(&store, &cat).unwrap();
        assert_eq!(second.id, "cat-menu");
        mark_all_seen(&store);
        assert!(due(&store, &cat).is_none());
        assert!(due(&store, &Selection::None).is_none());
        assert!(
            due_tip(&store, View::Home, Some(Modal::Sync), &Selection::None).is_none(),
            "no tips there"
        );
        reset(&store);
        assert_eq!(due(&store, &cat).unwrap().1.id, "cat-edit");
        assert_eq!(
            due_tip(&store, View::Map, None, &Selection::None)
                .unwrap()
                .1
                .id,
            "map-search"
        );
        for (view, modal) in [
            (View::Home, None),
            (View::Vet, None),
            (View::Home, Some(Modal::Sync)),
            (View::Home, Some(Modal::Capture)),
            (View::Home, Some(Modal::Achievements)),
        ] {
            assert!(!help_for(&t, view, modal, &Selection::None).is_empty());
        }
    }
}
