import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import 'calendar_mirror.dart';
import 'calendar_port.dart';
import 'device_calendar_port.dart';

/// Runs the calendar mirror after a plan changed, from any screen.
/// Every failure is named and switches the mirror off — a silent
/// failure would pose as a working mirror (the 1.0.0 lesson).
///
/// Fire-and-forget: the screen must not wait on the platform calendar.
void mirrorAfterChange(BuildContext context, CatalogStore store,
    {CalendarPort? port}) {
  if (!calendarMirrorEnabled(store)) return;
  if (port == null && !deviceCalendarAvailable) return;
  final t = context.t;
  final messenger = ScaffoldMessenger.maybeOf(context);
  void fail(String message) {
    // A catalog switched away mid-reconcile is closed by now: nothing
    // to record, nothing to report (#89).
    if (!store.isOpen) return;
    store.setLocalSetting(calendarMirrorEnabledKey, 'off');
    messenger?.showSnackBar(SnackBar(content: Text(message)));
  }

  reconcileCalendarOnce(store, port ?? DeviceCalendarPort(), t)
      .then((outcome) {
    final message = mirrorFailureMessage(t, outcome);
    if (message != null) fail(message);
  }).catchError((Object e) {
    // The calendar answered with an error (the platform's own wording
    // beats a guess): the mirror goes off, named, instead of the app
    // going down on every start — the 1.0.0 lesson, once more.
    if (e is StateError && !store.isOpen) return;
    fail(e is CalendarPortException ? e.message : '$e');
  });
}

/// "Resync calendar" from the agenda menu: deletes what cat(a)log wrote
/// into the calendar and writes the plans fresh. Reports failure like
/// the hook; on success says nothing — the calendar shows it.
Future<void> resyncCalendarNow(BuildContext context, CatalogStore store,
    {CalendarPort? port}) async {
  if (port == null && !deviceCalendarAvailable) return;
  final t = context.t;
  final messenger = ScaffoldMessenger.maybeOf(context);
  MirrorOutcome outcome;
  try {
    outcome = await resyncCalendar(store, port ?? DeviceCalendarPort(), t);
  } on CalendarPortException catch (e) {
    // The platform's own wording beats a guess at the cause.
    messenger?.showSnackBar(SnackBar(content: Text(e.message)));
    return;
  }
  final message = mirrorFailureMessage(t, outcome);
  if (message == null || !store.isOpen) return;
  store.setLocalSetting(calendarMirrorEnabledKey, 'off');
  messenger?.showSnackBar(SnackBar(content: Text(message)));
}

/// The cause-plus-fix text for a failed reconcile, null when it worked
/// (or the mirror is simply off).
String? mirrorFailureMessage(AppLocalizations t, MirrorOutcome outcome) =>
    switch (outcome) {
      MirrorOutcome.ok || MirrorOutcome.off || MirrorOutcome.abandoned => null,
      MirrorOutcome.noAccess => t.calendarPermissionDenied,
      MirrorOutcome.noCalendarChosen => t.calendarNotChosen,
      MirrorOutcome.calendarGone => t.calendarGone,
    };
