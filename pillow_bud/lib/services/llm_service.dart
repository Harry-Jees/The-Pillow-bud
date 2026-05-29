import 'emotion_detector.dart';

class LLMService {
  static const Map<String, List<String>> _responses = {
    'overwhelmed': [
      'That sounds like a lot to carry. What feels most heavy right now?',
      'I hear you — this is a lot. Let\'s take it one thing at a time. What\'s the most pressing thing?',
    ],
    'anxious': [
      'That worry makes sense. What\'s actually happening right now, in this moment?',
      'Anxiety can feel so consuming. What\'s the specific thing your mind keeps going back to?',
    ],
    'sad': [
      'That\'s worth feeling sad about. I\'m here with you. What happened?',
      'Sadness is real and valid. You don\'t have to rush through it. Tell me more.',
    ],
    'lonely': [
      'Loneliness is one of the hardest feelings. You matter, and I\'m listening.',
      'I\'m here. You\'re not alone right now. What\'s been making you feel this way?',
    ],
    'stressed': [
      'That\'s genuinely stressful. What\'s the biggest thing weighing on you?',
      'Stress is a signal that something matters to you. What can you actually control here?',
    ],
    'angry': [
      'Your anger makes complete sense. What happened?',
      'That sounds really frustrating. What\'s underneath the anger for you?',
    ],
    'hopeful': [
      'That\'s wonderful to hear. What shifted for you?',
      'Hold onto that feeling. What\'s been helping you feel more hopeful?',
    ],
    'calm': [
      'I\'m glad you\'re feeling calm. What\'s been helping you feel this way?',
      'That peace is worth protecting. What brought you here today?',
    ],
    'confused': [
      'It\'s okay to not have it all figured out. What feels most unclear?',
      'Let\'s untangle this together. What\'s the part that confuses you most?',
    ],
    'happy': [
      'That\'s really good to hear! What\'s been going well?',
      'I love hearing that. Tell me more about what\'s making you happy.',
    ],
    'neutral': [
      'I\'m here and listening. What\'s on your mind?',
      'Tell me more. I\'m not going anywhere.',
      'How are you really feeling today?',
    ],
  };

  static Future<String> getResponse(String userMessage) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final emotion = EmotionDetector.detect(userMessage);
    final list = _responses[emotion] ?? _responses['neutral']!;
    return list[DateTime.now().second % list.length];
  }
}
