import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/notes.dart';

/// What the notes at the top say right now, in English — for tests that
/// pump a page on its own, without the strip that would draw them.
Iterable<String> notesSaid() =>
    NoteQueue.instance.notes.map((n) => n.text(AppLocalizationsEn()));
