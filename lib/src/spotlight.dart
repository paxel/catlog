import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';

/// Per-screen what's-new spotlights: dim the page, highlight one new
/// element, one short sentence, Next chains, Skip ends the screen's
/// tour. Never traps input behind an unskippable tutorial.
///
/// Fresh installs see every item of a screen on first visit; upgraders
/// only items newer than the screen's seen version. Items carry a
/// `since` version; the comparison is lexicographic, which holds for
/// our single-digit versions.
const _currentVersion = '0.2.0';

class SpotlightItem {
  final String id;
  final String since;
  final String Function(AppLocalizations t) text;

  const SpotlightItem(this.id, this.since, this.text);
}

/// Every feature ticket appends its screen's entries here.
final Map<String, List<SpotlightItem>> spotlightManifest = {
  'home': [
    SpotlightItem('home-sync', '0.2.0', (t) => t.spotHomeSync),
  ],
  'map': [
    SpotlightItem('map-search', '0.2.0', (t) => t.spotMapSearch),
  ],
  'card': [
    SpotlightItem('card-chips', '0.2.0', (t) => t.spotCardChips),
  ],
  'cat': [
    SpotlightItem('cat-menu', '0.2.0', (t) => t.spotCatMenu),
  ],
};

/// Live anchors: Spotlight widgets register their keys here.
final Map<String, GlobalKey> _anchors = {};

/// Wrap the element a spotlight points at.
class Spotlight extends StatefulWidget {
  final String id;
  final Widget child;

  const Spotlight({super.key, required this.id, required this.child});

  @override
  State<Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _anchors[widget.id] = _key;
  }

  @override
  void dispose() {
    if (_anchors[widget.id] == _key) _anchors.remove(widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: _key, child: widget.child);
}

/// Clears all seen-marks so every tour runs again (About → What's new).
void resetSpotlights(CatalogStore store) {
  for (final screen in spotlightManifest.keys) {
    store.removeLocalSetting('spot:$screen');
  }
}

/// Call after the screen's first frame; shows due items sequentially.
Future<void> runSpotlights(
    BuildContext context, CatalogStore store, String screenId) async {
  // Widget tests must never wade through tour overlays.
  if (Platform.environment.containsKey('FLUTTER_TEST')) return;
  final items = spotlightManifest[screenId];
  if (items == null) return;
  final seen = store.localSetting('spot:$screenId') ?? '';
  final due = [
    for (final item in items)
      if (item.since.compareTo(seen) > 0 && _anchors.containsKey(item.id))
        item
  ];
  if (due.isEmpty) return;
  // Mark first: even an aborted tour never nags again.
  store.setLocalSetting('spot:$screenId', _currentVersion);
  for (final item in due) {
    if (!context.mounted) return;
    final key = _anchors[item.id];
    final box = key?.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) continue;
    final rect = box.localToGlobal(Offset.zero) & box.size;
    final next = await showDialog<bool>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => _SpotlightOverlay(
        target: rect.inflate(6),
        text: item.text(context.t),
        isLast: item == due.last,
      ),
    );
    if (next != true) return; // Skip ends this screen's tour.
  }
}

class _SpotlightOverlay extends StatelessWidget {
  final Rect target;
  final String text;
  final bool isLast;

  const _SpotlightOverlay(
      {required this.target, required this.text, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final below = target.bottom < size.height / 2;
    return Stack(children: [
      Positioned.fill(
        child: CustomPaint(
            painter: _DimPainter(target)),
      ),
      Positioned(
        left: 24,
        right: 24,
        top: below ? target.bottom + 16 : null,
        bottom: below ? null : size.height - target.top + 16,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(below ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Colors.white),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text),
                      const SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                              child: Text(context.t.introSkip),
                            ),
                            FilledButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(true),
                              child: Text(isLast
                                  ? context.t.spotDone
                                  : context.t.introNext),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

class _DimPainter extends CustomPainter {
  final Rect target;

  const _DimPainter(this.target);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRect(Offset.zero & size)
      ..addRRect(
          RRect.fromRectAndRadius(target, const Radius.circular(12)))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(
        path, Paint()..color = Colors.black.withValues(alpha: 0.6));
  }

  @override
  bool shouldRepaint(_DimPainter old) => old.target != target;
}
