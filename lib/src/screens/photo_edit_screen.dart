import 'dart:isolate';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';

enum PhotoEditMode { crop, mark }

/// Drag-to-select photo editing: a rectangle to Crop one cat out, or an
/// ellipse to Mark it (CONTEXT.md: Crop, Mark). Pops the edited JPEG
/// bytes; [allowSkip] (import flow) offers "use full photo", which pops
/// the original bytes unchanged.
class PhotoEditScreen extends StatefulWidget {
  final Uint8List bytes;
  final PhotoEditMode mode;
  final bool allowSkip;

  const PhotoEditScreen(
      {super.key,
      required this.bytes,
      required this.mode,
      this.allowSkip = false});

  @override
  State<PhotoEditScreen> createState() => _PhotoEditScreenState();
}

class _PhotoEditScreenState extends State<PhotoEditScreen> {
  Offset? _start;
  Offset? _end;
  Size? _imageSize;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    decodeImageFromList(widget.bytes).then((image) {
      if (mounted) {
        setState(() =>
            _imageSize = Size(image.width.toDouble(), image.height.toDouble()));
      }
    });
  }

  /// Where the image actually renders inside [box] with BoxFit.contain.
  Rect _renderedRect(Size box) {
    final image = _imageSize!;
    final scale = (box.width / image.width) < (box.height / image.height)
        ? box.width / image.width
        : box.height / image.height;
    final w = image.width * scale;
    final h = image.height * scale;
    return Rect.fromLTWH((box.width - w) / 2, (box.height - h) / 2, w, h);
  }

  Rect? get _selection {
    if (_start == null || _end == null) return null;
    return Rect.fromPoints(_start!, _end!);
  }

  Size _boxSize = Size.zero;

  Future<void> _apply() async {
    final selection = _selection;
    if (selection == null || _imageSize == null || _boxSize == Size.zero) {
      return;
    }
    final rendered = _renderedRect(_boxSize);
    final sel = selection.intersect(rendered);
    if (sel.width < 8 || sel.height < 8) return;
    // Normalize to 0..1 image fractions.
    final x = (sel.left - rendered.left) / rendered.width;
    final y = (sel.top - rendered.top) / rendered.height;
    final w = sel.width / rendered.width;
    final h = sel.height / rendered.height;

    setState(() => _busy = true);
    final result = await Isolate.run(
        _editTask(widget.bytes, widget.mode, x, y, w, h));
    if (mounted) Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.mode == PhotoEditMode.crop ? t.cropTitle : t.markTitle),
        actions: [
          if (widget.allowSkip)
            TextButton(
              onPressed: () => Navigator.of(context).pop(widget.bytes),
              child: Text(t.useFullPhoto),
            ),
          // A labeled button, not a bare checkmark: next to "Use full
          // photo" an icon didn't tell testers it applies the rectangle.
          TextButton(
            onPressed: _busy || _selection == null ? null : _apply,
            child: _busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : Text(widget.mode == PhotoEditMode.crop
                    ? t.applyCrop
                    : t.save),
          ),
        ],
      ),
      body: _imageSize == null
          ? const Center(child: CircularProgressIndicator())
          : Column(children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(widget.mode == PhotoEditMode.crop
                    ? t.dragToSelect
                    : t.dragOverTheCat),
              ),
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  _boxSize = constraints.biggest;
                  return GestureDetector(
                    key: const Key('photoEditArea'),
                    behavior: HitTestBehavior.opaque,
                    onPanStart: (d) => setState(() {
                      _start = d.localPosition;
                      _end = d.localPosition;
                    }),
                    onPanUpdate: (d) =>
                        setState(() => _end = d.localPosition),
                    child: CustomPaint(
                      foregroundPainter: _SelectionPainter(
                          _selection, widget.mode == PhotoEditMode.mark),
                      child: SizedBox.expand(
                        child: Image.memory(widget.bytes,
                            fit: BoxFit.contain),
                      ),
                    ),
                  );
                }),
              ),
            ]),
    );
  }
}

/// Built outside the State so the isolate closure captures ONLY these
/// sendable values — a closure created inside a State method can share
/// its context with setState closures and drag the whole widget tree
/// into the isolate message.
Uint8List Function() _editTask(Uint8List bytes, PhotoEditMode mode,
    double x, double y, double w, double h) {
  if (mode == PhotoEditMode.crop) {
    return () => CatalogStore.cropImage(bytes, x, y, w, h);
  }
  return () =>
      CatalogStore.markImage(bytes, x + w / 2, y + h / 2, w / 2, h / 2);
}

class _SelectionPainter extends CustomPainter {
  final Rect? selection;
  final bool ellipse;

  _SelectionPainter(this.selection, this.ellipse);

  @override
  void paint(Canvas canvas, Size size) {
    if (selection == null) return;
    final casing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = Colors.white;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.deepOrange;
    if (ellipse) {
      canvas.drawOval(selection!, casing);
      canvas.drawOval(selection!, stroke);
    } else {
      canvas.drawRect(selection!, casing);
      canvas.drawRect(selection!, stroke);
    }
  }

  @override
  bool shouldRepaint(_SelectionPainter old) =>
      old.selection != selection || old.ellipse != ellipse;
}
