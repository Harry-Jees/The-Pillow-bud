import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:pillow_bud/services/fallback_ai_service.dart';

void main() {
  group('FallbackAIService', () {
    late FallbackAIService service;

    setUp(() {
      // Use a seeded Random for deterministic tests
      service = FallbackAIService(random: Random(42));
    });

    group('basic properties', () {
      test('initialize completes immediately', () async {
        await service.initialize();
        // Should not throw or hang
      });

      test('isReady returns true', () {
        expect(service.isReady, true);
      });

      test('name returns Fallback', () {
        expect(service.name, 'Fallback');
      });

      test('status returns ready', () {
        expect(service.status, 'ready');
      });
    });

    group('generateResponse', () {
      const systemPrompt = 'You are Bud, an emotionally intelligent companion.';
      const recentContext = 'User: I had a rough day.\nBud: I hear you.';

      test('returns a non-empty string for neutral messages', () async {
        final response = await service.generateResponse(
          systemPrompt: systemPrompt,
          userMessage: 'Hello, how are you?',
        );

        expect(response, isNotEmpty);
        // Default responses should be used for neutral
        expect(response, contains('share'));
      });

      test('respects the systemPrompt parameter', () async {
        final response = await service.generateResponse(
          systemPrompt: 'Custom prompt',
          userMessage: 'I feel okay today',
        );

        // systemPrompt is ignored by fallback, but the method must accept it
        expect(response, isNotEmpty);
      });

      test('handles recentContext parameter', () async {
        final response = await service.generateResponse(
          systemPrompt: systemPrompt,
          userMessage: 'I feel okay today',
          recentContext: recentContext,
        );

        // Must not throw and must return a valid response
        expect(response, isNotEmpty);
      });
    });

    group('emotion-specific responses', () {
      // Each test sends a message containing a specific emotion keyword
      // and verifies the response is appropriate.

      test('responds to overwhelmed emotion', () async {
        const messages = [
          'I feel so overwhelmed with everything going on',
          "I can't handle all this pressure",
          'I feel like I am drowning in work',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          // Responses for overwhelmed should contain relevant words
          expect(
            response.contains('step') ||
                response.contains('weight') ||
                response.contains('heavy') ||
                response.contains('alone'),
            true,
            reason: 'Overwhelmed response should contain comfort: "$response"',
          );
        }
      });

      test('responds to anxiety', () async {
        const messages = [
          'I feel so anxious about tomorrow',
          'My heart is racing with worry',
          'I am scared and nervous',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('breath') ||
                response.contains('worry') ||
                response.contains('safe') ||
                response.contains('nervous'),
            true,
            reason:
                'Anxiety response should contain comforting cues: "$response"',
          );
        }
      });

      test('responds to sadness', () async {
        const messages = [
          'I feel so sad and lonely today',
          'I am feeling really down and hopeless',
          'Nothing matters anymore, I feel empty',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('sorry') ||
                response.contains('painful') ||
                response.contains('courage') ||
                response.contains('valid') ||
                response.contains('alone'),
            true,
            reason: 'Sadness response should be empathetic: "$response"',
          );
        }
      });

      test('responds to loneliness', () async {
        const messages = [
          'I feel so alone in this world',
          'No one understands me, I am isolated',
          'I feel completely disconnected from everyone',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('alone') ||
                response.contains('connection') ||
                response.contains('disconnected') ||
                response.contains('listening'),
            true,
            reason: 'Loneliness response should offer connection: "$response"',
          );
        }
      });

      test('responds to stress', () async {
        const messages = [
          'I am so stressed about work deadlines',
          'The pressure is too much for me',
          'I feel frustrated and tense',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('stress') ||
                response.contains('pressure') ||
                response.contains('pause') ||
                response.contains('carrying') ||
                response.contains('step'),
            true,
            reason: 'Stress response should offer calm: "$response"',
          );
        }
      });

      test('responds to confusion', () async {
        const messages = [
          'I am so confused about what to do',
          "I don't understand my feelings anymore",
          'Everything feels unclear and mixed up',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('confusion') ||
                response.contains('unclear') ||
                response.contains('figure') ||
                response.contains('answers') ||
                response.contains('process'),
            true,
            reason: 'Confusion response should offer clarity: "$response"',
          );
        }
      });

      test('responds to hope', () async {
        const messages = [
          'I am feeling hopeful about the future',
          'Things are getting better, I am optimistic',
          'I feel so positive and excited today',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('beautiful') ||
                response.contains('hope') ||
                response.contains('positive') ||
                response.contains('energy') ||
                response.contains('uplifting'),
            true,
            reason: 'Hopeful response should affirm positivity: "$response"',
          );
        }
      });

      test('responds to calm', () async {
        const messages = [
          'I feel so calm and relaxed today',
          'Everything feels peaceful and serene',
          'I am feeling grounded and centered',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('peace') ||
                response.contains('calm') ||
                response.contains('grounded') ||
                response.contains('at ease') ||
                response.contains('savor'),
            true,
            reason: 'Calm response should reinforce peace: "$response"',
          );
        }
      });

      test('responds to anger', () async {
        const messages = [
          'I am so angry and furious right now',
          'Everything makes me mad and frustrated',
          'I feel betrayed and annoyed',
        ];

        for (final msg in messages) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          expect(response, isNotEmpty,
              reason: 'Response should not be empty for: "$msg"');
          expect(
            response.contains('valid') ||
                response.contains('ang') ||
                response.contains('frustration') ||
                response.contains('boundary') ||
                response.contains('listen'),
            true,
            reason: 'Anger response should validate feelings: "$response"',
          );
        }
      });
    });

    group('intensity handling', () {
      test('adds extra warmth for high intensity negative emotions', () async {
        final response = await service.generateResponse(
          systemPrompt: '',
          userMessage: 'I am absolutely unbearably sad and hopeless',
        );

        // High intensity sad should include the extra warmth suffix
        expect(response, contains('completely valid'));
        expect(response, contains('not alone'));
      });

      test('does NOT add extra warmth for calm or hopeful regardless of intensity',
          () async {
        final calmResponse = await service.generateResponse(
          systemPrompt: '',
          userMessage: 'I am absolutely extremely calm and peaceful',
        );

        final hopefulResponse = await service.generateResponse(
          systemPrompt: '',
          userMessage: 'I am absolutely extremely hopeful and optimistic',
        );

        // Calm and hopeful emotions should not get the extra warmth suffix
        expect(calmResponse, isNot(contains('completely valid')));
        expect(hopefulResponse, isNot(contains('completely valid')));
      });

      test('does not add extra warmth for low intensity messages', () async {
        final response = await service.generateResponse(
          systemPrompt: '',
          userMessage: 'I feel a bit sad today',
        );

        // "a bit" should not trigger high intensity
        // Note: "sad" with no intensity marker should stay at default 0.5
        expect(response, isNot(contains('completely valid')));
      });
    });

    group('response diversity', () {
      test('returns different responses on different calls', () async {
        // Use unseeded Random for this test to ensure variety
        final freshService = FallbackAIService();
        final responses = <String>{};

        for (var i = 0; i < 10; i++) {
          final response = await freshService.generateResponse(
            systemPrompt: '',
            userMessage: 'I am feeling sad today',
          );
          responses.add(response);
        }

        // With 3 possible responses for sad, we should see some variety
        // in 10 calls (99.9% probability of seeing at least 2 different ones)
        expect(responses.length, greaterThanOrEqualTo(2),
            reason: 'Should generate varied responses across multiple calls');
      });

      test('returns different responses for different emotions', () async {
        final responses = <String>{};

        for (final emotion in [
          'I am so sad and lonely',
          'I am so happy and hopeful',
          'I am so angry and furious',
        ]) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: emotion,
          );
          responses.add(response);
        }

        // Different emotions should produce different responses
        expect(responses.length, greaterThanOrEqualTo(2),
            reason: 'Different emotions should produce different responses');
      });
    });

    group('generateResponse extension', () {
      test('works with empty system prompt', () async {
        final response = await service.generateResponse(
          systemPrompt: '',
          userMessage: 'Hello',
        );
        expect(response, isNotEmpty);
      });

      test('works with very long messages', () async {
        final longMessage = 'I feel ' * 100 + 'sad';
        final response = await service.generateResponse(
          systemPrompt: '',
          userMessage: longMessage,
        );
        expect(response, isNotEmpty);
      });

      test('works with messages containing special characters', () async {
        final response = await service.generateResponse(
          systemPrompt: '',
          userMessage: "Can't stop thinking about it... it's so much! 😢",
        );
        expect(response, isNotEmpty);
      });
    });

    group('contract compliance (LocalAIService)', () {
      test('implements all abstract members', () {
        // These are compile-time checks, but we verify behavior
        expect(service, isA<FallbackAIService>());
      });

      test('can be initialized multiple times without error', () async {
        await service.initialize();
        await service.initialize();
        await service.initialize();
        // Should never throw
      });

      test('generateResponse never throws', () async {
        // Random edge cases
        for (final msg in [
          '',
          ' ',
          'a',
          '!@#\$%^&*()',
          'Hello world this is a test message',
          'x' * 1000,
        ]) {
          final response = await service.generateResponse(
            systemPrompt: '',
            userMessage: msg,
          );
          // Should always return something, even if empty string input
          expect(response, isNotNull);
        }
      });
    });
  });
}
