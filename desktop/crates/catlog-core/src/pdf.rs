//! A small PDF writer: pages with text set in embedded TrueType fonts,
//! JPEG photos, filled rectangles and lines, QR and Code128 as vector
//! modules. Enough for a card, a poster and a report, and nothing that
//! a viewer or a printer trips over.

use std::collections::{BTreeMap, BTreeSet};
use std::io::Write;

use crate::Result;
use crate::error::Error;

/// A4 in points.
pub const A4: (f32, f32) = (595.28, 841.89);

/// A parsed TrueType font: the bytes travel into the PDF whole.
#[derive(Clone)]
pub struct Font {
    data: std::sync::Arc<Vec<u8>>,
    units_per_em: f32,
    ascender: i16,
    descender: i16,
    cap_height: i16,
    bbox: [i16; 4],
    /// Glyph id and advance per char, filled as text is measured and
    /// shared by every clone, so the widths written are the ones used.
    glyphs: std::sync::Arc<std::sync::Mutex<BTreeMap<char, (u16, u16)>>>,
    name: String,
}

impl std::fmt::Debug for Font {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "Font({})", self.name)
    }
}

impl Font {
    pub fn parse(data: Vec<u8>, name: &str) -> Result<Font> {
        let face = ttf_parser::Face::parse(&data, 0)
            .map_err(|e| Error::Invalid(format!("font {name}: {e}")))?;
        let b = face.global_bounding_box();
        let font = Font {
            units_per_em: face.units_per_em() as f32,
            ascender: face.ascender(),
            descender: face.descender(),
            cap_height: face.capital_height().unwrap_or(face.ascender()),
            bbox: [b.x_min, b.y_min, b.x_max, b.y_max],
            glyphs: std::sync::Arc::new(std::sync::Mutex::new(BTreeMap::new())),
            name: name.to_string(),
            data: std::sync::Arc::new(data),
        };
        Ok(font)
    }

    /// The font file's bytes.
    pub fn data(&self) -> &[u8] {
        &self.data
    }

    /// True when the font has a glyph for `c`.
    pub fn has(&self, c: char) -> bool {
        self.glyph(c).0 != 0
    }

    fn glyph(&self, c: char) -> (u16, u16) {
        if let Some(g) = self.glyphs.lock().ok().and_then(|m| m.get(&c).copied()) {
            return g;
        }
        let face = ttf_parser::Face::parse(&self.data, 0).expect("parsed once already");
        let id = face.glyph_index(c).map(|g| g.0).unwrap_or(0);
        let advance = face.glyph_hor_advance(ttf_parser::GlyphId(id)).unwrap_or(0);
        if let Ok(mut m) = self.glyphs.lock() {
            m.insert(c, (id, advance));
        }
        (id, advance)
    }

    /// The width of `text` at `size` points.
    pub fn width(&self, text: &str, size: f32) -> f32 {
        text.chars().map(|c| self.glyph(c).1 as f32).sum::<f32>() * size / self.units_per_em
    }

    /// Where the baseline sits below the top of a line at `size`.
    pub fn ascent(&self, size: f32) -> f32 {
        self.ascender as f32 * size / self.units_per_em
    }

    fn scaled(&self, v: i16) -> i32 {
        (v as f32 * 1000.0 / self.units_per_em).round() as i32
    }
}

/// A colour, 0..1 per channel.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Rgb(pub f32, pub f32, pub f32);

impl Rgb {
    pub const BLACK: Rgb = Rgb(0.0, 0.0, 0.0);
    pub const WHITE: Rgb = Rgb(1.0, 1.0, 1.0);
    pub fn gray(v: f32) -> Rgb {
        Rgb(v, v, v)
    }
    pub fn from_u32(rgb: u32) -> Rgb {
        Rgb(
            ((rgb >> 16) & 0xff) as f32 / 255.0,
            ((rgb >> 8) & 0xff) as f32 / 255.0,
            (rgb & 0xff) as f32 / 255.0,
        )
    }
}

fn num(v: f32) -> String {
    let s = format!("{v:.3}");
    s.trim_end_matches('0').trim_end_matches('.').to_string()
}

/// One page's content: coordinates in points, origin bottom left.
#[derive(Debug, Default)]
pub struct Page {
    pub width: f32,
    pub height: f32,
    ops: String,
    fonts: BTreeSet<usize>,
    images: BTreeSet<usize>,
}

impl Page {
    /// An empty page of the given size, to be added with [`Pdf::push`].
    pub fn blank(width: f32, height: f32) -> Page {
        Page {
            width,
            height,
            ..Default::default()
        }
    }

    /// Draws `text` with its baseline at (x, y).
    pub fn text(&mut self, font: &FontRef, size: f32, x: f32, y: f32, text: &str, color: Rgb) {
        let mut hex = String::new();
        for c in text.chars() {
            let (id, _) = font.font.glyph(c);
            hex.push_str(&format!("{id:04X}"));
        }
        self.fonts.insert(font.index);
        self.ops.push_str(&format!(
            "BT {} {} {} rg /F{} {} Tf {} {} Td <{hex}> Tj ET\n",
            num(color.0),
            num(color.1),
            num(color.2),
            font.index,
            num(size),
            num(x),
            num(y)
        ));
    }

    pub fn rect(&mut self, x: f32, y: f32, w: f32, h: f32, fill: Rgb) {
        self.ops.push_str(&format!(
            "{} {} {} rg {} {} {} {} re f\n",
            num(fill.0),
            num(fill.1),
            num(fill.2),
            num(x),
            num(y),
            num(w),
            num(h)
        ));
    }

    pub fn stroke_rect(&mut self, x: f32, y: f32, w: f32, h: f32, width: f32, color: Rgb) {
        self.ops.push_str(&format!(
            "{} {} {} RG {} w {} {} {} {} re S\n",
            num(color.0),
            num(color.1),
            num(color.2),
            num(width),
            num(x),
            num(y),
            num(w),
            num(h)
        ));
    }

    pub fn line(&mut self, x1: f32, y1: f32, x2: f32, y2: f32, width: f32, color: Rgb) {
        self.ops.push_str(&format!(
            "{} {} {} RG {} w {} {} m {} {} l S\n",
            num(color.0),
            num(color.1),
            num(color.2),
            num(width),
            num(x1),
            num(y1),
            num(x2),
            num(y2)
        ));
    }

    /// A polyline through `points`.
    pub fn polyline(&mut self, points: &[(f32, f32)], width: f32, color: Rgb) {
        if points.len() < 2 {
            return;
        }
        self.ops.push_str(&format!(
            "{} {} {} RG {} w 1 J 1 j ",
            num(color.0),
            num(color.1),
            num(color.2),
            num(width)
        ));
        for (i, (x, y)) in points.iter().enumerate() {
            self.ops.push_str(&format!(
                "{} {} {} ",
                num(*x),
                num(*y),
                if i == 0 { "m" } else { "l" }
            ));
        }
        self.ops.push_str("S\n");
    }

    pub fn circle(&mut self, cx: f32, cy: f32, r: f32, fill: Rgb) {
        // Four Bézier arcs.
        let k = 0.5523 * r;
        self.ops.push_str(&format!(
            "{} {} {} rg {} {} m {} {} {} {} {} {} c {} {} {} {} {} {} c {} {} {} {} {} {} c {} {} {} {} {} {} c f\n",
            num(fill.0), num(fill.1), num(fill.2),
            num(cx + r), num(cy),
            num(cx + r), num(cy + k), num(cx + k), num(cy + r), num(cx), num(cy + r),
            num(cx - k), num(cy + r), num(cx - r), num(cy + k), num(cx - r), num(cy),
            num(cx - r), num(cy - k), num(cx - k), num(cy - r), num(cx), num(cy - r),
            num(cx + k), num(cy - r), num(cx + r), num(cy - k), num(cx + r), num(cy)
        ));
    }

    /// Draws an image into the rectangle.
    pub fn image(&mut self, image: &ImageRef, x: f32, y: f32, w: f32, h: f32) {
        self.images.insert(image.index);
        self.ops.push_str(&format!(
            "q {} 0 0 {} {} {} cm /Im{} Do Q\n",
            num(w),
            num(h),
            num(x),
            num(y),
            image.index
        ));
    }

    /// Draws an image scaled to (dw, dh) at (dx, dy), clipped to the frame.
    #[allow(clippy::too_many_arguments)]
    pub fn image_clipped(
        &mut self,
        image: &ImageRef,
        frame: (f32, f32, f32, f32),
        dx: f32,
        dy: f32,
        dw: f32,
        dh: f32,
    ) {
        self.images.insert(image.index);
        self.ops.push_str(&format!(
            "q {} {} {} {} re W n {} 0 0 {} {} {} cm /Im{} Do Q\n",
            num(frame.0),
            num(frame.1),
            num(frame.2),
            num(frame.3),
            num(dw),
            num(dh),
            num(dx),
            num(dy),
            image.index
        ));
    }

    /// A QR code with a quiet zone, `size` wide, top left at (x, top).
    pub fn qr(&mut self, data: &str, x: f32, top: f32, size: f32) -> bool {
        let Ok(code) = qrcode::QrCode::new(data.as_bytes()) else {
            return false;
        };
        let width = code.width();
        let colors = code.to_colors();
        self.rect(x, top - size, size, size, Rgb::WHITE);
        let quiet = 2.0;
        let cell = size / (width as f32 + 2.0 * quiet);
        for row in 0..width {
            for col in 0..width {
                if colors[row * width + col] == qrcode::Color::Dark {
                    let cx = x + (col as f32 + quiet) * cell;
                    let cy = top - (row as f32 + quiet + 1.0) * cell;
                    self.rect(cx, cy, cell + 0.05, cell + 0.05, Rgb::BLACK);
                }
            }
        }
        true
    }

    /// A Code128 barcode, `w` wide and `h` high, top left at (x, top).
    pub fn code128(&mut self, value: &str, x: f32, top: f32, w: f32, h: f32) -> bool {
        let Ok(code) = barcoders::sym::code128::Code128::new(format!("\u{0181}{value}")) else {
            return false;
        };
        let bits = code.encode();
        let quiet = 8.0;
        let bar = (w - 2.0 * quiet) / bits.len() as f32;
        self.rect(x, top - h, w, h, Rgb::WHITE);
        for (i, bit) in bits.iter().enumerate() {
            if *bit == 1 {
                self.rect(
                    x + quiet + i as f32 * bar,
                    top - h,
                    bar + 0.05,
                    h,
                    Rgb::BLACK,
                );
            }
        }
        true
    }
}

/// A font added to a document.
#[derive(Debug, Clone)]
pub struct FontRef {
    index: usize,
    pub font: Font,
}

/// An image added to a document.
#[derive(Debug, Clone, Copy)]
pub struct ImageRef {
    index: usize,
    pub width: u32,
    pub height: u32,
}

/// A document under construction.
#[derive(Debug, Default)]
pub struct Pdf {
    title: String,
    fonts: Vec<Font>,
    images: Vec<(u32, u32, Vec<u8>)>,
    pub pages: Vec<Page>,
}

impl Pdf {
    pub fn new(title: &str) -> Pdf {
        Pdf {
            title: title.to_string(),
            ..Default::default()
        }
    }

    pub fn add_font(&mut self, font: &Font) -> FontRef {
        self.fonts.push(font.clone());
        FontRef {
            index: self.fonts.len(),
            font: font.clone(),
        }
    }

    /// Adds a JPEG; anything else is re-encoded as one.
    pub fn add_image(&mut self, bytes: &[u8]) -> Result<ImageRef> {
        let reader = image::ImageReader::new(std::io::Cursor::new(bytes))
            .with_guessed_format()
            .map_err(|e| Error::Invalid(format!("image: {e}")))?;
        let is_jpeg = reader.format() == Some(image::ImageFormat::Jpeg);
        let decoded = reader
            .decode()
            .map_err(|e| Error::Invalid(format!("image: {e}")))?;
        let (w, h) = (decoded.width(), decoded.height());
        let jpeg = if is_jpeg {
            bytes.to_vec()
        } else {
            let mut out = Vec::new();
            let encoder = image::codecs::jpeg::JpegEncoder::new_with_quality(&mut out, 85);
            decoded
                .to_rgb8()
                .write_with_encoder(encoder)
                .map_err(|e| Error::Invalid(format!("image: {e}")))?;
            out
        };
        self.images.push((w, h, jpeg));
        Ok(ImageRef {
            index: self.images.len(),
            width: w,
            height: h,
        })
    }

    /// Starts a page, A4 unless told otherwise.
    pub fn page(&mut self, width: f32, height: f32) -> &mut Page {
        self.pages.push(Page {
            width,
            height,
            ..Default::default()
        });
        self.pages.last_mut().expect("just pushed")
    }

    /// The finished file.
    pub fn save(&self) -> Vec<u8> {
        let mut objects: Vec<Vec<u8>> = Vec::new();
        let mut add = |body: Vec<u8>| -> usize {
            objects.push(body);
            objects.len()
        };
        // 1 catalog, 2 pages, 3 info: reserved and filled at the end.
        add(Vec::new());
        add(Vec::new());
        add(Vec::new());
        // Fonts.
        let mut font_ids = Vec::new();
        for font in &self.fonts {
            let compressed = deflate(&font.data);
            let file = add(stream(
                &format!("/Length1 {} /Filter /FlateDecode", font.data.len()),
                &compressed,
            ));
            let descriptor = add(format!(
                "<< /Type /FontDescriptor /FontName /{} /Flags 32 /FontBBox [{} {} {} {}] /ItalicAngle 0 /Ascent {} /Descent {} /CapHeight {} /StemV 80 /FontFile2 {} 0 R >>",
                font_name(&font.name),
                font.scaled(font.bbox[0]),
                font.scaled(font.bbox[1]),
                font.scaled(font.bbox[2]),
                font.scaled(font.bbox[3]),
                font.scaled(font.ascender),
                font.scaled(font.descender),
                font.scaled(font.cap_height),
                file
            ).into_bytes());
            let glyphs = font.glyphs.lock().map(|m| m.clone()).unwrap_or_default();
            let mut widths = String::new();
            let mut to_unicode = String::new();
            for (c, (id, advance)) in glyphs.iter() {
                widths.push_str(&format!(
                    "{id} [{}] ",
                    (*advance as f32 * 1000.0 / font.units_per_em).round() as i32
                ));
                let mut utf16 = [0u16; 2];
                let units = c.encode_utf16(&mut utf16);
                let dst: String = units.iter().map(|u| format!("{u:04X}")).collect();
                to_unicode.push_str(&format!("<{id:04X}> <{dst}>\n"));
            }
            let cid = add(format!(
                "<< /Type /Font /Subtype /CIDFontType2 /BaseFont /{} /CIDSystemInfo << /Registry (Adobe) /Ordering (Identity) /Supplement 0 >> /FontDescriptor {} 0 R /DW 1000 /W [{}] /CIDToGIDMap /Identity >>",
                font_name(&font.name),
                descriptor,
                widths.trim_end()
            ).into_bytes());
            let cmap = format!(
                "/CIDInit /ProcSet findresource begin\n12 dict begin\nbegincmap\n/CIDSystemInfo << /Registry (Adobe) /Ordering (UCS) /Supplement 0 >> def\n/CMapName /Adobe-Identity-UCS def\n/CMapType 2 def\n1 begincodespacerange\n<0000> <FFFF>\nendcodespacerange\n{} beginbfchar\n{}endbfchar\nendcmap\nCMapName currentdict /CMap defineresource pop\nend\nend\n",
                glyphs.len(),
                to_unicode
            );
            let unicode = add(stream("", cmap.as_bytes()));
            let type0 = add(format!(
                "<< /Type /Font /Subtype /Type0 /BaseFont /{} /Encoding /Identity-H /DescendantFonts [{} 0 R] /ToUnicode {} 0 R >>",
                font_name(&font.name),
                cid,
                unicode
            ).into_bytes());
            font_ids.push(type0);
        }
        // Images.
        let mut image_ids = Vec::new();
        for (w, h, jpeg) in &self.images {
            let id = add(stream(
                &format!(
                    "/Type /XObject /Subtype /Image /Width {w} /Height {h} /ColorSpace /DeviceRGB /BitsPerComponent 8 /Filter /DCTDecode"
                ),
                jpeg,
            ));
            image_ids.push(id);
        }
        // Pages.
        let mut page_ids = Vec::new();
        for page in &self.pages {
            let content = add(stream(
                "/Filter /FlateDecode",
                &deflate(page.ops.as_bytes()),
            ));
            let mut resources = String::from("<< /Font << ");
            for f in &page.fonts {
                resources.push_str(&format!("/F{} {} 0 R ", f, font_ids[f - 1]));
            }
            resources.push_str(">> /XObject << ");
            for i in &page.images {
                resources.push_str(&format!("/Im{} {} 0 R ", i, image_ids[i - 1]));
            }
            resources.push_str(">> >>");
            let id = add(format!(
                "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 {} {}] /Resources {} /Contents {} 0 R >>",
                num(page.width),
                num(page.height),
                resources,
                content
            ).into_bytes());
            page_ids.push(id);
        }
        let kids: Vec<String> = page_ids.iter().map(|id| format!("{id} 0 R")).collect();
        objects[1] = format!(
            "<< /Type /Pages /Kids [{}] /Count {} >>",
            kids.join(" "),
            page_ids.len()
        )
        .into_bytes();
        objects[0] = b"<< /Type /Catalog /Pages 2 0 R >>".to_vec();
        objects[2] = format!(
            "<< /Title ({}) /Producer (cat\\(a\\)log) >>",
            escape_literal(&self.title)
        )
        .into_bytes();
        // Serialise.
        let mut out: Vec<u8> = Vec::new();
        out.extend_from_slice(b"%PDF-1.4\n%\xE2\xE3\xCF\xD3\n");
        let mut offsets = Vec::new();
        for (i, body) in objects.iter().enumerate() {
            offsets.push(out.len());
            out.extend_from_slice(format!("{} 0 obj\n", i + 1).as_bytes());
            out.extend_from_slice(body);
            out.extend_from_slice(b"\nendobj\n");
        }
        let xref = out.len();
        out.extend_from_slice(
            format!("xref\n0 {}\n0000000000 65535 f \n", objects.len() + 1).as_bytes(),
        );
        for offset in offsets {
            out.extend_from_slice(format!("{offset:010} 00000 n \n").as_bytes());
        }
        out.extend_from_slice(
            format!(
                "trailer\n<< /Size {} /Root 1 0 R /Info 3 0 R >>\nstartxref\n{xref}\n%%EOF\n",
                objects.len() + 1
            )
            .as_bytes(),
        );
        out
    }
}

fn font_name(name: &str) -> String {
    name.chars()
        .filter(|c| c.is_ascii_alphanumeric() || *c == '-')
        .collect()
}

fn escape_literal(text: &str) -> String {
    text.chars()
        .filter(|c| c.is_ascii() && !c.is_ascii_control())
        .map(|c| match c {
            '(' => "\\(".to_string(),
            ')' => "\\)".to_string(),
            '\\' => "\\\\".to_string(),
            c => c.to_string(),
        })
        .collect()
}

fn stream(dict: &str, bytes: &[u8]) -> Vec<u8> {
    let mut out = format!("<< {dict} /Length {} >>\nstream\n", bytes.len()).into_bytes();
    out.extend_from_slice(bytes);
    out.extend_from_slice(b"\nendstream");
    out
}

fn deflate(bytes: &[u8]) -> Vec<u8> {
    let mut encoder = flate2::write::ZlibEncoder::new(Vec::new(), flate2::Compression::default());
    let _ = encoder.write_all(bytes);
    encoder.finish().unwrap_or_default()
}

/// Splits `text` into lines no wider than `max_width` at `size`, on
/// spaces where possible.
pub fn wrap(font: &Font, size: f32, text: &str, max_width: f32) -> Vec<String> {
    let mut lines = Vec::new();
    for paragraph in text.split('\n') {
        let mut line = String::new();
        for word in paragraph.split(' ') {
            let candidate = if line.is_empty() {
                word.to_string()
            } else {
                format!("{line} {word}")
            };
            if font.width(&candidate, size) <= max_width || line.is_empty() {
                line = candidate;
            } else {
                lines.push(line);
                line = word.to_string();
            }
        }
        lines.push(line);
    }
    lines
}

/// The largest size at or below `size` at which `text` fits `max_width`.
pub fn fit_size(font: &Font, size: f32, text: &str, max_width: f32) -> f32 {
    let width = font.width(text, size);
    if width <= max_width || width == 0.0 {
        size
    } else {
        (size * max_width / width).max(4.0)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    pub(crate) fn noto() -> Font {
        Font::parse(crate::fonts::NOTO_SANS_REGULAR.to_vec(), "NotoSans-Regular").unwrap()
    }

    #[test]
    fn a_document_with_text_image_and_codes_parses_and_measures() {
        let font = noto();
        assert!(font.has('ä'));
        assert!(!font.has('日'));
        let w = font.width("Miezi", 12.0);
        assert!(w > 20.0 && w < 40.0, "{w}");
        assert!(font.ascent(12.0) > 8.0);
        let mut pdf = Pdf::new("Test (1)");
        let f = pdf.add_font(&font);
        let img = image::DynamicImage::new_rgb8(8, 6);
        let mut png = Vec::new();
        img.write_to(&mut std::io::Cursor::new(&mut png), image::ImageFormat::Png)
            .unwrap();
        let image = pdf.add_image(&png).unwrap();
        assert_eq!((image.width, image.height), (8, 6));
        assert!(pdf.add_image(b"junk").is_err());
        let page = pdf.page(A4.0, A4.1);
        page.text(&f, 24.0, 40.0, 780.0, "Miezi — Vermisst äöü", Rgb::BLACK);
        page.rect(40.0, 700.0, 200.0, 20.0, Rgb::gray(0.5));
        page.stroke_rect(40.0, 660.0, 200.0, 20.0, 1.0, Rgb::from_u32(0xE65A28));
        page.line(40.0, 640.0, 240.0, 640.0, 0.5, Rgb::BLACK);
        page.polyline(
            &[(40.0, 600.0), (100.0, 620.0), (160.0, 590.0)],
            1.5,
            Rgb::BLACK,
        );
        page.polyline(&[(40.0, 600.0)], 1.5, Rgb::BLACK);
        page.circle(50.0, 560.0, 4.0, Rgb::BLACK);
        page.image(&image, 300.0, 700.0, 80.0, 60.0);
        page.image_clipped(
            &image,
            (300.0, 600.0, 80.0, 60.0),
            280.0,
            580.0,
            120.0,
            90.0,
        );
        assert!(page.qr("catlog-share:d:AAAA", 40.0, 500.0, 100.0));
        assert!(page.code128("276098100", 160.0, 500.0, 180.0, 44.0));
        assert!(!page.code128("ä", 160.0, 400.0, 180.0, 44.0));
        pdf.page(A4.0, A4.1)
            .text(&f, 12.0, 40.0, 800.0, "Page two", Rgb::BLACK);
        let bytes = pdf.save();
        assert!(bytes.starts_with(b"%PDF-1.4"));
        let doc = lopdf::Document::load_mem(&bytes).expect("a viewer-grade file");
        assert_eq!(doc.get_pages().len(), 2);
        let mut type0 = 0;
        let mut files = 0;
        for object in doc.objects.values() {
            if let Ok(dict) = object.as_dict() {
                if dict.get(b"Subtype").and_then(|s| s.as_name()).ok() == Some(b"Type0") {
                    type0 += 1;
                }
                if dict.has(b"FontFile2") {
                    files += 1;
                }
            }
            if let Ok(stream) = object.as_stream()
                && stream.dict.has(b"Length1")
            {
                assert!(
                    stream.content.len() < font.data.len(),
                    "the font is deflated"
                );
            }
        }
        assert_eq!(type0, 1, "one embedded font");
        assert_eq!(files, 1);
        let info = doc.trailer.get(b"Info").unwrap().as_reference().unwrap();
        let title = doc
            .get_object(info)
            .unwrap()
            .as_dict()
            .unwrap()
            .get(b"Title")
            .unwrap();
        assert_eq!(title.as_str().unwrap(), b"Test (1)");
        // Wrapping and fitting.
        let lines = wrap(
            &font,
            12.0,
            "one two three four five six seven eight nine ten",
            100.0,
        );
        assert!(lines.len() >= 3);
        assert!(lines.iter().all(|l| font.width(l, 12.0) <= 100.0));
        assert_eq!(wrap(&font, 12.0, "a\nb", 100.0), vec!["a", "b"]);
        assert_eq!(fit_size(&font, 40.0, "x", 1000.0), 40.0);
        let small = fit_size(&font, 40.0, "a very long line of text", 50.0);
        assert!(small < 40.0 && font.width("a very long line of text", small) <= 50.5);
        assert_eq!(fit_size(&font, 40.0, "", 50.0), 40.0);
        std::fs::write(
            std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../target/pdf_smoke.pdf"),
            &bytes,
        )
        .ok();
    }
}
