import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme_state.dart';

final themeStateProvider = StateNotifierProvider<ThemeNotifier, AppThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppThemeState> {
  ThemeNotifier() : super(const AppThemeState());

  void initFromSaved(String themeName, bool isDarkMode) {
    final preset = presetFromString(themeName);
    state = AppThemeState(preset: preset, isDarkMode: isDarkMode);
  }

  void setPreset(AppThemePreset preset) {
    state = state.copyWith(preset: preset);
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void setDarkMode(bool value) {
    state = state.copyWith(isDarkMode: value);
  }

  ThemeData buildTheme() {
    final c = state.colors;
    final isDark = state.isDarkMode;
    final bg = state.scaffoldBg;
    final card = state.cardColor;
    final text = state.textPrimary;

    final textTheme = GoogleFonts.caveatTextTheme().apply(
      bodyColor: text,
      displayColor: text,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: bg,
      primaryColor: c.primary,
      colorScheme: isDark
          ? ColorScheme.dark(
              primary: c.primary,
              secondary: c.secondary,
              surface: card,
              error: const Color(0xFFF09595),
            )
          : ColorScheme.light(
              primary: c.primary,
              secondary: c.secondary,
              surface: card,
              error: const Color(0xFFF09595),
            ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: text,
        ),
        iconTheme: IconThemeData(color: text),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bg,
        selectedItemColor: c.primary,
        unselectedItemColor: text.withValues(alpha: 0.4),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.nunito(fontSize: 11),
        unselectedLabelStyle: GoogleFonts.nunito(fontSize: 11),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.primary,
          side: BorderSide(color: c.primary.withValues(alpha: 0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: text.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: text.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: c.primary.withValues(alpha: 0.5), width: 1.5),
        ),
        hintStyle: TextStyle(color: text.withValues(alpha: 0.4), fontFamily: 'Nunito'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
