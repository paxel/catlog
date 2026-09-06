import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Chore reminders (1.2.0): a phone notification at the chore's chosen
/// time on the days it is due, for the chores the keeper switched it on
/// for. Scheduled alarms handed to the system, no service of our own:
/// rebuilt on every app start and after every tick, edit and sync, so a
/// chore done on the partner's phone quiets this one too.

/// What the platform must do for reminders; a fake in tests.
abstract class ReminderPort {
  /// Asks for the right to notify; false when refused.
  Future<bool> ensurePermission();

  Future<void> schedule(int id, DateTime at, String title, String body);

  Future<void> cancelAll();

  /// Opens the phone's battery settings for this app, where a maker's
  /// saver can be told to let reminders through. False where there is
  /// no such page.
  Future<bool> openBatterySettings();
}

/// One reminder to schedule: the chore, when, and what to say.
class PlannedReminder {
  final Chore chore;
  final DateTime at;

  const PlannedReminder(this.chore, this.at);

  /// A stable id per chore, so the newest schedule replaces the last.
  int get id => chore.id.hashCode & 0x7fffffff;
}

/// The next reminder of every chore that wants one, seen from [now]:
/// today at the chosen time when the chore is due and not done yet and
/// the time has not passed, else the next due day. One per chore; the
/// next rebuild takes care of the day after.
List<PlannedReminder> plannedReminders(CatalogStore store, DateTime now) {
  final today = dayOf(now);
  final result = <PlannedReminder>[];
  for (final chore in store.allChores()) {
    if (!chore.active || !chore.remind) continue;
    final at = chore.remindAt ?? chore.time;
    if (at == null) continue;
    final ticks = store.choreTicks(chore);
    DateTime moment(DateTime day) =>
        DateTime(day.year, day.month, day.day, at.hour, at.minute);
    final due = nextDue(chore, ticks, today);
    if (due == null) continue;
    var when = moment(due);
    if (!when.isAfter(now)) {
      // Today's time is past: the next due day after today.
      final later = nextDue(chore, ticks, daysFrom(today, 1));
      if (later == null) continue;
      when = moment(later);
    }
    result.add(PlannedReminder(chore, when));
  }
  result.sort((a, b) => a.at.compareTo(b.at));
  return result;
}

/// Replaces every scheduled reminder with the plan of this moment.
Future<void> rescheduleChoreReminders(
  CatalogStore store,
  ReminderPort port, {
  DateTime? now,
  required String Function(Chore chore) body,
}) async {
  final planned = plannedReminders(store, now ?? DateTime.now());
  await port.cancelAll();
  for (final p in planned) {
    await port.schedule(p.id, p.at, p.chore.title, body(p.chore));
  }
}

/// The phone's own notifications, through the local notifications
/// plugin. One instance for the app.
class LocalNotificationPort implements ReminderPort {
  static final LocalNotificationPort instance = LocalNotificationPort._();

  LocalNotificationPort._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> _init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      final zone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(zone.identifier));
    } catch (_) {
      // UTC then; a reminder an hour off beats none.
    }
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _ready = true;
  }

  @override
  Future<bool> ensurePermission() async {
    try {
      await _init();
      if (Platform.isAndroid) {
        final android = _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
        return await android?.requestNotificationsPermission() ?? true;
      }
      if (Platform.isIOS) {
        final ios = _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
        return await ios?.requestPermissions(alert: true, sound: true) ?? false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> schedule(int id, DateTime at, String title, String body) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    try {
      await _init();
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(at, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'chores',
            'Chores',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (_) {
      // No plugin here (desktop, tests): the checklist still reminds.
    }
  }

  @override
  Future<void> cancelAll() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    try {
      await _init();
      await _plugin.cancelAll();
    } catch (_) {}
  }

  @override
  Future<bool> openBatterySettings() async {
    if (!Platform.isAndroid) return false;
    try {
      return await const MethodChannel('catlog/backup')
              .invokeMethod<bool>('openBatterySettings') ??
          false;
    } catch (_) {
      return false;
    }
  }
}

/// The reminders as the app keeps them: rebuilt from [store] through the
/// phone's port, with the notification body in the app's words.
Future<void> refreshChoreReminders(
  CatalogStore store, {
  ReminderPort? port,
  required String Function(Chore chore) body,
}) => rescheduleChoreReminders(
  store,
  port ?? LocalNotificationPort.instance,
  body: body,
);
