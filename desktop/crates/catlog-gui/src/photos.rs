//! Photos on the desk: the viewer that shows one photo at a time, and
//! the editor that cuts a Cat out of a photo (Crop) or rings it (Mark).
//! Both are modal; both work in picture fractions, so the maths is the
//! phone's.

use catlog_core::Catalog;
use catlog_core::photo::{crop_image, mark_image};
use egui::{Color32, Context, Key, Pos2, Rect, Sense, Stroke, Vec2};

use crate::l10n::L10n;
use crate::textures::FaceCache;

/// What the viewer asked for this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ViewerAction {
    None,
    /// Save this photo's bytes to a file the keeper picks.
    Save(String),
}

/// The full-size viewer over a Cat's photos.
#[derive(Debug, Default)]
pub struct PhotoViewer {
    pub open: bool,
    pub hashes: Vec<String>,
    pub index: usize,
}

impl PhotoViewer {
    /// Opens the viewer on `hash` among `hashes`.
    pub fn open_at(&mut self, hashes: Vec<String>, hash: &str) {
        self.index = hashes.iter().position(|h| h == hash).unwrap_or(0);
        self.hashes = hashes;
        self.open = true;
    }

    /// Draws the viewer while it is open. Left and Right walk the
    /// photos, Escape closes.
    pub fn show(
        &mut self,
        ctx: &Context,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
    ) -> ViewerAction {
        if !self.open || self.hashes.is_empty() {
            self.open = false;
            return ViewerAction::None;
        }
        let mut action = ViewerAction::None;
        let mut close = false;
        let count = self.hashes.len();
        let (left, right, escape) = ctx.input(|i| {
            (
                i.key_pressed(Key::ArrowLeft),
                i.key_pressed(Key::ArrowRight),
                i.key_pressed(Key::Escape),
            )
        });
        if left {
            self.index = (self.index + count - 1) % count;
        }
        if right {
            self.index = (self.index + 1) % count;
        }
        let size = ctx.viewport_rect().size() - Vec2::new(80.0, 80.0);
        let modal = egui::Modal::new(egui::Id::new("photo-viewer")).show(ctx, |ui| {
            ui.set_width(size.x.max(200.0));
            ui.horizontal(|ui| {
                ui.heading(format!("{} / {count}", self.index + 1));
                if ui
                    .add_enabled(count > 1, egui::Button::new(t.previous_photo()))
                    .clicked()
                {
                    self.index = (self.index + count - 1) % count;
                }
                if ui
                    .add_enabled(count > 1, egui::Button::new(t.next_photo()))
                    .clicked()
                {
                    self.index = (self.index + 1) % count;
                }
                if ui.button(t.save_photo_as()).clicked() {
                    action = ViewerAction::Save(self.hashes[self.index].clone());
                }
                if ui.button(t.close()).clicked() {
                    close = true;
                }
            });
            let hash = self.hashes[self.index].clone();
            let area = Vec2::new(size.x.max(200.0), (size.y - 60.0).max(120.0));
            match faces.face(ui.ctx(), store, &hash) {
                Some(texture) => {
                    ui.add(
                        egui::Image::from_texture(&texture)
                            .max_size(area)
                            .shrink_to_fit(),
                    );
                }
                None => {
                    ui.allocate_ui(area, |ui| ui.label(t.photo_not_received()));
                }
            }
        });
        if close || escape || modal.should_close() {
            self.open = false;
        }
        action
    }
}

/// Which edit the editor makes.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum EditMode {
    Crop,
    Mark,
}

/// The Crop and Mark editor: a rectangle or an ellipse dragged over the
/// photo, then one verb. The edited copy joins the Cat as a new photo;
/// the original stays, one litter photo can serve many cats.
#[derive(Debug, Default)]
pub struct PhotoEditor {
    pub open: bool,
    pub mode: Option<EditMode>,
    pub cat: String,
    pub hash: String,
    bytes: Vec<u8>,
    /// The dragged corners, in picture fractions.
    pub selection: Option<(Vec2, Vec2)>,
    drag_from: Option<Vec2>,
}

impl PhotoEditor {
    /// Opens the editor on a stored photo; nothing happens when the bytes
    /// are not here.
    pub fn ask(&mut self, store: &Catalog, mode: EditMode, cat: &str, hash: &str) {
        let Some(bytes) = store.image_bytes(hash) else {
            return;
        };
        self.open = true;
        self.mode = Some(mode);
        self.cat = cat.to_string();
        self.hash = hash.to_string();
        self.bytes = bytes;
        self.selection = None;
        self.drag_from = None;
    }

    /// The selection as x, y, width, height fractions, normalised.
    pub fn rect(&self) -> Option<(f64, f64, f64, f64)> {
        let (a, b) = self.selection?;
        let x = a.x.min(b.x).clamp(0.0, 1.0) as f64;
        let y = a.y.min(b.y).clamp(0.0, 1.0) as f64;
        let w = a.x.max(b.x).clamp(0.0, 1.0) as f64 - x;
        let h = a.y.max(b.y).clamp(0.0, 1.0) as f64 - y;
        (w > 0.0 && h > 0.0).then_some((x, y, w, h))
    }

    /// The edited bytes, computed from the selection; an error when the
    /// selection is too small or the photo will not decode.
    pub fn apply(&self) -> catlog_core::Result<Vec<u8>> {
        let (x, y, w, h) = self
            .rect()
            .ok_or_else(|| catlog_core::Error::Invalid("Nothing selected".into()))?;
        match self.mode {
            Some(EditMode::Mark) => {
                mark_image(&self.bytes, x + w / 2.0, y + h / 2.0, w / 2.0, h / 2.0)
            }
            _ => crop_image(&self.bytes, x, y, w, h),
        }
    }

    /// Draws the editor while it is open; the Cat and the new photo's
    /// bytes when the verb was clicked, an error message when the edit
    /// failed.
    pub fn show(
        &mut self,
        ctx: &Context,
        store: &Catalog,
        t: &L10n,
        faces: &mut FaceCache,
    ) -> Option<Result<(String, Vec<u8>), String>> {
        if !self.open {
            return None;
        }
        let mode = self.mode.unwrap_or(EditMode::Crop);
        let (title, hint, verb) = match mode {
            EditMode::Crop => (t.crop_title(), t.drag_to_select(), t.apply_crop()),
            EditMode::Mark => (t.mark_title(), t.drag_over_the_cat(), t.mark_done()),
        };
        let mut result = None;
        let mut close = false;
        let size = ctx.viewport_rect().size() - Vec2::new(80.0, 80.0);
        let modal = egui::Modal::new(egui::Id::new("photo-editor")).show(ctx, |ui| {
            ui.set_width(size.x.max(200.0));
            ui.heading(title);
            ui.label(hint);
            let area = Vec2::new(size.x.max(200.0), (size.y - 90.0).max(120.0));
            if let Some(texture) = faces.face(ui.ctx(), store, &self.hash) {
                // Enlarged when small: a tiny photo still takes a drag.
                let fitted = fit(texture.size_vec2(), area, true);
                let (rect, response) = ui.allocate_exact_size(fitted, Sense::click_and_drag());
                egui::Image::from_texture(&texture).paint_at(ui, rect);
                let fraction = |pos: Pos2| {
                    Vec2::new(
                        ((pos.x - rect.min.x) / rect.width()).clamp(0.0, 1.0),
                        ((pos.y - rect.min.y) / rect.height()).clamp(0.0, 1.0),
                    )
                };
                // The drag starts where the button went down, which may
                // be a few pixels behind the pointer by the time egui
                // calls it a drag.
                if response.drag_started()
                    && let Some(pos) = ui
                        .input(|i| i.pointer.press_origin())
                        .or(response.interact_pointer_pos())
                {
                    self.drag_from = Some(fraction(pos));
                }
                if response.dragged()
                    && let (Some(from), Some(pos)) =
                        (self.drag_from, response.interact_pointer_pos())
                {
                    self.selection = Some((from, fraction(pos)));
                }
                if response.drag_stopped() {
                    self.drag_from = None;
                }
                if let Some((x, y, w, h)) = self.rect() {
                    let shape = Rect::from_min_size(
                        rect.min + Vec2::new(x as f32 * rect.width(), y as f32 * rect.height()),
                        Vec2::new(w as f32 * rect.width(), h as f32 * rect.height()),
                    );
                    let painter = ui.painter();
                    for (width, color) in
                        [(6.0, Color32::WHITE), (3.0, Color32::from_rgb(230, 90, 40))]
                    {
                        let stroke = Stroke::new(width, color);
                        match mode {
                            EditMode::Crop => {
                                painter.rect_stroke(shape, 0.0, stroke, egui::StrokeKind::Middle);
                            }
                            EditMode::Mark => {
                                painter.add(egui::Shape::ellipse_stroke(
                                    shape.center(),
                                    shape.size() / 2.0,
                                    stroke,
                                ));
                            }
                        }
                    }
                }
            } else {
                ui.label(t.photo_not_received());
            }
            ui.horizontal(|ui| {
                if ui
                    .add_enabled(self.rect().is_some(), egui::Button::new(verb))
                    .clicked()
                {
                    result = Some(
                        self.apply()
                            .map(|bytes| (self.cat.clone(), bytes))
                            .map_err(|e| e.to_string()),
                    );
                }
                if ui.button(t.cancel()).clicked() {
                    close = true;
                }
            });
        });
        let escape = ctx.input(|i| i.key_pressed(Key::Escape));
        if close || escape || modal.should_close() || matches!(result, Some(Ok(_))) {
            self.open = false;
        }
        result
    }
}

/// `size` scaled to fit inside `area`; enlarged only when asked.
fn fit(size: Vec2, area: Vec2, enlarge: bool) -> Vec2 {
    let mut scale = (area.x / size.x).min(area.y / size.y);
    if !enlarge {
        scale = scale.min(1.0);
    }
    size * scale
}

#[cfg(test)]
mod tests {
    use super::*;

    fn store_with_photo(dir: &std::path::Path) -> (Catalog, String) {
        let mut store = Catalog::open(dir).unwrap();
        store.set_author("Ada").unwrap();
        store.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        let img = image::DynamicImage::new_rgb8(400, 200);
        let mut out = Vec::new();
        img.write_to(&mut std::io::Cursor::new(&mut out), image::ImageFormat::Png)
            .unwrap();
        let hash = store.add_photo("cat:a", &out).unwrap();
        (store, hash)
    }

    #[test]
    fn the_editor_crops_and_marks_from_a_fractional_selection() {
        let dir = tempfile::tempdir().unwrap();
        let (store, hash) = store_with_photo(dir.path());
        let mut editor = PhotoEditor::default();
        editor.ask(&store, EditMode::Crop, "cat:a", &hash);
        assert!(editor.open);
        assert!(editor.apply().is_err(), "nothing selected yet");
        editor.selection = Some((Vec2::new(0.75, 0.75), Vec2::new(0.25, 0.25)));
        assert_eq!(editor.rect(), Some((0.25, 0.25, 0.5, 0.5)));
        let cropped = editor.apply().unwrap();
        let decoded = image::load_from_memory(&cropped).unwrap();
        assert_eq!((decoded.width(), decoded.height()), (200, 100));
        editor.ask(&store, EditMode::Mark, "cat:a", &hash);
        assert!(
            editor.selection.is_none(),
            "a fresh ask forgets the selection"
        );
        editor.selection = Some((Vec2::new(0.25, 0.25), Vec2::new(0.75, 0.75)));
        let marked = editor.apply().unwrap();
        let decoded = image::load_from_memory(&marked).unwrap();
        assert_eq!((decoded.width(), decoded.height()), (400, 200));
        assert_ne!(marked, cropped);
        // A photo whose bytes are gone cannot be edited.
        let mut other = PhotoEditor::default();
        other.ask(&store, EditMode::Crop, "cat:a", &"0".repeat(64));
        assert!(!other.open);
        // A zero-area selection is no selection.
        editor.selection = Some((Vec2::new(0.5, 0.5), Vec2::new(0.5, 0.9)));
        assert_eq!(editor.rect(), None);
    }

    #[test]
    fn fitting_enlarges_only_when_asked() {
        let area = Vec2::new(200.0, 200.0);
        assert_eq!(
            fit(Vec2::new(400.0, 200.0), area, false),
            Vec2::new(200.0, 100.0)
        );
        assert_eq!(
            fit(Vec2::new(40.0, 20.0), area, false),
            Vec2::new(40.0, 20.0)
        );
        assert_eq!(
            fit(Vec2::new(40.0, 20.0), area, true),
            Vec2::new(200.0, 100.0)
        );
    }

    #[test]
    fn the_viewer_opens_at_the_photo_and_wraps_around() {
        let mut viewer = PhotoViewer::default();
        viewer.open_at(vec!["a".into(), "b".into(), "c".into()], "b");
        assert!(viewer.open);
        assert_eq!(viewer.index, 1);
        viewer.open_at(vec!["a".into()], "zzz");
        assert_eq!(viewer.index, 0);
    }
}
