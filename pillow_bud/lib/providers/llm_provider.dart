import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/llm_service.dart';
import 'ai_service_provider.dart';
import 'app_providers.dart';

final llmServiceProvider = Provider<LLMService>((ref) {
  return LLMService.instance;
});

final llmInitProvider = FutureProvider<void>((ref) async {
  final aiService = await ref.watch(localAIServiceProvider.future);
  LLMService.instance.attachAI(aiService);
});

final currentEmotionProvider = StateProvider<String>((ref) => 'neutral');

final emotionIntensityProvider = StateProvider<double>((ref) => 0.5);

final isLoadingResponseProvider = StateProvider<bool>((ref) => false);

final buddyPersonalityProvider = FutureProvider<String>((ref) {
  return ref.watch(personalityProvider.future);
});
