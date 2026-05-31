import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_ai_service.dart';
import '../services/gemma_native_ai.dart';
import '../services/fallback_ai_service.dart';

final localAIServiceProvider = FutureProvider<LocalAIService>((ref) async {
  // Try Gemma first
  final gemma = GemmaNativeAI();
  await gemma.initialize();
  if (!gemma.isReady) {
    debugPrint('AIService: Gemma not ready. Installing from asset...');
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        final err = await GemmaNativeAI.installFromAsset();
        if (err != null) {
          debugPrint('AIService: Attempt $attempt failed: $err');
          continue;
        }
        await gemma.initialize();
        if (gemma.isReady) break;
      } catch (e) {
        debugPrint('AIService: Attempt $attempt exception: $e');
      }
    }
  }

  if (gemma.isReady) {
    debugPrint('AIService: Using GemmaNativeAI');
    return gemma;
  }

  // Fallback to rule-based AI so the chatbot always responds
  debugPrint('AIService: Gemma not ready (${gemma.status} ${gemma.error}), using FallbackAIService');
  return FallbackAIService();
});

/// Indicates whether the underlying AI is the full Gemma model (true)
/// or a fallback service (false).
final aiReadyProvider = FutureProvider<bool>((ref) async {
  final service = await ref.watch(localAIServiceProvider.future);
  return service.name == 'Gemma';
});

/// Provides the AI service name (e.g. 'Gemma' or 'Fallback').
final aiServiceNameProvider = FutureProvider<String>((ref) async {
  final service = await ref.watch(localAIServiceProvider.future);
  return service.name;
});
