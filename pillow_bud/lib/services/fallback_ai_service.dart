import 'dart:math';
import 'local_ai_service.dart';
import 'emotion_detector.dart';

/// A lightweight rule-based fallback AI service that responds to users
/// when the Gemma native AI model is unavailable or not yet installed.
///
/// Works instantly on all platforms with no dependencies.
class FallbackAIService extends LocalAIService {
  final Random _random;

  FallbackAIService({Random? random}) : _random = random ?? Random();

  static const _responses = <String, List<String>>{
    'overwhelmed': [
      "It sounds like there's a lot on your plate right now. Let's take it one step at a time. What feels most pressing?",
      "I hear how much is weighing on you. Sometimes just naming what's overwhelming can help it feel a little smaller. Want to talk through it?",
      "That sounds really heavy. You don't have to figure everything out at once. I'm here to listen.",
    ],
    'anxious': [
      "I can feel the worry in your words. Take a slow breath with me — we're in no rush. What's at the front of your mind?",
      "Anxiety can be so loud sometimes. Let's sit with it for a moment. What does it feel like in your body right now?",
      "It's okay to feel nervous. You're safe here. Want to tell me more about what's scaring you?",
    ],
    'sad': [
      "I'm really sorry you're feeling this way. You don't have to go through it alone. I'm right here.",
      "That sounds deeply painful. It takes courage to share that. Would it help to talk more about it?",
      "Sadness is so valid. You don't need to cheer up or fix anything right now. Just let yourself feel.",
    ],
    'lonely': [
      "Feeling alone is incredibly tough. I want you to know that your feelings matter, and you deserve connection.",
      "It hurts to feel disconnected. I'm here with you right now. What does loneliness feel like for you today?",
      "You're not alone in this moment. I'm listening. Sometimes sharing the little things can help bridge that gap.",
    ],
    'stressed': [
      "Stress can really build up. Let's try to unpack it a bit. What's contributing the most to how you're feeling?",
      "You've been carrying a lot. It's okay to pause and just breathe for a moment. What do you need right now?",
      "I can hear the pressure you're under. Sometimes the smallest step forward is still progress.",
    ],
    'confused': [
      "It's okay not to have things figured out. Let's explore this together. What part feels most unclear?",
      "Confusion is part of the process. You don't need to have answers right now. What's at the heart of it?",
      "That sounds like a lot to process. Sometimes just talking it through can bring clarity. Tell me more.",
    ],
    'hopeful': [
      "That's beautiful. It means a lot that you're sharing something positive. What's bringing you this sense of hope?",
      "I love that energy! Hope can be such a gentle but powerful force. Hold onto that feeling.",
      "It's so good to hear something uplifting. What's one thing that's giving you that positive outlook?",
    ],
    'calm': [
      "That sense of peace is precious. I'm glad you're in a good space right now. What's helping you feel grounded?",
      "It's wonderful to hear you're feeling at ease. Moments like these are worth savoring.",
      "Calm is a beautiful place to be. Enjoy it — you deserve these moments of peace.",
    ],
    'angry': [
      "Your anger is valid. Something clearly matters to you. Want to tell me what happened?",
      "I can hear the frustration. You don't have to calm down for me. Let it out — I'm here to listen.",
      "It sounds like a boundary was crossed or something really got to you. What's the story behind this feeling?",
    ],
    'neutral': [
      "I'm here and I'm listening. Tell me whatever's on your mind — no judgment, just presence.",
      "Thanks for checking in. How are things feeling for you right now?",
      "I'm glad you're here. Take your time — there's no rush. What would you like to talk about?",
    ],
  };

  static const _defaultResponses = [
    "Thank you for sharing that with me. I want to understand more. Can you tell me a bit more about how that feels?",
    "I'm really glad you're talking to me. Sometimes just getting things off your chest can make a difference.",
    "That makes sense. I want to sit with you in this moment. What else is coming up for you?",
    "I appreciate you being open with me. You don't have to have answers — just being here is enough.",
    "You're doing something really brave by expressing yourself. I'm here to support you however I can.",
  ];

  @override
  Future<void> initialize() async {
    // No initialization needed
  }

  @override
  bool get isReady => true;

  @override
  String get name => 'Fallback';

  @override
  String get status => 'ready';

  @override
  Future<String> generateResponse({
    required String systemPrompt,
    required String userMessage,
    String? recentContext,
  }) async {
    final emotion = EmotionDetector.detect(userMessage);
    final intensity = EmotionDetector.getIntensity(userMessage);

    final responses = _responses[emotion] ?? _defaultResponses;
    final response = responses[_random.nextInt(responses.length)];

    // For high intensity emotions, add more warmth
    if (intensity > 0.7 && emotion != 'calm' && emotion != 'hopeful') {
      return "$response\n\nI want you to know that what you're feeling is completely valid. You're not alone in this.";
    }

    return response;
  }
}
