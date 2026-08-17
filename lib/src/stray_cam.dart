import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'image_import.dart';
import 'l10n.dart';

/// What a position request came back with; [deniedForever] means only
/// the system settings can change the user's mind.
typedef PositionOutcome = ({(double, double)? pos, bool deniedForever});

typedef Locator = Future<PositionOutcome> Function();

/// The local setting parking an in-flight Stray Cam capture while the
/// system camera is open, so a capture the OS killed can be completed
/// on the next start (see [recoverStrayCam]).
const _pendingKey = 'strayCamPending';

/// The device's position, or why there is none. Denial degrades
/// gracefully — the map's long-press pin still works.
Future<PositionOutcome> locateDevice() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    return (pos: null, deniedForever: false);
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.deniedForever) {
    return (pos: null, deniedForever: true);
  }
  if (permission == LocationPermission.denied) {
    return (pos: null, deniedForever: false);
  }
  try {
    final p = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
    return (pos: (p.latitude, p.longitude), deniedForever: false);
  } catch (_) {
    return (pos: null, deniedForever: false);
  }
}

/// The device's position, or null when the service is off or denied.
Future<(double, double)?> currentPosition() async =>
    (await locateDevice()).pos;

/// Stray Cam (CONTEXT.md): one tap — a new Stray exists at the current
/// position with a photo. No photo means no cat: the record is created
/// only after the picture arrives, so a canceled or killed camera
/// leaves no orphan behind.
Future<String?> strayCam(BuildContext context, CatalogStore store,
    {Locator locate = locateDevice,
    Future<Uint8List?> Function(BuildContext)? pickPhoto,
    Future<bool> Function() openSettings = Geolocator.openAppSettings}) async {
  final outcome = await locate();
  final position = outcome.pos;
  if (position == null) {
    if (context.mounted) {
      if (outcome.deniedForever) {
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(context.t.locationDeniedForever),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.t.cancel),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openSettings();
                },
                child: Text(context.t.openSettings),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(context.t.noLocationAvailable),
        ));
      }
    }
    return null;
  }
  final now = DateTime.now();
  final name =
      'Stray ${now.toIso8601String().substring(0, 16).replaceFirst('T', ' ')}';
  // Park the capture: if Android kills the app behind the camera, the
  // photo arrives on next start as image_picker "lost data".
  store.setLocalSetting(
      _pendingKey, '${position.$1},${position.$2},$name');
  Uint8List? bytes;
  if (context.mounted) {
    // Field speed beats framing: Stray Cam skips the crop step.
    bytes = await (pickPhoto ??
        ((c) => pickImageBytes(c, allowCrop: false)))(context);
  }
  store.setLocalSetting(_pendingKey, '');
  if (bytes == null) return null;
  final catId = store.createCat(name);
  store.recordPosition(catId, position.$1, position.$2);
  final data = bytes;
  final jpeg = await Isolate.run(() => CatalogStore.compressImage(data));
  store.addImage(catId, jpeg);
  return catId;
}

/// Completes a Stray Cam capture whose camera never returned because
/// the OS killed the app: image_picker hands the photo over on the next
/// start, the position and name were parked in [_pendingKey].
Future<void> recoverStrayCam(CatalogStore store,
    {Future<LostDataResponse> Function()? retrieve}) async {
  final pending = store.localSetting(_pendingKey);
  if (pending == null || pending.isEmpty) return;
  store.setLocalSetting(_pendingKey, '');
  if (retrieve == null && !Platform.isAndroid) return;
  final response =
      await (retrieve ?? ImagePicker().retrieveLostData)();
  final file = response.file;
  if (file == null) return;
  final parts = pending.split(',');
  if (parts.length < 3) return;
  final lat = double.tryParse(parts[0]);
  final lon = double.tryParse(parts[1]);
  if (lat == null || lon == null) return;
  final bytes = await file.readAsBytes();
  final jpeg = await Isolate.run(() => CatalogStore.compressImage(bytes));
  final catId = store.createCat(parts.sublist(2).join(','));
  store.recordPosition(catId, lat, lon);
  store.addImage(catId, jpeg);
}

/// Records a sighting of an existing cat at the device's position.
/// Returns false when no location was available.
Future<bool> seenHereNow(CatalogStore store, String catId) async {
  final position = await currentPosition();
  if (position == null) return false;
  store.recordPosition(catId, position.$1, position.$2);
  return true;
}
