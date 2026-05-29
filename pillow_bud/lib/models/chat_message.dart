class ChatMessage {
  final String id;
  final String text;
  final bool isFromBud;
  final DateTime timestamp;

  ChatMessage({required this.id, required this.text, required this.isFromBud, required this.timestamp});
}
