//! Every Catalog on this device. One Catalog is a folder holding its
//! database and its photos, self-contained: copying the folder copies
//! the whole Catalog. Its display name lives inside it; the registry
//! only lists the names and remembers which one was open last.
//!
//! Layout under the root directory:
//!
//! ```text
//! registry.json                the list and the active one
//! catalogs/<id>/catalog.db     one Catalog
//! catalogs/<id>/images/        its photos
//! ```

use std::path::{Path, PathBuf};

use serde::{Deserialize, Serialize};

use crate::Result;
use crate::catalog::Catalog;
use crate::error::Error;

/// Where a Catalog keeps its own display name.
pub const CATALOG_NAME_KEY: &str = "catalogName";

/// One Catalog on disk.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct CatalogInfo {
    pub id: String,
    pub name: String,
    pub created: String,
}

#[derive(Debug, Default, Serialize, Deserialize)]
struct Registry {
    catalogs: Vec<CatalogInfo>,
    active: Option<String>,
}

pub struct CatalogManager {
    root: PathBuf,
    registry: Registry,
}

impl CatalogManager {
    /// Opens the manager, creating the layout and a first Catalog named
    /// `default_name` when there is none.
    pub fn open(root: &Path, default_name: &str) -> Result<CatalogManager> {
        std::fs::create_dir_all(root.join("catalogs")).map_err(|e| Error::io(root, e))?;
        let path = root.join("registry.json");
        let registry = match std::fs::read_to_string(&path) {
            Ok(text) => serde_json::from_str(&text)?,
            Err(_) => Registry::default(),
        };
        let mut manager = CatalogManager {
            root: root.to_path_buf(),
            registry,
        };
        if manager.registry.catalogs.is_empty() {
            manager.create(default_name)?;
        }
        Ok(manager)
    }

    fn save(&self) -> Result<()> {
        let path = self.root.join("registry.json");
        let text = serde_json::to_string_pretty(&self.registry)?;
        std::fs::write(&path, text).map_err(|e| Error::io(&path, e))
    }

    pub fn root(&self) -> &Path {
        &self.root
    }

    /// The Catalog's folder.
    pub fn dir(&self, id: &str) -> PathBuf {
        self.root.join("catalogs").join(id)
    }

    /// Every Catalog, oldest first.
    pub fn catalogs(&self) -> &[CatalogInfo] {
        &self.registry.catalogs
    }

    pub fn by_id(&self, id: &str) -> Option<&CatalogInfo> {
        self.registry.catalogs.iter().find(|c| c.id == id)
    }

    /// The Catalog to open on launch: the one last used, or the first.
    pub fn active(&self) -> &CatalogInfo {
        self.registry
            .active
            .as_deref()
            .and_then(|id| self.by_id(id))
            .unwrap_or(&self.registry.catalogs[0])
    }

    pub fn set_active(&mut self, id: &str) -> Result<()> {
        if self.by_id(id).is_none() {
            return Err(Error::Invalid(format!("No catalog {id}")));
        }
        self.registry.active = Some(id.to_string());
        self.save()
    }

    /// Opens a Catalog's store.
    pub fn open_store(&self, info: &CatalogInfo) -> Result<Catalog> {
        Catalog::open(&self.dir(&info.id))
    }

    /// Creates an empty Catalog. Names are unique so the switcher and
    /// the backup files stay unambiguous.
    pub fn create(&mut self, name: &str) -> Result<CatalogInfo> {
        let clean = name.trim();
        if clean.is_empty() {
            return Err(Error::Invalid("A catalog needs a name".into()));
        }
        self.require_free_name(clean)?;
        let mut bytes = [0u8; 16];
        getrandom::fill(&mut bytes)
            .map_err(|e| Error::Invalid(format!("no randomness for a catalog id: {e}")))?;
        let info = CatalogInfo {
            id: hex::encode(bytes),
            name: clean.to_string(),
            created: chrono::Utc::now().to_rfc3339_opts(chrono::SecondsFormat::Micros, true),
        };
        // The name lives in the Catalog too, so a copied folder is complete.
        let store = self.open_store(&info)?;
        store.set_local_setting(CATALOG_NAME_KEY, clean)?;
        drop(store);
        self.registry.catalogs.push(info.clone());
        if self.registry.active.is_none() {
            self.registry.active = Some(info.id.clone());
        }
        self.save()?;
        Ok(info)
    }

    pub fn rename(&mut self, id: &str, name: &str) -> Result<()> {
        let clean = name.trim();
        if clean.is_empty() {
            return Err(Error::Invalid("A catalog needs a name".into()));
        }
        let Some(current) = self.by_id(id).cloned() else {
            return Ok(());
        };
        if current.name != clean {
            self.require_free_name(clean)?;
        }
        let store = self.open_store(&current)?;
        store.set_local_setting(CATALOG_NAME_KEY, clean)?;
        drop(store);
        if let Some(c) = self.registry.catalogs.iter_mut().find(|c| c.id == id) {
            c.name = clean.to_string();
        }
        self.save()
    }

    /// Removes a Catalog and everything in it. The caller writes the
    /// keepsake bundle first: this is the point of no return. The last
    /// Catalog and the active one are refused.
    pub fn delete(&mut self, id: &str) -> Result<()> {
        let Some(info) = self.by_id(id).cloned() else {
            return Ok(());
        };
        if self.registry.catalogs.len() == 1 {
            return Err(Error::Invalid("The last catalog cannot be deleted".into()));
        }
        if self.active().id == id {
            return Err(Error::Invalid(
                "Switch to another catalog before deleting this one".into(),
            ));
        }
        let dir = self.dir(&info.id);
        if dir.exists() {
            std::fs::remove_dir_all(&dir).map_err(|e| Error::io(&dir, e))?;
        }
        self.registry.catalogs.retain(|c| c.id != id);
        self.save()
    }

    fn require_free_name(&self, name: &str) -> Result<()> {
        let taken = self
            .registry
            .catalogs
            .iter()
            .any(|c| c.name.to_lowercase() == name.to_lowercase());
        if taken {
            return Err(Error::Invalid(format!(
                "A catalog named \"{name}\" already exists"
            )));
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_manager_starts_with_one_catalog_and_manages_more() {
        let dir = tempfile::tempdir().unwrap();
        let mut m = CatalogManager::open(dir.path(), "Clowders").unwrap();
        assert_eq!(m.catalogs().len(), 1);
        assert_eq!(m.active().name, "Clowders");
        let store = m.open_store(m.active()).unwrap();
        assert_eq!(
            store.local_setting(CATALOG_NAME_KEY).as_deref(),
            Some("Clowders")
        );
        drop(store);
        let leipzig = m.create(" Leipzig ").unwrap();
        assert_eq!(leipzig.name, "Leipzig");
        assert!(m.create("leipzig").is_err(), "names are unique, case aside");
        assert!(m.create("  ").is_err());
        assert!(m.dir(&leipzig.id).join("catalog.db").exists());
        m.rename(&leipzig.id, "Leipzig Nord").unwrap();
        m.rename(&leipzig.id, "Leipzig Nord").unwrap();
        assert!(m.rename(&leipzig.id, "Clowders").is_err());
        assert!(m.rename(&leipzig.id, "").is_err());
        m.rename("nobody", "x").unwrap();
        assert_eq!(m.by_id(&leipzig.id).unwrap().name, "Leipzig Nord");
        // The registry survives reopening; the active catalog is remembered.
        m.set_active(&leipzig.id).unwrap();
        assert!(m.set_active("nobody").is_err());
        let m2 = CatalogManager::open(dir.path(), "ignored").unwrap();
        assert_eq!(m2.catalogs().len(), 2);
        assert_eq!(m2.active().id, leipzig.id);
        assert!(m2.root().join("registry.json").exists());
        // Deleting: not the active one, not the last one.
        let mut m2 = m2;
        assert!(m2.delete(&leipzig.id).is_err());
        let first = m2.catalogs()[0].id.clone();
        m2.delete(&first).unwrap();
        assert_eq!(m2.catalogs().len(), 1);
        assert!(!m2.dir(&first).exists());
        assert!(m2.delete(&leipzig.id).is_err(), "the last one stays");
        m2.delete("nobody").unwrap();
    }

    #[test]
    fn a_broken_registry_is_an_error_not_a_crash() {
        let dir = tempfile::tempdir().unwrap();
        std::fs::write(dir.path().join("registry.json"), "junk").unwrap();
        assert!(CatalogManager::open(dir.path(), "x").is_err());
    }
}
