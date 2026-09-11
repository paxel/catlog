import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../field_editing.dart';
import '../history_share.dart';
import '../l10n.dart';
import '../screens/field_history_screen.dart';
import '../widgets/date_entry.dart';

/// Remembered on this device: whether the log reads oldest first.
const choreLogOldestFirstKey = 'choreLogOldestFirst';

/// The chore's log, day by day: done when and by whom, missed, or still
/// open — the page a medicine needs. Newest first, or oldest first on
/// request; shareable as text. A long press on a done day corrects its
/// moment or removes the tick; removed ticks show on request and can be
/// restored.
class ChoreHistoryScreen extends StatefulWidget {
  final CatalogStore store;
  final Chore chore;

  const ChoreHistoryScreen({
    super.key,
    required this.store,
    required this.chore,
  });

  @override
  State<ChoreHistoryScreen> createState() => _ChoreHistoryScreenState();
}

class _ChoreHistoryScreenState extends State<ChoreHistoryScreen> {
  CatalogStore get store => widget.store;

  bool get _oldestFirst => store.localSetting(choreLogOldestFirstKey) == 'yes';

  bool get _showVoided => store.localSetting(historyShowVoidedKey) == 'yes';

  List<ChoreLogRow> get _rows {
    final rows = store.choreLog(widget.chore, DateTime.now());
    return _oldestFirst ? rows.reversed.toList() : rows;
  }

  String get _entity => store.resolveEntity(widget.chore.entity);

  /// The removed tick of a day that no longer reads done, if any.
  Entry? _voidedTick(ChoreLogRow r) {
    if (r.tick != null) return null;
    return store
        .fieldHistory(_entity, Keys.choreTick(widget.chore.id, dayKey(r.due)),
            includeVoided: true)
        .where((e) => e.voided && e.value != null)
        .firstOrNull;
  }

  String _line(AppLocalizations t, String locale, ChoreLogRow r) {
    final day = DateFormat.yMEd(locale);
    switch (r.state) {
      case ChoreDay.done:
        final when = r.tick == null
            ? day.format(r.doneOn!)
            : historyMoment(locale, r.tick!.date);
        final base = t.choreDoneAt(when, r.author ?? '');
        if (r.early) return '$base · ${t.choreDoneEarly}';
        if (r.late) return '$base · ${t.choreDoneLate}';
        return base;
      case ChoreDay.missed:
        return t.choreMissed;
      case ChoreDay.pending:
        return t.choreStillOpen;
      default:
        return '';
    }
  }

  /// The removed tick's line under a day, when hidden values show.
  String? _voidedText(AppLocalizations t, String locale, ChoreLogRow r) {
    if (!_showVoided) return null;
    final tick = _voidedTick(r);
    if (tick == null) return null;
    final when = historyMoment(locale, tick.date);
    return '${t.choreDoneAt(when, tick.author)} · '
        '${voidedLine(t, store, tick.field, tick, locale)}';
  }

  Future<void> _correct(Entry tick) async {
    var moment = tick.date.toLocal();
    final day = await pickDay(
      context,
      initial: moment,
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (day == null || !mounted) return;
    moment = withTimeOf(day, moment);
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(moment),
    );
    if (!mounted) return;
    if (time != null) {
      moment = DateTime(
          moment.year, moment.month, moment.day, time.hour, time.minute);
    }
    store.correctEntry(tick.seq, dayKey(dayOf(moment)), date: moment);
    setState(() {});
  }

  void _menu(ChoreLogRow r) {
    final t = context.t;
    final tick = r.tick;
    final removed = _voidedTick(r);
    if (tick == null && removed == null) return;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheet) => SafeArea(
        child: Wrap(
          children: [
            if (tick != null) ...[
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: Text(t.correctThisValue),
                onTap: () {
                  Navigator.of(sheet).pop();
                  _correct(tick);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(t.removeThisValue),
                onTap: () {
                  Navigator.of(sheet).pop();
                  store.removeEntry(tick.seq);
                  setState(() {});
                },
              ),
            ] else
              ListTile(
                leading: const Icon(Icons.restore),
                title: Text(t.restoreThisValue),
                onTap: () {
                  Navigator.of(sheet).pop();
                  store.restoreEntry(removed!.seq);
                  setState(() {});
                },
              ),
          ],
        ),
      ),
    );
  }

  List<HistoryLine> _lines(AppLocalizations t, String locale) => [
    for (final r in _rows)
      (
        when: DateFormat.yMEd(locale).format(r.due),
        value: _line(t, locale, r),
        who: r.author ?? '',
        note: _voidedText(t, locale, r) ?? '',
      ),
  ];

  String get _name =>
      store.current(widget.chore.entity, Keys.name) ?? context.t.unnamed;

  Future<void> _copy() {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    return copyText(
      context,
      historyText(widget.chore.title, _name, _lines(t, locale)),
    );
  }

  Future<void> _sharePdf() async {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final doc = historyPdf(
      title: widget.chore.title,
      subtitle: _name,
      lines: _lines(t, locale),
      whenHeader: t.colWhen,
      valueHeader: t.colValue,
      whoHeader: t.colWho,
    );
    await sharePdf(doc, '$_name ${widget.chore.title}.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final name = store.current(widget.chore.entity, Keys.name) ?? t.unnamed;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.chore.title} · $name'),
        actions: [
          IconButton(
            icon: Icon(
              _oldestFirst ? Icons.arrow_upward : Icons.arrow_downward,
            ),
            tooltip: _oldestFirst ? t.sortNewestFirst : t.sortOldestFirst,
            onPressed: () {
              store.setLocalSetting(
                choreLogOldestFirstKey,
                _oldestFirst ? 'no' : 'yes',
              );
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(
              _showVoided ? Icons.visibility_off_outlined : Icons.visibility,
            ),
            tooltip: _showVoided ? t.hideRemovedValues : t.showRemovedValues,
            onPressed: () {
              store.setLocalSetting(
                historyShowVoidedKey,
                _showVoided ? 'no' : 'yes',
              );
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.copy_outlined),
            tooltip: t.copyText,
            onPressed: _copy,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            tooltip: t.shareAsPdf,
            onPressed: _sharePdf,
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final r in _rows)
            ListTile(
              onLongPress: () => _menu(r),
              leading: Icon(
                switch (r.state) {
                  ChoreDay.done => Icons.check_circle,
                  ChoreDay.missed => Icons.cancel_outlined,
                  _ => Icons.radio_button_unchecked,
                },
                color: switch (r.state) {
                  ChoreDay.done => Colors.green,
                  ChoreDay.missed => theme.colorScheme.error,
                  _ => null,
                },
              ),
              title: Text(DateFormat.yMEd(locale).format(r.due)),
              subtitle: Text(switch (_voidedText(t, locale, r)) {
                final gone? => '${_line(t, locale, r)}\n$gone',
                null => _line(t, locale, r),
              }),
              isThreeLine: _voidedText(t, locale, r) != null,
            ),
        ],
      ),
    );
  }
}
