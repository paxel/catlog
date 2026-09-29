//! A view's data, kept between frames. The desk asked the store for
//! everything on every frame, and with a real catalog that was seconds
//! per frame. The store counts its writes; a memo remembers the count
//! and the inputs it was built for, and rebuilds only when either moved.

use std::fmt;

use catlog_core::Catalog;

pub struct Memo<K, T> {
    built_for: Option<(u64, K)>,
    value: Option<T>,
}

impl<K, T> Default for Memo<K, T> {
    fn default() -> Self {
        Memo {
            built_for: None,
            value: None,
        }
    }
}

impl<K, T> fmt::Debug for Memo<K, T> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "Memo({})",
            if self.value.is_some() {
                "built"
            } else {
                "empty"
            }
        )
    }
}

impl<K: PartialEq, T> Memo<K, T> {
    /// The value for `key` at the store's current generation, built by
    /// `build` when the last one was for another generation or key.
    pub fn get(&mut self, store: &Catalog, key: K, build: impl FnOnce() -> T) -> &T {
        let generation = store.generation();
        let stale = match &self.built_for {
            Some((g, k)) => *g != generation || *k != key,
            None => true,
        };
        if stale {
            self.value = Some(build());
            self.built_for = Some((generation, key));
        }
        self.value.as_ref().expect("built just now")
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_memo_rebuilds_on_a_write_or_a_new_key_and_not_otherwise() {
        let dir = tempfile::tempdir().unwrap();
        let mut store = Catalog::open(dir.path()).unwrap();
        store.set_author("Ada").unwrap();
        let mut memo: Memo<bool, usize> = Memo::default();
        let mut builds = 0;
        let mut count = |memo: &mut Memo<bool, usize>, store: &Catalog, key: bool| {
            *memo.get(store, key, || {
                builds += 1;
                builds
            })
        };
        assert_eq!(count(&mut memo, &store, false), 1);
        assert_eq!(count(&mut memo, &store, false), 1, "same store, same key");
        assert_eq!(count(&mut memo, &store, true), 2, "another key");
        store.create_clowder("clowder:x", "X").unwrap();
        assert_eq!(count(&mut memo, &store, true), 3, "a write");
        store.set_local_setting("fav:clowder:x", "yes").unwrap();
        assert_eq!(count(&mut memo, &store, true), 4, "a local setting");
        assert_eq!(count(&mut memo, &store, true), 4);
    }
}
