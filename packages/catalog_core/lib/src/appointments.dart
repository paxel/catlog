import 'dart:convert';

import 'fields.dart';
import 'store.dart';

/// When the phone's calendar should ping for an appointment.
enum AppointmentAlert { none, dayBefore, hourBefore }

/// A timed visit on a cat or clowder (#75): what the keeper leaves the
/// vet's desk with. Stored as one `$appt:<id>` entry per appointment
/// whose value is [toJson]; edits, finishing and deletion are later
/// entries on the same key, so it syncs, reverts and merges like any
/// value. Distinct from a reminder, which is a field's value due on a
/// day.
class Appointment {
  final String id;
  final String entity;

  /// The day; with [time] the exact moment, else all day.
  final DateTime date;
  final ({int hour, int minute})? time;
  final String title;
  final String notes;

  /// A field whose value is written when the appointment is done.
  final String? linkedField;
  final String? linkedValue;
  final AppointmentAlert alert;
  final bool done;

  /// Shared by the appointments of one vet run with several cats: each
  /// cat keeps its own entry, the group id folds them into one card and
  /// one calendar event, and edits fan out over the members. Null for
  /// an appointment that stands alone.
  final String? group;

  /// Keys this version does not know, carried through unchanged: an
  /// older app editing a newer appointment must not strip what a newer
  /// one wrote — exactly what happened to `group` before it existed.
  final Map<String, dynamic> extra;

  const Appointment({
    required this.id,
    required this.entity,
    required this.date,
    this.time,
    required this.title,
    this.notes = '',
    this.linkedField,
    this.linkedValue,
    this.alert = AppointmentAlert.dayBefore,
    this.done = false,
    this.group,
    this.extra = const {},
  });

  String get key => Keys.appointment(id);

  bool get allDay => time == null;

  /// The moment it starts, local time; midnight for all-day ones.
  DateTime get start => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  Appointment copyWith({
    DateTime? date,
    ({int hour, int minute})? time,
    bool clearTime = false,
    String? title,
    String? notes,
    String? linkedField,
    String? linkedValue,
    bool clearLink = false,
    AppointmentAlert? alert,
    bool? done,
    String? group,
  }) =>
      Appointment(
        id: id,
        entity: entity,
        group: group ?? this.group,
        extra: extra,
        date: date ?? this.date,
        time: clearTime ? null : (time ?? this.time),
        title: title ?? this.title,
        notes: notes ?? this.notes,
        linkedField: clearLink ? null : (linkedField ?? this.linkedField),
        linkedValue: clearLink ? null : (linkedValue ?? this.linkedValue),
        alert: alert ?? this.alert,
        done: done ?? this.done,
      );

  static const _known = {
    'date',
    'time',
    'title',
    'notes',
    'field',
    'value',
    'alert',
    'done',
    'group',
  };

  Map<String, dynamic> toJson() => {
        ...extra,
        'date': '${date.year.toString().padLeft(4, '0')}-'
            '${date.month.toString().padLeft(2, '0')}-'
            '${date.day.toString().padLeft(2, '0')}',
        if (time != null)
          'time': '${time!.hour.toString().padLeft(2, '0')}:'
              '${time!.minute.toString().padLeft(2, '0')}',
        'title': title,
        if (notes.isNotEmpty) 'notes': notes,
        if (linkedField != null) 'field': linkedField,
        if (linkedValue != null) 'value': linkedValue,
        'alert': alert.name,
        if (done) 'done': true,
        if (group != null) 'group': group,
      };

  /// Parses a stored value; null when it is not an appointment document
  /// (an older version wrote nothing of the kind, but the log is open).
  static Appointment? fromJson(String id, String entity, String? raw) {
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final date = DateTime.parse(json['date'] as String);
      ({int hour, int minute})? time;
      final t = json['time'] as String?;
      if (t != null) {
        final parts = t.split(':');
        time = (hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }
      return Appointment(
        id: id,
        entity: entity,
        date: DateTime(date.year, date.month, date.day),
        time: time,
        title: json['title'] as String? ?? '',
        notes: json['notes'] as String? ?? '',
        linkedField: json['field'] as String?,
        linkedValue: json['value'] as String?,
        alert: AppointmentAlert.values.firstWhere(
            (a) => a.name == json['alert'],
            orElse: () => AppointmentAlert.dayBefore),
        done: json['done'] == true,
        group: json['group'] as String?,
        extra: {
          for (final e in json.entries)
            if (!_known.contains(e.key)) e.key: e.value,
        },
      );
    } catch (_) {
      return null;
    }
  }
}

/// Appointments live in the ordinary entry log; these are the readers
/// and writers around it.
extension Appointments on CatalogStore {
  /// Records a new appointment and returns it (with its fresh id).
  Appointment createAppointment(Appointment draft, {DateTime? date}) {
    final id = newAppointmentId();
    final made = Appointment(
      id: id,
      entity: draft.entity,
      date: draft.date,
      time: draft.time,
      title: draft.title,
      notes: draft.notes,
      linkedField: draft.linkedField,
      linkedValue: draft.linkedValue,
      alert: draft.alert,
      done: draft.done,
      group: draft.group,
      extra: draft.extra,
    );
    append(made.entity, made.key, jsonEncode(made.toJson()), date: date);
    return made;
  }

  /// One vet run, several cats: the draft becomes one appointment per
  /// entity, all sharing a fresh group id. A single entity gets a plain
  /// appointment without a group — nothing to fold.
  List<Appointment> createAppointments(Appointment draft, List<String> entities,
      {DateTime? date}) {
    final group = entities.length > 1 ? newAppointmentId() : null;
    return [
      for (final entity in entities)
        createAppointment(
            Appointment(
              id: '',
              entity: entity,
              date: draft.date,
              time: draft.time,
              title: draft.title,
              notes: draft.notes,
              linkedField: draft.linkedField,
              linkedValue: draft.linkedValue,
              alert: draft.alert,
              group: group,
            ),
            date: date),
    ];
  }

  /// The open members of [a]'s group, [a] included, one per entity —
  /// a Merge of two members leaves one canonical entity, shown once.
  /// An appointment without a group is a group of one.
  List<Appointment> groupOf(Appointment a) {
    if (a.group == null) return [a];
    final seen = <String>{};
    return [
      for (final m in openAppointments())
        if (m.group == a.group && seen.add(m.entity)) m
    ];
  }

  /// Writes [a]'s date, time, title, notes, link and alert onto every
  /// member of its group — the whole vet run moves, never one cat.
  void updateAppointmentGroup(Appointment a, {DateTime? date}) {
    for (final m in groupOf(a)) {
      updateAppointment(
          m.copyWith(
            date: a.date,
            time: a.time,
            clearTime: a.time == null,
            title: a.title,
            notes: a.notes,
            linkedField: a.linkedField,
            linkedValue: a.linkedValue,
            clearLink: a.linkedField == null,
            alert: a.alert,
          ),
          date: date);
    }
  }

  /// Adds entities to an existing group. A lone appointment becomes a
  /// group of itself plus the newcomers.
  List<Appointment> addToAppointmentGroup(Appointment a, List<String> entities,
      {DateTime? date}) {
    var group = a.group;
    if (group == null) {
      group = newAppointmentId();
      updateAppointment(a.copyWith(group: group), date: date);
    }
    return [
      for (final entity in entities)
        createAppointment(
            Appointment(
              id: '',
              entity: entity,
              date: a.date,
              time: a.time,
              title: a.title,
              notes: a.notes,
              linkedField: a.linkedField,
              linkedValue: a.linkedValue,
              alert: a.alert,
              group: group,
            ),
            date: date),
    ];
  }

  /// Finishes the given members with shared outcome notes; the ones not
  /// listed stay open on their own.
  void finishAppointments(Iterable<Appointment> members,
      {String? notes, DateTime? date}) {
    for (final m in members) {
      finishAppointment(m, notes: notes, date: date);
    }
  }

  /// Deletes every open member of [a]'s group.
  void deleteAppointmentGroup(Appointment a, {DateTime? date}) {
    for (final m in groupOf(a)) {
      deleteAppointment(m, date: date);
    }
  }

  /// Every open appointment folded by group, earliest first: one list
  /// per vet run, a list of one for the rest.
  List<List<Appointment>> openAppointmentGroups() {
    final groups = <String, List<Appointment>>{};
    final seenEntity = <String, Set<String>>{};
    for (final a in openAppointments()) {
      final key = a.group ?? a.id;
      if (!(seenEntity[key] ??= {}).add(a.entity)) continue;
      (groups[key] ??= []).add(a);
    }
    final result = groups.values.toList();
    result.sort((x, y) => x.first.start.compareTo(y.first.start));
    return result;
  }

  /// Writes the appointment's current state as a new entry.
  void updateAppointment(Appointment a, {DateTime? date}) =>
      append(a.entity, a.key, jsonEncode(a.toJson()), date: date);

  /// Finishes an appointment: notes may carry the outcome; a linked
  /// field receives its value.
  void finishAppointment(Appointment a, {String? notes, DateTime? date}) {
    final closed = a.copyWith(notes: notes ?? a.notes, done: true);
    updateAppointment(closed, date: date);
    if (closed.linkedField != null) {
      append(closed.entity, closed.linkedField!, closed.linkedValue,
          date: date);
    }
  }

  /// Deletes an appointment — a cleared value, like any field.
  void deleteAppointment(Appointment a, {DateTime? date}) =>
      append(a.entity, a.key, null, date: date);

  /// The appointments of one entity, open ones unless [includeDone].
  List<Appointment> appointmentsOf(String entity, {bool includeDone = false}) {
    final canonical = resolveEntity(entity);
    final result = <Appointment>[];
    for (final MapEntry(:key, :value) in currentFields(canonical).entries) {
      if (!key.startsWith(Keys.appointmentPrefix)) continue;
      final a = Appointment.fromJson(
          key.substring(Keys.appointmentPrefix.length), canonical, value);
      if (a == null) continue;
      if (a.done && !includeDone) continue;
      result.add(a);
    }
    result.sort((x, y) => x.start.compareTo(y.start));
    return result;
  }

  /// Every open appointment in the catalog, earliest first.
  List<Appointment> openAppointments() {
    final result = <Appointment>[
      for (final e in [...cats(), ...clowders()]) ...appointmentsOf(e.id),
    ];
    result.sort((x, y) => x.start.compareTo(y.start));
    return result;
  }
}
