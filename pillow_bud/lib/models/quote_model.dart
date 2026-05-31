class Quote {
  final String id;
  final String text;
  final String author;
  final String category;
  final int emotionalImpact;
  final bool isPopular;
  final DateTime dateAdded;
  bool isFavorite;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    required this.emotionalImpact,
    this.isPopular = false,
    required this.dateAdded,
    this.isFavorite = false,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json['id'] as String,
        text: json['text'] as String,
        author: json['author'] as String,
        category: json['category'] as String,
        emotionalImpact: json['emotionalImpact'] as int,
        isPopular: (json['isPopular'] as bool?) ?? false,
        dateAdded: DateTime.parse(json['dateAdded'] as String),
        isFavorite: (json['isFavorite'] as bool?) ?? false,
      );
}