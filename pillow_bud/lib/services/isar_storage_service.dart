import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/chat_message.dart';
import '../models/journal_entry.dart';
import '../models/user_preference.dart';
import 'storage_service.dart';
import 'encryption_service.dart';

class IsarStorageService extends StorageService {
  Isar? _isar;

  @override
  Future<void> initialize() async {
    await EncryptionService.instance.initialize();

    if (Isar.instanceNames.isNotEmpty) {
      final existing = Isar.getInstance();
      if (existing != null) {
        _isar = existing;
        return;
      }
    }

    final directory = await getApplicationSupportDirectory();
    const disableInspector = bool.fromEnvironment(
      'DISABLE_ISAR_INSPECTOR',
      defaultValue: false,
    );

    _isar = await Isar.open(
      [ChatMessageSchema, JournalEntrySchema, UserPreferenceSchema],
      directory: directory.path,
      inspector: !disableInspector,
    );
  }

  Isar get _db {
    if (_isar == null) throw StateError('IsarStorageService not initialized');
    return _isar!;
  }

  @override
  Future<List<ChatMessage>> loadMessages() async {
    final messages = await _db.chatMessages.where().findAll();
    for (final msg in messages) {
      msg.text = EncryptionService.instance.decryptText(msg.text);
    }
    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return messages;
  }

  @override
  Future<void> saveMessage(ChatMessage message) async {
    final encrypted = ChatMessage(
      id: message.id,
      text: EncryptionService.instance.encryptText(message.text),
      isFromBud: message.isFromBud,
      timestamp: message.timestamp,
    );
    await _db.writeTxn(() => _db.chatMessages.put(encrypted));
  }

  @override
  Future<void> deleteAllMessages() async {
    await _db.writeTxn(() => _db.chatMessages.clear());
  }

  @override
  Future<List<JournalEntry>> loadEntries() async {
    final entries = await _db.journalEntrys.where().findAll();
    for (final entry in entries) {
      entry.text = EncryptionService.instance.decryptText(entry.text);
    }
    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

  @override
  Future<void> saveEntry(JournalEntry entry) async {
    final encrypted = JournalEntry(
      id: entry.id,
      text: EncryptionService.instance.encryptText(entry.text),
      mood: entry.mood,
      date: entry.date,
    );
    await _db.writeTxn(() => _db.journalEntrys.put(encrypted));
  }

  @override
  Future<void> deleteAllEntries() async {
    await _db.writeTxn(() => _db.journalEntrys.clear());
  }

  @override
  Future<UserPreference?> loadPreference() async {
    final pref = await _db.userPreferences.where().findFirst();
    if (pref != null) {
      pref.userName = EncryptionService.instance.decryptText(pref.userName);
    }
    return pref;
  }

  @override
  Future<void> savePreference(UserPreference pref) async {
    final encrypted = UserPreference(
      id: pref.id,
      userName: EncryptionService.instance.encryptText(pref.userName),
      buddyPersonality: pref.buddyPersonality,
      isDarkMode: pref.isDarkMode,
      primaryColor: pref.primaryColor,
      secondaryColor: pref.secondaryColor,
      onboardingCompleted: pref.onboardingCompleted,
      onboardingCompletedAt: pref.onboardingCompletedAt,
      lockScreenEnabled: pref.lockScreenEnabled,
      themeName: pref.themeName,
    );
    encrypted.isarId = pref.isarId;
    await _db.writeTxn(() => _db.userPreferences.put(encrypted));
  }

  @override
  Future<void> clearAll() async {
    await _db.writeTxn(() async {
      await _db.chatMessages.clear();
      await _db.journalEntrys.clear();
      await _db.userPreferences.clear();
    });
  }
}
