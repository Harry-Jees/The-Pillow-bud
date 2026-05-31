import 'package:flutter/material.dart';

enum ThemeCategory { solid, gradient }

enum AppThemePreset {
  azureSerenity,
  oceanDream,
  polarFrost,
  twilightSky,
  cosmicBlue,
  softWhisper,
  daylightBlue,
  depthDiscovery,
  morningCalm,
  silverLining,
  aquamarineDream,
  cornflowerBliss,
  steelSanctuary,
  periwinklePeace,
  slateHarmony,
  // Gradients
  azureToTeal,
  oceanDepths,
  skyToHorizon,
  aquaGlow,
  twilightAurora,
  mintBreeze,
  seafoamDrift,
  stellarBlue,
  lavenderSky,
  silverStream,
}

class ThemeColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color accent;
  final Color background;

  const ThemeColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.accent,
    required this.background,
  });
}

class GradientColors {
  final Color from;
  final Color to;
  final double angle;

  const GradientColors({
    required this.from,
    required this.to,
    this.angle = 135,
  });
}

const themePresetColors = {
  AppThemePreset.azureSerenity: ThemeColors(
    primary: Color(0xFF87CEEB),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF4A90E2),
    accent: Color(0xFF00D4FF),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.oceanDream: ThemeColors(
    primary: Color(0xFFADD8E6),
    secondary: Color(0xFFFAFBFF),
    tertiary: Color(0xFF0066CC),
    accent: Color(0xFF00B8D4),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.polarFrost: ThemeColors(
    primary: Color(0xFFFFFFFF),
    secondary: Color(0xFFE0F4FF),
    tertiary: Color(0xFF4169E1),
    accent: Color(0xFF00CED1),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.twilightSky: ThemeColors(
    primary: Color(0xFF87CEEB),
    secondary: Color(0xFFF0F8FF),
    tertiary: Color(0xFF663399),
    accent: Color(0xFFFF6B9D),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.cosmicBlue: ThemeColors(
    primary: Color(0xFF4169E1),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF1E3A8A),
    accent: Color(0xFF00FFFF),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.softWhisper: ThemeColors(
    primary: Color(0xFFB0E0E6),
    secondary: Color(0xFFFAFBFF),
    tertiary: Color(0xFF6A8CAF),
    accent: Color(0xFF87CEEB),
    background: Color(0xFF1A1F3A),
  ),
  AppThemePreset.daylightBlue: ThemeColors(
    primary: Color(0xFF87CEEB),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF1E90FF),
    accent: Color(0xFFFFD700),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.depthDiscovery: ThemeColors(
    primary: Color(0xFF007FFF),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF00008B),
    accent: Color(0xFF00FF7F),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.morningCalm: ThemeColors(
    primary: Color(0xFFADD8E6),
    secondary: Color(0xFFFFFACD),
    tertiary: Color(0xFF4682B4),
    accent: Color(0xFFFFB6C1),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.silverLining: ThemeColors(
    primary: Color(0xFFC0C0C0),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF4682B4),
    accent: Color(0xFF87CEEB),
    background: Color(0xFF1A1F3A),
  ),
  AppThemePreset.aquamarineDream: ThemeColors(
    primary: Color(0xFF7FFFD4),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF008B8B),
    accent: Color(0xFF00CED1),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.cornflowerBliss: ThemeColors(
    primary: Color(0xFF6495ED),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF1E3A8A),
    accent: Color(0xFFFFB6D9),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.steelSanctuary: ThemeColors(
    primary: Color(0xFF4682B4),
    secondary: Color(0xFFF0F8FF),
    tertiary: Color(0xFF2F4F7F),
    accent: Color(0xFF00FA9A),
    background: Color(0xFF1A1F3A),
  ),
  AppThemePreset.periwinklePeace: ThemeColors(
    primary: Color(0xFFCCCCFF),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF6B5B95),
    accent: Color(0xFF87CEEB),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.slateHarmony: ThemeColors(
    primary: Color(0xFF708090),
    secondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF2F4F4F),
    accent: Color(0xFF20B2AA),
    background: Color(0xFF0A1428),
  ),
  // Gradient presets also need ThemeColors for primary/secondary/etc
  AppThemePreset.azureToTeal: ThemeColors(
    primary: Color(0xFF87CEEB),
    secondary: Color(0xFFFAFBFF),
    tertiary: Color(0xFF00CED1),
    accent: Color(0xFF40E0D0),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.oceanDepths: ThemeColors(
    primary: Color(0xFF4169E1),
    secondary: Color(0xFFF0F8FF),
    tertiary: Color(0xFF00008B),
    accent: Color(0xFF1E90FF),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.skyToHorizon: ThemeColors(
    primary: Color(0xFF87CEEB),
    secondary: Color(0xFFFFFACD),
    tertiary: Color(0xFFFFD700),
    accent: Color(0xFFFFA500),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.aquaGlow: ThemeColors(
    primary: Color(0xFF007FFF),
    secondary: Color(0xFFF0FFFF),
    tertiary: Color(0xFF00FFFF),
    accent: Color(0xFF00BFFF),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.twilightAurora: ThemeColors(
    primary: Color(0xFF87CEEB),
    secondary: Color(0xFFF8F0FF),
    tertiary: Color(0xFF663399),
    accent: Color(0xFF9B59B6),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.mintBreeze: ThemeColors(
    primary: Color(0xFF98FF98),
    secondary: Color(0xFFF0FFF0),
    tertiary: Color(0xFF87CEEB),
    accent: Color(0xFF66CDAA),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.seafoamDrift: ThemeColors(
    primary: Color(0xFF93E9BE),
    secondary: Color(0xFFF0FFFA),
    tertiary: Color(0xFF6DD5ED),
    accent: Color(0xFF48D1CC),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.stellarBlue: ThemeColors(
    primary: Color(0xFF1E90FF),
    secondary: Color(0xFFF0F8FF),
    tertiary: Color(0xFF00BFFF),
    accent: Color(0xFF00CED1),
    background: Color(0xFF0A1428),
  ),
  AppThemePreset.lavenderSky: ThemeColors(
    primary: Color(0xFFE6E6FA),
    secondary: Color(0xFFFAFAFF),
    tertiary: Color(0xFF87CEEB),
    accent: Color(0xFFDDA0DD),
    background: Color(0xFF0D1B2A),
  ),
  AppThemePreset.silverStream: ThemeColors(
    primary: Color(0xFFD3D3D3),
    secondary: Color(0xFFFAFAFA),
    tertiary: Color(0xFF87CEEB),
    accent: Color(0xFFA9A9A9),
    background: Color(0xFF0A1428),
  ),
};

const themeGradientColors = {
  AppThemePreset.azureToTeal: GradientColors(
    from: Color(0xFF87CEEB),
    to: Color(0xFF00CED1),
    angle: 135,
  ),
  AppThemePreset.oceanDepths: GradientColors(
    from: Color(0xFF4169E1),
    to: Color(0xFF00008B),
    angle: 90,
  ),
  AppThemePreset.skyToHorizon: GradientColors(
    from: Color(0xFF87CEEB),
    to: Color(0xFFFFD700),
    angle: 180,
  ),
  AppThemePreset.aquaGlow: GradientColors(
    from: Color(0xFF007FFF),
    to: Color(0xFF00FFFF),
    angle: 45,
  ),
  AppThemePreset.twilightAurora: GradientColors(
    from: Color(0xFF663399),
    to: Color(0xFF87CEEB),
    angle: 135,
  ),
  AppThemePreset.mintBreeze: GradientColors(
    from: Color(0xFF98FF98),
    to: Color(0xFF87CEEB),
    angle: 90,
  ),
  AppThemePreset.seafoamDrift: GradientColors(
    from: Color(0xFF93E9BE),
    to: Color(0xFF6DD5ED),
    angle: 180,
  ),
  AppThemePreset.stellarBlue: GradientColors(
    from: Color(0xFF1E90FF),
    to: Color(0xFF00BFFF),
    angle: 45,
  ),
  AppThemePreset.lavenderSky: GradientColors(
    from: Color(0xFFE6E6FA),
    to: Color(0xFF87CEEB),
    angle: 135,
  ),
  AppThemePreset.silverStream: GradientColors(
    from: Color(0xFFD3D3D3),
    to: Color(0xFF87CEEB),
    angle: 90,
  ),
};

bool isGradientPreset(AppThemePreset p) {
  return p.index >= 15;
}

String presetName(AppThemePreset p) {
  switch (p) {
    case AppThemePreset.azureSerenity: return 'Azure Serenity';
    case AppThemePreset.oceanDream: return 'Ocean Dream';
    case AppThemePreset.polarFrost: return 'Polar Frost';
    case AppThemePreset.twilightSky: return 'Twilight Sky';
    case AppThemePreset.cosmicBlue: return 'Cosmic Blue';
    case AppThemePreset.softWhisper: return 'Soft Whisper';
    case AppThemePreset.daylightBlue: return 'Daylight Blue';
    case AppThemePreset.depthDiscovery: return 'Depth Discovery';
    case AppThemePreset.morningCalm: return 'Morning Calm';
    case AppThemePreset.silverLining: return 'Silver Lining';
    case AppThemePreset.aquamarineDream: return 'Aquamarine Dream';
    case AppThemePreset.cornflowerBliss: return 'Cornflower Bliss';
    case AppThemePreset.steelSanctuary: return 'Steel Sanctuary';
    case AppThemePreset.periwinklePeace: return 'Periwinkle Peace';
    case AppThemePreset.slateHarmony: return 'Slate Harmony';
    case AppThemePreset.azureToTeal: return 'Azure to Teal';
    case AppThemePreset.oceanDepths: return 'Ocean Depths';
    case AppThemePreset.skyToHorizon: return 'Sky to Horizon';
    case AppThemePreset.aquaGlow: return 'Aqua Glow';
    case AppThemePreset.twilightAurora: return 'Twilight Aurora';
    case AppThemePreset.mintBreeze: return 'Mint Breeze';
    case AppThemePreset.seafoamDrift: return 'Seafoam Drift';
    case AppThemePreset.stellarBlue: return 'Stellar Blue';
    case AppThemePreset.lavenderSky: return 'Lavender Sky';
    case AppThemePreset.silverStream: return 'Silver Stream';
  }
}

AppThemePreset presetFromString(String name) {
  for (final p in AppThemePreset.values) {
    if (p.name == name) return p;
  }
  return AppThemePreset.azureSerenity;
}

class AppThemeState {
  final AppThemePreset preset;
  final bool isDarkMode;

  const AppThemeState({
    this.preset = AppThemePreset.azureSerenity,
    this.isDarkMode = true,
  });

  ThemeColors get colors => themePresetColors[preset]!;

  GradientColors get gradient => themeGradientColors[preset]!;

  Color get scaffoldBg => isDarkMode ? const Color(0xFF0A1428) : const Color(0xFFFFFFFF);
  Color get cardColor => isDarkMode ? const Color(0xFF1A1F3A) : const Color(0xFFF5F5FF);
  Color get textPrimary => isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF212121);

  AppThemeState copyWith({AppThemePreset? preset, bool? isDarkMode}) {
    return AppThemeState(
      preset: preset ?? this.preset,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
