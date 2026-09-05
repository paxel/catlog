import 'dart:io';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';

import '../field_labels.dart';
import '../help.dart';
import '../geocode.dart';
import '../hidden.dart';
import '../image_provider_cache.dart';
import '../l10n.dart';
import '../map/cached_tiles.dart';
import '../map/place_view.dart';
import '../spotlight.dart';
import '../stray_cam.dart';
import '../widgets/cat_avatar.dart';
import '../widgets/cat_ear.dart';
import 'cat_detail_screen.dart';
import 'clowder_detail_screen.dart';
import 'cat_list_screen.dart';
import '../exclusive.dart';
import '../pet_mode.dart';

/// The map: Strays at their latest position, Clowders as home pins.
/// Long-press places a Clowder or records a Stray sighting at that spot.
class MapScreen extends StatefulWidget {
  final CatalogStore store;

  /// Test override; defaults to disk-cached OSM tiles.
  final TileProvider? tileProvider;

  /// Opens centered here (e.g. from a position chip) instead of on the
  /// first positioned entity.
  final LatLng? initialCenter;

  /// Test override for the place search; defaults to OSM Nominatim.
  final GeocodeSearch? geocode;

  /// The entity and spot "Show on map" was pressed for: drawn as a
  /// highlighted pin whatever the map's own rules say (#88).
  final (String, LatLng)? focus;

  /// A location field whose trail is on from the start: the entity and
  /// the field key, from a row with two values or more.
  final (String, String)? trailOf;

  const MapScreen(
      {super.key,
      required this.store,
      this.tileProvider,
      this.initialCenter,
      this.geocode,
      this.focus,
      this.trailOf});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

/// The last viewport, kept per device so the map reopens where it was
/// left instead of over the whole country (#55).
const mapViewportKey = 'mapViewport';

/// Greedy nearest-neighbor order over the pins, starting from [from] —
/// the prev/next arrows walk the map like a route.
List<(EntityView, LatLng)> navChain(
    List<(EntityView, LatLng)> pins, LatLng from) {
  final remaining = [...pins];
  final chain = <(EntityView, LatLng)>[];
  var cursor = from;
  while (remaining.isNotEmpty) {
    remaining.sort((a, b) => haversineMeters(cursor.latitude,
            cursor.longitude, a.$2.latitude, a.$2.longitude)
        .compareTo(haversineMeters(cursor.latitude, cursor.longitude,
            b.$2.latitude, b.$2.longitude)));
    final next = remaining.removeAt(0);
    chain.add(next);
    cursor = next.$2;
  }
  return chain;
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  TileProvider? _tiles;
  final _controller = MapController();
  final _search = TextEditingController();
  List<(EntityView, LatLng)>? _hits;
  List<GeoHit>? _placeHits;
  AnimationController? _glide;
  Timer? _viewportSave;
  List<(EntityView, LatLng)>? _navChain;
  int _navIndex = -1;

  /// The location field whose trail is drawn — an entity and a field
  /// key; tap a pin to toggle. Built-in positions trail their sightings,
  /// any other location field every value it held.
  (String, String)? _trailOf;

  /// The trail dot last tapped: its date and author join the label.
  Entry? _dot;

  bool _onTrail(String id, [String field = CatalogStore.positionKey]) =>
      _trailOf == (id, field);

  void _toggleTrail(String id, [String field = CatalogStore.positionKey]) =>
      setState(() {
        _trailOf = _onTrail(id, field) ? null : (id, field);
        _dot = null;
      });

  /// Missing cats whose possible stray area (500 m circles around their
  /// flier positions) is overlaid (#31).
  final _strayAreas = <String>{};

  CatalogStore get store => widget.store;

  @override
  void dispose() {
    _glide?.dispose();
    _viewportSave?.cancel();
    _search.dispose();
    _controller.dispose();
    super.dispose();
  }

  /// The stored viewport, or null before the first visit.
  (LatLng, double)? _storedViewport() {
    final raw = store.localSetting(mapViewportKey);
    if (raw == null) return null;
    final parts = raw.split(',');
    if (parts.length != 3) return null;
    final lat = double.tryParse(parts[0]);
    final lon = double.tryParse(parts[1]);
    final zoom = double.tryParse(parts[2]);
    if (lat == null || lon == null || zoom == null) return null;
    // tryParse accepts "Infinity" and "NaN". A camera that once went
    // infinite (degenerate bounds fit) would be saved and then crash
    // the map on every open — reject it and start fresh instead.
    if (!lat.isFinite || !lon.isFinite || !zoom.isFinite) return null;
    if (lat < -90 || lat > 90 || lon < -180 || lon > 180) return null;
    if (zoom < 1 || zoom > 20) return null;
    return (LatLng(lat, lon), zoom);
  }

  void _rememberViewport(MapCamera camera) {
    _viewportSave?.cancel();
    _viewportSave = Timer(const Duration(seconds: 1), () {
      final center = camera.center;
      // Never persist a broken camera (see _storedViewport).
      if (!center.latitude.isFinite ||
          !center.longitude.isFinite ||
          !camera.zoom.isFinite) {
        return;
      }
      store.setLocalSetting(mapViewportKey,
          '${center.latitude},${center.longitude},${camera.zoom}');
    });
  }

  /// Camera glide instead of a hard jump.
  void _animateTo(LatLng dest, double zoom) {
    _glide?.dispose();
    final camera = _controller.camera;
    final latTween =
        Tween(begin: camera.center.latitude, end: dest.latitude);
    final lonTween =
        Tween(begin: camera.center.longitude, end: dest.longitude);
    final zoomTween = Tween(begin: camera.zoom, end: zoom);
    final controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    final curve =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addListener(() {
      _controller.move(
          LatLng(latTween.evaluate(curve), lonTween.evaluate(curve)),
          zoomTween.evaluate(curve));
    });
    controller.forward();
    _glide = controller;
  }

  Future<void> _jumpToMyLocation() => runExclusive(
      'locate', _jumpToMyLocationNow, context: context);

  Future<void> _jumpToMyLocationNow() async {
    final outcome = await locateDevice();
    final pos = outcome.pos;
    if (pos == null) {
      if (mounted) {
        await explainLocationFailure(
            context, outcome.failure ?? LocationFailure.noFix);
      }
      return;
    }
    _animateTo(LatLng(pos.$1, pos.$2), 15);
  }

  /// Jumps to a found place at the zoom the place deserves.
  void _showPlace(GeoHit hit) {
    final fit = placeFit(hit);
    if (fit == null) {
      _animateTo(LatLng(hit.lat, hit.lon), placeZoom);
      return;
    }
    _controller.fitCamera(fit);
  }

  /// Prev/next over all pins in nearest-neighbor order from where the
  /// user currently looks; the chain rebuilds when pins change.
  void _stepPins(int direction) {
    final pins = [
      ..._positioned(store.visibleClowders(), sightingsOnly: false),
      for (final g in _grouped(_catPins())) (g.cats.first, g.point),
      ..._flierPinned(store.visibleStrays()),
    ];
    if (pins.isEmpty) return;
    if (_navChain == null || _navChain!.length != pins.length) {
      _navChain = navChain(pins, _controller.camera.center);
      _navIndex = -1;
    }
    _navIndex = (_navIndex + direction) % _navChain!.length;
    if (_navIndex < 0) _navIndex += _navChain!.length;
    _animateTo(_navChain![_navIndex].$2, 15);
  }

  /// The dated positions of one location field, oldest first. For the
  /// built-in position only sightings — flier positions are not part of
  /// the trail (#30); for any other location field every value.
  List<(Entry, LatLng)> _trailPoints((String, String) of) {
    final (id, field) = of;
    return [
      for (final e in store.fieldHistory(id, field).reversed)
        if (!e.reminder &&
            (field != CatalogStore.positionKey ||
                CatalogStore.parsePositionKind(e.value ?? '') ==
                    PositionKind.sighting))
          if (CatalogStore.parsePosition(e.value) case final pos?)
            (e, LatLng(pos.$1, pos.$2))
    ];
  }

  /// The location fields a keeper added, besides the built-in position.
  List<FieldDef> _userLocationFields(FieldScope scope) => [
        for (final def in store.visibleFieldDefs())
          if (def.type == FieldType.location &&
              def.key != CatalogStore.positionKey &&
              (def.scope == FieldScope.both || def.scope == scope))
            def
      ];

  /// Every value of a user-added location field on a visible cat or
  /// home: one pin each.
  List<(EntityView, FieldDef, LatLng)> _userPins() => [
        for (final (entities, scope) in [
          (store.visibleCats(), FieldScope.cat),
          (store.visibleClowders(), FieldScope.clowder),
        ])
          for (final def in _userLocationFields(scope))
            for (final e in entities)
              if (CatalogStore.parsePosition(store.current(e.id, def.key))
                  case final pos?)
                (e, def, LatLng(pos.$1, pos.$2))
      ];

  /// A neutral face for a user-added location: a place mark in a ring.
  Widget _placeFace(bool highlighted) => Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: highlighted ? Colors.red : Colors.blueGrey, width: 3),
          color: Colors.white,
        ),
        child: const Icon(Icons.place, size: 24, color: Colors.blueGrey),
      );

  @override
  void initState() {
    super.initState();
    _trailOf = widget.trailOf;
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => runSpotlights(context, store, 'map'));
    if (widget.tileProvider != null) {
      _tiles = widget.tileProvider;
    } else {
      getApplicationSupportDirectory().then((dir) {
        if (mounted) {
          setState(() =>
              _tiles = DiskCachingTileProvider(Directory('${dir.path}/tiles')));
        }
      });
    }
  }

  /// Strays pin at their latest sighting; their flier positions get
  /// their own square pins ([_flierPinned], #83). Clowders pin at their
  /// plain position.
  List<(EntityView, LatLng)> _positioned(List<EntityView> entities,
          {required bool sightingsOnly}) =>
      [
        for (final e in entities)
          if ((sightingsOnly
                  ? store.sightingPositionOf(e.id)
                  : store.positionOf(e.id))
              case final pos?)
            (e, LatLng(pos.$1, pos.$2))
      ];

  /// Each stray's latest flier position — where its poster says it was
  /// lost — for the square pins (#83). Older flier positions stay in
  /// the stray-area overlay (#55).
  List<(EntityView, LatLng)> _flierPinned(List<EntityView> entities) => [
        for (final e in entities)
          if (store.flierPositions(e.id).firstOrNull case final pos?)
            (e, LatLng(pos.$1, pos.$2))
      ];

  /// Cats that pin on their own: strays, and members of a clowder that
  /// has no position of its own (#88) — each at its latest sighting,
  /// latest sighting first so a group shows the freshest face.
  List<(EntityView, LatLng, DateTime)> _catPins() {
    final pins = <(EntityView, LatLng, DateTime)>[];
    for (final cat in store.visibleCats()) {
      final clowderId = store.current(cat.id, Keys.clowder);
      if (clowderId != null && store.positionOf(clowderId) != null) continue;
      for (final e in store.fieldHistory(cat.id, CatalogStore.positionKey)) {
        if (CatalogStore.parsePositionKind(e.value ?? '') !=
            PositionKind.sighting) {
          continue;
        }
        final pos = CatalogStore.parsePosition(e.value);
        if (pos == null) continue;
        pins.add((cat, LatLng(pos.$1, pos.$2), e.date));
        break;
      }
    }
    pins.sort((a, b) => b.$3.compareTo(a.$3));
    return pins;
  }

  /// Cat pins within [groupMeters] of each other merge into one pin
  /// (#88): one face, the name, and "+x"; tapping opens the cat list.
  List<_PinGroup> _grouped(List<(EntityView, LatLng, DateTime)> pins) {
    final groups = <_PinGroup>[];
    for (final (cat, point, _) in pins) {
      _PinGroup? near;
      for (final g in groups) {
        if (haversineMeters(g.point.latitude, g.point.longitude,
                point.latitude, point.longitude) <=
            groupMeters) {
          near = g;
          break;
        }
      }
      if (near == null) {
        groups.add(_PinGroup([cat], point));
      } else {
        near.cats.add(cat);
      }
    }
    return groups;
  }

  Widget _focusFace(String id) =>
      id.startsWith('clowder:') ? _clowderFace(id) : _catFace(id, true);

  Future<void> _openGroup(_PinGroup group) async {
    final ids = {for (final c in group.cats) c.id};
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CatListScreen(
        store: store,
        title: context.t.cats,
        source: (s) => [
          for (final c in s.visibleCats())
            if (ids.contains(c.id)) c
        ],
      ),
    ));
    if (mounted) setState(() {});
  }

  // Only sightings are recorded from the map; a clowder's position is set
  // via its Position field — clowders move far too rarely for a map menu.
  Future<void> _longPress(LatLng point) async {
    final strays = store.visibleStrays();
    final catId = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(shrinkWrap: true, children: [
          if (strays.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(context.t.recordSightingHere),
            ),
          for (final s in strays)
            ListTile(
              leading: CatAvatar(store: store, catId: s.id, size: 40),
              title: Text(s.name),
              onTap: () => Navigator.of(context).pop(s.id),
            ),
        ]),
      ),
    );
    if (catId == null) return;
    store.recordPosition(catId, point.latitude, point.longitude);
    setState(() {});
  }

  /// Missing cats (any cat with flier positions) offered as overlay
  /// toggles; the chosen ones get their 500 m circles drawn.
  Future<void> _pickStrayAreas() async {
    final missing = [
      for (final cat in store.visibleCats())
        if (store.flierPositions(cat.id).isNotEmpty ||
            strayHomePosition(store, cat.id) != null)
          cat
    ];
    // A dialog with OK, not a sheet: a sheet has no visible way out
    // but tapping beside it, which nobody guesses.
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialog) => AlertDialog(
          title: Text(context.t.strayAreaLabel),
          content: SizedBox(
            width: 360,
            child: missing.isEmpty
                ? Text(context.t.noMissingCats)
                : ListView(shrinkWrap: true, children: [
                    for (final cat in missing)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _strayAreas.contains(cat.id),
                        title: Text(cat.name),
                        secondary:
                            CatAvatar(store: store, catId: cat.id, size: 36),
                        onChanged: (on) {
                          setDialog(() {});
                          setState(() {
                            if (on == true) {
                              _strayAreas.add(cat.id);
                            } else {
                              _strayAreas.remove(cat.id);
                            }
                          });
                        },
                      ),
                  ]),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
          ],
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  /// A stray's face for its map pin: profile photo in a ring, paw icon
  /// as fallback.
  Widget _catFace(String catId, bool highlighted) {
    final hash = store.profileImage(catId);
    final photo = hash == null ? null : imageProviderFor(store, hash);
    final dead = isDeceased(store, catId);
    final ring = highlighted
        ? Colors.red
        : dead
            ? Colors.grey
            : Colors.deepOrange;
    final face = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: 3),
        color: Colors.white,
      ),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white,
        // Decode at pin size — full-resolution photos (2560px ≈ 26MB
        // decoded) in a 40px circle were the other leg of the OOM.
        backgroundImage:
            photo != null ? ResizeImage(photo, width: 96) : null,
        child: photo == null
            ? _placeholder()
            : null,
      ),
    );
    if (!dead) return face;
    return Opacity(
      opacity: 0.65,
      child: ColorFiltered(colorFilter: greyscale, child: face),
    );
  }

  /// The cat's face in a square frame: the flier pin (#83). Squarer
  /// than a clowder's rounded ring, so the three pins read apart.
  Widget _flierFace(String catId, bool highlighted) {
    final hash = store.profileImage(catId);
    final photo = hash == null ? null : imageProviderFor(store, hash);
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
            color: highlighted ? Colors.red : Colors.deepOrange, width: 3),
        color: Colors.white,
        image: photo != null
            ? DecorationImage(
                image: ResizeImage(photo, width: 96), fit: BoxFit.cover)
            : null,
      ),
      child: photo == null ? _placeholder() : null,
    );
  }

  /// The face of an animal without a photo: the cat silhouette, or a
  /// paw in pet mode (#93).
  Widget _placeholder() => petMode.value
      ? const Icon(Icons.pets, size: 24, color: Colors.deepOrange)
      : const CustomPaint(
          size: Size(24, 24),
          painter: _CatSilhouettePainter(Colors.deepOrange));

  /// A clowder's own photo in a rounded-square ring — visually distinct
  /// from the round cat faces; house silhouette only as placeholder.
  Widget _clowderFace(String clowderId) {
    final images = store.images(clowderId);
    // Same rule as the cat faces: the cached provider, decoded at pin
    // size — a fresh full-size MemoryImage per build was the leak.
    final photo =
        images.isEmpty ? null : imageProviderFor(store, images.first);
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 3),
        color: photo == null ? color : Colors.white,
        image: photo != null
            ? DecorationImage(
                image: ResizeImage(photo, width: 96), fit: BoxFit.cover)
            : null,
      ),
      child: photo == null
          ? const Icon(Icons.home, size: 22, color: Colors.white)
          : null,
    );
  }

  Future<void> _runSearch() async {
    final query = _search.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _hits = null;
        _placeHits = null;
      });
      return;
    }
    final byAuthor = store.entitiesTouchedBy(query).toSet();
    bool matches(EntityView e) =>
        e.name.toLowerCase().contains(query) || byAuthor.contains(e.id);
    final found = <(EntityView, LatLng)>[
      for (final entry in [
        ..._positioned(store.visibleCats(), sightingsOnly: true),
        ..._positioned(store.visibleClowders(), sightingsOnly: false),
      ])
        if (matches(entry.$1)) entry
    ];
    if (found.isEmpty) {
      // The catalog knows nothing by this name — ask the world (#55).
      List<GeoHit> places;
      try {
        places = await (widget.geocode ?? nominatimSearch)(query);
      } catch (_) {
        places = const [];
      }
      if (!mounted) return;
      setState(() {
        _hits = found;
        _placeHits = places;
      });
      return;
    }
    setState(() {
      _hits = found;
      _placeHits = null;
    });
    if (found.length == 1) {
      _animateTo(found.single.$2, 15);
    } else if (found.length > 1) {
      _controller.fitCamera(CameraFit.bounds(
        bounds: LatLngBounds.fromPoints([for (final f in found) f.$2]),
        padding: const EdgeInsets.all(64),
        // Several hits on the same spot make zero-size bounds; without
        // a ceiling the fit computes an infinite zoom and every tile
        // update crashes with "Infinity or NaN toInt".
        maxZoom: 17,
      ));
    }
  }

  /// Every map control in one row: layers, my location, pin stepping,
  /// Stray Cam. Off the map so nothing overlays it.
  Widget _toolbar(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(children: [
            Spotlight(
              id: 'map-layers',
              child: IconButton(
                icon: const Icon(Icons.layers_outlined),
                tooltip: context.t.strayAreaLabel,
                onPressed: _pickStrayAreas,
              ),
            ),
            IconButton(
              icon: const BusyIcon(keys: {'locate'}, icon: Icons.my_location),
              tooltip: context.t.useMyLocation,
              onPressed: _jumpToMyLocation,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              tooltip: context.t.prevPin,
              onPressed: () => _stepPins(-1),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              tooltip: context.t.nextPin,
              onPressed: () => _stepPins(1),
            ),
            const Spacer(),
            FilledButton.tonalIcon(
              onPressed: () async {
                final catId = await strayCam(context, store);
                if (catId != null && context.mounted) {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CatDetailScreen(
                        store: store, catId: catId, startEditing: true),
                  ));
                }
                if (!mounted) return;
                setState(() {});
              },
              icon: const Icon(Icons.photo_camera),
              label: Text(context.t.strayCam),
            ),
          ]),
        ),
      ),
    );
  }

  /// The bar under a drawn trail: whose, how many values, the tapped
  /// dot's date and author, a way into the page, and off.
  Widget _trailBar(BuildContext context) {
    final t = context.t;
    final (id, field) = _trailOf!;
    final name = store.current(id, Keys.name) ?? t.unnamed;
    final def = field == CatalogStore.positionKey
        ? null
        : store.fieldDefs().where((d) => d.key == field).firstOrNull;
    final who = def == null ? name : '$name — ${fieldDefName(t, def)}';
    var label = t.trailOf(who, _trailPoints(_trailOf!).length);
    if (_dot case final dot?) {
      final date = dot.date.toLocal().toIso8601String().substring(0, 10);
      label = '$label · $date · ${dot.author}';
    }
    return BottomAppBar(
      child: Row(children: [
        Expanded(child: Text(label, overflow: TextOverflow.ellipsis)),
        TextButton(
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => id.startsWith('clowder:')
                  ? ClowderDetailScreen(store: store, clowderId: id)
                  : CatDetailScreen(store: store, catId: id),
            ));
            if (!mounted) return;
            setState(() {});
          },
          child: Text(t.open),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => setState(() {
            _trailOf = null;
            _dot = null;
          }),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_tiles == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final groups = _grouped(_catPins());
    final fliers = _flierPinned(store.visibleStrays());
    final clowders =
        _positioned(store.visibleClowders(), sightingsOnly: false);
    final userPins = _userPins();
    final all = [
      for (final g in groups) (g.cats.first, g.point),
      ...fliers,
      ...clowders,
      for (final (e, _, p) in userPins) (e, p),
    ];
    final stored = _storedViewport();
    final center = widget.initialCenter ??
        stored?.$1 ??
        (all.isEmpty ? const LatLng(51.0, 10.0) : all.first.$2);
    final zoom = widget.initialCenter != null
        ? 15.0
        : stored?.$2 ?? (all.isEmpty ? 6.0 : 13.0);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.map),
        // All map controls live in the toolbar below the map.
        actions: [
          HelpButton(store: store, screenId: 'map'),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Spotlight(
            id: 'map-search',
            child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _search,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _runSearch(),
              onChanged: (v) {
                if (v.isEmpty) setState(() => _hits = null);
              },
              decoration: InputDecoration(
                hintText: context.t.mapSearchHint,
                isDense: true,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          ),
        ),
      ),
      // One toolbar row below the map instead of buttons floating on
      // it: nothing covers the map, and aiming at a button can no
      // longer pan it (fat fingers, #74 sibling).
      body: Column(children: [
        Expanded(child: Stack(children: [
        FlutterMap(
        mapController: _controller,
        options: MapOptions(
          initialCenter: center,
          initialZoom: zoom,
          onLongPress: (_, point) => _longPress(point),
          // Reopen where the user left off (#55).
          onPositionChanged: (camera, _) => _rememberViewport(camera),
          // North stays up: accidental two-finger rotation kept leaving
          // testers with a tilted map and no way back.
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'io.github.paxel.catlog',
            tileProvider: _tiles,
            // Cached tiles pop in instantly; the fade animation only
            // delays them (and never finishes under the test clock).
            tileDisplay: const TileDisplay.instantaneous(),
          ),
          if (_strayAreas.isNotEmpty)
            CircleLayer(circles: [
              // The union of fixed 500 m circles around each selected
              // missing cat's flier positions and the home it ran from
              // — no radius knob (#31).
              for (final catId in _strayAreas)
                for (final pos in [
                  ...store.flierPositions(catId),
                  ?strayHomePosition(store, catId),
                ])
                  CircleMarker(
                    point: LatLng(pos.$1, pos.$2),
                    radius: strayAreaRadiusMeters,
                    useRadiusInMeter: true,
                    color: Colors.orange.withValues(alpha: 0.18),
                    borderColor: Colors.deepOrange,
                    borderStrokeWidth: 2,
                  ),
            ]),
          // The trail line lies under the pins and dots, so both stay
          // tappable.
          if (_trailOf != null && _trailPoints(_trailOf!).length > 1)
            PolylineLayer(polylines: [
              Polyline(
                points: [for (final (_, p) in _trailPoints(_trailOf!)) p],
                strokeWidth: 3,
                color: Colors.redAccent,
              ),
            ]),
          MarkerLayer(markers: [
            // Toggled stray areas carry the missing cat's face on each
            // flier position — flier-only cats become reachable (#55).
            for (final catId in _strayAreas)
              for (final pos in store.flierPositions(catId).skip(1))
                Marker(
                  point: LatLng(pos.$1, pos.$2),
                  width: _MapPin.width,
                  height: _MapPin.height,
                  alignment: Alignment.bottomCenter,
                  child: _MapPin(
                    label: null,
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            CatDetailScreen(store: store, catId: catId),
                      ));
                      if (!mounted) return;
                      setState(() {});
                    },
                    child: _catFace(catId, false),
                  ),
                ),
            for (final (clowder, point) in clowders)
              Marker(
                point: point,
                width: _MapPin.width,
                height: _MapPin.height,
                alignment: Alignment.bottomCenter,
                child: _MapPin(
                  label: clowder.name,
                  color: Theme.of(context).colorScheme.primary,
                  highlighted: _onTrail(clowder.id),
                  child: _clowderFace(clowder.id),
                  onTap: () => _toggleTrail(clowder.id),
                ),
              ),
            for (final group in groups)
              if (group.cats case [final cat])
                Marker(
                  point: group.point,
                  width: _MapPin.width,
                  height: _MapPin.height,
                  alignment: Alignment.bottomCenter,
                  child: _MapPin(
                    label: cat.name,
                    highlighted: _onTrail(cat.id),
                    child: _catFace(cat.id, _onTrail(cat.id)),
                    onTap: () => _toggleTrail(cat.id),
                  ),
                )
              else
                // Several cats on one spot: one pin, the freshest face,
                // the count — the list behind it tells them apart (#88).
                Marker(
                  point: group.point,
                  width: _MapPin.width,
                  height: _MapPin.height,
                  alignment: Alignment.bottomCenter,
                  child: _MapPin(
                    label: '${group.cats.first.name} +${group.cats.length - 1}',
                    child: _catFace(group.cats.first.id, false),
                    onTap: () => _openGroup(group),
                  ),
                ),
            if (widget.focus case (final id, final point))
              Marker(
                point: point,
                width: _MapPin.width,
                height: _MapPin.height,
                alignment: Alignment.bottomCenter,
                child: _MapPin(
                  label: store.current(id, Keys.name) ?? context.t.unnamed,
                  highlighted: true,
                  child: _focusFace(id),
                  onTap: () {},
                ),
              ),
            // Where the poster says the cat was lost: a square pin,
            // apart from the round sighting pins (#83).
            for (final (cat, point) in fliers)
              Marker(
                point: point,
                width: _MapPin.width,
                height: _MapPin.height,
                alignment: Alignment.bottomCenter,
                child: _MapPin(
                  label: cat.name,
                  highlighted: _onTrail(cat.id),
                  child: _flierFace(cat.id, _onTrail(cat.id)),
                  onTap: () => _toggleTrail(cat.id),
                ),
              ),
            // A keeper's own location fields: neutral pins, the field
            // named on the label, a trail like any other.
            for (final (entity, def, point) in userPins)
              Marker(
                point: point,
                width: _MapPin.width,
                height: _MapPin.height,
                alignment: Alignment.bottomCenter,
                child: _MapPin(
                  label: '${entity.name} · ${fieldDefName(context.t, def)}',
                  color: Colors.blueGrey,
                  highlighted: _onTrail(entity.id, def.key),
                  child: _placeFace(_onTrail(entity.id, def.key)),
                  onTap: () => _toggleTrail(entity.id, def.key),
                ),
              ),
            // One dot per value on the trail; a tap puts its date and
            // author into the trail label.
            if (_trailOf case final of?)
              for (final (entry, point) in _trailPoints(of))
                Marker(
                  point: point,
                  width: 20,
                  height: 20,
                  child: GestureDetector(
                    onTap: () => setState(() => _dot = entry),
                    child: Tooltip(
                      message: entry.date
                          .toLocal()
                          .toIso8601String()
                          .substring(0, 10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _dot == entry ? Colors.red : Colors.redAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
          ]),
          const SimpleAttributionWidget(
            source: Text('OpenStreetMap contributors'),
          ),
        ],
      ),
        if (_hits != null && _hits!.length != 1)
          Material(
            elevation: 4,
            child: _hits!.isEmpty
                ? ListTile(title: Text(context.t.noPlacesFound))
                : ListView(shrinkWrap: true, children: [
                    for (final (entity, point) in _hits!)
                      ListTile(
                        dense: true,
                        leading: Icon(entity.id.startsWith('cat:')
                            ? Icons.pets
                            : Icons.home_outlined),
                        title: Text(entity.name),
                        onTap: () {
                          setState(() => _hits = null);
                          FocusScope.of(context).unfocus();
                          _animateTo(point, 15);
                        },
                      ),
                  ]),
          ),
        if (_placeHits != null)
          Material(
            elevation: 4,
            child: _placeHits!.isEmpty
                ? ListTile(title: Text(context.t.noPlacesFound))
                : ListView(shrinkWrap: true, children: [
                    for (final hit in _placeHits!)
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.place_outlined),
                        title: Text(hit.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        onTap: () {
                          setState(() => _placeHits = null);
                          FocusScope.of(context).unfocus();
                          _showPlace(hit);
                        },
                      ),
                  ]),
          ),
          // The whole map answers to long-press (records a sighting) —
          // it wears the ear like every other hold-for-more surface.
          const PositionedDirectional(
              top: 0, end: 0, child: CatEarBadge()),
        ])),
        _toolbar(context),
      ]),
      bottomNavigationBar: _trailOf == null ? null : _trailBar(context),
    );
  }
}

/// Map pin: avatar/icon with the name on a readable chip below.
/// Cat pins within this distance merge into one (#88).
const groupMeters = 20.0;

class _PinGroup {
  final List<EntityView> cats;
  final LatLng point;

  _PinGroup(this.cats, this.point);
}

/// A pin on the map: the name above, the face, and a tip whose point
/// sits on the exact coordinate — the marker is anchored at its bottom
/// centre, so what the pin marks is never in doubt.
class _MapPin extends StatelessWidget {
  /// Null draws no label: a face and its tip alone.
  final String? label;
  final Widget child;
  final VoidCallback onTap;
  final bool highlighted;

  /// The tip's colour; the face's ring colour, so they read as one.
  final Color color;

  const _MapPin(
      {required this.label,
      required this.child,
      required this.onTap,
      this.highlighted = false,
      this.color = Colors.deepOrange});

  /// The marker box every pin is laid out in, anchored at the bottom.
  static const width = 110.0;
  static const height = 84.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (label case final label?)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: highlighted ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(blurRadius: 2, color: Colors.black26),
              ],
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: highlighted ? Colors.white : Colors.black87,
              ),
            ),
          ),
        if (label != null) const SizedBox(height: 2),
        child,
        PinTip(color: highlighted ? Colors.red : color),
      ]),
    );
  }
}

/// The point of a pin: a small triangle under the face, its apex on the
/// coordinate.
class PinTip extends StatelessWidget {
  final Color color;

  const PinTip({super.key, required this.color});

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: const Size(14, 9),
        painter: _PinTipPainter(color),
      );
}

class _PinTipPainter extends CustomPainter {
  final Color color;

  const _PinTipPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final path = ui.Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawShadow(path, Colors.black, 1.5, false);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_PinTipPainter old) => old.color != color;
}

/// Minimal cat-head silhouette (round head, two ears) — the placeholder
/// for photoless cats; deliberately not a symbol from any icon font.
class _CatSilhouettePainter extends CustomPainter {
  final Color color;

  const _CatSilhouettePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width, h = size.height;
    canvas.drawCircle(Offset(w / 2, h * 0.58), w * 0.38, paint);
    final leftEar = ui.Path()
      ..moveTo(w * 0.18, h * 0.42)
      ..lineTo(w * 0.24, h * 0.06)
      ..lineTo(w * 0.46, h * 0.26)
      ..close();
    final rightEar = ui.Path()
      ..moveTo(w * 0.82, h * 0.42)
      ..lineTo(w * 0.76, h * 0.06)
      ..lineTo(w * 0.54, h * 0.26)
      ..close();
    canvas.drawPath(leftEar, paint);
    canvas.drawPath(rightEar, paint);
  }

  @override
  bool shouldRepaint(_CatSilhouettePainter old) => old.color != color;
}
