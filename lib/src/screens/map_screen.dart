import 'dart:io';
import 'dart:ui' as ui;

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

import '../hidden.dart';
import '../l10n.dart';
import '../map/cached_tiles.dart';
import '../stray_cam.dart';
import '../widgets/cat_avatar.dart';
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

  const MapScreen(
      {super.key, required this.store, this.tileProvider, this.initialCenter});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TileProvider? _tiles;
  final _controller = MapController();
  final _search = TextEditingController();
  List<(EntityView, LatLng)>? _hits;

  /// Cat whose movement trail is drawn; tap its pin to toggle.
  String? _trailCat;

  CatalogStore get store => widget.store;

  /// Dated positions of a cat, oldest first.
  List<(DateTime, LatLng)> _trail(String catId) => [
        for (final e
            in store.fieldHistory(catId, CatalogStore.positionKey).reversed)
          if (CatalogStore.parsePosition(e.value) != null)
            (
              e.date,
              LatLng(CatalogStore.parsePosition(e.value)!.$1,
                  CatalogStore.parsePosition(e.value)!.$2)
            )
      ];

  @override
  void initState() {
    super.initState();
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

  List<(EntityView, LatLng)> _positioned(List<EntityView> entities) => [
        for (final e in entities)
          if (store.positionOf(e.id) != null)
            (
              e,
              LatLng(store.positionOf(e.id)!.$1, store.positionOf(e.id)!.$2)
            )
      ];

  Future<void> _longPress(LatLng point) async {
    final clowders = store.visibleClowders();
    final strays = store.visibleStrays();
    final action = await showModalBottomSheet<(String, String)>(
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
              onTap: () => Navigator.of(context).pop(('stray', s.id)),
            ),
          if (clowders.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(context.t.orPlaceClowderHere),
            ),
          for (final c in clowders)
            ListTile(
              leading: SizedBox(
                  width: 40, height: 40, child: _clowderFace(c.id)),
              title: Text(c.name),
              onTap: () => Navigator.of(context).pop(('clowder', c.id)),
            ),
        ]),
      ),
    );
    if (action == null) return;
    store.recordPosition(action.$2, point.latitude, point.longitude);
    setState(() {});
  }

  /// A stray's face for its map pin: profile photo in a ring, paw icon
  /// as fallback.
  Widget _catFace(String catId, bool highlighted) {
    final hash = store.profileImage(catId);
    final bytes = hash == null ? null : store.imageBytes(hash);
    final ring = highlighted ? Colors.red : Colors.deepOrange;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: 3),
        color: Colors.white,
      ),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white,
        backgroundImage: bytes != null ? MemoryImage(bytes) : null,
        child: bytes == null
            ? const CustomPaint(
                size: Size(24, 24),
                painter: _CatSilhouettePainter(Colors.deepOrange))
            : null,
      ),
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

  void _runSearch() {
    final query = _search.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => _hits = null);
      return;
    }
    final byAuthor = store.entitiesTouchedBy(query).toSet();
    bool matches(EntityView e) =>
        e.name.toLowerCase().contains(query) || byAuthor.contains(e.id);
    final found = <(EntityView, LatLng)>[
      for (final entry in [
        ..._positioned(store.visibleCats()),
        ..._positioned(store.visibleClowders()),
      ])
        if (matches(entry.$1)) entry
    ];
    setState(() => _hits = found);
    if (found.length == 1) {
      _controller.move(found.single.$2, 15);
    } else if (found.length > 1) {
      _controller.fitCamera(CameraFit.bounds(
        bounds: LatLngBounds.fromPoints([for (final f in found) f.$2]),
        padding: const EdgeInsets.all(64),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_tiles == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final strays = _positioned(store.visibleStrays());
    final clowders = _positioned(store.visibleClowders());
    final all = [...strays, ...clowders];
    final center = widget.initialCenter ??
        (all.isEmpty ? const LatLng(51.0, 10.0) : all.first.$2);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.map),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final catId = await strayCam(context, store);
          if (catId != null && context.mounted) {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CatDetailScreen(store: store, catId: catId),
            ));
          }
          setState(() {});
        },
        icon: const Icon(Icons.photo_camera),
        label: Text(context.t.strayCam),
      ),
      body: Stack(children: [
        FlutterMap(
        mapController: _controller,
        options: MapOptions(
          initialCenter: center,
          initialZoom:
              widget.initialCenter != null ? 15 : (all.isEmpty ? 6 : 13),
          onLongPress: (_, point) => _longPress(point),
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
          MarkerLayer(markers: [
            for (final (clowder, point) in clowders)
              Marker(
                point: point,
                width: 110,
                height: 72,
                alignment: Alignment.topCenter,
                child: _MapPin(
                  label: clowder.name,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.home,
                        size: 24, color: Colors.white),
                  ),
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
                          _controller.move(point, 15);
                        },
                      ),
                  ]),
          ),
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
