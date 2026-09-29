//! What a starter Field value cannot be. The app knows what those Fields
//! mean, so it refuses the impossible: a birth after the death, a death
//! in the future, a pregnant tom, a female father, a parent younger than
//! its kitten. Custom Fields carry no meaning and are never checked;
//! clearing a value is always fine. A date at its own precision objects
//! only when its whole span is impossible.

use chrono::NaiveDate;

use crate::partial_date::PartialDate;
use crate::{Catalog, Result, keys};

/// Why a value is refused, with what it clashes with.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Objection {
    BirthdateInFuture,
    DeceasedInFuture,
    /// The birth date it lies before.
    DeceasedBeforeBirth(NaiveDate),
    /// The date of death it lies after.
    BornAfterDeceased(NaiveDate),
    MalePregnant,
    /// The named cat is female.
    FatherNotMale(String),
    /// The named cat is male.
    MotherNotFemale(String),
    /// The named parent and its birth.
    ParentBornAfterKitten(String, NaiveDate),
    GenderFatherFemale,
    GenderMotherMale,
}

fn date(value: Option<&str>) -> Option<PartialDate> {
    PartialDate::parse(value?)
}

impl Catalog {
    /// The objection to `value` for the starter Field `slug` on `entity`,
    /// as of `today`; none for a custom Field, a cleared value or a
    /// plausible one.
    pub fn starter_objection(
        &self,
        entity: &str,
        slug: &str,
        value: Option<&str>,
        today: NaiveDate,
    ) -> Result<Option<Objection>> {
        let Some(value) = value.filter(|v| !v.is_empty()) else {
            return Ok(None);
        };
        let field = |s: &str| self.current(entity, &keys::user_field(s));
        Ok(match slug {
            "birthdate" => {
                let Some(born) = date(Some(value)) else {
                    return Ok(None);
                };
                if born.earliest().is_some_and(|d| d > today) {
                    return Ok(Some(Objection::BirthdateInFuture));
                }
                match date(field("deceased")?.as_deref()).and_then(|d| d.latest()) {
                    Some(died) if born.earliest().is_some_and(|b| b > died) => {
                        Some(Objection::BornAfterDeceased(died))
                    }
                    _ => None,
                }
            }
            "deceased" => {
                let Some(died) = date(Some(value)) else {
                    return Ok(None);
                };
                if died.earliest().is_some_and(|d| d > today) {
                    return Ok(Some(Objection::DeceasedInFuture));
                }
                match date(field("birthdate")?.as_deref()).and_then(|d| d.earliest()) {
                    Some(born) if died.latest().is_some_and(|d| d < born) => {
                        Some(Objection::DeceasedBeforeBirth(born))
                    }
                    _ => None,
                }
            }
            "pregnant" => {
                if value == "yes" && field("gender")?.as_deref() == Some("male") {
                    Some(Objection::MalePregnant)
                } else {
                    None
                }
            }
            "father" => self.parent_objection(entity, value, "female")?,
            "mother" => self.parent_objection(entity, value, "male")?,
            "gender" => {
                if value == "female" && self.has_kittens_as(entity, "father")? {
                    Some(Objection::GenderFatherFemale)
                } else if value == "male" && self.has_kittens_as(entity, "mother")? {
                    Some(Objection::GenderMotherMale)
                } else {
                    None
                }
            }
            _ => None,
        })
    }

    /// A father is not female, a mother not male, and no parent is born
    /// on or after its kitten's birth.
    fn parent_objection(
        &self,
        kitten: &str,
        parent: &str,
        wrong_gender: &str,
    ) -> Result<Option<Objection>> {
        let parent = self.resolve_entity(parent)?;
        let name = self
            .current(&parent, keys::NAME)?
            .unwrap_or_else(|| "?".to_string());
        if self
            .current(&parent, &keys::user_field("gender"))?
            .as_deref()
            == Some(wrong_gender)
        {
            return Ok(Some(if wrong_gender == "female" {
                Objection::FatherNotMale(name)
            } else {
                Objection::MotherNotFemale(name)
            }));
        }
        let parent_born = date(
            self.current(&parent, &keys::user_field("birthdate"))?
                .as_deref(),
        )
        .and_then(|d| d.earliest());
        let kitten_born = date(
            self.current(kitten, &keys::user_field("birthdate"))?
                .as_deref(),
        )
        .and_then(|d| d.latest());
        Ok(match (parent_born, kitten_born) {
            (Some(p), Some(k)) if p >= k => Some(Objection::ParentBornAfterKitten(name, p)),
            _ => None,
        })
    }

    /// Whether any cat names `entity` as its `role`, father or mother.
    fn has_kittens_as(&self, entity: &str, role: &str) -> Result<bool> {
        let me = self.resolve_entity(entity)?;
        for cat in self.cats(None)? {
            if let Some(parent) = self.current(&cat.id, &keys::user_field(role))?
                && self.resolve_entity(&parent).ok().as_deref() == Some(me.as_str())
            {
                return Ok(true);
            }
        }
        Ok(false)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn day(y: i32, m: u32, d: u32) -> NaiveDate {
        NaiveDate::from_ymd_opt(y, m, d).unwrap()
    }

    #[test]
    fn the_impossible_is_refused_and_the_merely_odd_is_not() {
        let dir = tempfile::tempdir().unwrap();
        let mut c = Catalog::open(dir.path()).unwrap();
        c.set_author("Ada").unwrap();
        c.create_cat("cat:k", "Kitten", None, "cat").unwrap();
        c.create_cat("cat:d", "Dad", None, "cat").unwrap();
        c.create_cat("cat:m", "Mum", None, "cat").unwrap();
        let today = day(2026, 3, 10);
        let ask = |c: &Catalog, e: &str, s: &str, v: &str| {
            c.starter_objection(e, s, Some(v), today).unwrap()
        };
        assert_eq!(
            ask(&c, "cat:k", "birthdate", "2027"),
            Some(Objection::BirthdateInFuture)
        );
        assert_eq!(
            ask(&c, "cat:k", "birthdate", "2026"),
            None,
            "the year still holds today"
        );
        assert_eq!(
            ask(&c, "cat:k", "deceased", "2026-03-11"),
            Some(Objection::DeceasedInFuture)
        );
        c.append("cat:k", "f:birthdate", Some("2024-05")).unwrap();
        assert_eq!(
            ask(&c, "cat:k", "deceased", "2024-04-30"),
            Some(Objection::DeceasedBeforeBirth(day(2024, 5, 1)))
        );
        assert_eq!(
            ask(&c, "cat:k", "deceased", "2024-05"),
            None,
            "the same month may hold both"
        );
        c.append("cat:k", "f:deceased", Some("2025-01-01")).unwrap();
        assert_eq!(
            ask(&c, "cat:k", "birthdate", "2025-02"),
            Some(Objection::BornAfterDeceased(day(2025, 1, 1)))
        );
        // Custom fields and cleared values pass; so does a text that is no date.
        assert_eq!(ask(&c, "cat:k", "remarks", "2027"), None);
        assert_eq!(
            c.starter_objection("cat:k", "birthdate", None, today)
                .unwrap(),
            None
        );
        assert_eq!(ask(&c, "cat:k", "birthdate", "soon"), None);
        // Genders and parents.
        c.append("cat:d", "f:gender", Some("female")).unwrap();
        c.append("cat:m", "f:gender", Some("male")).unwrap();
        assert_eq!(
            ask(&c, "cat:k", "father", "cat:d"),
            Some(Objection::FatherNotMale("Dad".into()))
        );
        assert_eq!(
            ask(&c, "cat:k", "mother", "cat:m"),
            Some(Objection::MotherNotFemale("Mum".into()))
        );
        c.append("cat:d", "f:gender", Some("male")).unwrap();
        c.append("cat:d", "f:birthdate", Some("2024-06-01"))
            .unwrap();
        assert_eq!(
            ask(&c, "cat:k", "father", "cat:d"),
            Some(Objection::ParentBornAfterKitten(
                "Dad".into(),
                day(2024, 6, 1)
            ))
        );
        c.append("cat:d", "f:birthdate", Some("2020")).unwrap();
        assert_eq!(ask(&c, "cat:k", "father", "cat:d"), None);
        c.append("cat:k", "f:father", Some("cat:d")).unwrap();
        assert_eq!(
            ask(&c, "cat:d", "gender", "female"),
            Some(Objection::GenderFatherFemale)
        );
        assert_eq!(ask(&c, "cat:d", "gender", "male"), None);
        assert_eq!(
            ask(&c, "cat:d", "pregnant", "yes"),
            Some(Objection::MalePregnant)
        );
        assert_eq!(ask(&c, "cat:d", "pregnant", "no"), None);
    }
}
