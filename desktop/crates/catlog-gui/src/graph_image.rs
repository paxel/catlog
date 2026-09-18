//! The history graph drawn to pixels (#138): on white ground like the
//! Card, the readings on their line, the smoothed curve and the trend as
//! the page shows them, with the title, the first and the last day and
//! the range, so a picture of it goes to the clipboard and from there
//! to the vet or the group chat.

use catlog_core::GraphPoint;
use catlog_core::fonts::FontSet;
use catlog_core::graph::{smooth_curve, trend_line};
use image::{Rgba, RgbaImage};

/// What the picture shows, as the page laid it out.
#[derive(Debug, Clone, PartialEq)]
pub struct GraphSheet {
    /// `Miezi · Weight`.
    pub title: String,
    pub points: Vec<GraphPoint>,
    pub smooth: bool,
    pub trend: bool,
    pub first_day: String,
    pub last_day: String,
    /// The lowest and the highest reading, formatted.
    pub low: String,
    pub high: String,
    /// `Trend: +0.2 kg per month`, when the trend is on.
    pub trend_note: Option<String>,
}

pub const WIDTH: u32 = 800;
pub const HEIGHT: u32 = 480;

const INK: Rgba<u8> = Rgba([0, 0, 0, 255]);
const READINGS: Rgba<u8> = Rgba([150, 150, 150, 255]);
const FRAME: Rgba<u8> = Rgba([210, 210, 210, 255]);
/// The cat orange of the smoothed curve, as on the page.
const ORANGE: Rgba<u8> = Rgba([0xd9, 0x6c, 0x2b, 255]);

/// The graph as pixels; none without two readings or the fonts.
pub fn graph_image(sheet: &GraphSheet, fonts: &FontSet) -> Option<RgbaImage> {
    if sheet.points.len() < 2 {
        return None;
    }
    let regular = ab_glyph::FontRef::try_from_slice(fonts.regular.data()).ok()?;
    let bold = ab_glyph::FontRef::try_from_slice(fonts.bold.data()).ok()?;
    let mut img = RgbaImage::from_pixel(WIDTH, HEIGHT, Rgba([255, 255, 255, 255]));
    let after_title = draw_text(&mut img, &bold, 32.0, 40.0, 32.0, &sheet.title, 0);
    // The plot, with room at its left for the range: the readings' span
    // with a tenth above and below.
    let (left, right, top, bottom) = (130.0f32, 760.0f32, after_title + 24.0, 400.0f32);
    let points = &sheet.points;
    let from = points[0].at;
    let to = points[points.len() - 1].at;
    let span = (to - from).max(1) as f64;
    let (mut lo, mut hi) = points.iter().fold((f64::MAX, f64::MIN), |(lo, hi), p| {
        (lo.min(p.value), hi.max(p.value))
    });
    if hi <= lo {
        hi = lo + 1.0;
        lo -= 1.0;
    }
    let pad = (hi - lo) * 0.1;
    let (lo, hi) = (lo - pad, hi + pad);
    let at = |p: &GraphPoint| -> (f32, f32) {
        let x = left + 8.0 + ((p.at - from) as f64 / span) as f32 * (right - left - 16.0);
        let y = bottom - 8.0 - ((p.value - lo) / (hi - lo)) as f32 * (bottom - top - 16.0);
        (x, y)
    };
    frame(&mut img, left, top, right, bottom);
    let line: Vec<(f32, f32)> = points.iter().map(at).collect();
    for pair in line.windows(2) {
        stroke(&mut img, pair[0], pair[1], 2.0, READINGS);
    }
    if sheet.smooth {
        let curve: Vec<(f32, f32)> = smooth_curve(points, from, to, 80).iter().map(at).collect();
        for pair in curve.windows(2) {
            stroke(&mut img, pair[0], pair[1], 3.0, ORANGE);
        }
    }
    if sheet.trend
        && let Some(fit) = trend_line(points, from, to)
    {
        let a = at(&GraphPoint {
            at: from,
            value: fit.at_from,
        });
        let b = at(&GraphPoint {
            at: to,
            value: fit.at_to,
        });
        dashed(&mut img, a, b, 2.0, INK, 9.0, 6.0);
    }
    for p in &line {
        dot(&mut img, *p, 5.0, INK);
    }
    // The range beside the plot, the days under it, the trend last.
    let high_width = text_width(&regular, 18.0, &sheet.high);
    draw_text(
        &mut img,
        &regular,
        18.0,
        left - 10.0 - high_width,
        top,
        &sheet.high,
        110,
    );
    let low_width = text_width(&regular, 18.0, &sheet.low);
    draw_text(
        &mut img,
        &regular,
        18.0,
        left - 10.0 - low_width,
        bottom - 24.0,
        &sheet.low,
        110,
    );
    let y = draw_text(
        &mut img,
        &regular,
        20.0,
        left,
        bottom + 8.0,
        &sheet.first_day,
        110,
    );
    let last_width = text_width(&regular, 20.0, &sheet.last_day);
    draw_text(
        &mut img,
        &regular,
        20.0,
        right - last_width,
        bottom + 8.0,
        &sheet.last_day,
        110,
    );
    if let Some(note) = &sheet.trend_note {
        draw_text(&mut img, &regular, 20.0, 40.0, y + 6.0, note, 0);
    }
    Some(img)
}

/// The pixels as egui takes them for the clipboard.
pub fn to_color_image(img: &RgbaImage) -> egui::ColorImage {
    let size = [img.width() as usize, img.height() as usize];
    egui::ColorImage::from_rgba_unmultiplied(size, img.as_raw())
}

fn frame(img: &mut RgbaImage, left: f32, top: f32, right: f32, bottom: f32) {
    stroke(img, (left, top), (right, top), 1.0, FRAME);
    stroke(img, (right, top), (right, bottom), 1.0, FRAME);
    stroke(img, (right, bottom), (left, bottom), 1.0, FRAME);
    stroke(img, (left, bottom), (left, top), 1.0, FRAME);
}

/// A filled circle, blended by coverage at its edge.
fn dot(img: &mut RgbaImage, (cx, cy): (f32, f32), radius: f32, color: Rgba<u8>) {
    let (w, h) = (img.width() as i32, img.height() as i32);
    let r = radius.ceil() as i32 + 1;
    for py in (cy as i32 - r)..=(cy as i32 + r) {
        for px in (cx as i32 - r)..=(cx as i32 + r) {
            if px < 0 || py < 0 || px >= w || py >= h {
                continue;
            }
            let d = ((px as f32 + 0.5 - cx).powi(2) + (py as f32 + 0.5 - cy).powi(2)).sqrt();
            let cover = (radius + 0.5 - d).clamp(0.0, 1.0);
            if cover > 0.0 {
                blend(img.get_pixel_mut(px as u32, py as u32), color, cover);
            }
        }
    }
}

/// A line of `width` pixels: dots stamped along it.
fn stroke(img: &mut RgbaImage, a: (f32, f32), b: (f32, f32), width: f32, color: Rgba<u8>) {
    let (dx, dy) = (b.0 - a.0, b.1 - a.1);
    let length = (dx * dx + dy * dy).sqrt();
    let steps = (length / 0.5).ceil().max(1.0) as usize;
    for i in 0..=steps {
        let f = i as f32 / steps as f32;
        dot(img, (a.0 + dx * f, a.1 + dy * f), width / 2.0, color);
    }
}

/// A dashed line: `on` pixels drawn, `off` pixels left out, in turn.
#[allow(clippy::too_many_arguments)]
fn dashed(
    img: &mut RgbaImage,
    a: (f32, f32),
    b: (f32, f32),
    width: f32,
    color: Rgba<u8>,
    on: f32,
    off: f32,
) {
    let (dx, dy) = (b.0 - a.0, b.1 - a.1);
    let length = (dx * dx + dy * dy).sqrt();
    if length == 0.0 {
        return;
    }
    let mut start = 0.0;
    while start < length {
        let end = (start + on).min(length);
        let p = |d: f32| (a.0 + dx * d / length, a.1 + dy * d / length);
        stroke(img, p(start), p(end), width, color);
        start += on + off;
    }
}

fn blend(pixel: &mut Rgba<u8>, color: Rgba<u8>, cover: f32) {
    for i in 0..3 {
        let old = pixel[i] as f32;
        pixel[i] = (old + (color[i] as f32 - old) * cover).round() as u8;
    }
    pixel[3] = 255;
}

fn text_width(font: &ab_glyph::FontRef, size: f32, text: &str) -> f32 {
    use ab_glyph::{Font as _, ScaleFont as _};
    let scaled = font.as_scaled(ab_glyph::PxScale::from(size));
    text.chars()
        .map(|c| scaled.h_advance(scaled.glyph_id(c)))
        .sum()
}

/// Draws one line of text; returns the y below it.
pub fn draw_text(
    img: &mut RgbaImage,
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

#[cfg(test)]
mod tests {
    use super::*;

    fn sheet(smooth: bool, trend: bool) -> GraphSheet {
        let day = 86_400_000;
        GraphSheet {
            title: "Miezi · Weight".into(),
            points: (0..6)
                .map(|i| GraphPoint {
                    at: i * 30 * day,
                    value: 3.0 + i as f64 * 0.2 + if i % 2 == 0 { 0.1 } else { -0.1 },
                })
                .collect(),
            smooth,
            trend,
            first_day: "1/1/2026".into(),
            last_day: "5/30/2026".into(),
            low: "2.9 kg".into(),
            high: "4.1 kg".into(),
            trend_note: trend.then(|| "Trend: +0.2 kg per month".into()),
        }
    }

    fn count(img: &RgbaImage, color: Rgba<u8>) -> usize {
        img.pixels().filter(|p| **p == color).count()
    }

    #[test]
    fn the_graph_draws_its_lines_on_white_with_the_curve_on_request() {
        let fonts = catlog_core::fonts::FontSet::bundled().unwrap();
        let plain = graph_image(&sheet(false, false), &fonts).unwrap();
        assert_eq!((plain.width(), plain.height()), (WIDTH, HEIGHT));
        assert!(count(&plain, Rgba([255, 255, 255, 255])) > (WIDTH * HEIGHT / 2) as usize);
        assert!(count(&plain, INK) > 100, "dots and the title");
        assert!(count(&plain, READINGS) > 100, "the readings' line");
        assert_eq!(count(&plain, ORANGE), 0);
        let full = graph_image(&sheet(true, true), &fonts).unwrap();
        assert!(count(&full, ORANGE) > 100, "the smoothed curve");
        assert!(
            count(&full, INK) > count(&plain, INK),
            "the trend and its note"
        );
        let one = GraphSheet {
            points: vec![GraphPoint { at: 0, value: 1.0 }],
            ..sheet(false, false)
        };
        assert!(graph_image(&one, &fonts).is_none());
        let color = to_color_image(&full);
        assert_eq!(color.size, [WIDTH as usize, HEIGHT as usize]);
        if std::env::var_os("GRAPH_PNG").is_some() {
            let out = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../target");
            let _ = std::fs::create_dir_all(&out);
            full.save(out.join("graph_image.png")).unwrap();
        }
    }
}
