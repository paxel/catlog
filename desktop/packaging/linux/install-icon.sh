#!/usr/bin/env sh
# Install the cat(a)log launcher entry, its icons and its file type into the current
# user's XDG directories, so the app appears in the application menu and .catsync files
# open with it. Idempotent; --uninstall takes them out again.
#
# Homebrew's own share directory is not on a desktop session's XDG_DATA_DIRS, so an
# entry installed there alone stays invisible to menus; this copies into ~/.local/share,
# which every session reads. On Wayland it also gives the window its taskbar icon: there
# is no protocol for a client to set its own, so the compositor looks for the entry named
# after the window's app id, io.github.paxel.catlog.desktop.
#
# Usage:
#   install-icon.sh                launcher entry, icons and file type
#   install-icon.sh --uninstall    remove them again
set -eu

mode=install
for argument in "$@"; do
  case $argument in
    -h | --help)
      sed -n '2,14p' "$0"
      exit 0
      ;;
    --uninstall)
      mode=uninstall
      ;;
    *)
      echo "install-icon: unknown argument $argument" >&2
      exit 2
      ;;
  esac
done

here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
# Works both from a source checkout (desktop/packaging/linux/../../../assets/icon) and
# from the release tarball, where the icons and the .desktop file sit next to this script.
if [ -f "$here/icon.png" ]; then
  icons=$here
else
  icons=$here/../../../assets/icon
fi
desktop_source="$here/io.github.paxel.catlog.desktop"
mime_source="$here/catlog-mime.xml"

data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
desktop_target="$data_home/applications/io.github.paxel.catlog.desktop"
# The name releases before 2.0.1 used; left in place it would be a second menu entry.
old_desktop_target="$data_home/applications/catlog.desktop"
mime_target="$data_home/mime/packages/catlog-mime.xml"
svg_target="$data_home/icons/hicolor/scalable/apps/catlog.svg"
png_target="$data_home/icons/hicolor/1024x1024/apps/catlog.png"

refresh_caches() {
  # Where the tools exist (harmless if they don't).
  command -v gtk-update-icon-cache >/dev/null 2>&1 &&
    gtk-update-icon-cache -f -t "$data_home/icons/hicolor" >/dev/null 2>&1 || true
  command -v update-desktop-database >/dev/null 2>&1 &&
    update-desktop-database "$data_home/applications" >/dev/null 2>&1 || true
  command -v update-mime-database >/dev/null 2>&1 &&
    update-mime-database "$data_home/mime" >/dev/null 2>&1 || true
  command -v kbuildsycoca6 >/dev/null 2>&1 && kbuildsycoca6 >/dev/null 2>&1 || true
}

if [ "$mode" = uninstall ]; then
  for target in "$desktop_target" "$old_desktop_target" "$mime_target" "$svg_target" "$png_target"; do
    if [ -e "$target" ]; then
      rm -f "$target"
      echo "  removed $target"
    fi
  done
  refresh_caches
  echo "cat(a)log is out of your application menu."
  exit 0
fi

mkdir -p "$(dirname "$desktop_target")" "$(dirname "$mime_target")"

# The scalable icon is the one menus prefer; the 1024 pixel PNG is there for the
# desktops that cannot read SVG.
if [ -f "$icons/icon.svg" ]; then
  mkdir -p "$(dirname "$svg_target")"
  cp "$icons/icon.svg" "$svg_target"
  echo "  $svg_target"
fi
if [ -f "$icons/icon.png" ]; then
  mkdir -p "$(dirname "$png_target")"
  cp "$icons/icon.png" "$png_target"
  echo "  $png_target"
fi

rm -f "$old_desktop_target"
cp "$desktop_source" "$desktop_target"
echo "  $desktop_target"
cp "$mime_source" "$mime_target"
echo "  $mime_target"

refresh_caches

echo "cat(a)log is in your application menu. A window already open keeps its old"
echo "icon; start cat(a)log again to see the new one."
