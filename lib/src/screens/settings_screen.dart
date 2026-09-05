import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../celebration.dart';
import '../event_toasts.dart';
import '../l10n.dart';
import '../language_dialog.dart';
import '../spotlight.dart';
import '../units.dart';
import '../units_dialog.dart';
import 'intro_screen.dart';

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
      appBar: AppBar(title: Text(t.settings)),
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
