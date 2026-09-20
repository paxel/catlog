//! Tips shown once per page, the way the phone's spotlights are, and
//! the help text every page has.

use catlog_core::Catalog;
use egui::{Align2, Color32, Context, Id, Order, Pos2, Rect, Response, Stroke, Ui};

use crate::home::Selection;
use crate::l10n::L10n;
use crate::views::{Modal, View};

/// Where a tip points. A widget a tip is about registers its rectangle
/// as it draws; the spotlight dims everything else, rings it and puts
/// the words beside it. A tip whose widget is not on screen falls back
/// to the line under the menu.
pub fn anchor(ui: &Ui, id: &str, response: &Response) {
    let pass = ui.ctx().cumulative_pass_nr();
    ui.ctx()
        .data_mut(|d| d.insert_temp(anchor_key(id), (response.rect, pass)));
}

fn anchor_key(id: &str) -> Id {
    Id::new(("tip-anchor", id))
}

/// The rectangle a tip points at, when its widget drew this pass or the
/// one before.
pub fn anchor_rect(ctx: &Context, id: &str) -> Option<Rect> {
    let (rect, pass) = ctx.data(|d| d.get_temp::<(Rect, u64)>(anchor_key(id)))?;
    (ctx.cumulative_pass_nr().saturating_sub(pass) <= 1).then_some(rect)
}

/// What the keeper did with a tip's bubble this frame.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Answer {
    /// Nothing yet.
    None,
    /// Next, or Got it on the last: this tip is seen.
    Next,
    /// Skip: this page's remaining tips are seen too.
    Skip,
}

/// The one look every tip has, as on the phone: a bubble with the words,
/// Skip, and Next or Got it on the page's last tip. With a `target` the
/// screen is dimmed but for it, an orange ring around it breathes when
/// motion is on, and the bubble hangs beside it; without one the bubble
/// sits under the bar. It never starts above `keep_clear`, the bottom of
/// the menu and the bar, so those stay clickable. Drawn above modals, so
/// a tip about a modal's widget reaches it.
pub fn spotlight(
    ctx: &Context,
    target: Option<Rect>,
    keep_clear: f32,
    text: &str,
    last: bool,
    t: &L10n,
) -> Answer {
    let screen = ctx.content_rect();
    let hole = target.map(|r| r.expand(6.0));
    let pulse = if crate::motion::duration(ctx) > 0.0 {
        ctx.request_repaint();
        ((ctx.input(|i| i.time) * 3.0).sin() as f32) * 0.5 + 0.5
    } else {
        1.0
    };
    let (pos, pivot) = match hole {
        Some(hole) => {
            // The bubble below the widget when there is room, else above it.
            let below = hole.max.y + 140.0 < screen.max.y;
            let x = hole.min.x.clamp(
                screen.min.x + 8.0,
                (screen.max.x - 400.0).max(screen.min.x + 8.0),
            );
            if below {
                (
                    Pos2::new(x, (hole.max.y + 12.0).max(keep_clear + 8.0)),
                    Align2::LEFT_TOP,
                )
            } else {
                (Pos2::new(x, hole.min.y - 12.0), Align2::LEFT_BOTTOM)
            }
        }
        None => (
            Pos2::new(screen.min.x + 8.0, keep_clear + 8.0),
            Align2::LEFT_TOP,
        ),
    };
    let mut answer = Answer::None;
    egui::Area::new(Id::new("tip-bubble"))
        .order(Order::Tooltip)
        .fixed_pos(pos)
        .pivot(pivot)
        .show(ctx, |ui| {
            if let Some(hole) = hole {
                // The veil and the ring go on the bubble's own layer, before
                // its frame: over every modal, under the words.
                let painter = ui.painter().with_clip_rect(screen);
                let dim = Color32::from_black_alpha(70);
                for part in [
                    Rect::from_min_max(screen.min, Pos2::new(screen.max.x, hole.min.y)),
                    Rect::from_min_max(Pos2::new(screen.min.x, hole.max.y), screen.max),
                    Rect::from_min_max(
                        Pos2::new(screen.min.x, hole.min.y),
                        Pos2::new(hole.min.x, hole.max.y),
                    ),
                    Rect::from_min_max(
                        Pos2::new(hole.max.x, hole.min.y),
                        Pos2::new(screen.max.x, hole.max.y),
                    ),
                ] {
                    painter.rect_filled(part, 0.0, dim);
                }
                painter.rect_stroke(
                    hole.expand(pulse * 2.0),
                    10.0,
                    Stroke::new(3.0, crate::theme::PALETTE.orange),
                    egui::StrokeKind::Outside,
                );
            }
            egui::Frame::popup(ui.style())
                .fill(crate::theme::PALETTE.paper)
                .stroke(Stroke::new(1.5, crate::theme::PALETTE.orange))
                .show(ui, |ui| {
                    ui.set_max_width(380.0);
                    crate::icons::label(ui, crate::icons::LIGHTBULB_OUTLINE, text);
                    ui.horizontal(|ui| {
                        if ui.button(t.intro_skip()).clicked() {
                            answer = Answer::Skip;
                        }
                        let go = if last { t.spot_done() } else { t.intro_next() };
                        if crate::icons::button(ui, crate::icons::CHECK, go).clicked() {
                            answer = Answer::Next;
                        }
                    });
                });
        });
    answer
}

/// One tip: its id and its text.
pub struct Tip {
    pub id: &'static str,
    pub text: fn(&L10n) -> &'static str,
}

/// The screen the phone's tips are keyed by: a modal first, then what
/// lies on the desk, then the view.
fn screen_of(
    view: View,
    modal: Option<Modal>,
    selection: &Selection,
    strays: bool,
) -> &'static str {
    if modal.is_none() && view == View::Cats && strays {
        return "strays";
    }
    match (modal, view, selection) {
        (Some(Modal::Document), _, _) => "card",
        (Some(Modal::Page(_)), _, _) => "cat",
        (Some(Modal::Backups), _, _) => "settings",
        (Some(_), _, _) | (None, View::Vet, _) => "",
        (None, View::Map, _) => "map",
        (None, View::Agenda, _) => "agenda",
        (None, View::Cats | View::Clowders, Selection::Cat(_)) => "cat",
        (None, View::Home | View::Cats | View::Clowders, _) => "home",
    }
}

/// The tips per page, in the phone's order.
pub fn tips_for(
    view: View,
    modal: Option<Modal>,
    selection: &Selection,
    strays: bool,
) -> (&'static str, Vec<Tip>) {
    match screen_of(view, modal, selection, strays) {
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

/// The next tip the keeper has not seen on this page, and whether it is
/// the page's last.
pub fn due_tip(
    store: &Catalog,
    view: View,
    modal: Option<Modal>,
    selection: &Selection,
    strays: bool,
) -> Option<(&'static str, Tip, bool)> {
    let (screen, tips) = tips_for(view, modal, selection, strays);
    if screen.is_empty() {
        return None;
    }
    let seen = store.local_setting(&key(screen)).unwrap_or_default();
    let seen: Vec<&str> = seen.split(',').collect();
    let mut unseen = tips.into_iter().filter(|t| !seen.contains(&t.id));
    let first = unseen.next()?;
    let last = unseen.next().is_none();
    Some((screen, first, last))
}

/// Marks every tip of one page seen: Skip.
pub fn mark_page_seen(store: &Catalog, screen: &str) {
    let (view, modal, selection, strays) = screen_for(screen);
    let (_, tips) = tips_for(view, modal, &selection, strays);
    let ids: Vec<&str> = tips.iter().map(|t| t.id).collect();
    let _ = store.set_local_setting(&key(screen), &ids.join(","));
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
        mark_page_seen(store, screen);
    }
}

/// Forgets what was seen: the tips show again.
pub fn reset(store: &Catalog) {
    for screen in ["home", "agenda", "map", "cat", "card", "settings", "strays"] {
        let _ = store.remove_local_setting(&key(screen));
    }
}

fn screen_for(screen: &str) -> (View, Option<Modal>, Selection, bool) {
    match screen {
        "agenda" => (View::Agenda, None, Selection::None, false),
        "map" => (View::Map, None, Selection::None, false),
        "cat" => (View::Cats, None, Selection::Cat(String::new()), false),
        "card" => (View::Home, Some(Modal::Document), Selection::None, false),
        "settings" => (View::Home, Some(Modal::Backups), Selection::None, false),
        "strays" => (View::Cats, None, Selection::None, true),
        _ => (View::Home, None, Selection::None, false),
    }
}

/// The help text for what is shown: the modal, else the desk, else
/// the view.
pub fn help_for(
    t: &L10n,
    view: View,
    modal: Option<Modal>,
    selection: &Selection,
    strays: bool,
) -> &'static str {
    if modal.is_none() && view == View::Cats && strays {
        return t.help_strays();
    }
    match modal {
        Some(Modal::Sync) => return t.help_remote(),
        Some(Modal::InPerson) => return t.help_in_person(),
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
        Some(Modal::Page(_)) => return t.help_cat(),
        Some(Modal::Help) | Some(Modal::About) | None => {}
    }
    match (view, selection) {
        (View::Map, _) => t.help_map(),
        (View::Agenda | View::Vet, _) => t.help_agenda(),
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
        let due = |store: &Catalog, s: &Selection| due_tip(store, View::Cats, None, s, false);
        let (screen, first, last) = due(&store, &cat).unwrap();
        assert_eq!((screen, first.id, last), ("cat", "cat-edit", false));
        assert!(!(first.text)(&t).is_empty());
        mark_seen(&store, screen, first.id);
        let (_, second, _) = due(&store, &cat).unwrap();
        assert_eq!(second.id, "cat-menu");
        // Skip on a page marks the rest of that page seen, no other.
        mark_page_seen(&store, "cat");
        assert!(due(&store, &cat).is_none());
        let (_, map_first, map_last) =
            due_tip(&store, View::Map, None, &Selection::None, false).unwrap();
        assert_eq!((map_first.id, map_last), ("map-search", false));
        mark_seen(&store, "map", "map-search");
        let (_, map_second, map_last) =
            due_tip(&store, View::Map, None, &Selection::None, false).unwrap();
        assert_eq!((map_second.id, map_last), ("map-layers", true));
        mark_all_seen(&store);
        assert!(due(&store, &cat).is_none());
        assert!(due(&store, &Selection::None).is_none());
        assert!(
            due_tip(
                &store,
                View::Home,
                Some(Modal::Sync),
                &Selection::None,
                false
            )
            .is_none(),
            "no tips there"
        );
        reset(&store);
        assert_eq!(due(&store, &cat).unwrap().1.id, "cat-edit");
        assert!(!due(&store, &cat).unwrap().2);
        assert_eq!(
            due_tip(&store, View::Map, None, &Selection::None, false)
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
            assert!(!help_for(&t, view, modal, &Selection::None, false).is_empty());
        }
    }
}
