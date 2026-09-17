//! The desk's look: the phone's identity. Cream from the app icon, dark
//! ink, the cat's orange for actions and selection, a muted green for
//! what is done, round warm widgets. Light only. The fonts are Noto Sans
//! as on paper, the script fonts a language needs, and the icon font.

use egui::style::{Selection, WidgetVisuals, Widgets};
use egui::{
    Color32, Context, CornerRadius, FontDefinitions, FontFamily, Shadow, Stroke, Style, Visuals,
};

use catlog_core::fonts::FontSet;

/// The colours the desk draws with.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Palette {
    /// The window backdrop: the icon's cream.
    pub cream: Color32,
    /// Cards, windows and text fields: lighter than the backdrop.
    pub paper: Color32,
    /// Text.
    pub ink: Color32,
    /// Muted text and hairlines.
    pub grey: Color32,
    /// Actions and selection: the cat.
    pub orange: Color32,
    /// The pill a button rests in.
    pub tan: Color32,
    /// The pill under the pointer.
    pub peach: Color32,
    /// Done: ticks, finished, synced.
    pub green: Color32,
    /// Warnings and errors.
    pub red: Color32,
}

pub const PALETTE: Palette = Palette {
    cream: Color32::from_rgb(0xF6, 0xE7, 0xD3),
    paper: Color32::from_rgb(0xFF, 0xF9, 0xF2),
    ink: Color32::from_rgb(0x3A, 0x28, 0x1A),
    grey: Color32::from_rgb(0x9B, 0x8A, 0x78),
    orange: Color32::from_rgb(0xE8, 0x8A, 0x3A),
    tan: Color32::from_rgb(0xEC, 0xD6, 0xBC),
    peach: Color32::from_rgb(0xF7, 0xC5, 0x9F),
    green: Color32::from_rgb(0x5E, 0x9E, 0x5A),
    red: Color32::from_rgb(0xE0, 0x5A, 0x4E),
};

pub const ROUNDING: u8 = 8;

/// The visuals for the palette.
pub fn visuals(p: Palette) -> Visuals {
    let mut v = Visuals::light();
    v.override_text_color = None;
    v.panel_fill = p.cream;
    v.window_fill = p.paper;
    v.window_stroke = Stroke::new(1.0, p.tan);
    v.window_corner_radius = CornerRadius::same(12);
    v.window_shadow = Shadow {
        offset: [0, 6],
        blur: 18,
        spread: 0,
        color: Color32::from_black_alpha(40),
    };
    v.popup_shadow = Shadow {
        offset: [0, 4],
        blur: 12,
        spread: 0,
        color: Color32::from_black_alpha(30),
    };
    v.menu_corner_radius = CornerRadius::same(ROUNDING);
    v.extreme_bg_color = p.paper;
    v.faint_bg_color = p.tan;
    v.text_edit_bg_color = Some(p.paper);
    v.code_bg_color = p.tan;
    v.hyperlink_color = Color32::from_rgb(0xC9, 0x6F, 0x22);
    v.warn_fg_color = p.orange;
    v.error_fg_color = p.red;
    v.weak_text_color = Some(p.grey);
    v.selection = Selection {
        bg_fill: p.orange.gamma_multiply(0.35),
        stroke: Stroke::new(1.0, p.ink),
    };
    let pill = |bg: Color32, fg: Color32, stroke: Color32| WidgetVisuals {
        bg_fill: bg,
        weak_bg_fill: bg,
        bg_stroke: Stroke::new(1.0, stroke),
        corner_radius: CornerRadius::same(ROUNDING),
        fg_stroke: Stroke::new(1.5, fg),
        expansion: 0.0,
    };
    v.widgets = Widgets {
        noninteractive: WidgetVisuals {
            bg_fill: p.cream,
            weak_bg_fill: p.cream,
            bg_stroke: Stroke::new(1.0, p.tan),
            corner_radius: CornerRadius::same(ROUNDING),
            fg_stroke: Stroke::new(1.0, p.ink),
            expansion: 0.0,
        },
        inactive: pill(p.tan, p.ink, Color32::TRANSPARENT),
        hovered: WidgetVisuals {
            expansion: 1.0,
            ..pill(p.peach, p.ink, p.orange)
        },
        active: WidgetVisuals {
            expansion: 0.5,
            ..pill(p.orange, p.paper, p.orange)
        },
        open: pill(p.peach, p.ink, p.orange),
    };
    v.striped = true;
    v
}

/// The style: visuals plus roomier spacing than egui's default.
pub fn style(p: Palette) -> Style {
    let mut s = Style {
        visuals: visuals(p),
        ..Style::default()
    };
    s.spacing.item_spacing = egui::vec2(8.0, 6.0);
    s.spacing.button_padding = egui::vec2(10.0, 5.0);
    s.spacing.interact_size = egui::vec2(40.0, 24.0);
    s.spacing.menu_margin = egui::Margin::same(8);
    s.spacing.window_margin = egui::Margin::same(14);
    s.spacing.indent = 18.0;
    s.spacing.icon_width = 16.0;
    s.spacing.combo_width = 140.0;
    s.text_styles.insert(
        egui::TextStyle::Heading,
        egui::FontId::new(22.0, FontFamily::Name("bold".into())),
    );
    s.text_styles.insert(
        egui::TextStyle::Body,
        egui::FontId::new(14.5, FontFamily::Proportional),
    );
    s.text_styles.insert(
        egui::TextStyle::Button,
        egui::FontId::new(14.5, FontFamily::Proportional),
    );
    s.text_styles.insert(
        egui::TextStyle::Small,
        egui::FontId::new(11.5, FontFamily::Proportional),
    );
    s
}

/// Installs the look. Cheap enough to call every frame.
pub fn install(ctx: &Context) {
    ctx.set_theme(egui::ThemePreference::Light);
    ctx.set_style_of(egui::Theme::Light, style(PALETTE));
}

/// The fonts: Noto Sans regular as the proportional family, bold as
/// its own family for headings, the language's script font joined as a
/// fallback, and the icons last.
pub fn fonts(set: &FontSet) -> FontDefinitions {
    let mut fonts = FontDefinitions::default();
    let data = |font: &catlog_core::pdf::Font| {
        std::sync::Arc::new(egui::FontData::from_owned(font.data().to_vec()))
    };
    fonts
        .font_data
        .insert("noto-sans".into(), data(&set.regular));
    fonts
        .font_data
        .insert("noto-sans-bold".into(), data(&set.bold));
    let mut proportional = vec!["noto-sans".to_string()];
    let mut bold = vec!["noto-sans-bold".to_string()];
    if let Some((regular, heavy)) = &set.script {
        fonts.font_data.insert("script".into(), data(regular));
        fonts.font_data.insert("script-bold".into(), data(heavy));
        proportional.push("script".into());
        bold.push("script-bold".into());
    }
    // egui's own fonts stay behind ours for the symbols Noto lacks.
    let defaults = FontDefinitions::default();
    for name in defaults
        .families
        .get(&FontFamily::Proportional)
        .cloned()
        .unwrap_or_default()
    {
        proportional.push(name.clone());
        bold.push(name);
    }
    fonts
        .families
        .insert(FontFamily::Proportional, proportional);
    fonts.families.insert(FontFamily::Name("bold".into()), bold);
    crate::icons::add_font(&mut fonts);
    fonts
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_look_installs_and_the_fonts_stack_in_order() {
        let ctx = Context::default();
        install(&ctx);
        let style = ctx.global_style();
        assert_eq!(style.visuals.panel_fill, PALETTE.cream);
        assert!(
            style.visuals.override_text_color.is_none(),
            "per-state text colours stay readable"
        );
        assert_eq!(style.visuals.widgets.hovered.fg_stroke.color, PALETTE.ink);
        assert_eq!(style.visuals.widgets.active.bg_fill, PALETTE.orange);
        assert_eq!(style.visuals.error_fg_color, PALETTE.red);
        let set = FontSet::bundled().unwrap();
        let fonts = fonts(&set);
        let prop = &fonts.families[&FontFamily::Proportional];
        assert_eq!(prop[0], "noto-sans");
        assert_eq!(prop.last().map(String::as_str), Some("material-icons"));
        assert!(
            !fonts
                .families
                .contains_key(&FontFamily::Name("script".into()))
        );
        let with_script = FontSet {
            script: Some((set.bold.clone(), set.bold.clone())),
            ..set.clone()
        };
        let fonts = super::fonts(&with_script);
        assert_eq!(fonts.families[&FontFamily::Proportional][1], "script");
        assert_eq!(
            fonts.families[&FontFamily::Name("bold".into())][1],
            "script-bold"
        );
        ctx.set_fonts(fonts);
    }
}
