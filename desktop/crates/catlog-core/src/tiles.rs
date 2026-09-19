//! Map tiles from OpenStreetMap with a disk cache: once a tile was
//! seen, it renders offline forever. Visited areas only, no bulk
//! download; the oldest tiles go when the folder grows past its cap.

use std::collections::{HashSet, VecDeque};
use std::path::{Path, PathBuf};
use std::sync::{Arc, Condvar, Mutex};
use std::thread::JoinHandle;

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

/// The OpenStreetMap tile server. The agent is built once and kept:
/// it holds the connection open, so the tiles after the first skip the
/// handshake.
pub struct OsmTiles {
    agent: ureq::Agent,
}

impl OsmTiles {
    pub fn new() -> OsmTiles {
        OsmTiles {
            agent: ureq::Agent::config_builder()
                .user_agent(TILE_USER_AGENT)
                .timeout_global(Some(std::time::Duration::from_secs(15)))
                .build()
                .new_agent(),
        }
    }
}

impl Default for OsmTiles {
    fn default() -> OsmTiles {
        OsmTiles::new()
    }
}

impl TileSource for OsmTiles {
    fn fetch(&self, tile: TileId) -> Result<Vec<u8>, String> {
        let response = self
            .agent
            .get(&tile.url())
            .call()
            .map_err(|e| e.to_string())?;
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

/// How many tiles travel at once. The OpenStreetMap tile policy asks a
/// client for no more than two connections, and two keep a pan filled.
pub const FETCH_WORKERS: usize = 2;

/// How many tiles may wait for a thread. A pan leaves what it flew over
/// behind; the view asks again for whatever it still wants.
const MAX_QUEUE: usize = 64;

/// What the view asked for and what became of it.
#[derive(Default)]
struct Wanted {
    queue: VecDeque<TileId>,
    inflight: HashSet<TileId>,
    failed: HashSet<TileId>,
    stop: bool,
}

/// Tiles fetched away from the drawing thread: the view says what it
/// wants, a fixed pair of threads fills the disk cache, and the view
/// finds them there on a later frame. The newest wish is served first,
/// so tiles that scrolled away never hold up the ones now on screen,
/// and a tile already on its way is never asked for twice.
pub struct TileFetcher {
    cache: Arc<TileCache>,
    wanted: Arc<(Mutex<Wanted>, Condvar)>,
    workers: Vec<JoinHandle<()>>,
}

impl TileFetcher {
    /// A fetcher with its threads.
    pub fn new(cache: Arc<TileCache>) -> TileFetcher {
        TileFetcher::with_workers(cache, FETCH_WORKERS)
    }

    /// A fetcher without threads: [`TileFetcher::want`] fetches there
    /// and then. Tests use it, so what a frame shows never depends on
    /// when a thread got around to its tile.
    pub fn inline(cache: Arc<TileCache>) -> TileFetcher {
        TileFetcher::with_workers(cache, 0)
    }

    fn with_workers(cache: Arc<TileCache>, workers: usize) -> TileFetcher {
        let wanted = Arc::new((Mutex::new(Wanted::default()), Condvar::new()));
        let threads = (0..workers)
            .map(|_| {
                let cache = cache.clone();
                let wanted = wanted.clone();
                std::thread::spawn(move || work(&cache, &wanted))
            })
            .collect();
        TileFetcher {
            cache,
            wanted,
            workers: threads,
        }
    }

    /// The cache the fetched tiles land in; the view reads them there.
    pub fn cache(&self) -> &Arc<TileCache> {
        &self.cache
    }

    /// Asks for a tile. Known, queued, in flight or failed: nothing
    /// happens.
    pub fn want(&self, tile: TileId) {
        if self.workers.is_empty() {
            if self.cache.get(tile).is_err() {
                self.lock().failed.insert(tile);
            }
            return;
        }
        let mut wanted = self.lock();
        if wanted.inflight.contains(&tile)
            || wanted.failed.contains(&tile)
            || wanted.queue.contains(&tile)
        {
            return;
        }
        wanted.queue.push_front(tile);
        wanted.queue.truncate(MAX_QUEUE);
        drop(wanted);
        self.wanted.1.notify_one();
    }

    /// Whether any tile is still on its way.
    pub fn busy(&self) -> bool {
        let wanted = self.lock();
        !wanted.queue.is_empty() || !wanted.inflight.is_empty()
    }

    /// Whether a tile was asked for and did not come.
    pub fn failed(&self, tile: TileId) -> bool {
        self.lock().failed.contains(&tile)
    }

    /// Tiles that failed may be asked for again, after the network came
    /// back.
    pub fn retry_failed(&self) {
        self.lock().failed.clear();
    }

    fn lock(&self) -> std::sync::MutexGuard<'_, Wanted> {
        self.wanted.0.lock().unwrap_or_else(|e| e.into_inner())
    }
}

impl Drop for TileFetcher {
    fn drop(&mut self) {
        self.lock().stop = true;
        self.wanted.1.notify_all();
        for worker in std::mem::take(&mut self.workers) {
            let _ = worker.join();
        }
    }
}

/// One fetching thread: takes the newest wish, fills the cache with it.
fn work(cache: &TileCache, wanted: &(Mutex<Wanted>, Condvar)) {
    let (lock, waiting) = wanted;
    loop {
        let mut state = lock.lock().unwrap_or_else(|e| e.into_inner());
        let tile = loop {
            if state.stop {
                return;
            }
            if let Some(tile) = state.queue.pop_front() {
                state.inflight.insert(tile);
                break tile;
            }
            state = waiting.wait(state).unwrap_or_else(|e| e.into_inner());
        };
        drop(state);
        let outcome = cache.get(tile);
        let mut state = lock.lock().unwrap_or_else(|e| e.into_inner());
        state.inflight.remove(&tile);
        if outcome.is_err() {
            state.failed.insert(tile);
        }
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

    /// The same counting source behind an `Arc`, so a test can read its
    /// tally while the cache holds it.
    struct Shared(Arc<Counting>);

    impl TileSource for Shared {
        fn fetch(&self, tile: TileId) -> Result<Vec<u8>, String> {
            self.0.fetch(tile)
        }
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

    /// Waits for the fetcher to go quiet, or gives up after a second.
    fn settled(fetcher: &TileFetcher) -> bool {
        for _ in 0..100 {
            if !fetcher.busy() {
                return true;
            }
            std::thread::sleep(std::time::Duration::from_millis(10));
        }
        false
    }

    #[test]
    fn the_fetcher_fills_the_cache_on_its_threads_and_asks_once_per_tile() {
        let dir = tempfile::tempdir().unwrap();
        let counting = Arc::new(Counting {
            calls: Mutex::new(0),
            bytes: vec![1, 2, 3],
        });
        let cache = TileCache::open(dir.path(), Box::new(Shared(counting.clone()))).unwrap();
        let fetcher = TileFetcher::new(Arc::new(cache));
        let tile = TileId { z: 6, x: 34, y: 21 };
        fetcher.want(tile);
        fetcher.want(tile);
        assert!(settled(&fetcher), "the fetcher never went quiet");
        assert_eq!(fetcher.cache().cached(tile), Some(vec![1, 2, 3]));
        assert_eq!(*counting.calls.lock().unwrap(), 1);
        assert!(!fetcher.failed(tile));
    }

    #[test]
    fn a_tile_that_does_not_come_is_failed_until_it_is_asked_for_again() {
        let dir = tempfile::tempdir().unwrap();
        let counting = Arc::new(Counting {
            calls: Mutex::new(0),
            bytes: vec![],
        });
        let cache = TileCache::open(dir.path(), Box::new(Shared(counting.clone()))).unwrap();
        let fetcher = TileFetcher::new(Arc::new(cache));
        let tile = TileId { z: 3, x: 1, y: 2 };
        fetcher.want(tile);
        assert!(settled(&fetcher), "the fetcher never went quiet");
        assert!(fetcher.failed(tile));
        // A failed tile is not asked for again on its own.
        fetcher.want(tile);
        assert_eq!(*counting.calls.lock().unwrap(), 1);
        fetcher.retry_failed();
        assert!(!fetcher.failed(tile));
    }

    #[test]
    fn a_fetcher_without_threads_has_the_tile_when_want_returns() {
        let dir = tempfile::tempdir().unwrap();
        let cache = TileCache::open(
            dir.path(),
            Box::new(Counting {
                calls: Mutex::new(0),
                bytes: vec![7, 7],
            }),
        )
        .unwrap();
        let fetcher = TileFetcher::inline(Arc::new(cache));
        let tile = TileId { z: 2, x: 0, y: 1 };
        fetcher.want(tile);
        assert!(!fetcher.busy());
        assert_eq!(fetcher.cache().cached(tile), Some(vec![7, 7]));
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
