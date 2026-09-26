//! A Field's history on one entity: every value with who set it when,
//! corrections and removals shown on request, a tap corrects, the
//! secondary menu removes or restores; number Fields as a curve with
//! the smoothed line and the trend the phones draw.

use catlog_core::fields::{FieldDef, FieldType};
use catlog_core::graph::{smooth_curve, trend_line};
use catlog_core::units::UnitSystem;
use catlog_core::{Catalog, Entry};
use egui::{Color32, Pos2, Rect, Stroke, Ui, Vec2};

use crate::graph_image::GraphSheet;
use crate::l10n::L10n;
use crate::labels::{field_def_name, field_value_display, format_day, format_number, value_label};

/// What the keeper did on the history page.
#[derive(Debug, Clone, PartialEq)]
pub enum HistoryAction {
    None,
    /// The graph as a picture on the clipboard, as the page shows it.
    CopyGraph(Box<GraphSheet>),
    /// Correct the entry with this seq.
    Correct(i64),
    Remove(i64),
    Restore(i64),
    Back,
}

/// The page's own state, remembered per device through local settings.
#[derive(Default)]
pub struct HistoryPage {
    pub units: UnitSystem,
}

const OLDEST_FIRST_KEY: &str = "historyOldestFirst";
const SHOW_VOIDED_KEY: &str = "historyShowVoided";
const SMOOTH_KEY: &str = "graphSmooth";
const RANGE_KEY: &str = "graphRange";
const TREND_KEY: &str = "graphTrend";

/// How far back a graph looks, remembered per device.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Range {
    Month,
    HalfYear,
    Year,
    All,
}

impl Range {
    const ALL: [Range; 4] = [Range::Month, Range::HalfYear, Range::Year, Range::All];

    fn stored(self) -> &'static str {
        match self {
            Range::Month => "month",
            Range::HalfYear => "halfYear",
            Range::Year => "year",
            Range::All => "all",
        }
    }

    fn of(store: &Catalog) -> Range {
        match store.local_setting(RANGE_KEY).as_deref() {
            Some("month") => Range::Month,
            Some("halfYear") => Range::HalfYear,
            Some("year") => Range::Year,
            _ => Range::All,
        }
    }

    fn words(self, t: &L10n) -> &'static str {
        match self {
            Range::Month => t.range_month(),
            Range::HalfYear => t.range_half_year(),
            Range::Year => t.range_year(),
            Range::All => t.range_all(),
        }
    }

    /// The days this range covers, counted back from the last reading so
    /// that a cat who died last year still has a graph.
    fn days(self) -> Option<i64> {
        match self {
            Range::Month => Some(31),
            Range::HalfYear => Some(183),
            Range::Year => Some(365),
            Range::All => None,
        }
    }

    fn keep(self, points: &[catlog_core::GraphPoint]) -> Vec<catlog_core::GraphPoint> {
        let Some(days) = self.days() else {
            return points.to_vec();
        };
        let Some(last) = points.last().map(|p| p.at) else {
            return Vec::new();
        };
        let first = last - days * 24 * 60 * 60 * 1000;
        points.iter().filter(|p| p.at >= first).cloned().collect()
    }
}

fn flag(store: &Catalog, key: &str) -> bool {
    store.local_setting(key).as_deref() == Some("yes")
}

fn set_flag(store: &Catalog, key: &str, on: bool) {
    let _ = store.set_local_setting(key, if on { "yes" } else { "no" });
}

impl HistoryPage {
    /// Draws the history of `def` on `entity`.
    pub fn show(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        entity: &str,
        def: &FieldDef,
    ) -> HistoryAction {
        let mut action = HistoryAction::None;
        let locale = t.locale();
        let name = store
            .current(entity, catlog_core::keys::NAME)
            .ok()
            .flatten()
            .unwrap_or_else(|| t.unnamed().to_string());
        egui::ScrollArea::vertical().show(ui, |ui| {
            ui.horizontal(|ui| {
                if ui.button(t.back_label()).on_hover_text(&name).clicked() {
                    action = HistoryAction::Back;
                }
                ui.heading(format!("{name} · {}", field_def_name(t, def)));
            });
            let mut oldest_first = flag(store, OLDEST_FIRST_KEY);
            let mut show_voided = flag(store, SHOW_VOIDED_KEY);
            ui.horizontal(|ui| {
                if ui
                    .checkbox(&mut oldest_first, t.history_oldest_first())
                    .changed()
                {
                    set_flag(store, OLDEST_FIRST_KEY, oldest_first);
                }
                if ui
                    .checkbox(&mut show_voided, t.history_show_hidden())
                    .changed()
                {
                    set_flag(store, SHOW_VOIDED_KEY, show_voided);
                }
            });
            if matches!(def.field_type, FieldType::Number | FieldType::UnitValue)
                && let Some(sheet) = self.show_graph(ui, store, t, entity, def, &name)
            {
                action = HistoryAction::CopyGraph(Box::new(sheet));
            }
            let mut entries: Vec<Entry> = store
                .field_history(entity, &def.key(), show_voided)
                .unwrap_or_default();
            if oldest_first {
                entries.reverse();
            }
            // A diary: the day over what was written on it, each value
            // as long as it is. A long remark used to be one line and
            // pushed the modal past both edges of the screen.
            let mut day_shown = String::new();
            for e in &entries {
                let day = chrono::DateTime::parse_from_rfc3339(&e.date)
                    .map(|d| format_day(locale, d.date_naive()))
                    .unwrap_or_else(|_| e.date.clone());
                if day != day_shown {
                    ui.add_space(10.0);
                    ui.label(egui::RichText::new(&day).strong());
                    ui.separator();
                    day_shown = day;
                }
                let value = value_label(t, store, &e.field, e.value.as_deref(), self.units);
                let text = if e.voided {
                    egui::RichText::new(&value).weak().strikethrough()
                } else {
                    egui::RichText::new(&value)
                };
                let mut row = HistoryAction::None;
                ui.horizontal_top(|ui| {
                    let width = (ui.available_width() - 200.0).max(160.0);
                    let response = ui
                        .allocate_ui_with_layout(
                            Vec2::new(width, 0.0),
                            egui::Layout::top_down(egui::Align::LEFT),
                            |ui| {
                                ui.set_min_width(width);
                                ui.add(egui::Label::new(text).wrap().sense(egui::Sense::click()))
                            },
                        )
                        .inner;
                    if response.clicked() && !e.voided {
                        row = HistoryAction::Correct(e.seq);
                    }
                    ui.label(egui::RichText::new(&e.author).weak());
                    // The menu holds what the click does not: removing, or
                    // restoring what was removed.
                    let mut menu = |ui: &mut egui::Ui| {
                        if e.voided {
                            if ui.button(t.restore_this_value()).clicked() {
                                row = HistoryAction::Restore(e.seq);
                                ui.close();
                            }
                        } else if ui.button(t.remove_this_value()).clicked() {
                            row = HistoryAction::Remove(e.seq);
                            ui.close();
                        }
                    };
                    response.context_menu(&mut menu);
                    crate::icons::more_labeled(ui, t.value_actions(), &mut menu);
                });
                if row != HistoryAction::None {
                    action = row;
                }
            }
        });
        action
    }

    /// The readings as a curve: dots on a line, the smoothed line and
    /// the trend on request, the change per month under it. The sheet
    /// comes back when the keeper asked for the graph as a picture.
    #[allow(clippy::too_many_arguments)]
    fn show_graph(
        &mut self,
        ui: &mut Ui,
        store: &Catalog,
        t: &L10n,
        entity: &str,
        def: &FieldDef,
        name: &str,
    ) -> Option<GraphSheet> {
        let all = store.history_points(entity, &def.key()).unwrap_or_default();
        let mut smooth = flag(store, SMOOTH_KEY);
        let mut trend = flag(store, TREND_KEY);
        let mut range = Range::of(store);
        let mut copy = false;
        ui.horizontal(|ui| {
            if ui.checkbox(&mut smooth, t.graph_smoothed()).changed() {
                set_flag(store, SMOOTH_KEY, smooth);
            }
            if ui.checkbox(&mut trend, t.graph_trend()).changed() {
                set_flag(store, TREND_KEY, trend);
            }
            if all.len() >= 2 && ui.button(t.copy_graph_image()).clicked() {
                copy = true;
            }
        });
        // How far back the graph looks: a month tells a sick cat's week
        // apart, everything tells a life.
        ui.horizontal(|ui| {
            for one in Range::ALL {
                if ui.selectable_label(range == one, one.words(t)).clicked() {
                    range = one;
                    let _ = store.set_local_setting(RANGE_KEY, one.stored());
                }
            }
        });
        let points = range.keep(&all);
        if points.len() < 2 {
            return None;
        }
        let from = points[0].at;
        let to = points[points.len() - 1].at;
        let (mut lo, mut hi) = points.iter().fold((f64::MAX, f64::MIN), |(lo, hi), p| {
            (lo.min(p.value), hi.max(p.value))
        });
        if hi <= lo {
            hi = lo + 1.0;
            lo -= 1.0;
        }
        let pad = (hi - lo) * 0.1;
        let (lo, hi) = (lo - pad, hi + pad);
        let (rect, _) = ui.allocate_exact_size(
            Vec2::new(ui.available_width().min(640.0), 200.0),
            egui::Sense::hover(),
        );
        let painter = ui.painter();
        painter.rect_filled(rect, 4.0, ui.visuals().extreme_bg_color);
        let span = (to - from).max(1) as f64;
        let at = |p: &catlog_core::GraphPoint| -> Pos2 {
            let x =
                rect.left() + 8.0 + ((p.at - from) as f64 / span) as f32 * (rect.width() - 16.0);
            let y =
                rect.bottom() - 8.0 - ((p.value - lo) / (hi - lo)) as f32 * (rect.height() - 16.0);
            Pos2::new(x, y)
        };
        let ink = ui.visuals().text_color();
        let line: Vec<Pos2> = points.iter().map(at).collect();
        // Smoothed or measured, one line at a time: the two drawn over
        // each other were two answers to the same question.
        if smooth {
            let curve: Vec<Pos2> = smooth_curve(&points, from, to, 80).iter().map(at).collect();
            painter.add(egui::Shape::line(
                curve,
                Stroke::new(2.0, Color32::from_rgb(0xd9, 0x6c, 0x2b)),
            ));
        } else {
            painter.add(egui::Shape::line(
                line.clone(),
                Stroke::new(1.0, ink.gamma_multiply(0.4)),
            ));
        }
        if trend && let Some(fit) = trend_line(&points, from, to) {
            let a = at(&catlog_core::GraphPoint {
                at: from,
                value: fit.at_from,
            });
            let b = at(&catlog_core::GraphPoint {
                at: to,
                value: fit.at_to,
            });
            painter.add(egui::Shape::dashed_line(
                &[a, b],
                Stroke::new(1.5, ink),
                6.0,
                4.0,
            ));
        }
        for p in &line {
            painter.circle_filled(*p, 3.0, ink);
        }
        let reading = |v: f64| match def.field_type {
            FieldType::UnitValue => {
                field_value_display(t, Some(def), Some(&format!("{v}")), self.units)
            }
            _ => format_number(t.locale(), v, 2),
        };
        let mut trend_note = None;
        if trend && let Some(fit) = trend_line(&points, from, to) {
            let sign = if fit.per_month >= 0.0 { "+" } else { "" };
            let note = t.trend_per_month(&format!("{sign}{}", reading(fit.per_month)));
            ui.label(&note);
            trend_note = Some(note);
        }
        // The first and the last reading, as the axis.
        let day = |ms: i64| {
            chrono::DateTime::from_timestamp_millis(ms)
                .map(|d| format_day(t.locale(), d.date_naive()))
                .unwrap_or_default()
        };
        ui.horizontal(|ui| {
            ui.label(egui::RichText::new(day(from)).weak().small());
            ui.add_space(rect.width() - 160.0);
            ui.label(egui::RichText::new(day(to)).weak().small());
        });
        let _ = Rect::NOTHING;
        copy.then(|| {
            let (low, high) = points.iter().fold((f64::MAX, f64::MIN), |(lo, hi), p| {
                (lo.min(p.value), hi.max(p.value))
            });
            GraphSheet {
                title: format!("{name} · {}", field_def_name(t, def)),
                points: points.clone(),
                smooth,
                trend,
                first_day: day(from),
                last_day: day(to),
                low: reading(low),
                high: reading(high),
                trend_note,
            }
        })
    }
}
