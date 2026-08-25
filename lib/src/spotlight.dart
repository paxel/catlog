import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

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
    SpotlightItem('home-catalog', (t) => t.spotHomeCatalog),
    SpotlightItem('home-strays', (t) => t.spotHomeStrays),
    SpotlightItem('home-sync', (t) => t.spotHomeSync),
    SpotlightItem('home-menu', (t) => t.spotHomeMenu),
    SpotlightItem('home-ear', (t) => t.spotEar),
    SpotlightItem('home-agenda', (t) => t.spotHomeAgenda),
  ],
  'agenda': [
    SpotlightItem('agenda-add', (t) => t.spotAgendaAdd),
    SpotlightItem('agenda-calendar', (t) => t.spotAgendaCalendar),
  ],
  'clowder': [
    SpotlightItem('clowder-reminder', (t) => t.spotAddReminder),
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
    SpotlightItem('cat-reminder', (t) => t.spotAddReminder),
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

/// Forgets one screen's tips so they run again on the next visit —
/// the per-screen version of [resetSpotlights].
void replaySpotlights(CatalogStore store, String screenId) {
  store.removeLocalSetting('spot:$screenId');
  store.removeLocalSetting('spot2:$screenId');
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
      builder: (context) => SpotlightTip(
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

/// Widest a tip card gets. A single sentence stretched across a tablet
/// is the wrong shape, and a card beside the highlight says what an
/// arrow used to say badly.
const tipMaxWidth = 400.0;

/// Smallest gap between the card and the edge of the screen.
const tipMargin = 24.0;

/// Gap between the card and the element it explains.
const tipGap = 16.0;

/// Where a tip sits for a highlighted [target] on a [screen]: centred on
/// the target, capped in width, kept inside the screen, and above or
/// below the target so it never covers it.
({double left, double width, double? top, double? bottom}) tipPlacement(
    Rect target, Size screen) {
  final width = math.min(tipMaxWidth, screen.width - 2 * tipMargin);
  final rightmost = math.max(tipMargin, screen.width - tipMargin - width);
  final left =
      (target.center.dx - width / 2).clamp(tipMargin, rightmost).toDouble();
  final below = target.bottom < screen.height / 2;
  return (
    left: left,
    width: width,
    top: below ? target.bottom + tipGap : null,
    bottom: below ? null : screen.height - target.top + tipGap,
  );
}

/// One tip: the page dimmed with [target] cut out of it, and a card
/// beside it. Public so a test can place it without running a tour.
class SpotlightTip extends StatelessWidget {
  final Rect target;
  final String text;
  final bool isLast;

  const SpotlightTip(
      {super.key,
      required this.target,
      required this.text,
      required this.isLast});

  @override
  Widget build(BuildContext context) {
    final place = tipPlacement(target, MediaQuery.sizeOf(context));
    return Stack(children: [
      Positioned.fill(
        child: CustomPaint(
            painter: _DimPainter(target)),
      ),
      Positioned(
        left: place.left,
        width: place.width,
        top: place.top,
        bottom: place.bottom,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
