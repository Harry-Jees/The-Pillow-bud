import 'package:shared_preferences/shared_preferences.dart';

class PersonalizationService {
  static Future<void> setPersonalityMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('personality', mode);
  }

  static Future<String> getPersonalityMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('personality') ?? 'balanced';
  }

  static Future<void> setThemeMode(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

  static Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme') ?? 'classic';
  }

  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? true;
  }
}
