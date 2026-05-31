import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  EncryptionService._();

  static final instance = EncryptionService._();
  final _secureStorage = const FlutterSecureStorage();
  static const _keyStorageKey = 'encryption_key';

  encrypt.Key? _cachedKey;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      final storedKey = await _secureStorage.read(key: _keyStorageKey);
      if (storedKey != null && storedKey.isNotEmpty) {
        _cachedKey = encrypt.Key.fromBase64(storedKey);
      } else {
        _cachedKey = _generateKey();
        await _secureStorage.write(
          key: _keyStorageKey,
          value: _cachedKey!.base64,
        );
      }
      _initialized = true;
    } catch (_) {
      _initialized = false;
    }
  }

  bool get isReady => _initialized && _cachedKey != null;

  encrypt.Key _generateKey() {
    return encrypt.Key.fromSecureRandom(32);
  }

  String encryptText(String plainText) {
    if (!isReady || plainText.isEmpty) return plainText;
    try {
      final iv = encrypt.IV.fromSecureRandom(16);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(_cachedKey!, mode: encrypt.AESMode.cbc),
      );
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      final combined = base64Encode([
        ...iv.bytes,
        ...encrypted.bytes,
      ]);
      return combined;
    } catch (_) {
      return plainText;
    }
  }

  String decryptText(String cipherText) {
    if (!isReady || cipherText.isEmpty) return cipherText;
    try {
      final combined = base64Decode(cipherText);
      if (combined.length < 16) return cipherText;
      final iv = encrypt.IV(combined.sublist(0, 16));
      final encryptedBytes = combined.sublist(16);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(_cachedKey!, mode: encrypt.AESMode.cbc),
      );
      return encrypter.decrypt(
        encrypt.Encrypted(encryptedBytes),
        iv: iv,
      );
    } catch (_) {
      return cipherText;
    }
  }

  Future<void> resetKey() async {
    await _secureStorage.delete(key: _keyStorageKey);
    _cachedKey = null;
    _initialized = false;
  }
}
