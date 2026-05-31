import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette (White + Light Blue)
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFBFF);
  static const Color lightSkyBlue = Color(0xFF87CEEB);
  static const Color softBlue = Color(0xFFADD8E6);
  
  // Contrast / Backgrounds
  static const Color darkNavy = Color(0xFF0A1428);
  static const Color darkBlue = Color(0xFF0D1B2A);
  
  // Semantic Colors
  static const Color success = Color(0xFF7ACF8E);
  static const Color warning = Color(0xFFFAC775);
  static const Color danger = Color(0xFFF09595);

  // Legacy fallbacks for compatibility
  static const Color primary = lightSkyBlue;
  static const Color secondary = softBlue;
  static const Color darkBg = darkNavy;
  static const Color textPrimaryDark = pureWhite;
}

class AppThemePresets {
  static const Map<String, Map<String, Color>> themes = {
    'azureSerenity': {
      'primary': Color(0xFF87CEEB),
      'secondary': Color(0xFFFFFFFF),
      'accent': Color(0xFF00D4FF),
      'background': Color(0xFF0A1428),
    },
    'oceanDream': {
      'primary': Color(0xFFADD8E6),
      'secondary': Color(0xFFFFFFFF),
      'accent': Color(0xFF00B8D4),
      'background': Color(0xFF0D1B2A),
    },
    'polarFrost': {
      'primary': Color(0xFFFFFFFF),
      'secondary': Color(0xFFE0F4FF),
      'accent': Color(0xFF00CED1),
      'background': Color(0xFF0A1428),
    },
    // Gradient Theme Sample: Fresh Water
    'freshWater': {
      'gradStart': Color(0xFF87CEEB),
      'gradEnd': Color(0xFF00CED1),
      'background': Color(0xFF0A1428),
    },
  };

  static Map<String, Color> getTheme(String name) {
    return themes[name] ?? themes['azureSerenity']!;
  }
}