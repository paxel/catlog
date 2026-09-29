import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import 'l10n.dart';
import 'layout.dart';
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
  'history': (t) => t.helpHistory,
  'settings': (t) => t.helpSettings,
  'looks': (t) => t.helpLooks,
  'duplicates': (t) => t.helpDuplicates,
  'matches': (t) => t.helpMatches,
  'flier': (t) => t.helpFlier,
  'archive': (t) => t.helpArchive,
  'catalogs': (t) => t.helpCatalogs,
  'catalogSettings': (t) => t.helpCatalogSettings,
  'agenda': (t) => t.helpAgenda,
  'goBack': (t) => t.helpGoBack,
  'backups': (t) => t.helpBackups,
  'conflicts': (t) => t.helpConflicts,
  'inPerson': (t) => t.helpInPerson,
  'messenger': (t) => t.helpMessenger,
  'moderation': (t) => t.helpModeration,
  'remote': (t) => t.helpRemote,
  'restore': (t) => t.helpRestore,
  'scan': (t) => t.helpScan,
  'vetReport': (t) => t.helpVetReport,
  'poster': (t) => t.helpPoster,
  'achievements': (t) => t.helpAchievements,
};

/// The "?" for an app bar. Shows nothing when the screen has no help
/// text — better absent than empty.
class HelpButton extends StatelessWidget {
  /// Null on pages that stand outside a catalog (restore, scan,
  /// achievements): help shows, the tips button does not.
  final CatalogStore? store;
  final String screenId;

  const HelpButton({super.key, this.store, required this.screenId});

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

/// Opens the help page for a screen.
Future<void> showHelp(
  BuildContext context,
  CatalogStore? store,
  String screenId,
) async {
  if (!helpTexts.containsKey(screenId)) return;
  await Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => HelpScreen(store: store, screenId: screenId),
  ));
}

/// A page, not a sheet: what this screen is for, and the way to see
/// its tips again where it has any.
class HelpScreen extends StatelessWidget {
  final CatalogStore? store;
  final String screenId;

  const HelpScreen({super.key, required this.store, required this.screenId});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final text = helpTexts[screenId]!;
    final hasTips = store != null && spotlightManifest.containsKey(screenId);
    return Scaffold(
      appBar: roomyAppBar(context, title: Text(t.helpTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(text(t)),
          if (hasTips) ...[
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.lightbulb_outline),
              label: Text(t.showTipsAgain),
              onPressed: () {
                // Only this screen's tips come back, not every tour.
                replaySpotlights(store!, screenId);
                Navigator.of(context).pop();
              },
            ),
          ],
        ],
      ),
    );
  }
}
