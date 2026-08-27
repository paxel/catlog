import 'package:catalog_core/catalog_core.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(useSystemSqlite);

  late CatalogStore a, b;

  setUp(() {
    a = CatalogStore.inMemory()..author = 'anna';
    b = CatalogStore.inMemory()..author = 'ben';
  });

  tearDown(() {
    a.close();
    b.close();
  });

  Appointment draft(String cat,
          {DateTime? date, ({int hour, int minute})? time}) =>
      Appointment(
        id: '',
        entity: cat,
        date: date ?? DateTime(2026, 9, 3),
        time: time,
        title: 'Vet',
        notes: 'bring the blood-test form',
      );

  test('an appointment round-trips with date, time, notes and alert', () {
    final cat = a.createCat('Miezi');
    final made = a.createAppointment(draft(cat, time: (hour: 14, minute: 30)));
    final open = a.appointmentsOf(cat);
    expect(open, hasLength(1));
    final got = open.single;
    expect(got.id, made.id);
    expect(got.title, 'Vet');
    expect(got.notes, 'bring the blood-test form');
    expect(got.time, (hour: 14, minute: 30));
    expect(got.allDay, isFalse);
    expect(got.start, DateTime(2026, 9, 3, 14, 30));
    expect(got.alert, AppointmentAlert.dayBefore);
  });

  test('several appointments per cat, earliest first', () {
    final cat = a.createCat('Miezi');
    a.createAppointment(draft(cat, date: DateTime(2026, 9, 10)));
    a.createAppointment(draft(cat, date: DateTime(2026, 9, 3)));
    a.createAppointment(
        draft(cat, date: DateTime(2026, 9, 3), time: (hour: 9, minute: 0)));
    final open = a.appointmentsOf(cat);
    expect(open, hasLength(3));
    expect(open.map((x) => x.start.day).toList(), [3, 3, 10]);
    expect(open.first.allDay, isTrue);
  });

  test('editing writes the new state, the old one stays in history', () {
    final cat = a.createCat('Miezi');
    final made = a.createAppointment(draft(cat));
    a.updateAppointment(made
        .copyWith(date: DateTime(2026, 9, 5), time: (hour: 10, minute: 15)));
    final got = a.appointmentsOf(cat).single;
    expect(got.start, DateTime(2026, 9, 5, 10, 15));
    expect(a.fieldHistory(cat, made.key), hasLength(2));
  });

  test('finishing closes it, keeps the outcome and writes the linked value',
      () {
    final cat = a.createCat('Miezi');
    final made = a.createAppointment(Appointment(
      id: '',
      entity: cat,
      date: DateTime(2026, 9, 3),
      title: 'Vaccination',
      linkedField: 'f:vaccine',
      linkedValue: 'rabies 2026',
    ));
    a.finishAppointment(made, notes: 'all fine, next in a year');
    expect(a.appointmentsOf(cat), isEmpty);
    final closed = a.appointmentsOf(cat, includeDone: true).single;
    expect(closed.done, isTrue);
    expect(closed.notes, 'all fine, next in a year');
    expect(a.current(cat, 'f:vaccine'), 'rabies 2026');
  });

  test('deleting removes it from every list', () {
    final cat = a.createCat('Miezi');
    final made = a.createAppointment(draft(cat));
    a.deleteAppointment(made);
    expect(a.appointmentsOf(cat, includeDone: true), isEmpty);
  });

  test('open appointments across the catalog, cats and clowders mixed', () {
    final cat = a.createCat('Miezi');
    final home = a.createClowder('Hof');
    a.createAppointment(draft(cat, date: DateTime(2026, 9, 10)));
    a.createAppointment(draft(home, date: DateTime(2026, 9, 4)));
    final all = a.openAppointments();
    expect(all.map((x) => x.entity).toList(), [home, cat]);
  });

  test('appointments sync as ordinary entries', () {
    final cat = a.createCat('Miezi');
    a.createAppointment(draft(cat, time: (hour: 14, minute: 30)));
    b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
    expect(b.appointmentsOf(cat).single.title, 'Vet');
  });

  test('a merged cat keeps the appointments of both', () {
    final keep = a.createCat('Keep');
    final lose = a.createCat('Lose');
    a.createAppointment(draft(keep, date: DateTime(2026, 9, 3)));
    a.createAppointment(draft(lose, date: DateTime(2026, 9, 4)));
    a.mergeCat(lose, keep);
    expect(a.appointmentsOf(keep), hasLength(2));
    expect(a.openAppointments(), hasLength(2));
  });

  test('a garbled document is ignored, not thrown', () {
    final cat = a.createCat('Miezi');
    a.append(cat, Keys.appointment('x'), 'not json');
    expect(a.appointmentsOf(cat), isEmpty);
  });

  group('vet run with several cats', () {
    late String hugo, rudi, minka;

    setUp(() {
      hugo = a.createCat('Hugo');
      rudi = a.createCat('Rudi');
      minka = a.createCat('Minka');
    });

    test('one draft becomes one appointment per cat, sharing a group', () {
      final made = a.createAppointments(draft(hugo), [hugo, rudi, minka]);
      expect(made, hasLength(3));
      expect(made.map((m) => m.group).toSet(), hasLength(1));
      expect(made.first.group, isNotNull);
      expect(a.appointmentsOf(rudi).single.group, made.first.group);
      expect(a.groupOf(made.first).map((m) => m.entity),
          containsAll([hugo, rudi, minka]));
    });

    test('a single entity gets no group', () {
      final made = a.createAppointments(draft(hugo), [hugo]);
      expect(made.single.group, isNull);
      expect(a.groupOf(made.single), hasLength(1));
      expect(a.openAppointmentGroups().single, hasLength(1));
    });

    test('the agenda folds a group into one list, earliest first', () {
      a.createAppointments(
          draft(hugo, date: DateTime(2026, 9, 10)), [hugo, rudi]);
      a.createAppointment(draft(minka, date: DateTime(2026, 9, 3)));
      final groups = a.openAppointmentGroups();
      expect(groups, hasLength(2));
      expect(groups.first.single.entity, minka);
      expect(groups.last.map((m) => m.entity), containsAll([hugo, rudi]));
    });

    test('editing one member moves the whole run', () {
      final made = a.createAppointments(draft(hugo), [hugo, rudi]);
      a.updateAppointmentGroup(made.first.copyWith(
          date: DateTime(2026, 9, 5),
          time: (hour: 8, minute: 0),
          title: 'Neutering'));
      for (final cat in [hugo, rudi]) {
        final got = a.appointmentsOf(cat).single;
        expect(got.start, DateTime(2026, 9, 5, 8, 0));
        expect(got.title, 'Neutering');
        expect(got.group, made.first.group);
      }
    });

    test('finishing some leaves the others open on their own', () {
      final made = a.createAppointments(
          Appointment(
              id: '',
              entity: hugo,
              date: DateTime(2026, 9, 3),
              title: 'Neutering',
              linkedField: 'f:neutered',
              linkedValue: 'yes'),
          [hugo, rudi, minka]);
      final members = a.groupOf(made.first);
      a.finishAppointments(members.where((m) => m.entity != rudi),
          notes: 'both fine');
      expect(a.current(hugo, 'f:neutered'), 'yes');
      expect(a.current(minka, 'f:neutered'), 'yes');
      expect(a.current(rudi, 'f:neutered'), isNull);
      expect(a.appointmentsOf(hugo), isEmpty);
      expect(a.appointmentsOf(rudi).single.group, made.first.group);
      expect(a.openAppointmentGroups().single.single.entity, rudi);
      expect(
          a.appointmentsOf(hugo, includeDone: true).single.notes, 'both fine');
    });

    test('a cat can be added later, even to a lone appointment', () {
      final lone = a.createAppointment(draft(hugo));
      a.addToAppointmentGroup(lone, [rudi]);
      final hugoNow = a.appointmentsOf(hugo).single;
      expect(hugoNow.group, isNotNull);
      expect(a.appointmentsOf(rudi).single.group, hugoNow.group);
      expect(a.groupOf(hugoNow), hasLength(2));
    });

    test('deleting the run deletes every member', () {
      final made = a.createAppointments(draft(hugo), [hugo, rudi]);
      a.deleteAppointmentGroup(made.first);
      expect(a.openAppointments(), isEmpty);
    });

    test('leaving one cat out deletes only its own', () {
      final made = a.createAppointments(draft(hugo), [hugo, rudi]);
      a.deleteAppointment(made.firstWhere((m) => m.entity == rudi));
      expect(a.groupOf(made.first).map((m) => m.entity), [hugo]);
    });

    test('two merged members show once', () {
      final made = a.createAppointments(draft(hugo), [hugo, rudi, minka]);
      a.mergeCat(rudi, hugo);
      final groups = a.openAppointmentGroups();
      expect(groups.single.map((m) => m.entity).toSet(), {hugo, minka});
      expect(a.groupOf(made.first), hasLength(2));
    });

    test('groups sync as ordinary entries', () {
      a.createAppointments(draft(hugo), [hugo, rudi]);
      b.applyEntries(a.entriesSince(const {}), senderVector: a.versionVector());
      expect(b.openAppointmentGroups().single, hasLength(2));
    });
  });
}
