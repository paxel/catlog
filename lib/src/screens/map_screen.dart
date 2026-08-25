import 'dart:io';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';

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

  const MapScreen(
      {super.key,
      required this.store,
      this.tileProvider,
      this.initialCenter,
      this.geocode});

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

  /// Cat whose movement trail is drawn; tap its pin to toggle.
  String? _trailCat;

  /// Missing cats whose possible stray area (500 m circles around their
  /// flier positions) is overlaid (#31).
  final _strayAreas = <String>{};

  CatalogStore get store => widget.store;

  @override
  void dispose() {
    _glide?.dispose();
    _viewportSave?.cancel();
    _search.dispose();
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
    return (LatLng(lat, lon), zoom);
  }

  void _rememberViewport(MapCamera camera) {
    _viewportSave?.cancel();
    _viewportSave = Timer(const Duration(seconds: 1), () {
      store.setLocalSetting(mapViewportKey,
          '${camera.center.latitude},${camera.center.longitude},${camera.zoom}');
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

  Future<void> _jumpToMyLocation() async {
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
      ..._positioned(store.visibleStrays(), sightingsOnly: true),
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

  /// Dated sighting positions of a cat, oldest first — flier positions
  /// are not part of the trail (#30).
  List<(DateTime, LatLng)> _trail(String catId) => [
        for (final e
            in store.fieldHistory(catId, CatalogStore.positionKey).reversed)
          if (CatalogStore.parsePositionKind(e.value ?? '') ==
                  PositionKind.sighting &&
              CatalogStore.parsePosition(e.value) != null)
            (
              e.date,
              LatLng(CatalogStore.parsePosition(e.value)!.$1,
                  CatalogStore.parsePosition(e.value)!.$2)
            )
      ];

  @override
  void initState() {
    super.initState();
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

  /// Strays pin at their latest sighting; a flier-only stray stays off
  /// the map (#30). Clowders pin at their plain position.
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
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheet) => SafeArea(
          child: ListView(shrinkWrap: true, children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(context.t.strayAreaLabel,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            if (missing.isEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(context.t.noMissingCats),
              ),
            for (final cat in missing)
              CheckboxListTile(
                value: _strayAreas.contains(cat.id),
                title: Text(cat.name),
                secondary:
                    CatAvatar(store: store, catId: cat.id, size: 36),
                onChanged: (on) {
                  setSheet(() {});
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
            ? const CustomPaint(
                size: Size(24, 24),
                painter: _CatSilhouettePainter(Colors.deepOrange))
            : null,
      ),
    );
    if (!dead) return face;
    return Opacity(
      opacity: 0.65,
      child: ColorFiltered(colorFilter: greyscale, child: face),
    );
  }

  /// A clowder's own photo in a rounded-square ring — visually distinct
  /// from the round cat faces; house silhouette only as placeholder.
  Widget _clowderFace(String clowderId) {
    final images = store.images(clowderId);
    final bytes =
        images.isEmpty ? null : store.imageBytes(images.first);
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 3),
        color: bytes == null ? color : Colors.white,
        image: bytes != null
            ? DecorationImage(
                image: MemoryImage(bytes), fit: BoxFit.cover)
            : null,
      ),
      child: bytes == null
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
              icon: const Icon(Icons.my_location),
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

  @override
  Widget build(BuildContext context) {
    if (_tiles == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final strays =
        _positioned(store.visibleStrays(), sightingsOnly: true);
    final clowders =
        _positioned(store.visibleClowders(), sightingsOnly: false);
    final all = [...strays, ...clowders];
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
          MarkerLayer(markers: [
            // Toggled stray areas carry the missing cat's face on each
            // flier position — flier-only cats become reachable (#55).
            for (final catId in _strayAreas)
              for (final pos in store.flierPositions(catId))
                Marker(
                  point: LatLng(pos.$1, pos.$2),
                  width: 48,
                  height: 48,
                  child: GestureDetector(
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
                width: 110,
                height: 72,
                alignment: Alignment.topCenter,
                child: _MapPin(
                  label: clowder.name,
                  child: _clowderFace(clowder.id),
                  onTap: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ClowderDetailScreen(
                        store: store, clowderId: clowder.id),
                  )),
                ),
              ),
            for (final (cat, point) in strays)
              Marker(
                point: point,
                width: 110,
                height: 72,
                alignment: Alignment.topCenter,
                child: _MapPin(
                  label: cat.name,
                  highlighted: _trailCat == cat.id,
                  child: _catFace(cat.id, _trailCat == cat.id),
                  onTap: () => setState(() =>
                      _trailCat = _trailCat == cat.id ? null : cat.id),
                ),
              ),
            if (_trailCat != null)
              for (final (date, point) in _trail(_trailCat!))
                Marker(
                  point: point,
                  width: 20,
                  height: 20,
                  child: Tooltip(
                    message: date
                        .toLocal()
                        .toIso8601String()
                        .substring(0, 10),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
          ]),
          if (_trailCat != null && _trail(_trailCat!).length > 1)
            PolylineLayer(polylines: [
              Polyline(
                points: [for (final (_, p) in _trail(_trailCat!)) p],
                strokeWidth: 3,
                color: Colors.redAccent,
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
      bottomNavigationBar: _trailCat == null
          ? null
          : BottomAppBar(
              child: Row(children: [
                Expanded(
                  child: Text(
                    context.t.trailOf(
                        store.current(_trailCat!, Keys.name) ?? '',
                        _trail(_trailCat!).length),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CatDetailScreen(
                          store: store, catId: _trailCat!),
                    ));
                    if (!mounted) return;
                    setState(() {});
                  },
                  child: Text(context.t.open),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _trailCat = null),
                ),
              ]),
            ),
    );
  }
}

/// Map pin: avatar/icon with the name on a readable chip below.
class _MapPin extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback onTap;
  final bool highlighted;

  const _MapPin(
      {required this.label,
      required this.child,
      required this.onTap,
      this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        child,
        const SizedBox(height: 2),
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
      ]),
    );
  }
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
