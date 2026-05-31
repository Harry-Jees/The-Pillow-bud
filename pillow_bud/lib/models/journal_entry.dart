import 'package:isar/isar.dart';

part 'journal_entry.g.dart';

@Collection()
class JournalEntry {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String text;
  late String mood;
  late DateTime date;

  JournalEntry({
    required this.id,
    required this.text,
    required this.mood,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'mood': mood,
    'date': date.toIso8601String(),
  };

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
    id: json['id'] as String,
    text: json['text'] as String,
    mood: json['mood'] as String,
    date: DateTime.parse(json['date'] as String),
  );
}
