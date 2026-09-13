import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../celebration.dart';
import '../event_toasts.dart';
import '../help.dart';
import '../l10n.dart';
import '../fur_background.dart';
import '../achievements.dart';
import '../language_dialog.dart';
import '../spotlight.dart';
import '../units.dart';
import '../units_dialog.dart';
import 'intro_screen.dart';
import '../move_to_catalog.dart';
import 'achievements_screen.dart';
import 'backups_screen.dart';

/// The settings that belong to the app, not to a catalog: language,
/// units, celebrations, event toasts and the two replays. One flat
/// list, reached from the home menu.
class SettingsScreen extends StatefulWidget {
  final CatalogStore store;

  const SettingsScreen({super.key, required this.store});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => runSpotlights(context, widget.store, 'settings'),
    );
  }

  int get _fullMonths =>
      catalogManager
          ?.achievements()
          .where((a) => a.id == fullMonthId)
          .firstOrNull
          ?.times ??
      0;

  String _coatLabel(AppLocalizations t) {
    final favourite =
        FurPattern.values.asNameMap()[widget.store.localSetting('furFavourite')];
    return favourite == null ? t.coatRandom : coatLabel(t, favourite);
  }

  Future<void> _chooseCoat() async {
    final t = context.t;
    final picked = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(t.coatSetting),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(''),
            child: Text(t.coatRandom),
          ),
          for (final coat in coatsAvailable(_fullMonths))
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(coat.name),
              child: Text(coatLabel(t, coat)),
            ),
        ],
      ),
    );
    if (picked == null || !mounted) return;
    if (picked.isEmpty) {
      widget.store.removeLocalSetting('furFavourite');
    } else {
      widget.store.setLocalSetting('furFavourite', picked);
    }
    pickCoat(favourite: picked.isEmpty ? null : picked, fullMonths: _fullMonths);
    setState(() {});
  }

  Future<void> _pick(
    Future<void> Function(BuildContext, CatalogStore) dialog,
  ) async {
    await dialog(context, widget.store);
    if (mounted) setState(() {});
  }

  String _unitsLabel(AppLocalizations t) =>
      switch (widget.store.localSetting(unitsSettingKey)) {
        'metric' => t.unitsMetric,
        'imperial' => t.unitsImperial,
        _ => t.unitsAuto,
      };

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings),
        actions: [HelpButton(store: widget.store, screenId: 'settings')],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(t.language),
            subtitle: Text(languageLabel(context, widget.store)),
            onTap: () => _pick(showLanguageDialog),
          ),
          ListTile(
            leading: const Icon(Icons.straighten),
            title: Text(t.unitsLabel),
            subtitle: Text(_unitsLabel(t)),
            onTap: () => _pick(showUnitsDialog),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.celebration_outlined),
            title: Text(t.celebrationsToggle),
            subtitle: Text(t.celebrationsSubtitle),
            value: celebrationsEnabled(widget.store),
            onChanged: (v) =>
                setState(() => setCelebrationsEnabled(widget.store, v)),
          ),
          // The cheer on its own switch: confetti for the eyes, silence
          // for the ears, when that is the mood.
          SwitchListTile(
            secondary: const Icon(Icons.volume_up_outlined),
            title: Text(t.cheerToggle),
            subtitle: Text(t.cheerSubtitle),
            value: celebrationsEnabled(widget.store) &&
                cheerEnabled(widget.store),
            onChanged: celebrationsEnabled(widget.store)
                ? (v) => setState(() => setCheerEnabled(widget.store, v))
                : null,
          ),
          // The coat under every page: a different one each start, or
          // a favourite among the ones earned.
          ListTile(
            leading: const Icon(Icons.texture),
            title: Text(t.coatSetting),
            subtitle: Text(_coatLabel(t)),
            onTap: _chooseCoat,
          ),
          if (catalogManager != null)
            ListTile(
              leading: const Icon(Icons.emoji_events_outlined),
              title: Text(t.achievementsTitle),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AchievementsScreen(
                    manager: catalogManager!, stores: [widget.store]),
              )),
            ),
          Spotlight(
            id: 'settings-backups',
            child: ListTile(
              leading: const Icon(Icons.backup_outlined),
              title: Text(t.backupsTitle),
              subtitle: Text(t.backupsSubtitle),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BackupsScreen(store: widget.store),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: Text(t.toastSettingsTitle),
            subtitle: Text(t.toastSettingsSubtitle),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ToastSettingsScreen(store: widget.store),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.new_releases_outlined),
            title: Text(t.spotReplayTitle),
            subtitle: Text(t.spotReplaySubtitle),
            onTap: () {
              resetSpotlights(widget.store);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(t.spotReplayDone)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.slideshow_outlined),
            title: Text(t.introReplayTitle),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => IntroScreen(
                  store: widget.store,
                  onDone: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
