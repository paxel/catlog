//! Photos as textures: decoded once per content hash and kept for the
//! window's lifetime. A photo that will not decode shows as nothing.

use std::collections::HashMap;

use catlog_core::Catalog;
use egui::{ColorImage, Context, TextureHandle, TextureOptions};

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
