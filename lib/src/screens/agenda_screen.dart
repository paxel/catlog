import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../help.dart';
import '../l10n.dart';
import '../layout.dart';
import '../reminders/calendar_mirror.dart';
import '../reminders/calendar_port.dart';
import '../reminders/device_calendar_port.dart';
import '../reminders/mirror_hook.dart';
import '../reminders/plan_chooser.dart';
import '../share.dart';
import '../spotlight.dart';
import '../reminders/appointment_dialog.dart';
import '../widgets/appointment_card.dart';
import '../widgets/reminder_card.dart';
import 'cat_detail_screen.dart';
import 'clowder_detail_screen.dart';

/// The agenda auto-opens once per app run when something is due within
/// [agendaAutoOpenWindow]; this remembers that it already did.
bool agendaAutoOpened = false;

const agendaAutoOpenWindow = Duration(days: 3);

/// True when the next due date warrants opening the agenda on start —
/// a reminder's day or an appointment's start, whichever comes first.
bool agendaWantsAttention(CatalogStore store) {
  final limit = DateTime.now().add(agendaAutoOpenWindow);
  final reminders = store.activeReminders();
  if (reminders.isNotEmpty && !reminders.first.due.isAfter(limit)) {
    return true;
  }
  final appointments = store.openAppointments();
  return appointments.isNotEmpty && !appointments.first.start.isAfter(limit);
}

/// One row of the agenda: a reminder or an appointment, sorted together.
sealed class AgendaItem {
  DateTime get when;
}

class ReminderItem extends AgendaItem {
  final ActiveReminder reminder;
  ReminderItem(this.reminder);
  @override
  DateTime get when => reminder.due;
}

/// One appointment, or one vet run: [members] are the group's open
/// appointments, the first stands for the card.
class AppointmentItem extends AgendaItem {
  final List<Appointment> members;
  AppointmentItem(this.members);
  Appointment get appointment => members.first;
  @override
  DateTime get when => appointment.start;
}

/// Everything open, both kinds, earliest first.
List<AgendaItem> agendaItems(CatalogStore store) {
  final items = <AgendaItem>[
    for (final r in store.activeReminders()) ReminderItem(r),
    for (final g in store.openAppointmentGroups()) AppointmentItem(g),
  ];
  items.sort((x, y) => x.when.compareTo(y.when));
  return items;
}

/// The calendar file's events: the same ones the calendar mirror would
/// write — reminders all-day, appointments timed with their alarm, a
/// vet run as one event — so file and mirror never disagree.
List<IcsEvent> icsEvents(CatalogStore store, AppLocalizations t) => [
  for (final MapEntry(:key, :value) in desiredEvents(store, t).entries)
    IcsEvent(
      uid: 'catlog-$key@catlog'.replaceAll(RegExp(r'[:|]'), '-'),
      date: value.start,
      end: value.allDay ? null : value.end,
      summary: value.title,
      description: value.description,
      alertMinutesBefore: value.alertMinutesBefore,
    ),
];

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => runSpotlights(context, store, 'agenda'),
    );
  }

  bool get _calendarAvailable =>
      widget.calendarPort != null || deviceCalendarAvailable;

  void _changed() {
    setState(() {});
    mirrorAfterChange(context, store, port: widget.calendarPort);
  }

  Future<void> _add() async {
    if (await showPlanChooser(context, store) && mounted) _changed();
  }

  Future<void> _openEntity(String id) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => id.startsWith('cat:')
            ? CatDetailScreen(store: store, catId: id)
            : ClowderDetailScreen(store: store, clowderId: id),
      ),
    );
    if (mounted) setState(() {});
  }

  /// A run's card opens the clowder all its cats share, else the
  /// appointment itself; a single appointment opens its entity.
  Future<void> _openGroup(List<Appointment> members) async {
    if (members.length == 1) return _openEntity(members.single.entity);
    final homes = {
      for (final m in members) store.current(m.entity, Keys.clowder),
    };
    if (homes.length == 1 && homes.single != null) {
      return _openEntity(homes.single!);
    }
    final saved = await showAppointmentDialog(
      context,
      store,
      entityId: members.first.entity,
      existing: members.first,
    );
    if (saved != null && mounted) _changed();
  }

  /// The desktop and escape-hatch path: one .ics file of every plan.
  Future<void> _exportIcs() async {
    final t = context.t;
    final ics = writeIcs(icsEvents(store, t), stamp: DateTime.now());
    try {
      await shareFiles(context, [
        XFile.fromData(
          Uint8List.fromList(utf8.encode(ics)),
          mimeType: 'text/calendar',
          name: 'catlog.ics',
        ),
      ]);
    } catch (_) {
      // Share sheet unavailable (some desktops): save next to the data.
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/catlog.ics');
      await file.writeAsString(ics);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.icsSavedTo(file.path))));
    }
  }

  void _say(String message) =>
      ScaffoldMessenger.of(context)
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
    final List<CalendarChoice> calendars;
    try {
      calendars = await port.listCalendars();
    } on CalendarPortException catch (e) {
      // The platform's own wording beats a guess at the cause.
      if (mounted) _say(e.message);
      return;
    }
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
            child: Text(
              t.calendarMirrorSubtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          for (final c in calendars)
            SimpleDialogOption(
              onPressed: c.writable
                  ? () => Navigator.of(context).pop(c.id)
                  : null,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                enabled: c.writable,
                leading: const Icon(Icons.calendar_month_outlined),
                title: Text(c.name),
                subtitle: Text(
                  [?c.account, if (!c.writable) t.readOnlyCalendar].join(' · '),
                ),
              ),
            ),
        ],
      ),
    );
    if (chosen == null || !mounted) return;
    store.setLocalSetting(calendarMirrorCalendarKey, chosen);
    store.setLocalSetting(
      calendarMirrorCalendarNameKey,
      calendars.firstWhere((c) => c.id == chosen).name,
    );
    store.setLocalSetting(calendarMirrorEnabledKey, 'on');
    setState(() {});
    mirrorAfterChange(context, store, port: widget.calendarPort);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final items = agendaItems(store);
    return Scaffold(
      appBar: roomyAppBar(
        context,
        title: Text(t.agenda),
        actions: [
          HelpButton(store: store, screenId: 'agenda'),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'ics') _exportIcs();
              if (v == 'resync') {
                resyncCalendarNow(context, store, port: widget.calendarPort);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'ics', child: Text(t.exportIcs)),
              if (calendarMirrorEnabled(store) && _calendarAvailable)
                PopupMenuItem(value: 'resync', child: Text(t.resyncCalendar)),
            ],
          ),
        ],
      ),
      body: ListView(
        // The last card scrolls clear of the floating button.
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 88),
        children: [
          // The calendar switch as a visible row — state readable at a
          // glance, nothing buried in a menu.
          if (_calendarAvailable)
            Spotlight(
              id: 'agenda-calendar',
              child: SwitchListTile(
                secondary: const Icon(Icons.calendar_month_outlined),
                title: Text(
                  calendarMirrorEnabled(store)
                      ? t.calendarRowOn(
                          store.localSetting(calendarMirrorCalendarNameKey) ??
                              '',
                        )
                      : t.calendarRowOff,
                ),
                value: calendarMirrorEnabled(store),
                onChanged: (_) => _toggleMirror(),
              ),
            ),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(t.agendaEmpty),
            ),
          for (final item in items)
            switch (item) {
              ReminderItem(:final reminder) => ReminderCard(
                store: store,
                reminder: reminder,
                onChanged: _changed,
                onOpen: () => _openEntity(reminder.entity),
              ),
              AppointmentItem(:final appointment, :final members) =>
                AppointmentCard(
                  store: store,
                  appointment: appointment,
                  members: members,
                  wholeGroup: true,
                  onChanged: _changed,
                  onOpen: () => _openGroup(members),
                  onOpenEntity: _openEntity,
                ),
            },
        ],
      ),
      floatingActionButton: Spotlight(
        id: 'agenda-add',
        child: FloatingActionButton(
          onPressed: _add,
          tooltip: t.addAppointment,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
