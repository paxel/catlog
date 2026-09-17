//! The phone's icons on the desk: Material Icons, the font Flutter ships,
//! with the codepoints the phone's own screens use. An icon sits beside
//! its label as a painted glyph, never as text, so the ARB strings stay
//! the only words and the tests keep reading plain labels.

use egui::{Align2, Atom, Button, Color32, FontFamily, FontId, Id, Response, Ui, Vec2};

static MATERIAL_ICONS: &[u8] = include_bytes!("../assets/MaterialIcons-Regular.otf");

/// The font family the icons live in.
pub const FAMILY: &str = "icons";

/// The icon glyph size next to a label.
pub const SIZE: f32 = 16.0;

/// Adds the icon font to `fonts`: its own family, and the last resort of
/// the proportional family so a bare glyph in a label still shows.
pub fn add_font(fonts: &mut egui::FontDefinitions) {
    fonts.font_data.insert(
        "material-icons".into(),
        std::sync::Arc::new(egui::FontData::from_static(MATERIAL_ICONS)),
    );
    fonts.families.insert(
        FontFamily::Name(FAMILY.into()),
        vec!["material-icons".into()],
    );
    fonts
        .families
        .entry(FontFamily::Proportional)
        .or_default()
        .push("material-icons".into());
}

pub fn font_id(size: f32) -> FontId {
    FontId::new(size, FontFamily::Name(FAMILY.into()))
}

/// Paints one icon centred in `rect`.
pub fn paint(ui: &Ui, rect: egui::Rect, icon: &str, color: Color32) {
    // A bare Context without the fonts (unit tests) draws nothing.
    let bound = ui.fonts(|f| f.families().contains(&FontFamily::Name(FAMILY.into())));
    if !bound {
        return;
    }
    ui.painter().text(
        rect.center(),
        Align2::CENTER_CENTER,
        icon,
        font_id(rect.height()),
        color,
    );
}

/// A button with an icon before its text; the accessible label is the
/// text alone.
pub fn button(ui: &mut Ui, icon: &str, text: impl Into<egui::WidgetText>) -> Response {
    let id = Id::new(("icon-atom", icon)).with(ui.next_auto_id());
    let response = Button::new((Atom::custom(id, Vec2::splat(SIZE)), text.into())).atom_ui(ui);
    if let Some(rect) = response.rect(id) {
        let color = ui.style().interact(&response.response).fg_stroke.color;
        paint(ui, rect, icon, color);
    }
    tint(ui, &response.response);
    response.response
}

/// A hover tint that eases in and out over the button, when motion is on.
fn tint(ui: &Ui, response: &Response) {
    let k = crate::motion::tint(ui.ctx(), response.id, response.hovered());
    if k > 0.0 && k < 1.0 {
        ui.painter().rect_filled(
            response.rect,
            crate::theme::ROUNDING,
            crate::theme::PALETTE.orange.gamma_multiply(0.12 * k),
        );
    }
}

/// A selectable row with an icon before its text.
pub fn selectable(
    ui: &mut Ui,
    selected: bool,
    icon: &str,
    text: impl Into<egui::WidgetText>,
) -> Response {
    let id = Id::new(("icon-atom", icon)).with(ui.next_auto_id());
    let response = Button::selectable(selected, (Atom::custom(id, Vec2::splat(SIZE)), text.into()))
        .atom_ui(ui);
    if let Some(rect) = response.rect(id) {
        let color = ui.style().interact(&response.response).fg_stroke.color;
        paint(ui, rect, icon, color);
    }
    tint(ui, &response.response);
    response.response
}

/// An icon on its own, as a glyph in the icon font.
pub fn glyph(ui: &mut Ui, icon: &str, size: f32, color: Color32) -> Response {
    let (rect, response) = ui.allocate_exact_size(Vec2::splat(size), egui::Sense::hover());
    if ui.is_rect_visible(rect) {
        paint(ui, rect, icon, color);
    }
    response
}

/// A label with an icon before it.
pub fn label(ui: &mut Ui, icon: &str, text: impl Into<egui::WidgetText>) -> Response {
    ui.horizontal(|ui| {
        let color = ui.visuals().text_color();
        glyph(ui, icon, SIZE, color);
        ui.label(text)
    })
    .inner
}

pub const ADD: &str = "\u{e047}";
pub const ADD_A_PHOTO: &str = "\u{e048}";
pub const ADD_HOME_OUTLINED: &str = "\u{f06d5}";
pub const ADD_LOCATION_ALT_OUTLINED: &str = "\u{ee44}";
pub const AGRICULTURE_OUTLINED: &str = "\u{ee54}";
pub const ALARM: &str = "\u{e072}";
pub const ALARM_ADD: &str = "\u{e073}";
pub const ARROW_DOWNWARD: &str = "\u{e097}";
pub const ARROW_DROP_DOWN: &str = "\u{e098}";
pub const ARROW_UPWARD: &str = "\u{e0a0}";
pub const ASSIGNMENT_OUTLINED: &str = "\u{ee98}";
pub const BACKUP_OUTLINED: &str = "\u{eeb6}";
pub const BADGE_OUTLINED: &str = "\u{eeb8}";
pub const BOOKMARK_ADD_OUTLINED: &str = "\u{eee0}";
pub const BOOKMARK_OUTLINE: &str = "\u{e0f4}";
pub const BROKEN_IMAGE_OUTLINED: &str = "\u{eeff}";
pub const BUG_REPORT_OUTLINED: &str = "\u{ef04}";
pub const CALENDAR_MONTH_OUTLINED: &str = "\u{f051f}";
pub const CAMPAIGN_OUTLINED: &str = "\u{ef27}";
pub const CANCEL_OUTLINED: &str = "\u{ef28}";
pub const CASINO_OUTLINED: &str = "\u{ef32}";
pub const CELEBRATION_OUTLINED: &str = "\u{ef38}";
pub const CHECK: &str = "\u{e156}";
pub const CHECK_CIRCLE: &str = "\u{e159}";
pub const CHECK_CIRCLE_OUTLINE: &str = "\u{e15a}";
pub const CHECKLIST: &str = "\u{e15b}";
pub const CHEVRON_LEFT: &str = "\u{e15e}";
pub const CHEVRON_RIGHT: &str = "\u{e15f}";
pub const CIRCLE_OUTLINED: &str = "\u{ef53}";
pub const CLEAR: &str = "\u{e168}";
pub const CLOSE: &str = "\u{e16a}";
pub const CODE: &str = "\u{e176}";
pub const COFFEE_OUTLINED: &str = "\u{ef68}";
pub const COPY: &str = "\u{e190}";
pub const CREATE_NEW_FOLDER_OUTLINED: &str = "\u{ef8c}";
pub const CROP: &str = "\u{e1a3}";
pub const DELETE_FOREVER_OUTLINED: &str = "\u{efa8}";
pub const DELETE_OUTLINE: &str = "\u{e1bb}";
pub const DESCRIPTION_OUTLINED: &str = "\u{efae}";
pub const DEVICES_OUTLINED: &str = "\u{efbb}";
pub const DOWNLOAD: &str = "\u{e201}";
pub const DRIVE_FILE_MOVE_OUTLINE: &str = "\u{e20a}";
pub const DRIVE_FILE_RENAME_OUTLINE: &str = "\u{e20b}";
pub const EDIT: &str = "\u{e21a}";
pub const EDIT_CALENDAR_OUTLINED: &str = "\u{f05ef}";
pub const EDIT_OUTLINED: &str = "\u{f00d}";
pub const EMOJI_EVENTS: &str = "\u{e22c}";
pub const EMOJI_EVENTS_OUTLINED: &str = "\u{f01a}";
pub const EVENT: &str = "\u{e23e}";
pub const EVENT_BUSY: &str = "\u{e240}";
pub const EXPAND_LESS: &str = "\u{e245}";
pub const EXPAND_MORE: &str = "\u{e246}";
pub const EXPLORE: &str = "\u{e248}";
pub const FAVORITE: &str = "\u{e25b}";
pub const FOLDER_COPY_OUTLINED: &str = "\u{f05ff}";
pub const FOLDER_OPEN: &str = "\u{e2a4}";
pub const FOLDER_OUTLINED: &str = "\u{f091}";
pub const FOLDER_SHARED_OUTLINED: &str = "\u{f092}";
pub const GPP_BAD_OUTLINED: &str = "\u{f0c6}";
pub const GRID_VIEW: &str = "\u{e2ea}";
pub const HEALING_OUTLINED: &str = "\u{f0f1}";
pub const HELP_OUTLINE: &str = "\u{e30b}";
pub const HIDE_IMAGE_OUTLINED: &str = "\u{f0fa}";
pub const HISTORY: &str = "\u{e314}";
pub const HOME: &str = "\u{e318}";
pub const HOME_OUTLINED: &str = "\u{f107}";
pub const IMAGE_NOT_SUPPORTED_OUTLINED: &str = "\u{f11f}";
pub const IMAGE_OUTLINED: &str = "\u{f120}";
pub const INFO_OUTLINE: &str = "\u{e33d}";
pub const INVENTORY_2_OUTLINED: &str = "\u{f134}";
pub const IOS_SHARE: &str = "\u{e34d}";
pub const JOIN_INNER: &str = "\u{f0527}";
pub const KEY_OUTLINED: &str = "\u{f0624}";
pub const LABEL_OUTLINE: &str = "\u{e364}";
pub const LANGUAGE: &str = "\u{e366}";
pub const LAYERS_OUTLINED: &str = "\u{f157}";
pub const LIGHTBULB_OUTLINE: &str = "\u{e37c}";
pub const LINK: &str = "\u{e380}";
pub const LIST_ALT_OUTLINED: &str = "\u{f16c}";
pub const LOCATION_PIN: &str = "\u{e3ac}";
pub const LOCK: &str = "\u{e3ae}";
pub const LOCK_OPEN: &str = "\u{e3b0}";
pub const LOCK_OUTLINE: &str = "\u{e3b1}";
pub const LOGIN: &str = "\u{e3b2}";
pub const LOGOUT: &str = "\u{e3b3}";
pub const MAIL_OUTLINE: &str = "\u{e3c4}";
pub const MAP_OUTLINED: &str = "\u{f1ae}";
pub const MEDICAL_INFORMATION_OUTLINED: &str = "\u{f06fc}";
pub const MEDICAL_SERVICES_OUTLINED: &str = "\u{f1be}";
pub const MERGE: &str = "\u{f053b}";
pub const MERGE_TYPE: &str = "\u{e3df}";
pub const MOVIE_OUTLINED: &str = "\u{f1f5}";
pub const MY_LOCATION: &str = "\u{e418}";
pub const NEW_RELEASES_OUTLINED: &str = "\u{f20e}";
pub const NIGHT_SHELTER_OUTLINED: &str = "\u{f212}";
pub const NOTIFICATIONS_ACTIVE_OUTLINED: &str = "\u{f234}";
pub const NOTIFICATIONS_OUTLINED: &str = "\u{f237}";
pub const OPEN_IN_NEW: &str = "\u{e45c}";
pub const PAUSE: &str = "\u{e47c}";
pub const PAUSE_CIRCLE_OUTLINE: &str = "\u{e47f}";
pub const PERSON_OFF_OUTLINED: &str = "\u{f279}";
pub const PERSON_OUTLINE: &str = "\u{e497}";
pub const PETS: &str = "\u{e4a1}";
pub const PETS_OUTLINED: &str = "\u{f285}";
pub const PHONELINK_ERASE_OUTLINED: &str = "\u{f292}";
pub const PHONELINK_LOCK_OUTLINED: &str = "\u{f293}";
pub const PHOTO_CAMERA: &str = "\u{e4b6}";
pub const PHOTO_LIBRARY: &str = "\u{e4ba}";
pub const PHOTO_LIBRARY_OUTLINED: &str = "\u{f29d}";
pub const PHOTO_OUTLINED: &str = "\u{f29e}";
pub const PICTURE_AS_PDF: &str = "\u{e4c0}";
pub const PLACE: &str = "\u{e4c9}";
pub const PLACE_OUTLINED: &str = "\u{f2ac}";
pub const PLAY_ARROW: &str = "\u{e4cb}";
pub const PRINT: &str = "\u{e4ea}";
pub const QR_CODE: &str = "\u{e4f5}";
pub const QR_CODE_SCANNER: &str = "\u{e4f7}";
pub const RADIO_BUTTON_CHECKED: &str = "\u{e503}";
pub const RADIO_BUTTON_OFF: &str = "\u{e504}";
pub const RADIO_BUTTON_UNCHECKED: &str = "\u{e504}";
pub const REFRESH: &str = "\u{e514}";
pub const REMOVE: &str = "\u{e516}";
pub const RESTORE: &str = "\u{e534}";
pub const SAVE_OUTLINED: &str = "\u{f334}";
pub const SCHEDULE: &str = "\u{e556}";
pub const SEARCH: &str = "\u{e567}";
pub const SEND_OUTLINED: &str = "\u{f355}";
pub const SETTINGS_OUTLINED: &str = "\u{f36e}";
pub const SHOW_CHART: &str = "\u{e59f}";
pub const SLIDESHOW_OUTLINED: &str = "\u{f3a3}";
pub const SORT: &str = "\u{e5d2}";
pub const STAR: &str = "\u{e5f9}";
pub const STAR_BORDER: &str = "\u{e5fa}";
pub const STOP: &str = "\u{e606}";
pub const STORAGE_OUTLINED: &str = "\u{f3ec}";
pub const STRAIGHTEN: &str = "\u{e60e}";
pub const SYNC: &str = "\u{e62f}";
pub const TABLE_ROWS_OUTLINED: &str = "\u{f41e}";
pub const TEXTURE: &str = "\u{e653}";
pub const UNDO: &str = "\u{e68c}";
pub const VERIFIED_USER_OUTLINED: &str = "\u{f47d}";
pub const VIEW_LIST: &str = "\u{e6b5}";
pub const VISIBILITY: &str = "\u{e6bd}";
pub const VISIBILITY_OFF: &str = "\u{e6be}";
pub const VISIBILITY_OFF_OUTLINED: &str = "\u{f4a0}";
pub const VISIBILITY_OUTLINED: &str = "\u{f4a1}";
pub const VOLUME_UP_OUTLINED: &str = "\u{f4a8}";
pub const VOLUNTEER_ACTIVISM: &str = "\u{e6c6}";
pub const WARNING_AMBER: &str = "\u{e6cc}";
pub const WIFI_OFF: &str = "\u{e6eb}";
pub const WIFI_TETHERING: &str = "\u{e6ed}";
pub const WORKSPACE_PREMIUM_OUTLINED: &str = "\u{f06a1}";

/// Every icon this module names, for the test that each has a glyph.
pub const ALL: &[&str] = &[
    ADD,
    ADD_A_PHOTO,
    ADD_HOME_OUTLINED,
    ADD_LOCATION_ALT_OUTLINED,
    AGRICULTURE_OUTLINED,
    ALARM,
    ALARM_ADD,
    ARROW_DOWNWARD,
    ARROW_DROP_DOWN,
    ARROW_UPWARD,
    ASSIGNMENT_OUTLINED,
    BACKUP_OUTLINED,
    BADGE_OUTLINED,
    BOOKMARK_ADD_OUTLINED,
    BOOKMARK_OUTLINE,
    BROKEN_IMAGE_OUTLINED,
    BUG_REPORT_OUTLINED,
    CALENDAR_MONTH_OUTLINED,
    CAMPAIGN_OUTLINED,
    CANCEL_OUTLINED,
    CASINO_OUTLINED,
    CELEBRATION_OUTLINED,
    CHECK,
    CHECK_CIRCLE,
    CHECK_CIRCLE_OUTLINE,
    CHECKLIST,
    CHEVRON_LEFT,
    CHEVRON_RIGHT,
    CIRCLE_OUTLINED,
    CLEAR,
    CLOSE,
    CODE,
    COFFEE_OUTLINED,
    COPY,
    CREATE_NEW_FOLDER_OUTLINED,
    CROP,
    DELETE_FOREVER_OUTLINED,
    DELETE_OUTLINE,
    DESCRIPTION_OUTLINED,
    DEVICES_OUTLINED,
    DOWNLOAD,
    DRIVE_FILE_MOVE_OUTLINE,
    DRIVE_FILE_RENAME_OUTLINE,
    EDIT,
    EDIT_CALENDAR_OUTLINED,
    EDIT_OUTLINED,
    EMOJI_EVENTS,
    EMOJI_EVENTS_OUTLINED,
    EVENT,
    EVENT_BUSY,
    EXPAND_LESS,
    EXPAND_MORE,
    EXPLORE,
    FAVORITE,
    FOLDER_COPY_OUTLINED,
    FOLDER_OPEN,
    FOLDER_OUTLINED,
    FOLDER_SHARED_OUTLINED,
    GPP_BAD_OUTLINED,
    GRID_VIEW,
    HEALING_OUTLINED,
    HELP_OUTLINE,
    HIDE_IMAGE_OUTLINED,
    HISTORY,
    HOME,
    HOME_OUTLINED,
    IMAGE_NOT_SUPPORTED_OUTLINED,
    IMAGE_OUTLINED,
    INFO_OUTLINE,
    INVENTORY_2_OUTLINED,
    IOS_SHARE,
    JOIN_INNER,
    KEY_OUTLINED,
    LABEL_OUTLINE,
    LANGUAGE,
    LAYERS_OUTLINED,
    LIGHTBULB_OUTLINE,
    LINK,
    LIST_ALT_OUTLINED,
    LOCATION_PIN,
    LOCK,
    LOCK_OPEN,
    LOCK_OUTLINE,
    LOGIN,
    LOGOUT,
    MAIL_OUTLINE,
    MAP_OUTLINED,
    MEDICAL_INFORMATION_OUTLINED,
    MEDICAL_SERVICES_OUTLINED,
    MERGE,
    MERGE_TYPE,
    MOVIE_OUTLINED,
    MY_LOCATION,
    NEW_RELEASES_OUTLINED,
    NIGHT_SHELTER_OUTLINED,
    NOTIFICATIONS_ACTIVE_OUTLINED,
    NOTIFICATIONS_OUTLINED,
    OPEN_IN_NEW,
    PAUSE,
    PAUSE_CIRCLE_OUTLINE,
    PERSON_OFF_OUTLINED,
    PERSON_OUTLINE,
    PETS,
    PETS_OUTLINED,
    PHONELINK_ERASE_OUTLINED,
    PHONELINK_LOCK_OUTLINED,
    PHOTO_CAMERA,
    PHOTO_LIBRARY,
    PHOTO_LIBRARY_OUTLINED,
    PHOTO_OUTLINED,
    PICTURE_AS_PDF,
    PLACE,
    PLACE_OUTLINED,
    PLAY_ARROW,
    PRINT,
    QR_CODE,
    QR_CODE_SCANNER,
    RADIO_BUTTON_CHECKED,
    RADIO_BUTTON_OFF,
    RADIO_BUTTON_UNCHECKED,
    REFRESH,
    REMOVE,
    RESTORE,
    SAVE_OUTLINED,
    SCHEDULE,
    SEARCH,
    SEND_OUTLINED,
    SETTINGS_OUTLINED,
    SHOW_CHART,
    SLIDESHOW_OUTLINED,
    SORT,
    STAR,
    STAR_BORDER,
    STOP,
    STORAGE_OUTLINED,
    STRAIGHTEN,
    SYNC,
    TABLE_ROWS_OUTLINED,
    TEXTURE,
    UNDO,
    VERIFIED_USER_OUTLINED,
    VIEW_LIST,
    VISIBILITY,
    VISIBILITY_OFF,
    VISIBILITY_OFF_OUTLINED,
    VISIBILITY_OUTLINED,
    VOLUME_UP_OUTLINED,
    VOLUNTEER_ACTIVISM,
    WARNING_AMBER,
    WIFI_OFF,
    WIFI_TETHERING,
    WORKSPACE_PREMIUM_OUTLINED,
];

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_named_icon_has_a_glyph_in_the_font() {
        let face = ttf_parser::Face::parse(MATERIAL_ICONS, 0).unwrap();
        for icon in ALL {
            let c = icon.chars().next().unwrap();
            assert!(face.glyph_index(c).is_some(), "{icon:?} has no glyph");
        }
        assert_eq!(ALL.len(), 152);
        let mut fonts = egui::FontDefinitions::default();
        add_font(&mut fonts);
        assert!(fonts.font_data.contains_key("material-icons"));
        assert_eq!(
            fonts.families[&FontFamily::Proportional]
                .last()
                .map(String::as_str),
            Some("material-icons")
        );
    }
}
