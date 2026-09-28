# App icon

`icon_source.jpg` is the source of truth: a painted picture of the two
cats — a Turkish Van, white with chestnut ears and cap, and a tuxedo with
a white chin — lying on a folder of index cards, on the app's orange.
The hand-drawn `icon.svg` of before is gone, and with it the scalable
Linux icon; the 256 px PNG is what every desktop draws.

Regenerate after replacing the picture:

```sh
dart run tool/icon_from_raster.dart assets/icon/icon_source.jpg \
  --scale 0.80 --shift 0.10
dart run flutter_launcher_icons
```

The tool crops the picture to a centred square and writes:

- `icon.png` — 1024 px, flattened opaque 8-bit RGB. It MUST stay opaque:
  an alpha channel turns the iOS App Store icon solid black.
- `icon_256.png` — the desk's window icon and the Linux menu icon.
- `icon_fg.png` — the Android adaptive-icon foreground. The launcher
  shows only the middle 72/108 of it, in a circle, and the cats' heads
  sit at the top of the picture; so the artwork is scaled to 80 % and
  moved down by 10 % of the canvas, on the picture's own orange
  (`#FD5700`, also the adaptive background in
  `flutter_launcher_icons.yaml`). `adaptive_icon_foreground_inset` stays
  `0`: the margin is already in the file, and letting the package inset
  it again is what once made the cats a speck in the ring.

- `store/play-icon-512.png` and `store/play-feature-1024x500.png` — what
  the Play Console takes by hand under Store listing: the icon, and the
  feature graphic with the artwork centred on the picture's orange. The
  App Store takes its 1024 px icon from the iOS build.

To judge the launcher look before fanning the files out, add
`--preview DIR`: the tool writes the circle mask at 48 and 192 px there.
