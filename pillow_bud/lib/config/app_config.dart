class AppConfig {
  static const bool debugMode = true;
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration chatResponseTimeout = Duration(seconds: 60);
  static const double defaultBorderRadius = 14.0;
  static const double softBorderRadius = 16.0;
  static const double pillBorderRadius = 20.0;
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  static const String appName = 'Pillow Bud';
  static const String appVersion = '1.0.0';
}
