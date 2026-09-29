import 'package:catlog/l10n/app_localizations.dart';
import 'package:catlog/l10n/app_localizations_en.dart';
import 'package:catlog/src/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The notes at the top: one at a time, the rest behind it; swipe left
/// for the next, swipe right clears the news and leaves the failures; a
/// finished job leaves on its own; the page below moves down.
void main() {
  late NoteQueue notes;

  setUp(() => notes = NoteQueue());
  tearDown(() => notes.dispose());

  Note done(String text, {VoidCallback? onTap}) =>
      Note.done((_) => text, onTap: onTap);
  Note failed(String text, {String? detail}) =>
      Note.failed((_) => text, detail: detail);

  test('one visible, the rest wait; next shows them in order', () {
    notes.add(done('a'));
    notes.add(failed('b'));
    notes.add(done('c'));
    expect(notes.visible!.text(_none), 'a');
    expect(notes.more, isTrue);
    notes.next();
    expect(notes.visible!.text(_none), 'b');
    notes.next();
    expect(notes.visible!.text(_none), 'c');
    expect(notes.more, isFalse);
    notes.next();
    expect(notes.visible, isNull);
    notes.next(); // nothing behind: nothing happens
    expect(notes.visible, isNull);
  });

  test('clearing the news leaves the failures', () {
    var gone = 0;
    notes.add(done('a'));
    notes.add(failed('b'));
    notes.add(Note.waiting((_) => 'w', onTap: () {}, onGone: () => gone++));
    notes.clearNews();
    expect(notes.notes.map((n) => n.text(_none)), ['b']);
    expect(gone, 1);
  });

  test('a newer waiting note replaces the older one', () {
    notes.add(Note.waiting((_) => 'first', onTap: () {}));
    notes.add(done('a'));
    notes.add(Note.waiting((_) => 'second', onTap: () {}));
    expect(notes.notes.map((n) => n.text(_none)), ['a', 'second']);
  });

  test('a tap removes the note and runs its action', () {
    var opened = 0;
    final note = done('a', onTap: () => opened++);
    notes.add(note);
    notes.open(note);
    expect(notes.visible, isNull);
    expect(opened, 1);
  });

  // The strip sits above the navigator, as in the app: a failure's
  // dialog opens in the navigator's context.
  final nav = GlobalKey<NavigatorState>();
  Future<void> pump(WidgetTester tester, {Set<String> busy = const {}}) =>
      tester.pumpWidget(
        MaterialApp(
          navigatorKey: nav,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => NoteStrip(
            queue: notes,
            busy: ValueNotifier(busy),
            openIn: () => nav.currentContext!,
            child: child!,
          ),
          home: const Scaffold(body: Text('page')),
        ),
      );

  testWidgets('a finished job leaves on its own, once the strip showed it',
      (tester) async {
    await pump(tester);
    notes.add(failed('f'));
    notes.add(done('d'));
    await tester.pump(const Duration(seconds: 10));
    expect(notes.notes, hasLength(2)); // behind a failure: still there
    notes.next();
    await tester.pumpAndSettle();
    expect(find.text('d'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(notes.visible, isNotNull);
    await tester.pump(const Duration(seconds: 2));
    expect(notes.visible, isNull);
  });

  testWidgets('the strip pushes the page down and marks what waits',
      (tester) async {
    await pump(tester);
    final before = tester.getTopLeft(find.text('page'));
    notes.add(done('Backup done'));
    notes.add(done('Later'));
    await tester.pumpAndSettle();
    expect(find.text('Backup done'), findsOneWidget);
    expect(find.text('…'), findsOneWidget);
    expect(tester.getTopLeft(find.text('page')).dy, greaterThan(before.dy));
    // Swipe left: the next one, no mark any more.
    await tester.drag(find.text('Backup done'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Later'), findsOneWidget);
    expect(find.text('…'), findsNothing);
    await tester.drag(find.text('Later'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.text('page')), before);
  });

  testWidgets('a swipe right clears the news and the failure stays',
      (tester) async {
    await pump(tester);
    notes.add(done('News'));
    notes.add(failed('Backup failed'));
    await tester.pumpAndSettle();
    await tester.drag(find.text('News'), const Offset(500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Backup failed'), findsOneWidget);
    // The failure shrugs off a swipe right and goes on a swipe left.
    await tester.drag(find.text('Backup failed'), const Offset(500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Backup failed'), findsOneWidget);
    await tester.drag(find.text('Backup failed'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Backup failed'), findsNothing);
  });

  testWidgets('a failure opens its dialog with the full text and Report',
      (tester) async {
    await pump(tester);
    notes.add(failed('Backup failed', detail: 'disk full'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Backup failed'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('disk full'), findsOneWidget);
    expect(find.text('Report'), findsOneWidget);
    expect(notes.visible, isNull);
  });

  testWidgets('the activity line shows an icon per running job',
      (tester) async {
    await pump(tester, busy: {'folderSync', 'backup', 'imagePicker'});
    expect(find.byIcon(activityIcons['folderSync']!), findsOneWidget);
    expect(find.byIcon(activityIcons['backup']!), findsOneWidget);
    expect(find.byType(ActivityLine), findsOneWidget);
    // Two shown, the picker has no place on the line.
    expect(find.descendant(
      of: find.byType(ActivityLine),
      matching: find.byType(Icon),
    ), findsNWidgets(2));
    // Something not tested: the pulse repeats, so no pumpAndSettle here.
    await tester.pump(const Duration(seconds: 1));
  });
}

/// Notes in these tests carry their words themselves.
final AppLocalizations _none = AppLocalizationsEn();
