import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n.dart';
import 'name_proposals.dart';
import 'pet_mode.dart';
import 'widgets/date_entry.dart';
import 'package:catalog_core/catalog_core.dart';
import 'field_labels.dart';

class NameAndDate {
  final String name;
  final DateTime date;

  /// The species chosen in pet mode; null when the dialog did not ask.
  final String? species;
  const NameAndDate(this.name, this.date, {this.species});
}

/// Name plus an "as of" date — so a clowder that has existed for ten
/// years, or a cat that moved in long ago, carries its real date from
/// the start instead of today's.
Future<NameAndDate?> askNameAndDate(BuildContext context, String title,
    {Future<String?> Function()? propose, String? species}) {
  return showDialog<NameAndDate>(
    context: context,
    builder: (context) =>
        _NameDateDialog(title: title, propose: propose, species: species),
  );
}

/// Asks for a new animal and creates it: name, "as of" date and — in
/// pet mode — the species, offered from the one picked last on this
/// device and remembered for the next time (#94). Returns the new id,
/// or null when the keeper backed out.
Future<String?> createAnimal(BuildContext context, CatalogStore store,
    {required String title, String? clowderId}) async {
  final locale = Localizations.localeOf(context);
  final result = await askNameAndDate(
    context,
    title,
    propose: () => proposeCatName(store, locale),
    species: petMode.value ? (store.localSetting(lastSpeciesKey) ?? 'cat') : null,
  );
  if (result == null) return null;
  final species = result.species ?? 'cat';
  if (result.species != null) store.setLocalSetting(lastSpeciesKey, species);
  return store.createCat(result.name,
      clowderId: clowderId, date: result.date, species: species);
}

class _NameDateDialog extends StatefulWidget {
  final String title;

  /// When set, prefills the name with a proposal; the dice rerolls.
  final Future<String?> Function()? propose;

  /// Preselected species; non-null makes the dialog ask for one (#94).
  final String? species;

  const _NameDateDialog({required this.title, this.propose, this.species});

  @override
  State<_NameDateDialog> createState() => _NameDateDialogState();
}

class _NameDateDialogState extends State<_NameDateDialog> {
  final _name = TextEditingController();
  late final _ownSpecies = TextEditingController(
      text: widget.species != null && !speciesPresets.contains(widget.species)
          ? widget.species
          : '');
  DateTime _asOf = DateTime.now();

  /// A preset, or '' for "own" (typed below).
  late String? _species = widget.species == null
      ? null
      : speciesPresets.contains(widget.species)
          ? widget.species
          : '';

  /// The species to store: the preset, or what was typed for "own".
  String? get _chosenSpecies {
    if (widget.species == null) return null;
    if (_species == '') {
      final own = _ownSpecies.text.trim();
      return own.isEmpty ? 'cat' : own;
    }
    return _species;
  }

  @override
  void initState() {
    super.initState();
    if (widget.propose != null) _reroll();
  }

  Future<void> _reroll() async {
    final name = await widget.propose!();
    if (name == null || !mounted) return;
    _name.text = name;
    // Selected, so typing replaces the proposal without extra taps.
    _name.selection =
        TextSelection(baseOffset: 0, extentOffset: name.length);
  }

  @override
  void dispose() {
    _name.dispose();
    _ownSpecies.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context)
        .pop(NameAndDate(name, _asOf, species: _chosenSpecies));
  }

  @override
  Widget build(BuildContext context) {
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return AlertDialog(
      title: Text(widget.title),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: _name,
          autofocus: true,
          decoration: InputDecoration(
            labelText: context.t.name,
            suffixIcon: widget.propose == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.casino_outlined),
                    tooltip: context.t.proposeAnotherName,
                    onPressed: _reroll,
                  ),
          ),
          onSubmitted: (_) => _submit(),
        ),
        if (widget.species != null) ...[
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _species,
            decoration: InputDecoration(labelText: context.t.starterSpecies),
            items: [
              for (final s in speciesPresets)
                DropdownMenuItem(
                    value: s, child: Text(speciesDisplay(context.t, s))),
              DropdownMenuItem(value: '', child: Text(context.t.ownValue)),
            ],
            onChanged: (v) => setState(() => _species = v),
          ),
          if (_species == '')
            TextField(
              controller: _ownSpecies,
              decoration: InputDecoration(labelText: context.t.ownValue),
            ),
        ],
        const SizedBox(height: 8),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.event),
          title: Text(sameDay
              ? context.t.asOfToday
              : context.t.asOfDate(DateFormat.yMd(
                      Localizations.localeOf(context).toString())
                  .format(_asOf))),
          trailing: const Icon(Icons.edit_calendar_outlined),
          onTap: () async {
            final picked = await pickDay(
              context,
              initial: _asOf,
              lastDate: DateTime.now().add(const Duration(days: 1)),
            );
            if (!mounted) return;
            if (picked != null) setState(() => _asOf = picked);
          },
        ),
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(context.t.create)),
      ],
    );
  }
}

/// Just the "as of" date, defaulting to today — used when moving a cat,
/// so historic moves land on their real date.
Future<DateTime?> askAsOfDate(BuildContext context, String title) {
  return showDialog<DateTime>(
    context: context,
    builder: (context) => _AsOfDialog(title: title),
  );
}

class _AsOfDialog extends StatefulWidget {
  final String title;
  const _AsOfDialog({required this.title});

  @override
  State<_AsOfDialog> createState() => _AsOfDialogState();
}

class _AsOfDialogState extends State<_AsOfDialog> {
  DateTime _asOf = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final sameDay = DateUtils.isSameDay(_asOf, DateTime.now());
    return AlertDialog(
      title: Text(widget.title),
      content: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.event),
        title: Text(sameDay
            ? context.t.asOfToday
            : context.t.asOfDate(DateFormat.yMd(
                    Localizations.localeOf(context).toString())
                .format(_asOf))),
        trailing: const Icon(Icons.edit_calendar_outlined),
        onTap: () async {
          final picked = await pickDay(
            context,
            initial: _asOf,
            lastDate: DateTime.now().add(const Duration(days: 1)),
          );
          if (!mounted) return;
          if (picked != null) setState(() => _asOf = picked);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_asOf),
          child: Text(context.t.save),
        ),
      ],
    );
  }
}
