import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n.dart';

/// Why a starter field value is implausible; [other] carries the
/// conflicting date where the rule compares two fields.
enum ObjectionKind {
  birthdateInFuture,
  deceasedInFuture,
  deceasedBeforeBirth,
  bornAfterDeceased,
  malePregnant,
}

typedef Objection = ({ObjectionKind kind, DateTime? other});

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
        return (kind: ObjectionKind.birthdateInFuture, other: null);
      }
      final died = _date(store.current(entityId, Keys.userField('deceased')));
      if (died != null && born.isAfter(died)) {
        return (kind: ObjectionKind.bornAfterDeceased, other: died);
      }
    case 'deceased':
      final died = _date(value);
      if (died == null) return null;
      if (died.isAfter(limit)) {
        return (kind: ObjectionKind.deceasedInFuture, other: null);
      }
      final born = _date(store.current(entityId, Keys.userField('birthdate')));
      if (born != null && died.isBefore(born)) {
        return (kind: ObjectionKind.deceasedBeforeBirth, other: born);
      }
    case 'pregnant':
      if (value == 'yes' &&
          store.current(entityId, Keys.userField('gender')) == 'male') {
        return (kind: ObjectionKind.malePregnant, other: null);
      }
  }
  return null;
}

String objectionText(BuildContext context, Objection objection) {
  final t = context.t;
  String d(DateTime date) =>
      DateFormat.yMd(Localizations.localeOf(context).toString()).format(date);
  return switch (objection.kind) {
    ObjectionKind.birthdateInFuture => t.birthdateInFuture,
    ObjectionKind.deceasedInFuture => t.deceasedInFuture,
    ObjectionKind.deceasedBeforeBirth =>
      t.deceasedBeforeBirth(d(objection.other!)),
    ObjectionKind.bornAfterDeceased =>
      t.bornAfterDeceased(d(objection.other!)),
    ObjectionKind.malePregnant => t.malePregnant,
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
