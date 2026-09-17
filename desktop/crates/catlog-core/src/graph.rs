//! A number Field's history as a curve: the readings, a smoothed line
//! through them and a straight trend, computed the way the phones do.

use crate::Result;
use crate::catalog::Catalog;

/// One reading: when, as milliseconds since the epoch, and the value.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct GraphPoint {
    pub at: i64,
    pub value: f64,
}

/// A straight line fitted through the readings.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Trend {
    pub at_from: f64,
    pub at_to: f64,
    pub per_month: f64,
}

/// The smoothed line: a Gaussian-weighted average of the readings,
/// width one twelfth of the shown span, sampled evenly between the
/// first and the last reading. A cluster of five weighings in a week
/// does not drag a year's line.
pub fn smooth_curve(points: &[GraphPoint], from: i64, to: i64, samples: usize) -> Vec<GraphPoint> {
    if points.len() < 2 {
        return points.to_vec();
    }
    let span = (to - from).max(1) as f64;
    let sigma = span / 12.0;
    let first = points[0].at as f64;
    let last = points[points.len() - 1].at as f64;
    (0..=samples)
        .map(|i| {
            let t = first + (last - first) * i as f64 / samples as f64;
            let mut weight = 0.0;
            let mut sum = 0.0;
            for p in points {
                let d = (p.at as f64 - t) / sigma;
                let w = (-0.5 * d * d).exp();
                weight += w;
                sum += w * p.value;
            }
            GraphPoint {
                at: t.round() as i64,
                value: sum / weight,
            }
        })
        .collect()
}

/// The trend: least squares through the readings, as the value at
/// `from`, the value at `to`, and the change per month. None with fewer
/// than two readings or no time span.
pub fn trend_line(points: &[GraphPoint], from: i64, to: i64) -> Option<Trend> {
    if points.len() < 2 {
        return None;
    }
    const DAY: f64 = 86_400_000.0;
    let origin = points[0].at as f64;
    let xs: Vec<f64> = points
        .iter()
        .map(|p| (p.at as f64 - origin) / DAY)
        .collect();
    let ys: Vec<f64> = points.iter().map(|p| p.value).collect();
    let n = xs.len() as f64;
    let mx = xs.iter().sum::<f64>() / n;
    let my = ys.iter().sum::<f64>() / n;
    let mut sxx = 0.0;
    let mut sxy = 0.0;
    for (x, y) in xs.iter().zip(&ys) {
        sxx += (x - mx) * (x - mx);
        sxy += (x - mx) * (y - my);
    }
    if sxx == 0.0 {
        return None;
    }
    let slope = sxy / sxx;
    let at = |d: i64| my + slope * ((d as f64 - origin) / DAY - mx);
    Some(Trend {
        at_from: at(from),
        at_to: at(to),
        per_month: slope * 30.44,
    })
}

impl Catalog {
    /// The numeric readings of a Field on an entity, oldest first: every
    /// value that parses as a number, with its effective date.
    pub fn history_points(&self, entity: &str, field: &str) -> Result<Vec<GraphPoint>> {
        let mut points: Vec<GraphPoint> = self
            .field_history(entity, field, false)?
            .into_iter()
            .filter(|e| !e.reminder)
            .filter_map(|e| {
                let value: f64 = e.value.as_deref()?.replace(',', ".").parse().ok()?;
                let at = chrono::DateTime::parse_from_rfc3339(&e.date)
                    .ok()?
                    .timestamp_millis();
                Some(GraphPoint { at, value })
            })
            .collect();
        points.sort_by_key(|p| p.at);
        Ok(points)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const DAY: i64 = 86_400_000;

    fn p(day: i64, value: f64) -> GraphPoint {
        GraphPoint {
            at: day * DAY,
            value,
        }
    }

    #[test]
    fn the_trend_is_a_least_squares_line_with_a_monthly_rate() {
        let points = [p(0, 1.0), p(10, 2.0), p(20, 3.0)];
        let t = trend_line(&points, 0, 20 * DAY).unwrap();
        assert!((t.at_from - 1.0).abs() < 1e-9 && (t.at_to - 3.0).abs() < 1e-9);
        assert!((t.per_month - 3.044).abs() < 1e-6);
        assert!(trend_line(&points[..1], 0, DAY).is_none());
        assert!(
            trend_line(&[p(3, 1.0), p(3, 2.0)], 0, DAY).is_none(),
            "no span, no slope"
        );
    }

    #[test]
    fn the_smoothed_curve_is_sampled_between_first_and_last_reading() {
        let points = [p(0, 1.0), p(10, 3.0), p(20, 1.0)];
        let curve = smooth_curve(&points, 0, 20 * DAY, 4);
        assert_eq!(curve.len(), 5);
        assert_eq!(curve[0].at, 0);
        assert_eq!(curve[4].at, 20 * DAY);
        assert!(curve[2].value > curve[0].value, "the bump shows");
        assert!(curve.iter().all(|c| c.value >= 1.0 && c.value <= 3.0));
        assert_eq!(smooth_curve(&points[..1], 0, DAY, 4), points[..1].to_vec());
    }

    #[test]
    fn readings_come_from_the_history_oldest_first() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        c.create_cat("cat:a", "Miezi", None, "cat").unwrap();
        c.append_at(
            "cat:a",
            "f:weight",
            Some("3200"),
            Some("2026-01-20T00:00:00Z"),
            false,
        )
        .unwrap();
        c.append_at(
            "cat:a",
            "f:weight",
            Some("3000"),
            Some("2026-01-05T00:00:00Z"),
            false,
        )
        .unwrap();
        c.append_at(
            "cat:a",
            "f:weight",
            Some("heavy"),
            Some("2026-01-10T00:00:00Z"),
            false,
        )
        .unwrap();
        c.append_at(
            "cat:a",
            "f:weight",
            Some("9999"),
            Some("2027-01-10T00:00:00Z"),
            true,
        )
        .unwrap();
        let points = c.history_points("cat:a", "f:weight").unwrap();
        assert_eq!(
            points.iter().map(|p| p.value).collect::<Vec<_>>(),
            vec![3000.0, 3200.0]
        );
    }
}
