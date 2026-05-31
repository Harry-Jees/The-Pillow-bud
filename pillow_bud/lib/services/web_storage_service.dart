import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message.dart';
import '../models/journal_entry.dart';
import '../models/user_preference.dart';
import 'storage_service.dart';
import 'encryption_service.dart';

class WebStorageService extends StorageService {
  static const _messagesKey = 'web_storage_messages';
  static const _entriesKey = 'web_storage_entries';
  static const _prefKey = 'web_storage_preference';

  SharedPreferences? _prefs;

  @override
  Future<void> initialize() async {
    await EncryptionService.instance.initialize();
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get _p {
    if (_prefs == null) throw StateError('WebStorageService not initialized');
    return _prefs!;
  }

  @override
  Future<List<ChatMessage>> loadMessages() async {
    final raw = _p.getString(_messagesKey);
    if (raw == null || raw.isEmpty) return [];
    final decrypted = EncryptionService.instance.decryptText(raw);
    final list = jsonDecode(decrypted) as List;
    return list.map((e) => ChatMessage.fromJson(e)).toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  @override
  Future<void> saveMessage(ChatMessage message) async {
    final messages = await loadMessages();
    messages.add(message);
    final jsonStr = jsonEncode(messages.map((e) => e.toJson()).toList());
    final encrypted = EncryptionService.instance.encryptText(jsonStr);
    await _p.setString(_messagesKey, encrypted);
  }

  @override
  Future<void> deleteAllMessages() async {
    await _p.remove(_messagesKey);
  }

  @override
  Future<List<JournalEntry>> loadEntries() async {
    final raw = _p.getString(_entriesKey);
    if (raw == null || raw.isEmpty) return [];
    final decrypted = EncryptionService.instance.decryptText(raw);
    final list = jsonDecode(decrypted) as List;
    return list.map((e) => JournalEntry.fromJson(e)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<void> saveEntry(JournalEntry entry) async {
    final entries = await loadEntries();
    entries.add(entry);
    final jsonStr = jsonEncode(entries.map((e) => e.toJson()).toList());
    final encrypted = EncryptionService.instance.encryptText(jsonStr);
    await _p.setString(_entriesKey, encrypted);
  }

  @override
  Future<void> deleteAllEntries() async {
    await _p.remove(_entriesKey);
  }

  @override
  Future<UserPreference?> loadPreference() async {
    final raw = _p.getString(_prefKey);
    if (raw == null || raw.isEmpty) return null;
    final decrypted = EncryptionService.instance.decryptText(raw);
    return UserPreference.fromJson(jsonDecode(decrypted) as Map<String, dynamic>);
  }

  @override
  Future<void> savePreference(UserPreference pref) async {
    final jsonStr = jsonEncode(pref.toJson());
    final encrypted = EncryptionService.instance.encryptText(jsonStr);
    await _p.setString(_prefKey, encrypted);
  }

  @override
  Future<void> clearAll() async {
    await _p.remove(_messagesKey);
    await _p.remove(_entriesKey);
    await _p.remove(_prefKey);
  }
}
