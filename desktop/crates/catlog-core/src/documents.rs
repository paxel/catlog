//! The documents a Catalog prints: the Card of a Cat, the missing
//! poster and the report for the vet. The GUI hands over translated
//! words; the layout is the phone's, in points on A4.

use crate::fonts::FontSet;
use crate::graph::{GraphPoint, smooth_curve};
use crate::pdf::{A4, Pdf, Rgb, fit_size, wrap};

/// The palette the report tells Fields apart with.
pub const REPORT_COLOURS: [u32; 8] = [
    0xd32f2f, 0x1976d2, 0x388e3c, 0xf57c00, 0x7b1fa2, 0x00838f, 0xc2185b, 0x5d4037,
];

pub fn report_colour(index: usize) -> u32 {
    REPORT_COLOURS[index % REPORT_COLOURS.len()]
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum CodeKind {
    Qr,
    Code128,
}

/// An ID on the card: its code and the caption under it.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct CardCode {
    pub kind: CodeKind,
    pub data: String,
    pub caption: String,
}

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct CardContent {
    pub name: String,
    pub photo: Option<Vec<u8>>,
    pub facts: Vec<(String, String)>,
    pub codes: Vec<CardCode>,
}

const CARD_MARGIN: f32 = 28.0;

/// The Card: the photo, the name, the facts, the codes.
pub fn card_pdf(c: &CardContent, fonts: &FontSet, title: &str) -> Vec<u8> {
    let mut pdf = Pdf::new(title);
    let regular = pdf.add_font(&fonts.regular);
    let bold = pdf.add_font(&fonts.bold);
    let script = fonts
        .script
        .as_ref()
        .map(|(r, b)| (pdf.add_font(r), pdf.add_font(b)));
    let photo = c.photo.as_ref().and_then(|bytes| pdf.add_image(bytes).ok());
    let width = A4.0 - 2.0 * CARD_MARGIN;
    let page = pdf.page(A4.0, A4.1);
    let mut y = A4.1 - CARD_MARGIN;
    if let Some(img) = photo {
        let h = 240.0;
        let w = (img.width as f32 / img.height as f32 * h).min(width);
        let x = CARD_MARGIN + (width - w) / 2.0;
        page.image(&img, x, y - h, w, h);
        y -= h + 16.0;
    }
    let pick = |text: &str, is_bold: bool| -> &crate::pdf::FontRef {
        let base = fonts.face(text, is_bold);
        match (
            &script,
            base.has('\u{0}')
                || std::ptr::eq(base, if is_bold { &fonts.bold } else { &fonts.regular }),
        ) {
            (_, true) => {
                if is_bold {
                    &bold
                } else {
                    &regular
                }
            }
            (Some((r, b)), false) => {
                if is_bold {
                    b
                } else {
                    r
                }
            }
            (None, false) => {
                if is_bold {
                    &bold
                } else {
                    &regular
                }
            }
        }
    };
    let name = fonts.visual(&c.name);
    let size = fit_size(&pick(&name, true).font, 28.0, &name, width);
    y -= size;
    page.text(pick(&name, true), size, CARD_MARGIN, y, &name, Rgb::BLACK);
    y -= 14.0;
    for (label, value) in &c.facts {
        let label = fonts.visual(label);
        let value = fonts.visual(value);
        let lines = wrap(&pick(&value, false).font, 12.0, &value, width - 130.0);
        y -= 14.0;
        page.text(
            pick(&label, false),
            12.0,
            CARD_MARGIN,
            y,
            &label,
            Rgb::gray(0.4),
        );
        for (i, line) in lines.iter().enumerate() {
            if i > 0 {
                y -= 14.0;
            }
            page.text(
                pick(line, false),
                12.0,
                CARD_MARGIN + 130.0,
                y,
                line,
                Rgb::BLACK,
            );
        }
        y -= 4.0;
    }
    for code in &c.codes {
        y -= 12.0;
        match code.kind {
            CodeKind::Qr => {
                page.qr(&code.data, CARD_MARGIN, y, 80.0);
                y -= 80.0;
            }
            CodeKind::Code128 => {
                if !page.code128(&code.data, CARD_MARGIN, y, 180.0, 44.0) {
                    let text = fonts.visual(&code.data);
                    y -= 9.0;
                    page.text(pick(&text, false), 9.0, CARD_MARGIN, y, &text, Rgb::BLACK);
                }
                y -= 44.0;
            }
        }
        let caption = fonts.visual(&code.caption);
        y -= 11.0;
        page.text(
            pick(&caption, false),
            9.0,
            CARD_MARGIN,
            y,
            &caption,
            Rgb::gray(0.4),
        );
    }
    pdf.save()
}

/// A photo on the poster with the part of it that shows: x, y, w, h as
/// fractions of the picture, (0, 0, 1, 1) for all of it.
#[derive(Debug, Clone, PartialEq)]
pub struct PosterPhoto {
    pub bytes: Vec<u8>,
    pub x: f32,
    pub y: f32,
    pub w: f32,
    pub h: f32,
}

impl PosterPhoto {
    pub fn whole(bytes: Vec<u8>) -> PosterPhoto {
        PosterPhoto {
            bytes,
            x: 0.0,
            y: 0.0,
            w: 1.0,
            h: 1.0,
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct PosterCode {
    pub data: String,
    pub caption: String,
}

#[derive(Debug, Clone, Default, PartialEq)]
pub struct PosterContent {
    pub headline: String,
    pub name: String,
    pub photos: Vec<PosterPhoto>,
    pub lines: Vec<String>,
    pub phone: Option<String>,
    pub looks: Option<String>,
    pub extra: Option<String>,
    pub standing: String,
    pub codes: Vec<PosterCode>,
}

/// The QR payload a phone still reads off paper.
pub const POSTER_QR_LIMIT: usize = 2300;

const POSTER_MARGIN: f32 = 28.0;
const PHOTO_ROW_HEIGHT: f32 = 230.0;
const PHOTO_GAP: f32 = 10.0;

pub fn poster_width() -> f32 {
    A4.0 - 2.0 * POSTER_MARGIN
}

/// The frame a photo gets, as width over height.
pub fn poster_frame_aspect(count: usize) -> f32 {
    if count <= 1 {
        poster_width() / PHOTO_ROW_HEIGHT
    } else {
        ((poster_width() - PHOTO_GAP) / 2.0) / PHOTO_ROW_HEIGHT
    }
}

/// Headline and name sizes that leave room for the rest of the page.
pub fn poster_title_sizes(lines: &[String], photos: bool, phone: bool, codes: bool) -> (f32, f32) {
    let (headline_max, headline_min) = (62.0, 38.0);
    let (name_max, name_min) = (96.0, 52.0);
    let mut spent = 0.0;
    if photos {
        spent += PHOTO_ROW_HEIGHT + PHOTO_GAP;
    }
    if phone {
        spent += 64.0 + 10.0;
    }
    spent += 14.0 + 96.0 + if codes { 132.0 } else { 0.0 };
    let need: f32 = lines.iter().map(|_| 24.0).sum();
    let room = A4.1 - 2.0 * POSTER_MARGIN - spent - need;
    let mut headline = headline_max;
    let mut name = name_max;
    let mut short = headline + name - room;
    if short > 0.0 {
        let give = short.min(headline_max - headline_min);
        headline -= give;
        short -= give;
    }
    if short > 0.0 {
        name -= short.min(name_max - name_min);
    }
    (headline, name)
}

/// The missing poster.
pub fn poster_pdf(c: &PosterContent, fonts: &FontSet) -> Vec<u8> {
    let mut pdf = Pdf::new(&format!("{} — {}", c.name, c.headline));
    let bold = pdf.add_font(&fonts.bold);
    let regular = pdf.add_font(&fonts.regular);
    let script = fonts
        .script
        .as_ref()
        .map(|(r, b)| (pdf.add_font(r), pdf.add_font(b)));
    let images: Vec<_> = c
        .photos
        .iter()
        .take(2)
        .filter_map(|p| pdf.add_image(&p.bytes).ok().map(|img| (img, p.clone())))
        .collect();
    let width = poster_width();
    let mut lines: Vec<String> = c.lines.clone();
    if let Some(extra) = c.extra.as_ref().filter(|e| !e.is_empty()) {
        lines.push(extra.clone());
    }
    let (headline_size, name_size) = poster_title_sizes(
        &lines,
        !images.is_empty(),
        c.phone.is_some(),
        !c.codes.is_empty(),
    );
    let page = pdf.page(A4.0, A4.1);
    let font_for = |text: &str, is_bold: bool| -> &crate::pdf::FontRef {
        let base = if is_bold { &fonts.bold } else { &fonts.regular };
        let wants_script = text.chars().any(|ch| !base.has(ch));
        match (&script, wants_script) {
            (Some((r, b)), true) => {
                if is_bold {
                    b
                } else {
                    r
                }
            }
            _ => {
                if is_bold {
                    &bold
                } else {
                    &regular
                }
            }
        }
    };
    let mut y = A4.1 - POSTER_MARGIN;
    // Photos: one across, or two side by side, each framed by its crop.
    if !images.is_empty() {
        let fw = if images.len() == 1 {
            width
        } else {
            (width - PHOTO_GAP) / 2.0
        };
        for (i, (img, photo)) in images.iter().enumerate() {
            let fx = POSTER_MARGIN + i as f32 * (fw + PHOTO_GAP);
            let frame = (fx, y - PHOTO_ROW_HEIGHT, fw, PHOTO_ROW_HEIGHT);
            let drawn_w = fw / photo.w.max(0.01);
            let drawn_h = PHOTO_ROW_HEIGHT / photo.h.max(0.01);
            let dx = fx - photo.x * drawn_w;
            let dy = (y - PHOTO_ROW_HEIGHT) - (1.0 - photo.y - photo.h) * drawn_h;
            page.image_clipped(img, frame, dx, dy, drawn_w, drawn_h);
        }
        y -= PHOTO_ROW_HEIGHT + PHOTO_GAP;
    }
    let headline = fonts.visual(&c.headline);
    let size = fit_size(
        &font_for(&headline, true).font,
        headline_size,
        &headline,
        width,
    );
    y -= headline_size + 2.0;
    page.text(
        font_for(&headline, true),
        size,
        POSTER_MARGIN,
        y + (headline_size - size) * 0.2,
        &headline,
        Rgb::BLACK,
    );
    let name = fonts.visual(&c.name);
    let size = fit_size(&font_for(&name, true).font, name_size - 6.0, &name, width);
    y -= name_size;
    page.text(
        font_for(&name, true),
        size,
        POSTER_MARGIN,
        y + (name_size - size) * 0.2,
        &name,
        Rgb::BLACK,
    );
    y -= 8.0;
    // The lines, shrunk together when they would not fit above the band.
    let reserved = 10.0
        + if c.phone.is_some() { 64.0 + 10.0 } else { 0.0 }
        + 14.0
        + 96.0
        + if c.codes.is_empty() { 0.0 } else { 132.0 }
        + POSTER_MARGIN;
    let room = y - reserved;
    let mut line_size: f32 = 20.0;
    let need = lines.len() as f32 * (line_size + 4.0);
    if need > room && !lines.is_empty() {
        line_size = (line_size * room / need).max(8.0);
    }
    for line in &lines {
        let line = fonts.visual(line);
        let size = fit_size(&font_for(&line, true).font, line_size, &line, width);
        y -= line_size + 4.0;
        page.text(
            font_for(&line, true),
            size,
            POSTER_MARGIN,
            y,
            &line,
            Rgb::BLACK,
        );
    }
    // The bottom block sits at the foot: phone band, looks, standing, codes.
    let block_height = if c.phone.is_some() { 64.0 + 10.0 } else { 0.0 }
        + 14.0
        + 96.0
        + if c.codes.is_empty() { 0.0 } else { 132.0 };
    let mut y = (POSTER_MARGIN + block_height).min(y - 10.0);
    if let Some(phone) = &c.phone {
        let phone = fonts.visual(phone);
        y -= 64.0;
        page.rect(POSTER_MARGIN, y, width, 64.0, Rgb::BLACK);
        let size = fit_size(&font_for(&phone, true).font, 46.0, &phone, width - 24.0);
        page.text(
            font_for(&phone, true),
            size,
            POSTER_MARGIN + 12.0,
            y + 14.0,
            &phone,
            Rgb::WHITE,
        );
        y -= 10.0;
    }
    y -= 14.0;
    if let Some(looks) = &c.looks {
        for line in wrap(&fonts.bold, 13.0, &fonts.visual(looks), width)
            .iter()
            .take(3)
        {
            y -= 15.0;
            page.text(
                font_for(line, true),
                13.0,
                POSTER_MARGIN,
                y,
                line,
                Rgb::BLACK,
            );
        }
        y -= 6.0;
    }
    for line in wrap(&fonts.bold, 13.0, &fonts.visual(&c.standing), width)
        .iter()
        .take(3)
    {
        y -= 15.0;
        page.text(
            font_for(line, true),
            13.0,
            POSTER_MARGIN,
            y,
            line,
            Rgb::BLACK,
        );
    }
    if !c.codes.is_empty() {
        y -= 8.0;
        let code_size =
            (120.0f32).min((width - 14.0 * (c.codes.len() as f32 - 1.0)) / c.codes.len() as f32);
        let top = y;
        for (i, code) in c.codes.iter().enumerate() {
            let x = POSTER_MARGIN + i as f32 * (code_size + 14.0);
            page.qr(&code.data, x, top, code_size);
            let caption = fonts.visual(&code.caption);
            let size = fit_size(&font_for(&caption, false).font, 8.0, &caption, code_size);
            page.text(
                font_for(&caption, false),
                size,
                x,
                top - code_size - 10.0,
                &caption,
                Rgb::BLACK,
            );
        }
    }
    pdf.save()
}

/// The patient sheet at the front of the report.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct ReportSummary {
    pub title: String,
    pub photo: Option<Vec<u8>>,
    pub facts: Vec<(String, String)>,
}

/// One entry on the timeline.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ReportRow {
    /// The day, only on the first row of it.
    pub day: String,
    pub colour: u32,
    pub label: String,
    pub value: String,
}

#[derive(Debug, Clone, PartialEq)]
pub struct ReportCurve {
    pub title: String,
    pub colour: u32,
    pub points: Vec<GraphPoint>,
    pub from: i64,
    pub to: i64,
    /// The words under the left and right end of the axis.
    pub axis: (String, String),
}

#[derive(Debug, Clone, Default, PartialEq)]
pub struct ReportContent {
    pub name: String,
    pub timeline_title: String,
    pub legend_title: String,
    pub legend: Vec<(String, u32)>,
    pub summary: Option<ReportSummary>,
    pub rows: Vec<ReportRow>,
    pub curves: Vec<ReportCurve>,
    /// Shown when the script's fonts were not to be had.
    pub note: Option<String>,
}

const REPORT_MARGIN: f32 = 40.0;

/// The report for the vet: patient sheet, timeline with legend, one
/// curve per page, a footer with the page count.
pub fn vet_report_pdf(c: &ReportContent, fonts: &FontSet) -> Vec<u8> {
    let mut pdf = Pdf::new(&format!("{} — {}", c.name, c.timeline_title));
    let regular = pdf.add_font(&fonts.regular);
    let bold = pdf.add_font(&fonts.bold);
    let width = A4.0 - 2.0 * REPORT_MARGIN;
    let photo = c
        .summary
        .as_ref()
        .and_then(|s| s.photo.as_ref())
        .and_then(|b| pdf.add_image(b).ok());
    let mut pages: Vec<crate::pdf::Page> = Vec::new();
    let new_page = |pages: &mut Vec<crate::pdf::Page>| -> f32 {
        pages.push(crate::pdf::Page::blank(A4.0, A4.1));
        A4.1 - REPORT_MARGIN
    };
    let mut y = new_page(&mut pages);
    if let Some(summary) = &c.summary {
        let page = pages.last_mut().expect("page");
        let mut x = REPORT_MARGIN;
        if let Some(img) = photo {
            let h = 120.0;
            let w = (img.width as f32 / img.height as f32 * h).min(160.0);
            page.image(&img, x, y - h, w, h);
            x += w + 12.0;
        }
        let name = fonts.visual(&c.name);
        page.text(&bold, 24.0, x, y - 24.0, &name, Rgb::BLACK);
        page.text(
            &regular,
            8.0,
            x,
            y - 38.0,
            &fonts.visual(&summary.title),
            Rgb::gray(0.4),
        );
        let mut fy = y - 56.0;
        for (label, value) in &summary.facts {
            page.text(&regular, 10.0, x, fy, &fonts.visual(label), Rgb::gray(0.4));
            for (i, line) in wrap(
                &fonts.regular,
                11.0,
                &fonts.visual(value),
                width - (x - REPORT_MARGIN) - 110.0,
            )
            .iter()
            .enumerate()
            {
                if i > 0 {
                    fy -= 13.0;
                }
                page.text(&regular, 11.0, x + 110.0, fy, line, Rgb::BLACK);
            }
            fy -= 14.0;
        }
        y = new_page(&mut pages);
    }
    // Timeline.
    {
        let page = pages.last_mut().expect("page");
        let title = if c.summary.is_some() {
            c.timeline_title.clone()
        } else {
            format!("{} · {}", c.name, c.timeline_title)
        };
        y -= 16.0;
        page.text(
            &bold,
            16.0,
            REPORT_MARGIN,
            y,
            &fonts.visual(&title),
            Rgb::BLACK,
        );
        y -= 12.0;
        page.text(
            &regular,
            8.0,
            REPORT_MARGIN,
            y,
            &fonts.visual(&c.legend_title),
            Rgb::gray(0.4),
        );
        let mut x = REPORT_MARGIN;
        y -= 12.0;
        for (label, colour) in &c.legend {
            let label = fonts.visual(label);
            let w = fonts.regular.width(&label, 9.0) + 18.0;
            if x + w > A4.0 - REPORT_MARGIN {
                x = REPORT_MARGIN;
                y -= 12.0;
            }
            page.circle(x + 4.0, y + 3.0, 3.5, Rgb::from_u32(*colour));
            page.text(&regular, 9.0, x + 11.0, y, &label, Rgb::BLACK);
            x += w;
        }
        if let Some(note) = &c.note {
            y -= 13.0;
            page.text(
                &regular,
                9.0,
                REPORT_MARGIN,
                y,
                &fonts.visual(note),
                Rgb::from_u32(0xc62828),
            );
        }
        y -= 10.0;
    }
    for row in &c.rows {
        let value_lines = wrap(
            &fonts.regular,
            10.0,
            &fonts.visual(&row.value),
            width - 84.0 - 100.0,
        );
        let height = 14.0 * value_lines.len().max(1) as f32 + 4.0;
        if y - height < REPORT_MARGIN + 20.0 {
            y = new_page(&mut pages);
        }
        let page = pages.last_mut().expect("page");
        y -= 12.0;
        page.text(
            &regular,
            9.0,
            REPORT_MARGIN,
            y,
            &fonts.visual(&row.day),
            Rgb::gray(0.4),
        );
        page.circle(
            REPORT_MARGIN + 72.0,
            y + 3.0,
            3.5,
            Rgb::from_u32(row.colour),
        );
        page.text(
            &bold,
            10.0,
            REPORT_MARGIN + 84.0,
            y,
            &fonts.visual(&row.label),
            Rgb::BLACK,
        );
        for (i, line) in value_lines.iter().enumerate() {
            if i > 0 {
                y -= 13.0;
            }
            page.text(&regular, 10.0, REPORT_MARGIN + 184.0, y, line, Rgb::BLACK);
        }
        y -= 6.0;
    }
    for curve in &c.curves {
        let top = new_page(&mut pages);
        let page = pages.last_mut().expect("page");
        page.text(
            &bold,
            16.0,
            REPORT_MARGIN,
            top - 16.0,
            &fonts.visual(&curve.title),
            Rgb::BLACK,
        );
        let (gx, gy, gw, gh) = (REPORT_MARGIN + 30.0, top - 380.0, width - 30.0, 320.0);
        page.stroke_rect(gx, gy, gw, gh, 0.5, Rgb::gray(0.6));
        if curve.points.len() >= 2 {
            let (min, max) = curve
                .points
                .iter()
                .fold((f64::MAX, f64::MIN), |(lo, hi), p| {
                    (lo.min(p.value), hi.max(p.value))
                });
            let span = (max - min).max(0.1);
            let (lo, hi) = (min - span * 0.1, max + span * 0.1);
            let to_xy = |p: &GraphPoint| -> (f32, f32) {
                let fx = (p.at - curve.from) as f32 / (curve.to - curve.from).max(1) as f32;
                let fy = ((p.value - lo) / (hi - lo)) as f32;
                (gx + fx * gw, gy + fy * gh)
            };
            let smooth: Vec<(f32, f32)> = smooth_curve(&curve.points, curve.from, curve.to, 80)
                .iter()
                .map(to_xy)
                .collect();
            page.polyline(&smooth, 1.5, Rgb::from_u32(curve.colour));
            for p in &curve.points {
                let (x, y) = to_xy(p);
                page.circle(x, y, 2.5, Rgb::from_u32(curve.colour));
            }
            page.text(
                &regular,
                9.0,
                REPORT_MARGIN,
                gy + gh - 4.0,
                &format!("{hi:.1}"),
                Rgb::gray(0.4),
            );
            page.text(
                &regular,
                9.0,
                REPORT_MARGIN,
                gy,
                &format!("{lo:.1}"),
                Rgb::gray(0.4),
            );
        }
        page.text(
            &regular,
            9.0,
            gx,
            gy - 12.0,
            &fonts.visual(&curve.axis.0),
            Rgb::gray(0.4),
        );
        let right = fonts.visual(&curve.axis.1);
        let w = fonts.regular.width(&right, 9.0);
        page.text(
            &regular,
            9.0,
            gx + gw - w,
            gy - 12.0,
            &right,
            Rgb::gray(0.4),
        );
    }
    let count = pages.len();
    for (i, page) in pages.iter_mut().enumerate() {
        let footer = format!("cat(a)log · {} · {}/{}", c.name, i + 1, count);
        page.text(
            &regular,
            8.0,
            REPORT_MARGIN,
            REPORT_MARGIN - 16.0,
            &fonts.visual(&footer),
            Rgb::gray(0.5),
        );
    }
    pdf.pages = pages;
    pdf.save()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn jpeg(w: u32, h: u32) -> Vec<u8> {
        let img = image::DynamicImage::new_rgb8(w, h);
        let mut out = Vec::new();
        img.write_to(
            &mut std::io::Cursor::new(&mut out),
            image::ImageFormat::Jpeg,
        )
        .unwrap();
        out
    }

    fn pages_of(bytes: &[u8]) -> usize {
        lopdf::Document::load_mem(bytes).unwrap().get_pages().len()
    }

    #[test]
    fn the_card_carries_photo_facts_and_codes() {
        let fonts = FontSet::bundled().unwrap();
        let card = CardContent {
            name: "Miezi".into(),
            photo: Some(jpeg(40, 30)),
            facts: vec![
                ("Gender".into(), "female".into()),
                (
                    "Remarks".into(),
                    "a very long remark that has to wrap onto a second line of the card for sure"
                        .into(),
                ),
            ],
            codes: vec![
                CardCode {
                    kind: CodeKind::Qr,
                    data: "https://example.org/276".into(),
                    caption: "Chip ID: 276".into(),
                },
                CardCode {
                    kind: CodeKind::Code128,
                    data: "276098".into(),
                    caption: "Chip ID: 276098".into(),
                },
                CardCode {
                    kind: CodeKind::Code128,
                    data: "ä".into(),
                    caption: "odd".into(),
                },
            ],
        };
        let bytes = card_pdf(&card, &fonts, "Card — Miezi");
        assert_eq!(pages_of(&bytes), 1);
        let empty = card_pdf(&CardContent::default(), &fonts, "Card");
        assert_eq!(pages_of(&empty), 1);
        std::fs::write(
            std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../target/card.pdf"),
            &bytes,
        )
        .ok();
    }

    #[test]
    fn the_poster_sizes_its_titles_and_puts_the_qr_where_a_phone_reads_it() {
        let fonts = FontSet::bundled().unwrap();
        let (h, n) = poster_title_sizes(&[], false, false, false);
        assert_eq!((h, n), (62.0, 96.0));
        let many: Vec<String> = (0..20).map(|i| format!("line {i}")).collect();
        let (h, n) = poster_title_sizes(&many, true, true, true);
        assert!(h < 62.0 && n < 96.0);
        assert!(h >= 38.0 && n >= 52.0);
        assert!(poster_frame_aspect(1) > poster_frame_aspect(2));
        let payload = crate::share::encode_share_data(b"hello poster");
        let poster = PosterContent {
            headline: "MISSING".into(),
            name: "Miezi".into(),
            photos: vec![
                PosterPhoto::whole(jpeg(60, 40)),
                PosterPhoto {
                    bytes: jpeg(40, 60),
                    x: 0.1,
                    y: 0.1,
                    w: 0.5,
                    h: 0.5,
                },
                PosterPhoto::whole(jpeg(9, 9)),
            ],
            lines: vec![
                "Missing since: 3/10/2026".into(),
                "Address: Katzenweg 3".into(),
            ],
            phone: Some("0170 1234567".into()),
            looks: Some("small, black and white".into()),
            extra: Some("Very shy".into()),
            standing: "Please check cellars, sheds and garages. Do not chase, just call.".into(),
            codes: vec![
                PosterCode {
                    data: payload.clone(),
                    caption: "QR code for cat(a)log".into(),
                },
                PosterCode {
                    data: "geo:51.34,12.37".into(),
                    caption: "Address".into(),
                },
            ],
        };
        let bytes = poster_pdf(&poster, &fonts);
        assert_eq!(pages_of(&bytes), 1);
        let bare = poster_pdf(
            &PosterContent {
                name: "Tom".into(),
                headline: "MISSING".into(),
                ..Default::default()
            },
            &fonts,
        );
        assert_eq!(pages_of(&bare), 1);
        std::fs::write(
            std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../target/poster.pdf"),
            &bytes,
        )
        .ok();
        // The QR on the page decodes to the payload: the same modules the
        // page draws, rendered to pixels and read back.
        let code = qrcode::QrCode::new(payload.as_bytes()).unwrap();
        let (width, colors, scale, quiet) = (code.width(), code.to_colors(), 6u32, 4u32);
        let side = (width as u32 + 2 * quiet) * scale;
        let image = image::GrayImage::from_fn(side, side, |x, y| {
            let (col, row) = (x / scale, y / scale);
            let dark = col >= quiet
                && row >= quiet
                && col - quiet < width as u32
                && row - quiet < width as u32
                && colors[(row - quiet) as usize * width + (col - quiet) as usize]
                    == qrcode::Color::Dark;
            image::Luma([if dark { 0 } else { 255 }])
        });
        let mut prepared = rqrr::PreparedImage::prepare(image);
        let grids = prepared.detect_grids();
        assert_eq!(grids.len(), 1);
        let (_, text) = grids[0].decode().unwrap();
        assert_eq!(text, payload);
        assert_eq!(
            crate::share::decode_share_qr(&text),
            Some(crate::share::ShareQr::Data(b"hello poster".to_vec()))
        );
        assert!(payload.len() < POSTER_QR_LIMIT);
    }

    /// Reads the QR back off the rendered page; needs pdftoppm.
    #[test]
    #[ignore = "needs pdftoppm on the path"]
    fn the_rendered_poster_page_carries_a_readable_qr() {
        let dir = tempfile::tempdir().unwrap();
        let fonts = FontSet::bundled().unwrap();
        let payload = crate::share::encode_share_data(b"hello poster");
        let poster = PosterContent {
            headline: "MISSING".into(),
            name: "Miezi".into(),
            standing: "Call.".into(),
            codes: vec![PosterCode {
                data: payload.clone(),
                caption: "QR".into(),
            }],
            ..Default::default()
        };
        let pdf = dir.path().join("poster.pdf");
        std::fs::write(&pdf, poster_pdf(&poster, &fonts)).unwrap();
        let status = std::process::Command::new("pdftoppm")
            .args(["-r", "150", "-png", "-singlefile"])
            .arg(&pdf)
            .arg(dir.path().join("page"))
            .status()
            .expect("pdftoppm");
        assert!(status.success());
        let png = image::open(dir.path().join("page.png")).unwrap().to_luma8();
        let mut prepared = rqrr::PreparedImage::prepare(png);
        let grids = prepared.detect_grids();
        assert!(!grids.is_empty(), "a QR on the page");
        let (_, text) = grids[0].decode().unwrap();
        assert_eq!(text, payload);
    }

    #[test]
    fn the_report_has_a_patient_sheet_a_timeline_and_a_curve_page_each() {
        let fonts = FontSet::bundled().unwrap();
        let rows: Vec<ReportRow> = (0..80)
            .map(|i| ReportRow {
                day: if i % 3 == 0 {
                    format!("3/{}/2026", i % 28 + 1)
                } else {
                    String::new()
                },
                colour: report_colour(i % 2),
                label: if i % 2 == 0 {
                    "Weight".into()
                } else {
                    "Remarks".into()
                },
                value: if i % 2 == 0 {
                    format!("{:.1} kg", 3.0 + i as f64 / 10.0)
                } else {
                    "a longer remark that the vet should read in full even when it wraps".into()
                },
            })
            .collect();
        let points: Vec<GraphPoint> = (0..10)
            .map(|i| GraphPoint {
                at: 1_700_000_000_000 + i * 86_400_000 * 7,
                value: 3.0 + i as f64 * 0.1,
            })
            .collect();
        let report = ReportContent {
            name: "Miezi".into(),
            timeline_title: "Timeline".into(),
            legend_title: "Legend".into(),
            legend: vec![
                ("Weight".into(), report_colour(0)),
                ("Remarks".into(), report_colour(1)),
            ],
            summary: Some(ReportSummary {
                title: "Patient summary".into(),
                photo: Some(jpeg(30, 40)),
                facts: vec![
                    ("Species".into(), "cat".into()),
                    ("Age".into(), "2 years".into()),
                ],
            }),
            rows,
            curves: vec![
                ReportCurve {
                    title: "Weight".into(),
                    colour: report_colour(0),
                    points: points.clone(),
                    from: points[0].at,
                    to: points[9].at,
                    axis: ("11/14/2023".into(), "1/16/2024".into()),
                },
                ReportCurve {
                    title: "Empty".into(),
                    colour: 0,
                    points: vec![],
                    from: 0,
                    to: 1,
                    axis: ("a".into(), "b".into()),
                },
            ],
            note: Some("Fonts missing".into()),
        };
        let bytes = vet_report_pdf(&report, &fonts);
        let pages = pages_of(&bytes);
        assert!(
            pages >= 5,
            "sheet, two or more timeline pages, two curves: {pages}"
        );
        let plain = vet_report_pdf(
            &ReportContent {
                name: "Tom".into(),
                timeline_title: "Timeline".into(),
                ..Default::default()
            },
            &fonts,
        );
        assert_eq!(pages_of(&plain), 1);
        assert_eq!(report_colour(8), REPORT_COLOURS[0]);
        std::fs::write(
            std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../target/report.pdf"),
            &bytes,
        )
        .ok();
    }
}
