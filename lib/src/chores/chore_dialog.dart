import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n.dart';
import '../reminders/plan_chooser.dart';

/// Making or editing a chore (1.2.0): a title, whose it is, how often,
/// and at what time of day. Returns the chore as saved, null when
/// dismissed. An existing chore can be paused, resumed or ended here.
Future<Chore?> showChoreDialog(
  BuildContext context,
  CatalogStore store, {
  String? entityId,
  Chore? existing,
}) async {
  var entity = existing?.entity ?? entityId;
  if (entity == null) {
    entity = await pickPlanEntity(context, store);
    if (entity == null || !context.mounted) return null;
  }
  final subject = entity;
  final title = TextEditingController(text: existing?.title ?? '');
  var repeat = existing?.schedule.repeat ?? ChoreRepeat.daily;
  var every = existing?.schedule.every ?? 2;
  if (every < 2) every = 2;
  final weekdays = {...?existing?.schedule.weekdays};
  var time = existing?.time;
  final locale = Localizations.localeOf(context).toString();
  final monday = DateTime(2026, 9, 7);

  final result = await showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) {
        final t = context.t;
        final canSave =
            title.text.trim().isNotEmpty &&
            (repeat != ChoreRepeat.weekdays || weekdays.isNotEmpty);
        return AlertDialog(
          title: Text(existing == null ? t.newChore : t.choreEdit),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  autofocus: existing == null,
                  decoration: InputDecoration(labelText: t.choreTitleLabel),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (_) => setDialogState(() {}),
                ),
                const SizedBox(height: 12),
                SegmentedButton<ChoreRepeat>(
                  segments: [
                    ButtonSegment(
                      value: ChoreRepeat.daily,
                      label: Text(t.choreRepeatDaily),
                    ),
                    ButtonSegment(
                      value: ChoreRepeat.everyDays,
                      label: Text(t.choreRepeatEvery),
                    ),
                    ButtonSegment(
                      value: ChoreRepeat.weekdays,
                      label: Text(t.choreRepeatWeekdays),
                    ),
                  ],
                  selected: {repeat},
                  onSelectionChanged: (s) =>
                      setDialogState(() => repeat = s.first),
                ),
                if (repeat == ChoreRepeat.everyDays)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: every > 2
                              ? () => setDialogState(() => every--)
                              : null,
                        ),
                        Text(t.choreEveryDays(every)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: every < 365
                              ? () => setDialogState(() => every++)
                              : null,
                        ),
                      ],
                    ),
                  ),
                if (repeat == ChoreRepeat.weekdays)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 4,
                      children: [
                        for (var d = DateTime.monday; d <= DateTime.sunday; d++)
                          FilterChip(
                            label: Text(
                              DateFormat.E(locale)
                                  .format(monday.add(Duration(days: d - 1))),
                            ),
                            selected: weekdays.contains(d),
                            visualDensity: VisualDensity.compact,
                            onSelected: (on) => setDialogState(
                              () => on ? weekdays.add(d) : weekdays.remove(d),
                            ),
                          ),
                      ],
                    ),
                  ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.schedule),
                  title: Text(
                    time == null
                        ? t.choreNoTime
                        : MaterialLocalizations.of(context).formatTimeOfDay(
                            TimeOfDay(hour: time!.hour, minute: time!.minute),
                          ),
                  ),
                  trailing: time == null
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setDialogState(() => time = null),
                        ),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: time?.hour ?? 8,
                        minute: time?.minute ?? 0,
                      ),
                    );
                    if (picked != null) {
                      setDialogState(
                        () => time = (hour: picked.hour, minute: picked.minute),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            if (existing != null) ...[
              TextButton(
                onPressed: () => Navigator.of(context).pop('end'),
                child: Text(t.choreEnd),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context)
                        .pop(existing.paused ? 'resume' : 'pause'),
                child: Text(existing.paused ? t.choreResume : t.chorePause),
              ),
            ],
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.cancel),
            ),
            FilledButton(
              onPressed: canSave
                  ? () => Navigator.of(context).pop('save')
                  : null,
              child: Text(t.save),
            ),
          ],
        );
      },
    ),
  );
  if (result == null) return null;
  if (existing != null && result != 'save') {
    final changed = switch (result) {
      'end' => existing.copyWith(ended: true),
      'pause' => existing.copyWith(paused: true),
      _ => existing.copyWith(paused: false),
    };
    store.updateChore(changed);
    return changed;
  }
  final name = title.text.trim();
  if (name.isEmpty) return null;
  final schedule = switch (repeat) {
    ChoreRepeat.daily => const ChoreSchedule.daily(),
    ChoreRepeat.everyDays => ChoreSchedule.everyDays(every),
    ChoreRepeat.weekdays => ChoreSchedule.weekdays(weekdays),
  };
  if (existing != null) {
    final changed = existing.copyWith(
      title: name,
      schedule: schedule,
      time: time,
      clearTime: time == null,
    );
    store.updateChore(changed);
    return changed;
  }
  return store.createChore(
    Chore(
      id: '',
      entity: subject,
      title: name,
      schedule: schedule,
      time: time,
      start: dayOf(DateTime.now()),
    ),
  );
}
