import 'package:catlog/src/reminders/device_calendar_port.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tzdata;

/// 1.0.5: the phone's calendar showed appointments two hours late —
/// the local hour had been written as a UTC hour.
void main() {
  setUpAll(tzdata.initializeTimeZones);

  test('a timed appointment keeps the instant the keeper entered', () {
    final typed = DateTime(2026, 8, 29, 10, 0);
    final written = calendarMoment(typed, allDay: false);
    expect(written.millisecondsSinceEpoch, typed.millisecondsSinceEpoch);
  });

  test('an all-day appointment is UTC midnight of its day', () {
    final written = calendarMoment(DateTime(2026, 8, 29), allDay: true);
    expect(written.isUtc, isTrue);
    expect((written.year, written.month, written.day, written.hour),
        (2026, 8, 29, 0));
  });
}
