import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n.dart';
import '../reminders/plan_chooser.dart';
import 'chore_reminders.dart';

/// Making or editing a chore (1.2.0): a title, whose it is, how often,
/// at what time of day, and whether the phone should remind. A full
/// page that scrolls, Save in the top bar; an existing chore has Pause
/// and End as rows at the bottom. Returns the chore as saved, null when
/// dismissed.
Future<Chore?> showChoreDialog(
  BuildContext context,
  CatalogStore store, {
  String? entityId,
  Chore? existing,
  ReminderPort? reminders,
}) async {
  var entity = existing?.entity ?? entityId;
  if (entity == null) {
    entity = await pickPlanEntity(context, store);
    if (entity == null || !context.mounted) return null;
  }
  return Navigator.of(context).push<Chore>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => ChoreEditorScreen(
        store: store,
        entityId: entity!,
        existing: existing,
        reminders: reminders,
      ),
    ),
  );
}

class ChoreEditorScreen extends StatefulWidget {
  final CatalogStore store;
  final String entityId;
  final Chore? existing;
  final ReminderPort? reminders;

  const ChoreEditorScreen({
    super.key,
    required this.store,
    required this.entityId,
    this.existing,
    this.reminders,
  });

  @override
  State<ChoreEditorScreen> createState() => _ChoreEditorScreenState();
}

class _ChoreEditorScreenState extends State<ChoreEditorScreen> {
  CatalogStore get store => widget.store;
  Chore? get existing => widget.existing;
  ReminderPort get port => widget.reminders ?? LocalNotificationPort.instance;

  late final TextEditingController _title = TextEditingController(
    text: existing?.title ?? '',
  );
  late ChoreRepeat _repeat = existing?.schedule.repeat ?? ChoreRepeat.daily;
  late int _every = (existing?.schedule.every ?? 2) < 2
      ? 2
      : existing!.schedule.every;
  late final Set<int> _weekdays = {...?existing?.schedule.weekdays};
  late ({int hour, int minute})? _time = existing?.time;
  late bool _remind = existing?.remind ?? false;
  late ({int hour, int minute})? _remindAt =
      existing?.remindAt ?? existing?.time;

  static final _monday = DateTime(2026, 9, 7);

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _title.text.trim().isNotEmpty &&
      (_repeat != ChoreRepeat.weekdays || _weekdays.isNotEmpty);

  String _clock(({int hour, int minute}) at) =>
      MaterialLocalizations.of(context)
          .formatTimeOfDay(TimeOfDay(hour: at.hour, minute: at.minute));

  ChoreSchedule get _schedule => switch (_repeat) {
    ChoreRepeat.daily => const ChoreSchedule.daily(),
    ChoreRepeat.everyDays => ChoreSchedule.everyDays(_every),
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
          entity: widget.entityId,
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

  /// The reminder switch asks for the permission, then for the time; a
  /// refusal is said and the switch stays off.
  Future<void> _toggleRemind(bool on) async {
    if (on && !await port.ensurePermission()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.t.remindPermissionDenied)),
        );
      }
      return;
    }
    if (!mounted) return;
    if (on) {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: _remindAt?.hour ?? _time?.hour ?? 8,
          minute: _remindAt?.minute ?? _time?.minute ?? 0,
        ),
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
                    onPressed: _every > 2
                        ? () => setState(() => _every--)
                        : null,
                  ),
                  Text(t.choreEveryDays(_every)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _every < 365
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
            ListTile(
              leading: Icon(existing!.paused ? Icons.play_arrow : Icons.pause),
              title: Text(existing!.paused ? t.choreResume : t.chorePause),
              onTap: _pauseOrResume,
            ),
            ListTile(
              leading: Icon(
                Icons.stop_circle_outlined,
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
