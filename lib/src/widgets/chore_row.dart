import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../chores/chore_dialog.dart';
import '../l10n.dart';
import 'cat_ear.dart';

/// One chore on one day: a checkbox, the title and time, whose it is,
/// the streak, and seven dots for the week. The checkbox ticks or
/// unticks the occurrence [due]; a tap opens the cat or home; the
/// long-press (cat ear) opens the editor, where pause and end live.
class ChoreRow extends StatelessWidget {
  final CatalogStore store;
  final Chore chore;

  /// The occurrence this row stands for: today, or an upcoming due day.
  final DateTime due;
  final DateTime today;
  final bool showEntity;
  final VoidCallback onChanged;
  final VoidCallback? onOpen;

  const ChoreRow({
    super.key,
    required this.store,
    required this.chore,
    required this.due,
    required this.today,
    required this.onChanged,
    this.showEntity = true,
    this.onOpen,
  });

  Future<void> _edit(BuildContext context) async {
    final saved = await showChoreDialog(context, store, existing: chore);
    if (saved != null) onChanged();
  }

  void _toggle() {
    final ticks = store.choreTicks(chore);
    if (ticks.containsKey(dayOf(due))) {
      store.untickChore(chore, due);
    } else {
      store.tickChore(chore, due, doneOn: today);
    }
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final ticks = store.choreTicks(chore);
    final done = ticks.containsKey(dayOf(due));
    final later = dayOf(due).isAfter(dayOf(today));
    final run = streak(chore, ticks, today);
    final locale = Localizations.localeOf(context).toString();
    final parts = <String>[
      if (showEntity) store.current(chore.entity, Keys.name) ?? t.unnamed,
      if (later) t.choreDue(DateFormat.MMMEd(locale).format(due)),
      if (run > 0) t.streakDays(run),
      if (chore.paused) t.chorePaused,
    ];
    final time = chore.time;
    final title = time == null
        ? chore.title
        : '${chore.title} · ${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay(hour: time.hour, minute: time.minute))}';
    // A ticked row steps back: struck through and greyed, so the open
    // ones are what the eye lands on. A paused one is greyed too and
    // has no box — nothing to tick — but keeps its tap and long-press,
    // so it can be resumed or ended from wherever it shows.
    final faded = Theme.of(context).disabledColor;
    final paused = chore.paused;
    return WithCatEar(
      child: Card(
      child: ListTile(
        leading: paused
            ? Icon(Icons.pause_circle_outline, color: faded)
            : Checkbox(value: done, onChanged: (_) => _toggle()),
        title: Text(
          title,
          style: done
              ? TextStyle(decoration: TextDecoration.lineThrough, color: faded)
              : paused
                  ? TextStyle(color: faded)
                  : null,
        ),
        subtitle: parts.isEmpty
            ? null
            : Text(parts.join(' · '),
                style: done || paused ? TextStyle(color: faded) : null),
        trailing: _WeekDots(weekDots(chore, ticks, today)),
        onTap: onOpen,
        onLongPress: () => _edit(context),
      ),
      ),
    );
  }
}

/// Seven small circles, oldest left: done, missed, pending, not due.
class _WeekDots extends StatelessWidget {
  final List<ChoreDay> dots;

  const _WeekDots(this.dots);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final d in dots)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.5),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: switch (d) {
                  ChoreDay.done => Colors.green,
                  ChoreDay.missed => scheme.error.withValues(alpha: 0.6),
                  ChoreDay.pending => Colors.transparent,
                  _ => scheme.outlineVariant,
                },
                border: d == ChoreDay.pending
                    ? Border.all(color: scheme.primary, width: 1.5)
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}
