import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_message.dart';
import '../models/journal_entry.dart';
import '../services/storage_service.dart';
import 'storage_provider.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final userNameProvider = FutureProvider<String>((ref) async {
  try {
    final storage = await ref.watch(storageServiceProvider.future);
    final pref = await storage.loadPreference();
    final name = pref?.userName.trim() ?? '';
    if (name.isNotEmpty) return name;
  } catch (_) {}
  // Fallback to SharedPreferences for backward compatibility
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  final name = prefs.getString('user_name')?.trim() ?? '';
  return name.isNotEmpty ? name : 'Friend';
});

final personalityProvider = FutureProvider<String>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return prefs.getString('personality') ?? 'balanced';
});

final onboardingDoneProvider = FutureProvider<bool>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return prefs.getBool('onboarding_done') ?? false;
});

final chatStateProvider = StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>(
  (ref) => ChatMessagesNotifier(ref.watch(storageServiceProvider.future)),
);

final journalEntriesProvider = StateNotifierProvider<JournalEntriesNotifier, List<JournalEntry>>(
  (ref) => JournalEntriesNotifier(ref.watch(storageServiceProvider.future)),
);

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  final Future<StorageService> _storageFuture;

  ChatMessagesNotifier(this._storageFuture) : super([]) {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final storage = await _storageFuture;
    state = await storage.loadMessages();
  }

  Future<void> addMessage(ChatMessage message) async {
    final storage = await _storageFuture;
    await storage.saveMessage(message);
    state = [...state, message];
  }

  Future<void> clearHistory() async {
    final storage = await _storageFuture;
    await storage.deleteAllMessages();
    state = [];
  }
}

class JournalEntriesNotifier extends StateNotifier<List<JournalEntry>> {
  final Future<StorageService> _storageFuture;

  JournalEntriesNotifier(this._storageFuture) : super([]) {
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final storage = await _storageFuture;
    state = await storage.loadEntries();
  }

  Future<void> addEntry(JournalEntry entry) async {
    final storage = await _storageFuture;
    await storage.saveEntry(entry);
    state = [entry, ...state];
  }

  Future<void> clearJournal() async {
    final storage = await _storageFuture;
    await storage.deleteAllEntries();
    state = [];
  }
}
