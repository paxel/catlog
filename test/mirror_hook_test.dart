import 'package:catalog_core/catalog_core.dart';
import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/src/reminders/calendar_mirror.dart';
import 'package:catlog/src/reminders/calendar_port.dart';
import 'package:catlog/src/reminders/mirror_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A calendar that answers with an error switches the mirror off and
/// says why — it must never become a crash on every start.
class BrokenCalendar implements CalendarPort {
  @override
  Future<bool> ensureAccess() async => true;

  @override
  Future<List<CalendarChoice>> listCalendars() async =>
      throw const CalendarPortException('Calendar provider unavailable');

  @override
  Future<String?> createEvent(String calendarId, EventSpec spec) async => null;

  @override
  Future<bool> updateEvent(
          String calendarId, String eventId, EventSpec spec) async =>
      false;

  @override
  Future<void> deleteEvent(String calendarId, String eventId) async {}

  @override
  Future<List<String>> markedEventIds(String calendarId) async => [];
}

void main() {
  setUpAll(useSystemSqlite);

  testWidgets('a calendar error turns the mirror off with its message',
      (tester) async {
    final store = CatalogStore.inMemory()..author = 'test';
    addTearDown(store.close);
    store.setLocalSetting(calendarMirrorEnabledKey, 'on');
    store.setLocalSetting(calendarMirrorCalendarKey, 'cal-1');
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Builder(builder: (c) {
        context = c;
        return const SizedBox();
      })),
    ));
    mirrorAfterChange(context, store, port: BrokenCalendar());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(store.localSetting(calendarMirrorEnabledKey), 'off');
    expect(find.text('Calendar provider unavailable'), findsOneWidget);
  });
}
