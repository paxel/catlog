/// One immutable fact in the append-only log.
///
/// Entries are never updated or removed (ADR-0001). The displayed value of
/// a field is the entry with the highest ([date], [recorded], [author],
/// [seq]) for its (entity, field) pair.
class Entry {
  /// Local insertion order; also the per-device log position for delta sync.
  final int seq;

  /// Entity id, e.g. `clowder:<uuid>` or `cat:<uuid>`.
  final String entity;

  /// Field key, e.g. `name`, `f:gender`, `$type`, `$image:<hash>`.
  final String field;

  /// The value as a string; `null` clears the field.
  final String? value;

  /// Effective date stated by the user — backdatable.
  final DateTime date;

  /// Author name the recording device was configured with.
  final String author;

  /// Wall clock at recording time; tiebreak after [date].
  final DateTime recorded;

  const Entry({
    required this.seq,
    required this.entity,
    required this.field,
    required this.value,
    required this.date,
    required this.author,
    required this.recorded,
  });

  @override
  String toString() =>
      'Entry($seq $entity $field=$value @${date.toIso8601String()} by $author)';
}
