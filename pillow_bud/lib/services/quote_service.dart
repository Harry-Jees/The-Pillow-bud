import '../models/quote_model.dart';

class QuoteService {
  static const List<Map<String, dynamic>> _mockDb = [
    // Motivation (10)
    {
      'id': 'q001',
      'text': 'The only way to do great work is to love what you do.',
      'author': 'Steve Jobs',
      'category': 'motivation',
      'emotionalImpact': 9,
      'isPopular': true,
      'dateAdded': '2024-01-01',
    },
    {
      'id': 'q002',
      'text': 'Believe you can and you\'re halfway there.',
      'author': 'Theodore Roosevelt',
      'category': 'motivation',
      'emotionalImpact': 8,
      'isPopular': true,
      'dateAdded': '2024-01-01',
    },
    {
      'id': 'q003',
      'text': 'It does not matter how slowly you go as long as you do not stop.',
      'author': 'Confucius',
      'category': 'motivation',
      'emotionalImpact': 8,
      'isPopular': true,
      'dateAdded': '2024-01-02',
    },
    {
      'id': 'q004',
      'text': 'Your present circumstances do not determine where you can go; they merely determine where you start.',
      'author': 'Nido Qubein',
      'category': 'motivation',
      'emotionalImpact': 7,
      'dateAdded': '2024-01-03',
    },
    // Hope (6)
    {
      'id': 'q005',
      'text': 'Hope is being able to see that there is light despite all of the darkness.',
      'author': 'Desmond Tutu',
      'category': 'hope',
      'emotionalImpact': 9,
      'isPopular': true,
      'dateAdded': '2024-01-04',
    },
    {
      'id': 'q006',
      'text': 'Storms make trees take deeper roots.',
      'author': 'Dolly Parton',
      'category': 'hope',
      'emotionalImpact': 7,
      'dateAdded': '2024-01-05',
    },
    {
      'id': 'q007',
      'text': 'Every day may not be good, but there is something good in every day.',
      'author': 'Alice Morse Earle',
      'category': 'hope',
      'emotionalImpact': 8,
      'isPopular': true,
      'dateAdded': '2024-01-06',
    },
    // Strength (6)
    {
      'id': 'q008',
      'text': 'You never know how strong you are until being strong is your only choice.',
      'author': 'Bob Marley',
      'category': 'strength',
      'emotionalImpact': 9,
      'isPopular': true,
      'dateAdded': '2024-01-07',
    },
    {
      'id': 'q009',
      'text': 'The world breaks everyone, and afterward, some are strong at the broken places.',
      'author': 'Ernest Hemingway',
      'category': 'strength',
      'emotionalImpact': 8,
      'dateAdded': '2024-01-08',
    },
    {
      'id': 'q010',
      'text': 'You are stronger than you think.',
      'author': 'Unknown',
      'category': 'strength',
      'emotionalImpact': 9,
      'isPopular': true,
      'dateAdded': '2024-01-09',
    },
    // Calm (5)
    {
      'id': 'q011',
      'text': 'Peace comes from within. Do not seek it without.',
      'author': 'Buddha',
      'category': 'calm',
      'emotionalImpact': 9,
      'dateAdded': '2024-01-10',
    },
    {
      'id': 'q012',
      'text': 'Almost everything will work again if you unplug it for a few minutes, including you.',
      'author': 'Anne Lamott',
      'category': 'calm',
      'emotionalImpact': 7,
      'dateAdded': '2024-01-11',
    },
    {
      'id': 'q013',
      'text': 'The greatest weapon against stress is our ability to choose one thought over another.',
      'author': 'William James',
      'category': 'calm',
      'emotionalImpact': 8,
      'isPopular': true,
      'dateAdded': '2024-01-12',
    },
    // Self-love (5)
    {
      'id': 'q014',
      'text': 'You yourself, as much as anybody in the entire universe, deserve your love and affection.',
      'author': 'Buddha',
      'category': 'self-love',
      'emotionalImpact': 9,
      'isPopular': true,
      'dateAdded': '2024-01-13',
    },
    {
      'id': 'q015',
      'text': 'Be gentle with yourself. You are doing the best you can.',
      'author': 'Unknown',
      'category': 'self-love',
      'emotionalImpact': 8,
      'dateAdded': '2024-01-14',
    },
    // Perspective (5)
    {
      'id': 'q016',
      'text': 'The darker the night, the brighter the stars.',
      'author': 'Fyodor Dostoevsky',
      'category': 'perspective',
      'emotionalImpact': 8,
      'dateAdded': '2024-01-15',
    },
    {
      'id': 'q017',
      'text': 'This too shall pass.',
      'author': 'Persian Proverb',
      'category': 'perspective',
      'emotionalImpact': 8,
      'isPopular': true,
      'dateAdded': '2024-01-16',
    },
    // Connection (4)
    {
      'id': 'q018',
      'text': 'You are not alone. You are seen. You are heard. You matter.',
      'author': 'Unknown',
      'category': 'connection',
      'emotionalImpact': 9,
      'dateAdded': '2024-01-17',
    },
    {
      'id': 'q019',
      'text': 'The best way to find yourself is to lose yourself in the service of others.',
      'author': 'Mahatma Gandhi',
      'category': 'connection',
      'emotionalImpact': 7,
      'dateAdded': '2024-01-18',
    },
    // Mindfulness (3)
    {
      'id': 'q020',
      'text': 'Be where you are, not where you think you should be.',
      'author': 'Unknown',
      'category': 'mindfulness',
      'emotionalImpact': 8,
      'dateAdded': '2024-01-19',
    },
    {
      'id': 'q021',
      'text': 'The present moment is filled with joy and happiness. If you are attentive, you will see it.',
      'author': 'Thich Nhat Hanh',
      'category': 'mindfulness',
      'emotionalImpact': 8,
      'dateAdded': '2024-01-20',
    },
    // Acceptance (3)
    {
      'id': 'q022',
      'text': 'Grant me the serenity to accept the things I cannot change, courage to change the things I can, and wisdom to know the difference.',
      'author': 'Reinhold Niebuhr',
      'category': 'acceptance',
      'emotionalImpact': 9,
      'isPopular': true,
      'dateAdded': '2024-01-21',
    },
    {
      'id': 'q023',
      'text': 'Let go of the illusion of control. Some things are not meant to be fixed, they are meant to be felt.',
      'author': 'Unknown',
      'category': 'acceptance',
      'emotionalImpact': 8,
      'dateAdded': '2024-01-22',
    },
    // Action (3)
    {
      'id': 'q024',
      'text': 'The journey of a thousand miles begins with one step.',
      'author': 'Lao Tzu',
      'category': 'action',
      'emotionalImpact': 8,
      'isPopular': true,
      'dateAdded': '2024-01-23',
    },
    {
      'id': 'q025',
      'text': 'You don\'t have to be great to start, but you have to start to be great.',
      'author': 'Zig Ziglar',
      'category': 'action',
      'emotionalImpact': 9,
      'isPopular': true,
      'dateAdded': '2024-01-24',
    },
  ];

  static Quote getDailyQuote() {
    final now = DateTime.now();
    final index = (now.year + now.month + now.day) % _mockDb.length;
    return Quote.fromJson(_mockDb[index]);
  }

  static Quote getRandomQuote() {
    final now = DateTime.now();
    final index = now.microsecondsSinceEpoch % _mockDb.length;
    return Quote.fromJson(_mockDb[index]);
  }

  static Quote getQuoteByCategory(String category) {
    final filtered = _mockDb.where((q) => q['category'] == category).toList();
    if (filtered.isEmpty) return getDailyQuote();
    final now = DateTime.now();
    final index = now.microsecondsSinceEpoch % filtered.length;
    return Quote.fromJson(filtered[index]);
  }

  static List<Quote> getTopQuotes({int limit = 5}) {
    return _mockDb
        .where((q) => q['isPopular'] == true)
        .take(limit)
        .map((q) => Quote.fromJson(q))
        .toList();
  }
}