import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../field_labels.dart';
import '../l10n.dart';
import '../layout.dart';
import '../reminders/calendar_mirror.dart';
import '../reminders/calendar_port.dart';
import '../reminders/device_calendar_port.dart';
import '../reminders/mirror_hook.dart';
import '../reminders/reminder_dialog.dart';
import '../share.dart';
import '../widgets/reminder_card.dart';
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

  /// Test override for the device calendar; null = the real one.
  final CalendarPort? calendarPort;

  const AgendaScreen({super.key, required this.store, this.calendarPort});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  CatalogStore get store => widget.store;

  bool get _calendarAvailable =>
      widget.calendarPort != null || deviceCalendarAvailable;

  void _changed() {
    setState(() {});
    mirrorAfterChange(context, store, port: widget.calendarPort);
  }

  Future<void> _add() async {
    if (await showAddReminder(context, store) && mounted) _changed();
  }

  Future<void> _openEntity(String id) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => id.startsWith('cat:')
          ? CatDetailScreen(store: store, catId: id)
          : ClowderDetailScreen(store: store, clowderId: id),
    ));
    if (mounted) setState(() {});
  }

  /// The desktop and escape-hatch path: one .ics file of every plan.
  Future<void> _exportIcs() async {
    final t = context.t;
    final defs = {for (final def in store.fieldDefs()) def.key: def};
    final ics = writeIcs([
      for (final r in store.activeReminders())
        IcsEvent(
          uid: 'catlog-${r.entity}-${r.field}@catlog'.replaceAll(':', '-'),
          date: r.due,
          summary: '${store.current(r.entity, Keys.name) ?? t.unnamed} — '
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

  void _say(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  /// Switching the mirror on: permission, then the user picks one of
  /// the device's writable calendars. Every refusal is named.
  Future<void> _toggleMirror() async {
    final t = context.t;
    if (calendarMirrorEnabled(store)) {
      store.setLocalSetting(calendarMirrorEnabledKey, 'off');
      setState(() {});
      return;
    }
    final port = widget.calendarPort ?? DeviceCalendarPort();
    if (!await port.ensureAccess()) {
      if (mounted) _say(t.calendarPermissionDenied);
      return;
    }
    final calendars = await port.listCalendars();
    if (!mounted) return;
    if (calendars.isEmpty) {
      _say(t.noWritableCalendar);
      return;
    }
    final chosen = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(t.pickCalendar),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Text(t.calendarMirrorSubtitle,
                style: Theme.of(context).textTheme.bodySmall),
          ),
          for (final c in calendars)
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(c.id),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_month_outlined),
                title: Text(c.name),
                subtitle: c.account == null ? null : Text(c.account!),
              ),
            ),
        ],
      ),
    );
    if (chosen == null || !mounted) return;
    store.setLocalSetting(calendarMirrorCalendarKey, chosen);
    store.setLocalSetting(calendarMirrorEnabledKey, 'on');
    setState(() {});
    mirrorAfterChange(context, store, port: widget.calendarPort);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final active = store.activeReminders();
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
              if (_calendarAvailable)
                CheckedPopupMenuItem(
                    value: 'mirror',
                    checked: calendarMirrorEnabled(store),
                    child: Text(t.calendarMirrorLabel)),
              PopupMenuItem(value: 'ics', child: Text(t.exportIcs)),
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
              // The last card scrolls clear of the floating button.
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 88),
              children: [
                for (final r in active)
                  ReminderCard(
                    store: store,
                    reminder: r,
                    onChanged: _changed,
                    onOpen: () => _openEntity(r.entity),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: t.addReminder,
        child: const Icon(Icons.alarm_add),
      ),
    );
  }
}
