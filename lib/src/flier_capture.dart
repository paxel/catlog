import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'field_editing.dart';
import 'field_labels.dart';
import 'flier_ocr.dart';
import 'flier_template.dart';
import 'geocode.dart';
import 'image_import.dart';
import 'l10n.dart';
import 'screens/photo_edit_screen.dart';
import 'screens/scan_screen.dart';
import 'stray_cam.dart';
import 'widgets/date_entry.dart';

/// A transponder number on a flier: 15 digits, often printed with
/// spaces or hyphens between groups.
String? suggestChipId(String text) {
  final match = RegExp(r'(?<!\d)(?:\d[ -]?){14}\d(?!\d)').firstMatch(text);
  if (match == null) return null;
  final digits = match.group(0)!.replaceAll(RegExp(r'[ -]'), '');
  return digits.length == 15 ? digits : null;
}

/// A phone number on a flier — after the chip ID has been taken out,
/// any 8+ digit run with phone punctuation qualifies.
String? suggestPhone(String text) {
  final withoutChip = suggestChipId(text) == null
      ? text
      : text.replaceFirst(RegExp(r'(?<!\d)(?:\d[ -]?){14}\d(?!\d)'), '');
  final match = RegExp(r'(\+?\d[\d /()-]{6,}\d)').firstMatch(withoutChip);
  return match?.group(1)?.trim();
}

/// An e-mail address on a flier.
String? suggestEmail(String text) => RegExp(
  r'[\w.+-]+@[\w-]+\.[\w.-]+',
  caseSensitive: false,
).firstMatch(text)?.group(0);

/// A registry number found on a flier, ready to be stored: either a
/// service the app ships ([preset]) or one learned from the link.
class FlierRegistryHit {
  final String serviceName;
  final String template;
  final String value;

  /// Off means "do not store this one" — the link still survives in the
  /// remarks, like the rest of the flier text.
  bool take;

  /// Printed as a number in the text (a template found it), not
  /// carried by a link.
  final bool fromText;

  /// Taught by the user from an unknown link on this poster.
  final bool learned;

  FlierRegistryHit({
    required this.serviceName,
    required this.template,
    required this.value,
    this.take = true,
    this.fromText = false,
    this.learned = false,
  });
}

/// Registry links found in flier text or its QR codes: matched first
/// against the services already known to this catalog (ID fields with
/// a lookup template), then against the ones the app ships. A service
/// learned from an earlier poster is therefore recognized on the next.
List<FlierRegistryHit> registryHitsIn(
  Iterable<String> urls, {
  Iterable<FieldDef> defs = const [],
}) {
  final hits = <FlierRegistryHit>[];
  for (final url in urls) {
    for (final (name, template) in [
      for (final def in defs)
        if (def.lookupUrl case final template?)
          if (template.isNotEmpty) (def.name, template),
      for (final preset in registryPresets) (preset.name, preset.template),
    ]) {
      final value = idFromLookupUrl(template, url);
      if (value == null) continue;
      if (!hits.any((h) => h.serviceName == name && h.value == value)) {
        hits.add(
          FlierRegistryHit(serviceName: name, template: template, value: value),
        );
      }
      break;
    }
  }
  return hits;
}

/// True when [url] belongs to no service this catalog knows or ships.
bool isUnknownService(String url, Iterable<FieldDef> defs) =>
    registryHitsIn([url], defs: defs).isEmpty;

/// Flier capture (#32, ADR-0007): a photographed missing-cat flier
/// becomes an owner Clowder plus a Missing Cat that went stray on the
/// flier's date. On an existing cat it appends flier positions and IDs.
/// The form is a wizard — one question per page, so nothing important
/// (the face crop, a registry number) is quietly skipped. The only way
/// out forward is the Check-and-save page; back asks before aborting.
class FlierCaptureScreen extends StatefulWidget {
  final CatalogStore store;

  /// "Add flier" mode: append to this cat instead of creating one.
  final String? existingCatId;

  /// Test seams; production uses the real camera, GPS, scanner, OCR.
  final Future<Uint8List?> Function(BuildContext)? pickPhoto;
  final Locator? locate;
  final Future<String?> Function(BuildContext)? scan;
  final Future<FlierText?> Function(Uint8List)? ocr;
  final Future<FlierCodes> Function(Uint8List)? codes;
  final GeocodeSearch? geocode;
  final Future<FlierTemplateSet> Function()? templates;

  const FlierCaptureScreen({
    super.key,
    required this.store,
    this.existingCatId,
    this.pickPhoto,
    this.locate,
    this.scan,
    this.ocr,
    this.codes,
    this.geocode,
    this.templates,
  });

  @override
  State<FlierCaptureScreen> createState() => _FlierCaptureScreenState();
}

class _FlierCaptureScreenState extends State<FlierCaptureScreen> {
  CatalogStore get store => widget.store;

  Uint8List? _photo;
  Uint8List? _portrait;
  (double, double)? _position;

  /// Position of the owner's address, looked up on request.
  (double, double)? _addressPosition;
  DateTime _missingSince = DateUtils.dateOnly(DateTime.now());

  /// The poster's missing-since date at the precision it was printed
  /// (#76); [_missingSince] is its first day, used for entry timestamps
  /// only — a timestamp needs a day, a stored value never gets one.
  PartialDate? _missingSincePartial;

  final _name = TextEditingController();
  final _chip = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _owner = TextEditingController();
  final _address = TextEditingController();
  final _remarks = TextEditingController();
  bool _locatingAddress = false;
  String? _addressError;

  /// What the poster says, line by line with a target each — the Flier
  /// text page lets the user move lines between fields before they
  /// are applied.
  FlierReading? _reading;
  FlierCodes _codes = FlierCodes.none;

  /// Codes the user unticked on the Flier text page.
  final _rejectedCodes = <String>{};

  /// Catalog Fields the poster filled (gender, breed, …), editable on
  /// the Cat page.
  final _fieldInputs = <String, FieldValueController>{};

  /// Registry numbers the poster carried.
  final _registryHits = <FlierRegistryHit>[];

  /// Links from the poster that belong to no known service.
  final _unknownLinks = <String>[];

  int _step = 0;

  /// Double-submit guard: saving compresses images for a noticeable
  /// moment — a second tap must not create a second owner and cat.
  bool _saving = false;

  bool get _newCat => widget.existingCatId == null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _capture());
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _chip,
      _phone,
      _email,
      _owner,
      _address,
      _remarks,
    ]) {
      c.dispose();
    }
    for (final c in _fieldInputs.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _capture() async {
    // Position resolves while the camera is open; a flier without a
    // position is still a flier.
    final located = (widget.locate ?? locateDevice)();
    final bytes =
        await (widget.pickPhoto ??
            ((c) => pickImageBytes(c, allowCrop: false)))(context);
    if (bytes == null) {
      // No photo, no flier.
      if (mounted) Navigator.of(context).pop();
      return;
    }
    final outcome = await located;
    if (!mounted) return;
    setState(() {
      _photo = bytes;
      _position = outcome.pos;
    });
    await _runOcr();
  }

  Future<void> _runOcr() async {
    final photo = _photo;
    if (photo == null) return;
    final text = await (widget.ocr ?? recognizeFlierText)(photo);
    final codes = await (widget.codes ?? recognizeFlierCodes)(photo);
    final templates = await (widget.templates ?? FlierTemplateSet.load)();
    if (!mounted) return;
    setState(() {
      _codes = codes;
      if (text != null) {
        // Lines with boxes pair into label/value; a recognizer that
        // gave only text (or none at all) leaves every line lone.
        final pairs = text.lines.isNotEmpty
            ? pairLines(text.lines)
            : [for (final l in text.text.split('\n')) FlierPair(null, l)];
        _reading = readFlier(pairs, templates);
      }
      _applyReading();
    });
  }

  /// Fills the wizard's inputs from the Flier text page's assignments.
  /// Runs after recognition and every time that page is left forward,
  /// so a corrected line lands where it was sent.
  void _applyReading() {
    final reading = _reading;
    final remarks = <String>[];
    final defs = store.fieldDefs();
    for (final c in _fieldInputs.values) {
      c.dispose();
    }
    _fieldInputs.clear();
    // Hits are recomputed from the assignments and the kept codes; only
    // a service the user taught on this poster survives untouched.
    _registryHits.removeWhere((h) => !h.learned);
    if (reading != null) {
      if (_newCat) {
        _name.text = reading.first(FlierTarget.name) ?? '';
        _address.text = reading.first(FlierTarget.lostPlace) ?? '';
        final since = reading.first(FlierTarget.missingSince);
        final date = since == null ? null : _missingDate(since);
        if (date != null) {
          _missingSince = date.earliest;
          _missingSincePartial = date;
        }
      }
      for (final entry in reading.entries) {
        // The label names the line on the Flier text page and nowhere
        // else; only the value travels (#77).
        final line = entry.value;
        switch (entry.target) {
          case FlierTarget.drop:
            break;
          case FlierTarget.name:
          case FlierTarget.lostPlace:
            if (!_newCat) remarks.add(line);
          case FlierTarget.missingSince:
            if (!_newCat || _missingDate(entry.value) == null) {
              remarks.add(line);
            }
          case FlierTarget.registryNumber:
            final template = reading.template;
            final hit = template == null
                ? null
                : _registryHitFor(template.registry, entry.value, defs);
            if (hit == null) {
              remarks.add(line);
            } else if (!_registryHits.any(
              (h) => normalizeId(h.value) == normalizeId(hit.value),
            )) {
              _registryHits.add(hit);
            }
          case FlierTarget.remarks:
          case FlierTarget.contact:
            remarks.add(line);
          case 'chipid':
            final chip = suggestChipId(entry.value);
            if (chip != null) {
              _chip.text = chip;
            } else {
              remarks.add(line);
            }
          case final slug:
            final def = defs.where((d) => d.slug == slug).firstOrNull;
            // A date field takes the poster's date in stored form, at
            // the precision printed; a line without one stays text.
            final value = def?.type == FieldType.date
                ? parseFlierDate(entry.value)?.iso
                : entry.value;
            if (def == null ||
                def.scope == FieldScope.clowder ||
                value == null) {
              remarks.add(line);
            } else if (!_fieldInputs.containsKey(slug)) {
              _fieldInputs[slug] = FieldValueController(def, current: value);
            }
        }
      }
    }
    // Prefills are suggestions — every field stays editable (#32).
    // Contact lines belong to the registry, so the owner's phone and
    // mail come from the rest of the text only. Without a reading the
    // user types everything; nothing typed is touched.
    var ownText = '';
    if (reading != null) {
      ownText = [
        for (final e in reading.entries)
          if (e.target != FlierTarget.contact) e.value,
      ].join('\n');
      if (reading.template == null && _chip.text.isEmpty) {
        _chip.text = suggestChipId(ownText) ?? '';
      }
      _phone.text = suggestPhone(ownText) ?? '';
      _email.text = suggestEmail(ownText) ?? '';
      _remarks.text = remarks.join('\n');
    }
    // Links come from the printed text and from the QR codes the user
    // kept.
    final urls = [
      ...urlsIn(ownText),
      for (final code in _codes.codes)
        if (!_rejectedCodes.contains(code) &&
            code.toLowerCase().startsWith('http'))
          code,
    ];
    for (final hit in registryHitsIn(urls, defs: defs)) {
      if (!_registryHits.any(
        (h) => normalizeId(h.value) == normalizeId(hit.value),
      )) {
        _registryHits.add(hit);
      }
    }
    _unknownLinks
      ..clear()
      ..addAll([
        for (final url in urls)
          if (isUnknownService(url, defs)) url,
      ]);
  }

  /// The missing-since date a line carries, or null when it is no date
  /// or lies in the future (a misread year) — the date picker only
  /// reaches today, and such a line belongs in remarks.
  PartialDate? _missingDate(String text) {
    final date = parseFlierDate(text);
    if (date == null) return null;
    return date.earliest.isAfter(DateUtils.dateOnly(DateTime.now()))
        ? null
        : date;
  }

  /// A hit for a number printed in the text: the registry named by the
  /// template, with its template taken from a Field this catalog has
  /// or from the shipped presets.
  FlierRegistryHit? _registryHitFor(
    String registry,
    String value,
    List<FieldDef> defs,
  ) {
    final slug = CatalogStore.slugify(registry);
    final known = defs.where((d) => d.slug == slug).firstOrNull;
    final template =
        known?.lookupUrl ??
        registryPresets
            .where((p) => p.name.toLowerCase() == registry.toLowerCase())
            .firstOrNull
            ?.template;
    if (template == null || template.isEmpty) return null;
    return FlierRegistryHit(
      serviceName: known?.name ?? registry,
      template: template,
      value: value.trim(),
      fromText: true,
    );
  }

  Future<void> _cropPortrait() async {
    final photo = _photo;
    if (photo == null) return;
    final cropped = await Navigator.of(context).push<Uint8List>(
      MaterialPageRoute(
        builder: (_) => PhotoEditScreen(bytes: photo, mode: PhotoEditMode.crop),
      ),
    );
    if (cropped != null && mounted) setState(() => _portrait = cropped);
  }

  Future<void> _scanCode() async {
    final value =
        await (widget.scan ??
            (BuildContext c) => Navigator.of(c).push<String>(
              MaterialPageRoute(builder: (_) => const ScanScreen()),
            ))(context);
    if (value != null && value.isNotEmpty && mounted) {
      setState(() => _chip.text = value);
    }
  }

  String _missingSinceText(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final partial = _missingSincePartial;
    return partial == null
        ? DateFormat.yMd(locale).format(_missingSince)
        : formatPartialDate(locale, partial);
  }

  Future<void> _pickMissingSince() async {
    final picked = await pickDay(
      context,
      initial: _missingSince,
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        _missingSince = DateUtils.dateOnly(picked);
        _missingSincePartial = null;
      });
    }
  }

  /// Turns the typed address into a position for the owner's clowder —
  /// on request only, because it asks the geocoding service.
  Future<void> _locateAddress() async {
    final query = _address.text.trim();
    if (query.isEmpty || _locatingAddress) return;
    setState(() {
      _locatingAddress = true;
      _addressError = null;
    });
    List<GeoHit> hits;
    try {
      hits = await (widget.geocode ?? nominatimSearch)(query);
    } catch (_) {
      hits = const [];
    }
    if (!mounted) return;
    setState(() {
      _locatingAddress = false;
      if (hits.isEmpty) {
        // Say why nothing happened and what fixes it.
        _addressError = context.t.addressNotFound;
      } else {
        _addressPosition = (hits.first.lat, hits.first.lon);
      }
    });
  }

  /// Stores a registry hit: the service's Field is created on first use
  /// (with its lookup template), then the number lands on the cat.
  void _storeRegistryHit(String catId, FlierRegistryHit hit) {
    final slug = CatalogStore.slugify(hit.serviceName);
    var def = store.fieldDefs().where((d) => d.slug == slug).firstOrNull;
    if (def == null) {
      store.defineField(
        hit.serviceName,
        FieldType.id,
        scope: FieldScope.cat,
        lookupUrl: hit.template,
      );
      def = store.fieldDefs().firstWhere((d) => d.slug == slug);
    } else if (def.lookupUrl == null || def.lookupUrl!.isEmpty) {
      store.setFieldLookupUrl(def.id, hit.template);
    }
    store.append(catId, def.key, hit.value);
  }

  /// Teaches the app an unknown service from a link on the poster.
  Future<void> _learnLink(String url) async {
    final candidates = idCandidatesIn(url);
    final result = await showDialog<FlierRegistryHit>(
      context: context,
      builder: (context) =>
          _LearnServiceDialog(url: url, candidates: candidates),
    );
    if (result != null && mounted) {
      setState(() {
        _registryHits.add(result);
        _unknownLinks.remove(url);
      });
    }
  }

  /// Back on the wizard: the photo is taken and lines are assigned —
  /// leaving throws that away, so ask first.
  Future<void> _confirmAbort() async {
    final t = context.t;
    final abort = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.abortScanTitle),
        content: Text(t.abortScanBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.keepScanning),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.abortScan),
          ),
        ],
      ),
    );
    if (abort == true && mounted) Navigator.of(context).pop();
  }

  Future<void> _save() async {
    final photo = _photo;
    if (photo == null || _saving) return;
    setState(() => _saving = true);
    final t = context.t;
    String catId;
    final catName = _name.text.trim().isEmpty
        ? t.captureFlier
        : _name.text.trim();
    if (_newCat) {
      // Owner clowder first: public flier data, no Private marker. A
      // nameless owner is named after the cat, so the card isn't barren.
      final ownerName = _owner.text.trim();
      final clowderId = store.createClowder(
        ownerName.isEmpty ? t.ownerOfCat(catName) : ownerName,
        date: _missingSince,
      );
      store.append(
        clowderId,
        Keys.userField('status'),
        'owner',
        date: _missingSince,
      );
      if (_address.text.trim().isNotEmpty) {
        store.append(
          clowderId,
          Keys.userField('address'),
          _address.text.trim(),
          date: _missingSince,
        );
      }
      if (_addressPosition case final pos?) {
        store.recordPosition(clowderId, pos.$1, pos.$2, date: _missingSince);
      }
      if (ownerName.isNotEmpty) {
        store.append(
          clowderId,
          Keys.userField('responsible'),
          ownerName,
          date: _missingSince,
        );
      }
      // Contact details go into their own fields; the flier text stays
      // in remarks as the source it came from.
      if (_phone.text.trim().isNotEmpty) {
        store.append(
          clowderId,
          Keys.userField('phone'),
          _phone.text.trim(),
          date: _missingSince,
        );
      }
      if (_email.text.trim().isNotEmpty) {
        store.append(
          clowderId,
          Keys.userField('email'),
          _email.text.trim(),
          date: _missingSince,
        );
      }
      if (_remarks.text.trim().isNotEmpty) {
        store.append(
          clowderId,
          Keys.userField('remarks'),
          _remarks.text.trim(),
          date: _missingSince,
        );
      }
      // The cat lived with its owner until the flier's date — plain
      // Move semantics keep the history reconstructable after a Merge.
      catId = store.createCat(
        catName,
        clowderId: clowderId,
        date: _missingSince,
      );
      store.moveCat(catId, null, date: _missingSince);
    } else {
      catId = widget.existingCatId!;
    }
    if (_position case final pos?) {
      store.recordPosition(catId, pos.$1, pos.$2, kind: PositionKind.flier);
    }
    if (_chip.text.trim().isNotEmpty) {
      store.append(catId, Keys.userField('chipid'), _chip.text.trim());
    }
    for (final input in _fieldInputs.values) {
      if (input.value case final value?) {
        store.append(catId, input.def.key, value);
      }
    }
    for (final hit in _registryHits) {
      if (hit.take) _storeRegistryHit(catId, hit);
    }
    final remarks = _remarks.text.trim();
    if (remarks.isNotEmpty) {
      final existing = store.current(catId, Keys.userField('remarks')) ?? '';
      store.append(
        catId,
        Keys.userField('remarks'),
        existing.isEmpty ? remarks : '$existing\n$remarks',
      );
    }
    // The full flier photo is provenance; the cropped portrait becomes
    // the face.
    await addCompressedImage(store, catId, photo);
    if (_portrait case final portrait?) {
      final hash = await addCompressedImage(store, catId, portrait);
      store.setProfileImage(catId, hash);
    }
    if (!mounted) return;
    Navigator.of(context).pop(catId);
    // No _saving reset: the screen pops; a failed pop keeps it guarded.
  }

  // --------------------------------------------------------------- steps

  List<({String title, Widget body})> _steps(AppLocalizations t) => [
    (title: t.stepFlierText, body: _textStep(t)),
    (title: t.stepCat, body: _catStep(t)),
    if (_newCat) (title: t.stepOwner, body: _ownerStep(t)),
    (title: t.stepFace, body: _faceStep(t)),
    (title: t.stepRegistry, body: _registryStep(t)),
    (title: t.stepReview, body: _reviewStep(t)),
  ];

  Widget _flierThumb() => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(_photo!, height: 160, fit: BoxFit.contain),
  );

  /// The targets a line can be sent to: the wizard's own inputs and
  /// every cat Field, by localized name.
  List<DropdownMenuItem<String>> _targetItems(AppLocalizations t) => [
    DropdownMenuItem(value: FlierTarget.drop, child: Text(t.targetDrop)),
    DropdownMenuItem(value: FlierTarget.remarks, child: Text(t.starterRemarks)),
    if (_newCat) ...[
      DropdownMenuItem(value: FlierTarget.name, child: Text(t.name)),
      DropdownMenuItem(
        value: FlierTarget.missingSince,
        child: Text(t.missingSinceLabel),
      ),
      DropdownMenuItem(
        value: FlierTarget.lostPlace,
        child: Text(t.targetLostPlace),
      ),
    ],
    if (_reading?.template != null)
      DropdownMenuItem(
        value: FlierTarget.registryNumber,
        child: Text(t.targetRegistryNumber),
      ),
    DropdownMenuItem(value: FlierTarget.contact, child: Text(t.targetContact)),
    // The remarks Field is the Remarks target above.
    for (final def in store.fieldDefs())
      if (def.slug != FlierTarget.remarks &&
          def.scope != FieldScope.clowder &&
          def.type != FieldType.location &&
          def.type != FieldType.cat)
        DropdownMenuItem(value: def.slug, child: Text(fieldDefName(t, def))),
  ];

  Widget _textStep(AppLocalizations t) {
    final reading = _reading;
    final items = _targetItems(t);
    final known = {for (final i in items) i.value};
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _flierThumb(),
        const SizedBox(height: 12),
        // The QR card: found, none, or the reader's own error. A
        // silent failure would look like a poster without a code.
        if (_codes.error case final error?)
          Text(
            t.qrFailed(error),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          )
        else if (_codes.codes.isEmpty)
          Text(t.qrNone, style: Theme.of(context).textTheme.bodySmall)
        else ...[
          Text(t.qrFoundHint, style: Theme.of(context).textTheme.bodySmall),
          for (final code in _codes.codes)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: !_rejectedCodes.contains(code),
              onChanged: (on) => setState(() {
                if (on ?? true) {
                  _rejectedCodes.remove(code);
                } else {
                  _rejectedCodes.add(code);
                }
              }),
              title: Text(t.useCode),
              subtitle: Text(
                code,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
        const Divider(),
        if (reading == null)
          Text(t.ocrUnavailable, style: Theme.of(context).textTheme.bodySmall)
        else ...[
          Text(
            reading.template == null
                ? t.flierLayoutUnknown
                : t.flierRecognized(reading.template!.name),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          for (final entry in reading.entries)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(entry.value),
              subtitle: entry.label == null ? null : Text(entry.label!),
              trailing: DropdownButton<String>(
                value: known.contains(entry.target)
                    ? entry.target
                    : FlierTarget.remarks,
                items: items,
                onChanged: (v) =>
                    setState(() => entry.target = v ?? entry.target),
              ),
            ),
        ],
        if (reading == null)
          TextField(
            controller: _remarks,
            minLines: 3,
            maxLines: 8,
            decoration: InputDecoration(labelText: t.starterRemarks),
          ),
      ],
    );
  }

  Widget _catStep(AppLocalizations t) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      if (_newCat)
        TextField(
          controller: _name,
          decoration: InputDecoration(labelText: t.name),
        ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chip,
              decoration: InputDecoration(
                labelText: fieldDefName(
                  t,
                  store.fieldDefs().firstWhere((d) => d.slug == 'chipid'),
                ),
                helperText: t.chipScanHint,
                helperMaxLines: 3,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: t.scanPrintedCode,
            onPressed: _scanCode,
          ),
        ],
      ),
      if (_newCat)
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.event_busy),
          title: Text(t.missingSinceLabel),
          subtitle: Text(_missingSinceText(context)),
          onTap: _pickMissingSince,
        ),
      // Fields the poster filled, each with its own type-aware
      // input — a wrong gender is one tap away from right.
      for (final input in _fieldInputs.values) ...[
        const SizedBox(height: 8),
        Text(
          fieldDefName(t, input.def),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        FieldValueInput(controller: input, store: store, autofocus: false),
      ],
      TextField(
        controller: _remarks,
        minLines: 3,
        maxLines: 8,
        decoration: InputDecoration(labelText: t.starterRemarks),
      ),
    ],
  );

  Widget _ownerStep(AppLocalizations t) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text(t.stepOwnerHint, style: Theme.of(context).textTheme.bodySmall),
      TextField(
        controller: _owner,
        decoration: InputDecoration(labelText: t.starterResponsible),
      ),
      TextField(
        controller: _phone,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(labelText: t.starterPhone),
      ),
      TextField(
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: t.starterEmail),
      ),
      TextField(
        controller: _address,
        decoration: InputDecoration(
          labelText: t.starterAddress,
          errorText: _addressError,
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          icon: _locatingAddress
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  _addressPosition == null
                      ? Icons.add_location_alt_outlined
                      : Icons.check,
                ),
          label: Text(
            _addressPosition == null ? t.locateAddress : t.addressLocated,
          ),
          onPressed: _locatingAddress ? null : _locateAddress,
        ),
      ),
    ],
  );

  Widget _faceStep(AppLocalizations t) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text(t.stepFaceHint),
      const SizedBox(height: 12),
      if (_portrait case final portrait?)
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(portrait, height: 220, fit: BoxFit.contain),
        )
      else
        _flierThumb(),
      const SizedBox(height: 12),
      FilledButton.icon(
        icon: const Icon(Icons.crop),
        label: Text(_portrait == null ? t.cropPortrait : t.cropAgain),
        onPressed: _cropPortrait,
      ),
    ],
  );

  Widget _registryStep(AppLocalizations t) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text(
        _registryHits.isEmpty && _unknownLinks.isEmpty
            ? t.noRegistryLinks
            : t.stepRegistryHint,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      for (final hit in _registryHits)
        CheckboxListTile(
          value: hit.take,
          onChanged: (on) => setState(() => hit.take = on ?? hit.take),
          title: Text('${hit.serviceName}: ${hit.value}'),
          subtitle: Text(
            buildLookupUrl(hit.template, hit.value),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      for (final url in _unknownLinks)
        ListTile(
          leading: const Icon(Icons.link),
          title: Text(url, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text(t.unknownServiceHint),
          trailing: TextButton(
            onPressed: () => _learnLink(url),
            child: Text(t.rememberService),
          ),
        ),
    ],
  );

  Widget _reviewStep(AppLocalizations t) {
    final rows = <(String, String)>[
      if (_newCat)
        (
          t.name,
          _name.text.trim().isEmpty ? t.captureFlier : _name.text.trim(),
        ),
      if (_chip.text.trim().isNotEmpty) (t.starterChipId, _chip.text.trim()),
      if (_newCat) (t.missingSinceLabel, _missingSinceText(context)),
      for (final input in _fieldInputs.values)
        if (input.value case final value?)
          (fieldDefName(t, input.def), fieldValueDisplay(t, input.def, value)),
      if (_newCat && _owner.text.trim().isNotEmpty)
        (t.starterResponsible, _owner.text.trim()),
      if (_newCat && _phone.text.trim().isNotEmpty)
        (t.starterPhone, _phone.text.trim()),
      if (_newCat && _email.text.trim().isNotEmpty)
        (t.starterEmail, _email.text.trim()),
      if (_newCat && _address.text.trim().isNotEmpty)
        (t.starterAddress, _address.text.trim()),
      for (final hit in _registryHits)
        if (hit.take) (hit.serviceName, hit.value),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final (label, value) in rows)
          ListTile(dense: true, title: Text(label), subtitle: Text(value)),
        if (_portrait == null)
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(t.noFaceYet),
          ),
        const SizedBox(height: 16),
        FilledButton.icon(
          icon: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.check),
          label: Text(_saving ? t.savingLabel : t.save),
          onPressed: _saving ? null : _save,
        ),
      ],
    );
  }

  void _next(int step) {
    setState(() {
      // Leaving the Flier text page applies its assignments; the later
      // pages then show what the poster said.
      if (step == 0) _applyReading();
      _step = step + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final photo = _photo;
    if (photo == null) {
      return Scaffold(
        appBar: AppBar(title: Text(_newCat ? t.captureFlier : t.addFlier)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final steps = _steps(t);
    final step = _step.clamp(0, steps.length - 1);
    final last = step == steps.length - 1;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmAbort();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(steps[step].title)),
        body: Column(
          children: [
            LinearProgressIndicator(value: (step + 1) / steps.length),
            // Keyed per page: every page is a ListView, and an unkeyed one
            // would inherit the previous page's scroll position.
            Expanded(
              child: KeyedSubtree(key: ValueKey(step), child: steps[step].body),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              TextButton.icon(
                icon: const Icon(Icons.chevron_left),
                label: Text(t.backLabel),
                onPressed: step == 0
                    ? null
                    : () => setState(() => _step = step - 1),
              ),
              const Spacer(),
              Text('${step + 1}/${steps.length}'),
              const Spacer(),
              FilledButton.icon(
                icon: Icon(last ? Icons.check : Icons.chevron_right),
                label: Text(last ? t.save : t.introNext),
                onPressed: last ? (_saving ? null : _save) : () => _next(step),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Asks which part of an unknown link is the number, then keeps that
/// service for the next flier.
class _LearnServiceDialog extends StatefulWidget {
  final String url;
  final List<({String where, String value})> candidates;

  const _LearnServiceDialog({required this.url, required this.candidates});

  @override
  State<_LearnServiceDialog> createState() => _LearnServiceDialogState();
}

class _LearnServiceDialogState extends State<_LearnServiceDialog> {
  final _name = TextEditingController();
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.candidates.firstOrNull?.value;
    final host = Uri.tryParse(widget.url)?.host ?? '';
    // The host is the obvious working name; the user can rename it.
    _name.text = host.replaceFirst(RegExp(r'^www\.'), '');
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(t.rememberService),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.rememberServiceHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: t.name),
          ),
          const SizedBox(height: 12),
          if (widget.candidates.isEmpty)
            Text(t.noIdInLink)
          else
            DropdownButtonFormField<String>(
              initialValue: _value,
              decoration: InputDecoration(labelText: t.whichNumber),
              items: [
                for (final c in widget.candidates)
                  DropdownMenuItem(
                    value: c.value,
                    child: Text('${c.where}: ${c.value}'),
                  ),
              ],
              onChanged: (v) => setState(() => _value = v ?? _value),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: _value == null || _name.text.trim().isEmpty
              ? null
              : () {
                  final template = learnLookupTemplate(widget.url, _value!);
                  if (template == null) {
                    Navigator.of(context).pop();
                    return;
                  }
                  Navigator.of(context).pop(
                    FlierRegistryHit(
                      serviceName: _name.text.trim(),
                      template: template,
                      value: _value!,
                      learned: true,
                    ),
                  );
                },
          child: Text(t.save),
        ),
      ],
    );
  }
}
