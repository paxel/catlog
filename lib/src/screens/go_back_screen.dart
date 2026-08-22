import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../help.dart';
import '../l10n.dart';
import '../layout.dart';
import '../undo_import.dart';

/// The moments this catalog changed shape, as sentences — no term to
/// learn, just "Before importing · 14 March" and a way back.
class GoBackScreen extends StatefulWidget {
  final CatalogStore store;

  /// Where the file written before going back is put. Injectable so a
  /// test can see it without a platform channel.
  final SaveFile? saveTo;

  const GoBackScreen({super.key, required this.store, this.saveTo});

  @override
  State<GoBackScreen> createState() => _GoBackScreenState();
}

/// How many moments are shown before "show older" is needed.
const recentMoments = 12;

class _GoBackScreenState extends State<GoBackScreen> {
  bool _showAll = false;

  Future<void> _mark() async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text(context.t.nameThisMoment),
          content: TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.t.cancel)),
            FilledButton(
                onPressed: () =>
                    Navigator.of(context).pop(controller.text.trim()),
                child: Text(context.t.save)),
          ],
        );
      },
    );
    if (name == null || name.isEmpty) return;
    widget.store.addMoment(cause: MomentCause.manual, label: name);
    setState(() {});
  }

  Future<void> _goBack(Moment point) async {
    final done = await confirmGoBack(context, widget.store, point,
        saveTo: widget.saveTo);
    if (done && mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final all = momentsOf(widget.store);
    final shown = _showAll ? all : all.take(recentMoments).toList();
    return Scaffold(
      appBar: roomyAppBar(context, title: Text(t.goBackTitle), actions: [
        HelpButton(store: widget.store, screenId: 'goBack'),
      ]),
      body: ListView(children: [
        for (final (index, point) in shown.indexed) ...[
          // A month header where the month changes: a long history has
          // to stay readable without hunting through dates.
          if (index == 0 ||
              !_sameMonth(shown[index - 1].at, point.at))
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(_month(context, point.at),
                  style: Theme.of(context).textTheme.titleSmall),
            ),
          ListTile(
            leading: Icon(_icon(point.cause)),
            title: Text(momentTitle(t, point)),
            subtitle: Text(momentDetail(context, point)),
            trailing: TextButton(
              onPressed: () => _goBack(point),
              child: Text(t.goBackToHere),
            ),
          ),
        ],
        if (!_showAll && all.length > shown.length)
          Center(
            child: TextButton(
              onPressed: () => setState(() => _showAll = true),
              child: Text(t.showOlderMoments),
            ),
          ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _mark,
        tooltip: t.nameThisMoment,
        child: const Icon(Icons.bookmark_add_outlined),
      ),
    );
  }
}

bool _sameMonth(DateTime a, DateTime b) =>
    a.toLocal().year == b.toLocal().year &&
    a.toLocal().month == b.toLocal().month;

String _month(BuildContext context, DateTime at) =>
    DateFormat.yMMMM(Localizations.localeOf(context).toString())
        .format(at.toLocal());

IconData _icon(String cause) => switch (cause) {
      MomentCause.import => Icons.download,
      MomentCause.sync => Icons.sync,
      MomentCause.merge => Icons.merge,
      MomentCause.hardDelete => Icons.delete_forever_outlined,
      MomentCause.archive => Icons.inventory_2_outlined,
      _ => Icons.bookmark_outline,
    };

/// A moment as a sentence: what was about to happen.
String momentTitle(AppLocalizations t, Moment point) =>
    switch (point.cause) {
      MomentCause.import => t.momentImport,
      MomentCause.sync => t.momentSync,
      MomentCause.merge => t.momentMerge,
      MomentCause.hardDelete => t.momentHardDelete,
      MomentCause.archive => t.momentArchive,
      _ => point.label ?? t.momentManual,
    };

/// What it was about, and when — the label unless it is already the
/// title, then just the date.
String momentDetail(BuildContext context, Moment point) {
  final when = DateFormat.yMd(Localizations.localeOf(context).toString())
      .add_Hm()
      .format(point.at.toLocal());
  final label = point.cause == MomentCause.manual ? null : point.label;
  return label == null || label.isEmpty ? when : '$label · $when';
}
