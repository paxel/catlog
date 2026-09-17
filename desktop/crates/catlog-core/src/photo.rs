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

impl Catalog {
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
}
