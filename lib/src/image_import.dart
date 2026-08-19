import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'l10n.dart';
import 'screens/photo_edit_screen.dart';
import 'video_frames_io.dart';

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

/// Compresses off the UI thread and stores the photo on the cat.
Future<String> addCompressedImage(
    CatalogStore store, String catId, Uint8List bytes) async {
  final jpeg = await Isolate.run(() => CatalogStore.compressImage(bytes));
  return store.addImage(catId, jpeg);
}

/// Photo-add sheet with the video path (#41): camera, gallery, or
/// frames picked from a video. Returns true when photos landed.
Future<bool> addPhotosViaSheet(
    BuildContext context, CatalogStore store, String catId) async {
  if (!Platform.isAndroid && !Platform.isIOS) {
    // Desktop keeps the plain picker; video frames are mobile-first.
    return await pickAndAddImage(context, store, catId) != null;
  }
  final choice = await showModalBottomSheet<String>(
    context: context,
    builder: (context) => SafeArea(
      child: Wrap(children: [
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: Text(context.t.takePhoto),
          onTap: () => Navigator.of(context).pop('camera'),
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: Text(context.t.chooseFromGallery),
          onTap: () => Navigator.of(context).pop('gallery'),
        ),
        ListTile(
          leading: const Icon(Icons.movie_outlined),
          title: Text(context.t.fromVideo),
          onTap: () => Navigator.of(context).pop('video'),
        ),
      ]),
    ),
  );
  if (choice == null || !context.mounted) return false;
  if (choice == 'video') {
    final frames = await pickVideoFrames(context);
    if (frames == null || frames.isEmpty) return false;
    for (final frame in frames) {
      await addCompressedImage(store, catId, frame);
    }
    return true;
  }
  final raw = await pickImageBytes(context,
      source:
          choice == 'camera' ? ImageSource.camera : ImageSource.gallery);
  if (raw == null) return false;
  await addCompressedImage(store, catId, raw);
  return true;
}

/// Picks or takes a photo and returns the (optionally cropped) raw
/// bytes, or null if the user canceled. A preselected [source] skips
/// the sheet.
Future<Uint8List?> pickImageBytes(BuildContext context,
    {bool allowCrop = true, ImageSource? source}) async {
  final canUseCamera = Platform.isAndroid || Platform.isIOS;
  var pickedSource = source ?? ImageSource.gallery;
  if (source == null && canUseCamera) {
    final picked = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text(context.t.takePhoto),
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(context.t.chooseFromGallery),
            onTap: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
        ]),
      ),
    );
    if (picked == null) return null;
    pickedSource = picked;
  }

  final file = await ImagePicker().pickImage(source: pickedSource);
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
