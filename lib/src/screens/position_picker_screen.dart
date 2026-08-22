import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

import '../geocode.dart';
import '../l10n.dart';
import '../map/cached_tiles.dart';
import '../map/place_view.dart';
import '../stray_cam.dart';

/// Where the picker last was, so the next pick starts in the same
/// region instead of a country-level default. Session memory is enough:
/// across restarts the GPS jump covers it.
LatLng? _lastRegion;
double _lastZoom = 14;

/// Picks a position on the map: tap drops the pin, "use my location"
/// jumps to GPS, and a place search (OSM Nominatim) jumps anywhere by
/// name. Pops "lat,lon" — nobody types coordinates. Opens at the pin,
/// else at the device position, else at the last picked region.
class PositionPickerScreen extends StatefulWidget {
  final String? initial;

  /// Test override; defaults to disk-cached OSM tiles.
  final TileProvider? tileProvider;

  /// Test override; defaults to Nominatim.
  final GeocodeSearch? geocode;

  const PositionPickerScreen(
      {super.key, this.initial, this.tileProvider, this.geocode});

  @override
  State<PositionPickerScreen> createState() => _PositionPickerScreenState();
}

class _PositionPickerScreenState extends State<PositionPickerScreen> {
  TileProvider? _tiles;
  LatLng? _picked;
  final _controller = MapController();
  final _search = TextEditingController();
  List<GeoHit>? _hits;
  bool _searching = false;
  bool _touched = false;

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
    // No pin to return to: jump to the device position once it arrives,
    // unless the user already moved the map themselves.
    if (_picked == null) {
      locateDevice().then((outcome) {
        final p = outcome.pos;
        if (p != null && mounted && !_touched && _picked == null) {
          _controller.move(LatLng(p.$1, p.$2), 15);
        }
      });
    }
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _useMyLocation() async {
    final outcome = await locateDevice();
    final position = outcome.pos;
    if (position == null) {
      if (mounted) {
        await explainLocationFailure(
            context, outcome.failure ?? LocationFailure.noFix);
      }
      return;
    }
    if (!mounted) return;
    setState(() => _picked = LatLng(position.$1, position.$2));
    _controller.move(_picked!, 15);
  }

  Future<void> _runSearch() async {
    final query = _search.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _searching = true;
      _hits = null;
    });
    List<GeoHit> hits;
    try {
      hits = await (widget.geocode ?? nominatimSearch)(query);
    } catch (_) {
      hits = const [];
    }
    if (!mounted) return;
    setState(() {
      _searching = false;
      _hits = hits;
    });
  }

  void _jumpTo(GeoHit hit) {
    setState(() => _hits = null);
    _search.clear();
    FocusScope.of(context).unfocus();
    // Street zoom, or the place's own extent — a centered hit shown at
    // country zoom is useless for dropping a pin.
    final fit = placeFit(hit);
    if (fit == null) {
      _controller.move(LatLng(hit.lat, hit.lon), placeZoom);
    } else {
      _controller.fitCamera(fit);
    }
  }

  void _pop() {
    _lastRegion = _controller.camera.center;
    _lastZoom = _controller.camera.zoom;
    Navigator.of(context)
        .pop('${_picked!.latitude},${_picked!.longitude}');
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
            onPressed: _picked == null ? null : _pop,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _search,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _runSearch(),
              decoration: InputDecoration(
                hintText: context.t.searchPlaceHint,
                isDense: true,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searching
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                            width: 18,
                            height: 18,
                            child:
                                CircularProgressIndicator(strokeWidth: 2)),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _useMyLocation,
        icon: const Icon(Icons.my_location),
        label: Text(context.t.useMyLocation),
      ),
      body: Stack(children: [
        FlutterMap(
          mapController: _controller,
          options: MapOptions(
            initialCenter: _picked ?? _lastRegion ?? const LatLng(51.0, 10.0),
            initialZoom:
                _picked != null ? 14 : (_lastRegion != null ? _lastZoom : 6),
            onTap: (_, point) => setState(() => _picked = point),
            onPositionChanged: (_, byGesture) {
              if (byGesture) _touched = true;
            },
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
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
        if (_hits != null)
          Material(
            elevation: 4,
            child: _hits!.isEmpty
                ? ListTile(title: Text(context.t.noPlacesFound))
                : ListView(shrinkWrap: true, children: [
                    for (final hit in _hits!)
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.place_outlined),
                        title: Text(hit.name,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        onTap: () => _jumpTo(hit),
                      ),
                  ]),
          ),
      ]),
    );
  }
}
