import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'image_import.dart';
import 'name_proposals.dart';
import 'l10n.dart';
import 'exclusive.dart';

/// Why there is no position — each case gets its own explanation, and
/// where the user can fix it, the matching settings screen.
enum LocationFailure { serviceOff, denied, deniedForever, noFix }

/// What a position request came back with; [failure] is null on success.
typedef PositionOutcome = ({(double, double)? pos, LocationFailure? failure});

typedef Locator = Future<PositionOutcome> Function();

/// The local setting parking an in-flight Stray Cam capture (as JSON:
/// lat, lon, name) while the system camera is open, so a capture the OS
/// killed can be completed on the next start (see [recoverStrayCam]).
const strayCamPendingKey = 'strayCamPending';

/// The device's position, or why there is none.
Future<PositionOutcome> locateDevice() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    return (pos: null, failure: LocationFailure.serviceOff);
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.deniedForever) {
    return (pos: null, failure: LocationFailure.deniedForever);
  }
  if (permission == LocationPermission.denied) {
    return (pos: null, failure: LocationFailure.denied);
  }
  try {
    final p = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
    return (pos: (p.latitude, p.longitude), failure: null);
  } catch (_) {
    return (pos: null, failure: LocationFailure.noFix);
  }
}

/// Explains why there is no position, offering the settings screen that
/// fixes it where one exists. Anything is acceptable to users as long
/// as the reason is explained.
Future<void> explainLocationFailure(
    BuildContext context, LocationFailure failure,
    {Future<bool> Function() openAppSettings = Geolocator.openAppSettings,
    Future<bool> Function() openLocationSettings =
        Geolocator.openLocationSettings}) {
  final t = context.t;
  final message = switch (failure) {
    LocationFailure.serviceOff => t.locationServiceOff,
    LocationFailure.denied => t.locationDenied,
    LocationFailure.deniedForever => t.locationDeniedForever,
    LocationFailure.noFix => t.locationNoFix,
  };
  final openSettings = switch (failure) {
    LocationFailure.serviceOff => openLocationSettings,
    LocationFailure.deniedForever => openAppSettings,
    _ => null,
  };
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(openSettings == null ? t.ok : t.cancel),
        ),
        if (openSettings != null)
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              openSettings();
            },
            child: Text(t.openSettings),
          ),
      ],
    ),
  );
}

/// Stray Cam (CONTEXT.md): one tap — a new Stray exists at the current
/// position with a photo. No photo means no cat: the record is created
/// only after the picture arrives, so a canceled or killed camera
/// leaves no orphan behind.
/// One Stray Cam at a time (#91): a second press while the fix or the
/// camera is pending does nothing; a plugin error ends it with a
/// message; the parked capture is cleared however it ends.
Future<String?> strayCam(BuildContext context, CatalogStore store,
    {Locator locate = locateDevice,
    Future<Uint8List?> Function(BuildContext)? pickPhoto,
    Future<bool> Function() openSettings = Geolocator.openAppSettings,
    Future<bool> Function() openLocationSettings =
        Geolocator.openLocationSettings}) {
  return runExclusive(
    'strayCam',
    () => _strayCam(context, store,
        locate: locate,
        pickPhoto: pickPhoto,
        openSettings: openSettings,
        openLocationSettings: openLocationSettings),
    context: context,
  );
}

Future<String?> _strayCam(BuildContext context, CatalogStore store,
    {Locator locate = locateDevice,
    Future<Uint8List?> Function(BuildContext)? pickPhoto,
    Future<bool> Function() openSettings = Geolocator.openAppSettings,
    Future<bool> Function() openLocationSettings =
        Geolocator.openLocationSettings}) async {
  final outcome = await locate();
  final position = outcome.pos;
  if (position == null) {
    if (context.mounted) {
      await explainLocationFailure(
          context, outcome.failure ?? LocationFailure.noFix,
          openAppSettings: openSettings,
          openLocationSettings: openLocationSettings);
    }
    return null;
  }
  String? name;
  if (context.mounted) {
    name = await proposeCatName(store, Localizations.localeOf(context));
  }
  name ??=
      'Stray ${DateTime.now().toIso8601String().substring(0, 16).replaceFirst('T', ' ')}';
  // Park the capture: if Android kills the app behind the camera, the
  // photo arrives on next start as image_picker "lost data".
  store.setLocalSetting(strayCamPendingKey,
      jsonEncode({'lat': position.$1, 'lon': position.$2, 'name': name}));
  Uint8List? bytes;
  try {
    if (context.mounted) {
      // Field speed beats framing: Stray Cam skips the crop step.
      bytes = await (pickPhoto ??
          ((c) => pickImageBytes(c, allowCrop: false)))(context);
    }
  } finally {
    // Cancelled, failed or done: nothing stays parked (#91).
    if (store.isOpen) store.setLocalSetting(strayCamPendingKey, '');
  }
  if (bytes == null) return null;
  final catId = store.createCat(name);
  store.recordPosition(catId, position.$1, position.$2);
  await addCompressedImage(store, catId, bytes);
  return catId;
}

/// Completes a Stray Cam capture whose camera never returned because
/// the OS killed the app: image_picker hands the photo over on the next
/// start, the position and name were parked in [strayCamPendingKey].
Future<void> recoverStrayCam(CatalogStore store,
    {Future<LostDataResponse> Function()? retrieve}) async {
  final pending = store.localSetting(strayCamPendingKey);
  if (pending == null || pending.isEmpty) return;
  if (retrieve == null && !Platform.isAndroid) {
    store.setLocalSetting(strayCamPendingKey, '');
    return;
  }
  final LostDataResponse response;
  try {
    response = await (retrieve ?? ImagePicker().retrieveLostData)();
  } catch (_) {
    // Retrieval failed — keep the parked capture for the next start.
    return;
  }
  store.setLocalSetting(strayCamPendingKey, '');
  final file = response.file;
  if (file == null) return;
  final Map<String, dynamic> capture;
  try {
    capture = jsonDecode(pending) as Map<String, dynamic>;
  } catch (_) {
    return;
  }
  final lat = capture['lat'], lon = capture['lon'], name = capture['name'];
  if (lat is! num || lon is! num || name is! String) return;
  final bytes = await file.readAsBytes();
  final catId = store.createCat(name);
  store.recordPosition(catId, lat.toDouble(), lon.toDouble());
  await addCompressedImage(store, catId, bytes);
}

/// Records a sighting of an existing cat at the device's position.
/// Returns null on success, otherwise why no position was available.
Future<LocationFailure?> seenHereNow(CatalogStore store, String catId) async {
  final outcome = await locateDevice();
  final position = outcome.pos;
  if (position == null) return outcome.failure ?? LocationFailure.noFix;
  store.recordPosition(catId, position.$1, position.$2);
  return null;
}
