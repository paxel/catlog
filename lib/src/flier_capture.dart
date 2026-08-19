import 'dart:typed_data';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'field_labels.dart';
import 'flier_ocr.dart';
import 'image_import.dart';
import 'l10n.dart';
import 'screens/photo_edit_screen.dart';
import 'screens/scan_screen.dart';
import 'stray_cam.dart';

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
      : text.replaceFirst(
          RegExp(r'(?<!\d)(?:\d[ -]?){14}\d(?!\d)'), '');
  final match =
      RegExp(r'(\+?\d[\d /()-]{6,}\d)').firstMatch(withoutChip);
  return match?.group(1)?.trim();
}

/// Flier capture (#32, ADR-0007): a photographed missing-cat flier
/// becomes an owner Clowder plus a Missing Cat that went stray on the
/// flier's date. On an existing cat it appends flier positions and IDs.
class FlierCaptureScreen extends StatefulWidget {
  final CatalogStore store;

  /// "Add flier" mode: append to this cat instead of creating one.
  final String? existingCatId;

  /// Test seams; production uses the real camera, GPS, scanner, OCR.
  final Future<Uint8List?> Function(BuildContext)? pickPhoto;
  final Locator? locate;
  final Future<String?> Function(BuildContext)? scan;
  final Future<String?> Function(Uint8List)? ocr;

  const FlierCaptureScreen(
      {super.key,
      required this.store,
      this.existingCatId,
      this.pickPhoto,
      this.locate,
      this.scan,
      this.ocr});

  @override
  State<FlierCaptureScreen> createState() => _FlierCaptureScreenState();
}

class _FlierCaptureScreenState extends State<FlierCaptureScreen> {
  CatalogStore get store => widget.store;

  Uint8List? _photo;
  Uint8List? _portrait;
  (double, double)? _position;
  DateTime _missingSince = DateUtils.dateOnly(DateTime.now());

  final _name = TextEditingController();
  final _chip = TextEditingController();
  final _phone = TextEditingController();
  final _owner = TextEditingController();
  final _address = TextEditingController();
  final _remarks = TextEditingController();
  bool _ocrTried = false;

  /// Double-submit guard: saving compresses images for a noticeable
  /// moment — a second tap must not create a second owner and cat.
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _capture());
  }

  @override
  void dispose() {
    for (final c in [_name, _chip, _phone, _owner, _address, _remarks]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _capture() async {
    // Position resolves while the camera is open; a flier without a
    // position is still a flier.
    final located = (widget.locate ?? locateDevice)();
    final bytes = await (widget.pickPhoto ??
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
    if (!mounted) return;
    setState(() => _ocrTried = true);
    if (text == null) return;
    setState(() {
      // Prefills are suggestions — every field stays editable (#32).
      if (_remarks.text.isEmpty) _remarks.text = text;
      final chip = suggestChipId(text);
      if (chip != null && _chip.text.isEmpty) _chip.text = chip;
      final phone = suggestPhone(text);
      if (phone != null && _phone.text.isEmpty) _phone.text = phone;
    });
  }

  Future<void> _cropPortrait() async {
    final photo = _photo;
    if (photo == null) return;
    final cropped = await Navigator.of(context).push<Uint8List>(
      MaterialPageRoute(
        builder: (_) =>
            PhotoEditScreen(bytes: photo, mode: PhotoEditMode.crop),
      ),
    );
    if (cropped != null && mounted) setState(() => _portrait = cropped);
  }

  Future<void> _scanCode() async {
    final value = await (widget.scan ??
        (BuildContext c) => Navigator.of(c).push<String>(
            MaterialPageRoute(builder: (_) => const ScanScreen())))(context);
    if (value != null && value.isNotEmpty && mounted) {
      setState(() => _chip.text = value);
    }
  }

  Future<void> _pickMissingSince() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _missingSince,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      errorFormatText: context.t
          .dateFormatError(MaterialLocalizations.of(context).dateHelpText),
    );
    if (picked != null && mounted) {
      setState(() => _missingSince = DateUtils.dateOnly(picked));
    }
  }

  Future<void> _save() async {
    final photo = _photo;
    if (photo == null || _saving) return;
    setState(() => _saving = true);
    final t = context.t;
    String catId;
    final catName =
        _name.text.trim().isEmpty ? t.captureFlier : _name.text.trim();
    if (widget.existingCatId == null) {
      // Owner clowder first: public flier data, no Private marker. A
      // nameless owner is named after the cat, so the card isn't barren.
      final ownerName = _owner.text.trim();
      final clowderId = store.createClowder(
          ownerName.isEmpty ? t.ownerOfCat(catName) : ownerName,
          date: _missingSince);
      store.append(clowderId, Keys.userField('status'), 'owner',
          date: _missingSince);
      if (_address.text.trim().isNotEmpty) {
        store.append(clowderId, Keys.userField('address'),
            _address.text.trim(),
            date: _missingSince);
      }
      if (ownerName.isNotEmpty) {
        store.append(clowderId, Keys.userField('responsible'), ownerName,
            date: _missingSince);
      }
      // The owner card carries the flier's contact and text itself —
      // it must stand on its own next to the cat.
      final ownerRemarks = [
        if (_phone.text.trim().isNotEmpty)
          '${t.phoneLabel}: ${_phone.text.trim()}',
        if (_remarks.text.trim().isNotEmpty) _remarks.text.trim(),
      ].join('\n\n');
      if (ownerRemarks.isNotEmpty) {
        store.append(clowderId, Keys.userField('remarks'), ownerRemarks,
            date: _missingSince);
      }
      // The cat lived with its owner until the flier's date — plain
      // Move semantics keep the history reconstructable after a Merge.
      catId = store.createCat(catName,
          clowderId: clowderId, date: _missingSince);
      store.moveCat(catId, null, date: _missingSince);
    } else {
      catId = widget.existingCatId!;
    }
    if (_position case final pos?) {
      store.recordPosition(catId, pos.$1, pos.$2,
          kind: PositionKind.flier);
    }
    if (_chip.text.trim().isNotEmpty) {
      store.append(
          catId, Keys.userField('chipid'), _chip.text.trim());
    }
    final remarks = _remarks.text.trim();
    if (remarks.isNotEmpty) {
      final existing =
          store.current(catId, Keys.userField('remarks')) ?? '';
      store.append(catId, Keys.userField('remarks'),
          existing.isEmpty ? remarks : '$existing\n$remarks');
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

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final photo = _photo;
    final newCat = widget.existingCatId == null;
    return Scaffold(
      appBar: AppBar(
          title: Text(newCat ? t.captureFlier : t.addFlier),
          actions: [
            IconButton(
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.check),
                tooltip: _saving ? t.savingLabel : t.save,
                onPressed: photo == null || _saving ? null : _save),
          ]),
      body: photo == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(padding: const EdgeInsets.all(16), children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(photo,
                    height: 220, fit: BoxFit.contain),
              ),
              Row(children: [
                TextButton.icon(
                    icon: const Icon(Icons.crop),
                    label: Text(t.cropPortrait),
                    onPressed: _cropPortrait),
                if (_portrait != null)
                  const Icon(Icons.check, size: 18),
                const Spacer(),
                TextButton.icon(
                    icon: const Icon(Icons.qr_code_scanner),
                    label: Text(t.scanCode),
                    onPressed: _scanCode),
              ]),
              if (_ocrTried && _remarks.text.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(t.ocrUnavailable,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              if (newCat)
                TextField(
                    controller: _name,
                    decoration: InputDecoration(labelText: t.name)),
              TextField(
                  controller: _chip,
                  decoration: InputDecoration(
                      labelText: fieldDefName(
                          t,
                          store.fieldDefs().firstWhere(
                              (d) => d.slug == 'chipid')))),
              if (newCat) ...[
                TextField(
                    controller: _owner,
                    decoration: InputDecoration(
                        labelText: t.starterResponsible)),
                TextField(
                    controller: _phone,
                    decoration:
                        InputDecoration(labelText: t.phoneLabel)),
                TextField(
                    controller: _address,
                    decoration:
                        InputDecoration(labelText: t.starterAddress)),
              ],
              TextField(
                  controller: _remarks,
                  minLines: 3,
                  maxLines: 8,
                  decoration:
                      InputDecoration(labelText: t.starterRemarks)),
              if (newCat)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_busy),
                  title: Text(t.missingSinceLabel),
                  subtitle: Text(DateFormat.yMd(
                          Localizations.localeOf(context).toString())
                      .format(_missingSince)),
                  onTap: _pickMissingSince,
                ),
              const SizedBox(height: 24),
              FilledButton.icon(
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.check),
                  label: Text(_saving ? t.savingLabel : t.save),
                  onPressed: _saving ? null : _save),
            ]),
    );
  }
}
