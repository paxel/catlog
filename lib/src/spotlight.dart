import 'dart:async';
import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';

/// Per-screen what's-new spotlights: dim the page, highlight one new
/// element, one short sentence, Next chains, Skip ends the screen's
/// tour. Never traps input behind an unskippable tutorial.
///
/// Seen-tracking is PER ITEM (a CSV of item ids under `spot2:<screen>`),
/// so features added later in the same version still get their tour.
/// The legacy `spot:<screen>` version mark seeds the original items as
/// seen once, then stops mattering.
class SpotlightItem {
  final String id;
  final String Function(AppLocalizations t) text;

  const SpotlightItem(this.id, this.text);
}

/// The items the legacy version-mark implies were already shown.
const _legacyItems = {'home-sync', 'map-search', 'card-chips', 'cat-menu'};

/// Every feature ticket appends its screen's entries here.
final Map<String, List<SpotlightItem>> spotlightManifest = {
  'home': [
    SpotlightItem('home-strays', (t) => t.spotHomeStrays),
    SpotlightItem('home-sync', (t) => t.spotHomeSync),
    SpotlightItem('home-menu', (t) => t.spotHomeMenu),
  ],
  'map': [
    SpotlightItem('map-search', (t) => t.spotMapSearch),
    SpotlightItem('map-layers', (t) => t.spotMapLayers),
  ],
  'card': [
    SpotlightItem('card-chips', (t) => t.spotCardChips),
  ],
  'cat': [
    SpotlightItem('cat-edit', (t) => t.spotCatEdit),
    SpotlightItem('cat-menu', (t) => t.spotCatMenu),
  ],
  'strays': [
    SpotlightItem('strays-flier', (t) => t.spotStraysFlier),
    SpotlightItem('strays-scan', (t) => t.spotStraysScan),
  ],
};

/// Pure due-computation, unit-testable: everything not yet in the
/// seen CSV, in manifest order.
List<SpotlightItem> dueSpotlights(String seenCsv, List<SpotlightItem> items) {
  final seen = seenCsv.split(',').toSet();
  return [
    for (final item in items)
      if (!seen.contains(item.id)) item
  ];
}

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
    store.removeLocalSetting('spot2:$screen');
  }
}

String _seen(CatalogStore store, String screenId) {
  final seen = store.localSetting('spot2:$screenId') ?? '';
  if (seen.isNotEmpty) return seen;
  // Legacy version mark: those tours showed the original items already.
  final legacy = store.localSetting('spot:$screenId') ?? '';
  return legacy.isEmpty ? '' : _legacyItems.join(',');
}

/// Call after the screen's first frame; shows due items sequentially.
Future<void> runSpotlights(
    BuildContext context, CatalogStore store, String screenId) async {
  // Widget tests must never wade through tour overlays.
  if (Platform.environment.containsKey('FLUTTER_TEST')) return;
  final items = spotlightManifest[screenId];
  if (items == null) return;
  final due = [
    for (final item in dueSpotlights(_seen(store, screenId), items))
      if (_anchors.containsKey(item.id)) item
  ];
  if (due.isEmpty) return;

  // Anchors move while the page-transition runs — measuring early put
  // the highlight on the wrong spot. Wait for the route to settle.
  final route = ModalRoute.of(context);
  final animation = route?.animation;
  if (animation != null &&
      animation.status == AnimationStatus.forward) {
    final settled = Completer<void>();
    void listener(AnimationStatus status) {
      if (status == AnimationStatus.completed && !settled.isCompleted) {
        settled.complete();
      }
    }

    animation.addStatusListener(listener);
    await settled.future
        .timeout(const Duration(seconds: 2), onTimeout: () {});
    animation.removeStatusListener(listener);
  }
  await WidgetsBinding.instance.endOfFrame;
  if (!context.mounted) return;

  final shown = <String>{
    ..._seen(store, screenId).split(',').where((s) => s.isNotEmpty)
  };
  for (final item in due) {
    if (!context.mounted) return;
    final key = _anchors[item.id];
    final box = key?.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) continue;
    final rect = box.localToGlobal(Offset.zero) & box.size;
    // Mark before showing: even an aborted tour never nags again.
    shown.add(item.id);
    store.setLocalSetting('spot2:$screenId', shown.join(','));
    final next = await showDialog<bool>(
      context: context,
      barrierColor: Colors.transparent,
      // The overlay paints in GLOBAL coordinates; the default SafeArea
      // wrapper would shift it down by the status-bar inset.
      useSafeArea: false,
      builder: (context) => _SpotlightOverlay(
        target: rect.inflate(6),
        text: item.text(context.t),
        isLast: item == due.last,
      ),
    );
    if (next != true) {
      // Skip ends this screen's tour and marks the rest seen.
      for (final rest in due) {
        shown.add(rest.id);
      }
      store.setLocalSetting('spot2:$screenId', shown.join(','));
      return;
    }
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
