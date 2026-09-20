import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'crash_guard.dart';
import 'l10n.dart';

/// Everything the app has to say lands at the top of the screen, under
/// the status bar and above every page: one note at a time, the rest
/// waiting behind it. A note is a job that finished, a job that failed,
/// or changes waiting to be merged; a tap opens what it is about.
///
/// Swipe left shows the next note, swipe right clears the news and
/// leaves the failures; a failure goes only by swipe left or tap. A
/// finished job leaves on its own after [NoteQueue.doneDwell]. Nothing
/// ever comes from the bottom, where the gestures and the keyboard live.

enum NoteKind {
  /// Changes wait somewhere; tapping acts on them.
  waiting,

  /// A job finished cleanly; tapping opens the details when there are any.
  done,

  /// A job failed; tapping opens the cause, the fix and a way to report.
  failed,
}

/// One announcement. [text] reads in the ambient language when the
/// strip draws it, so a note added by a timer still speaks the language
/// the keeper picks later.
class Note {
  final NoteKind kind;
  final String Function(AppLocalizations t) text;

  /// What a tap opens; nothing when null.
  final VoidCallback? onTap;

  /// Told when the note leaves without its tap — swiped, cleared, timed
  /// out. The sync watcher uses it to stay quiet until more arrives.
  final VoidCallback? onGone;

  /// The full error text of a failed job, for its dialog.
  final String? detail;

  /// The page a failure belongs to, opened from its dialog.
  final String Function(AppLocalizations t)? pageLabel;
  final VoidCallback? onOpenPage;

  Note.waiting(this.text, {required VoidCallback this.onTap, this.onGone})
      : kind = NoteKind.waiting,
        detail = null,
        pageLabel = null,
        onOpenPage = null;

  Note.done(this.text, {this.onTap})
      : kind = NoteKind.done,
        onGone = null,
        detail = null,
        pageLabel = null,
        onOpenPage = null;

  Note.failed(this.text, {this.detail, this.pageLabel, this.onOpenPage})
      : kind = NoteKind.failed,
        onTap = null,
        onGone = null;
}

/// The notes on screen, oldest first; the first one is the visible one.
/// A global: the announcements come from timers, background merges and
/// pages that are already gone.
class NoteQueue extends ChangeNotifier {
  static final NoteQueue instance = NoteQueue();

  /// How long a finished job stays once it is the visible note.
  static const doneDwell = Duration(seconds: 3);

  final List<Note> notes = [];
  Timer? _dwell;
  Note? _dwelling;

  Note? get visible => notes.firstOrNull;
  bool get more => notes.length > 1;

  void add(Note note) {
    // One thing waits at a time: a newer waiting note replaces the old.
    if (note.kind == NoteKind.waiting) {
      notes.removeWhere((n) => n.kind == NoteKind.waiting);
    }
    notes.add(note);
    _changed();
  }

  /// Swipe left: the visible note goes, the next one shows.
  void next() {
    final note = visible;
    if (note == null) return;
    notes.removeAt(0);
    note.onGone?.call();
    _changed();
  }

  /// Swipe right: every note that is not a failure goes.
  void clearNews() {
    final news = [for (final n in notes) if (n.kind != NoteKind.failed) n];
    if (news.isEmpty) return;
    notes.removeWhere(news.contains);
    for (final n in news) {
      n.onGone?.call();
    }
    _changed();
  }

  /// The note was tapped: it leaves, its tap runs.
  void open(Note note) {
    if (!notes.remove(note)) return;
    _changed();
    note.onTap?.call();
  }

  /// The note's reason is gone — a manual sync took what waited.
  void remove(Note note) {
    if (notes.remove(note)) _changed();
  }

  /// Nothing said any more: the app switched catalogs, or a test ends.
  void clear() {
    if (notes.isEmpty) return;
    notes.clear();
    _changed();
  }

  /// The visible finished note dwells, then goes; the timer runs only
  /// while the note is the visible one, so nothing leaves unseen.
  void _changed() {
    final top = visible;
    if (top != _dwelling) {
      _dwell?.cancel();
      _dwell = null;
      _dwelling = null;
      if (top != null && top.kind == NoteKind.done) {
        _dwelling = top;
        _dwell = Timer(doneDwell, () {
          if (visible == top) next();
        });
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _dwell?.cancel();
    super.dispose();
  }
}

/// Which running flows show on the activity line, with their icon.
/// Flows without an entry (a camera, a share sheet) are on screen
/// themselves and need no line.
const activityIcons = <String, IconData>{
  'folderSync': Icons.folder_copy_outlined,
  'lanSync': Icons.phonelink_ring_outlined,
  'bundleImport': Icons.file_download_outlined,
  'backup': Icons.backup_outlined,
  'restore': Icons.settings_backup_restore,
  'archive': Icons.archive_outlined,
};

/// The strip over every page: the activity line while jobs run, the
/// visible note under it, [child] pushed down below.
class NoteStrip extends StatelessWidget {
  final NoteQueue queue;

  /// The keys of the flows running now (`busyFlows` in the app).
  final ValueListenable<Set<String>> busy;

  /// Where a failure's dialog opens: the navigator's context, which the
  /// strip, sitting above the navigator, has none of its own. A strip
  /// inside a page (a test) leaves it out and uses its own.
  final BuildContext Function()? openIn;
  final Widget child;

  const NoteStrip({
    super.key,
    required this.queue,
    required this.busy,
    this.openIn,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: queue,
        builder: (context, _) {
          final note = queue.visible;
          return Stack(
            children: [
              Column(
                children: [
                  // The page moves down slowly enough to be noticed
                  // before it moves under a thumb.
                  AnimatedSize(
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeIn,
                    alignment: Alignment.topCenter,
                    child: note == null
                        ? const SizedBox(width: double.infinity)
                        : _NoteLine(
                            key: ObjectKey(note),
                            note: note,
                            more: queue.more,
                            onLeft: queue.next,
                            onRight: queue.clearNews,
                            onTap: () => _open(context, note),
                          ),
                  ),
                  Expanded(
                    // The note took the status bar's height; the page
                    // must not pad for it again.
                    child: note == null
                        ? child
                        : MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: child,
                          ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.paddingOf(context).top,
                left: 0,
                right: 0,
                child: ActivityLine(busy: busy),
              ),
            ],
          );
        },
      );

  void _open(BuildContext context, Note note) {
    if (note.kind == NoteKind.failed) {
      queue.open(note);
      showFailureDialog(openIn?.call() ?? context, note);
    } else if (note.onTap != null) {
      queue.open(note);
    }
  }
}

class _NoteLine extends StatelessWidget {
  final Note note;
  final bool more;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onTap;

  const _NoteLine({
    super.key,
    required this.note,
    required this.more,
    required this.onLeft,
    required this.onRight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final failed = note.kind == NoteKind.failed;
    final ground = failed ? scheme.errorContainer : scheme.primaryContainer;
    final ink = failed ? scheme.onErrorContainer : scheme.onPrimaryContainer;
    final icon = switch (note.kind) {
      NoteKind.waiting => Icons.folder_copy_outlined,
      NoteKind.done => Icons.check_circle_outline,
      NoteKind.failed => Icons.error_outline,
    };
    return Dismissible(
      key: ObjectKey(note),
      direction: DismissDirection.horizontal,
      // A failure survives the swipe right that clears the news.
      confirmDismiss: (direction) async =>
          !(failed && direction == DismissDirection.startToEnd),
      onDismissed: (direction) =>
          direction == DismissDirection.endToStart ? onLeft() : onRight(),
      child: Material(
        color: ground,
        child: InkWell(
          onTap: failed || note.onTap != null ? onTap : null,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(icon, color: ink),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(note.text(t), style: TextStyle(color: ink)),
                      ),
                    ],
                  ),
                  // More wait behind this one: a mark, no count — the
                  // queue grows while you swipe.
                  SizedBox(
                    height: 10,
                    child: more
                        ? Text(
                            '…',
                            style: TextStyle(
                              color: ink,
                              height: 0.6,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A thin pulsing line with one icon per running job. It covers three
/// pixels of the page rather than pushing it: nothing on it is read.
class ActivityLine extends StatelessWidget {
  final ValueListenable<Set<String>> busy;

  const ActivityLine({super.key, required this.busy});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: busy,
        builder: (context, running, _) {
          final icons = [
            for (final MapEntry(:key, :value) in activityIcons.entries)
              if (running.contains(key)) value,
          ];
          if (icons.isEmpty) return const SizedBox.shrink();
          return _Pulse(icons: icons);
        },
      );
}

class _Pulse extends StatefulWidget {
  final List<IconData> icons;

  const _Pulse({required this.icons});

  @override
  State<_Pulse> createState() => _PulseState();
}

class _PulseState extends State<_Pulse> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FadeTransition(
      opacity: Tween(begin: 0.35, end: 1.0).animate(_controller),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(height: 3, color: scheme.primary),
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final icon in widget.icons)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(icon, size: 14, color: scheme.primary),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A failure's dialog: the sentence, the full text, Close and Report;
/// the page it belongs to as a line inside, not a third button.
Future<void> showFailureDialog(BuildContext context, Note note) {
  final t = context.t;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(note.text(t)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.detail case final detail?) SelectableText(detail),
            if (note.onOpenPage != null && note.pageLabel != null) ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  note.onOpenPage!();
                },
                child: Text(
                  t.failureOpenPage(note.pageLabel!(t)),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            mailCrashReport('${note.text(t)}\n\n${note.detail ?? ''}');
          },
          child: Text(t.failureReport),
        ),
      ],
    ),
  );
}
