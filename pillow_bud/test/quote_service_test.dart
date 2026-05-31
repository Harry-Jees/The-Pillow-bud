import 'package:flutter_test/flutter_test.dart';
import 'package:pillow_bud/services/quote_service.dart';
import 'package:pillow_bud/models/quote_model.dart';

void main() {
  group('QuoteService Tests', () {
    test('getDailyQuote returns a valid Quote object', () {
      final quote = QuoteService.getDailyQuote();
      
      expect(quote, isA<Quote>());
      expect(quote.text.isNotEmpty, true);
      expect(quote.author.isNotEmpty, true);
    });

    test('getRandomQuote returns a valid Quote object', () {
      final quote = QuoteService.getRandomQuote();
      
      expect(quote, isA<Quote>());
      expect(quote.text.isNotEmpty, true);
      expect(quote.author.isNotEmpty, true);
    });
  });
}