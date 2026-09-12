import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import 'sync_watch.dart';

/// The line at the top of every page while changes wait in the shared
/// folder: who wrote them, which catalog, tap to sync. Gone once merged.
class SyncWatchLine extends StatelessWidget {
  final SyncWatcher watcher;
  final Widget child;

  const SyncWatchLine({super.key, required this.watcher, required this.child});

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: watcher,
    builder: (context, _) {
      final pending = watcher.pending;
      if (pending == null) return child;
      final t = context.t;
      final scheme = Theme.of(context).colorScheme;
      final authors = pending.authors.isEmpty
          ? t.syncAnotherDevice
          : pending.authors.join(', ');
      final catalog = watcher.store.localSetting(catalogNameKey) ?? t.appTitle;
      return Column(
        children: [
          Material(
            color: scheme.primaryContainer,
            child: InkWell(
              onTap: () => watcher.merge(fromTap: true),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.folder_copy_outlined,
                        color: scheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          t.syncChangesWaiting(authors, catalog),
                          style: TextStyle(color: scheme.onPrimaryContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // The line took the status bar's height; the page below must
          // not pad for it again.
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: child,
            ),
          ),
        ],
      );
    },
  );
}
