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
const TREND_KEY: &str = "graphTrend";

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
            egui::Grid::new(("history", entity, &def.slug))
                .num_columns(3)
                .spacing([16.0, 4.0])
                .striped(true)
                .show(ui, |ui| {
                    ui.strong(t.col_when());
                    ui.strong(t.col_value());
                    ui.strong(t.col_who());
                    ui.end_row();
                    for e in &entries {
                        let day = chrono::DateTime::parse_from_rfc3339(&e.date)
                            .map(|d| format_day(locale, d.date_naive()))
                            .unwrap_or_else(|_| e.date.clone());
                        let value = value_label(t, store, &e.field, e.value.as_deref(), self.units);
                        let text = if e.voided {
                            egui::RichText::new(&value).weak().strikethrough()
                        } else {
                            egui::RichText::new(&value)
                        };
                        ui.label(&day);
                        let response = ui.selectable_label(false, text);
                        if response.clicked() && !e.voided {
                            action = HistoryAction::Correct(e.seq);
                        }
                        // The menu holds what the click does not: removing,
                        // or restoring what was removed.
                        let mut menu = |ui: &mut egui::Ui| {
                            if e.voided {
                                if ui.button(t.restore_this_value()).clicked() {
                                    action = HistoryAction::Restore(e.seq);
                                    ui.close();
                                }
                            } else if ui.button(t.remove_this_value()).clicked() {
                                action = HistoryAction::Remove(e.seq);
                                ui.close();
                            }
                        };
                        response.context_menu(&mut menu);
                        ui.horizontal(|ui| {
                            ui.label(&e.author);
                            crate::icons::more(ui, &mut menu);
                        });
                        ui.end_row();
                    }
                });
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
        let points = store.history_points(entity, &def.key()).unwrap_or_default();
        let mut smooth = flag(store, SMOOTH_KEY);
        let mut trend = flag(store, TREND_KEY);
        let mut copy = false;
        ui.horizontal(|ui| {
            if ui.checkbox(&mut smooth, t.graph_smoothed()).changed() {
                set_flag(store, SMOOTH_KEY, smooth);
            }
            if ui.checkbox(&mut trend, t.graph_trend()).changed() {
                set_flag(store, TREND_KEY, trend);
            }
            if points.len() >= 2 && ui.button(t.copy_graph_image()).clicked() {
                copy = true;
            }
        });
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
        painter.add(egui::Shape::line(
            line.clone(),
            Stroke::new(1.0, ink.gamma_multiply(0.4)),
        ));
        if smooth {
            let curve: Vec<Pos2> = smooth_curve(&points, from, to, 80).iter().map(at).collect();
            painter.add(egui::Shape::line(
                curve,
                Stroke::new(2.0, Color32::from_rgb(0xd9, 0x6c, 0x2b)),
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
