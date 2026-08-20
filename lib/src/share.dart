import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Shares files anchored to [context]'s widget. iPads present the share
/// sheet as a popover and throw a PlatformException when no non-zero
/// anchor rect is given (#43).
Future<ShareResult> shareFiles(BuildContext context, List<XFile> files) {
  final box = context.findRenderObject() as RenderBox?;
  final origin =
      box == null ? null : box.localToGlobal(Offset.zero) & box.size;
  return Share.shareXFiles(files, sharePositionOrigin: origin);
}
