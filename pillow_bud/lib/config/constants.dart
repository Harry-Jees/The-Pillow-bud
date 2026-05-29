class AppConstants {
  static const String icallName = 'iCall India';
  static const String icallNumber = '9152987821';
  static const String vandrevalaName = 'Vandrevala Foundation';
  static const String vandrevalaNumber = '1860-2662-345';
  static const String aasraName = 'AASRA';
  static const String aasraNumber = '9820466726';

  static const List<String> crisisTriggers = [
    'kill myself', 'end my life', 'suicide', 'want to die',
    'better off dead', 'harm myself', 'cut myself', 'overdose',
    'no reason to live', 'can\'t go on', 'end it all',
  ];

  static const List<Map<String, String>> moods = [
    {'emoji': '😤', 'label': 'Stressed'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '😌', 'label': 'Calm'},
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😟', 'label': 'Anxious'},
  ];

  static const List<Map<String, String>> personalities = [
    {'key': 'gentle', 'label': 'Gentle', 'desc': 'Soft, validating'},
    {'key': 'curious', 'label': 'Curious', 'desc': 'Ask questions'},
    {'key': 'wise', 'label': 'Wise', 'desc': 'Reflective, thoughtful'},
    {'key': 'balanced', 'label': 'Balanced', 'desc': 'Mix of all (default)'},
  ];
}
