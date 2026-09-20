#!/usr/bin/env sh
# Packs the Linux release from a built binary: the tarball the Homebrew
# formula installs, a .deb, and an AppImage.
#
#   packaging/linux/pack.sh <version> <arch> <binary> <dist dir>
#
# arch is x86_64 or arm64 (the artifact names); the .deb calls them
# amd64 and arm64. appimagetool is fetched when missing.
set -eu
version=$1
arch=$2
binary=$3
dist=$4
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
icons=$here/../../../assets/icon
mkdir -p "$dist"
stage=$(mktemp -d)

# The tarball: everything flat, as the formula expects.
bundle="$stage/bundle"
mkdir -p "$bundle"
cp "$binary" "$bundle/catlog"
cp "$here/io.github.paxel.catlog.desktop" "$here/catlog-mime.xml" "$here/install-icon.sh" "$bundle/"
cp "$icons/icon.png" "$icons/icon.svg" "$bundle/"
cp "$here/../../../LICENSE-APACHE" "$here/../../../LICENSE-MIT" "$bundle/" 2>/dev/null || true
tar -C "$bundle" -czf "$dist/catlog-$version-linux-$arch.tar.gz" .

# The .deb: binary, launcher, icons, MIME type.
case $arch in
  x86_64) deb_arch=amd64 ;;
  arm64) deb_arch=arm64 ;;
  *) deb_arch=$arch ;;
esac
deb="$stage/deb"
mkdir -p "$deb/DEBIAN" "$deb/usr/bin" "$deb/usr/share/applications" \
  "$deb/usr/share/mime/packages" "$deb/usr/share/icons/hicolor/scalable/apps" \
  "$deb/usr/share/icons/hicolor/1024x1024/apps" "$deb/usr/share/doc/catlog"
cp "$binary" "$deb/usr/bin/catlog"
chmod 0755 "$deb/usr/bin/catlog"
cp "$here/io.github.paxel.catlog.desktop" "$deb/usr/share/applications/io.github.paxel.catlog.desktop"
cp "$here/catlog-mime.xml" "$deb/usr/share/mime/packages/catlog-mime.xml"
cp "$icons/icon.svg" "$deb/usr/share/icons/hicolor/scalable/apps/catlog.svg"
cp "$icons/icon.png" "$deb/usr/share/icons/hicolor/1024x1024/apps/catlog.png"
cp "$here/../../THIRD-PARTY.md" "$deb/usr/share/doc/catlog/THIRD-PARTY.md"
cat > "$deb/DEBIAN/control" <<CONTROL
Package: catlog
Version: $version
Section: utils
Priority: optional
Architecture: $deb_arch
Maintainer: paxel <taum@tuta.io>
Depends: libc6, libxkbcommon0, libasound2t64 | libasound2
Homepage: https://github.com/paxel/catlog
Description: Local-first catalog for foster cats
 cat(a)log keeps the cats, clowders, chores and photos of a foster
 home on this machine and syncs through a shared folder or a file,
 with no server and no account.
CONTROL
dpkg-deb --build --root-owner-group "$deb" "$dist/catlog-$version-linux-$arch.deb" >/dev/null

# The AppImage.
appdir="$stage/AppDir"
mkdir -p "$appdir/usr/bin" "$appdir/usr/share/applications" \
  "$appdir/usr/share/icons/hicolor/1024x1024/apps"
cp "$binary" "$appdir/usr/bin/catlog"
chmod 0755 "$appdir/usr/bin/catlog"
cp "$here/io.github.paxel.catlog.desktop" "$appdir/io.github.paxel.catlog.desktop"
cp "$here/io.github.paxel.catlog.desktop" "$appdir/usr/share/applications/io.github.paxel.catlog.desktop"
cp "$icons/icon.png" "$appdir/catlog.png"
cp "$icons/icon.png" "$appdir/usr/share/icons/hicolor/1024x1024/apps/catlog.png"
cat > "$appdir/AppRun" <<'APPRUN'
#!/bin/sh
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
exec "$here/usr/bin/catlog" "$@"
APPRUN
chmod 0755 "$appdir/AppRun"
case $arch in
  x86_64) tool_arch=x86_64 ;;
  arm64) tool_arch=aarch64 ;;
  *) tool_arch=$arch ;;
esac
tool="${APPIMAGETOOL:-$stage/appimagetool}"
if [ ! -x "$tool" ]; then
  curl -sSL -o "$tool" \
    "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-$tool_arch.AppImage"
  chmod 0755 "$tool"
fi
ARCH=$tool_arch "$tool" --appimage-extract-and-run "$appdir" \
  "$dist/catlog-$version-linux-$arch.AppImage" >/dev/null 2>&1
rm -rf "$stage"
ls -1 "$dist"
