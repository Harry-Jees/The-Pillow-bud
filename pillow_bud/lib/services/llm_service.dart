import 'emotion_detector.dart';
import 'crisis_detector.dart';
import 'system_prompt_generator.dart';
import 'local_ai_service.dart';
import '../models/chat_message.dart';

class LLMService {
  LLMService._();

  static final instance = LLMService._();

  LocalAIService? _ai;

  void attachAI(LocalAIService service) {
    _ai = service;
  }

  bool get hasActiveAI => _ai?.isReady ?? false;

  String get aiName => _ai?.name ?? 'None';

  String? get aiError => _ai?.error;

  String get aiStatus => _ai?.status ?? '';

  Future<String> getResponse(
    String userMessage, {
    List<ChatMessage>? conversationHistory,
    String userName = 'Friend',
    String personalityMode = 'balanced',
  }) async {
    final detectedEmotion = EmotionDetector.detect(userMessage);
    final intensity = EmotionDetector.getIntensity(userMessage);

    if (CrisisDetector.detect(userMessage)) {
      return CrisisDetector.getCrisisResourceMessage();
    }

    final systemPrompt = SystemPromptGenerator.generatePrompt(
      userName: userName,
      personalityMode: personalityMode,
      detectedEmotion: detectedEmotion,
      emotionIntensity: intensity,
    );

    String? recentContext;
    if (conversationHistory != null && conversationHistory.length > 1) {
      final recent = conversationHistory.length > 6
          ? conversationHistory.sublist(conversationHistory.length - 6)
          : conversationHistory;
      recentContext = recent
          .map((m) => '${m.isFromBud ? 'Bud' : 'User'}: ${m.text}')
          .join('\n');
    }

    final emotionContext = detectedEmotion != 'neutral'
        ? '[User seems to be feeling $detectedEmotion (intensity: ${(intensity * 100).toStringAsFixed(0)}%)] $userMessage'
        : userMessage;

    if (_ai != null && _ai!.isReady) {
      return await _ai!.generateResponse(
        systemPrompt: systemPrompt,
        userMessage: emotionContext,
        recentContext: recentContext,
      );
    }

    throw StateError('AI not available');
  }
}
