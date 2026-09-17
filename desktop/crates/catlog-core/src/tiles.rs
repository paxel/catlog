//! Map tiles from OpenStreetMap with a disk cache: once a tile was
//! seen, it renders offline forever. Visited areas only, no bulk
//! download; the oldest tiles go when the folder grows past its cap.

use std::path::{Path, PathBuf};

use crate::error::Error;

/// The tile server, and the name the app gives when asking it.
pub const TILE_URL: &str = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
pub const TILE_USER_AGENT: &str = "catlog/2.0 (+https://github.com/paxel/catlog)";

/// The largest tile response kept: OSM tiles are well under 100 KB.
pub const MAX_TILE_BYTES: usize = 2 << 20;

/// The disk cap: months of browsing a city otherwise pile up hundreds of MB.
pub const MAX_CACHE_BYTES: u64 = 200 << 20;

/// One tile's coordinates.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord)]
pub struct TileId {
    pub z: u32,
    pub x: u32,
    pub y: u32,
}

impl TileId {
    pub fn url(&self) -> String {
        TILE_URL
            .replace("{z}", &self.z.to_string())
            .replace("{x}", &self.x.to_string())
            .replace("{y}", &self.y.to_string())
    }

    fn file_name(&self) -> String {
        format!("{}_{}_{}.png", self.z, self.x, self.y)
    }
}

/// Where tile bytes come from: the network, or a stand-in in tests.
pub trait TileSource: Send + Sync {
    fn fetch(&self, tile: TileId) -> Result<Vec<u8>, String>;
}

/// The OpenStreetMap tile server.
pub struct OsmTiles;

impl TileSource for OsmTiles {
    fn fetch(&self, tile: TileId) -> Result<Vec<u8>, String> {
        let agent = ureq::Agent::config_builder()
            .user_agent(TILE_USER_AGENT)
            .timeout_global(Some(std::time::Duration::from_secs(15)))
            .build()
            .new_agent();
        let response = agent.get(&tile.url()).call().map_err(|e| e.to_string())?;
        let bytes = response
            .into_body()
            .with_config()
            .limit(MAX_TILE_BYTES as u64)
            .read_to_vec()
            .map_err(|e| e.to_string())?;
        Ok(bytes)
    }
}

/// Tiles from the cache, or from the source and then into the cache.
pub struct TileCache {
    dir: PathBuf,
    source: Box<dyn TileSource>,
}

impl TileCache {
    /// Opens the cache in `dir`, trimming it to the cap.
    pub fn open(dir: &Path, source: Box<dyn TileSource>) -> crate::Result<TileCache> {
        std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
        trim(dir, MAX_CACHE_BYTES);
        Ok(TileCache {
            dir: dir.to_path_buf(),
            source,
        })
    }

    pub fn dir(&self) -> &Path {
        &self.dir
    }

    /// The tile's bytes from disk, if it was ever seen.
    pub fn cached(&self, tile: TileId) -> Option<Vec<u8>> {
        std::fs::read(self.dir.join(tile.file_name())).ok()
    }

    /// The tile's bytes, fetched and kept when not cached yet.
    pub fn get(&self, tile: TileId) -> Result<Vec<u8>, String> {
        if let Some(bytes) = self.cached(tile) {
            return Ok(bytes);
        }
        let bytes = self.source.fetch(tile)?;
        if bytes.len() > MAX_TILE_BYTES || bytes.is_empty() {
            return Err(format!(
                "tile {} is not a tile ({} bytes)",
                tile.url(),
                bytes.len()
            ));
        }
        let path = self.dir.join(tile.file_name());
        let tmp = path.with_extension("png.tmp");
        if std::fs::write(&tmp, &bytes).is_ok() {
            let _ = std::fs::rename(&tmp, &path);
        }
        Ok(bytes)
    }
}

/// Deletes the least recently modified tiles until `dir` holds at most
/// `max_bytes`.
pub fn trim(dir: &Path, max_bytes: u64) {
    let Ok(entries) = std::fs::read_dir(dir) else {
        return;
    };
    let mut files: Vec<(PathBuf, u64, std::time::SystemTime)> = entries
        .filter_map(|e| e.ok())
        .filter_map(|e| {
            let meta = e.metadata().ok()?;
            meta.is_file().then(|| {
                (
                    e.path(),
                    meta.len(),
                    meta.modified().unwrap_or(std::time::UNIX_EPOCH),
                )
            })
        })
        .collect();
    let mut total: u64 = files.iter().map(|f| f.1).sum();
    if total <= max_bytes {
        return;
    }
    files.sort_by_key(|f| f.2);
    for (path, size, _) in files {
        if total <= max_bytes {
            break;
        }
        if std::fs::remove_file(&path).is_ok() {
            total -= size;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::sync::Mutex;

    struct Counting {
        calls: Mutex<usize>,
        bytes: Vec<u8>,
    }

    impl TileSource for Counting {
        fn fetch(&self, _tile: TileId) -> Result<Vec<u8>, String> {
            *self.calls.lock().unwrap() += 1;
            if self.bytes.is_empty() {
                Err("no network".into())
            } else {
                Ok(self.bytes.clone())
            }
        }
    }

    #[test]
    fn tiles_are_fetched_once_and_then_read_from_disk() {
        let dir = tempfile::tempdir().unwrap();
        let cache = TileCache::open(
            &dir.path().join("tiles"),
            Box::new(Counting {
                calls: Mutex::new(0),
                bytes: vec![1, 2, 3],
            }),
        )
        .unwrap();
        let tile = TileId { z: 6, x: 34, y: 21 };
        assert_eq!(tile.url(), "https://tile.openstreetmap.org/6/34/21.png");
        assert!(cache.cached(tile).is_none());
        assert_eq!(cache.get(tile).unwrap(), vec![1, 2, 3]);
        assert_eq!(cache.get(tile).unwrap(), vec![1, 2, 3]);
        assert!(cache.dir().join("6_34_21.png").exists());
        assert!(cache.cached(tile).is_some());
    }

    #[test]
    fn a_failed_fetch_is_an_error_and_the_cache_is_trimmed_by_age() {
        let dir = tempfile::tempdir().unwrap();
        let cache = TileCache::open(
            dir.path(),
            Box::new(Counting {
                calls: Mutex::new(0),
                bytes: vec![],
            }),
        )
        .unwrap();
        assert!(cache.get(TileId { z: 1, x: 0, y: 0 }).is_err());
        for i in 0..5u32 {
            std::fs::write(dir.path().join(format!("1_{i}_0.png")), vec![0u8; 100]).unwrap();
            let t = std::time::SystemTime::UNIX_EPOCH
                + std::time::Duration::from_secs(1_000 + i as u64);
            let f = std::fs::File::open(dir.path().join(format!("1_{i}_0.png"))).unwrap();
            f.set_modified(t).unwrap();
        }
        trim(dir.path(), 250);
        let left: Vec<String> = std::fs::read_dir(dir.path())
            .unwrap()
            .filter_map(|e| e.ok().map(|e| e.file_name().to_string_lossy().into_owned()))
            .collect();
        assert_eq!(left.len(), 2);
        assert!(left.contains(&"1_4_0.png".to_string()) && left.contains(&"1_3_0.png".to_string()));
        trim(&dir.path().join("nowhere"), 1);
    }
}
