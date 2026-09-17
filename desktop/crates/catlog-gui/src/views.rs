//! The bar with the six views, and the modals everything else opens as.
//!
//! A view is where the keeper works: Home, Cats, Clowders, Map, Agenda
//! or Vet, one click away in the bar under the menu. Every former page
//! that is not a view opens as a modal over the desk and closes with
//! Escape, a click beside it or its close button.

use egui::{Context, Id, Key, Modifiers, Sense, Ui};

use crate::icons;
use crate::l10n::L10n;
use crate::theme::PALETTE;

/// The six views in the bar's order.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Default)]
pub enum View {
    #[default]
    Home,
    Cats,
    Clowders,
    Map,
    Agenda,
    Vet,
}

impl View {
    pub const ALL: [View; 6] = [
        View::Home,
        View::Cats,
        View::Clowders,
        View::Map,
        View::Agenda,
        View::Vet,
    ];

    pub fn label(self, t: &L10n) -> &'static str {
        match self {
            View::Home => t.view_home(),
            View::Cats => t.cats(),
            View::Clowders => t.clowders(),
            View::Map => t.map(),
            View::Agenda => t.agenda(),
            View::Vet => t.view_vet(),
        }
    }

    pub fn icon(self) -> &'static str {
        match self {
            View::Home => icons::HOME_OUTLINED,
            View::Cats => icons::PETS_OUTLINED,
            View::Clowders => icons::NIGHT_SHELTER_OUTLINED,
            View::Map => icons::MAP_OUTLINED,
            View::Agenda => icons::CALENDAR_MONTH_OUTLINED,
            View::Vet => icons::MEDICAL_SERVICES_OUTLINED,
        }
    }

    /// The key that reaches the view with Ctrl: 1 to 6.
    fn key(self) -> Key {
        match self {
            View::Home => Key::Num1,
            View::Cats => Key::Num2,
            View::Clowders => Key::Num3,
            View::Map => Key::Num4,
            View::Agenda => Key::Num5,
            View::Vet => Key::Num6,
        }
    }
}

/// What is open over the desk.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Modal {
    /// A Cat's whole page, from its card.
    Page(String),
    Sync,
    Conflicts,
    Duplicates,
    Moments,
    Archive,
    Backups,
    Restore,
    Moderation,
    Settings,
    Achievements,
    Capture,
    Document,
    Help,
    About,
}

/// Draws the bar; the view chosen this frame, by a click or Ctrl+1..6.
pub fn show_bar(ui: &mut Ui, t: &L10n, active: View) -> Option<View> {
    let mut chosen = None;
    for view in View::ALL {
        if ui.input_mut(|i| i.consume_key(Modifiers::COMMAND, view.key())) {
            chosen = Some(view);
        }
    }
    ui.horizontal(|ui| {
        ui.spacing_mut().item_spacing.x = 4.0;
        // The active view is a solid orange pill with paper text.
        let visuals = ui.visuals_mut();
        visuals.selection.bg_fill = PALETTE.orange;
        visuals.selection.stroke.color = PALETTE.paper;
        for view in View::ALL {
            let selected = view == active;
            if icons::selectable(ui, selected, view.icon(), view.label(t)).clicked() {
                chosen = Some(view);
            }
        }
    });
    chosen
}

/// Shows `content` as a modal over the desk: sized to it, scrolling
/// when long, with a close button in its corner. The second value is
/// true when it wants to close: Escape, a click beside it or the button.
pub fn show_modal<R>(
    ctx: &Context,
    id: &str,
    close_label: &str,
    content: impl FnOnce(&mut Ui) -> R,
) -> (R, bool) {
    let screen = ctx.content_rect();
    // The modal fades in: its backdrop, its frame and what it holds.
    let fade = crate::motion::fade_in(ctx, ("modal", id));
    let style = ctx.global_style();
    let popup = egui::Frame::popup(&style);
    let frame = egui::Frame {
        fill: popup.fill.gamma_multiply(fade),
        stroke: egui::Stroke::new(popup.stroke.width, popup.stroke.color.gamma_multiply(fade)),
        shadow: egui::epaint::Shadow {
            color: popup.shadow.color.gamma_multiply(fade),
            ..popup.shadow
        },
        ..popup
    };
    let modal = egui::Modal::new(Id::new(("modal", id)))
        .frame(frame)
        .backdrop_color(egui::Color32::from_black_alpha((100.0 * fade) as u8))
        .show(ctx, |ui| {
            ui.set_opacity(fade);
            // An area's ui is as big as it was last frame; the bounds are
            // set anew so the scroll area can grow with its content.
            ui.set_max_width((screen.width() - 80.0).min(960.0));
            let max_height = screen.height() - 80.0;
            ui.set_max_height(max_height);
            let inner = egui::ScrollArea::vertical()
                .max_height(max_height)
                .show(ui, content)
                .inner;
            // An area asks for no repaint when its content shrinks; one more
            // frame lets it settle, so what is on screen is where it says.
            let size = ui.min_rect().size();
            let key = Id::new(("modal-size", id));
            if ctx.data(|d| d.get_temp::<egui::Vec2>(key)) != Some(size) {
                ctx.data_mut(|d| d.insert_temp(key, size));
                ctx.request_repaint();
            }
            // The close button sits in the frame's corner, past the content.
            ui.set_min_width(ui.min_rect().width() + 28.0);
            let corner = ui.min_rect().right_top();
            let rect =
                egui::Rect::from_min_size(corner + egui::vec2(-20.0, 0.0), egui::Vec2::splat(20.0));
            let response = ui
                .interact(rect, ui.id().with("close"), Sense::click())
                .on_hover_text(close_label);
            response.widget_info(|| {
                egui::WidgetInfo::labeled(egui::WidgetType::Button, true, close_label)
            });
            let color = if response.hovered() {
                PALETTE.orange
            } else {
                PALETTE.grey
            };
            icons::paint(ui, rect, icons::CLOSE, color);
            (inner, response.clicked())
        });
    let wants_close = modal.should_close();
    let (inner, closed) = modal.inner;
    (inner, closed || wants_close)
}
