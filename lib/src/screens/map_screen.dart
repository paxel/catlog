import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> _longPress(LatLng point) async {
    final clowders = store.clowders();
    final strays = store.strays();
    final action = await showModalBottomSheet<(String, String)>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(shrinkWrap: true, children: [
          if (strays.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text('Record a sighting here:'),
            ),
          for (final s in strays)
            ListTile(
              leading: const Icon(Icons.pets),
              title: Text(s.name),
              onTap: () => Navigator.of(context).pop(('stray', s.id)),
            ),
          if (clowders.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text('Or place a clowder here:'),
            ),
          for (final c in clowders)
            ListTile(
              leading: const Icon(Icons.home),
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
      appBar: AppBar(title: const Text('Map')),
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
        label: const Text('Stray Cam'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: all.isEmpty ? 6 : 13,
          onLongPress: (_, point) => _longPress(point),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'io.github.paxel.catlog',
            tileProvider: _tiles,
          ),
          MarkerLayer(markers: [
            for (final (clowder, point) in clowders)
              Marker(
                point: point,
                width: 44,
                height: 44,
                child: IconButton(
                  icon: const Icon(Icons.home, size: 32),
                  color: Theme.of(context).colorScheme.primary,
                  tooltip: clowder.name,
                  onPressed: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ClowderDetailScreen(
                        store: store, clowderId: clowder.id),
                  )),
                ),
              ),
            for (final (cat, point) in strays)
              Marker(
                point: point,
                width: 44,
                height: 44,
                child: IconButton(
                  icon: Icon(Icons.pets,
                      size: _trailCat == cat.id ? 36 : 30),
                  color: _trailCat == cat.id
                      ? Colors.red
                      : Colors.deepOrange,
                  tooltip: cat.name,
                  onPressed: () => setState(() =>
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
                    'Trail: ${store.current(_trailCat!, Keys.name) ?? ''} '
                    '(${_trail(_trailCat!).length} sightings)',
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
                  child: const Text('Open'),
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
