//! Photos as textures: decoded once per content hash and kept for the
//! window's lifetime. A photo that will not decode shows as nothing.

use std::collections::HashMap;

use catlog_core::{Catalog, keys};
use egui::{Color32, ColorImage, Context, Pos2, Rect, TextureHandle, TextureOptions, Ui};

/// True when the cat's deceased date is set.
pub fn is_deceased(store: &Catalog, cat: &str) -> bool {
    store
        .current(cat, &keys::user_field("deceased"))
        .ok()
        .flatten()
        .is_some_and(|d| !d.is_empty())
}

/// The Trauerflor: a black band across the lower right of a round
/// portrait, the sign on the framed picture of one who died. Drawn over
/// the face of a deceased cat wherever it stands for the cat, photo or
/// placeholder; never over the other photos. The band is a fifth of the
/// face deep, at 45°, and ends at the rim.
pub fn mourning_band(ui: &Ui, face: Rect) {
    let r = face.width().min(face.height()) / 2.0;
    let centre = face.center();
    let depth = r * 0.4;
    // The chord where the band begins: its distance from the centre.
    let inner = r - depth;
    let half = (r * r - inner * inner).sqrt();
    let along = egui::vec2(1.0, -1.0) / 2f32.sqrt();
    let toward = egui::vec2(1.0, 1.0) / 2f32.sqrt();
    let foot = centre + toward * inner;
    let a = foot + along * half;
    let b = foot - along * half;
    let mut points = vec![b, a];
    // The rim from a to b, the way through the corner.
    let angle = |p: Pos2| (p.y - centre.y).atan2(p.x - centre.x);
    let (from, to) = (angle(a), angle(b));
    let steps = 12;
    for i in 1..steps {
        let t = from + (to - from) * i as f32 / steps as f32;
        points.push(centre + egui::vec2(t.cos(), t.sin()) * r);
    }
    ui.painter().add(egui::Shape::convex_polygon(
        points,
        Color32::BLACK,
        egui::Stroke::NONE,
    ));
}

/// The band on `face` when `cat` is deceased.
pub fn band_if_deceased(ui: &Ui, store: &Catalog, cat: &str, face: Rect) {
    if is_deceased(store, cat) {
        mourning_band(ui, face);
    }
}

#[derive(Default)]
pub struct FaceCache {
    textures: HashMap<String, Option<TextureHandle>>,
}

impl FaceCache {
    /// The texture of a stored photo, loaded on first use; none when the
    /// Catalog has no bytes for the hash or they will not decode.
    pub fn face(&mut self, ctx: &Context, store: &Catalog, hash: &str) -> Option<TextureHandle> {
        if let Some(cached) = self.textures.get(hash) {
            return cached.clone();
        }
        let texture = store
            .image_bytes(hash)
            .and_then(|bytes| decode(&bytes))
            .map(|img| ctx.load_texture(format!("photo-{hash}"), img, TextureOptions::LINEAR));
        self.textures.insert(hash.to_string(), texture.clone());
        texture
    }

    /// Forgets a photo, for when its bytes changed or went.
    pub fn forget(&mut self, hash: &str) {
        self.textures.remove(hash);
    }

    pub fn len(&self) -> usize {
        self.textures.len()
    }

    pub fn is_empty(&self) -> bool {
        self.textures.is_empty()
    }
}

/// A photo's bytes as egui's pixels; none when they are no image.
pub fn decode(bytes: &[u8]) -> Option<ColorImage> {
    let img = image::load_from_memory(bytes).ok()?.to_rgba8();
    let size = [img.width() as usize, img.height() as usize];
    Some(ColorImage::from_rgba_unmultiplied(size, img.as_raw()))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn photos_decode_once_and_junk_decodes_to_nothing() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let png = {
            let img = image::DynamicImage::new_rgb8(4, 4);
            let mut out = Vec::new();
            img.write_to(&mut std::io::Cursor::new(&mut out), image::ImageFormat::Png)
                .unwrap();
            out
        };
        let good = store.add_image("cat:a", &png).unwrap();
        let junk = store.add_image("cat:a", b"not a picture").unwrap();
        let ctx = Context::default();
        let mut cache = FaceCache::default();
        assert!(cache.is_empty());
        assert!(cache.face(&ctx, &store, &good).is_some());
        assert!(cache.face(&ctx, &store, &good).is_some());
        assert!(cache.face(&ctx, &store, &junk).is_none());
        assert!(cache.face(&ctx, &store, "0".repeat(64).as_str()).is_none());
        assert_eq!(cache.len(), 3);
        cache.forget(&good);
        assert_eq!(cache.len(), 2);
    }
}
