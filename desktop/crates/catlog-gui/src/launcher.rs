//! The launcher entry on Linux, written by the desk itself.
//!
//! A Homebrew or tarball install and a downloaded AppImage are a binary
//! and nothing else: no `.desktop` entry, no icon in a place the menu
//! reads, so the app is not in the menu and on Wayland its window shows
//! a generic icon, the compositor finding the icon through the entry
//! named after the window's app id. The desk closes that gap on every
//! start: it writes or refreshes the icon, the launcher and the file
//! type in the user's XDG data dirs, what `packaging/linux/install-icon.sh`
//! does for a checkout and the formula does once at install.
//!
//! Rules: only an entry carrying the `X-Catlog-Managed` marker is ever
//! overwritten, a hand-written or distro-installed one is left alone;
//! nothing is written when the content is current; every failure is
//! swallowed, a missing menu entry is never worth failing a start over.

use std::fs;
use std::io;
use std::path::{Path, PathBuf};

use crate::settings::APP_ID;

/// The icon as the menu draws it, 256 pixels, by its theme name.
const ICON: &[u8] = include_bytes!("../../../../assets/icon/icon_256.png");
/// The `.catsync` file type.
const MIME: &[u8] = include_bytes!("../../../packaging/linux/catlog-mime.xml");
/// The marker claiming an entry as ours to update.
const MARKER: &str = "X-Catlog-Managed=true";

/// Registers icon, launcher and file type for the running binary; call
/// from a thread of its own. Best effort: errors and a home-less
/// environment are ignored.
pub fn register() {
    let Some(data_home) = data_home() else {
        return;
    };
    let Some(exec) = exec_path() else {
        return;
    };
    if let Ok(true) = register_at(&data_home, &exec) {
        refresh_caches(&data_home);
    }
}

/// `$XDG_DATA_HOME`, else `$HOME/.local/share`.
fn data_home() -> Option<PathBuf> {
    if let Some(x) = std::env::var_os("XDG_DATA_HOME")
        && !x.is_empty()
    {
        return Some(PathBuf::from(x));
    }
    std::env::var_os("HOME").map(|h| PathBuf::from(h).join(".local/share"))
}

/// What the launcher executes: the AppImage file when running from one
/// (`$APPIMAGE`, the mount the binary runs from is gone after exit),
/// else the running executable, through the stable Homebrew symlink
/// when the binary lives in a Cellar.
fn exec_path() -> Option<PathBuf> {
    if let Some(ai) = std::env::var_os("APPIMAGE")
        && !ai.is_empty()
    {
        return Some(PathBuf::from(ai));
    }
    let exe = std::env::current_exe().ok()?;
    Some(stable_brew_path(&exe).unwrap_or(exe))
}

/// The `<prefix>/bin/catlog` symlink for a binary in a Homebrew Cellar,
/// verified to point back at it; none for everything else. `current_exe`
/// resolves into the versioned Cellar directory, which the next
/// `brew upgrade` deletes; a launcher pinned there dies with it. The
/// prefix's `bin` is repointed on every upgrade, so that path lives on.
fn stable_brew_path(exe: &Path) -> Option<PathBuf> {
    let prefix = exe
        .ancestors()
        .find(|a| a.file_name() == Some("Cellar".as_ref()))?
        .parent()?;
    let candidate = prefix.join("bin").join(exe.file_name()?);
    (fs::canonicalize(&candidate).ok()? == fs::canonicalize(exe).ok()?).then_some(candidate)
}

/// Writes icon, launcher and file type under `data_home` for `exec`.
/// Whether anything was written; the caches are refreshed only then.
fn register_at(data_home: &Path, exec: &Path) -> io::Result<bool> {
    let mut wrote = false;

    let icon_path = data_home.join("icons/hicolor/256x256/apps/catlog.png");
    if fs::read(&icon_path).ok().as_deref() != Some(ICON) {
        write_atomic(&icon_path, ICON)?;
        wrote = true;
    }

    let mime_path = data_home.join("mime/packages/catlog-mime.xml");
    if fs::read(&mime_path).ok().as_deref() != Some(MIME) {
        write_atomic(&mime_path, MIME)?;
        wrote = true;
    }

    let desktop_path = data_home.join(format!("applications/{APP_ID}.desktop"));
    let desired = desktop_entry(exec);
    match fs::read_to_string(&desktop_path) {
        Ok(current) if !current.contains(MARKER) => {}
        Ok(current) if current == desired => {}
        _ => {
            write_atomic(&desktop_path, desired.as_bytes())?;
            wrote = true;
        }
    }
    Ok(wrote)
}

/// The launcher, as `packaging/linux/io.github.paxel.catlog.desktop` has
/// it, with Exec and TryExec pointed at the binary: TryExec hides the
/// entry once an AppImage was moved away instead of failing.
fn desktop_entry(exec: &Path) -> String {
    let exec_str = exec.to_string_lossy();
    format!(
        "[Desktop Entry]\n\
         Name=cat(a)log\n\
         Comment=The catalog for people who foster cats\n\
         TryExec={exec_str}\n\
         Exec={} %f\n\
         Icon=catlog\n\
         Terminal=false\n\
         Type=Application\n\
         Categories=Utility;\n\
         MimeType=application/x-catsync;\n\
         StartupWMClass={APP_ID}\n\
         {MARKER}\n",
        quote_exec(&exec_str),
    )
}

/// A path for an `Exec=` line: double-quoted with the reserved characters
/// escaped, unless it is plain enough to stand bare.
fn quote_exec(path: &str) -> String {
    let plain = path
        .chars()
        .all(|c| c.is_alphanumeric() || matches!(c, '/' | '.' | '_' | '-' | '+' | ':' | '@'));
    if plain {
        return path.to_owned();
    }
    let mut out = String::with_capacity(path.len() + 2);
    out.push('"');
    for c in path.chars() {
        if matches!(c, '"' | '\\' | '$' | '`') {
            out.push('\\');
        }
        out.push(c);
    }
    out.push('"');
    out
}

/// Parent directories made, then a same-directory temp file renamed into
/// place, so a crash leaves no half-written launcher.
fn write_atomic(path: &Path, bytes: &[u8]) -> io::Result<()> {
    let dir = path
        .parent()
        .ok_or_else(|| io::Error::other("path has no parent"))?;
    fs::create_dir_all(dir)?;
    let tmp = dir.join(format!(
        ".{}.tmp",
        path.file_name()
            .map(|n| n.to_string_lossy())
            .unwrap_or_default()
    ));
    fs::write(&tmp, bytes)?;
    fs::rename(&tmp, path)
}

/// Pokes the desktop's caches so the entry shows without a new login.
/// Every tool is optional; absence and failure are both fine.
fn refresh_caches(data_home: &Path) {
    let run = |cmd: &str, args: &[&std::ffi::OsStr]| {
        let _ = std::process::Command::new(cmd)
            .args(args)
            .stdout(std::process::Stdio::null())
            .stderr(std::process::Stdio::null())
            .status();
    };
    let icons = data_home.join("icons/hicolor");
    let apps = data_home.join("applications");
    let mime = data_home.join("mime");
    run(
        "gtk-update-icon-cache",
        &["-f".as_ref(), "-t".as_ref(), icons.as_os_str()],
    );
    run("update-desktop-database", &[apps.as_os_str()]);
    run("update-mime-database", &[mime.as_os_str()]);
    run("kbuildsycoca6", &[]);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_fresh_register_writes_icon_file_type_and_marked_launcher() {
        let dir = tempfile::tempdir().unwrap();
        let exec = Path::new("/opt/brew/bin/catlog");
        assert!(register_at(dir.path(), exec).unwrap());
        assert_eq!(
            fs::read(dir.path().join("icons/hicolor/256x256/apps/catlog.png")).unwrap(),
            ICON
        );
        assert_eq!(
            fs::read(dir.path().join("mime/packages/catlog-mime.xml")).unwrap(),
            MIME
        );
        let desktop = fs::read_to_string(
            dir.path()
                .join("applications/io.github.paxel.catlog.desktop"),
        )
        .unwrap();
        assert!(desktop.contains("Exec=/opt/brew/bin/catlog %f"));
        assert!(desktop.contains("TryExec=/opt/brew/bin/catlog"));
        assert!(desktop.contains("Icon=catlog\n"));
        assert!(desktop.contains("StartupWMClass=io.github.paxel.catlog"));
        assert!(desktop.contains(MARKER));
        // Current content is not written again; a moved binary is.
        assert!(!register_at(dir.path(), exec).unwrap());
        assert!(register_at(dir.path(), Path::new("/new/catlog")).unwrap());
        let desktop = fs::read_to_string(
            dir.path()
                .join("applications/io.github.paxel.catlog.desktop"),
        )
        .unwrap();
        assert!(desktop.contains("Exec=/new/catlog %f"));
    }

    #[test]
    fn a_launcher_without_the_marker_is_left_alone() {
        let dir = tempfile::tempdir().unwrap();
        let desktop_path = dir
            .path()
            .join("applications/io.github.paxel.catlog.desktop");
        fs::create_dir_all(desktop_path.parent().unwrap()).unwrap();
        let foreign = "[Desktop Entry]\nName=my catlog\nExec=/home/me/custom\n";
        fs::write(&desktop_path, foreign).unwrap();
        register_at(dir.path(), Path::new("/opt/catlog")).unwrap();
        assert_eq!(fs::read_to_string(&desktop_path).unwrap(), foreign);
    }

    #[test]
    fn a_cellar_binary_registers_the_stable_bin_symlink() {
        let dir = tempfile::tempdir().unwrap();
        let cellar_bin = dir.path().join("Cellar/catlog/2.0.1/bin");
        fs::create_dir_all(&cellar_bin).unwrap();
        let exe = cellar_bin.join("catlog");
        fs::write(&exe, b"binary").unwrap();
        let bin = dir.path().join("bin");
        fs::create_dir_all(&bin).unwrap();
        std::os::unix::fs::symlink("../Cellar/catlog/2.0.1/bin/catlog", bin.join("catlog"))
            .unwrap();
        assert_eq!(stable_brew_path(&exe), Some(bin.join("catlog")));
        // A bin symlink naming another binary is not ours; no Cellar, itself.
        let other = dir.path().join("Cellar/other/1.0/bin");
        fs::create_dir_all(&other).unwrap();
        fs::write(other.join("catlog"), b"other").unwrap();
        assert_eq!(stable_brew_path(&other.join("catlog")), None);
        assert_eq!(stable_brew_path(Path::new("/usr/local/bin/catlog")), None);
    }

    #[test]
    fn exec_paths_with_specials_are_quoted() {
        assert_eq!(quote_exec("/opt/brew/bin/catlog"), "/opt/brew/bin/catlog");
        assert_eq!(
            quote_exec("/home/me/My Apps/catlog.AppImage"),
            "\"/home/me/My Apps/catlog.AppImage\""
        );
        assert_eq!(quote_exec("/tmp/a\"b"), "\"/tmp/a\\\"b\"");
        assert_eq!(quote_exec("/tmp/$HOME"), "\"/tmp/\\$HOME\"");
    }
}
