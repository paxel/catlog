import 'package:catalog_core/catalog_core.dart';

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;

import 'flier_ocr.dart';

/// Targets a flier line can fill that are not catalog Fields: the
/// wizard's own inputs. Everything else names a Field by slug.
abstract final class FlierTarget {
  static const name = 'name';
  static const registryNumber = 'registryNumber';
  static const missingSince = 'missingSince';
  static const lostPlace = 'lostPlace';

  /// Registry hotline, mail, website — never the owner's contact.
  static const contact = 'contact';

  /// Free text: goes to remarks.
  static const remarks = 'remarks';

  /// Not stored anywhere — a hotline, a heading, a value already in a
  /// field (#77).
  static const drop = 'drop';

  static const wizard = {name, registryNumber, missingSince, lostPlace};
}

/// A label with the value printed next to it — or a lone line when
/// nothing sits beside it ([label] null).
class FlierPair {
  final String? label;
  final String value;

  const FlierPair(this.label, this.value);

  @override
  String toString() => label == null ? value : '$label: $value';

  @override
  bool operator ==(Object other) =>
      other is FlierPair && other.label == label && other.value == value;

  @override
  int get hashCode => Object.hash(label, value);
}

/// Pairs each line with the line printed beside it, by height: a
/// label in the left column and its value in the right one overlap
/// vertically. Long lines are body text, never labels.
List<FlierPair> pairLines(List<FlierLine> lines) {
  final sorted = [...lines]..sort((a, b) => a.box.top.compareTo(b.box.top));
  final used = <FlierLine>{};
  final pairs = <FlierPair>[];
  for (final line in sorted) {
    if (used.contains(line)) continue;
    used.add(line);
    FlierLine? partner;
    var gap = double.infinity;
    if (line.text.split(RegExp(r'\s+')).length <= 5) {
      for (final other in sorted) {
        if (used.contains(other)) continue;
        if (other.box.left < line.box.right - line.box.height / 2) continue;
        final overlap =
            min(line.box.bottom, other.box.bottom) -
            max(line.box.top, other.box.top);
        if (overlap < min(line.box.height, other.box.height) / 2) continue;
        final distance = other.box.left - line.box.right;
        if (distance < gap) {
          gap = distance;
          partner = other;
        }
      }
    }
    if (partner == null) {
      pairs.add(FlierPair(null, line.text));
    } else {
      used.add(partner);
      pairs.add(FlierPair(line.text, partner.text));
    }
  }
  return pairs;
}

/// How one registry prints its posters: which labels stand for which
/// target, how the name line reads, and which lines are the registry's
/// own contact. Shipped as data (assets/fliers/templates.json) so a
/// changed layout or a new registry is a file edit, not code.
class FlierTemplate {
  final String name;

  /// The registry preset the number belongs to, e.g. "Tasso".
  final String registry;

  /// Target → label synonyms, any language.
  final Map<String, List<String>> labels;

  /// Two groups: a prefix word (Kater, Katze, …) and the name.
  final RegExp? namePattern;

  /// Substrings marking the registry's own contact lines.
  final List<String> contact;

  const FlierTemplate({
    required this.name,
    required this.registry,
    required this.labels,
    this.namePattern,
    this.contact = const [],
  });

  /// The target a printed label stands for, or null.
  String? targetOf(String label) {
    final wanted = _fold(label);
    for (final entry in labels.entries) {
      for (final synonym in entry.value) {
        if (_fold(synonym) == wanted) return entry.key;
      }
    }
    return null;
  }

  bool isContact(String text) {
    final folded = _fold(text);
    return contact.any((c) => folded.contains(_fold(c)));
  }
}

/// The shipped templates plus the shared word lists that turn printed
/// values into Field options (männlich → male) for every template.
class FlierTemplateSet {
  final List<FlierTemplate> templates;

  /// Field slug → option → synonyms.
  final Map<String, Map<String, List<String>>> values;

  const FlierTemplateSet(this.templates, this.values);

  static const empty = FlierTemplateSet([], {});

  factory FlierTemplateSet.fromJson(String source) {
    final json = jsonDecode(source) as Map<String, dynamic>;
    return FlierTemplateSet(
      [
        for (final t in (json['templates'] as List? ?? const []))
          FlierTemplate(
            name: t['name'] as String,
            registry: t['registry'] as String,
            labels: {
              for (final e in (t['labels'] as Map<String, dynamic>).entries)
                e.key: [for (final s in e.value as List) s as String],
            },
            namePattern: t['namePattern'] == null
                ? null
                : RegExp(t['namePattern'] as String, caseSensitive: false),
            contact: [
              for (final c in (t['contact'] as List? ?? const [])) c as String,
            ],
          ),
      ],
      {
        for (final f
            in ((json['values'] as Map<String, dynamic>?) ?? const {}).entries)
          f.key: {
            for (final o in (f.value as Map<String, dynamic>).entries)
              o.key: [for (final s in o.value as List) s as String],
          },
      },
    );
  }

  /// The shipped file. Loaded once per wizard; a broken asset is a
  /// build error, not a runtime one.
  static Future<FlierTemplateSet> load() async => FlierTemplateSet.fromJson(
    await rootBundle.loadString('assets/fliers/templates.json'),
  );

  /// The option [raw] stands for in Field [slug], or [raw] itself when
  /// no word list knows it. Longest synonym wins, so "nicht kastriert"
  /// beats "kastriert".
  String normalize(String slug, String raw) {
    final options = values[slug];
    if (options == null) return raw;
    final folded = _fold(raw);
    String? best;
    var bestLength = 0;
    for (final option in options.entries) {
      for (final synonym in option.value) {
        final s = _fold(synonym);
        if (s.length <= bestLength) continue;
        if (folded == s || _containsWord(folded, s)) {
          best = option.key;
          bestLength = s.length;
        }
      }
    }
    return best ?? raw;
  }

  /// True when some word list of [slug] knows [raw].
  bool knows(String slug, String raw) =>
      values.containsKey(slug) && normalize(slug, raw) != raw;

  /// The template whose labels appear most on the poster, or null
  /// when fewer than two do — then the layout is unknown.
  FlierTemplate? match(List<FlierPair> pairs) {
    FlierTemplate? best;
    var bestScore = 1;
    for (final template in templates) {
      var score = 0;
      for (final pair in pairs) {
        final label = pair.label;
        if (label == null) continue;
        for (final part in label.split(',')) {
          if (template.targetOf(part.trim()) != null) score++;
        }
      }
      if (score > bestScore) {
        bestScore = score;
        best = template;
      }
    }
    return best;
  }
}

/// One line of the poster with the target it should fill. The wizard
/// shows these for correction before anything lands in a Field.
class FlierEntry {
  final String? label;
  final String value;
  String target;

  FlierEntry({
    this.label,
    required this.value,
    this.target = FlierTarget.remarks,
  });

  @override
  String toString() => '$target <- ${label == null ? value : '$label: $value'}';
}

/// What the poster says, read through [templates]: every pair with a
/// target, composite rows ("Tierart, Geschlecht" / "Katze, männlich")
/// split into one entry per part, values turned into Field options.
class FlierReading {
  final FlierTemplate? template;
  final List<FlierEntry> entries;

  const FlierReading(this.template, this.entries);

  /// All entries that landed on [target], first first.
  Iterable<FlierEntry> of(String target) =>
      entries.where((e) => e.target == target);

  /// The first value for [target], or null.
  String? first(String target) => of(target).firstOrNull?.value;

  /// The remarks text: unassigned pairs as "Label: value", lone lines
  /// as they are. The photo keeps the rest.
  String remarks() => [
    for (final e in entries)
      if (e.target == FlierTarget.remarks || e.target == FlierTarget.contact)
        e.label == null ? e.value : '${e.label}: ${e.value}',
  ].join('\n');
}

/// Reads [pairs] with the best-matching template. Without a match every
/// entry stays remarks and the wizard asks for the fields.
FlierReading readFlier(List<FlierPair> pairs, FlierTemplateSet templates) {
  final template = templates.match(pairs);
  if (template == null) {
    return FlierReading(null, [
      for (final p in pairs) FlierEntry(label: p.label, value: p.value),
    ]);
  }
  final entries = <FlierEntry>[];
  for (final pair in pairs) {
    final label = pair.label;
    if (label == null) {
      entries.addAll(_loneLine(pair.value, template, templates));
      continue;
    }
    final labelParts = [for (final l in label.split(',')) l.trim()];
    final targets = [for (final l in labelParts) template.targetOf(l)];
    if (targets.every((t) => t == null)) {
      entries.add(
        FlierEntry(
          label: label,
          value: pair.value,
          target: template.isContact(pair.value)
              ? FlierTarget.contact
              : FlierTarget.remarks,
        ),
      );
      continue;
    }
    if (labelParts.length == 1) {
      entries.add(
        FlierEntry(
          label: label,
          value: templates.normalize(targets.first!, pair.value),
          target: targets.first!,
        ),
      );
      continue;
    }
    entries.addAll(_composite(labelParts, targets, pair.value, templates));
  }
  return FlierReading(template, entries);
}

/// A composite row: value parts zip onto label parts when the counts
/// agree; otherwise each part goes to the target whose word list
/// knows it, the rest to remarks.
List<FlierEntry> _composite(
  List<String> labelParts,
  List<String?> targets,
  String value,
  FlierTemplateSet templates,
) {
  final valueParts = [for (final v in value.split(',')) v.trim()];
  final entries = <FlierEntry>[];
  if (valueParts.length == labelParts.length) {
    for (var i = 0; i < labelParts.length; i++) {
      final target = targets[i];
      entries.add(
        FlierEntry(
          label: labelParts[i],
          value: target == null
              ? valueParts[i]
              : templates.normalize(target, valueParts[i]),
          target: target ?? FlierTarget.remarks,
        ),
      );
    }
    return entries;
  }
  final known = targets.nonNulls.toList();
  for (final part in valueParts) {
    final target = known.where((t) => templates.knows(t, part)).firstOrNull;
    entries.add(
      FlierEntry(
        label: target == null
            ? labelParts.join(', ')
            : labelParts[targets.indexOf(target)],
        value: target == null ? part : templates.normalize(target, part),
        target: target ?? FlierTarget.remarks,
      ),
    );
  }
  return entries;
}

/// A line without a label: the name line ("Kater HUGO" — name plus a
/// gender hint), a contact line, or plain text.
List<FlierEntry> _loneLine(
  String text,
  FlierTemplate template,
  FlierTemplateSet templates,
) {
  final match = template.namePattern?.firstMatch(text);
  if (match != null && match.groupCount >= 2) {
    final prefix = match.group(1)!;
    final name = match.group(2)!.trim();
    return [
      FlierEntry(label: prefix, value: name, target: FlierTarget.name),
      if (templates.knows('gender', prefix))
        FlierEntry(
          label: prefix,
          value: templates.normalize('gender', prefix),
          target: 'gender',
        ),
      if (templates.knows('species', prefix))
        FlierEntry(
          label: prefix,
          value: templates.normalize('species', prefix),
          target: 'species',
        ),
    ];
  }
  return [
    FlierEntry(
      value: text,
      target: template.isContact(text)
          ? FlierTarget.contact
          : FlierTarget.remarks,
    ),
  ];
}

/// A date as posters print it: 05.06.2025, 5.6.2025, 2025-06-05,
/// 5/6/2025 — or only a month (05/2025) or a year (2025), kept at that
/// precision (#76). Null when the line holds no date.
PartialDate? parseFlierDate(String text) => PartialDate.find(text);

String _fold(String s) =>
    s.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');

bool _containsWord(String haystack, String needle) => RegExp(
  '(^|[^\\p{L}])${RegExp.escape(needle)}(\$|[^\\p{L}])',
  unicode: true,
).hasMatch(haystack);
