# App icon

`icon.svg` is the source of truth — a stack of Karteikarten (index
cards) with two cats on the front one: a tuxedo with a white chin and
white whiskers, and a Turkish Van, white with chestnut ears and cap.
Filled shapes only, and every curve spelled out as a polygon:
ImageMagick's built-in SVG renderer drops strokes and has no arcs.

Regenerate after editing the SVG (icon.png MUST be flattened opaque
8-bit - an alpha channel turns the iOS App Store icon solid black):

```sh
magick -background none -density 300 assets/icon/icon.svg \
  -resize 1024x1024 -background '#F6E7D3' -flatten -alpha off -depth 8 \
  PNG24:assets/icon/icon.png
magick assets/icon/icon.png -resize 256x256 assets/icon/icon_256.png
sed '/<rect width="1024" height="1024" fill="#F6E7D3"\/>/d' \
  assets/icon/icon.svg > /tmp/icon_fg.svg
magick -background none -density 300 /tmp/icon_fg.svg \
  -resize 1024x1024 assets/icon/icon_fg.png
dart run flutter_launcher_icons
```

`icon_fg.png` is the Android adaptive-icon foreground: the same artwork
without the background, at full size, and `adaptive_icon_foreground_inset`
is `0` in `flutter_launcher_icons.yaml`. The card's corners fall outside
the launcher's circle, which is what the safe zone is for — the cats sit
well inside it. Shrinking the foreground here *and* letting the package
inset it again is what made the cats too small to recognise on a phone.
The adaptive background colour is `#F6E7D3`.
