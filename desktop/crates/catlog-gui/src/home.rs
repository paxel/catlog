//! What lies on the desk, and the Clowder rows the Clowders table
//! shows: faces and counts, favourites first, hidden ones on request.

use catlog_core::{Catalog, EntityView};

/// What was opened last: a Clowder or a Cat, or nothing yet. The views
/// and the modals live beside it.
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub enum Selection {
    #[default]
    None,
    Clowder(String),
    Cat(String),
}

/// What the keeper did on the home pane this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum HomeAction {
    None,
    Open(Selection),
    ToggleFavourite(String),
    ToggleHidden(String),
    NewClowder,
}

/// One row as the pane draws it, worked out before drawing.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ClowderRow {
    pub view: EntityView,
    pub favourite: bool,
    pub hidden: bool,
    /// Profile image hashes of up to five of its Cats.
    pub faces: Vec<String>,
    pub cat_count: usize,
}

/// How many faces a row shows before the count takes over.
pub const FACES_SHOWN: usize = 5;

/// The rows in the order the pane shows them: favourites first, then
/// creation order; hidden ones only when asked for.
pub fn clowder_rows(store: &Catalog, show_hidden: bool) -> catlog_core::Result<Vec<ClowderRow>> {
    let mut rows = Vec::new();
    for view in store.clowders()? {
        let hidden = store.is_hidden(&view.id)?;
        if hidden && !show_hidden {
            continue;
        }
        let cats = store.cats(Some(&view.id))?;
        let mut faces = Vec::new();
        for cat in &cats {
            if faces.len() >= FACES_SHOWN {
                break;
            }
            if let Some(hash) = store.profile_image(&cat.id)? {
                faces.push(hash);
            }
        }
        rows.push(ClowderRow {
            favourite: store.local_setting(&format!("fav:{}", view.id)).as_deref() == Some("yes"),
            hidden,
            faces,
            cat_count: cats.len(),
            view,
        });
    }
    rows.sort_by_key(|r| !r.favourite);
    Ok(rows)
}

pub struct HomePane {
    pub selection: Selection,
    pub show_hidden: bool,
}

impl Default for HomePane {
    fn default() -> Self {
        HomePane {
            selection: Selection::None,
            show_hidden: false,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn rows_put_favourites_first_and_count_past_five_faces() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        store.create_clowder("clowder:a", "Alpha").unwrap();
        store.create_clowder("clowder:b", "Beta").unwrap();
        store.create_clowder("clowder:h", "Hidden").unwrap();
        for i in 0..7 {
            let id = format!("cat:{i}");
            store
                .create_cat(&id, &format!("Cat {i}"), Some("clowder:a"), "cat")
                .unwrap();
            store
                .add_image(&id, format!("photo {i}").as_bytes())
                .unwrap();
        }
        store.set_local_setting("fav:clowder:b", "yes").unwrap();
        store.set_hidden("clowder:h", true).unwrap();
        let rows = clowder_rows(&store, false).unwrap();
        assert_eq!(
            rows.iter()
                .map(|r| r.view.name.as_str())
                .collect::<Vec<_>>(),
            vec!["Beta", "Alpha"]
        );
        assert!(rows[0].favourite && !rows[1].favourite);
        assert_eq!(rows[1].faces.len(), FACES_SHOWN);
        assert_eq!(rows[1].cat_count, 7);
        let all = clowder_rows(&store, true).unwrap();
        assert_eq!(all.len(), 3);
        assert!(all[2].hidden);
    }
}
