//! Reserved field keys, the same strings the phones write. User-defined
//! Fields are keyed `f:<slug>`.

/// Entity kind: `cat`, `clowder`, or `fielddef`.
pub const TYPE: &str = "$type";
/// `true` when the entity is deleted (hidden everywhere).
pub const DELETED: &str = "$deleted";
/// Alias merge: set on the loser, value = survivor entity id.
pub const MERGED_INTO: &str = "$mergedInto";
/// Concurrent-edit flag for one field: `$conflict:<field>`.
pub const CONFLICT_PREFIX: &str = "$conflict:";
/// A correction or removal of one entry: `$void:<device>:<dseq>`.
pub const VOID_PREFIX: &str = "$void:";
/// The value of a void marker that simply takes an entry back.
pub const VOID_REMOVED: &str = "removed";
/// Display name of a Cat, Clowder, or field definition.
pub const NAME: &str = "name";
/// A Cat's Clowder membership; a null value means Stray.
pub const CLOWDER: &str = "clowder";
/// A Cat's chosen profile image (content hash).
pub const PROFILE_IMAGE: &str = "$profile";
/// Per-image presence marker: `$image:<hash>`, value `added`/`deleted`.
pub const IMAGE_PREFIX: &str = "$image:";
/// `yes` while the entity is Private.
pub const PRIVATE: &str = "$private";
/// Per-value privacy: `$private:<field>`.
pub const PRIVATE_PREFIX: &str = "$private:";
/// The public trace of a withheld value: `$withheld:<field>`.
pub const WITHHELD_PREFIX: &str = "$withheld:";
/// An appointment: `$appt:<id>`.
pub const APPOINTMENT_PREFIX: &str = "$appt:";
/// A chore: `$chore:<id>`, a tick `$chore:<id>@<day>`.
pub const CHORE_PREFIX: &str = "$chore:";
/// A person's own record: `person:<device>`.
pub const PERSON_PREFIX: &str = "person:";
/// The title a person wears, `rank|chore`, on their own record.
pub const PERSON_TITLE: &str = "title";

/// Field-definition properties.
pub const FIELD_TYPE: &str = "type";
pub const FIELD_SCOPE: &str = "scope";
pub const FIELD_OPTIONS: &str = "options";
pub const FIELD_OPTIONS_PREFIX: &str = "options:";
pub const FIELD_ID_DISPLAY: &str = "iddisplay";
pub const FIELD_LOOKUP_URL: &str = "lookup";
pub const FIELD_DIMENSION: &str = "dimension";

/// Entity kinds stored under [`TYPE`].
pub const KIND_CAT: &str = "cat";
pub const KIND_CLOWDER: &str = "clowder";
pub const KIND_FIELD_DEF: &str = "fielddef";

pub fn image(hash: &str) -> String {
    format!("{IMAGE_PREFIX}{hash}")
}

pub fn user_field(slug: &str) -> String {
    format!("f:{slug}")
}

pub fn conflict(field: &str) -> String {
    format!("{CONFLICT_PREFIX}{field}")
}

pub fn private_field(field: &str) -> String {
    format!("{PRIVATE_PREFIX}{field}")
}

pub fn withheld(field: &str) -> String {
    format!("{WITHHELD_PREFIX}{field}")
}

pub fn voided(device: &str, dseq: i64) -> String {
    format!("{VOID_PREFIX}{device}:{dseq}")
}

pub fn person(device: &str) -> String {
    format!("{PERSON_PREFIX}{device}")
}

/// Fields that carry no personal detail and hold the catalog together;
/// never private, on any entity.
pub fn is_structural(field: &str) -> bool {
    field == TYPE
        || field == NAME
        || field == CLOWDER
        || field == DELETED
        || field == MERGED_INTO
        || field == PRIVATE
        || field.starts_with(PRIVATE_PREFIX)
        || field.starts_with(WITHHELD_PREFIX)
        || field.starts_with(CONFLICT_PREFIX)
        || field.starts_with(VOID_PREFIX)
}

/// True when entries of `field` may be corrected or removed.
pub fn is_correctable(field: &str) -> bool {
    field != TYPE
        && field != DELETED
        && field != MERGED_INTO
        && !field.starts_with(CONFLICT_PREFIX)
        && !field.starts_with(VOID_PREFIX)
        && !field.starts_with(IMAGE_PREFIX)
}

/// Fields worth a conflict badge: what a keeper reads and can judge.
pub fn is_conflictable(field: &str) -> bool {
    is_correctable(field)
        && field != PRIVATE
        && field != PROFILE_IMAGE
        && !field.starts_with(PRIVATE_PREFIX)
        && !field.starts_with(WITHHELD_PREFIX)
        && !field.starts_with(APPOINTMENT_PREFIX)
        && !field.starts_with(CHORE_PREFIX)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn structural_fields_hold_the_catalog_together() {
        assert!(is_structural(TYPE));
        assert!(is_structural(&withheld("f:phone")));
        assert!(!is_structural("f:phone"));
        assert!(!is_structural(&image("abc")));
    }

    #[test]
    fn bookkeeping_fields_never_get_a_conflict_badge() {
        assert!(is_conflictable("f:color"));
        assert!(!is_conflictable(PROFILE_IMAGE));
        assert!(!is_conflictable(&image("abc")));
        assert!(!is_correctable(MERGED_INTO));
        assert_eq!(voided("d", 3), "$void:d:3");
        assert_eq!(person("d"), "person:d");
        assert_eq!(conflict("name"), "$conflict:name");
        assert_eq!(private_field("f:x"), "$private:f:x");
        assert_eq!(user_field("x"), "f:x");
    }
}
