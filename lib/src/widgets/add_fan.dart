import 'package:flutter/material.dart';

/// One way to add something: its icon, its words, what it does.
class FanItem {
  final IconData icon;
  final String label;
  final Future<void> Function() onTap;

  const FanItem({required this.icon, required this.label, required this.onTap});
}

/// The plus of a page that adds in more than one way. A tap fans the
/// ways out above it, icon and words each, over a light veil; the plus
/// becomes a minus. Minus, the veil or a pick folds it back. The items
/// appear one after another, unless the system asks for no motion.
class AddFan extends StatefulWidget {
  final List<FanItem> items;
  final String tooltip;

  /// Fanned out as the page appears: a fresh record asking for its
  /// first photo.
  final bool openAtStart;

  const AddFan({
    super.key,
    required this.items,
    required this.tooltip,
    this.openAtStart = false,
  });

  @override
  State<AddFan> createState() => _AddFanState();
}

class _AddFanState extends State<AddFan> with SingleTickerProviderStateMixin {
  late final AnimationController _motion = AnimationController(vsync: this);
  final _button = GlobalKey();
  OverlayEntry? _entry;

  bool get _open => _entry != null;

  @override
  void initState() {
    super.initState();
    if (widget.openAtStart) {
      // After the first frame, when the button has a place to fan from;
      // a page already left must not open one.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_open) _openFan();
      });
    }
  }

  @override
  void dispose() {
    _entry?.remove();
    _motion.dispose();
    super.dispose();
  }

  Duration get _duration => MediaQuery.disableAnimationsOf(context)
      ? Duration.zero
      : const Duration(milliseconds: 240);

  void _toggle() {
    if (_open) {
      _close();
    } else {
      _openFan();
    }
  }

  void _openFan() {
    final overlay = Overlay.of(context);
    final box = _button.currentContext!.findRenderObject() as RenderBox;
    final overlayBox = overlay.context.findRenderObject() as RenderBox;
    final rect = box.localToGlobal(Offset.zero, ancestor: overlayBox) & box.size;
    _motion.duration = _duration;
    _entry = OverlayEntry(
      builder: (_) => _Fan(
        anchor: rect,
        items: widget.items,
        motion: _motion,
        onClose: _close,
        onPick: _pick,
      ),
    );
    overlay.insert(_entry!);
    _motion.forward(from: 0);
    setState(() {});
  }

  Future<void> _close() async {
    if (!_open) return;
    await _motion.reverse();
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() {});
  }

  Future<void> _pick(FanItem item) async {
    await _close();
    await item.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: _button,
      onPressed: _toggle,
      tooltip: widget.tooltip,
      child: AnimatedSwitcher(
        duration: _duration,
        child: Icon(
          _open ? Icons.remove : Icons.add,
          key: ValueKey(_open),
        ),
      ),
    );
  }
}

/// The veil and the column of ways, above the button.
class _Fan extends StatelessWidget {
  final Rect anchor;
  final List<FanItem> items;
  final Animation<double> motion;
  final VoidCallback onClose;
  final Future<void> Function(FanItem) onPick;

  const _Fan({
    required this.anchor,
    required this.items,
    required this.motion,
    required this.onClose,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onClose,
            child: FadeTransition(
              opacity: motion,
              child: const ColoredBox(color: Color(0x66000000)),
            ),
          ),
        ),
        Positioned(
          right: size.width - anchor.right,
          bottom: size.height - anchor.top + 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // The nearest item first out of the button: the last in
              // the column leads the stagger.
              for (final (i, item) in items.indexed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _FanRow(
                    item: item,
                    motion: CurvedAnimation(
                      parent: motion,
                      curve: Interval(
                        (items.length - 1 - i) * 0.12,
                        1,
                        curve: Curves.easeOut,
                      ),
                    ),
                    onTap: () => onPick(item),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FanRow extends StatelessWidget {
  final FanItem item;
  final Animation<double> motion;
  final VoidCallback onTap;

  const _FanRow({required this.item, required this.motion, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FadeTransition(
      opacity: motion,
      child: ScaleTransition(
        scale: motion,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: scheme.surface,
              elevation: 2,
              shape: const StadiumBorder(),
              child: InkWell(
                customBorder: const StadiumBorder(),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(item.label),
                ),
              ),
            ),
            const SizedBox(width: 12),
            FloatingActionButton.small(
              heroTag: null,
              onPressed: onTap,
              tooltip: item.label,
              child: Icon(item.icon),
            ),
          ],
        ),
      ),
    );
  }
}
