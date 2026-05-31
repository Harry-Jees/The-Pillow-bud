import 'package:isar/isar.dart';

part 'chat_message.g.dart';

@Collection()
class ChatMessage {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String text;
  late bool isFromBud;
  late DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromBud,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isFromBud': isFromBud,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'] as String,
    text: json['text'] as String,
    isFromBud: json['isFromBud'] as bool,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
}
