import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';

/// Moderation (ADR-0006): per-author hard delete behind one plain
/// confirmation, and the local ban list. Everything here acts on THIS device only —
/// bans never propagate; the group coordinates by talking.
class ModerationScreen extends StatefulWidget {
  final CatalogStore store;

  const ModerationScreen({super.key, required this.store});

  @override
  State<ModerationScreen> createState() => _ModerationScreenState();
}

class _ModerationScreenState extends State<ModerationScreen> {
  CatalogStore get store => widget.store;

  Future<void> _hardDelete(
      ({String author, String device, int count}) row) async {
    final t = context.t;
    var alsoBan = true;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(t.hardDeleteAction),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(t.hardDeleteWarning(row.author)),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: alsoBan,
              onChanged: (v) =>
                  setDialogState(() => alsoBan = v ?? true),
              title: Text(t.alsoBan),
              contentPadding: EdgeInsets.zero,
            ),
          ]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.delete),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true || !mounted) return;
    // No moment is recorded here on purpose: a hard delete removes
    // entries instead of adding any (ADR-0006), so there would be
    // nothing above the mark to put back. The ban list is what keeps
    // the material from coming home.
    final removedBlobs = store.hardDeleteAuthor(row.author);
    if (alsoBan) {
      store.ban(author: row.author);
      for (final hash in removedBlobs) {
        store.ban(blobHash: hash);
      }
    }
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.deletedDone)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final rows = store.authorsOverview();
    final bans = store.bans();
    return Scaffold(
      appBar: AppBar(title: Text(t.moderationTitle)),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(t.authorsSection,
              style: Theme.of(context).textTheme.titleMedium),
        ),
        for (final row in rows)
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(row.author),
            subtitle: Text('${row.count} · ${row.device.substring(0, 8)}'),
            trailing: row.author == store.author
                ? null
                : IconButton(
                    icon: const Icon(Icons.delete_forever_outlined),
                    tooltip: t.hardDeleteAction,
                    onPressed: () => _hardDelete(row),
                  ),
          ),
        if (store.localSettingsByPrefix('trust:').isNotEmpty) ...[
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(t.trustedDevicesSection,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          for (final (deviceId, value)
              in store.localSettingsByPrefix('trust:'))
            ListTile(
              leading: Icon(value.startsWith('private')
                  ? Icons.lock_open
                  : Icons.devices_outlined),
              title: Text(value.split('|').length > 2
                  ? '${value.split('|')[1]} · ${value.split('|')[2]}'
                  : deviceId),
              trailing: TextButton(
                onPressed: () {
                  store.removeLocalSetting('trust:$deviceId');
                  setState(() {});
                },
                child: Text(t.removeTrust),
              ),
            ),
        ],
        if (bans.isNotEmpty) ...[
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(t.bansSection,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          for (final (kind, value) in bans)
            ListTile(
              leading: Icon(switch (kind) {
                'author' => Icons.person_off_outlined,
                'device' => Icons.phonelink_erase_outlined,
                _ => Icons.image_not_supported_outlined,
              }),
              title: Text(
                kind == 'blob'
                    ? '${value.substring(0, 12)}…'
                    : value,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: TextButton(
                onPressed: () {
                  store.unban(
                    author: kind == 'author' ? value : null,
                    device: kind == 'device' ? value : null,
                    blobHash: kind == 'blob' ? value : null,
                  );
                  setState(() {});
                },
                child: Text(t.unbanAction),
              ),
            ),
        ],
      ]),
    );
  }
}
