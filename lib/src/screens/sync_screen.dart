import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../help.dart';
import '../auto_backup.dart';
import '../l10n.dart';
import 'in_person_screen.dart';
import 'messenger_screen.dart';
import 'remote_screen.dart';

/// The sync chooser: three self-explaining cards instead of one packed
/// page (ADR-0002 transports; forgiving-UX rule 8 — uncluttered pages).
class SyncScreen extends StatelessWidget {
  final CatalogStore store;

  const SyncScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final backupError = store.localSetting(backupErrorKey);
    return Scaffold(
      appBar: AppBar(title: Text(t.sync), actions: [
        HelpButton(store: store, screenId: 'sync'),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // A silently failing auto-backup must be discoverable somewhere.
          if (backupError != null && backupError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(t.lastBackupFailed(backupError),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          _ChooserCard(
            icon: Icons.qr_code,
            title: t.syncChooserInPerson,
            subtitle: t.syncChooserInPersonSub,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => InPersonScreen(store: store),
            )),
          ),
          _ChooserCard(
            icon: Icons.folder_shared_outlined,
            title: t.syncChooserRemote,
            subtitle: t.syncChooserRemoteSub,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => RemoteScreen(store: store),
            )),
          ),
          _ChooserCard(
            icon: Icons.send_outlined,
            title: t.syncChooserMessenger,
            subtitle: t.syncChooserMessengerSub,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MessengerScreen(store: store),
            )),
          ),
        ],
      ),
    );
  }
}

class _ChooserCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ChooserCard(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            Icon(icon, size: 40,
                color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ]),
        ),
      ),
    );
  }
}
