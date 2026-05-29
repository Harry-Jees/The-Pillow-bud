class EmotionDetector {
  static const Map<String, List<String>> _keywords = {
    'overwhelmed': ['overwhelmed', 'too much', 'can\'t handle', 'drowning'],
    'anxious': ['anxious', 'anxiety', 'nervous', 'worried', 'scared', 'panic'],
    'sad': ['sad', 'depressed', 'down', 'empty', 'hopeless', 'crying'],
    'lonely': ['lonely', 'alone', 'isolated', 'no one', 'disconnected'],
    'stressed': ['stressed', 'stress', 'pressure', 'busy', 'tense', 'overwhelm'],
    'angry': ['angry', 'furious', 'mad', 'rage', 'frustrated', 'annoyed'],
    'hopeful': ['hopeful', 'better', 'improving', 'optimistic', 'looking forward'],
    'calm': ['calm', 'peaceful', 'relaxed', 'centered', 'grounded', 'okay'],
    'confused': ['confused', 'lost', 'uncertain', 'unsure', 'don\'t know'],
    'happy': ['happy', 'great', 'wonderful', 'excited', 'joy', 'good'],
  };

  static String detect(String message) {
    final lower = message.toLowerCase();
    for (final entry in _keywords.entries) {
      for (final kw in entry.value) {
        if (lower.contains(kw)) return entry.key;
      }
    }
    return 'neutral';
  }
}
