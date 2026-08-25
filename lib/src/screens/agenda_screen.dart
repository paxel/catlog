import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../field_labels.dart';
import '../l10n.dart';
import '../layout.dart';
import '../reminders/calendar_mirror.dart';
import '../reminders/device_calendar_port.dart';
import '../share.dart';
import '../widgets/cat_ear.dart';
import 'cat_detail_screen.dart';
import 'clowder_detail_screen.dart';

/// The agenda auto-opens once per app run when something is due within
/// [agendaAutoOpenWindow]; this remembers that it already did.
bool agendaAutoOpened = false;

const agendaAutoOpenWindow = Duration(days: 3);

/// True when the next due date warrants opening the agenda on start.
bool agendaWantsAttention(CatalogStore store) {
  final active = store.activeReminders();
  if (active.isEmpty) return false;
  final next = active.first.due;
  return !next.isAfter(DateTime.now().add(agendaAutoOpenWindow));
}

/// Everything due, ordered by date (#74): one card per active plan —
/// relative date, absolute date, who, what. Overdue stays pinned at the
/// top until handled. Done records the fact and offers the next cycle.
class AgendaScreen extends StatefulWidget {
  final CatalogStore store;

  const AgendaScreen({super.key, required this.store});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  CatalogStore get store => widget.store;

  Map<String, FieldDef> get _defs => {
        for (final def in store.fieldDefs()) def.key: def,
      };

  /// Fire-and-forget one-way reconcile after any plan change.
  void _mirror() {
    if (!deviceCalendarAvailable || !calendarMirrorEnabled(store)) return;
    final t = context.t;
    reconcileCalendar(store, DeviceCalendarPort(), t);
  }

  Future<void> _markDone(ActiveReminder r) async {
    store.append(r.entity, r.field, r.value);
    setState(() {});
    final again = await _askRepeat();
    if (!mounted) return;
    if (again != null) {
      store.append(r.entity, r.field, r.value,
          date: again, reminder: true);
    }
    _mirror();
    setState(() {});
  }

  /// "Again in…" — returns the next due date, or null for no repeat.
  Future<DateTime?> _askRepeat() => showDialog<DateTime>(
        context: context,
        builder: (context) => const _RepeatDialog(),
      );

  Future<void> _changeDate(ActiveReminder r) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: r.due,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      errorFormatText: context.t
          .dateFormatError(MaterialLocalizations.of(context).dateHelpText),
    );
    if (picked == null || !mounted) return;
    store.append(r.entity, r.field, r.value, date: picked, reminder: true);
    _mirror();
    setState(() {});
  }

  void _cancel(ActiveReminder r) {
    store.append(r.entity, r.field, null, reminder: true);
    _mirror();
    setState(() {});
  }

  /// The desktop and escape-hatch path: one .ics file of every plan.
  Future<void> _exportIcs() async {
    final t = context.t;
    final defs = _defs;
    final ics = writeIcs([
      for (final r in store.activeReminders())
        IcsEvent(
          uid: 'catlog-${r.entity}-${r.field}@catlog'
              .replaceAll(':', '-'),
          date: r.due,
          summary:
              '${store.current(r.entity, Keys.name) ?? t.unnamed} — '
              '${defs[r.field] == null ? r.field : fieldDefName(t, defs[r.field]!)}',
          description: r.value,
        ),
    ], stamp: DateTime.now());
    try {
      await shareFiles(context, [
        XFile.fromData(Uint8List.fromList(utf8.encode(ics)),
            mimeType: 'text/calendar', name: 'catlog.ics'),
      ]);
    } catch (_) {
      // Share sheet unavailable (some desktops): save next to the data.
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/catlog.ics');
      await file.writeAsString(ics);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.icsSavedTo(file.path))),
      );
    }
  }

  Future<void> _toggleMirror() async {
    final t = context.t;
    if (calendarMirrorEnabled(store)) {
      store.setLocalSetting(calendarMirrorEnabledKey, 'off');
      setState(() {});
      return;
    }
    // One dialog says what the switch does before anything is written.
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.calendarMirrorLabel),
        content: Text(t.calendarMirrorSubtitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.ok),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    store.setLocalSetting(calendarMirrorEnabledKey, 'on');
    _mirror();
    setState(() {});
  }

  Future<void> _openEntity(String id) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => id.startsWith('cat:')
          ? CatDetailScreen(store: store, catId: id)
          : ClowderDetailScreen(store: store, clowderId: id),
    ));
    if (mounted) setState(() {});
  }

  Future<void> _menu(ActiveReminder r, Offset position) async {
    final action = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
            value: 'date', child: Text(context.t.changeDateLabel)),
        PopupMenuItem(
            value: 'remove', child: Text(context.t.removeReminderLabel)),
      ],
    );
    if (!mounted) return;
    if (action == 'date') await _changeDate(r);
    if (action == 'remove') _cancel(r);
  }

  String _relative(BuildContext context, DateTime due) {
    final today = DateUtils.dateOnly(DateTime.now());
    final day = DateUtils.dateOnly(due);
    final days = day.difference(today).inDays;
    if (days == 0) return context.t.dueToday;
    if (days > 0) return context.t.dueInDays(days);
    return context.t.overdueByDays(-days);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final active = store.activeReminders();
    final defs = _defs;
    final today = DateUtils.dateOnly(DateTime.now());
    final dateFormat =
        DateFormat.yMd(Localizations.localeOf(context).toString());
    return Scaffold(
      appBar: roomyAppBar(
        context,
        title: Text(t.agenda),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'ics') _exportIcs();
              if (v == 'mirror') _toggleMirror();
            },
            itemBuilder: (context) => [
              if (deviceCalendarAvailable)
                CheckedPopupMenuItem(
                    value: 'mirror',
                    checked: calendarMirrorEnabled(store),
                    child: Text(t.calendarMirrorLabel)),
              PopupMenuItem(
                  value: 'ics', child: Text(t.exportIcs)),
            ],
          ),
        ],
      ),
      body: active.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(32),
              child: Text(t.agendaEmpty),
            )
          : ListView(
              padding: const EdgeInsets.all(8),
              children: [
                for (final r in active)
                  _card(context, r, defs, today, dateFormat),
              ],
            ),
    );
  }

  Widget _card(BuildContext context, ActiveReminder r,
      Map<String, FieldDef> defs, DateTime today, DateFormat dateFormat) {
    final t = context.t;
    final overdue = DateUtils.dateOnly(r.due).isBefore(today);
    final name = store.current(r.entity, Keys.name) ?? t.unnamed;
    final def = defs[r.field];
    final fieldName =
        def == null ? r.field : fieldDefName(t, def);
    final color = overdue ? Theme.of(context).colorScheme.error : null;
    return Card(
      child: GestureDetector(
        onLongPressStart: (d) => _menu(r, d.globalPosition),
        onSecondaryTapDown: (d) => _menu(r, d.globalPosition),
        child: WithCatEar(
            child: ListTile(
          onTap: () => _openEntity(r.entity),
          title: Text(
              '${_relative(context, r.due)} · '
              '${dateFormat.format(r.due)}',
              style:
                  TextStyle(color: color, fontWeight: FontWeight.bold)),
          subtitle: Text('$name · $fieldName\n${r.value}',
              maxLines: 2, overflow: TextOverflow.ellipsis),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: t.markDone,
            onPressed: () => _markDone(r),
          ),
        )),
      ),
    );
  }
}

/// Number + unit for the next cycle; pops the computed date, or null
/// for no repeat.
class _RepeatDialog extends StatefulWidget {
  const _RepeatDialog();

  @override
  State<_RepeatDialog> createState() => _RepeatDialogState();
}

class _RepeatDialogState extends State<_RepeatDialog> {
  final _count = TextEditingController(text: '3');
  String _unit = 'months';

  @override
  void dispose() {
    _count.dispose();
    super.dispose();
  }

  DateTime? _next() {
    final n = int.tryParse(_count.text.trim());
    if (n == null || n <= 0) return null;
    final now = DateTime.now();
    return switch (_unit) {
      'days' => now.add(Duration(days: n)),
      'weeks' => now.add(Duration(days: 7 * n)),
      'months' => DateTime(now.year, now.month + n, now.day),
      _ => DateTime(now.year + n, now.month, now.day),
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final units = {
      'days': t.unitDays,
      'weeks': t.unitWeeks,
      'months': t.unitMonths,
      'years': t.unitYears,
    };
    return AlertDialog(
      title: Text(t.repeatTitle),
      content: Row(children: [
        SizedBox(
          width: 64,
          child: TextField(
            controller: _count,
            autofocus: true,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButton<String>(
            value: _unit,
            isExpanded: true,
            items: [
              for (final MapEntry(:key, :value) in units.entries)
                DropdownMenuItem(value: key, child: Text(value)),
            ],
            onChanged: (v) =>
                setState(() => _unit = v ?? _unit),
          ),
        ),
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.noRepeatLabel),
        ),
        FilledButton(
          onPressed:
              _next() == null ? null : () => Navigator.of(context).pop(_next()),
          child: Text(t.save),
        ),
      ],
    );
  }
}
