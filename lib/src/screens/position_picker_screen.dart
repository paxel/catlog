import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

import '../l10n.dart';
import '../map/cached_tiles.dart';
import '../stray_cam.dart';

/// Picks a position on the map: tap drops the pin, "use my location"
/// jumps to GPS. Pops "lat,lon" — nobody types coordinates.
class PositionPickerScreen extends StatefulWidget {
  final String? initial;

  /// Test override; defaults to disk-cached OSM tiles.
  final TileProvider? tileProvider;

  const PositionPickerScreen({super.key, this.initial, this.tileProvider});

  @override
  State<PositionPickerScreen> createState() => _PositionPickerScreenState();
}

class _PositionPickerScreenState extends State<PositionPickerScreen> {
  TileProvider? _tiles;
  LatLng? _picked;
  final _controller = MapController();

  @override
  void initState() {
    super.initState();
    final initial = CatalogStore.parsePosition(widget.initial);
    if (initial != null) _picked = LatLng(initial.$1, initial.$2);
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

  Future<void> _useMyLocation() async {
    final position = await currentPosition();
    if (position == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.t.noLocationAvailable)));
      }
      return;
    }
    if (!mounted) return;
    setState(() => _picked = LatLng(position.$1, position.$2));
    _controller.move(_picked!, 15);
  }

  @override
  Widget build(BuildContext context) {
    if (_tiles == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.starterPosition),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: context.t.save,
            onPressed: _picked == null
                ? null
                : () => Navigator.of(context).pop(
                    '${_picked!.latitude},${_picked!.longitude}'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _useMyLocation,
        icon: const Icon(Icons.my_location),
        label: Text(context.t.useMyLocation),
      ),
      body: FlutterMap(
        mapController: _controller,
        options: MapOptions(
          initialCenter: _picked ?? const LatLng(51.0, 10.0),
          initialZoom: _picked == null ? 6 : 14,
          onTap: (_, point) => setState(() => _picked = point),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'io.github.paxel.catlog',
            tileProvider: _tiles,
          ),
          if (_picked != null)
            MarkerLayer(markers: [
              Marker(
                point: _picked!,
                width: 44,
                height: 44,
                alignment: Alignment.topCenter,
                child: const Icon(Icons.location_pin,
                    size: 44, color: Colors.deepOrange),
              ),
            ]),
          const SimpleAttributionWidget(
            source: Text('OpenStreetMap contributors'),
          ),
        ],
      ),
    );
  }
}
