import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import '../field_labels.dart';
import '../history_share.dart';
import '../l10n.dart';
import '../missing_poster.dart';
import '../pdf_fonts.dart';
import '../widgets/date_entry.dart';

/// What the poster says, ticked from the record: photo, Looks, the day
/// the cat went missing, the home's address as the place, phone and
/// email as contact, a QR code for another cat(a)log, and one free
/// line for what the record lacks.
class MissingPosterScreen extends StatefulWidget {
  final CatalogStore store;
  final String catId;

  /// Where the PDF goes; the share sheet by default. Tests inject.
  final Future<void> Function(pw.Document doc, String fileName)? share;

  const MissingPosterScreen({
    super.key,
    required this.store,
    required this.catId,
    this.share,
  });

  @override
  State<MissingPosterScreen> createState() => _MissingPosterScreenState();
}

class _MissingPosterScreenState extends State<MissingPosterScreen> {
  CatalogStore get store => widget.store;
  final _extra = TextEditingController();
  DateTime _since = DateUtils.dateOnly(DateTime.now());
  bool _photo = true;
  bool _looks = true;
  bool _place = true;
  bool _phone = true;
  bool _email = false;
  bool _qr = true;
  bool _busy = false;

  String? get _clowder => store.current(widget.catId, Keys.clowder);

  String? _home(String slug) {
    final c = _clowder;
    if (c == null) return null;
    final v = store.current(c, Keys.userField(slug));
    return v == null || v.isEmpty ? null : v;
  }

  String? get _looksText {
    final v = store.current(widget.catId, Keys.userField('looks'));
    return v == null || v.isEmpty
        ? null
        : valueLabel(context.t, store, Keys.userField('looks'), v);
  }

  @override
  void dispose() {
    _extra.dispose();
    super.dispose();
  }

  /// The public share behind the QR code: the same ticks, photos out.
  String? _qrPayload() {
    final fields = <String>{
      if (_looks) Keys.userField('looks'),
      if (_place) Keys.userField('address'),
      if (_phone) Keys.userField('phone'),
      if (_email) Keys.userField('email'),
    };
    final payload = encodeShareData(
      catShareBytes(
        store,
        catId: widget.catId,
        fields: fields,
        includePhotos: false,
      ),
    );
    return payload.length > posterQrLimit ? null : payload;
  }

  Future<void> _share() async {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final language = Localizations.localeOf(context).languageCode;
    final name = store.current(widget.catId, Keys.name) ?? t.unnamed;
    final hash = store.profileImage(widget.catId);
    final content = PosterContent(
      headline: t.posterHeadline,
      name: name,
      photo: _photo && hash != null ? store.imageBytes(hash) : null,
      since: '${t.missingSinceLabel}: ${DateFormat.yMd(locale).format(_since)}',
      place: _place && _home('address') != null
          ? '${t.posterLastSeen} ${_home('address')}'
          : null,
      phone: _phone ? _home('phone') : null,
      email: _email ? _home('email') : null,
      looks: _looks ? _looksText : null,
      extra: _extra.text.trim(),
      standing: t.posterStanding,
      qr: _qr ? _qrPayload() : null,
      qrCaption: t.posterQr,
    );
    setState(() => _busy = true);
    try {
      final fonts = await pdfFontsFor(language);
      final doc = missingPosterPdf(content, fonts);
      await (widget.share ?? sharePdf)(doc, '$name ${t.posterHeadline}.pdf');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final hasPhoto = store.profileImage(widget.catId) != null;
    return Scaffold(
      appBar: AppBar(title: Text(t.posterMenu.replaceAll('…', ''))),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event),
            title: Text(t.missingSinceLabel),
            subtitle: Text(DateFormat.yMd(locale).format(_since)),
            onTap: () async {
              final picked = await pickDay(
                context,
                initial: _since,
                lastDate: DateTime.now(),
              );
              if (picked != null && mounted) setState(() => _since = picked);
            },
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _photo && hasPhoto,
            onChanged: hasPhoto ? (v) => setState(() => _photo = v!) : null,
            title: Text(t.posterPhoto),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _looks && _looksText != null,
            onChanged: _looksText != null
                ? (v) => setState(() => _looks = v!)
                : null,
            title: Text(t.starterLooks),
            subtitle: _looksText == null ? null : Text(_looksText!),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _place && _home('address') != null,
            onChanged: _home('address') != null
                ? (v) => setState(() => _place = v!)
                : null,
            title: Text(t.posterLastSeen),
            subtitle: _home('address') == null ? null : Text(_home('address')!),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _phone && _home('phone') != null,
            onChanged: _home('phone') != null
                ? (v) => setState(() => _phone = v!)
                : null,
            title: Text(t.starterPhone),
            subtitle: _home('phone') == null ? null : Text(_home('phone')!),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _email && _home('email') != null,
            onChanged: _home('email') != null
                ? (v) => setState(() => _email = v!)
                : null,
            title: Text(t.starterEmail),
            subtitle: _home('email') == null ? null : Text(_home('email')!),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _qr,
            onChanged: (v) => setState(() => _qr = v!),
            title: Text(t.posterQr),
          ),
          TextField(
            controller: _extra,
            decoration: InputDecoration(labelText: t.posterFreeText),
            maxLength: 60,
          ),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            icon: _busy
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.picture_as_pdf_outlined),
            label: Text(t.shareAsPdf),
            onPressed: _busy ? null : _share,
          ),
        ),
      ),
    );
  }
}
