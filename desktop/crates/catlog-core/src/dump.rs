//! The state of a Catalog as the fixture corpus records it: what came
//! from partners, projected and raw. The Dart core writes the same
//! picture (`packages/catalog_core/tool/fixtures/dump.dart`); the two
//! must agree for every scenario.

use serde_json::{Map, Value, json};

use crate::Result;
use crate::catalog::Catalog;
use crate::keys;

impl Catalog {
    /// The corpus dump: version vector, entities with their current
    /// fields, the photos present, and every foreign entry as it travels.
    pub fn dump(&self) -> Result<Value> {
        self.dump_with(false)
    }

    /// The dump as a partner would see this Catalog: own rows included.
    /// What the reverse corpus records for the Dart core to reproduce.
    pub fn dump_as_partner(&self) -> Result<Value> {
        self.dump_with(true)
    }

    fn dump_with(&self, include_own: bool) -> Result<Value> {
        let me = if include_own {
            String::new()
        } else {
            self.device_id()
        };
        let mut vector = Map::new();
        for (device, max) in self.version_vector()? {
            if device != me {
                vector.insert(device, json!(max));
            }
        }
        let all = self.all_entries()?;
        // An entity counts once a partner wrote a row for it: the reader's
        // own rows are its own business.
        let foreign: std::collections::HashSet<&str> = all
            .iter()
            .filter(|e| e.device != me)
            .map(|e| e.entity.as_str())
            .collect();
        let mut entities = Map::new();
        let mut blobs = std::collections::BTreeSet::new();
        for view in self.clowders()?.into_iter().chain(self.cats(None)?) {
            if !foreign.contains(view.id.as_str()) {
                continue;
            }
            entities.insert(view.id.clone(), self.dump_entity(&view.id)?);
            for hash in self.images(&view.id)? {
                if self.image_bytes(&hash).is_some() {
                    blobs.insert(hash);
                }
            }
        }
        for id in self.field_def_ids()? {
            if foreign.contains(id.as_str()) {
                entities.insert(id.clone(), self.dump_entity(&id)?);
            }
        }
        let entries: Vec<Value> = all
            .into_iter()
            .filter(|e| e.device != me)
            .map(|e| serde_json::to_value(e.wire()))
            .collect::<std::result::Result<_, _>>()?;
        Ok(json!({
            "vector": vector,
            "entities": entities,
            "blobs": blobs,
            "entries": entries,
        }))
    }

    fn dump_entity(&self, id: &str) -> Result<Value> {
        let fields = self.current_fields(id)?;
        let kind = fields.get(keys::TYPE).cloned().flatten();
        let mut out = Map::new();
        out.insert("kind".into(), json!(kind));
        out.insert("fields".into(), json!(fields));
        if matches!(
            kind.as_deref(),
            Some(keys::KIND_CAT) | Some(keys::KIND_CLOWDER)
        ) {
            out.insert("images".into(), json!(self.images(id)?));
            out.insert("profile".into(), json!(self.profile_image(id)?));
        }
        Ok(Value::Object(out))
    }
}
