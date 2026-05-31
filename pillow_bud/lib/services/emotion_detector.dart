class EmotionDetector {
  static const Map<String, List<String>> _keywords = {
    'overwhelmed': [
      'overwhelmed', 'too much', "can't handle", 'drowning',
      'everything at once', 'stressed out', 'breaking down',
      "can't cope", 'too many things',
    ],
    'anxious': [
      'anxious', 'anxiety', 'nervous', 'worried', 'scared', 'afraid',
      'what if', 'panic', 'heart racing',
    ],
    'sad': [
      'sad', 'depressed', 'down', 'blue', 'lonely', 'empty',
      'numb', 'nothing matters', 'pointless', 'worthless', 'crying',
      'hopeless',
    ],
    'lonely': [
      'alone', 'isolated', 'no one understands', 'disconnected',
      'nobody cares', 'left out', 'by myself',
    ],
    'stressed': [
      'stressed', 'stress', 'pressure', 'deadlines', 'busy',
      "can't relax", 'tense', 'frustrated', 'irritated',
    ],
    'confused': [
      'confused', "don't understand", 'lost', 'unclear',
      "don't know", 'what do i do', 'mixed up',
    ],
    'hopeful': [
      'hopeful', 'getting better', 'improving', 'optimistic',
      'positive', 'feeling good', 'progress', 'excited',
      'looking forward',
    ],
    'calm': [
      'calm', 'relaxed', 'peaceful', 'serene', 'at ease',
      'grounded', 'centered', 'composed', 'okay',
    ],
    'angry': [
      'angry', 'furious', 'mad', 'rage', 'hate', 'infuriated',
      'pissed', 'betrayed', 'annoyed',
    ],
  };

  static const Map<String, double> _intensityMarkers = {
    'very': 1.5,
    'extremely': 1.7,
    'so': 1.3,
    'really': 1.2,
    'absolutely': 1.6,
    'completely': 1.5,
    'total': 1.4,
    'intense': 1.6,
    'unbearable': 1.8,
    "can't": 1.3,
  };

  static String detect(String message) {
    final lower = message.toLowerCase();
    final scores = <String, int>{};
    for (final entry in _keywords.entries) {
      int score = 0;
      for (final kw in entry.value) {
        if (lower.contains(kw)) {
          score += kw.length;
        }
      }
      if (score > 0) {
        scores[entry.key] = score;
      }
    }
    if (scores.isEmpty) return 'neutral';
    return scores.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  static double getIntensity(String message) {
    final words = message.toLowerCase().split(' ');
    double intensity = 0.5;
    for (final word in words) {
      if (_intensityMarkers.containsKey(word)) {
        intensity = (intensity + _intensityMarkers[word]!) / 2;
      }
    }
    return intensity.clamp(0.0, 1.0);
  }

  static String getRecommendedStyle(String emotion) {
    switch (emotion) {
      case 'overwhelmed':
      case 'anxious':
      case 'stressed':
      case 'angry':
        return 'gentle';
      case 'sad':
        return 'wise';
      case 'lonely':
      case 'confused':
        return 'curious';
      case 'hopeful':
      case 'calm':
        return 'balanced';
      default:
        return 'balanced';
    }
  }
}
