import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n.dart';
import 'widgets/date_entry.dart';

/// The move dialog: a home or "stray" per row, the current one ticked,
/// and the day it happened at the foot. Pops the target and the day.
/// A correction from the history opens it on the move it corrects: its
/// home ticked as [current], its moment as [asOf].
class MoveDialog extends StatefulWidget {
  final List<EntityView> clowders;
  final String? current;
  final DateTime? asOf;
  const MoveDialog(
      {super.key, required this.clowders, required this.current, this.asOf});

  @override
  State<MoveDialog> createState() => _MoveDialogState();
}

class _MoveDialogState extends State<MoveDialog> {
  late DateTime _asOf = widget.asOf ?? DateTime.now();

  Future<void> _pickDay() async {
    final picked = await pickDay(
      context,
      initial: _asOf,
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (!mounted || picked == null) return;
    setState(() => _asOf = picked);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return SimpleDialog(
      title: Text(t.moveTo),
      children: [
        for (final c in widget.clowders)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop((c.id, _asOf)),
            child: Row(
              children: [
                if (c.id == widget.current)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.check, size: 18),
                  ),
                Expanded(child: Text(c.name)),
              ],
            ),
          ),
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop((null, _asOf)),
          child: Row(
            children: [
              const Icon(Icons.explore, size: 18),
              const SizedBox(width: 8),
              Expanded(child: Text(t.noClowderStrayOption)),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.event),
          title: Text(
            sameDay
                ? t.asOfToday
                : t.asOfDate(
                    DateFormat.yMd(
                      Localizations.localeOf(context).toString(),
                    ).format(_asOf),
                  ),
          ),
          trailing: const Icon(Icons.edit_calendar_outlined),
          onTap: _pickDay,
        ),
      ],
    );
  }
}
