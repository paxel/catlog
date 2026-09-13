import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../missing_poster.dart';

/// A frame the keeper drags and pinches a picture in. The picture fills
/// the frame from the start (nothing squeezed, the long side cut); every
/// move reports which part of the picture shows, in fractions, so the
/// poster prints exactly the framed part.
class PosterFrame extends StatefulWidget {
  final Uint8List bytes;

  /// Width by height, the same ratio the poster's frame has.
  final double aspect;
  final ValueChanged<PosterPhoto> onChanged;

  const PosterFrame({
    super.key,
    required this.bytes,
    required this.aspect,
    required this.onChanged,
  });

  @override
  State<PosterFrame> createState() => _PosterFrameState();
}

class _PosterFrameState extends State<PosterFrame> {
  final _controller = TransformationController();
  Size? _image;
  Size? _frame;

  @override
  void initState() {
    super.initState();
    _decode();
  }

  @override
  void didUpdateWidget(PosterFrame old) {
    super.didUpdateWidget(old);
    if (!identical(old.bytes, widget.bytes)) {
      _controller.value = Matrix4.identity();
      _image = null;
      _decode();
    }
  }

  Future<void> _decode() async {
    final bytes = widget.bytes;
    final image = await decodeImageFromList(bytes);
    if (!mounted || !identical(bytes, widget.bytes)) return;
    setState(() {
      _image = Size(image.width.toDouble(), image.height.toDouble());
    });
    image.dispose();
    _report();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// The visible part of the picture: the frame's rectangle pulled back
  /// through the pan and zoom, then measured against the picture as it
  /// was drawn to cover the frame.
  void _report() {
    final image = _image;
    final frame = _frame;
    if (image == null || frame == null) return;
    final seen = MatrixUtils.inverseTransformRect(
      _controller.value,
      Offset.zero & frame,
    );
    final scale = _coverScale(frame, image);
    final drawn = Size(image.width * scale, image.height * scale);
    final ox = (frame.width - drawn.width) / 2;
    final oy = (frame.height - drawn.height) / 2;
    double clamp(double v) => v.clamp(0.0, 1.0);
    final x = clamp((seen.left - ox) / drawn.width);
    final y = clamp((seen.top - oy) / drawn.height);
    final w = clamp((seen.right - ox) / drawn.width) - x;
    final h = clamp((seen.bottom - oy) / drawn.height) - y;
    widget.onChanged(PosterPhoto(widget.bytes, x: x, y: y, w: w, h: h));
  }

  static double _coverScale(Size frame, Size image) {
    final sx = frame.width / image.width;
    final sy = frame.height / image.height;
    return sx > sy ? sx : sy;
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final frame = Size(width, width / widget.aspect);
      if (_frame != frame) {
        _frame = frame;
        WidgetsBinding.instance.addPostFrameCallback((_) => _report());
      }
      return ClipRect(
        child: SizedBox(
          width: frame.width,
          height: frame.height,
          child: InteractiveViewer(
            transformationController: _controller,
            minScale: 1,
            maxScale: 6,
            boundaryMargin: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            onInteractionEnd: (_) => _report(),
            child: Image.memory(
              widget.bytes,
              width: frame.width,
              height: frame.height,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
        ),
      );
    },
  );
}
