#!/usr/bin/env sh
# Packs the macOS release from a built binary: catlog.app in a .dmg,
# unsigned, with the .catsync file type declared so a double-click opens
# the app.
#
#   packaging/macos/pack.sh <version> <arch> <binary> <dist dir>
set -eu
version=$1
arch=$2
binary=$3
dist=$4
here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
icons=$here/../../../assets/icon
mkdir -p "$dist"
stage=$(mktemp -d)
app="$stage/dmgroot/catlog.app"
mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources"
cp "$binary" "$app/Contents/MacOS/catlog"
chmod 0755 "$app/Contents/MacOS/catlog"

# The icon: an iconset from the 1024 px PNG.
iconset="$stage/catlog.iconset"
mkdir -p "$iconset"
# The ten names iconutil accepts: five sizes, each with its @2x twin.
for size in 16 32 128 256 512; do
  sips -z $size $size "$icons/icon.png" --out "$iconset/icon_${size}x${size}.png" >/dev/null
  double=$((size * 2))
  sips -z $double $double "$icons/icon.png" --out "$iconset/icon_${size}x${size}@2x.png" >/dev/null
done
iconutil -c icns "$iconset" -o "$app/Contents/Resources/catlog.icns"

cat > "$app/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key><string>cat(a)log</string>
  <key>CFBundleDisplayName</key><string>cat(a)log</string>
  <key>CFBundleIdentifier</key><string>io.github.paxel.catlog</string>
  <key>CFBundleVersion</key><string>$version</string>
  <key>CFBundleShortVersionString</key><string>$version</string>
  <key>CFBundleExecutable</key><string>catlog</string>
  <key>CFBundleIconFile</key><string>catlog</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>LSMinimumSystemVersion</key><string>11.0</string>
  <key>NSHighResolutionCapable</key><true/>
  <key>CFBundleDocumentTypes</key>
  <array>
    <dict>
      <key>CFBundleTypeName</key><string>cat(a)log bundle</string>
      <key>CFBundleTypeRole</key><string>Viewer</string>
      <key>LSHandlerRank</key><string>Owner</string>
      <key>LSItemContentTypes</key><array><string>io.github.paxel.catlog.catsync</string></array>
    </dict>
  </array>
  <key>UTExportedTypeDeclarations</key>
  <array>
    <dict>
      <key>UTTypeIdentifier</key><string>io.github.paxel.catlog.catsync</string>
      <key>UTTypeDescription</key><string>cat(a)log bundle</string>
      <key>UTTypeConformsTo</key><array><string>public.data</string></array>
      <key>UTTypeTagSpecification</key>
      <dict>
        <key>public.filename-extension</key><array><string>catsync</string></array>
        <key>public.mime-type</key><array><string>application/x-catsync</string></array>
      </dict>
    </dict>
  </array>
</dict>
</plist>
PLIST
ln -s /Applications "$stage/dmgroot/Applications"
hdiutil create -volname "cat(a)log" -srcfolder "$stage/dmgroot" -ov -format UDZO \
  "$dist/catlog-$version-macos-$arch.dmg" >/dev/null
rm -rf "$stage"
ls -1 "$dist"
