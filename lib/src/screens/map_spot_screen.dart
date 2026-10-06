import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../cover_picture.dart';
import '../field_labels.dart';
import '../hidden.dart';
import '../l10n.dart';
import '../widgets/cat_avatar.dart';
import 'cat_detail_screen.dart';
import 'clowder_detail_screen.dart';

/// What stands on one spot of the map, behind a merged pin: a row per
/// thing in the pin's order, a tap opens it, the map icon goes back to
/// the map with that thing's trail on.
class MapSpotScreen extends StatelessWidget {
  final CatalogStore store;
  final PinSpot spot;

  const MapSpotScreen({super.key, required this.store, required this.spot});

  Widget _face(MapPin pin) => switch (pin.kind) {
    PinKind.home => _cover(pin.id),
    PinKind.cat ||
    PinKind.flier => CatAvatar(store: store, catId: pin.id, size: 40),
    PinKind.field =>
      pin.id.startsWith('clowder:')
          ? _cover(pin.id)
          : CatAvatar(store: store, catId: pin.id, size: 40),
  };

  Widget _cover(String clowderId) {
    final image = coverImage(store, clowderId);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.brown.shade300,
        image: image != null
            ? DecorationImage(image: image, fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? const Icon(Icons.home, size: 22, color: Colors.white)
          : null,
    );
  }

  String _kind(BuildContext context, MapPin pin) {
    final t = context.t;
    return switch (pin.kind) {
      PinKind.home => t.kindClowder,
      PinKind.cat => t.kindCat,
      PinKind.flier => t.stray,
      PinKind.field => fieldDefName(
        t,
        store.visibleFieldDefs().firstWhere((d) => d.key == pin.fieldKey),
      ),
    };
  }

  Future<void> _open(BuildContext context, MapPin pin) async {
    final page = pin.id.startsWith('clowder:')
        ? ClowderDetailScreen(store: store, clowderId: pin.id)
        : CatDetailScreen(store: store, catId: pin.id);
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(spot.label)),
      body: ListView(
        children: [
          for (final pin in spot.pins)
            ListTile(
              leading: _face(pin),
              title: Text(pin.name),
              subtitle: Text(_kind(context, pin)),
              trailing: IconButton(
                icon: const Icon(Icons.map),
                tooltip: t.showOnMap,
                onPressed: () => Navigator.of(context)
                    .pop((pin.id, pin.fieldKey ?? CatalogStore.positionKey)),
              ),
              onTap: () => _open(context, pin),
            ),
        ],
      ),
    );
  }
}
