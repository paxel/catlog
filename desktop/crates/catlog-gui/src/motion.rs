//! Modest motion: fades, eased hovers and cards settling into place,
//! all under 200 ms and all from one duration. The Eye candy switch in
//! Settings sets that duration to zero and everything stands still.

use std::hash::Hash;

use egui::{Context, Id, Pos2};

/// How long a fade or an ease takes when the switch is on, in seconds.
pub const DEFAULT: f32 = 0.16;

fn key() -> Id {
    Id::new("motion-duration")
}

/// Sets the duration for this frame and the ones after: the default
/// with the switch on, zero with it off. egui's own animations follow.
pub fn set(ctx: &Context, on: bool) {
    let duration = if on { DEFAULT } else { 0.0 };
    ctx.data_mut(|d| d.insert_temp(key(), duration));
    if ctx.global_style().animation_time != duration {
        ctx.all_styles_mut(|s| s.animation_time = duration);
    }
}

/// The duration in force, zero until `set` said otherwise.
pub fn duration(ctx: &Context) -> f32 {
    ctx.data(|d| d.get_temp::<f32>(key()).unwrap_or(0.0))
}

/// 0 → 1 over the duration after `what` first shows; 1 at once when
/// motion is off. The key names the thing and its opening, so a thing
/// opened again fades again.
pub fn fade_in(ctx: &Context, what: impl Hash + std::fmt::Debug) -> f32 {
    let duration = duration(ctx);
    let id = Id::new(("fade", what));
    if duration <= 0.0 {
        return 1.0;
    }
    let seen = id.with("seen");
    if !ctx.data(|d| d.get_temp::<bool>(seen).unwrap_or(false)) {
        ctx.data_mut(|d| d.insert_temp(seen, true));
        ctx.animate_value_with_time(id, 0.0, 0.0);
        ctx.request_repaint();
        return 0.0;
    }
    ctx.animate_value_with_time(id, 1.0, duration)
}

/// Eases a position towards `target` over the duration; the first
/// call snaps there, as does every call with motion off.
pub fn ease_to(ctx: &Context, what: impl Hash + std::fmt::Debug, target: Pos2) -> Pos2 {
    let duration = duration(ctx);
    if duration <= 0.0 {
        return target;
    }
    let id = Id::new(("ease", what));
    Pos2::new(
        ctx.animate_value_with_time(id.with("x"), target.x, duration),
        ctx.animate_value_with_time(id.with("y"), target.y, duration),
    )
}

/// 0 → 1 while `on`, back over the duration when not: a hover or press
/// tint that eases instead of snapping.
pub fn tint(ctx: &Context, what: impl Hash + std::fmt::Debug, on: bool) -> f32 {
    let duration = duration(ctx);
    if duration <= 0.0 {
        return if on { 1.0 } else { 0.0 };
    }
    ctx.animate_bool_with_time(Id::new(("tint", what)), on, duration)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_switch_zeroes_every_duration_and_on_it_fades() {
        let ctx = Context::default();
        set(&ctx, false);
        assert_eq!(duration(&ctx), 0.0);
        assert_eq!(ctx.global_style().animation_time, 0.0);
        assert_eq!(fade_in(&ctx, "modal"), 1.0, "nothing to wait for");
        assert_eq!(tint(&ctx, "button", true), 1.0);
        assert_eq!(
            ease_to(&ctx, "card", Pos2::new(40.0, 8.0)),
            Pos2::new(40.0, 8.0)
        );
        set(&ctx, true);
        assert_eq!(duration(&ctx), DEFAULT);
        assert_eq!(ctx.global_style().animation_time, DEFAULT);
        // Inside a pass the fade starts from nothing, grows and ends at one.
        let at = |time: f64| egui::RawInput {
            time: Some(time),
            ..Default::default()
        };
        let _ = ctx.run_ui(at(0.0), |ui| {
            assert_eq!(fade_in(ui.ctx(), "sheet"), 0.0);
        });
        let _ = ctx.run_ui(at(0.01), |ui| {
            let _ = fade_in(ui.ctx(), "sheet");
        });
        let _ = ctx.run_ui(at(0.08), |ui| {
            let k = fade_in(ui.ctx(), "sheet");
            assert!(k > 0.0 && k < 1.0, "{k}");
        });
        let _ = ctx.run_ui(at(1.0), |ui| {
            assert_eq!(fade_in(ui.ctx(), "sheet"), 1.0);
        });
    }
}
