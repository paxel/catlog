//! Photos: what the store keeps and what travels. Every stored photo is
//! a JPEG scaled to at most [`MAX_IMAGE_EDGE`] on its longest side and
//! stripped of its metadata, so where a picture was taken never reaches
//! the shared folder, and every device that strips the same file gets
//! the same bytes.

use std::io::Cursor;

use image::codecs::jpeg::JpegEncoder;
use image::{DynamicImage, ImageDecoder, ImageReader};
use sha2::{Digest, Sha256};

use crate::Result;
use crate::catalog::Catalog;
use crate::error::Error;
use crate::keys;

/// Longest edge an imported photo keeps; larger photos are scaled down.
pub const MAX_IMAGE_EDGE: u32 = 2560;

/// More pixels than this and an image is refused before it is decoded.
pub const MAX_IMAGE_PIXELS: u64 = 40 * 1000 * 1000;

/// `jpeg` without its APP1..APP15 and COM segments (Exif, XMP, ICC,
/// comments). The picture data is untouched: no re-encoding. Bytes that
/// are not a JPEG come back as they are.
pub fn strip_jpeg_metadata(jpeg: &[u8]) -> Vec<u8> {
    if jpeg.len() < 4 || jpeg[0] != 0xFF || jpeg[1] != 0xD8 {
        return jpeg.to_vec();
    }
    let mut out = vec![0xFF, 0xD8];
    let mut i = 2;
    let mut changed = false;
    while i + 4 <= jpeg.len() && jpeg[i] == 0xFF {
        let marker = jpeg[i + 1];
        if marker == 0xD9 || marker == 0xDA {
            break;
        }
        if marker == 0xFF {
            i += 1;
            continue;
        }
        if (0xD0..=0xD7).contains(&marker) {
            out.extend_from_slice(&jpeg[i..i + 2]);
            i += 2;
            continue;
        }
        let length = ((jpeg[i + 2] as usize) << 8) | jpeg[i + 3] as usize;
        let end = i + 2 + length;
        if end > jpeg.len() {
            return jpeg.to_vec();
        }
        let drop = (0xE1..=0xEF).contains(&marker) || marker == 0xFE;
        if drop {
            changed = true;
        } else {
            out.extend_from_slice(&jpeg[i..end]);
        }
        i = end;
    }
    if !changed {
        return jpeg.to_vec();
    }
    out.extend_from_slice(&jpeg[i..]);
    out
}

/// True when `jpeg` still carries a segment [`strip_jpeg_metadata`] drops.
pub fn has_jpeg_metadata(jpeg: &[u8]) -> bool {
    strip_jpeg_metadata(jpeg) != jpeg
}

/// True when `bytes` declare more than [`MAX_IMAGE_PIXELS`] in their
/// header; false for anything decodable within bounds, and for bytes no
/// decoder recognises.
pub fn image_too_large(bytes: &[u8]) -> bool {
    let Ok(reader) = ImageReader::new(Cursor::new(bytes)).with_guessed_format() else {
        return false;
    };
    match reader.into_dimensions() {
        Ok((w, h)) => w as u64 * h as u64 > MAX_IMAGE_PIXELS,
        Err(_) => false,
    }
}

/// Re-encodes a photo as JPEG, scaled to [`MAX_IMAGE_EDGE`], with the
/// camera's orientation baked in and no metadata left.
pub fn compress_image(bytes: &[u8]) -> Result<Vec<u8>> {
    if image_too_large(bytes) {
        return Err(Error::Invalid("Image too large".into()));
    }
    let reader = ImageReader::new(Cursor::new(bytes))
        .with_guessed_format()
        .map_err(|e| Error::Invalid(format!("Not a decodable image: {e}")))?;
    let mut decoder = reader
        .into_decoder()
        .map_err(|e| Error::Invalid(format!("Not a decodable image: {e}")))?;
    let orientation = decoder.orientation().ok();
    let mut decoded = DynamicImage::from_decoder(decoder)
        .map_err(|e| Error::Invalid(format!("Not a decodable image: {e}")))?;
    if let Some(orientation) = orientation {
        decoded.apply_orientation(orientation);
    }
    let edge = decoded.width().max(decoded.height());
    if edge > MAX_IMAGE_EDGE {
        let scale = MAX_IMAGE_EDGE as f64 / edge as f64;
        let w = (decoded.width() as f64 * scale).round() as u32;
        let h = (decoded.height() as f64 * scale).round() as u32;
        decoded = decoded.resize_exact(w.max(1), h.max(1), image::imageops::FilterType::Triangle);
    }
    let mut out = Vec::new();
    let encoder = JpegEncoder::new_with_quality(&mut out, 85);
    decoded
        .to_rgb8()
        .write_with_encoder(encoder)
        .map_err(|e| Error::Invalid(format!("JPEG: {e}")))?;
    Ok(strip_jpeg_metadata(&out))
}

/// Cuts a fractional rectangle (0..1 coordinates) out of a photo: the
/// Crop operation. The result is a new JPEG; the original stays.
pub fn crop_image(bytes: &[u8], x: f64, y: f64, w: f64, h: f64) -> Result<Vec<u8>> {
    let decoded = decode(bytes)?;
    let (width, height) = (decoded.width(), decoded.height());
    let px = (x.clamp(0.0, 1.0) * width as f64).round() as u32;
    let py = (y.clamp(0.0, 1.0) * height as f64).round() as u32;
    let pw = (w.clamp(0.0, 1.0) * width as f64).round() as u32;
    let ph = (h.clamp(0.0, 1.0) * height as f64).round() as u32;
    if pw < 8 || ph < 8 {
        return Err(Error::Invalid("Crop rectangle too small".into()));
    }
    let px = px.min(width - 1);
    let py = py.min(height - 1);
    let cropped = decoded.crop_imm(
        px,
        py,
        pw.min(width - px).max(1),
        ph.min(height - py).max(1),
    );
    encode(&cropped)
}

/// Bakes a highlight ellipse into a copy of a photo: the Mark operation.
/// Centre and radii are 0..1 fractions of the picture. A white casing
/// under an orange stroke keeps the mark visible on any background.
pub fn mark_image(bytes: &[u8], cx: f64, cy: f64, rx: f64, ry: f64) -> Result<Vec<u8>> {
    let mut decoded = decode(bytes)?.to_rgb8();
    let (width, height) = (decoded.width(), decoded.height());
    let centre = (cx * width as f64, cy * height as f64);
    let radius = ((rx * width as f64).abs(), (ry * height as f64).abs());
    if radius.0 < 4.0 || radius.1 < 4.0 {
        return Err(Error::Invalid("Mark ellipse too small".into()));
    }
    let thickness = (width.max(height) / 150 + 3) as f64;
    const SEGMENTS: usize = 90;
    for (color, t) in [
        (image::Rgb([255, 255, 255]), thickness + 4.0),
        (image::Rgb([230, 90, 40]), thickness),
    ] {
        for i in 0..SEGMENTS {
            let a1 = std::f64::consts::TAU * i as f64 / SEGMENTS as f64;
            let a2 = std::f64::consts::TAU * (i + 1) as f64 / SEGMENTS as f64;
            let p1 = (
                centre.0 + radius.0 * a1.cos(),
                centre.1 + radius.1 * a1.sin(),
            );
            let p2 = (
                centre.0 + radius.0 * a2.cos(),
                centre.1 + radius.1 * a2.sin(),
            );
            thick_line(&mut decoded, p1, p2, t, color);
        }
    }
    encode(&DynamicImage::ImageRgb8(decoded))
}

fn decode(bytes: &[u8]) -> Result<DynamicImage> {
    image::load_from_memory(bytes)
        .map_err(|e| Error::Invalid(format!("Not a decodable image: {e}")))
}

/// JPEG at quality 85 with no metadata, as every stored photo is.
fn encode(img: &DynamicImage) -> Result<Vec<u8>> {
    let mut out = Vec::new();
    let encoder = JpegEncoder::new_with_quality(&mut out, 85);
    img.to_rgb8()
        .write_with_encoder(encoder)
        .map_err(|e| Error::Invalid(format!("JPEG: {e}")))?;
    Ok(strip_jpeg_metadata(&out))
}

/// A line of the given thickness: a disc stamped along it.
fn thick_line(
    img: &mut image::RgbImage,
    from: (f64, f64),
    to: (f64, f64),
    thickness: f64,
    color: image::Rgb<u8>,
) {
    let (dx, dy) = (to.0 - from.0, to.1 - from.1);
    let steps = (dx.abs().max(dy.abs()).ceil() as usize).max(1);
    let r = thickness / 2.0;
    for s in 0..=steps {
        let f = s as f64 / steps as f64;
        let (x, y) = (from.0 + dx * f, from.1 + dy * f);
        let (x0, x1) = ((x - r).floor() as i64, (x + r).ceil() as i64);
        let (y0, y1) = ((y - r).floor() as i64, (y + r).ceil() as i64);
        for py in y0..=y1 {
            for px in x0..=x1 {
                let inside = (px as f64 + 0.5 - x).powi(2) + (py as f64 + 0.5 - y).powi(2) <= r * r;
                if inside
                    && px >= 0
                    && py >= 0
                    && (px as u32) < img.width()
                    && (py as u32) < img.height()
                {
                    img.put_pixel(px as u32, py as u32, color);
                }
            }
        }
    }
}

impl Catalog {
    /// Compresses a raw picture as the phone does and stores it as a new
    /// photo of the entity. Returns the content hash.
    pub fn add_photo(&mut self, entity: &str, raw: &[u8]) -> Result<String> {
        let jpeg = compress_image(raw)?;
        self.add_image(entity, &jpeg)
    }

    /// Rewrites every stored photo that still carries metadata: the
    /// stripped bytes become a new photo under their own hash, the old
    /// one is marked deleted, a profile picture follows. Returns how many
    /// photos were rewritten.
    pub fn strip_photo_locations(&mut self) -> Result<usize> {
        let mut rewritten = 0;
        let entities: Vec<String> = self
            .cats(None)?
            .into_iter()
            .chain(self.clowders()?)
            .map(|v| v.id)
            .collect();
        for entity in entities {
            for hash in self.images(&entity)? {
                let Some(bytes) = self.image_bytes(&hash) else {
                    continue;
                };
                let clean = strip_jpeg_metadata(&bytes);
                if clean == bytes {
                    continue;
                }
                let new_hash = hex::encode(Sha256::digest(&clean));
                if self.image_bytes(&new_hash).is_none() {
                    self.put_blob(&new_hash, &clean)?;
                }
                let was_profile = self.profile_image(&entity)?.as_deref() == Some(hash.as_str());
                let private = self.is_field_private(&entity, &keys::image(&hash))?;
                self.append(&entity, &keys::image(&new_hash), Some("added"))?;
                if private {
                    self.set_field_private(&entity, &keys::image(&new_hash), true)?;
                }
                self.delete_image(&entity, &hash)?;
                if was_profile {
                    self.set_profile_image(&entity, &new_hash)?;
                }
                rewritten += 1;
            }
        }
        Ok(rewritten)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// A JPEG with an Exif segment in front of its picture data.
    fn with_exif(jpeg: &[u8]) -> Vec<u8> {
        let mut out = vec![
            0xFF, 0xD8, 0xFF, 0xE1, 0x00, 0x08, b'E', b'x', b'i', b'f', 0, 0,
        ];
        out.extend_from_slice(&jpeg[2..]);
        out
    }

    /// A 1 by 1 PNG whose header claims a huge picture; the chunk CRC is
    /// recomputed so the decoder believes the header.
    fn huge_png() -> Vec<u8> {
        let mut huge = png(1, 1);
        huge[16..20].copy_from_slice(&30_000u32.to_be_bytes());
        huge[20..24].copy_from_slice(&30_000u32.to_be_bytes());
        let mut crc = 0xFFFF_FFFFu32;
        for &b in &huge[12..29] {
            crc ^= b as u32;
            for _ in 0..8 {
                crc = if crc & 1 == 1 {
                    (crc >> 1) ^ 0xEDB8_8320
                } else {
                    crc >> 1
                };
            }
        }
        huge[29..33].copy_from_slice(&(!crc).to_be_bytes());
        huge
    }

    fn png(w: u32, h: u32) -> Vec<u8> {
        let img = DynamicImage::new_rgb8(w, h);
        let mut out = Vec::new();
        img.write_to(&mut Cursor::new(&mut out), image::ImageFormat::Png)
            .unwrap();
        out
    }

    #[test]
    fn metadata_segments_are_dropped_and_the_picture_kept() {
        let jpeg = compress_image(&png(8, 6)).unwrap();
        assert!(!has_jpeg_metadata(&jpeg));
        let tagged = with_exif(&jpeg);
        assert!(has_jpeg_metadata(&tagged));
        assert_eq!(strip_jpeg_metadata(&tagged), jpeg);
        assert_eq!(strip_jpeg_metadata(b"not a jpeg"), b"not a jpeg");
        let truncated = &tagged[..6];
        assert_eq!(strip_jpeg_metadata(truncated), truncated);
        // Fill bytes and restart markers pass through.
        let mut odd = vec![0xFF, 0xD8, 0xFF, 0xFF, 0xD0, 0xFF, 0xFE, 0x00, 0x03, b'c'];
        odd.extend_from_slice(&jpeg[2..]);
        let stripped = strip_jpeg_metadata(&odd);
        assert!(stripped.len() < odd.len());
    }

    #[test]
    fn compression_scales_down_re_encodes_and_refuses_the_absurd() {
        let big = png(MAX_IMAGE_EDGE + 200, 100);
        let jpeg = compress_image(&big).unwrap();
        let (w, h) = ImageReader::new(Cursor::new(&jpeg))
            .with_guessed_format()
            .unwrap()
            .into_dimensions()
            .unwrap();
        assert_eq!(w, MAX_IMAGE_EDGE);
        assert!(h < 100);
        assert!(compress_image(b"garbage").is_err());
        assert!(!image_too_large(b"garbage"));
        assert!(!image_too_large(&big));
        // A header claiming a huge picture is refused before decoding.
        let huge = huge_png();
        assert!(image_too_large(&huge));
        assert!(compress_image(&huge).is_err());
    }

    #[test]
    fn stored_photos_with_metadata_are_rewritten_once() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open_with_device(dir.path(), "me").unwrap();
        c.set_author("Ada").unwrap();
        c.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let clean = compress_image(&png(4, 4)).unwrap();
        let tagged = with_exif(&clean);
        let old = c.add_image("cat:a", &tagged).unwrap();
        c.set_profile_image("cat:a", &old).unwrap();
        c.set_field_private("cat:a", &keys::image(&old), true)
            .unwrap();
        assert_eq!(c.strip_photo_locations().unwrap(), 1);
        assert_eq!(c.strip_photo_locations().unwrap(), 0);
        let images = c.images("cat:a").unwrap();
        assert_eq!(images.len(), 1);
        assert_ne!(images[0], old);
        assert_eq!(c.image_bytes(&images[0]).unwrap(), clean);
        assert_eq!(
            c.profile_image("cat:a").unwrap().as_deref(),
            Some(images[0].as_str())
        );
        assert!(
            c.is_field_private("cat:a", &keys::image(&images[0]))
                .unwrap()
        );
        assert!(c.image_bytes(&old).is_none());
        // A blob too large to be one of ours is not kept.
        let huge = huge_png();
        let hash = hex::encode(Sha256::digest(&huge));
        c.put_blob(&hash, &huge).unwrap();
        assert!(c.image_bytes(&hash).is_none());
    }

    #[test]
    fn crop_applies_the_fractional_rectangle_and_refuses_slivers() {
        let source = compress_image(&png(400, 200)).unwrap();
        let cropped = crop_image(&source, 0.25, 0.25, 0.5, 0.5).unwrap();
        let decoded = image::load_from_memory(&cropped).unwrap();
        assert_eq!((decoded.width(), decoded.height()), (200, 100));
        assert!(!has_jpeg_metadata(&cropped));
        // Clamped at the edge rather than failing.
        let edge = crop_image(&source, 0.9, 0.9, 0.5, 0.5).unwrap();
        let decoded = image::load_from_memory(&edge).unwrap();
        assert_eq!((decoded.width(), decoded.height()), (40, 20));
        assert!(crop_image(&source, 0.5, 0.5, 0.001, 0.001).is_err());
        assert!(crop_image(b"junk", 0.0, 0.0, 1.0, 1.0).is_err());
    }

    #[test]
    fn mark_bakes_visible_pixels_into_a_copy() {
        let source = compress_image(&png(300, 300)).unwrap();
        let marked = mark_image(&source, 0.5, 0.5, 0.25, 0.15).unwrap();
        assert_ne!(marked, source);
        let decoded = image::load_from_memory(&marked).unwrap().to_rgb8();
        assert_eq!((decoded.width(), decoded.height()), (300, 300));
        // A pixel on the ellipse's rightmost point is strongly orange.
        let p = decoded.get_pixel(150 + 75 - 1, 150);
        assert!(p[0] > 150, "orange stroke, got {p:?}");
        // The centre is untouched.
        assert_eq!(decoded.get_pixel(150, 150)[0], 0);
        assert!(mark_image(&source, 0.5, 0.5, 0.001, 0.001).is_err());
        assert!(mark_image(b"junk", 0.5, 0.5, 0.2, 0.2).is_err());
    }

    #[test]
    fn a_raw_picture_is_compressed_on_its_way_into_the_catalog() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let hash = store
            .add_photo("cat:a", &with_exif(&compress_image(&png(20, 10)).unwrap()))
            .unwrap();
        let stored = store.image_bytes(&hash).unwrap();
        assert!(!has_jpeg_metadata(&stored));
        assert_eq!(store.images("cat:a").unwrap(), vec![hash]);
        assert!(store.add_photo("cat:a", b"junk").is_err());
    }
}
