import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n.dart';
import '../sounds.dart';
import '../notes.dart';
import '../reminders/plan_entity.dart';
import 'chore_history_screen.dart';
import 'chore_reminders.dart';

/// Making or editing a chore (1.2.0): a title, whose it is, how often,
/// at what time of day, and whether the phone should remind. A full
/// page that scrolls, Save in the top bar; an existing chore has
/// Duplicate, Pause and End as rows at the bottom. Duplicate asks whose
/// the copy is and opens a fresh editor preset from this one, over it,
/// so three kittens get their feeding with pick, Save, pick, Save.
/// Returns the chore as saved, null when dismissed.
Future<Chore?> showChoreDialog(
  BuildContext context,
  CatalogStore store, {
  String? entityId,
  Chore? existing,
  ReminderPort? reminders,
}) async {
  return Navigator.of(context).push<Chore>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => ChoreEditorScreen(
        store: store,
        entityId: existing?.entity ?? entityId,
        existing: existing,
        reminders: reminders,
      ),
    ),
  );
}

class ChoreEditorScreen extends StatefulWidget {
  final CatalogStore store;

  /// Whose it is, from the page; null from the agenda or a copy, where
  /// the For field starts with the entity looked at last.
  final String? entityId;
  final Chore? existing;

  /// A chore to copy the values from, for a new one: title, schedule,
  /// time and reminder. Its start, pause, end and unknown keys stay
  /// behind.
  final Chore? template;
  final ReminderPort? reminders;

  const ChoreEditorScreen({
    super.key,
    required this.store,
    this.entityId,
    this.existing,
    this.template,
    this.reminders,
  });

  @override
  State<ChoreEditorScreen> createState() => _ChoreEditorScreenState();
}

class _ChoreEditorScreenState extends State<ChoreEditorScreen> {
  CatalogStore get store => widget.store;
  Chore? get existing => widget.existing;

  /// Where the page's values come from: the chore edited, or the one
  /// copied.
  Chore? get _source => widget.existing ?? widget.template;
  ReminderPort get port => widget.reminders ?? LocalNotificationPort.instance;

  /// Whose the chore is: the For field, preset from the page or the
  /// chore edited, else the entity looked at last.
  late String _entity = widget.entityId ?? existing?.entity ?? defaultPlanEntity(store) ?? '';

  late final TextEditingController _title = TextEditingController(
    text: _source?.title ?? '',
  );
  late ChoreRepeat _repeat = _source?.schedule.repeat ?? ChoreRepeat.daily;
  // Two at least; a new chore has no existing schedule to read.
  late int _every = _source == null || _source!.schedule.every < 2
      ? 2
      : _source!.schedule.every;
  late ChoreUnit _unit = _source?.schedule.unit ?? ChoreUnit.days;

  /// The longest gap that still means something per unit.
  int get _maxEvery => switch (_unit) {
    ChoreUnit.days => 365,
    ChoreUnit.weeks => 52,
    ChoreUnit.months => 24,
    ChoreUnit.years => 10,
  };

  /// "every 2 weeks": the sentence for [n] in [unit].
  String _everyText(int n, ChoreUnit unit) {
    final t = context.t;
    return switch (unit) {
      ChoreUnit.days => t.choreEveryDays(n),
      ChoreUnit.weeks => t.choreEveryWeeks(n),
      ChoreUnit.months => t.choreEveryMonths(n),
      ChoreUnit.years => t.choreEveryYears(n),
    };
  }

  late final Set<int> _weekdays = {...?_source?.schedule.weekdays};
  late ({int hour, int minute})? _time = _source?.time;
  late bool _remind = _source?.remind ?? false;
  late ({int hour, int minute})? _remindAt =
      _source?.remindAt ?? _source?.time;

  static final _monday = DateTime(2026, 9, 7);

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _entity.isNotEmpty &&
      _title.text.trim().isNotEmpty &&
      (_repeat != ChoreRepeat.weekdays || _weekdays.isNotEmpty);

  String _clock(({int hour, int minute}) at) =>
      MaterialLocalizations.of(context)
          .formatTimeOfDay(TimeOfDay(hour: at.hour, minute: at.minute));

  ChoreSchedule get _schedule => switch (_repeat) {
    ChoreRepeat.daily => const ChoreSchedule.daily(),
    ChoreRepeat.everyDays => ChoreSchedule.every(_every, _unit),
    ChoreRepeat.weekdays => ChoreSchedule.weekdays(_weekdays),
  };

  void _save() {
    final name = _title.text.trim();
    if (name.isEmpty) return;
    final Chore saved;
    if (existing != null) {
      saved = existing!.copyWith(
        title: name,
        schedule: _schedule,
        time: _time,
        clearTime: _time == null,
        remind: _remind,
        remindAt: _remindAt,
      );
      store.updateChore(saved);
    } else {
      saved = store.createChore(
        Chore(
          id: '',
          entity: _entity,
          title: name,
          schedule: _schedule,
          time: _time,
          start: dayOf(DateTime.now()),
          remind: _remind,
          remindAt: _remindAt,
        ),
      );
    }
    Navigator.of(context).pop(saved);
  }

  /// One more like this one, for another cat or home: the preset
  /// editor over this page, its For field the place to say whose.
  /// Saved or not, this page stays where it was.
  Future<void> _duplicate() async {
    await Navigator.of(context).push<Chore>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ChoreEditorScreen(
          store: store,
          template: existing,
          reminders: widget.reminders,
        ),
      ),
    );
  }

  void _pauseOrResume() {
    final changed = existing!.copyWith(paused: !existing!.paused);
    store.updateChore(changed);
    Navigator.of(context).pop(changed);
  }

  Future<void> _end() async {
    final t = context.t;
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.choreEnd),
        content: Text(t.choreEndConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.choreEnd),
          ),
        ],
      ),
    );
    if (sure != true || !mounted) return;
    final changed = existing!.copyWith(ended: true);
    store.updateChore(changed);
    Navigator.of(context).pop(changed);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _time?.hour ?? 8,
        minute: _time?.minute ?? 0,
      ),
    );
    if (picked != null && mounted) {
      setState(() => _time = (hour: picked.hour, minute: picked.minute));
    }
  }

  /// When the next reminder would fire for this chore as it is on the
  /// page now: today at the chosen time if still due and not done,
  /// else the next due day — a chore ticked today reminds tomorrow.
  String _nextReminderText(AppLocalizations t) {
    final at = _remindAt ?? _time;
    if (at == null) return t.remindNone;
    final draft =
        (existing ??
                Chore(
                  id: 'draft',
                  entity: _entity,
                  title: _title.text,
                  schedule: _schedule,
                  start: dayOf(DateTime.now()),
                ))
            .copyWith(schedule: _schedule, remind: true, remindAt: at);
    final ticks = existing == null
        ? <DateTime, DateTime>{}
        : store.choreTicks(existing!);
    final now = DateTime.now();
    final today = dayOf(now);
    DateTime moment(DateTime day) =>
        DateTime(day.year, day.month, day.day, at.hour, at.minute);
    var due = nextDue(draft, ticks, today);
    if (due == null) return t.remindNone;
    var when = moment(due);
    if (!when.isAfter(now)) {
      final later = nextDue(draft, ticks, daysFrom(today, 1));
      if (later == null) return t.remindNone;
      when = moment(later);
    }
    final locale = Localizations.localeOf(context).toString();
    return t.remindNext(DateFormat.MMMEd(locale).add_Hm().format(when));
  }

  void _say(String text) {
    if (mounted) noteFailed(text);
  }

  /// Whether notifications may be sent: the phone's answer, or the
  /// reason the question could not even be asked. A refusal and a
  /// broken plugin read differently — one is fixed in the phone's
  /// settings, the other is a bug report.
  Future<bool> _allowed() async {
    final t = context.t;
    try {
      if (await port.ensurePermission()) return true;
      _say(t.remindPermissionDenied);
    } catch (e) {
      _say(t.remindFailed(e.toString()));
    }
    return false;
  }

  /// The reminder switch asks for the permission, then for the time; a
  /// refusal is said and the switch stays off.
  Future<void> _toggleRemind(bool on) async {
    if (on && !await _allowed()) return;
    if (!mounted) return;
    if (on) {
      // Opens at the chore's own time, else now: a fixed 08:00 read as
      // a wrong time zone on a mid-morning phone.
      final at = _remindAt ?? _time;
      final picked = await showTimePicker(
        context: context,
        initialTime: at == null
            ? TimeOfDay.now()
            : TimeOfDay(hour: at.hour, minute: at.minute),
      );
      if (picked == null || !mounted) return;
      _remindAt = (hour: picked.hour, minute: picked.minute);
    }
    setState(() => _remind = on);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(existing == null ? t.newChore : t.choreEdit),
        actions: [
          TextButton(onPressed: _canSave ? _save : null, child: Text(t.save)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (existing == null) ...[
            PlanEntityField(
              store: store,
              value: _entity,
              onChanged: (v) => setState(() => _entity = v ?? _entity),
            ),
            const SizedBox(height: 16),
          ],
          TextField(
            controller: _title,
            autofocus: existing == null,
            decoration: InputDecoration(labelText: t.choreTitleLabel),
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
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
            selected: {_repeat},
            onSelectionChanged: (s) => setState(() => _repeat = s.first),
          ),
          if (_repeat == ChoreRepeat.everyDays)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _every > 1
                        ? () => setState(() => _every--)
                        : null,
                  ),
                  // The unit picker reads as the sentence it makes:
                  // "every 2 weeks", "every 2 years".
                  DropdownButton<ChoreUnit>(
                    value: _unit,
                    items: [
                      for (final u in ChoreUnit.values)
                        DropdownMenuItem(
                          value: u,
                          child: Text(_everyText(_every, u)),
                        ),
                    ],
                    onChanged: (u) => setState(() {
                      if (u == null) return;
                      _unit = u;
                      if (_every > _maxEvery) _every = _maxEvery;
                    }),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _every < _maxEvery
                        ? () => setState(() => _every++)
                        : null,
                  ),
                ],
              ),
            ),
          if (_repeat == ChoreRepeat.weekdays)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 4,
                children: [
                  for (var d = DateTime.monday; d <= DateTime.sunday; d++)
                    FilterChip(
                      label: Text(
                        DateFormat.E(locale)
                            .format(_monday.add(Duration(days: d - 1))),
                      ),
                      selected: _weekdays.contains(d),
                      onSelected: (on) => setState(
                        () => on ? _weekdays.add(d) : _weekdays.remove(d),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text(_time == null ? t.choreNoTime : _clock(_time!)),
            trailing: _time == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _time = null),
                  ),
            onTap: _pickTime,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.notifications_outlined),
            title: Text(t.remindMe),
            subtitle: _remind && _remindAt != null
                ? Text(_clock(_remindAt!))
                : null,
            value: _remind,
            onChanged: _toggleRemind,
          ),
          if (_remind) ...[
            // What will be scheduled once saved, and what the phone holds
            // now — so "nothing came" has a visible reason.
            Text(_nextReminderText(t), style: theme.textTheme.bodySmall),
            FutureBuilder<int>(
              future: port.pendingCount(),
              builder: (context, snap) => snap.hasData
                  ? Text(
                      t.remindPending(snap.data!),
                      style: theme.textTheme.bodySmall,
                    )
                  : const SizedBox.shrink(),
            ),
            // Reminders are inexact alarms: Android picks the moment.
            Text(t.remindLateHint, style: theme.textTheme.bodySmall),
            TextButton.icon(
              icon: const Icon(Icons.notifications_active_outlined),
              label: Text(t.remindTest),
              onPressed: () async {
                if (!await _allowed() || !mounted) return;
                try {
                  await port.showNow(
                    _title.text.trim().isEmpty
                        ? t.newChore
                        : _title.text.trim(),
                    store.current(_entity, Keys.name) ?? '',
                    catSound: reminderCatSound(store),
                  );
                } catch (e) {
                  _say(t.remindFailed(e.toString()));
                }
              },
            ),
          ],
          if (_remind && Platform.isAndroid)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.batteryHint, style: theme.textTheme.bodySmall),
                TextButton(
                  onPressed: port.openBatterySettings,
                  child: Text(t.batterySettings),
                ),
              ],
            ),
          if (existing != null) ...[
            const Divider(height: 32),
            // Day by day: done when and by whom, missed, open — the
            // control a medicine needs.
            ListTile(
              leading: const Icon(Icons.history),
              title: Text(t.choreHistory),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ChoreHistoryScreen(store: store, chore: existing!),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.copy_outlined),
              title: Text(t.choreDuplicate),
              onTap: _duplicate,
            ),
            ListTile(
              leading: Icon(existing!.paused ? Icons.play_arrow : Icons.pause),
              title: Text(existing!.paused ? t.choreResume : t.chorePause),
              onTap: _pauseOrResume,
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: theme.colorScheme.error,
              ),
              title: Text(
                t.choreEnd,
                style: TextStyle(color: theme.colorScheme.error),
              ),
              onTap: _end,
            ),
          ],
        ],
      ),
    );
  }
}
