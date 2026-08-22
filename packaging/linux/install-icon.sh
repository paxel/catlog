#!/usr/bin/env sh
# Install the cat(a)log launcher entry, its icons and its file type into the current
# user's XDG directories, so the app appears in the application menu and .catsync files
# open with it. Idempotent.
#
# Homebrew's own share directory is not on a desktop session's XDG_DATA_DIRS, so an
# entry installed there alone stays invisible to menus; this copies into ~/.local/share,
# which every session reads. On Wayland it also gives the window its taskbar icon: there
# is no protocol for a client to set its own, so the compositor matches the window's
# app_id to the .desktop entry instead.
#
# Usage:
#   install-icon.sh    launcher entry, icons and file type
set -eu

for argument in "$@"; do
  case $argument in
    -h | --help)
      sed -n '2,12p' "$0"
      exit 0
      ;;
    *)
      echo "install-icon: unknown argument $argument" >&2
      exit 2
      ;;
  esac
done

here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
# Works both from a source checkout (packaging/linux/../../assets/icon) and from the
# release tarball, where the icons and the .desktop file sit next to this script.
if [ -f "$here/icon.png" ]; then
  icons=$here
else
  icons=$here/../../assets/icon
fi
desktop_source="$here/catlog.desktop"
mime_source="$here/catlog-mime.xml"

data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
desktop_target="$data_home/applications/catlog.desktop"
mime_target="$data_home/mime/packages/catlog-mime.xml"

mkdir -p "$(dirname "$desktop_target")" "$(dirname "$mime_target")"

# The scalable icon is the one menus prefer; the 1024 pixel PNG is there for the
# desktops that cannot read SVG.
if [ -f "$icons/icon.svg" ]; then
  target="$data_home/icons/hicolor/scalable/apps/catlog.svg"
  mkdir -p "$(dirname "$target")"
  cp "$icons/icon.svg" "$target"
  echo "  $target"
fi
if [ -f "$icons/icon.png" ]; then
  target="$data_home/icons/hicolor/1024x1024/apps/catlog.png"
  mkdir -p "$(dirname "$target")"
  cp "$icons/icon.png" "$target"
  echo "  $target"
fi

cp "$desktop_source" "$desktop_target"
echo "  $desktop_target"
cp "$mime_source" "$mime_target"
echo "  $mime_target"

# Refresh caches where the tools exist (harmless if they don't).
command -v gtk-update-icon-cache >/dev/null 2>&1 &&
  gtk-update-icon-cache -f -t "$data_home/icons/hicolor" >/dev/null 2>&1 || true
command -v update-desktop-database >/dev/null 2>&1 &&
  update-desktop-database "$data_home/applications" >/dev/null 2>&1 || true
command -v update-mime-database >/dev/null 2>&1 &&
  update-mime-database "$data_home/mime" >/dev/null 2>&1 || true
command -v kbuildsycoca6 >/dev/null 2>&1 && kbuildsycoca6 >/dev/null 2>&1 || true

echo "cat(a)log is in your application menu; on KDE you may need to log out and in"
echo "before the menu and the .catsync file type notice."
