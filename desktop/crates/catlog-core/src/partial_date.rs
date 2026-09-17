//! A date known to the day, the month, or only the year. Stored as
//! `YYYY`, `YYYY-MM` or `YYYY-MM-DD`: exactly what is known, never
//! padded, so the three forms sort correctly as plain strings.

use chrono::{Datelike, NaiveDate};

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct PartialDate {
    pub year: i32,
    pub month: Option<u32>,
    pub day: Option<u32>,
}

impl PartialDate {
    /// Day precision: the only form a scheduled thing accepts.
    pub fn is_full(&self) -> bool {
        self.day.is_some()
    }

    /// The stored form.
    pub fn iso(&self) -> String {
        let mut s = format!("{:04}", self.year);
        if let Some(m) = self.month {
            s.push_str(&format!("-{m:02}"));
        }
        if let Some(d) = self.day {
            s.push_str(&format!("-{d:02}"));
        }
        s
    }

    /// First day of the period.
    pub fn earliest(&self) -> Option<NaiveDate> {
        NaiveDate::from_ymd_opt(self.year, self.month.unwrap_or(1), self.day.unwrap_or(1))
    }

    /// Last day of the period.
    pub fn latest(&self) -> Option<NaiveDate> {
        match (self.month, self.day) {
            (Some(m), Some(d)) => NaiveDate::from_ymd_opt(self.year, m, d),
            (Some(m), None) => {
                let next = if m == 12 {
                    NaiveDate::from_ymd_opt(self.year + 1, 1, 1)
                } else {
                    NaiveDate::from_ymd_opt(self.year, m + 1, 1)
                };
                next.and_then(|n| n.pred_opt())
            }
            _ => NaiveDate::from_ymd_opt(self.year, 12, 31),
        }
    }

    /// The stored form parsed back; none for anything else.
    pub fn parse(value: &str) -> Option<PartialDate> {
        let s = value.trim();
        let parts: Vec<&str> = s.split('-').collect();
        match parts.as_slice() {
            [y] if y.len() == 4 => checked(y.parse().ok()?, None, None),
            [y, m] if y.len() == 4 && m.len() == 2 => {
                checked(y.parse().ok()?, Some(m.parse().ok()?), None)
            }
            [y, m, d] if y.len() == 4 && m.len() == 2 && d.len() == 2 => checked(
                y.parse().ok()?,
                Some(m.parse().ok()?),
                Some(d.parse().ok()?),
            ),
            _ => None,
        }
    }

    /// A date as people type or posters print it: `2021`, `5/2021`,
    /// `05.2021`, `2021-05`, `14.05.2021`, `5.6.2025`, `14/05/2021`,
    /// `2021-05-14`. Day-month order is day first.
    pub fn parse_loose(text: &str) -> Option<PartialDate> {
        let s = text.trim();
        if let Some(d) = Self::parse(s) {
            return Some(d);
        }
        let digits = |p: &str, min: usize, max: usize| -> Option<u32> {
            ((min..=max).contains(&p.len()) && p.bytes().all(|b| b.is_ascii_digit()))
                .then(|| p.parse().ok())
                .flatten()
        };
        let parts: Vec<&str> = s.split(['.', '/']).collect();
        match parts.as_slice() {
            [d, m, y] => checked(
                digits(y, 4, 4)? as i32,
                Some(digits(m, 1, 2)?),
                Some(digits(d, 1, 2)?),
            ),
            [a, b] => {
                if let (Some(m), Some(y)) = (digits(a, 1, 2), digits(b, 4, 4)) {
                    checked(y as i32, Some(m), None)
                } else if let (Some(y), Some(m)) = (digits(a, 4, 4), digits(b, 1, 2)) {
                    checked(y as i32, Some(m), None)
                } else {
                    None
                }
            }
            _ => None,
        }
    }

    /// Full years and months elapsed at `today`, as far as the precision
    /// allows: a year-only date yields no months. None before the date.
    pub fn age_at(&self, today: NaiveDate) -> Option<(i32, Option<i32>)> {
        let mut years = today.year() - self.year;
        let Some(month) = self.month else {
            return (years >= 0).then_some((years, None));
        };
        let mut months = today.month() as i32 - month as i32;
        if let Some(day) = self.day
            && today.day() < day
        {
            months -= 1;
        }
        if months < 0 {
            years -= 1;
            months += 12;
        }
        (years >= 0).then_some((years, Some(months)))
    }
}

fn checked(y: i32, m: Option<u32>, d: Option<u32>) -> Option<PartialDate> {
    if !(1000..=9999).contains(&y) {
        return None;
    }
    if let Some(m) = m
        && !(1..=12).contains(&m)
    {
        return None;
    }
    if let Some(d) = d {
        let m = m?;
        if !(1..=31).contains(&d) || NaiveDate::from_ymd_opt(y, m, d).is_none() {
            return None;
        }
    }
    Some(PartialDate {
        year: y,
        month: m,
        day: d,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    fn date(y: i32, m: u32, d: u32) -> NaiveDate {
        NaiveDate::from_ymd_opt(y, m, d).unwrap()
    }

    #[test]
    fn the_stored_form_says_exactly_what_is_known() {
        let full = PartialDate::parse("2021-05-14").unwrap();
        assert_eq!(full.iso(), "2021-05-14");
        assert!(full.is_full());
        assert_eq!(full.earliest(), Some(date(2021, 5, 14)));
        assert_eq!(full.latest(), Some(date(2021, 5, 14)));
        let month = PartialDate::parse("2021-05").unwrap();
        assert_eq!(month.earliest(), Some(date(2021, 5, 1)));
        assert_eq!(month.latest(), Some(date(2021, 5, 31)));
        assert_eq!(
            PartialDate::parse("2021-12").unwrap().latest(),
            Some(date(2021, 12, 31))
        );
        let year = PartialDate::parse("2021").unwrap();
        assert_eq!(year.latest(), Some(date(2021, 12, 31)));
        assert!(year < month && month < full);
        for bad in ["2021-13", "2021-02-30", "21-05-14", "999", "2021-5-1", "x"] {
            assert_eq!(PartialDate::parse(bad), None, "{bad}");
        }
    }

    #[test]
    fn loose_spellings_read_day_first() {
        assert_eq!(
            PartialDate::parse_loose("14.05.2021").unwrap().iso(),
            "2021-05-14"
        );
        assert_eq!(
            PartialDate::parse_loose("5.6.2025").unwrap().iso(),
            "2025-06-05"
        );
        assert_eq!(
            PartialDate::parse_loose("14/05/2021").unwrap().iso(),
            "2021-05-14"
        );
        assert_eq!(PartialDate::parse_loose("5/2021").unwrap().iso(), "2021-05");
        assert_eq!(
            PartialDate::parse_loose("05.2021").unwrap().iso(),
            "2021-05"
        );
        assert_eq!(PartialDate::parse_loose("2021/5").unwrap().iso(), "2021-05");
        assert_eq!(PartialDate::parse_loose(" 2021 ").unwrap().iso(), "2021");
        assert_eq!(PartialDate::parse_loose("31.02.2021"), None);
        assert_eq!(PartialDate::parse_loose("a.b.c"), None);
        assert_eq!(PartialDate::parse_loose("1.2.3.4"), None);
    }

    #[test]
    fn ages_count_full_years_and_months() {
        let born = PartialDate::parse("2020-05-14").unwrap();
        assert_eq!(born.age_at(date(2021, 5, 13)), Some((0, Some(11))));
        assert_eq!(born.age_at(date(2021, 5, 14)), Some((1, Some(0))));
        assert_eq!(born.age_at(date(2019, 1, 1)), None);
        let year = PartialDate::parse("2020").unwrap();
        assert_eq!(year.age_at(date(2023, 1, 1)), Some((3, None)));
        assert_eq!(year.age_at(date(2019, 1, 1)), None);
        let month = PartialDate::parse("2020-11").unwrap();
        assert_eq!(month.age_at(date(2021, 3, 1)), Some((0, Some(4))));
    }
}
