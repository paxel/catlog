import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';
import 'spotlight.dart';

/// Per-screen help: what this page is for and what you can do here.
/// Nobody reads a manual, so the manual comes to the page — one "?" in
/// the app bar, the same place everywhere.
typedef HelpText = String Function(AppLocalizations t);

/// Screen id → help text. Ids match [spotlightManifest] where a screen
/// has tips, so the sheet can offer to show them again.
final Map<String, HelpText> helpTexts = {
  'home': (t) => t.helpHome,
  'clowder': (t) => t.helpClowder,
  'cat': (t) => t.helpCat,
  'strays': (t) => t.helpStrays,
  'map': (t) => t.helpMap,
  'card': (t) => t.helpCard,
  'sync': (t) => t.helpSync,
  'fields': (t) => t.helpFields,
  'timeline': (t) => t.helpTimeline,
  'duplicates': (t) => t.helpDuplicates,
  'matches': (t) => t.helpMatches,
  'flier': (t) => t.helpFlier,
  'archive': (t) => t.helpArchive,
  'catalogs': (t) => t.helpCatalogs,
  'agenda': (t) => t.helpAgenda,
  'goBack': (t) => t.helpGoBack,
};

/// The "?" for an app bar. Shows nothing when the screen has no help
/// text — better absent than empty.
class HelpButton extends StatelessWidget {
  final CatalogStore store;
  final String screenId;

  const HelpButton({super.key, required this.store, required this.screenId});

  @override
  Widget build(BuildContext context) {
    if (!helpTexts.containsKey(screenId)) return const SizedBox.shrink();
    return IconButton(
      icon: const Icon(Icons.help_outline),
      tooltip: context.t.helpTitle,
      onPressed: () => showHelp(context, store, screenId),
    );
  }
}

/// Opens the help sheet for a screen.
Future<void> showHelp(
    BuildContext context, CatalogStore store, String screenId) async {
  final text = helpTexts[screenId];
  if (text == null) return;
  final hasTips = spotlightManifest.containsKey(screenId);
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      final t = context.t;
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            children: [
              Text(t.helpTitle,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(text(t)),
              if (hasTips) ...[
                const SizedBox(height: 20),
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.lightbulb_outline),
                  label: Text(t.showTipsAgain),
                  onPressed: () {
                    // Only this screen's tips come back, not every tour.
                    replaySpotlights(store, screenId);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}
