/// One immutable fact in the append-only log.
///
/// Entries are never updated or removed (ADR-0001). The displayed value of
/// a field is the entry with the highest ([date], [recorded], [author],
/// [seq]) for its (entity, field) pair — among entries that are not
/// [reminder]-flagged: a flagged entry is a plan, never a fact.
class Entry {
  /// Local insertion order — a local handle only (revert, UI). Differs
  /// between devices; never used for cross-device ordering.
  final int seq;

  /// Origin device id. Together with [dseq] globally unique and the
  /// basis of delta sync (ADR-0002).
  final String device;

  /// Per-origin-device monotonic counter.
  final int dseq;

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

  /// A plan, not a fact (#74): the entry names a due date but never
  /// becomes the current value — not even after the date passes, a
  /// missed appointment is not a treatment.
  final bool reminder;

  const Entry({
    required this.seq,
    required this.device,
    required this.dseq,
    required this.entity,
    required this.field,
    required this.value,
    required this.date,
    required this.author,
    required this.recorded,
    this.reminder = false,
  });

  @override
  String toString() =>
      'Entry($seq $entity $field=$value @${date.toIso8601String()} by $author)';

  /// Wire format for sync transports. `seq` is intentionally absent —
  /// it is a local handle; identity on the wire is (device, dseq).
  Map<String, dynamic> toJson() => {
        'device': device,
        'dseq': dseq,
        'entity': entity,
        'field': field,
        'value': value,
        'date': date.toIso8601String(),
        'author': author,
        'recorded': recorded.toIso8601String(),
        if (reminder) 'reminder': true,
      };

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        seq: -1,
        device: json['device'] as String,
        dseq: json['dseq'] as int,
        entity: json['entity'] as String,
        field: json['field'] as String,
        value: json['value'] as String?,
        date: DateTime.parse(json['date'] as String),
        author: json['author'] as String,
        recorded: DateTime.parse(json['recorded'] as String),
        // Absent in every pre-1.0.0 file and payload.
        reminder: json['reminder'] == true,
      );
}
