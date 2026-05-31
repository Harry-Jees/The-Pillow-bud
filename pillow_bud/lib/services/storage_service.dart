import '../models/chat_message.dart';
import '../models/journal_entry.dart';
import '../models/user_preference.dart';

abstract class StorageService {
  Future<void> initialize();

  Future<List<ChatMessage>> loadMessages();
  Future<void> saveMessage(ChatMessage message);
  Future<void> deleteAllMessages();

  Future<List<JournalEntry>> loadEntries();
  Future<void> saveEntry(JournalEntry entry);
  Future<void> deleteAllEntries();

  Future<UserPreference?> loadPreference();
  Future<void> savePreference(UserPreference pref);

  Future<void> clearAll();
}
