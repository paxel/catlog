//! ID values drawn as codes: a QR code any phone reads, or a Code 128
//! barcode as the chip cards print it. Drawn straight into the ui.

use egui::{Color32, Rect, Ui, Vec2};

/// Draws `value` as a QR code, `size` points wide; none when the value
/// is too long for a code.
pub fn qr(ui: &mut Ui, value: &str, size: f32) -> Option<egui::Response> {
    let code = qrcode::QrCode::new(value.as_bytes()).ok()?;
    let width = code.width();
    let colors = code.to_colors();
    let (rect, response) = ui.allocate_exact_size(Vec2::splat(size), egui::Sense::hover());
    if ui.is_rect_visible(rect) {
        let painter = ui.painter();
        painter.rect_filled(rect, 0.0, Color32::WHITE);
        let quiet = 2.0;
        let cell = size / (width as f32 + 2.0 * quiet);
        for y in 0..width {
            for x in 0..width {
                if colors[y * width + x] == qrcode::Color::Dark {
                    let min =
                        rect.min + Vec2::new((x as f32 + quiet) * cell, (y as f32 + quiet) * cell);
                    painter.rect_filled(
                        Rect::from_min_size(min, Vec2::splat(cell + 0.2)),
                        0.0,
                        Color32::BLACK,
                    );
                }
            }
        }
    }
    Some(response)
}

/// Whether Code 128 can carry every character of `value`.
pub fn prints_as_code128(value: &str) -> bool {
    !value.is_empty() && value.bytes().all(|b| (0x20..0x7f).contains(&b))
}

/// Draws `value` as a Code 128 barcode with the number underneath;
/// none when the value has characters the symbology cannot carry.
pub fn barcode(ui: &mut Ui, value: &str, width: f32, height: f32) -> Option<egui::Response> {
    if !prints_as_code128(value) {
        return None;
    }
    let bits = barcoders::sym::code128::Code128::new(format!("\u{0181}{value}"))
        .ok()?
        .encode();
    let text_height = 16.0;
    let (rect, response) =
        ui.allocate_exact_size(Vec2::new(width, height + text_height), egui::Sense::hover());
    if ui.is_rect_visible(rect) {
        let painter = ui.painter();
        painter.rect_filled(rect, 0.0, Color32::WHITE);
        let quiet = 10.0;
        let bar = (width - 2.0 * quiet) / bits.len() as f32;
        for (i, bit) in bits.iter().enumerate() {
            if *bit == 1 {
                let min = rect.min + Vec2::new(quiet + i as f32 * bar, 0.0);
                painter.rect_filled(
                    Rect::from_min_size(min, Vec2::new(bar + 0.2, height)),
                    0.0,
                    Color32::BLACK,
                );
            }
        }
        painter.text(
            rect.center_bottom() - Vec2::new(0.0, 2.0),
            egui::Align2::CENTER_BOTTOM,
            value,
            egui::FontId::monospace(12.0),
            Color32::BLACK,
        );
    }
    Some(response)
}

#[cfg(test)]
mod tests {
    use super::*;
    use egui_kittest::Harness;

    #[test]
    fn codes_draw_for_fitting_values_and_refuse_the_rest() {
        assert!(prints_as_code128("276098100123456"));
        assert!(!prints_as_code128("äöü"));
        assert!(!prints_as_code128(""));
        let mut h = Harness::builder()
            .with_size(egui::vec2(400.0, 400.0))
            .build_ui(|ui| {
                assert!(qr(ui, "https://example.org", 120.0).is_some());
                assert!(qr(ui, &"x".repeat(5000), 120.0).is_none());
                assert!(barcode(ui, "276098100123456", 300.0, 60.0).is_some());
                assert!(barcode(ui, "ä", 300.0, 60.0).is_none());
            });
        h.run();
    }
}
