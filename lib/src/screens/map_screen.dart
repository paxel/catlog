import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

import '../image_provider_cache.dart';
import '../l10n.dart';
import '../map/cached_tiles.dart';
import '../stray_cam.dart';
import 'cat_detail_screen.dart';
import 'clowder_detail_screen.dart';

/// The map: Strays at their latest position, Clowders as home pins.
/// Long-press places a Clowder or records a Stray sighting at that spot.
class MapScreen extends StatefulWidget {
  final CatalogStore store;

  /// Test override; defaults to disk-cached OSM tiles.
  final TileProvider? tileProvider;

  const MapScreen({super.key, required this.store, this.tileProvider});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TileProvider? _tiles;

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

  // Only sightings are recorded from the map; a clowder's position is set
  // via its Position field — clowders move far too rarely for a map menu.
  Future<void> _longPress(LatLng point) async {
    final strays = store.strays();
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
              leading: const Icon(Icons.pets),
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

  /// A stray's face for its map pin: profile photo in a ring, paw icon
  /// as fallback.
  Widget _catFace(String catId, bool highlighted) {
    final hash = store.profileImage(catId);
    final photo = hash == null ? null : imageProviderFor(store, hash);
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
        // Decode at pin size — full-resolution photos (2560px ≈ 26MB
        // decoded) in a 40px circle were the other leg of the OOM.
        backgroundImage:
            photo != null ? ResizeImage(photo, width: 96) : null,
        child: photo == null
            ? const Icon(Icons.pets, size: 20, color: Colors.deepOrange)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_tiles == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final strays = _positioned(store.strays());
    final clowders = _positioned(store.clowders());
    final all = [...strays, ...clowders];
    final center =
        all.isEmpty ? const LatLng(51.0, 10.0) : all.first.$2;
    return Scaffold(
      appBar: AppBar(title: Text(context.t.map)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final catId = await strayCam(context, store);
          if (catId != null && context.mounted) {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CatDetailScreen(store: store, catId: catId),
            ));
          }
          if (!mounted) return;
          setState(() {});
        },
        icon: const Icon(Icons.photo_camera),
        label: Text(context.t.strayCam),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: all.isEmpty ? 6 : 13,
          onLongPress: (_, point) => _longPress(point),
          // North stays up: accidental two-finger rotation kept leaving
          // testers with a tilted map and no way back.
          interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
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
