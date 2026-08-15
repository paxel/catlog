import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'image_import.dart';

/// The device's position, or null when the service is off or denied.
/// Denial degrades gracefully — the map's long-press pin still works.
Future<(double, double)?> currentPosition() async {
  if (!await Geolocator.isLocationServiceEnabled()) return null;
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    return null;
  }
  try {
    final p = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
    return (p.latitude, p.longitude);
  } catch (_) {
    return null;
  }
}

/// Stray Cam (CONTEXT.md): one tap — a new Stray exists at the current
/// position with a photo. Name is generated; rename later if wanted.
/// Returns the new cat's id, or null if location was unavailable.
Future<String?> strayCam(BuildContext context, CatalogStore store) async {
  final position = await currentPosition();
  if (position == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No location available — long-press the map to '
            'place the stray by hand.'),
      ));
    }
    return null;
  }
  final now = DateTime.now();
  final name = 'Stray ${now.toIso8601String().substring(0, 16).replaceFirst('T', ' ')}';
  final catId = store.createCat(name);
  store.recordPosition(catId, position.$1, position.$2);
  if (context.mounted) {
    await pickAndAddImage(context, store, catId);
  }
  return catId;
}

/// Records a sighting of an existing cat at the device's position.
/// Returns false when no location was available.
Future<bool> seenHereNow(CatalogStore store, String catId) async {
  final position = await currentPosition();
  if (position == null) return false;
  store.recordPosition(catId, position.$1, position.$2);
  return true;
}
