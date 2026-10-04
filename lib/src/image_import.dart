import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'screens/photo_edit_screen.dart';
import 'video_frames_io.dart';
import 'exclusive.dart';

/// Lets the user pick or take a photo, offers the crop step (skippable;
/// Stray Cam passes [allowCrop] false), compresses off the UI thread,
/// and stores it on the Cat. Returns the content hash, or null if the
/// user canceled.
Future<String?> pickAndAddImage(
    BuildContext context, CatalogStore store, String catId,
    {bool allowCrop = true}) async {
  final raw = await pickImageBytes(context, allowCrop: allowCrop);
  if (raw == null) return null;
  return addCompressedImage(store, catId, raw);
}

/// Compresses off the UI thread, cutting out [crop] if given, and
/// stores the photo on the cat. Null when the catalog was switched away
/// (and closed) meanwhile — the photo then has no home, and a write
/// would be a crash.
Future<String?> addCompressedImage(
    CatalogStore store, String catId, Uint8List bytes,
    {CropFractions? crop}) async {
  final jpeg =
      await Isolate.run(() => CatalogStore.compressImage(bytes, crop: crop));
  if (!store.isOpen) return null;
  return store.addImage(catId, jpeg);
}

/// A frame kept from a video and the part of it to store; a null [crop]
/// stores all of it.
typedef KeptFrame = ({Uint8List bytes, CropFractions? crop});

/// Stores [frames] on the cat one after the other and reports after
/// each — the page shows them as they land instead of all at once after
/// a silent wait. Returns how many landed.
Future<int> addFrames(CatalogStore store, String catId, List<KeptFrame> frames,
    {void Function(int done, int total)? onProgress}) async {
  var done = 0;
  for (final frame in frames) {
    if (await addCompressedImage(store, catId, frame.bytes,
            crop: frame.crop) ==
        null) {
      break;
    }
    done++;
    onProgress?.call(done, frames.length);
  }
  return done;
}

/// One crop page over a frame: null when canceled.
typedef CropStep = Future<CropChoice?> Function(
    BuildContext context, Uint8List frame);

Future<CropChoice?> cropPage(BuildContext context, Uint8List frame) =>
    Navigator.of(context).push<CropChoice>(MaterialPageRoute(
      builder: (_) => PhotoEditScreen(
          bytes: frame,
          mode: PhotoEditMode.crop,
          allowSkip: true,
          selectOnly: true),
    ));

/// The crop step for each frame kept from a video, in order, on the
/// full-size frame before anything is compressed. "Use full photo"
/// keeps a frame whole; Cancel drops only that frame.
Future<List<KeptFrame>> cropFrames(
    BuildContext context, List<Uint8List> frames,
    {CropStep cropStep = cropPage}) async {
  final kept = <KeptFrame>[];
  for (final frame in frames) {
    if (!context.mounted) break;
    final choice = await cropStep(context, frame);
    if (choice != null) kept.add((bytes: frame, crop: choice.crop));
  }
  return kept;
}

/// A photo from the camera or the gallery onto the cat, as the fan
/// item said. True when one landed.
Future<bool> addPhotoFrom(
    BuildContext context, CatalogStore store, String catId, ImageSource source) async {
  final raw = await pickImageBytes(context, source: source);
  if (raw == null) return false;
  await addCompressedImage(store, catId, raw);
  return true;
}

/// Frames picked from a video onto the cat (#41), each through the
/// crop step, then landing one by one; [onProgress] hears about each.
/// True when any landed.
Future<bool> addPhotosFromVideo(
    BuildContext context, CatalogStore store, String catId,
    {void Function(int done, int total)? onProgress,
    Future<List<Uint8List>?> Function(BuildContext) pickFrames =
        pickVideoFrames,
    CropStep cropStep = cropPage}) async {
  final frames = await pickFrames(context);
  if (frames == null || frames.isEmpty || !context.mounted) return false;
  final kept = await cropFrames(context, frames, cropStep: cropStep);
  return await addFrames(store, catId, kept, onProgress: onProgress) > 0;
}

/// Whether this device has a camera to offer.
bool get hasCamera => Platform.isAndroid || Platform.isIOS;

/// The camera where there is one, the gallery on a desktop: for a
/// button that already says "take a picture".
ImageSource get cameraIfThereIsOne =>
    hasCamera ? ImageSource.camera : ImageSource.gallery;

/// Picks or takes a photo and returns the (optionally cropped) raw
/// bytes, or null if the user canceled. The button that led here said
/// camera or gallery; without a [source] it is the gallery.
Future<Uint8List?> pickImageBytes(BuildContext context,
    {bool allowCrop = true, ImageSource? source}) =>
    runExclusive('imagePicker',
        () => _pickImageBytes(context, allowCrop: allowCrop, source: source),
        context: context);

Future<Uint8List?> _pickImageBytes(BuildContext context,
    {bool allowCrop = true, ImageSource? source}) async {
  final file =
      await ImagePicker().pickImage(source: source ?? ImageSource.gallery);
  if (file == null) return null;
  var raw = await file.readAsBytes();

  if (allowCrop && context.mounted) {
    final edited = await Navigator.of(context).push<Uint8List>(
      MaterialPageRoute(
        builder: (_) => PhotoEditScreen(
            bytes: raw, mode: PhotoEditMode.crop, allowSkip: true),
      ),
    );
    if (edited == null) return null; // canceled the import
    raw = edited;
  }

  return raw;
}
