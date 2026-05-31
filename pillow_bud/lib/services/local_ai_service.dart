abstract class LocalAIService {
  Future<void> initialize();
  bool get isReady;
  String? get error => null;
  String get status => '';
  String get name => 'AI';
  Future<String> generateResponse({
    required String systemPrompt,
    required String userMessage,
    String? recentContext,
  });
}
