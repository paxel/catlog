//! The app icon: the index card with the cat face, from the asset every
//! platform ships, for the window, the taskbar and the pages that show it.

use egui::{ColorImage, Context, IconData, TextureHandle, TextureOptions};

static ICON_PNG: &[u8] = include_bytes!("../../../../assets/icon/icon.png");

fn decoded(size: u32) -> Option<image::RgbaImage> {
    let img = image::load_from_memory(ICON_PNG).ok()?;
    Some(
        img.resize_exact(size, size, image::imageops::FilterType::Triangle)
            .to_rgba8(),
    )
}

/// The window icon, 256 pixels.
pub fn window_icon() -> IconData {
    match decoded(256) {
        Some(img) => IconData {
            width: img.width(),
            height: img.height(),
            rgba: img.into_raw(),
        },
        None => IconData::default(),
    }
}

/// The icon as a texture, `size` pixels.
pub fn texture(ctx: &Context, size: u32) -> Option<TextureHandle> {
    let img = decoded(size)?;
    let color = ColorImage::from_rgba_unmultiplied(
        [img.width() as usize, img.height() as usize],
        img.as_raw(),
    );
    Some(ctx.load_texture(format!("app-icon-{size}"), color, TextureOptions::LINEAR))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_icon_decodes_at_the_sizes_the_window_and_pages_want() {
        let icon = window_icon();
        assert_eq!((icon.width, icon.height), (256, 256));
        assert_eq!(icon.rgba.len(), 256 * 256 * 4);
        let ctx = Context::default();
        assert!(texture(&ctx, 96).is_some());
    }
}
