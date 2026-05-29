import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';
import 'theme/app_colors.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PillowBudApp());
}

class PillowBudApp extends StatelessWidget {
  const PillowBudApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = AppTheme.darkTheme();
    // Override all TextStyles that use 'Lora' or 'DM Sans' font family strings
    // by wrapping with google_fonts theme
    final theme = base.copyWith(
      textTheme: GoogleFonts.dmSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimaryDark,
        displayColor: AppColors.textPrimaryDark,
      ),
    );
    return MaterialApp(
      title: 'Pillow Bud',
      theme: theme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
