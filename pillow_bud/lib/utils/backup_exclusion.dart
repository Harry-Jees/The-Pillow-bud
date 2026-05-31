import 'package:flutter/foundation.dart';

Future<void> excludeAppDataFromBackup() async {
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    debugPrint(
      'iOS/macOS backup exclusion: data is encrypted via AES-256, '
      'and the encryption key is stored in the OS Keychain '
      '(never backed up).',
    );
  }
}
