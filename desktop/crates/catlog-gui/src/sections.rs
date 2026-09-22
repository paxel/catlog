//! The static card every section of Home and the Agenda sits in, and the
//! two-line row a chore, an appointment or a reminder is drawn as. The
//! movable desk cards (`cards.rs`) wear a thicker frame and a shadow;
//! these lie flat on the page.

use egui::{Response, RichText, TextureHandle, Ui, Vec2};

use crate::theme::{PALETTE, ROUNDING};

/// A rounded paper card, its heading top left with a hairline under it,
/// the body below. It takes the width it is given.
pub fn section_card<R>(ui: &mut Ui, title: &str, body: impl FnOnce(&mut Ui) -> R) -> R {
    section_card_tipped(ui, title, None, body)
}

/// [`section_card`] whose heading anchors a tip.
pub fn section_card_tipped<R>(
    ui: &mut Ui,
    title: &str,
    tip: Option<&str>,
    body: impl FnOnce(&mut Ui) -> R,
) -> R {
    egui::Frame::new()
        .fill(PALETTE.paper)
        .stroke(egui::Stroke::new(1.0, PALETTE.tan))
        .corner_radius(ROUNDING)
        .inner_margin(12.0)
        .show(ui, |ui| {
            ui.set_width(ui.available_width());
            let heading = ui.label(RichText::new(title).strong().size(16.0));
            if let Some(id) = tip {
                crate::tips::anchor(ui, id, &heading);
            }
            ui.add_space(4.0);
            ui.separator();
            ui.add_space(6.0);
            body(ui)
        })
        .inner
}

/// The two lines of a plan: the bold first line says what and when, the
/// weak second line whose it is, with the face, and how it stands.
pub struct PlanRow<'a> {
    pub face: Option<TextureHandle>,
    pub line1: &'a str,
    pub line2: String,
}

/// One plan as a row inside a section: what stands left of it (a tick
/// box), the two lines, and what stands right of it (buttons, dots, the
/// ⋮), drawn right to left. Returns the first line's label, for a
/// context menu.
pub fn plan_row(
    ui: &mut Ui,
    row: PlanRow<'_>,
    leading: impl FnOnce(&mut Ui),
    trailing: impl FnOnce(&mut Ui),
) -> Response {
    let mut label = None;
    egui::Frame::new()
        .fill(PALETTE.cream)
        .corner_radius(ROUNDING)
        .inner_margin(egui::Margin::symmetric(10, 8))
        .show(ui, |ui| {
            ui.set_width(ui.available_width());
            ui.horizontal(|ui| {
                leading(ui);
                ui.vertical(|ui| {
                    label = Some(ui.label(RichText::new(row.line1).strong()));
                    ui.horizontal(|ui| {
                        if let Some(face) = &row.face {
                            ui.add(
                                egui::Image::from_texture(face)
                                    .fit_to_exact_size(Vec2::splat(20.0))
                                    .corner_radius(10.0),
                            );
                        }
                        if !row.line2.is_empty() {
                            ui.label(RichText::new(&row.line2).weak());
                        }
                    });
                });
                ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), trailing);
            });
        });
    label.expect("the row draws its first line")
}
