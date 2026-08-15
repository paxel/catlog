# App icon

`icon.svg` is the source of truth — a Karteikarte (index card) with a cat
face. Filled shapes only: ImageMagick's built-in SVG renderer drops
strokes and mishandles rotate transforms.

Regenerate after editing the SVG:

```sh
magick -background none -density 300 assets/icon/icon.svg \
  -resize 1024x1024 assets/icon/icon.png
sed '/<rect width="1024" height="1024" fill="#F6E7D3"\/>/d' \
  assets/icon/icon.svg > /tmp/icon_fg.svg
magick -background none -density 300 /tmp/icon_fg.svg \
  -resize 660x660 -gravity center -extent 1024x1024 assets/icon/icon_fg.png
dart run flutter_launcher_icons
```

`icon_fg.png` is the Android adaptive-icon foreground (content inside the
66% safe zone, transparent background); the adaptive background color is
`#F6E7D3` (set in `flutter_launcher_icons.yaml`).
