import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import '../field_labels.dart';
import '../history_share.dart';
import '../l10n.dart';
import '../pdf_fonts.dart';
import '../vet_report.dart';
import '../widgets/date_entry.dart';
import 'field_graph_screen.dart';

/// What goes to the vet: field chips, a date range, every row ticked
/// until unticked, the patient summary on or off. Share as PDF builds
/// the report and hands it to the share sheet.
class VetReportScreen extends StatefulWidget {
  final CatalogStore store;
  final String catId;

  /// Where the PDF goes; the share sheet by default. Tests inject.
  final Future<void> Function(pw.Document doc, String fileName)? share;

  const VetReportScreen({
    super.key,
    required this.store,
    required this.catId,
    this.share,
  });

  @override
  State<VetReportScreen> createState() => _VetReportScreenState();
}

class _VetReportScreenState extends State<VetReportScreen> {
  CatalogStore get store => widget.store;
  late final List<FieldDef> _fields = reportableFields(store, widget.catId);
  late final Set<String> _chosen = {for (final d in _fields) d.key};
  late DateTime _from;
  late DateTime _to;
  final _dropped = <int>{};
  bool _summary = true;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    final all = reportEntries(
      store,
      widget.catId,
      _fields,
      DateTime(1900),
      DateTime.now(),
    );
    _to = DateUtils.dateOnly(DateTime.now());
    _from = all.isEmpty ? _to : DateUtils.dateOnly(all.first.date.toLocal());
  }

  List<FieldDef> get _chosenFields => [
    for (final d in _fields)
      if (_chosen.contains(d.key)) d,
  ];

  List<Entry> get _entries =>
      reportEntries(store, widget.catId, _chosenFields, _from, _to);

  Future<void> _pick(bool from) async {
    final picked = await pickDay(
      context,
      initial: from ? _from : _to,
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (from) {
        _from = picked;
      } else {
        _to = picked;
      }
    });
  }

  Future<void> _share() async {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final language = Localizations.localeOf(context).languageCode;
    setState(() => _busy = true);
    try {
      final fields = _chosenFields;
      final entries = [
        for (final e in _entries)
          if (!_dropped.contains(e.seq)) e,
      ];
      final curves = <ReportCurve>[];
      for (final (i, def) in fields.indexed) {
        if (def.type != FieldType.number && def.type != FieldType.unitValue) {
          continue;
        }
        final points = [
          for (final p in graphPoints(store, widget.catId, def))
            if (inRange(
              p.at,
              _from,
              DateTime(_to.year, _to.month, _to.day + 1),
            ))
              p,
        ];
        final png = await curvePng(
          points,
          _from,
          DateTime(_to.year, _to.month, _to.day + 1),
          reportColour(i),
          locale,
        );
        if (png != null) curves.add((def: def, png: png));
      }
      final fonts = await pdfFontsFor(language);
      if (!mounted) return;
      final doc = vetReportPdf(
        t: t,
        store: store,
        catId: widget.catId,
        fields: fields,
        entries: entries,
        curves: curves,
        summary: _summary,
        locale: locale,
        fonts: fonts,
      );
      final name = store.current(widget.catId, Keys.name) ?? t.unnamed;
      await (widget.share ?? sharePdf)(doc, '$name ${t.vetReportTitle}.pdf');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final day = DateFormat.yMd(locale);
    final entries = _entries;
    return Scaffold(
      appBar: AppBar(title: Text(t.vetReportTitle)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            t.vetReportFields,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 2,
            children: [
              for (final d in _fields)
                FilterChip(
                  label: Text(fieldDefName(t, d)),
                  selected: _chosen.contains(d.key),
                  avatar: CircleAvatar(
                    backgroundColor: Color(reportColour(_fields.indexOf(d))),
                    radius: 5,
                  ),
                  onSelected: (on) => setState(() {
                    if (on) {
                      _chosen.add(d.key);
                    } else {
                      _chosen.remove(d.key);
                    }
                  }),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event),
                  title: Text(t.vetReportFrom),
                  subtitle: Text(day.format(_from)),
                  onTap: () => _pick(true),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event),
                  title: Text(t.vetReportTo),
                  subtitle: Text(day.format(_to)),
                  onTap: () => _pick(false),
                ),
              ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _summary,
            onChanged: (v) => setState(() => _summary = v),
            title: Text(t.vetReportSummary),
          ),
          const Divider(),
          for (final e in entries)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              value: !_dropped.contains(e.seq),
              onChanged: (v) => setState(() {
                if (v == true) {
                  _dropped.remove(e.seq);
                } else {
                  _dropped.add(e.seq);
                }
              }),
              title: Text(
                '${fieldLabel(t, store, e.field)}: ${valueLabel(t, store, e.field, e.value)}',
              ),
              subtitle: Text(
                '${DateFormat.yMd(locale).add_Hm().format(e.date.toLocal())} · ${e.author}',
              ),
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
            onPressed: _busy || entries.isEmpty ? null : _share,
          ),
        ),
      ),
    );
  }
}
