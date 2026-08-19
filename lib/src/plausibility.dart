import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n.dart';

/// Why a starter field value is implausible.
enum ObjectionKind {
  birthdateInFuture,
  deceasedInFuture,
  deceasedBeforeBirth,
  bornAfterDeceased,
  malePregnant,
  fatherNotMale,
  motherNotFemale,
  parentBornAfterKitten,
  genderFatherFemale,
  genderMotherMale,
}

class Objection {
  final ObjectionKind kind;

  /// The conflicting date, where the rule compares two dates.
  final DateTime? date;

  /// The other cat's name, where the rule involves a second cat.
  final String? name;

  const Objection(this.kind, {this.date, this.name});
}

DateTime? _date(String? value) =>
    value == null || value.isEmpty ? null : DateTime.tryParse(value);

/// Plausibility check for starter fields — the app knows what those
/// mean, so it refuses the impossible. Custom fields carry no known
/// semantics and are never checked. Clearing a value is always fine.
Objection? starterFieldObjection(
    CatalogStore store, String entityId, FieldDef def, String? value,
    {DateTime? today}) {
  if (value == null || value.isEmpty) return null;
  final limit = DateUtils.dateOnly(today ?? DateTime.now());
  switch (def.slug) {
    case 'birthdate':
      final born = _date(value);
      if (born == null) return null;
      if (born.isAfter(limit)) {
        return const Objection(ObjectionKind.birthdateInFuture);
      }
      final died = _date(store.current(entityId, Keys.userField('deceased')));
      if (died != null && born.isAfter(died)) {
        return Objection(ObjectionKind.bornAfterDeceased, date: died);
      }
    case 'deceased':
      final died = _date(value);
      if (died == null) return null;
      if (died.isAfter(limit)) {
        return const Objection(ObjectionKind.deceasedInFuture);
      }
      final born = _date(store.current(entityId, Keys.userField('birthdate')));
      if (born != null && died.isBefore(born)) {
        return Objection(ObjectionKind.deceasedBeforeBirth, date: born);
      }
    case 'pregnant':
      if (value == 'yes' &&
          store.current(entityId, Keys.userField('gender')) == 'male') {
        return const Objection(ObjectionKind.malePregnant);
      }
    case 'father':
      return _parentObjection(store, entityId, value,
          wrongGender: 'female',
          objection: ObjectionKind.fatherNotMale);
    case 'mother':
      return _parentObjection(store, entityId, value,
          wrongGender: 'male',
          objection: ObjectionKind.motherNotFemale);
    case 'gender':
      // The reverse guard: a recorded parent role pins the plausible
      // gender — refusing here explains WHY instead of corrupting later.
      if (value == 'female' && _hasKittensAs(store, entityId, 'father')) {
        return const Objection(ObjectionKind.genderFatherFemale);
      }
      if (value == 'male' && _hasKittensAs(store, entityId, 'mother')) {
        return const Objection(ObjectionKind.genderMotherMale);
      }
  }
  return null;
}

/// Father must not be female, mother must not be male, and no parent is
/// born on or after its kitten's birth date.
Objection? _parentObjection(
    CatalogStore store, String kittenId, String parentValue,
    {required String wrongGender, required ObjectionKind objection}) {
  final parent = store.resolveEntity(parentValue);
  final parentName = store.current(parent, Keys.name) ?? '?';
  if (store.current(parent, Keys.userField('gender')) == wrongGender) {
    return Objection(objection, name: parentName);
  }
  final parentBorn =
      _date(store.current(parent, Keys.userField('birthdate')));
  final kittenBorn =
      _date(store.current(kittenId, Keys.userField('birthdate')));
  if (parentBorn != null &&
      kittenBorn != null &&
      !parentBorn.isBefore(kittenBorn)) {
    return Objection(ObjectionKind.parentBornAfterKitten,
        date: parentBorn, name: parentName);
  }
  return null;
}

bool _hasKittensAs(CatalogStore store, String entityId, String role) {
  final id = store.resolveEntity(entityId);
  for (final cat in store.cats()) {
    final parent = store.current(cat.id, Keys.userField(role));
    if (parent != null && store.resolveEntity(parent) == id) return true;
  }
  return false;
}

String objectionText(BuildContext context, Objection objection) {
  final t = context.t;
  String d(DateTime date) =>
      DateFormat.yMd(Localizations.localeOf(context).toString()).format(date);
  return switch (objection.kind) {
    ObjectionKind.birthdateInFuture => t.birthdateInFuture,
    ObjectionKind.deceasedInFuture => t.deceasedInFuture,
    ObjectionKind.deceasedBeforeBirth =>
      t.deceasedBeforeBirth(d(objection.date!)),
    ObjectionKind.bornAfterDeceased =>
      t.bornAfterDeceased(d(objection.date!)),
    ObjectionKind.malePregnant => t.malePregnant,
    ObjectionKind.fatherNotMale => t.fatherNotMale(objection.name!),
    ObjectionKind.motherNotFemale => t.motherNotFemale(objection.name!),
    ObjectionKind.parentBornAfterKitten =>
      t.parentBornAfterKitten(objection.name!, d(objection.date!)),
    ObjectionKind.genderFatherFemale => t.genderFatherFemale,
    ObjectionKind.genderMotherMale => t.genderMotherMale,
  };
}

/// Explains why the value was not saved. Refusals always carry the
/// reason — that is the house law for error cases.
Future<void> explainObjection(BuildContext context, Objection objection) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.t.notSaved),
      content: Text(objectionText(context, objection)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.ok),
        ),
      ],
    ),
  );
}
